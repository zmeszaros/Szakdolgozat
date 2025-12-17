//Egy hõmérõ beállításának formja
Unit HomeroBeallUnit;

Interface

Uses SysUtils, Classes, Controls, Forms, ExtCtrls, ComCtrls,
     StdCtrls, FormFestoUnit, UtilUnit, Buttons, Spin, Windows,
     BerendezesekLancUnit, HomeroLancUnit, HozzaadUnit, KapcsBerendLancUnit;

Type
  THomeroBeallDlg = Class(TForm)
    Bevel2      : TBevel;
    Label1      : TLabel;
    Bevel1      : TBevel;
    Label4      : TLabel;
    Label5      : TLabel;
    ComboBox1   : TComboBox;
    OKBtn       : TBitBtn;
    Panel1      : TPanel;
    Bevel4      : TBevel;
    Bevel3      : TBevel;
    FokLabel    : TLabel;
    MaxLabel    : TLabel;
    MinLabel    : TLabel;
    Label2      : TLabel;
    MaxFokLabel : TLabel;
    MinFokLabel : TLabel;
    Label3      : TLabel;
    HomeroBar   : TTrackBar;
    MaxEdit     : TSpinEdit;
    MinEdit     : TSpinEdit;
    CancelBtn   : TBitBtn;
    NaplozBox   : TCheckBox;
    ListBox1    : TListBox;
    Button1     : TBitBtn;
    AlkalmazBtn : TButton;
    Procedure FormActivate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
    Procedure HomeroBarChange(Sender: TObject);
    Procedure MaxEditChange(Sender: TObject);
    Procedure MinEditChange(Sender: TObject);
    Procedure OKBtnClick(Sender: TObject);
    Procedure Button1Click(Sender: TObject);
    Procedure ComboBox1Change(Sender: TObject);
    Procedure NaplozBoxClick(Sender: TObject);
    Procedure Label4Click(Sender: TObject);
    Procedure AlkalmazBtnClick(Sender: TObject);
    Procedure CancelBtnClick(Sender: TObject);
  Private
    Ertek           : Integer;             //beállított érték
    RegiMaxValue    : Integer;             //módosítás elõtti max érték
    RegiMinValue    : Integer;             //módosítás elõtti min érték
    Modositas       : Boolean;             //volt-e módosítás
    HomeroList      : THomeroLista;        //hõmérõket tartalmazó lánc
    MutTomb         : TMutatoArray;        //berendezéseket tartalmazó tömb
    BerendList      : TBerendezesLista;    //berendezéseket tartalmazó lánc
    KapcsBerendList : TKapcsBerendLista;   //kapcsolatokat tartalmazó lánc
    Procedure Beallit(Min,Max,Ert: Integer; Naploz: Boolean);
  Public
    Property Homero : THomeroLista Write HomeroList;
    Property BerendezesList : TBerendezesLista Write BerendList;
    Property KapcsBerendezesList : TKapcsBerendLista Write KapcsBerendList;
  End;

Var HomeroBeallDlg : THomeroBeallDlg;

Implementation

{$R *.DFM}

//egy hõmérõhöz kapcsolódó berendezések és tulajdonságok kiírása
Procedure THomeroBeallDlg.Beallit(Min,Max,Ert: Integer; Naploz: Boolean);
Begin
  ListBox1.Clear;
  Self.Ertek:=Ert;
  MinEdit.Value:=Min;
  MaxEdit.Value:=Max;
  HomeroBar.Position:=(Max-Ert+Min);
  NaplozBox.Checked:=Naploz;
  FokLabel.Caption:=IntToStr(Self.Ertek)+sCelsius;
  HomeroBar.Max:=MaxEdit.Value;
  HomeroBar.Min:=MinEdit.Value;
  Self.RegiMaxValue:=MaxEdit.Value;
  Self.RegiMinValue:=MinEdit.Value;
  FokLabel.Caption:=IntToStr(Self.Ertek)+sCelsius;
  MaxFokLabel.Caption:=IntToStr(MaxEdit.Value)+sCelsius;
  MinFokLabel.Caption:=IntToStr(MinEdit.Value)+sCelsius;
  ListBox1.Items:=KapcsBerendList.KeresBerend(HomeroList.Aktualis.HomeroMutato);
End;

//kilépés
Procedure THomeroBeallDlg.CancelBtnClick(Sender: TObject);
Begin
  Close;
End;

//a form aktívvá válik
Procedure THomeroBeallDlg.FormActivate(Sender: TObject);
Begin
  RePaint;
  ComboBox1Change(Sender);
  Self.Modositas:=False;
  SetLength(Self.MutTomb,0);
  //tömb feltöltése
  If (ListBox1.Items.Count > 0) Then
    MutTomb:=KapcsBerendList.MiKapcs(HomeroList.Aktualis.HomeroMutato);
  AlkalmazBtn.Enabled:=False;
End;

//form átfestése
Procedure THomeroBeallDlg.FormPaint(Sender: TObject);
Var LabelArray : Array[1..3] Of TLabel;
    BevelArray : Array[1..4] Of TBevel;
Begin
  LabelArray[1]:=Self.Label1;
  LabelArray[2]:=Self.Label4;
  LabelArray[3]:=Self.Label5;
  BevelArray[1]:=Self.Bevel1;
  BevelArray[2]:=Self.Bevel2;
  BevelArray[3]:=Self.Bevel3;
  BevelArray[4]:=Self.Bevel4;
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then
  Begin
    Label_Bevel_Allit(HomeroBeallDlg,LabelArray,BevelArray,True,AblakSzin.HatterSzin,bsLowered);
    //festõ meghívása
    FormFesto(HomeroBeallDlg);
  End
  Else Label_Bevel_Allit(HomeroBeallDlg,LabelArray,BevelArray,False,AblakSzin.BetuSzin,bsRaised);
End;

//beállított érték változtatása
Procedure THomeroBeallDlg.HomeroBarChange(Sender: TObject);
Begin
  Self.Modositas:=True;
  AlkalmazBtn.Enabled:=True;
  //új érték kiszámítása
  Ertek:=(HomeroBar.Max-HomeroBar.Position+HomeroBar.Min);
  FokLabel.Caption:=IntToStr(Ertek)+sCelsius;
  HomeroBar.SelStart:=HomeroBar.Position;
  HomeroBar.SelEnd:=HomeroBar.Max;
End;

//hõmérõ mérési maximumának változása
Procedure THomeroBeallDlg.MaxEditChange(Sender: TObject);
Begin
  Self.Modositas:=True;
  AlkalmazBtn.Enabled:=True;
  If (MaxEdit.Value > MinEdit.Value) And (Ertek <= MaxEdit.Value) Then
  Begin
    HomeroBar.Max:=MaxEdit.Value;
    If (RegiMaxValue > MaxEdit.Value) Then HomeroBar.Position:=HomeroBar.Position-1
      Else HomeroBar.Position:=HomeroBar.Position+1;
    MaxFokLabel.Caption:=IntToStr(MaxEdit.Value)+sCelsius;
    RegiMaxValue:=MaxEdit.Value;
  End
  Else MaxEdit.Value:=HomeroBar.Max;
End;

//hõmérõ mérési minimumának változása
Procedure THomeroBeallDlg.MinEditChange(Sender: TObject);
Begin
  Self.Modositas:=True;
  AlkalmazBtn.Enabled:=True;
  If (MinEdit.Value < MaxEdit.Value) And (Ertek >= MinEdit.Value) Then
  Begin
    HomeroBar.Min:=MinEdit.Value;
    If (RegiMinValue < MinEdit.Value) Then HomeroBar.Position:=HomeroBar.Position+1
      Else HomeroBar.Position:=HomeroBar.Position-1;
    MinFokLabel.Caption:=IntToStr(MinEdit.Value)+sCelsius;
    RegiMinValue:=MinEdit.Value;
  End
  Else MinEdit.Value:=HomeroBar.Min;
End;

//kattintás a Rendben gombra
Procedure THomeroBeallDlg.OKBtnClick(Sender: TObject);
Var I      : Integer;
    Valtoz : Boolean;
Begin
  Valtoz:=False;
  //ha a lánc nem üres és van aktuális elem kiválasztva, ami módosítva lett
  If (HomeroList <> Nil) And (ComboBox1.Text <> '') And Modositas Then
  Begin
    If (HomeroList.Aktualis.Min <> MinEdit.Value) Then
    Begin
      Valtoz:=True;
      HomeroList.Aktualis.Min:=MinEdit.Value;
    End;
    If (HomeroList.Aktualis.Max <> MaxEdit.Value) Then
    Begin
      Valtoz:=True;
      HomeroList.Aktualis.Max:=MaxEdit.Value;
    End;
    If (HomeroList.Aktualis.BeallErtek <> Ertek) Then
    Begin
      Valtoz:=True;
      HomeroList.Aktualis.BeallErtek:=Ertek;
    End;
    If (HomeroList.Aktualis.Naplozas <> NaplozBox.Checked) Then
    Begin
      Valtoz:=True;
      HomeroList.Aktualis.Naplozas:=NaplozBox.Checked;
    End;
    //kapcsolatok lánc frissítése
    KapcsBerendList.Kifuz(HomeroList.Aktualis.HomeroMutato);
    If (Self.MutTomb <> Nil) Then
    Begin
      Valtoz:=True;
      //berendezések felfûzése
      For I:=0 To High(Self.MutTomb) Do
        KapcsBerendList.Felfuz(MutTomb[I],HomeroList.Aktualis.HomeroMutato);
    End;
    If Valtoz Then HomeroList.Valtozas:=True;
  End;
End;

//kattintás a Beállítás gombra
Procedure THomeroBeallDlg.Button1Click(Sender: TObject);
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

//elem választása
Procedure THomeroBeallDlg.ComboBox1Change(Sender: TObject);
Var ID     : Integer;
    Mutato : PHomeroElem;
Begin
  //azonosító keresése
  ID:=BerendList.KeresNev(ComboBox1.Items[ComboBox1.ItemIndex]);
  //azonosító alapján a mutató megkeresése
  If HomeroList.KeresID(ID,Mutato) Then
  Begin
    HomeroList.Aktualis:=Mutato;
    //tulajdonságok frissítése
    Beallit(Mutato.Min,Mutato.Max,Mutato.BeallErtek,Mutato.Naplozas);
  End;
  Self.Modositas:=False;
  AlkalmazBtn.Enabled:=False;
End;

//kattintás a naplózás CheckBox-ra
Procedure THomeroBeallDlg.NaplozBoxClick(Sender: TObject);
Begin
  Self.Modositas:=True;
  AlkalmazBtn.Enabled:=True;
End;

//kattintás a naplózás feliratra
Procedure THomeroBeallDlg.Label4Click(Sender: TObject);
Begin
  NaplozBox.Checked:=Not NaplozBox.Checked;
  NaplozBoxClick(Sender);
End;

//kattintás az Alkalmaz gombra
Procedure THomeroBeallDlg.AlkalmazBtnClick(Sender: TObject);
Begin
  OKBtnClick(Sender);
  AlkalmazBtn.Enabled:=False;
  Self.Modositas:=False;
End;

End.
