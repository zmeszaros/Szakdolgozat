//ajtó dialog box
Unit AjtoUnit;

Interface

Uses Classes, Forms, Controls, StdCtrls, Buttons, ExtCtrls, FormFestoUnit;

Type
  TAjtoBeallDlg = Class(TForm)
    OKBtn            : TButton;
    CancelBtn        : TButton;
    Panel1           : TPanel;
    JobbosButton     : TRadioButton;
    BalosButton      : TRadioButton;
    KetszarnyuButton : TRadioButton;
    Label1           : TLabel;
    Procedure FormPaint(Sender: TObject);
    Procedure FormActivate(Sender: TObject);
  End;

Var AjtoBeallDlg : TAjtoBeallDlg;

Implementation

{$R *.DFM}

//form átfestése
Procedure TAjtoBeallDlg.FormPaint(Sender: TObject);
Var LabelArray : Array[1..1] Of TLabel;
Begin
  LabelArray[1]:=Label1;
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then
  Begin
    //beállítjuk a feliratok színét
    Label_Allit(AjtoBeallDlg,LabelArray,True,AblakSzin.HatterSzin);
    //festõ meghívása
    FormFesto(AjtoBeallDlg);
  End
  Else Label_Allit(AjtoBeallDlg,LabelArray,False,AblakSzin.BetuSzin);
End;

//a form aktívvá válik
Procedure TAjtoBeallDlg.FormActivate(Sender: TObject);
Begin
  RePaint;
End;

End.
