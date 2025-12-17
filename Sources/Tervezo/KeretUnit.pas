//Kijelölõ keret eljárásai, függvényei
Unit KeretUnit;

Interface

Uses Windows, Graphics, ExtCtrls, Forms, Classes, RajzolasUnit, PenUnit;

Type
  //a kijelölõ keret egy sarkának koordinátái
  TSarokKoord = Object
    Koord1 : Extended;   //X
    Koord2 : Extended;   //Y
  End;

  //keret õsosztály
  TKeretClass = Class
    Public
      Constructor Init(Keret_BF, Keret_JA : TPoint); overload; virtual;
      Constructor Init(BF_X, BF_Y, JA_X, JA_Y : Integer); overload; virtual;
      Procedure SetKeret_Ossz(BF_X, BF_Y, JA_X, JA_Y : Integer);
      Procedure SetKeret_BF(Keret_BF : TPoint); overload;
      Procedure SetKeret_BF(BF_X, BF_Y : Integer); overload;
      Procedure SetKeret_JA(Keret_JA : TPoint); overload;
      Procedure SetKeret_JA(JA_X, JA_Y : Integer); overload;
      Procedure SetKeret_BF_X(BF_X : Integer);
      Procedure SetKeret_BF_Y(BF_Y : Integer);
      Procedure SetKeret_JA_X(JA_X : Integer);
      Procedure SetKeret_JA_Y(JA_Y : Integer);
      Procedure SetKeret_RegiBF(BF_X, BF_Y : Integer);
      Procedure SetKeret_RegiJA(JA_X, JA_Y : Integer);
      Procedure SetKeret_KisNPos(Ertek : Byte);
      Function GetKeret_BF      : TPoint;
      Function GetKeret_JA      : TPoint;
      Function GetKeret_BF_X    : Integer;
      Function GetKeret_BF_Y    : Integer;
      Function GetKeret_JA_X    : Integer;
      Function GetKeret_JA_Y    : Integer;
      Function GetKeret_MVekt_X : Integer;
      Function GetKeret_MVekt_Y : Integer;
    Private
      BF        : TPoint;     //balfelsõ koord
      JA        : TPoint;     //jobbalsó koord
      RegiBF    : TPoint;     //mentett balfelsõ koord
      RegiJA    : TPoint;     //mentett jobbalsó koord
      MVekt     : TPoint;     //elmozdulás mértéke
      IVekt     : TPoint;     //irányvektor
      KisNPos   : Byte;       //sarkot jelölõ négyzet pozíciója
      Procedure Feltolt;
  End;

  //keret osztály
  TKeret = Class(TKeretClass)
    Public
      Constructor Init(Forms : TForm; Images : TImage; Keret_BF, Keret_JA : TPoint); reintroduce; overload;
      Constructor Init(Forms : TForm; Images : TImage; BF_X, BF_Y, JA_X, JA_Y : Integer); reintroduce; overload;
      Function KeretEllonoriz(Const Min,Max : TPoint) : Boolean;
      Function UjSarok(Const Sarok : Integer) : TSarokKoord;
      Function KeretForgat(Const Irany,Szog,Sarok : Integer) : Boolean;
      Procedure KeretMent;
      Procedure KeretVissza;
      Procedure KoordCsere;
      Procedure PenStyleMent(Obj : TRegiPenStyle; PM : TPenMode);
      Procedure KeretSzamit(X, Y : Integer);
      Procedure KoordRendez(RajzMeret : Integer);
      Procedure KeretRajzoloBekapcs(X,Y : Integer);
      Procedure KeretRajzoloKikapcs;
      Procedure KeretRajzoloFrissit(X,Y : Integer);
      Procedure KeretKapcs(Szin : TColor; PenMod : TPenMode);
      Procedure RegiKeretKapcs(Szin : TColor; PenMod : TPenMode);
    Private
      Form         : TForm;           //melyik form-on dolgozunk
      Image        : TImage;          //melyik image-n dolgozunk
      RegiKeret    : TKeret;          //keret mentése
      RegiPenStyle : TRegiPenStyle;   //toll tulajdonság mentése
      RegiPenMode  : TPenMode;        //toll tulajdonság mentése
  End;

  Function RelHely(Pont1,Pont2 : Extended) : Extended;
  Function UjKoord(Const Sarok: TSarokKoord; Const Irany,Szog: Integer;
           Const P1,P2: Extended) : TPoint;

Implementation

//relatív hely
Function RelHely(Pont1,Pont2 : Extended) : Extended;
Begin
  Result:=Pont1-Pont2;
End;

//pont elforgatása egy sarok körül
Function UjKoord(Const Sarok: TSarokKoord; Const Irany,Szog: Integer;
         Const P1,P2: Extended) : TPoint;
Var Alpha : Extended;
Begin
  Alpha:=SzogToRad(Szog);
  Result.X:=Round((P1*cos(Alpha))+(Irany*P2*sin(Alpha))+Sarok.Koord1);
  Result.Y:=Round(((-1)*(Irany)*P1*sin(Alpha))+(P2*cos(Alpha))+Sarok.Koord2);
End;

//keret létrehozása
Constructor TKeret.Init(Forms: TForm; Images: TImage; Keret_BF,Keret_JA: TPoint);
Begin
  Form:=Forms;
  Image:=Images;
  Inherited Init(Keret_BF,Keret_JA);
End;

//keret létrehozása
Constructor TKeret.Init(Forms : TForm; Images : TImage; BF_X, BF_Y, JA_X, JA_Y : Integer);
Begin
  Form:=Forms;
  Image:=Images;
  Inherited Init(BF_X,BF_Y,JA_X,JA_Y);
End;

//keret adatainak lementése
Procedure TKeret.KeretMent;
Begin
  RegiKeret:=TKeret.Init(Self.Form,Self.Image,Self.BF,Self.JA);
  RegiKeret.MVekt:=Self.MVekt;
  RegiKeret.KisNPos:=Self.KisNPos;
End;

//keret adatainak visszatöltése
Procedure TKeret.KeretVissza;
Begin
  BF:=RegiKeret.BF;
  JA:=RegiKeret.JA;
  Feltolt;
  MVekt:=RegiKeret.MVekt;
  KisNPos:=RegiKeret.KisNPos;
End;

//keret rajzolási adatainak mentése
Procedure TKeret.PenStyleMent;
Begin
  RegiPenMode:=PM;
  RegiPenStyle.Stilus:=Obj.Stilus;
  RegiPenStyle.Szin:=Obj.Szin;
  RegiPenStyle.Meret:=Obj.Meret;
End;

//keret koor-inak újrarendezése min,max alapján
Procedure TKeret.KoordRendez(RajzMeret : Integer);
Var MinX,MinY : Integer;
    MaxX,MaxY : Integer;
Begin
  MinX:=RajzMeret;
  MinY:=RajzMeret;
  MaxX:=0;
  MaxY:=0;
  If (BF.X <= MinX) Then MinX:=BF.X;
  If (BF.X >= MaxX) Then MaxX:=BF.X;
  If (BF.Y <= MinY) Then MinY:=BF.Y;
  If (BF.Y >= MaxY) Then MaxY:=BF.Y;
  If (JA.X <= MinX) Then MinX:=JA.X;
  If (JA.X >= MaxX) Then MaxX:=JA.X;
  If (JA.Y <= MinY) Then MinY:=JA.Y;
  If (JA.Y >= MaxY) Then MaxY:=JA.Y;
  BF.X:=MinX;
  BF.Y:=MinY;
  JA.X:=MaxX;
  JA.Y:=MaxY;
  Feltolt;
End;

//keret rajzolása
Procedure TKeret.KeretRajzoloBekapcs(X,Y : Integer);
Begin
  SetPenStyle(Form,Image,psSolid,clFuchsia,1);
  With Image.Canvas Do
  Begin
    KeretSzamit(X,Y);
    NegyzetRajzol(Form,Image,BF,Point(JA.X,BF.Y),JA,Point(BF.X,JA.Y));
  End;
End;

//keret eltüntetése
Procedure TKeret.KeretRajzoloKikapcs;
Var RPS : TRegiPenStyle;
    RPM : TPenMode;
Begin
  RPS.Ment(Form,Image);
  RPM:=Image.Canvas.Pen.Mode;
  SetPenStyle(Form,Image,psSolid,clFuchsia,1);
  Image.Canvas.Pen.Color:=clNone;
  Image.Canvas.Pen.Mode:=pmNotXor;
  NegyzetRajzol(Form,Image,BF,Point(JA.X,BF.Y),JA,Point(BF.X,JA.Y));
  Image.Canvas.Pen.Mode:=pmNotXor;
  RPS.Vissza(Form,Image);
  Image.Canvas.Pen.Mode:=RPM;
End;

//keret újra rajzolása
Procedure TKeret.KeretRajzoloFrissit(X,Y : Integer);
Begin
  With Image.Canvas Do
  Begin
    SetPenStyle(Form,Image,psSolid,clFuchsia,1);
    Pen.Mode:=pmNotXor;
    NegyzetRajzol(Form,Image,BF,Point(JA.X,BF.Y),JA,Point(BF.X,JA.Y));
    KeretSzamit(X,Y);
    Pen.Mode:=pmNotXor;
    NegyzetRajzol(Form,Image,BF,Point(JA.X,BF.Y),JA,Point(BF.X,JA.Y));
  End;
End;

//alapértékek feltöltése
Procedure TKeretClass.Feltolt;
Begin
  RegiBF:=BF;
  RegiJA:=JA;
  IVekt.X:=Round((JA.X-BF.X) Div 2);
  IVekt.Y:=Round((JA.Y-BF.Y) Div 2);
End;

//KeretClass létrehozása
Constructor TKeretClass.Init(Keret_BF, Keret_JA : TPoint);
Begin
  BF:=Keret_BF;
  JA:=Keret_JA;
  Feltolt;
End;

//KeretClass létrehozása
Constructor TKeretClass.Init(BF_X, BF_Y, JA_X, JA_Y : Integer);
Begin
  BF.X:=BF_X;
  BF.Y:=BF_Y;
  JA.X:=JA_X;
  JA.Y:=JA_Y;
  Feltolt;
End;

//melyik kis négyzetet választottuk
//jobb-alsó, bal-felsõ pontok beállítása
procedure TKeret.KoordCsere;
Var K1,K2 : TPoint;  //segédpontok
Begin
  Case KisNPos Of
    //ha a bal-felsõt választottuk
    1 : Begin
          K1:=BF;
          BF:=JA;
          JA:=K1;
        End;
    //ha a jobb-felsõt választottuk
    3 : Begin
          K1:=Point(BF.X,JA.Y);
          K2:=Point(JA.X,BF.Y);
          BF:=K1;
          JA:=K2;
        End;
    //ha a bal-alsót választottuk
    4 : Begin
          K1:=Point(BF.X,JA.Y);
          K2:=Point(JA.X,BF.Y);
          BF:=K2;
          JA:=K1;
        End;
  End;
end;

//az összes sarokpont beállítása
procedure TKeretClass.SetKeret_Ossz(BF_X, BF_Y, JA_X, JA_Y: Integer);
begin
  BF.X:=BF_X;
  BF.Y:=BF_Y;
  JA.X:=JA_X;
  JA.Y:=JA_Y;
  Feltolt;
end;

//a bal-felsõ sarokpont beállítása
Procedure TKeretClass.SetKeret_BF(Keret_BF : TPoint);
Begin
  BF:=Keret_BF;
  Feltolt;
End;

//a bal-felsõ sarokpont beállítása
procedure TKeretClass.SetKeret_BF(BF_X, BF_Y: Integer);
begin
  BF.X:=BF_X;
  BF.Y:=BF_Y;
  Feltolt;
end;

//a jobb-alsó sarokpont beállítása
Procedure TKeretClass.SetKeret_JA(Keret_JA : TPoint);
Begin
  JA:=Keret_JA;
  Feltolt;
End;

//a jobb-alsó sarokpont beállítása
procedure TKeretClass.SetKeret_JA(JA_X, JA_Y: Integer);
begin
  JA.X:=JA_X;
  JA.Y:=JA_Y;
  Feltolt;
end;

//koordináták újraszámolása, méretváltozás esetén
procedure TKeret.KeretSzamit(X, Y: Integer);
begin
  BF.X:=X-IVekt.X;
  BF.Y:=Y-IVekt.Y;
  JA.X:=X+IVekt.X;
  JA.Y:=Y+IVekt.Y;
  MVekt.X:=BF.X-RegiBF.X;
  MVekt.Y:=BF.Y-RegiBF.Y;
end;

//keret ki-be kapcsolása -> újrarajzolás
procedure TKeret.KeretKapcs(Szin: TColor; PenMod: TPenMode);
Var RegiMode : TPenMode;
    RegiPen  : TRegiPenStyle;
Begin
  With Form Do
  Begin
    RegiPen.Ment(Form,Image);
    RegiMode:=Image.Canvas.Pen.Mode;
    Image.Canvas.Pen.Mode:=PenMod;
    SetPenStyle(Form,Image,psSolid,Szin,1);
    NegyzetRajzol(Form,Image,BF,Point(JA.X,BF.Y),JA,Point(BF.X,JA.Y));
    Image.Canvas.Pen.Mode:=RegiMode;
    RegiPen.Vissza(Form,Image);
  End;
end;

//mentett keret ki-be kapcsolása -> újrarajzolás
procedure TKeret.RegiKeretKapcs(Szin: TColor; PenMod: TPenMode);
Begin
  RegiKeret.KeretKapcs(Szin,PenMod);
end;

//a bal-felsõ sarokpont lekérdezése
function TKeretClass.GetKeret_BF: TPoint;
begin
  Result:=BF;
end;

//a jobb-alsó sarokpont lekérdezése
function TKeretClass.GetKeret_JA: TPoint;
begin
  Result:=JA;
end;

//a bal-felsõ sarokpont X koord. lekérdezése
function TKeretClass.GetKeret_BF_X : Integer;
begin
  Result:=BF.X;
end;

//a bal-felsõ sarokpont Y koord. lekérdezése
function TKeretClass.GetKeret_BF_Y: Integer;
begin
  Result:=BF.Y;
end;

//a jobb-alsó sarokpont X koord. lekérdezése
function TKeretClass.GetKeret_JA_X: Integer;
begin
  Result:=JA.X;
end;

//a jobb-alsó sarokpont Y koord. lekérdezése
function TKeretClass.GetKeret_JA_Y: Integer;
begin
  Result:=JA.Y;
end;

//az elmozdulás vektor X koord. lekérdezése
function TKeretClass.GetKeret_MVekt_X: Integer;
begin
  Result:=MVekt.X;
end;

//az elmozdulás vektor Y koord. lekérdezése
function TKeretClass.GetKeret_MVekt_Y: Integer;
begin
  Result:=MVekt.Y;
end;

//a bal-felsõ sarokpont X koord. beállítása
procedure TKeretClass.SetKeret_BF_X(BF_X: Integer);
begin
  BF.X:=BF_X;
  Feltolt;
end;

//a bal-felsõ sarokpont Y koord. beállítása
procedure TKeretClass.SetKeret_BF_Y(BF_Y: Integer);
begin
  BF.Y:=BF_Y;
  Feltolt;
end;

//a jobb-alsó sarokpont X koord. beállítása
procedure TKeretClass.SetKeret_JA_X(JA_X: Integer);
begin
  JA.X:=JA_X;
  Feltolt;
end;

//a jobb-alsó sarokpont Y koord. beállítása
procedure TKeretClass.SetKeret_JA_Y(JA_Y: Integer);
begin
  JA.Y:=JA_Y;
  Feltolt;
end;

//keret bal-felsõ pontjának mentése
procedure TKeretClass.SetKeret_RegiBF(BF_X, BF_Y: Integer);
begin
  RegiBF:=Point(BF_X, BF_Y);
end;

//keret jobb-alsó pontjának mentése
procedure TKeretClass.SetKeret_RegiJA(JA_X, JA_Y: Integer);
begin
  RegiJA:=Point(JA_X, JA_Y);
end;

//a keret kijelölõ négyzeteinek állapota ( melyik volt kiválasztva )
procedure TKeretClass.SetKeret_KisNPos(Ertek: Byte);
begin
  KisNPos:=Ertek;
end;

//a keret nagyobb, mint a kijelölt alakzatok
//ha nem nagyobb -> True, különben -> False
Function TKeret.KeretEllonoriz(Const Min,Max : TPoint) : Boolean;
Begin
  Result:=True;
  If ((BF.X < Min.X) Or (BF.Y < Min.Y) Or
      (JA.X > Max.X) Or (JA.Y > Max.Y)) Then Result:=False;
End;

//sarok választása esetén visszaadja a választott sarok koordinátáit
Function TKeret.UjSarok(Const Sarok: Integer): TSarokKoord;
Begin
  Case Sarok Of
    //ha a bal-felsõ pont
    1 : Begin
          Result.Koord1:=Self.GetKeret_BF_X;
          Result.Koord2:=Self.GetKeret_BF_Y;
        End;
    //ha a jobb-felsõ pont
    2 : Begin
          Result.Koord1:=Self.GetKeret_JA_X;
          Result.Koord2:=Self.GetKeret_BF_Y;
        End;
    //ha a jobb-alsó pont
    3 : Begin
          Result.Koord1:=Self.GetKeret_JA_X;
          Result.Koord2:=Self.GetKeret_JA_Y;
        End;
    //ha a bal-alsó pont
    4 : Begin
          Result.Koord1:=Self.GetKeret_BF_X;
          Result.Koord2:=Self.GetKeret_JA_Y;
        End;
    //ha a középpont lett kiválasztva
    5 : Begin
          Result.Koord1:=(Self.GetKeret_BF_X+Self.GetKeret_JA_X)/2;
          Result.Koord2:=(Self.GetKeret_BF_Y+Self.GetKeret_JA_Y)/2;
        End;
  End;
End;

//a keretet elforgatja a megadott irányba, szöggel, a kiválasztott sarok körül
//ha sikerült -> True, különben -> False
Function TKeret.KeretForgat(Const Irany,Szog,Sarok: Integer): Boolean;
Var P1,P2   : TPoint;
    SarokXY : TSarokKoord;
Begin
  SarokXY:=Self.UjSarok(Sarok);
  P1:=UjKoord(SarokXY,Irany,Szog,RelHely(Self.GetKeret_BF_X,SarokXY.Koord1),RelHely(Self.GetKeret_BF_Y,SarokXY.Koord2));
  P2:=UjKoord(SarokXY,Irany,Szog,RelHely(Self.GetKeret_JA_X,SarokXY.Koord1),RelHely(Self.GetKeret_JA_Y,SarokXY.Koord2));
  //ha az új keret nem lóg ki a rajzterületrõl
  Result:=((P1.X > 0) And (P1.X < RajzMeret) And (P1.Y > 0) And (P1.Y < RajzMeret) And
    (P2.X > 0) And (P2.X < RajzMeret) And (P2.Y > 0) And (P2.Y < RajzMeret));
End;

End.
