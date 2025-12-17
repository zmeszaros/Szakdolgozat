//beállítások dialog box
Unit BeallitUnit;

Interface

Uses Classes, Forms, Controls, StdCtrls, Buttons,
     ExtCtrls, Spin, ComCtrls, FormFestoUnit;

Type
  TDlgBeallit = Class(TForm)
    Bevel1         : TBevel;
    Bevel2         : TBevel;
    Bevel3         : TBevel;
    Bevel4         : TBevel;
    Label1         : TLabel;
    Label2         : TLabel;
    Label3         : TLabel;
    Label4         : TLabel;
    OKBtn          : TBitBtn;
    CancelBtn      : TBitBtn;
    SarokEdit      : TSpinEdit;
    AblakEdit      : TSpinEdit;
    SzinAtmenetBox : TCheckBox;
    Procedure FormPaint(Sender: TObject);
    Procedure FormActivate(Sender: TObject);
    Procedure Label3Click(Sender: TObject);
  End;

Var DlgBeallit : TDlgBeallit;

Implementation

{$R *.DFM}

//form átfestése
Procedure TDlgBeallit.FormPaint(Sender: TObject);
Var LabelArray : Array[1..4] Of TLabel;
    BevelArray : Array[1..4] Of TBevel;
Begin
  LabelArray[1]:=Self.Label1;
  LabelArray[2]:=Self.Label2;
  LabelArray[3]:=Self.Label3;
  LabelArray[4]:=Self.Label4;
  BevelArray[1]:=Self.Bevel1;
  BevelArray[2]:=Self.Bevel2;
  BevelArray[3]:=Self.Bevel3;
  BevelArray[4]:=Self.Bevel4;
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then
  Begin
    //beállítjuk a feliratok és a keretek színét
    Label_Bevel_Allit(DlgBeallit,LabelArray,BevelArray,True,AblakSzin.HatterSzin,bsLowered);
    //festõ meghívása
    FormFesto(DlgBeallit);
  End
  Else Label_Bevel_Allit(DlgBeallit,LabelArray,BevelArray,False,AblakSzin.BetuSzin,bsRaised);
End;

//a form aktívvá válik
Procedure TDlgBeallit.FormActivate(Sender: TObject);
Begin
  RePaint;
End;

//kattintás a szövegen
Procedure TDlgBeallit.Label3Click(Sender: TObject);
Begin
  SzinAtmenetBox.Checked:=Not SzinAtmenetBox.Checked;
End;

End.
