//Megnyitás dialog box
Unit MegnyitasUnit;

Interface

Uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     StdCtrls, FileCtrl, Buttons, FormFestoUnit, FileTablaUnit;

Type
  TOpenDlg = Class(TForm)
    Label1            : TLabel;
    Label2            : TLabel;
    OpenBtn           : TBitBtn;
    CloseBtn          : TBitBtn;
    FileListBox1      : TFileListBox;
    DriveComboBox1    : TDriveComboBox;
    DirectoryListBox1 : TDirectoryListBox;
    Function Get_DirPath : String;
    Function Get_DirName : String;
    Procedure CloseBtnClick(Sender: TObject);
    Procedure FormActivate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
    Procedure DirectoryListBox1Change(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure OpenBtnClick(Sender: TObject);
  Private
    DirPath : String;  //könyvtár elérési útja
    DirName : String;  //könyvtár neve
  End;

Var OpenDlg : TOpenDlg;

Implementation

{$R *.DFM}

//könyvtár elérési útjának lekérdezése
Function TOpenDlg.Get_DirPath: String;
Begin
  Result:=Self.DirPath;
End;

//könyvtár nevének lekérdezése
Function TOpenDlg.Get_DirName: String;
Begin
  Result:=Self.DirName;
End;

//bezárás gomb esemény
Procedure TOpenDlg.CloseBtnClick(Sender: TObject);
Begin
  Close;
End;

//a form aktívvá válik
Procedure TOpenDlg.FormActivate(Sender: TObject);
Begin
  RePaint;
  Self.DirPath:='';
  Self.DirName:='';
  DirectoryListBox1.Directory:=GetCurrentDir;
End;

//form átfestése
Procedure TOpenDlg.FormPaint(Sender: TObject);
Var LabelArray : Array[1..2] Of TLabel;
Begin
  LabelArray[1]:=Label1;
  LabelArray[2]:=Label2;
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then
  Begin
    //beállítjuk a feliratok színét
    Label_Allit(OpenDlg,LabelArray,True,AblakSzin.HatterSzin);
    //festõ meghívása
    FormFesto(OpenDlg);
  End
  Else Label_Allit(OpenDlg,LabelArray,False,AblakSzin.BetuSzin);
End;

//lépkedés a könvtár struktúrában
Procedure TOpenDlg.DirectoryListBox1Change(Sender: TObject);
Var SR       : TSearchRec;
    FileAttr : Integer;
Begin
  FileAttr:=0;
  //ha van benne adatbázis -> megnyitás gomb feléled
  If (FindFirst(sAlaprajz+sKit,FileAttr,SR) = 0) Then OpenBtn.Enabled:=True
    Else OpenBtn.Enabled:=False;
  FindClose(SR);
End;

//form létrehozása
Procedure TOpenDlg.FormCreate(Sender: TObject);
Begin
  Self.DirPath:='';
  Self.DirName:='';
  OpenBtn.Enabled:=False;
End;

//megnyitás gomb esemény
Procedure TOpenDlg.OpenBtnClick(Sender: TObject);
Begin
  Self.DirPath:=GetCurrentDir;
  Self.DirName:=AktDirNev(Self.DirPath);
End;

End.
