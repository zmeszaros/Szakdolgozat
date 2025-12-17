//A tollal kapcsolatos eljárások
Unit PenUnit;

Interface

Uses ExtCtrls,Forms,Graphics,RajzolasUnit;

Type
  //a toll tulajdonságainak tárolása
  TRegiPenStyle = Object
    Stilus : TPenStyle;
    Szin   : TColor;
    Meret  : Integer;
    Procedure Ment(Form : TForm; Image : TImage);
    Procedure Vissza(Form : TForm; Image : TImage);
  End;

Procedure GetPenStyle(Const Form : TForm;Const Image : TImage);
Procedure SetPenStyle(Const Form : TForm;Const Image : TImage;
          Const Stilus : TPenStyle;Const Szin : TColor;Const Meret : Integer);
Procedure AlapPenBeallit(Const Form : TForm;Const Image : TImage);

Implementation

//toll tulajdonságainak mentése
Procedure TRegiPenStyle.Ment(Form : TForm; Image : TImage);
Begin
  //toll tulajdonságainak lekérdezése
  GetPenStyle(Form,Image);
  Stilus:=EpuletTul.PS;
  Szin:=EpuletTul.PC;
  Meret:=EpuletTul.PM;
End;

//toll tulajdonságainak visszaállítása
Procedure TRegiPenStyle.Vissza(Form : TForm; Image : TImage);
Begin
  //toll tulajdonságainak visszaállítása a paraméterek szerint
  SetPenStyle(Form,Image,Stilus,Szin,Meret);
End;

//toll tulajdonságainak visszaállítása a paraméterek szerint
Procedure SetPenStyle(Const Form: TForm; Const Image: TImage;
          Const Stilus: TPenStyle; Const Szin: TColor; Const Meret: Integer);
Begin
  With Form Do
    With Image.Canvas Do
    Begin
      //toll beállítása
      Pen.Style:=Stilus;
      Pen.Width:=Meret;
      Pen.Color:=Szin;
      //toll tulajdonságainak lekérdezése
      GetPenStyle(Form,Image);
    End;
End;

//toll tulajdonságainak lekérdezése
Procedure GetPenStyle(Const Form : TForm; Const  Image : TImage);
Begin
  With Form Do
    With Image.Canvas Do
    Begin
      EpuletTul.PS:=Pen.Style;
      EpuletTul.PM:=Pen.Width;
      EpuletTul.PC:=Pen.Color;
    End;
End;

//toll alap tulajdonságainak beállítása
Procedure AlapPenBeallit(Const Form : TForm;Const Image : TImage);
Begin
  With Form Do
    With Image.Canvas Do
    Begin
      Pen.Style:=psSolid;
      Pen.Width:=1;
      Pen.Color:=clBlack;
      //toll tulajdonságainak lekérdezése
      GetPenStyle(Form,Image);
    End;
End;

End.
 