//Névjegy dialog box
Unit AboutUnit;

Interface

Uses Classes, Graphics, Forms, Controls, StdCtrls, Buttons, ExtCtrls,
     FormFestoUnit, GradientLabel;

Type
  TAboutBox = Class(TForm)
    Label1   : TGradientLabel;
    Label2   : TLabel;
    Label3   : TLabel;
    Label4   : TLabel;
    Label5   : TLabel;
    Bevel1   : TBevel;
    MyIcon   : TImage;
    OKButton : TButton;
    Procedure OKButtonClick(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
    Procedure FormActivate(Sender: TObject);
  End;

Var AboutBox : TAboutBox;

Implementation

{$R *.DFM}

//ablak bezárása
Procedure TAboutBox.OKButtonClick(Sender: TObject);
Begin
  Close;
End;

//form átfestése
Procedure TAboutBox.FormPaint(Sender: TObject);
Var LabelArray : Array[1..4] Of TLabel;
    BevelArray : Array[1..1] Of TBevel;
Begin
  LabelArray[1]:=Self.Label2;
  LabelArray[2]:=Self.Label3;
  LabelArray[3]:=Self.Label4;
  LabelArray[4]:=Self.Label5;
  BevelArray[1]:=Self.Bevel1;
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then
  Begin
    //beállítjuk a feliratok és a keretek színét
    Label_Bevel_Allit(AboutBox,LabelArray,BevelArray,True,AblakSzin.HatterSzin,bsLowered);
    //festõ meghívása
    FormFesto(AboutBox);
  End
  Else Label_Bevel_Allit(AboutBox,LabelArray,BevelArray,False,AblakSzin.BetuSzin,bsRaised);
End;

//a form aktívvá válik
Procedure TAboutBox.FormActivate(Sender: TObject);
Begin
  RePaint;
End;

End.

