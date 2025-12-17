//Egy riasztó beállításának formja
Unit RiasztoBeallUnit;

Interface

Uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     StdCtrls, Buttons, ExtCtrls, FormFestoUnit, HozzaadUnit,
     BerendezesekLancUnit, RiasztoLancUnit, KapcsBerendLancUnit;

Type
  TRiasztoBeallDlg = Class(TForm)
    Bevel1      : TBevel;
    Bevel2      : TBevel;
    Label1      : TLabel;
    Label2      : TLabel;
    Label3      : TLabel;
    OKBtn       : TBitBtn;
    CancelBtn   : TBitBtn;
    ListBox1    : TListBox;
    ComboBox1   : TComboBox;
    NaplozBox   : TCheckBox;
    Button1     : TBitBtn;
    AlkalmazBtn : TButton;
    Procedure FormActivate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
    Procedure Button1Click(Sender: TObject);
    Procedure AlkalmazBtnClick(Sender: TObject);
    Procedure OKBtnClick(Sender: TObject);
    Procedure ComboBox1Change(Sender: TObject);
    Procedure NaplozBoxClick(Sender: TObject);
    Procedure Label2Click(Sender: TObject);
    Procedure CancelBtnClick(Sender: TObject);
  Private
    Modositas       : Boolean;            //volt-e módosítás
    MutTomb         : TMutatoArray;       //berendezéseket tartalmazó tömb
    RiasztoList     : TRiasztoLista;      //riasztókat tartalmazó lánc
    BerendList      : TBerendezesLista;   //berendezéseket tartalmazó lánc
    KapcsBerendList : TKapcsBerendLista;  //kapcsolatokat tartalmazó lánc
    Procedure Beallit(Naploz: Boolean);
  Public
    Property Riaszto : TRiasztoLista Write RiasztoList;
    Property BerendezesList : TBerendezesLista Write BerendList;
    Property KapcsBerendezesList : TKapcsBerendLista Write KapcsBerendList;
  End;

Var RiasztoBeallDlg : TRiasztoBeallDlg;

Implementation

{$R *.DFM}

//egy riasztóhoz kapcsolódó berendezések kiírása
Procedure TRiasztoBeallDlg.Beallit(Naploz: Boolean);
Begin
  ListBox1.Clear;
  NaplozBox.Checked:=Naploz;
  ListBox1.Items:=KapcsBerendList.KeresBerend(RiasztoList.Aktualis.RiasztoMutato);
End;

//kilépés
Procedure TRiasztoBeallDlg.CancelBtnClick(Sender: TObject);
Begin
  Close;
End;

//a form aktívvá válik
Procedure TRiasztoBeallDlg.FormActivate(Sender: TObject);
Begin
  RePaint;
  ComboBox1Change(Sender);
  Self.Modositas:=False;
  SetLength(Self.MutTomb,0);
  AlkalmazBtn.Enabled:=False;
End;

//form átfestése
Procedure TRiasztoBeallDlg.FormPaint(Sender: TObject);
Var LabelArray : Array[1..3] Of TLabel;
    BevelArray : Array[1..2] Of TBevel;
Begin
  LabelArray[1]:=Self.Label1;
  LabelArray[2]:=Self.Label2;
  LabelArray[3]:=Self.Label3;
  BevelArray[1]:=Self.Bevel1;
  BevelArray[2]:=Self.Bevel2;
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then
  Begin
    Label_Bevel_Allit(Self,LabelArray,BevelArray,True,AblakSzin.HatterSzin,bsLowered);
    //festõ meghívása
    FormFesto(Self);
  End
  Else Label_Bevel_Allit(Self,LabelArray,BevelArray,False,AblakSzin.BetuSzin,bsRaised);
End;

//kattintás a Beállítás gombra
Procedure TRiasztoBeallDlg.Button1Click(Sender: TObject);
Begin
  Self.Visible:=False;
  With HozzaadListDlg Do
  Begin
    Enabled:=True;
    Visible:=False;
    ActiveControl:=OKBtn;
    //a hozzáadás form meghívása
    If (ShowModal(BerendList,ListBox1.Items) <> idCancel) Then
    Begin
      Self.ListBox1.Items:=HozzaadListDlg.Lista;
      //tömb aktualizálása
      If (HozzaadListDlg.MutatoTomb <> Nil) Then
      Begin
        SetLength(MutTomb,High(HozzaadListDlg.MutatoTomb));
        MutTomb:=HozzaadListDlg.MutatoTomb;
      End
      Else SetLength(MutTomb,0);
      //volt-e változtatás
      Self.Modositas:=HozzaadListDlg.Valtozas;
      AlkalmazBtn.Enabled:=Self.Modositas;
    End;
    Enabled:=False;
  End;
  Self.Visible:=True;
End;

//kattintás a Rendben gombra
Procedure TRiasztoBeallDlg.OKBtnClick(Sender: TObject);
Var I      : Integer;
    Valtoz : Boolean;
Begin
  Valtoz:=False;
  //ha a lánc nem üres és van aktuális elem kiválasztva, ami módosítva lett
  If (RiasztoList <> Nil) And (ComboBox1.Text <> '') And Modositas Then
  Begin
    If (RiasztoList.Aktualis.Naplozas <> NaplozBox.Checked) Then
    Begin
      Valtoz:=True;
      RiasztoList.Aktualis.Naplozas:=NaplozBox.Checked;
    End;
    //kapcsolatok lánc frissítése
    KapcsBerendList.Kifuz(RiasztoList.Aktualis.RiasztoMutato);
    If (Self.MutTomb <> Nil) Then
    Begin
      Valtoz:=True;
      //berendezések felfûzése
      For I:=0 To High(Self.MutTomb) Do
        KapcsBerendList.Felfuz(MutTomb[I],RiasztoList.Aktualis.RiasztoMutato);
    End;
    If Valtoz Then RiasztoList.Valtozas:=True;
  End;
End;

//elem választása
Procedure TRiasztoBeallDlg.ComboBox1Change(Sender: TObject);
Var ID     : Integer;
    Mutato : PRiasztoElem;
Begin
  //azonosító keresése
  ID:=BerendList.KeresNev(ComboBox1.Items[ComboBox1.ItemIndex]);
  //azonosító alapján a mutató megkeresése
  If RiasztoList.KeresID(ID,Mutato) Then
  Begin
    RiasztoList.Aktualis:=Mutato;
    //tulajdonságok frissítése
    Beallit(Mutato.Naplozas);
  End;
  Self.Modositas:=False;
  AlkalmazBtn.Enabled:=False;
End;

//kattintás a naplózás CheckBox-ra
Procedure TRiasztoBeallDlg.NaplozBoxClick(Sender: TObject);
Begin
  Self.Modositas:=True;
  AlkalmazBtn.Enabled:=True;
End;

//kattintás a naplózás feliratra
Procedure TRiasztoBeallDlg.Label2Click(Sender: TObject);
Begin
  NaplozBox.Checked:=Not NaplozBox.Checked;
  NaplozBoxClick(Sender);
End;

//kattintás az Alkalmaz gombra
Procedure TRiasztoBeallDlg.AlkalmazBtnClick(Sender: TObject);
Begin
  OKBtnClick(Sender);
  AlkalmazBtn.Enabled:=False;
  Self.Modositas:=False;
End;

End.
