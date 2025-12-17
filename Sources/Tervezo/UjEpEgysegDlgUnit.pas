//Új épületegység felvétele
Unit UjEpEgysegDlgUnit;

Interface

Uses Windows, Dialogs, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
     Buttons, ExtCtrls, FormFestoUnit, EpuletLancUnit;

Type
  TUjEpEgysegDlg = Class(TForm)
    Label1: TLabel;
    EgysegNevEdit: TEdit;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Procedure OKBtnClick(Sender: TObject);
    Procedure FormActivate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
  Private
    EpLista : TEpuletLista;  //épület lánc
  Public
    Function ShowModal(Const EL: TEpuletLista) : Integer; Reintroduce; Overload;
  End;

Var UjEpEgysegDlg : TUjEpEgysegDlg;

Implementation

{$R *.DFM}

//form megjelenítése
Function TUjEpEgysegDlg.ShowModal(Const EL: TEpuletLista) : Integer;
Begin
  EpLista:=EL;
  Result:=Inherited ShowModal;
End;

//rendben gomb eseménykezelõje
Procedure TUjEpEgysegDlg.OKBtnClick(Sender: TObject);
Begin
  //ha üres a beviteli mezõ
  If (EgysegNevEdit.Text = '') Then
  Begin
    ModalResult:=mrNone;
    ActiveControl:=EgysegNevEdit;
    Exit;
  End;
  //név ellenõrzés
  If EpLista.EgysegKeresNev(EgysegNevEdit.Text) Then
  Begin
    MessageDlg('A(z) '+EgysegNevEdit.Text+' név már létezik!',mtError,[mbOK],0);
    ModalResult:=mrNone;
    ActiveControl:=EgysegNevEdit;
  End;
End;

//a form aktívvá válik
Procedure TUjEpEgysegDlg.FormActivate(Sender: TObject);
Begin
  EgysegNevEdit.Text:='';
  RePaint;
End;

//form átfestése
Procedure TUjEpEgysegDlg.FormPaint(Sender: TObject);
Var LabelArray : Array[1..1] Of TLabel;
Begin
  LabelArray[1]:=Self.Label1;
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then
  Begin
    //beállítjuk a feliratok és keretek színét
    Label_Allit(UjEpEgysegDlg,LabelArray,True,AblakSzin.HatterSzin);
    //festõ meghívása
    FormFesto(UjEpEgysegDlg);
  End
  Else Label_Allit(UjEpEgysegDlg,LabelArray,False,AblakSzin.BetuSzin);
End;

end.
