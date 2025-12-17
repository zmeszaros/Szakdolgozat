//Naplózó form
Unit NaploDlgUnit;

Interface

Uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
     Buttons, ExtCtrls, FormFestoUnit, ToolWin, ComCtrls, Dialogs, Printers;

Type
  TNaploDlg = Class(TForm)
    Label1       : TLabel;
    Bevel1       : TBevel;
    Bevel2       : TBevel;
    Bevel3       : TBevel;
    ToolBar1     : TToolBar;
    RichEdit1    : TRichEdit;
    OpenDialog1  : TOpenDialog;
    ToolButton1  : TToolButton;
    ToolButton2  : TToolButton;
    KilepesBtn   : TSpeedButton;
    MegnyitasBtn : TSpeedButton;
    NyomtatBtn   : TSpeedButton;
    CloseBtn     : TSpeedButton;
    PreviewBtn   : TSpeedButton;
    Procedure FormActivate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
    Procedure KilepesBtnClick(Sender: TObject);
    Procedure MegnyitasBtnClick(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure NyomtatBtnClick(Sender: TObject);
    Procedure CloseBtnClick(Sender: TObject);
    Procedure FormClose(Sender: TObject; var Action: TCloseAction);
    Procedure PreviewBtnClick(Sender: TObject);
  End;

Var NaploDlg : TNaploDlg;

Implementation

Uses FrmNyomtatUnit;

{$R *.DFM}

//form létrehozása
Procedure TNaploDlg.FormCreate(Sender: TObject);
Begin
  RichEdit1.Clear;
  RichEdit1.ReadOnly:=True;
End;

//form bezárása
Procedure TNaploDlg.FormClose(Sender: TObject; var Action: TCloseAction);
Begin
  RichEdit1.Lines.Clear;
  Label1.Caption:='Naplófájlok megtekintése';
End;

//a form aktívvá válik
Procedure TNaploDlg.FormActivate(Sender: TObject);
Begin
  RePaint;
End;

//form átfestése
Procedure TNaploDlg.FormPaint(Sender: TObject);
Var LabelArray : Array[1..1] Of TLabel;
Begin
  LabelArray[1]:=Label1;
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then
  Begin
    Label_Allit(NaploDlg,LabelArray,True,AblakSzin.HatterSzin);
    //festõ meghívása
    FormFesto(NaploDlg);
  End
  Else Label_Allit(NaploDlg,LabelArray,False,AblakSzin.BetuSzin);
End;

//kilépés
Procedure TNaploDlg.KilepesBtnClick(Sender: TObject);
Begin
  Close;
End;

//megnyitás
Procedure TNaploDlg.MegnyitasBtnClick(Sender: TObject);
Begin
  If OpenDialog1.Execute Then
  Begin
    Try
      RichEdit1.Clear;
      //betöltés fájlból
      RichEdit1.Lines.LoadFromFile(OpenDialog1.FileName);
      Label1.Caption:=ExtractFileName(OpenDialog1.FileName);
    Except
      On EFOpenError Do Begin
                          RichEdit1.Clear;
                          Label1.Caption:='Naplófájlok megtekintése';
                        End;
    End;
  End;
End;

//nyomtatási kép
Procedure TNaploDlg.PreviewBtnClick(Sender: TObject);
Begin
  Try
    //ha nem üres
    If (RichEdit1.Lines.Count > 0) Then
    Begin
      frmNyomtat.qRich.Lines.LoadFromFile(OpenDialog1.FileName);
      frmNyomtat.qNaplonev.Caption:='('+ExtractFileName(OpenDialog1.FileName)+')';
      frmNyomtat.qNyomtat.Preview;
    End;
  Except
    On EPrinter Do Application.MessageBox('Nyomtatási hiba! Lehet, hogy nincs alapnyomtató kijelölve!',
                   'Nyomtató hiba',mb_OK);
  End;
End;

//nyomtatás
Procedure TNaploDlg.NyomtatBtnClick(Sender: TObject);
Begin
  Try
    //ha nem üres
    If (RichEdit1.Lines.Count > 0) Then
    Begin
      frmNyomtat.qRich.Lines.LoadFromFile(OpenDialog1.FileName);
      frmNyomtat.qNaplonev.Caption:='('+ExtractFileName(OpenDialog1.FileName)+')';
      frmNyomtat.qNyomtat.Print;
    End;
  Except
    On EPrinter Do Application.MessageBox('Nyomtatási hiba! Lehet, hogy nincs alapnyomtató kijelölve!',
                   'Nyomtató hiba',mb_OK);
  End;
End;

//fájl bezárása
Procedure TNaploDlg.CloseBtnClick(Sender: TObject);
Begin
  Label1.Caption:='Naplófájlok megtekintése';
  RichEdit1.Clear;
End;

End.
