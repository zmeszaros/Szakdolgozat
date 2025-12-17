//Az InditasDlg dialog box eljárásai
Unit InditUnit;

Interface

Uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     StdCtrls, ExtCtrls, FormFestoUnit;

Type
  TInditasDlg = Class(TForm)
    Label1 : TLabel;
    Bevel1 : TBevel;
    Memo1  : TMemo;
    Procedure FormActivate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
  End;

Var InditasDlg : TInditasDlg;

Implementation

{$R *.DFM}

//a form aktívvá válik
Procedure TInditasDlg.FormActivate(Sender: TObject);
Begin
  RePaint;
  UpDate;
End;

//form átfestése
Procedure TInditasDlg.FormPaint(Sender: TObject);
Var LabelArray : Array[1..1] Of TLabel;
    BevelArray : Array[1..1] Of TBevel;
Begin
  LabelArray[1]:=Label1;
  BevelArray[1]:=Bevel1;
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then
  Begin
    //beállítjuk a feliratok és a keretek színét
    Label_Bevel_Allit(InditasDlg,LabelArray,BevelArray,True,AblakSzin.HatterSzin,bsLowered);
    //festõ meghívása
    FormFesto(InditasDlg);
  End
  Else Label_Bevel_Allit(InditasDlg,LabelArray,BevelArray,False,AblakSzin.BetuSzin,bsRaised);
End;

End.
