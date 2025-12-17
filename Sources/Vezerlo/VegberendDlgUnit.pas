//Egy végberendezés beállításának formja
Unit VegberendDlgUnit;

Interface

Uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     Gomb, StdCtrls, Buttons, ExtCtrls, FormFestoUnit, ComCtrls, KuldThreadUnit,
     BerendezesekLancUnit, KapcsBerendLancUnit, VegBerendLancUnit, KodolasUnit;

Type
  TVegberendDlg = Class(TForm)
    OKBtn       : TBitBtn;
    CancelBtn   : TBitBtn;
    Kapcsolo1   : TKapcsolo;
    Label1      : TLabel;
    Bevel1      : TBevel;
    Label2      : TLabel;
    ComboBox1   : TComboBox;
    NaplozBox   : TCheckBox;
    Label3      : TLabel;
    Kapcsolo2   : TKapcsolo;
    Label4      : TLabel;
    Bevel2      : TBevel;
    Bevel3      : TBevel;
    Label5      : TLabel;
    Label6      : TLabel;
    ListBox1    : TListBox;
    StatusBar1  : TStatusBar;
    AlkalmazBtn : TButton;
    Procedure CancelBtnClick(Sender: TObject);
    Procedure FormActivate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
    Procedure Kapcsolo1MouseDown(Sender: TObject; Button: TMouseButton;
              Shift: TShiftState; X, Y: Integer);
    Procedure Kapcsolo2MouseDown(Sender: TObject; Button: TMouseButton;
              Shift: TShiftState; X, Y: Integer);
    Procedure NaplozBoxClick(Sender: TObject);
    Procedure Label2Click(Sender: TObject);
    Procedure OKBtnClick(Sender: TObject);
    Procedure AlkalmazBtnClick(Sender: TObject);
    Procedure ComboBox1Change(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
  Protected
    Modositas       : Boolean;             //volt-e módosítás
    VegberendList   : TVegBerendLista;     //végberendezéseket tartalmazó lánc
    BerendList      : TBerendezesLista;    //berendezéseket tartalmazó lánc
    KapcsBerendList : TKapcsBerendLista;   //kapcsolatokat tartalmazó lánc
    Function AllapotString : String;
    Procedure Beallit(Naploz,Kapcs1,Kapcs2: Boolean);
  Public
    Property BerendezesList : TBerendezesLista Write BerendList;
    Property VegberendezesList : TVegBerendLista Write VegberendList;
    Property KapcsBerendezesList : TKapcsBerendLista Write KapcsBerendList;
  End;

Var VegberendDlg : TVegberendDlg;

Implementation

Uses VezerloUnit;

{$R *.DFM}

//a kapcsolók állapotát adja vissza szövegesen 
Function TVegberendDlg.AllapotString: String;
Begin
  Result:='';
  If Kapcsolo1.StateOn Then Result:=ListBox1.Items[1]
  Else If Kapcsolo2.StateOn Then Result:=ListBox1.Items[2]
       Else Result:=ListBox1.Items[0];
End;

//kilépés
Procedure TVegberendDlg.CancelBtnClick(Sender: TObject);
Begin
  Close;
End;

//a form aktívvá válik
Procedure TVegberendDlg.FormActivate(Sender: TObject);
Begin
  RePaint;
  ComboBox1Change(Sender);
  Self.Modositas:=False;
  AlkalmazBtn.Enabled:=False;
End;

//form létrehozása
Procedure TVegberendDlg.FormCreate(Sender: TObject);
Begin
  Self.DoubleBuffered:=True;
End;

//form átfestése
Procedure TVegberendDlg.FormPaint(Sender: TObject);
Var LabelArray : Array[1..6] Of TLabel;
    BevelArray : Array[1..3] Of TBevel;
Begin
  LabelArray[1]:=Self.Label1;
  LabelArray[2]:=Self.Label2;
  LabelArray[3]:=Self.Label3;
  LabelArray[4]:=Self.Label4;
  LabelArray[5]:=Self.Label5;
  LabelArray[6]:=Self.Label6;
  BevelArray[1]:=Self.Bevel1;
  BevelArray[2]:=Self.Bevel2;
  BevelArray[3]:=Self.Bevel3;
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then
  Begin
    Label_Bevel_Allit(Self,LabelArray,BevelArray,True,AblakSzin.HatterSzin,bsLowered);
    //festõ meghívása
    FormFesto(Self);
  End
  Else Label_Bevel_Allit(Self,LabelArray,BevelArray,False,AblakSzin.BetuSzin,bsRaised);
End;

//kattintás a kapcsolóra
Procedure TVegberendDlg.Kapcsolo1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Begin
  If Kapcsolo1.StateOn Then Label5.Caption:='- Be'
    Else Label5.Caption:='- Ki';
  Label4.Enabled:=Not Kapcsolo1.StateOn;
  Kapcsolo2.Enabled:=Not Kapcsolo1.StateOn;
  StatusBar1.SimpleText:=AllapotString;
  Self.Modositas:=True;
  AlkalmazBtn.Enabled:=True;
End;

//kattintás a kapcsolóra
Procedure TVegberendDlg.Kapcsolo2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Begin
  If Kapcsolo2.StateOn Then Label6.Caption:='- Be'
    Else Label6.Caption:='- Ki';
  StatusBar1.SimpleText:=AllapotString;
  Self.Modositas:=True;
  AlkalmazBtn.Enabled:=True;
End;

//kattintás a naplózás CheckBox-ra
Procedure TVegberendDlg.NaplozBoxClick(Sender: TObject);
Begin
  Self.Modositas:=True;
  AlkalmazBtn.Enabled:=True;
End;

//kattintás a naplózás feliratra
Procedure TVegberendDlg.Label2Click(Sender: TObject);
Begin
  NaplozBox.Checked:=Not NaplozBox.Checked;
  NaplozBoxClick(Sender);
End;

//kattintás a Rendben bombra
Procedure TVegberendDlg.OKBtnClick(Sender: TObject);
Var Valtoz : Boolean;
    Szoveg : String;
    UzTomb : TAdatUzenetTomb;
Begin
  Valtoz:=False;
  //ha a lánc nem üres és van aktuális elem kiválasztva, ami módosítva lett
  If (VegberendList <> Nil) And (ComboBox1.Text <> '') And Modositas Then
  Begin
    If (VegberendList.Aktualis.Naplozas <> NaplozBox.Checked) Then
    Begin
      Valtoz:=True;
      VegberendList.Aktualis.Naplozas:=NaplozBox.Checked;
    End;
    If (VegberendList.Aktualis.Automata <> Kapcsolo1.StateOn) Then
    Begin
      Valtoz:=True;
      VegberendList.Aktualis.Automata:=Kapcsolo1.StateOn;
    End;
    If (VegberendList.Aktualis.Direkt <> Kapcsolo2.StateOn) Then
    Begin
      Valtoz:=True;
      VegberendList.Aktualis.Direkt:=Kapcsolo2.StateOn;
    End;
    If (VegberendList.Aktualis.Allapot <> VegberendList.Aktualis.Direkt) Then
    Begin
      //ha van kapcsolat
      If FormVezerlo.VanKapcsolat Then
      Begin
        SetLength(UzTomb,2);
        UzTomb[0]:=VegberendList.Aktualis.ID;
        //berendezés bekapcsolása
        If VegberendList.Aktualis.Direkt Then
        Begin
          UzTomb[1]:=BoolToInt(True);
          Szoveg:=MemoIdo+'('+IntToStr(VegberendList.Aktualis.ID)+') '+
            VegberendList.Aktualis.VegBerendMutato.BerendezesNev+' bekapcsolása...';
        End
        //berendezés kikapcsolása
        Else Begin
          UzTomb[1]:=BoolToInt(False);
          Szoveg:=MemoIdo+'('+IntToStr(VegberendList.Aktualis.ID)+') '+
            VegberendList.Aktualis.VegBerendMutato.BerendezesNev+' kikapcsolása...';
        End;
        FormVezerlo.TextAttributes.Color:=clYellow;
        //üzenet elküldése
        FormVezerlo.AdatUzenetKuld(False,UzTomb,Szoveg,FormVezerlo.TextAttributes);
        SetLength(UzTomb,0);
      End;
    End;
    If Valtoz Then VegberendList.Valtozas:=True;
  End;
End;

//kattintás az Alkalmaz gombra
Procedure TVegberendDlg.AlkalmazBtnClick(Sender: TObject);
Begin
  OKBtnClick(Sender);
  AlkalmazBtn.Enabled:=False;
  Self.Modositas:=False;
End; 

//egy végberendezés tulajdonságainak kiírása
Procedure TVegberendDlg.Beallit(Naploz,Kapcs1,Kapcs2: Boolean);
Begin
  NaplozBox.Checked:=Naploz;
  Kapcsolo1.StateOn:=Kapcs1;
  Kapcsolo2.StateOn:=Kapcs2;
  If Kapcsolo1.StateOn Then Label5.Caption:='- Be'
    Else Label5.Caption:='- Ki';
  If Kapcsolo2.StateOn Then Label6.Caption:='- Be'
    Else Label6.Caption:='- Ki';
  Label4.Enabled:=Not Kapcsolo1.StateOn;
  Kapcsolo2.Enabled:=Not Kapcsolo1.StateOn;
  StatusBar1.SimpleText:=AllapotString;
End;

//elem választása
Procedure TVegberendDlg.ComboBox1Change(Sender: TObject);
Var ID     : Integer;
    Mutato : PVegBerendElem;
Begin
  //azonosító keresése
  ID:=BerendList.KeresNev(ComboBox1.Items[ComboBox1.ItemIndex]);
  //azonosító alapján a mutató megkeresése
  If VegberendList.KeresID(ID,Mutato) Then
  Begin
    VegberendList.Aktualis:=Mutato;
    //tulajdonságok frissítése
    Beallit(Mutato.Naplozas,Mutato.Automata,Mutato.Direkt);
  End;
  Self.Modositas:=False;
  AlkalmazBtn.Enabled:=False;
End;

End.
