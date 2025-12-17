//Riasztást nyugtázó form
Unit NyugtaDlgUnit;

Interface

Uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
     Buttons, ExtCtrls, FormFestoUnit;

Type
  TNyugtaDlg = Class(TForm)
    OKBtn : TButton;
    Procedure FormActivate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
    Procedure OKBtnClick(Sender: TObject);
  End;

Var NyugtaDlg : TNyugtaDlg;

Implementation

Uses VezerloUnit;

{$R *.DFM}

//a form aktívvá válik
Procedure TNyugtaDlg.FormActivate(Sender: TObject);
Begin
  RePaint;
End;

//form átfestése
Procedure TNyugtaDlg.FormPaint(Sender: TObject);
Begin
  If AblakSzin.SzinAtmenet Then FormFesto(NyugtaDlg);
End;

//kattintás a gombra
Procedure TNyugtaDlg.OKBtnClick(Sender: TObject);
Begin
  With FormVezerlo Do
  Begin
    RiasztasokNyugat;
    VanHang.Enabled:=False;
  End;
  Close;
End;

End.
