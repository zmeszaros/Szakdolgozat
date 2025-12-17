//Forgatás dialog box
Unit ForgatUnit;

Interface

Uses SysUtils, Classes, Forms, Controls, StdCtrls,
     Buttons, ExtCtrls, Spin, FormFestoUnit;

Type
  TDlgForgatas = Class(TForm)
    Panel1         : TPanel;
    Panel2         : TPanel;
    Bevel1         : TBevel;
    Bevel2         : TBevel;
    Bevel3         : TBevel;
    Bevel4         : TBevel;
    Bevel5         : TBevel;
    Bevel6         : TBevel;
    Label1         : TLabel;
    Label2         : TLabel;
    Label3         : TLabel;
    Label4         : TLabel;
    Label5         : TLabel;
    OKBtn          : TButton;
    CancelBtn      : TButton;
    FokEdit        : TSpinEdit;
    Fok5Button     : TRadioButton;
    Fok10Button    : TRadioButton;
    Fok15Button    : TRadioButton;
    Fok20Button    : TRadioButton;
    Fok25Button    : TRadioButton;
    Fok30Button    : TRadioButton;
    Fok35Button    : TRadioButton;
    Fok40Button    : TRadioButton;
    Fok45Button    : TRadioButton;
    Fok90Button    : TRadioButton;
    Fok180Button   : TRadioButton;
    OraPlusButton  : TRadioButton;
    OraMinusButton : TRadioButton;
    BFButton       : TRadioButton;
    JFButton       : TRadioButton;
    BAButton       : TRadioButton;
    JAButton       : TRadioButton;
    KPButton       : TRadioButton;
    Procedure FormPaint(Sender: TObject);
    Procedure FormActivate(Sender: TObject);
    Procedure FokEditChange(Sender: TObject);
    Procedure BFButtonClick(Sender: TObject);
    Procedure JFButtonClick(Sender: TObject);
    Procedure KPButtonClick(Sender: TObject);
    Procedure BAButtonClick(Sender: TObject);
    Procedure JAButtonClick(Sender: TObject);
    Procedure Fok5ButtonClick(Sender: TObject);
    Procedure Fok10ButtonClick(Sender: TObject);
    Procedure Fok15ButtonClick(Sender: TObject);
    Procedure Fok20ButtonClick(Sender: TObject);
    Procedure Fok25ButtonClick(Sender: TObject);
    Procedure Fok30ButtonClick(Sender: TObject);
    Procedure Fok35ButtonClick(Sender: TObject);
    Procedure Fok40ButtonClick(Sender: TObject);
    Procedure Fok45ButtonClick(Sender: TObject);
    Procedure Fok90ButtonClick(Sender: TObject);
    Procedure Fok180ButtonClick(Sender: TObject);
  Private
    Procedure MindUres;
  End;

Var DlgForgatas : TDlgForgatas;

Implementation

{$R *.DFM}

//form átfestése
Procedure TDlgForgatas.FormPaint(Sender: TObject);
Var LabelArray : Array[1..5] Of TLabel;
    BevelArray : Array[1..6] Of TBevel;
Begin
  LabelArray[1]:=Self.Label1;
  LabelArray[2]:=Self.Label2;
  LabelArray[3]:=Self.Label3;
  LabelArray[4]:=Self.Label4;
  LabelArray[5]:=Self.Label5;
  BevelArray[1]:=Self.Bevel1;
  BevelArray[2]:=Self.Bevel2;
  BevelArray[3]:=Self.Bevel3;
  BevelArray[4]:=Self.Bevel4;
  BevelArray[5]:=Self.Bevel5;
  BevelArray[6]:=Self.Bevel6;
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then
  Begin
    //beállítjuk a feliratok és keretek színét
    Label_Bevel_Allit(DlgForgatas,LabelArray,BevelArray,True,AblakSzin.HatterSzin,bsLowered);
    //festõ meghívása
    FormFesto(DlgForgatas);
  End
  Else Label_Bevel_Allit(DlgForgatas,LabelArray,BevelArray,False,AblakSzin.BetuSzin,bsRaised);
End;

//a form aktívvá válik
Procedure TDlgForgatas.FormActivate(Sender: TObject);
Begin
  RePaint;
End;

//a kijelöléseket elvesszük
Procedure TDlgForgatas.MindUres;
Begin
  Fok5Button.Checked:=False;
  Fok10Button.Checked:=False;
  Fok15Button.Checked:=False;
  Fok20Button.Checked:=False;
  Fok25Button.Checked:=False;
  Fok30Button.Checked:=False;
  Fok35Button.Checked:=False;
  Fok40Button.Checked:=False;
  Fok45Button.Checked:=False;
  Fok90Button.Checked:=False;
  Fok180Button.Checked:=False;
End;

//forgatási szög változása
Procedure TDlgForgatas.FokEditChange(Sender: TObject);
Begin
  Try
    Case FokEdit.Value Of
        5 : Fok5Button.Checked:=True;
       10 : Fok10Button.Checked:=True;
       15 : Fok15Button.Checked:=True;
       20 : Fok20Button.Checked:=True;
       25 : Fok25Button.Checked:=True;
       30 : Fok30Button.Checked:=True;
       35 : Fok35Button.Checked:=True;
       40 : Fok40Button.Checked:=True;
       45 : Fok45Button.Checked:=True;
       90 : Fok90Button.Checked:=True;
      180 : Fok180Button.Checked:=True;
      Else MindUres;
    End;
  Except
    On EConvertError Do FokEdit.Value:=0;
  End;
End;

Procedure TDlgForgatas.Fok5ButtonClick(Sender: TObject);
Begin
  If Fok5Button.Checked Then FokEdit.Value:=5;
End;

Procedure TDlgForgatas.Fok10ButtonClick(Sender: TObject);
Begin
  If Fok10Button.Checked Then FokEdit.Value:=10;
End;

Procedure TDlgForgatas.Fok15ButtonClick(Sender: TObject);
Begin
  If Fok15Button.Checked Then FokEdit.Value:=15;
End;

Procedure TDlgForgatas.Fok20ButtonClick(Sender: TObject);
Begin
  If Fok20Button.Checked Then FokEdit.Value:=20;
End;

Procedure TDlgForgatas.Fok25ButtonClick(Sender: TObject);
Begin
  If Fok25Button.Checked Then FokEdit.Value:=25;
End;

Procedure TDlgForgatas.Fok30ButtonClick(Sender: TObject);
Begin
  If Fok30Button.Checked Then FokEdit.Value:=30;
End;

Procedure TDlgForgatas.Fok35ButtonClick(Sender: TObject);
Begin
  If Fok35Button.Checked Then FokEdit.Value:=35;
End;

Procedure TDlgForgatas.Fok40ButtonClick(Sender: TObject);
Begin
  If Fok40Button.Checked Then FokEdit.Value:=40;
End;

Procedure TDlgForgatas.Fok45ButtonClick(Sender: TObject);
Begin
  If Fok45Button.Checked Then FokEdit.Value:=45;
End;

Procedure TDlgForgatas.Fok90ButtonClick(Sender: TObject);
Begin
  If Fok90Button.Checked Then FokEdit.Value:=90;
End;

Procedure TDlgForgatas.Fok180ButtonClick(Sender: TObject);
Begin
  If Fok180Button.Checked Then FokEdit.Value:=180;
End;

Procedure TDlgForgatas.BFButtonClick(Sender: TObject);
Begin
  Label5.Caption:='Balfelsõ pont körüli elforgatás';
End;

Procedure TDlgForgatas.JFButtonClick(Sender: TObject);
Begin
  Label5.Caption:='Jobbfelsõ pont körüli elforgatás';
End;

Procedure TDlgForgatas.KPButtonClick(Sender: TObject);
Begin
  Label5.Caption:='Középpont körüli elforgatás';
End;

Procedure TDlgForgatas.BAButtonClick(Sender: TObject);
Begin
  Label5.Caption:='Balalsó pont körüli elforgatás';
End;

Procedure TDlgForgatas.JAButtonClick(Sender: TObject);
Begin
  Label5.Caption:='Jobbalsó pont körüli elforgatás';
End;

End.
