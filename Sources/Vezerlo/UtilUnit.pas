//Általános eljárások, függvények
Unit UtilUnit;

Interface

Uses
  Windows, SysUtils, Classes, Controls, Graphics, Forms, DbTables,
  ExtCtrls, StdCtrls, Inifiles, Math, EpuletLancUnit, ObjektumUnit,
  BerendezesekLancUnit, ZoomUnit, RajzolasUnit, PenUnit;

Const SAROKMERET = 5;
      sCelsius : ShortString=' '+Chr(176)+'C'; // = '°C'

Type
  //egér pozíciója
  TEgerPos = Record
    X : Integer;
    Y : Integer;
  End;

  Function BenneVan(Const BF,JA,Mi: TPoint) : Boolean;
  Function PontForgat(Const Pont: TPoint; Const Szog: Integer) : TPoint;
  Function KeresComboBox(Const Form: TForm; Const CB: TComboBox; Const S: String) : Boolean;
  Function ObjektumLancBetolt(Const EpLista: TEpuletLista; Tabla: TTable) : TObjektumLista;
  Function BerendezesLancBetolt(Tabla: TTable) : TBerendezesLista;
  Procedure AblakRajzol(Const Form: TForm; Const Image: TImage;
    Const AblakAlakzat: TAblakAlakzat; Const Szin: TColor; Const Zoom: Extended);
  Procedure AjtoIvSzamol(Const Kezdo,Vegzo: TPoint; Const JB: Byte; Var Iv1,Iv2: TPoint);
  Procedure AjtoRajzol(Const Form: TForm; Const Image: TImage;
    Const AjtoAlakzat: TAjtoAlakzat; Const Zoom: Extended);
  Procedure RajzasztalKeszit(Const Form: TForm; Const Image: TImage; Const Meret: Integer);
  Procedure AlakzatLancAtRajzol(Const Form: TForm; Const Image: TImage;
    Const Zoom: Extended); Overload;
  Procedure AlakzatLancAtRajzol(Const Form: TForm; Const Image: TImage;
    Const Szin: TColor; Const Zoom: Extended); Overload;
  Procedure AlakzatLancAtRajzol(Const Form: TForm; Const Image: TImage;
    Const Szin: TColor; Const Mit: Pointer; Const Zoom: Extended); Overload;
  Procedure AlakzatLetrehoz(Const Form: TForm; Const Image: TImage;
    Const EpLista: TEpuletLista; Const Szog: Integer; Const Tip: TDrawingTool;
    Const PM: Integer; Const PS: TPenStyle; Const PC: Integer; Const K1,K2,K3,K4: TPoint;
    Const A,B: Double; Const Zoom: Extended);
  Procedure Asztalfrissit(Const Form: TForm; Const Image: TImage; Const Zoom: Extended);

Implementation

//egy pont benne van-e a két pont által határolt területben
//ha benne van -> True, különben -> False
Function BenneVan(Const BF,JA,Mi: TPoint) : Boolean;
Begin
  Result:=(Mi.X >= BF.X) And (Mi.X <= JA.X) And (Mi.Y >= BF.Y) And (Mi.Y <= JA.Y);
End;

//ComboBox-ban keres egy karaktersorozatot
//ha megvan -> True, különben -> False
Function KeresComboBox(Const Form: TForm; Const CB: TComboBox; Const S: String) : Boolean;
Var i : Integer;
Begin
  i:=0;
  Result:=False;
  With Form Do
  Begin
    While (i < CB.Items.Count) And (CB.Items[i] <> S) Do Inc(i);
    If (CB.Items[i] = S) Then Result:=True;
  End;
End;

//rajzasztal elkészítése
Procedure RajzasztalKeszit(Const Form: TForm; Const Image: TImage; Const Meret: Integer);
Var Bitmap : TBitmap;
Begin
  //rajzlap létrehozása és alapbeállítása
  Bitmap:=Nil;
  Try
    Bitmap:=TBitmap.Create;
    Bitmap.PixelFormat:=pf16bit;
    Bitmap.Width:=Meret;
    Bitmap.Height:=Meret;
  Finally
    With Form Do
      With Image Do
      Begin
        Picture.Graphic:=Bitmap;
        Width:=Meret;
        Height:=Meret;
        Canvas.Brush.Style:=bsClear;
        Canvas.Pen.Color:=clBlack;
        Enabled:=True;
        Visible:=True;
      End;
    EpuletTul.DT:=dtNyil;
    Bitmap.Free;
  End;
End;

//egy pont elforgatása egy adott szöggel
//visszaadja az új pontot
Function PontForgat(Const Pont: TPoint; Const Szog: Integer) : TPoint;
Begin
  PontForgat.X:=Round(Pont.X*cos(SzogToRad(Szog))-Pont.Y*sin(SzogToRad(Szog)));
  PontForgat.Y:=Round(Pont.X*sin(SzogToRad(Szog))+Pont.Y*cos(SzogToRad(Szog)));
End;

//az ajtó ívének kiszámolja két pontját és vissza is adja
Procedure AjtoIvSzamol(Const Kezdo,Vegzo: TPoint; Const JB: Byte; Var Iv1,Iv2: TPoint);
Var V : TPoint;
Begin
  V.X:=(Vegzo.X-Kezdo.X);
  V.Y:=(Vegzo.Y-Kezdo.Y);
  //ajtó típusa ( jobbos-balos )
  Case JB Of
    0 : Begin
          V.Y:=(-1)*V.Y;
          Iv1:=PontForgat(V,(-1)*30);
          Iv2:=PontForgat(V,(-1)*60);
        End;
    1 : Begin
          V.X:=(-1)*V.X;
          Iv1:=PontForgat(V,30);
          Iv2:=PontForgat(V,60);
        End;
  End;
End;

//ajtó kirajzolása
Procedure AjtoRajzol(Const Form: TForm; Const Image: TImage;
  Const AjtoAlakzat: TAjtoAlakzat; Const Zoom: Extended);
Var FelezoPont : TPoint;
    RegiPen    : TRegiPenStyle;

  //az ajtó ívének számolása és rajzolása
  Procedure Szamit(K1,K2,K3: TPoint; JB : Byte);
  Var Iv1,Iv2  : TPoint;
      PontTomb : Array[1..4] Of TPoint;
  Begin
    //ajtó típusa ( jobbos-balos )
    Case JB Of
      0 : AjtoIvSzamol(K2,K1,JB,Iv1,Iv2);
      1 : AjtoIvSzamol(K1,K2,JB,Iv1,Iv2);
    End;
    PontTomb[1]:=K1;
    PontTomb[2]:=Point(K2.X+Iv1.X,K2.Y-Iv1.Y);
    PontTomb[3]:=Point(K2.X+Iv2.X,K2.Y-Iv2.Y);
    PontTomb[4]:=K3;
    //ív rajzolása
    Image.Canvas.PolyBezier(PontTomb);
  End;

Begin
  //toll beállítása
  RegiPen.Ment(Form,Image);
  SetPenStyle(Form,Image,psSolid,clNone,1);
  With AjtoAlakzat Do
  Begin
    DrawShape(Form,Image,dtVonal,KoordZoom(Koord[1],Zoom),KoordZoom(Koord[2],Zoom),BE);
    RegiPen.Vissza(Form,Image);
    //ha duplaszárnyú az ajtó
    If (Koord[4].X > Low(SmallInt)+1) And (Koord[4].Y > Low(SmallInt)+1) Then
    Begin
      DrawShape(Form,Image,dtVonal,KoordZoom(Koord[2],Zoom),KoordZoom(Koord[3],Zoom),BE);
      DrawShape(Form,Image,dtVonal,KoordZoom(Koord[1],Zoom),KoordZoom(Koord[4],Zoom),BE);
      FelezoPont.X:=Round(Zoom*(Koord[1].X+Koord[2].X)/2);
      FelezoPont.Y:=Round(Zoom*(Koord[1].Y+Koord[2].Y)/2);
      Szamit(FelezoPont,KoordZoom(Koord[2],Zoom),KoordZoom(Koord[3],Zoom),0);
      Szamit(FelezoPont,KoordZoom(Koord[1],Zoom),KoordZoom(Koord[4],Zoom),1);
    End
    //különben
    Else Begin
      If (Koord[4].X = Low(SmallInt)+1) Then
      Begin
        DrawShape(Form,Image,dtVonal,KoordZoom(Koord[2],Zoom),KoordZoom(Koord[3],Zoom),BE);
        Szamit(KoordZoom(Koord[1],Zoom),KoordZoom(Koord[2],Zoom),KoordZoom(Koord[3],Zoom),0);
      End;
      If (Koord[4].Y = Low(SmallInt)+1) Then
      Begin
        DrawShape(Form,Image,dtVonal,KoordZoom(Koord[1],Zoom),KoordZoom(Koord[3],Zoom),BE);
        Szamit(KoordZoom(Koord[2],Zoom),KoordZoom(Koord[1],Zoom),KoordZoom(Koord[3],Zoom),1);
      End;
    End;
  End;
End;     

//ablak rajzolása
Procedure AblakRajzol(Const Form: TForm; Const Image: TImage;
  Const AblakAlakzat: TAblakAlakzat; Const Szin: TColor; Const Zoom: Extended);
Var RegiPen    : TRegiPenStyle;
    RBS        : TBrushStyle;
    RBC        : TColor;
    KitoltSzin : TColor;
    VonalSzin  : TColor;
    PX,PY      : Integer;
    Szinezhet  : Boolean;
    Tav        : Extended;
Begin
  //toll beállítása
  RegiPen.Ment(Form,Image);
  //kifestés beállítása
  RBS:=Image.Canvas.Brush.Style;
  RBC:=Image.Canvas.Brush.Color;
  //milyen a kitöltési szín
  Case Szin Of
    clAqua    : Begin
                  KitoltSzin:=Szin;
                  VonalSzin:=AblakAlakzat.PenColor;
                End;
    clFuchsia,
    clSilver  : Begin
                  KitoltSzin:=clNone;
                  VonalSzin:=Szin;
                End;
    Else Begin
           KitoltSzin:=clNone;
           VonalSzin:=clNone;
         End;
  End;
  With AblakAlakzat Do
  Begin
    Szinezhet:=True;
    SetPenStyle(Form,Image,psSolid,clPurple,1);
    //ablak rajzolása
    NegyzetRajzol(Form,Image,KoordZoom(Koord[1],Zoom),KoordZoom(Koord[2],Zoom),
                  KoordZoom(Koord[3],Zoom),KoordZoom(Koord[4],Zoom));
    {If (Not BenneVan(KoordZoom(Koord[4],Zoom),KoordZoom(Koord[2],Zoom),Point(PX,PY))) Then Szinezhet:=False;
    If (Abs(Zoom*(Koord[1].Y+Koord[3].Y))- (2*PY) < 4) Then Szinezhet:=False;
    If (Abs((Zoom*Koord[1].X)-(Zoom*Koord[3].X)) < 4) Then Szinezhet:=False; }
    Tav:=Sqrt(Sqr(Zoom*(Koord[1].X-Koord[4].X))+Sqr(Zoom*(Koord[1].Y-Koord[4].Y)));
    If (Tav < 3) Then Szinezhet:=False;
    //ha lehet festeni
    If Szinezhet Then
    Begin
      PX:=Round((Zoom*(Koord[1].X+Koord[3].X))/2);
      PY:=Round((Zoom*(Koord[1].Y+Koord[3].Y))/2);
      Image.Canvas.Pixels[PX,PY]:=clMaroon;
      Image.Canvas.Brush.Style:=bsSolid;
      Image.Canvas.Brush.Color:=KitoltSzin;
      Image.Canvas.FloodFill(PX,PY,clPurple,fsBorder);
    End;
    //ablakkeret újrarajzolása
    SetPenStyle(Form,Image,psSolid,VonalSzin,1);
    NegyzetRajzol(Form,Image,KoordZoom(Koord[1],Zoom),KoordZoom(Koord[2],Zoom),
                  KoordZoom(Koord[3],Zoom),KoordZoom(Koord[4],Zoom));
    Image.Canvas.Brush.Style:=RBS;
    Image.Canvas.Brush.Color:=RBC;
    SetPenStyle(Form,Image,psSolid,EpuletTul.PC,1);
    DrawShape(Form,Image,dtVonal,
      Point(Round((Zoom*Koord[1].X+Zoom*Koord[4].X)/2),Round((Zoom*Koord[1].Y+Zoom*Koord[4].Y)/2)),
      Point(Round((Zoom*Koord[2].X+Zoom*Koord[3].X)/2),Round((Zoom*Koord[2].Y+Zoom*Koord[3].Y)/2)),
      BE);
  End;
  RegiPen.Vissza(Form,Image);
End;

//egy alakzat rajzolása
Procedure LancRajzol(Form: TForm; Image: TImage; DT: TDrawingTool;
  Szin: TColor; AlakMut: Pointer; Zoom: Extended);
Begin
  //rajzolási mûvelet típusa
  Case DT Of
    dtVonal     : Begin
                    SetPenStyle(Form,Image,
                                PVonalAlakzat(AlakMut)^.PenStyle,
                                Szin,
                                PVonalAlakzat(AlakMut)^.PenMeret);
                    DrawShape(Form,Image,EpuletTul.DT,
                              KoordZoom(PVonalAlakzat(AlakMut)^.Koord[1],Zoom),
                              KoordZoom(PVonalAlakzat(AlakMut)^.Koord[2],Zoom),BE);
                  End;
    dtNegyzet   : Begin
                    SetPenStyle(Form,Image,
                                PNegyzetAlakzat(AlakMut)^.PenStyle,
                                Szin,
                                PNegyzetAlakzat(AlakMut)^.PenMeret);
                    NegyzetRajzol(Form,Image,
                                  KoordZoom(PNegyzetAlakzat(AlakMut)^.Koord[1],Zoom),
                                  KoordZoom(PNegyzetAlakzat(AlakMut)^.Koord[3],Zoom),
                                  KoordZoom(PNegyzetAlakzat(AlakMut)^.Koord[2],Zoom),
                                  KoordZoom(PNegyzetAlakzat(AlakMut)^.Koord[4],Zoom));
                  End;
    dtEllipszis : Begin
                    SetPenStyle(Form,Image,
                                PEllipszisAlakzat(AlakMut)^.PenStyle,
                                Szin,
                                PEllipszisAlakzat(AlakMut)^.PenMeret);
                    EllipszisRajzol(Form,Image,
                                    Zoom*PEllipszisAlakzat(AlakMut)^.A,
                                    Zoom*PEllipszisAlakzat(AlakMut)^.B,
                                    KoordZoom(PEllipszisAlakzat(AlakMut)^.Kozep,Zoom),
                                    PEllipszisAlakzat(AlakMut)^.Szog,True,
                                    PEllipszisAlakzat(AlakMut)^.Koord[1],
                                    PEllipszisAlakzat(AlakMut)^.Koord[2]);
                  End;
    dtAjto      : Begin
                    SetPenStyle(Form,Image,
                                PAjtoAlakzat(AlakMut)^.PenStyle,
                                Szin,
                                PAjtoAlakzat(AlakMut)^.PenMeret);
                    AjtoRajzol(Form,Image,PAjtoAlakzat(AlakMut)^,Zoom);
                  End;
    dtAblak     : Begin
                    SetPenStyle(Form,Image,
                                PAblakAlakzat(AlakMut)^.PenStyle,
                                Szin,
                                PAblakAlakzat(AlakMut)^.PenMeret);
                    AblakRajzol(Form,Image,PAblakAlakzat(AlakMut)^,clAqua,Zoom);
                  End;
  End;
End;

//épületegység újra kirajzolása
Procedure AlakzatLancAtRajzol(Const Form: TForm; Const Image: TImage; Const Zoom: Extended);
Var Regi    : PAlakzatElem;
    AlakMut : Pointer;
    Szin    : TColor;
    RegiPen : TRegiPenStyle;
Begin
  Szin:=0;
  //ha a lánc létezik és nem üres
  If (AlakzatLanc <> Nil) And (AlakzatLanc.Elso <> Nil) Then
  Begin
    RegiPen.Ment(Form,Image);
    Regi:=AlakzatLanc.Aktualis;
    AlakzatLanc.Aktualis:=AlakzatLanc.Elso;
    //végigmegyünk a láncon
    While (AlakzatLanc.Aktualis <> Nil) Do
    Begin
      AlakMut:=AlakzatLanc.Aktualis.AlakMut;
      EpuletTul.DT:=AlakzatLanc.Aktualis.Tipus;
      //alakzat típusa
      Case EpuletTul.DT Of
        dtVonal     : Szin:=PVonalAlakzat(AlakMut)^.PenColor;
        dtNegyzet   : Szin:=PNegyzetAlakzat(AlakMut)^.PenColor;
        dtEllipszis : Szin:=PEllipszisAlakzat(AlakMut)^.PenColor;
        dtAjto      : Szin:=PAjtoAlakzat(AlakMut)^.PenColor;
        dtAblak     : Szin:=PAblakAlakzat(AlakMut)^.PenColor;
      End;
      //alakzat rajzolása
      LancRajzol(Form,Image,EpuletTul.DT,Szin,AlakMut,Zoom);
      AlakzatLanc.Aktualis:=AlakzatLanc.Aktualis.Kovetkezo;
    End;
    AlakzatLanc.Aktualis:=Regi;
    RegiPen.Vissza(Form,Image);
  End;
End;

//épületegység újra kirajzolása a megadott színnel
Procedure AlakzatLancAtRajzol(Const Form: TForm; Const Image: TImage;
  Const Szin: TColor; Const Zoom: Extended);
Var Regi    : PAlakzatElem;
    AlakMut : Pointer;
    RegiPen : TRegiPenStyle;
Begin
  //ha a lánc létezik és nem üres
  If (AlakzatLanc <> Nil) And (AlakzatLanc.Elso <> Nil) Then
  Begin
    RegiPen.Ment(Form,Image);
    Regi:=AlakzatLanc.Aktualis;
    AlakzatLanc.Aktualis:=AlakzatLanc.Elso;
    //végigmegyünk a láncon
    While (AlakzatLanc.Aktualis <> Nil) Do
    Begin
      AlakMut:=AlakzatLanc.Aktualis.AlakMut;
      EpuletTul.DT:=AlakzatLanc.Aktualis.Tipus;
      If (EpuletTul.DT = dtAblak) Then AblakRajzol(Form,Image,PAblakAlakzat(AlakMut)^,Szin,Zoom)
      Else LancRajzol(Form,Image,EpuletTul.DT,Szin,AlakMut,Zoom);
      AlakzatLanc.Aktualis:=AlakzatLanc.Aktualis.Kovetkezo;
    End;
    AlakzatLanc.Aktualis:=Regi;
    RegiPen.Vissza(Form,Image);
  End;
End;

//egy adott alakzat újrarajzolása a megadott színnel
Procedure AlakzatLancAtRajzol(Const Form: TForm; Const Image: TImage;
  Const Szin: TColor; Const Mit: Pointer; Const Zoom: Extended);
Var Regi    : PAlakzatElem;
    AlakMut : Pointer;
    RegiPen : TRegiPenStyle;
Begin
  //ha a lánc létezik és nem üres
  If (Mit <> Nil) And (AlakzatLanc <> Nil) And (AlakzatLanc.Elso <> Nil) Then
  Begin
    RegiPen.Ment(Form,Image);
    Regi:=AlakzatLanc.Aktualis;
    AlakzatLanc.Aktualis:=Mit;
    AlakMut:=AlakzatLanc.Aktualis.AlakMut;
    EpuletTul.DT:=AlakzatLanc.Aktualis.Tipus;
    If (EpuletTul.DT = dtAblak) Then
    Begin
      SetPenStyle(Form,Image,PAblakAlakzat(AlakMut)^.PenStyle,Szin,PAblakAlakzat(AlakMut)^.PenMeret);
      AblakRajzol(Form,Image,PAblakAlakzat(AlakMut)^,Szin,Zoom);
    End
    Else LancRajzol(Form,Image,EpuletTul.DT,Szin,AlakMut,Zoom);
    AlakzatLanc.Aktualis:=Regi;
    RegiPen.Vissza(Form,Image);
  End;
End;

//egy alakzat létrehozása
Procedure AlakzatLetrehoz(Const Form: TForm; Const Image: TImage;
  Const EpLista: TEpuletLista; Const Szog: Integer; Const Tip: TDrawingTool;
  Const PM: Integer; Const PS: TPenStyle; Const PC: Integer;
  Const K1,K2,K3,K4: TPoint; Const A,B: Double; Const Zoom: Extended);
Begin
  //alakzat típusa
  Case Tip Of
    dtVonal     : Begin
                    New(Vonal);
                    Vonal.Szog:=Szog;
                    Vonal.Tipus:=Tip;
                    Vonal.PenMeret:=PM;
                    Vonal.PenStyle:=PS;
                    Vonal.PenColor:=PC;
                    Vonal.Koord[1]:=K1;
                    Vonal.Koord[2]:=K2;
                    //alakzat felfûzése a láncra
                    AlakzatLanc.LancraFuz(EpLista,Vonal,Tip);
                  End;
    dtNegyzet   : Begin
                    New(Negyzet);
                    Negyzet.Szog:=Szog;
                    Negyzet.Tipus:=Tip;
                    Negyzet.PenMeret:=PM;
                    Negyzet.PenStyle:=PS;
                    Negyzet.PenColor:=PC;
                    Negyzet.Koord[1]:=K1;
                    Negyzet.Koord[2]:=K2;
                    Negyzet.Koord[3]:=K3;
                    Negyzet.Koord[4]:=K4;
                    //alakzat felfûzése a láncra
                    AlakzatLanc.LancraFuz(EpLista,Negyzet,Tip);
                  End;
    dtEllipszis : Begin
                    New(Ellipszis);
                    Ellipszis.Szog:=Szog;
                    Ellipszis.Tipus:=Tip;
                    Ellipszis.PenMeret:=PM;
                    Ellipszis.PenStyle:=PS;
                    Ellipszis.PenColor:=PC;
                    Ellipszis.A:=A;
                    Ellipszis.B:=B;
                    Ellipszis.Kozep.X:=K3.X;
                    Ellipszis.Kozep.Y:=K3.Y;
                    //ellipszis rajzolása
                    EllipszisRajzol(Form,Image, Ellipszis.A,Ellipszis.B,
                      Ellipszis.Kozep, Ellipszis.Szog,False,
                      Ellipszis.Koord[1],Ellipszis.Koord[2]);
                    //alakzat felfûzése a láncra
                    AlakzatLanc.LancraFuz(EpLista,Ellipszis,Tip);
                  End;
    dtAjto      : Begin
                    New(Ajto);
                    Ajto.Szog:=Szog;
                    Ajto.Tipus:=Tip;
                    Ajto.PenMeret:=PM;
                    Ajto.PenStyle:=PS;
                    Ajto.PenColor:=PC;
                    Ajto.Koord[1]:=K1;
                    Ajto.Koord[2]:=K2;
                    Ajto.Koord[3]:=K3;
                    Ajto.Koord[4]:=K4;
                    //alakzat felfûzése a láncra
                    AlakzatLanc.LancraFuz(EpLista,Ajto,Tip);
                  End;
    dtAblak     : Begin
                    New(Ablak);
                    Ablak.Szog:=Szog;
                    Ablak.Tipus:=Tip;
                    Ablak.PenMeret:=PM;
                    Ablak.PenStyle:=PS;
                    Ablak.PenColor:=PC;
                    Ablak.Koord[1]:=K1;
                    Ablak.Koord[2]:=K2;
                    Ablak.Koord[3]:=K3;
                    Ablak.Koord[4]:=K4;
                    //alakzat felfûzése a láncra
                    AlakzatLanc.LancraFuz(EpLista,Ablak,Tip);
                    //ablak rajzolása
                    AblakRajzol(Form,Image,PAblakalakzat(Ablak)^,clAqua,Zoom);
                  End;
  End;
End;

//rajzasztal újrarajzolása
Procedure Asztalfrissit(Const Form: TForm; Const Image: TImage; Const Zoom: Extended);
Var RegiDrawingTool : TDrawingTool;
Begin
  With Form Do
  Begin
    RegiDrawingTool:=EpuletTul.DT;
    Image.Picture.Graphic:=Nil;
    //elkeszíti a rajzasztalt
    RajzasztalKeszit(Form,Image,Round(Zoom*Rajzmeret));
    //kirajzolja az alakzatokat
    AlakzatLancAtRajzol(Form,Image,Zoom);
    EpuletTul.DT:=RegiDrawingTool;
  End;
End;

//objektumok betöltése
//visszaadja az objektumok láncát
Function ObjektumLancBetolt(Const EpLista: TEpuletLista; Tabla: TTable) : TObjektumLista;
Var EgysNev   : String;
    ObjNev    : String;
    ID        : Integer;
    X,Y       : Integer;
    Meret     : Integer;
    Mutato    : PObjektumLanc;
    ALancMut  : PAlakzatLanc;
    EpEgysMut : PEpuletEgyseg;
Begin
  //lánc létrehozása
  Result:=TObjektumLista.Create(EpLista);
  //az adatbázisból beolvassuk az adatokat
  With Tabla Do
  Begin
    First;
    While (Not EOF) Do
    Begin
      Mutato:=Nil;
      ObjNev:=FieldByName('ObjNev').AsString;
      X:=FieldByName('X').AsInteger;
      Y:=FieldByName('Y').AsInteger;
      ID:=FieldByName('id').AsInteger;
      //pontok felvétele
      If Result.KeresAndRaAll(ObjNev,Mutato) Then Mutato.ObjMut.Pontok[ID]:=Point(X,Y)
      Else Begin
        EgysNev:=FieldByName('EgysegNev').AsString;
        EpLista.EgysegKeresNev(EgysNev,ALancMut,EpEgysMut);
        Meret:=FieldByName('Meret').AsInteger;
        //felfûzzük a láncra
        Result.Felfuz(ObjNev,EpEgysMut,Meret,Mutato);
        Mutato.ObjMut.Pontok[ID]:=Point(X,Y);
      End;
      Next;
    End;
  End;
End;

//berendezések betöltése
//visszaadja az berendezések láncát
Function BerendezesLancBetolt(Tabla : TTable) : TBerendezesLista;
Var EgysNev   : String;
    ObjNev    : String;
    BerendNev : String;
    ID        : Integer;
    BerendTip : TBerendezesTip;
Begin
  //lánc létrehozása
  Result:=TBerendezesLista.Create;
  //az adatbázisból beolvassuk az adatokat
  With Tabla Do
  Begin
    First;
    While (Not EOF) Do
    Begin
      BerendTip:=TBerendezesTip(FieldByName('Tipus').AsInteger);
      EgysNev:=FieldByName('EgysegNev').AsString;
      ObjNev:=FieldByName('ObjNev').AsString;
      BerendNev:=FieldByName('BerendNev').AsString;
      ID:=FieldByName('id').AsInteger;
      //felfûzzük a láncra
      Result.Felfuz(BerendTip,ObjNev,EgysNev,BerendNev,ID);
      Next;
    End;
  End;
End;

End.
