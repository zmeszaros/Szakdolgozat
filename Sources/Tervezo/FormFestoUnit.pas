//Egy form átfestése
Unit FormFestoUnit;

Interface

Uses Windows, Forms, Graphics, StdCtrls, ExtCtrls;

Type
  //színátmenet tulajdonságai
  TAblakSzin = Object
    EndColor    : Integer;  //végszín
    BetuSzin    : Integer;  //betûk színe
    HatterSzin  : Integer;  //háttér színe
    SzinAtmenet : Boolean;  //kell-e színátmenet
  End;

Var AblakSzin : TAblakSzin;

Procedure FormFesto(Form: TForm);
Procedure Label_Bevel_Allit(Form: TForm; TombLabel: Array Of TLabel;
          TombBevel: Array Of TBevel; Ertek: Boolean; Szin: Integer;
          Stilus: TBevelStyle);
Procedure Label_Allit(Form: TForm; TombLabel: Array Of TLabel;
          Ertek: Boolean; Szin: Integer);
Procedure Bevel_Allit(Form: TForm; TombBevel: Array Of TBevel;
          Ertek: Boolean; Stilus: TBevelStyle);

Implementation

//beállítja a betûk és a keretek színét
Procedure Label_Bevel_Allit(Form: TForm; TombLabel: Array Of TLabel;
          TombBevel: Array Of TBevel; Ertek: Boolean; Szin: Integer;
          Stilus: TBevelStyle);
Var I : Integer;
Begin
  With Form Do
  Begin
    //ha nem kell színátmenet
    If (Ertek = False) Then
    Begin
      Form.Color:=AblakSzin.HatterSzin;
      Form.Font.Color:=AblakSzin.BetuSzin;
    End;
    //beállítja a szövegek tulajdonságait
    For I:=0 To High(TombLabel) Do
    Begin
      TombLabel[i].Transparent:=Ertek;
      TombLabel[i].Font.Color:=Szin;
    End;
    //beállítja a keret stílusát
    For I:=0 To High(TombBevel) Do TombBevel[i].Style:=Stilus;
  End;
End;

//beállítja a betûk színét
Procedure Label_Allit(Form: TForm; TombLabel: Array Of TLabel; Ertek: Boolean; Szin: Integer);
Var I : Integer;
Begin
  With Form Do
  Begin
    //ha nem kell színátmenet
    If (Ertek = False) Then
    Begin
      Form.Color:=AblakSzin.HatterSzin;
      Form.Font.Color:=AblakSzin.BetuSzin;
    End;
    //beállítja a szövegek tulajdonságait
    For I:=0 To High(TombLabel) Do
    Begin
      TombLabel[i].Transparent:=Ertek;
      TombLabel[i].Font.Color:=Szin;
    End;
  End;
End;

//beállítja a keretek színét
Procedure Bevel_Allit(Form: TForm; TombBevel: Array Of TBevel; Ertek: Boolean; Stilus: TBevelStyle);
Var I : Integer;
Begin
  With Form Do
  Begin
    //ha nem kell színátmenet
    If (Ertek = False) Then
    Begin
      Form.Color:=AblakSzin.HatterSzin;
      Form.Font.Color:=AblakSzin.BetuSzin;
    End;
    //beállítja a keret stílusát
    For I:=0 To High(TombBevel) Do TombBevel[i].Style:=Stilus;
  End;
End;

//festõ rutin
Procedure FormFesto(Form : TForm);
Var X                       : Integer;
    GradientDistance,
    GradientWidth           : Integer;
    tmpColor                : TColor;
    NewRed,NewGreen,NewBlue : Byte;
    EndRed,EndGreen,EndBlue : Byte;
Begin
  GradientDistance:=Form.Height;
  GradientWidth:=Form.Width;
  //Színösszetevõk beállítása
  EndRed:=GetRValue(AblakSzin.EndColor);
  EndBlue:=GetBValue(AblakSzin.EndColor);
  EndGreen:=GetGValue(AblakSzin.EndColor);
  //színátmenet képzése
  For X:=1 To GradientDistance Do
  Begin
    NewRed:=(X*EndRed) Div GradientDistance;
    NewBlue:=(X*EndBlue) Div GradientDistance;
    NewGreen:=(X*EndGreen) Div GradientDistance;
    tmpColor:=RGB(NewRed,NewGreen,NewBlue);
    //rajzolás
    With Form Do
    Begin
      Canvas.Pen.Color:=tmpColor;
      Canvas.MoveTo(0,X);
      Canvas.LineTo(GradientWidth,X);
    End;
  End;
End;

Begin
  //alapbeállítások
  AblakSzin.EndColor:=16744448;
  AblakSzin.BetuSzin:=clBlack;
  AblakSzin.HatterSzin:=clBtnFace;
End.
 