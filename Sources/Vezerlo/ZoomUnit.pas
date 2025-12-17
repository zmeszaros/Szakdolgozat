//Nagyítás-kicsinyítés függvényei
Unit ZoomUnit;

Interface

Uses Windows, Classes;

Const MAXZOOM = 4;  //maximális nagyítás

Type

  TZoom = Object
    Szorzo : Extended;           //arányszám
    Function Novel : Boolean;
    Function Csokkent : Boolean;
  End;

  Function ErtekZoom(Const Ertek: Integer;Const Zoom: Extended) : Integer;
  Function KoordZoom(Const Pont: TPoint;Const Zoom: Extended) : TPoint;

Var Zoom : TZoom;

Implementation

//nagyítás
//ha lehet még nagyítani -> True, különben -> False
Function TZoom.Novel;
Begin
  Result:=False;
  If (Self.Szorzo < MAXZOOM) Then
  Begin
    Result:=True;
    Self.Szorzo:=2*Self.Szorzo;
  End;
End;

//kicsinyítés
//ha lehet még kicsinyíteni -> True, különben -> False
Function TZoom.Csokkent;
Begin
  Result:=False;
  If (Self.Szorzo > (1/MAXZOOM)) Then
  Begin
    Result:=True;
    Self.Szorzo:=Self.Szorzo/2;
  End;
End;

//kapott érték konvertálása a Zoom mértéke szerint
Function ErtekZoom(Const Ertek: Integer;Const Zoom: Extended) : Integer;
Begin
  Result:=Round(Zoom*Ertek);
End;

//kapott koordináta konvertálása a Zoom mértéke szerint
Function KoordZoom(Const Pont: TPoint;Const Zoom: Extended) : TPoint;
Begin
  Result:=Point(ErtekZoom(Pont.X,Zoom),ErtekZoom(Pont.Y,Zoom));
End;

End.
 