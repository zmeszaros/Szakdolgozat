//Rajzolással kapcsolatos eljárások, függvények
Unit RajzolasUnit;

Interface

Uses Windows, ExtCtrls, Forms, Graphics, Classes, EpuletLancUnit;

Const BE          = pmCopy;     //rajzolás
      KI          = pmNotXor;   //törlés
      RAJZMERET   = 1200;       //rajzasztal mérete
      ELLPONTSZAM = 200;        //ellipszis pontjainak a száma

Type
  //egy épületrajz tulajdonságai
  TEpuletTul = Record
    PS : TPenStyle;    //PenStyle
    PC : TColor;       //PenColor
    PM : Integer;      //PenMeret
    DT : TDrawingTool; //DrawingTool
    VE : Boolean;      //VanEpulet
  End;

Function SzogToRad(Const Szog: Integer) : Extended;
Procedure DrawShape(Const Form: TForm; Const Image: TImage; Const DT: TDrawingTool;
  Const TopLeft,BottomRight: TPoint; Const AMode: TPenMode);
Procedure NegyzetRajzol(Const Form: TForm; Const Image: TImage; Const BF,JF,JA,BA: TPoint);
Procedure EllipszisRajzol(Const Form: TForm; Const Image: TImage; Const A,B: Double;
  Const Kozep: TPoint; Const Szog: Integer; Const Rajzol: Boolean; Var Min,Max: TPoint);

Var EpuletTul : TEpuletTul;

Implementation

//szög átalakítása radiánba
Function SzogToRad(Const Szog: Integer) : Extended;
Begin
  Result:=Szog*(Pi/180);
End;

//rajzolási rutin
Procedure DrawShape(Const Form: TForm; Const Image: TImage; Const DT: TDrawingTool;
  Const TopLeft,BottomRight: TPoint; Const AMode: TPenMode);
Var Min,Max : TPoint;
Begin
  With Form Do
   With Image.Canvas Do
   Begin
     Pen.Mode:=AMode;
     //mûvelet típusa
     Case DT Of
       dtFal       : Begin
                       MoveTo(TopLeft.X,TopLeft.Y);
                       LineTo(BottomRight.X,BottomRight.Y);
                       MoveTo(TopLeft.X,TopLeft.Y+50);
                       LineTo(BottomRight.X,BottomRight.Y+50);
                     End;
       dtAjto,
       dtAblak,
       dtVonal,
       dtPoligon,
       dtObjektum  : Begin
                       MoveTo(TopLeft.X,TopLeft.Y);
                       LineTo(BottomRight.X,BottomRight.Y);
                     End;
       dtNegyzet,
       dtMeretez,
       dtKijelol   : NegyzetRajzol(Form,Image,TopLeft,
                                   Point(BottomRight.X,TopLeft.Y),
                                   BottomRight,
                                   Point(TopLeft.X,BottomRight.Y));
       dtEllipszis : EllipszisRajzol(Form,Image,
                                     Abs(TopLeft.X-BottomRight.X)/2,
                                     Abs(TopLeft.Y-BottomRight.Y)/2,
                                     Point(Round((TopLeft.X+BottomRight.X)/2),
                                     Round((TopLeft.Y+BottomRight.Y)/2)),
                                     0,True,Min,Max);
     End;
  End;
End;

//négyzet rajzolása
Procedure NegyzetRajzol(Const Form: TForm; Const Image: TImage; Const BF,JF,JA,BA: TPoint);
Begin
  With Form Do
    With Image Do Canvas.PolyLine([BF,JF,JA,BA,BF]);
End;

//ellipszis rajzolása
Procedure EllipszisRajzol(Const Form: TForm; Const Image: TImage; Const A,B: Double;
  Const Kozep: TPoint; Const Szog: Integer; Const Rajzol: Boolean; Var Min,Max: TPoint);
Var I             : Integer;
    ForgatasiSzog : Double;
    Theta         : Double;
    X,Y           : Double;
    ForgatottX    : Integer;
    ForgatottY    : Integer;

  //az ellipszis min, max pontjának keresése
  Procedure MinMax(Pont : TPoint);
  Begin
    If (Pont.X >= Max.X) Then Max.X:=Pont.X;
    If (Pont.X <= Min.X) Then Min.X:=Pont.X;
    If (Pont.Y >= Max.Y) Then Max.Y:=Pont.Y;
    If (Pont.Y <= Min.Y) Then Min.Y:=Pont.Y;
  End;

Begin
  Max.X:=0;
  Max.Y:=0;
  Min.X:=RajzMeret;
  Min.Y:=RajzMeret;
  //a koordináta tengelyhez viszonyított elforgatás
  ForgatasiSzog:=SzogToRad(Szog);
  For I:=0 To ELLPONTSZAM Do
  Begin
    //az egyes pontok kiszámítása
    Theta:=360*(I/ELLPONTSZAM)*(Pi/180);
    X:=Kozep.X+A*COS(Theta);
    Y:=Kozep.Y+B*SIN(Theta);
    ForgatottX:=Round(Kozep.X+(x-Kozep.X)*COS(ForgatasiSzog)-(y-Kozep.Y)*SIN(ForgatasiSzog));
    ForgatottY:=Round(Kozep.Y+(x-Kozep.X)*SIN(ForgatasiSzog)+(y-Kozep.Y)*COS(ForgatasiSzog));
    //rajzolás a vászonra
    If Rajzol Then
      With Form Do
        With Image Do
          If (I = 0) Then Canvas.MoveTo(ForgatottX,ForgatottY)
          Else Canvas.LineTo(ForgatottX,ForgatottY);
    //min, max meghatározása
    MinMax(Point(ForgatottX,ForgatottY));
  End;
End;

End.
