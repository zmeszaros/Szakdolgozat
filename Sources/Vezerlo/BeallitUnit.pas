//A beállításokat megjelenítõ dilog box
Unit BeallitUnit;

Interface

Uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     StdCtrls, Buttons, FormFestoUnit, UtilUnit, ExtCtrls, FileTablaUnit,
     MegnyitasUnit, ComCtrls, CPort, CPortCtl;

Type
  //régi értékek tárolása
  TRegiErtekek = Object
    EpuletNev   : String;    //épület elérési útja
    SzinAt      : Boolean;   //kell-e színátmenet
    AutIndit    : Boolean;   //automatikus indítás
    ComPort     : Integer;   //port tulajdonságai
    StopBit     : Integer;
    DataBit     : Integer;
    FlowControl : Integer;
    BaudRate    : Integer;
    Procedure Ment(S1: String; B1,B2: Boolean; I1,I2,I3,I4,I5: Integer);
  End;

  TBeallitDlg = Class(TForm)
    OKBtn             : TBitBtn;
    CancelBtn         : TBitBtn;
    Panel1            : TPanel;
    PageControl1      : TPageControl;
    AltTabSheet       : TTabSheet;
    KapcsTabSheet     : TTabSheet;
    GroupBox2         : TGroupBox;
    SzinAtmenetBox    : TCheckBox;
    GroupBox1         : TGroupBox;
    FileNevEdit       : TEdit;
    BtnBeallit        : TBitBtn;
    BtnTorles         : TBitBtn;
    BaudRateRadio     : TComRadioGroup;
    DataBitRadio      : TComRadioGroup;
    ComBox            : TComComboBox;
    StopBitBox        : TComComboBox;
    FlowControlRadio  : TComRadioGroup;
    AutInditBox       : TCheckBox;
    Bevel1            : TBevel;
    RadioGroup1       : TRadioGroup;
    FolyamatosHangBtn : TRadioButton;
    EgyHangBtn        : TRadioButton;
    NincsHangBtn      : TRadioButton;
    Label1            : TLabel;
    Label2            : TLabel;
    Function ShowModal(Port: TComPort; Var Valt: Boolean) : Integer; Reintroduce; Overload;
    Procedure FormActivate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure BtnBeallitClick(Sender: TObject);
    Procedure BtnTorlesClick(Sender: TObject);
    Procedure CancelBtnClick(Sender: TObject);
    Procedure FileNevEditDblClick(Sender: TObject);
    procedure SzinAtmenetBoxClick(Sender: TObject);
    procedure FileNevEditChange(Sender: TObject);
    procedure BaudRateRadioClick(Sender: TObject);
    procedure ComBoxChange(Sender: TObject);
    procedure StopBitBoxChange(Sender: TObject);
    procedure DataBitRadioClick(Sender: TObject);
    procedure FlowControlRadioClick(Sender: TObject);
    procedure AutInditBoxClick(Sender: TObject);
    procedure EgyHangBtnClick(Sender: TObject);
    procedure FolyamatosHangBtnClick(Sender: TObject);
    procedure NincsHangBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  Private
    Valtozas    : Boolean;         //volt-e változás
    CPort       : TComPort;        //kommunikációs port
    RegiErtekek : TRegiErtekek;    //régi értékek
    Procedure ErtekekVissza;
  End;

Var BeallitDlg : TBeallitDlg;

Implementation

{$R *.DFM}

//régi értékek elmentése
Procedure TRegiErtekek.Ment(S1: String; B1,B2: Boolean; I1,I2,I3,I4,I5: Integer);
Begin
  EpuletNev:=S1;
  SzinAt:=B1;
  AutIndit:=B2;
  ComPort:=I1;
  StopBit:=I2;
  DataBit:=I3;
  FlowControl:=I4;
  BaudRate:=I5;
End;

//a form megjelenítése
Function TBeallitDlg.ShowModal(Port: TComPort; Var Valt: Boolean): Integer;
Begin
  //értékek aktualizálása
  Self.CPort:=Port;
  ComBox.ComPort:=Self.CPort;
  StopBitBox.ComPort:=Self.CPort;
  DataBitRadio.ComPort:=Self.CPort;
  BaudRateRadio.ComPort:=Self.CPort;
  FlowControlRadio.ComPort:=Self.CPort;
  //értékek mentése
  With Self Do RegiErtekek.Ment(FileNevEdit.Text,SzinAtmenetBox.Checked,
    AutInditBox.Checked,ComBox.ItemIndex,StopBitBox.ItemIndex,
    DataBitRadio.ItemIndex,FlowControlRadio.ItemIndex,BaudRateRadio.ItemIndex);
  Self.Valtozas:=False;
  Result:=Inherited ShowModal;
  Valt:=Self.Valtozas;
End;

//a form aktívvá válik
Procedure TBeallitDlg.FormActivate(Sender: TObject);
Begin
  RePaint;
  PageControl1.ActivePage:=AltTabSheet;
End;

//form átfestése
Procedure TBeallitDlg.FormPaint(Sender: TObject);
Begin
  If AblakSzin.SzinAtmenet Then FormFesto(BeallitDlg);
End;

//a form létrehozása
Procedure TBeallitDlg.FormCreate(Sender: TObject);
Begin
  FileNevEdit.ReadOnly:=True;
  Self.Visible:=False;
  PageControl1.ActivePage:=AltTabSheet;
End;

//kattintás a Beállítás gombra
Procedure TBeallitDlg.BtnBeallitClick(Sender: TObject);
Var RegiEdit    : String;
    EpuletNev   : String;
    RegiDirName : String;
Begin
  RegiEdit:=FileNevEdit.Text;
  RegiDirName:=ExtractFilePath(ParamStr(0));
  //könyvtár kiválasztása
  If (OpenDlg.ShowModal <> idCancel) Then
  Begin
    EpuletNev:=OpenDlg.Get_DirPath+'\';
    FileNevEdit.Text:=EpuletNev;
  End
  Else FileNevEdit.Text:=RegiEdit;
  SetCurrentDir(RegiDirName);
End;

//kattintás a Törlés gombra
Procedure TBeallitDlg.BtnTorlesClick(Sender: TObject);
Begin
  FileNevEdit.ReadOnly:=False;
  FileNevEdit.Text:='';
  FileNevEdit.ReadOnly:=True;
End;

//kattintás a Mégsem gombra
Procedure TBeallitDlg.OKBtnClick(Sender: TObject);
Begin
  PageControl1.ActivePage:=AltTabSheet;
End;

//kattintás a Mégsem gombra
Procedure TBeallitDlg.CancelBtnClick(Sender: TObject);
Begin
  //régi értékek visszaállítása
  ErtekekVissza;
  PageControl1.ActivePage:=AltTabSheet;
End;

//duplakattintás az input boxon gombra
Procedure TBeallitDlg.FileNevEditDblClick(Sender: TObject);
Begin
  BtnBeallitClick(Sender);
End;

//régi értékek visszaállítása
Procedure TBeallitDlg.ErtekekVissza;
Begin
  With RegiErtekek Do
  Begin
    FileNevEdit.Text:=EpuletNev;
    SzinAtmenetBox.Checked:=SzinAt;
    AutInditBox.Checked:=AutIndit;
    ComBox.ItemIndex:=ComPort;
    StopBitBox.ItemIndex:=StopBit;
    DataBitRadio.ItemIndex:=DataBit;
    FlowControlRadio.ItemIndex:=FlowControl;
    BaudRateRadio.ItemIndex:=BaudRate;
  End;
End;

//kattintás eseménye
Procedure TBeallitDlg.SzinAtmenetBoxClick(Sender: TObject);
Begin
  Self.Valtozas:=True;
End;

//fájl nevének változtatása
procedure TBeallitDlg.FileNevEditChange(Sender: TObject);
Begin
  Self.Valtozas:=True;
End;

//kattintás eseménye
Procedure TBeallitDlg.BaudRateRadioClick(Sender: TObject);
Begin
  Self.Valtozas:=True;
End;

//port kiválasztása
Procedure TBeallitDlg.ComBoxChange(Sender: TObject);
Begin
  Self.Valtozas:=True;
End;

//stop bit változtatása
Procedure TBeallitDlg.StopBitBoxChange(Sender: TObject);
Begin
  Self.Valtozas:=True;
End;

//kattintás eseménye
Procedure TBeallitDlg.DataBitRadioClick(Sender: TObject);
Begin
  Self.Valtozas:=True;
End;

//kattintás eseménye
Procedure TBeallitDlg.FlowControlRadioClick(Sender: TObject);
Begin
  Self.Valtozas:=True;
End;

//kattintás eseménye
Procedure TBeallitDlg.AutInditBoxClick(Sender: TObject);
Begin
  Self.Valtozas:=True;
End;

//kattintás eseménye
Procedure TBeallitDlg.EgyHangBtnClick(Sender: TObject);
Begin
  Self.Valtozas:=True;
End;

//kattintás eseménye
Procedure TBeallitDlg.FolyamatosHangBtnClick(Sender: TObject);
Begin
  Self.Valtozas:=True;
End;

//kattintás eseménye
Procedure TBeallitDlg.NincsHangBtnClick(Sender: TObject);
Begin
  Self.Valtozas:=True;
End;

End.
