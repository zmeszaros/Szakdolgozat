//Két pont távolságát kiszámító eljárások, függvények
Unit TavolsagUnit;

Interface

Uses Windows, SysUtils, Comctrls, Forms, Classes, EpuletLancUnit;

Type
  //távolság objektum
  TTavolsag = Object
  Public
    Function Get_Tavolsag : Real;
    Function Get_STavolsag : String;
    Procedure Init(Forms: TForm; SB: TStatusBar; Egys: Extended);
    Procedure Set_Pont1(Pont: TPoint);
    Procedure Set_Pont2(Pont: TPoint);
    Procedure Set_Pont1_X(PontX: Integer);
    Procedure Set_Pont1_Y(PontY: Integer);
    Procedure Set_Pont2_X(PontX: Integer);
    Procedure Set_Pont2_Y(PontY: Integer);
    Procedure TavSzamit(DT: TDrawingTool);
  Private
    Form      : TForm;
    StatBar   : TStatusBar;  //ide fogjuk kiírni
    Egyseg    : Extended;    //milyen méretarányban vagyunk
    Pont1     : TPoint;
    Pont2     : TPoint;
    Tavolsag  : Real;
    STavolsag : String;
  End;

Implementation

//visszaadja a távolságot sztringként
Function TTavolsag.Get_STavolsag: String;
Begin
  Result:=STavolsag;
End;

//visszaadja a távolságot valós számként
Function TTavolsag.Get_Tavolsag: Real;
Begin
  Result:=Tavolsag;
End;

//objektum inicializálása
Procedure TTavolsag.Init;
Begin
  Self.Form:=Forms;
  Self.StatBar:=SB;
  Self.Egyseg:=Egys;
  Self.Pont1:=Point(0,0);
  Self.Pont2:=Point(0,0);
  Self.STavolsag:='';
  With Form Do StatBar.Panels[2].Text:='';
End;

//kezdõpont beállítása
Procedure TTavolsag.Set_Pont1(Pont: TPoint);
Begin
  Self.Pont1:=Pont;
End;

//kezdõpont X koord-nak beállítása
Procedure TTavolsag.Set_Pont1_X(PontX: Integer);
Begin
  Self.Pont1.X:=PontX;
End;

//kezdõpont Y koord-nak beállítása
Procedure TTavolsag.Set_Pont1_Y(PontY: Integer);
Begin
  Self.Pont1.Y:=PontY;
End;

//végpont beállítása
Procedure TTavolsag.Set_Pont2(Pont: TPoint);
Begin
  Self.Pont2:=Pont;
End;

//végpont X koord-nak beállítása
Procedure TTavolsag.Set_Pont2_X(PontX: Integer);
Begin
  Self.Pont2.X:=PontX;
End;

//végpont Y koord-nak beállítása
Procedure TTavolsag.Set_Pont2_Y(PontY: Integer);
Begin
  Self.Pont2.Y:=PontY;
End;

//távolság számítása
Procedure TTavolsag.TavSzamit(DT: TDrawingTool);
Var Koord3 : TPoint;
    Tav1   : Extended;
    Tav2   : Extended;
Begin
  Case DT Of
    dtVonal   : Begin
                  Tavolsag:=Sqrt(Sqr(Pont2.Y-Pont1.Y)+Sqr(Pont2.X-Pont1.X));
                  Tav1:=Round(Tavolsag)*Egyseg;
                  STavolsag:=IntToStr(Round(Tav1) Div 1000);
                  STavolsag:=STavolsag+'.'+IntToStr(Round(Tav1) Mod 1000)+'m';
                End;
    dtEllipszis,
    dtNegyzet : Begin
                  Koord3.X:=Pont1.X;
                  Koord3.Y:=Pont2.Y;
                  Tav1:=Round(Sqrt(Sqr(Koord3.Y-Pont1.Y)+Sqr(Koord3.X-Pont1.X)))*Egyseg;
                  Tav2:=Round(Sqrt(Sqr(Pont2.Y-Koord3.Y)+Sqr(Pont2.X-Koord3.X)))*Egyseg;
                  STavolsag:=IntToStr(Round(Tav2) Div 1000);
                  STavolsag:=STavolsag+'.'+IntToStr(Round(Tav2) Mod 1000)+'m';
                  STavolsag:=STavolsag+' x '+IntToStr(Round(Tav1) Div 1000);
                  STavolsag:=STavolsag+'.'+IntToStr(Round(Tav1) Mod 1000)+'m';
                End;
  End;
End;

End.
 