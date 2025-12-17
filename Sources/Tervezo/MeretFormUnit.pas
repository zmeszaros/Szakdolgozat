//Rajzasztal beállítása dialog box
Unit MeretFormUnit;

Interface

Uses SysUtils, Classes, Forms, Controls, Buttons, StdCtrls, ExtCtrls, Spin,
     ComCtrls, Dialogs, FormFestoUnit, EpuletLancUnit;

Type
  TMeretForm = Class(TForm)
    OKBtn         : TButton;
    CancelBtn     : TButton;
    Bevel1        : TBevel;
    Bevel2        : TBevel;
    Bevel3        : TBevel;
    Label1        : TLabel;
    Label2        : TLabel;
    Label3        : TLabel;
    Label4        : TLabel;
    Label5        : TLabel;
    Label6        : TLabel;
    LabelKurzor   : TLabel;
    LabelMeret    : TLabel;
    EgysegNevEdit : TEdit;
    EpuletNevEdit : TEdit;
    UpDown1       : TUpDown;
    ListBox1      : TListBox;
    ListBox2      : TListBox;
    ListBox3      : TListBox;
    Procedure FormCreate(Sender: TObject);
    Procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    Procedure FormPaint(Sender: TObject);
    Procedure FormActivate(Sender: TObject);
    Procedure OKBtnClick(Sender: TObject);
  Private
    EpLista      : TEpuletLista;  //épület neve
    Procedure Beallit;
  Public
    Function ShowModal(Const EL: TEpuletLista) : Integer; Reintroduce; Overload;
  End;

Var MeretForm : TMeretForm;
    AlapMeret : Integer;
    EgysMeret : Integer;

Implementation

{$R *.DFM}

//form megjelenítése
Function TMeretForm.ShowModal(Const EL: TEpuletLista) : Integer;
Begin
  EpLista:=EL;
  Result:=Inherited ShowModal;
End;

//komponensek értékeinek beállítása
Procedure TMeretForm.Beallit;
Begin
  LabelMeret.Caption:=ListBox1.Items.Strings[UpDown1.Position];
  LabelKurzor.Caption:=ListBox2.Items.Strings[UpDown1.Position];
  Try
    AlapMeret:=StrToInt(ListBox3.Items.Strings[UpDown1.Position]);
    EgysMeret:=StrToInt(ListBox3.Items.Strings[11+UpDown1.Position]);
  Except
    On EConvertError Do
      Begin
        MessageDlg('Hiba a beállításkor!'+#13+
          'Alapértelmezett beállítások lesznek érvényben:'+#13+
          'Alaprajz mérete: 24x24 m'+#13+
          'Minimális kurzormozgás: 20 mm',mtError,[mbOk],0);
        AlapMeret:=24;
        EgysMeret:=20;
      End;
  End;
End;

//form létrehozása
Procedure TMeretForm.FormCreate(Sender: TObject);
Begin
  UpDown1.Position:=2;
  Beallit;
End;

//alaprajz méretének változása
Procedure TMeretForm.UpDown1Click(Sender: TObject; Button: TUDBtnType);
Begin
  Beallit;
End;

//form átfestése
Procedure TMeretForm.FormPaint(Sender: TObject);
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
    //beállítjuk a feliratok és keretek színét
    Label_Bevel_Allit(MeretForm,LabelArray,BevelArray,True,AblakSzin.HatterSzin,bsLowered);
    //festõ meghívása
    FormFesto(MeretForm);
  End
  Else Label_Bevel_Allit(MeretForm,LabelArray,BevelArray,False,AblakSzin.BetuSzin,bsRaised);
End;

//a form aktívvá válik
Procedure TMeretForm.FormActivate(Sender: TObject);
Begin
  RePaint;
End;

//rendben gomb eseménye
Procedure TMeretForm.OKBtnClick(Sender: TObject);
Begin
  //ha nem jók az adatok ( valamelyik üres )
  If ((EgysegNevEdit.Text = '') Or (EpuletNevEdit.Text = '')) Then
  Begin
    ModalResult:=mrNone;
    If (EgysegNevEdit.Text = '') Then ActiveControl:=EgysegNevEdit
      Else ActiveControl:=EpuletNevEdit;
    Exit;
  End;
End;

End.
