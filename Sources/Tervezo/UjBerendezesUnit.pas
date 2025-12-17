//Új berendezés hozzáadása Dialog box
Unit UjBerendezesUnit;

Interface

Uses Classes, Controls, Forms, ExtCtrls, StdCtrls, Buttons, Dialogs,
     BerendezesekLancUnit, FormFestoUnit;

Type
  TUjBerendDlg = Class(TForm)
    Label1           : TLabel;
    Label2           : TLabel;
    Bevel1           : TBevel;
    BerendezesEdit   : TEdit;
    OKBtn            : TBitBtn;
    CancelBtn        : TBitBtn;
    ObjektumComboBox : TComboBox;
    Procedure Set_Lista(Lanc: TBerendezesLista);
    Procedure FormActivate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
    Procedure OKBtnClick(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure FormShow(Sender: TObject);
  Private
    Lista : TBerendezesLista;  //berendezés lánc
  End;

Var UjBerendDlg : TUjBerendDlg;

Implementation

{$R *.DFM}

//berendezés lánc beállítása
Procedure TUjBerendDlg.Set_Lista(Lanc: TBerendezesLista);
Begin
  Self.Lista:=Lanc;
End;

//a form aktívvá válik
Procedure TUjBerendDlg.FormActivate(Sender: TObject);
Begin
  RePaint;
End;

//form átfestése
Procedure TUjBerendDlg.FormPaint(Sender: TObject);
Var LabelArray : Array[1..2] Of TLabel;
    BevelArray : Array[1..1] Of TBevel;
Begin
  LabelArray[1]:=Self.Label1;
  LabelArray[2]:=Self.Label2;
  BevelArray[1]:=Self.Bevel1;
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then
  Begin
    //beállítjuk a feliratok és keretek színét
    Label_Bevel_Allit(UjBerendDlg,LabelArray,BevelArray,True,AblakSzin.HatterSzin,bsLowered);
    //festõ meghívása
    FormFesto(UjBerendDlg);
  End
  Else Label_Bevel_Allit(UjBerendDlg,LabelArray,BevelArray,False,AblakSzin.BetuSzin,bsRaised);
End;

//rendben gomb eseménykezelõje
Procedure TUjBerendDlg.OKBtnClick(Sender: TObject);
Begin
  //ha valamelyik üres
  If ((BerendezesEdit.Text = '') Or (ObjektumComboBox.Text = '')) Then
  Begin
    Self.ActiveControl:=BerendezesEdit;
    ModalResult:=mrNone;
    Exit;
  End;
  //ha van már azonos nevû berendezés
  If Self.Lista.Keres(BerendezesEdit.Text) Then
  Begin
    MessageDlg('Ez a név már létezik!',mtError,[mbOK],0);
    ModalResult:=mrNone;
  End;
End;

//form létrehozása
Procedure TUjBerendDlg.FormCreate(Sender: TObject);
Begin
  Lista:=Nil;
End;

//form megjelenítése
Procedure TUjBerendDlg.FormShow(Sender: TObject);
Begin
  BerendezesEdit.Text:='';
  ObjektumComboBox.Text:=ObjektumComboBox.Items.Strings[0];
  ObjektumComboBox.ItemIndex:=0;
End;

End.
