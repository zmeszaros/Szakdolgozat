Program Tervezo;

uses
  Forms,
  Windows,
  Classes,
  IniFiles,
  SysUtils,
  ShellAPI,
  InstanceHandler,
  TervezoUnit in 'TervezoUnit.pas' {FormTervezo},
  AboutUnit in 'AboutUnit.pas' {AboutBox},
  MeretFormUnit in 'MeretFormUnit.pas' {MeretForm},
  UjUnit in 'UjUnit.pas' {DlgUj},
  AjtoUnit in 'AjtoUnit.pas' {AjtoBeallDlg},
  ForgatUnit in 'ForgatUnit.pas' {DlgForgatas},
  BeallitUnit in 'BeallitUnit.pas' {DlgBeallit},
  UtilUnit in 'UtilUnit.pas',
  KeretUnit in 'KeretUnit.pas',
  KijelolNegyzetUnit in 'KijelolNegyzetUnit.pas',
  TavolsagUnit in 'TavolsagUnit.pas',
  KijelolLancUnit in 'KijelolLancUnit.pas',
  FileTablaUnit in 'FileTablaUnit.pas',
  PontLancUnit in 'PontLancUnit.pas',
  FormFestoUnit in 'FormFestoUnit.pas',
  ObjektumUnit in 'ObjektumUnit.pas',
  ObjNevFormUnit in 'ObjNevFormUnit.pas' {ObjNevForm},
  ObjektumokDlgUnit in 'ObjektumokDlgUnit.pas' {ObjektumokDlg},
  BerendezesekLancUnit in 'BerendezesekLancUnit.pas',
  UjBerendezesUnit in 'UjBerendezesUnit.pas' {UjBerendDlg},
  EpuletLancUnit in 'EpuletLancUnit.pas',
  ZoomUnit in 'ZoomUnit.pas',
  RajzolasUnit in 'RajzolasUnit.pas',
  PenUnit in 'PenUnit.pas',
  BerendDlgUnit in 'BerendDlgUnit.pas' {BerendezesDlg},
  MonitorUnit in 'MonitorUnit.pas' {MonitorDlg},
  ObjListaUnit in 'ObjListaUnit.pas' {ObjListaDlg},
  MegnyitasUnit in 'MegnyitasUnit.pas' {OpenDlg},
  ResolutionUnit in 'ResolutionUnit.pas',
  UjEpEgysegDlgUnit in 'UjEpEgysegDlgUnit.pas' {UjEpEgysegDlg};

{$R *.RES}
{$R Hourglas.RES}

Const CursorName = 'Hourglas.ani';

//rejtett-e a Taskbar
Function IsTaskbarAutoHideOn : Boolean;
Var ABData : TAppBarData;
Begin
  ABData.cbSize:=SizeOf(ABData);
  Result:=(SHAppBarMessage(ABM_GETSTATE,ABData) And ABS_AUTOHIDE) > 0;
End;

//Taskbar elrejtése
Procedure HideTaskbar;
Var wndHandle : THandle;
    wndClass  : Array[0..50] Of Char;
Begin
  StrPCopy(@wndClass[0],'Shell_TrayWnd');
  wndHandle:=FindWindow(@wndClass[0],Nil);
  ShowWindow(wndHandle,SW_HIDE);
End;

//Taskbar megjelenítése
Procedure ShowTaskbar;
Var wndHandle : THandle;
    wndClass  : Array[0..50] Of Char;
Begin
  StrPCopy(@wndClass[0],'Shell_TrayWnd');
  wndHandle:=FindWindow(@wndClass[0],Nil);
  ShowWindow(wndHandle,SW_RESTORE);
End;

//alapbeállítások betöltése
Procedure Beallitas;
Var Proba      : String;
    FileName   : String;
    TervezoIni : TIniFile;
Begin
  FileName:=ExtractFilePath(ParamStr(0))+'Tervezo.ini';
  TervezoIni:=TIniFile.Create(FileName);
  With TervezoIni Do
  Begin
    Proba:=ReadString('Beállítások','SzinAtmenet','¤');
    If (Proba = '¤') Then WriteBool('Beállítások','SzinAtmenet',True);
    DlgBeallit.SzinAtmenetBox.Checked:=ReadBool('Beállítások','SzinAtmenet',True);
    AblakSzin.SzinAtmenet:=DlgBeallit.SzinAtmenetBox.Checked;
    Proba:=ReadString('Beállítások','AblakMeret','¤');
    If (Proba = '¤') Then WriteInteger('Beállítások','AblakMeret',150);
    DlgBeallit.AblakEdit.Value:=ReadInteger('Beállítások','AblakMeret',150);
    FormTervezo.Set_AblakMeret(DlgBeallit.AblakEdit.Value);
    Free;
  End;
End;

Var InstancesInfo : IInstancesInfo;
    Resolution    : TResolution;

Begin
  //Ellenõrzi, hogy fut-e egy példány a programból
  InstancesInfo:=GetInstancesInfo;
  If (InstancesInfo.Count > 1) Then
  Begin
    // Elõzõ programpéldány aktiválása
    InstancesInfo[0].ActivateAppWnd;
    Exit;
  End;
  InstancesInfo:=Nil;

  //Felbontás beállítása
  Resolution:=TResolution.Create;
  If (Not Resolution.BestOfRes) Then
  Begin
    Application.MessageBox('A kívánt felbontást nem lehet beállítani!','HIBA',MB_OK);
    Exit;
  End;
  If (Not IsTaskbarAutoHideOn) Then HideTaskbar;

  //Ha nem létezik az kurzor
  If Not FileExists(CursorName) Then
    //kimeti egy file-ba az erõforrást (mert platformfüggõ az .ani)
    With TResourceStream.Create(hInstance,'MYCURSOR','ANICURSOR') Do
    Try
      SaveToFile(CursorName);
    Finally
      Free;
    End;
  //betölti a kurzort
  Screen.Cursors[1]:=Windows.LoadImage(0,PChar(CursorName),IMAGE_CURSOR,0,0,LR_DEFAULTSIZE Or LR_LOADFROMFILE);

  Application.Initialize;
  Application.HelpFile:='C:\Programozas\IntellHouse\Tervezo\Súgó.hlp';
  Application.Title:='Tervezõ';
  Application.CreateForm(TDlgUj, DlgUj);
  Application.CreateForm(TFormTervezo, FormTervezo);
  Application.CreateForm(TMeretForm, MeretForm);
  Application.CreateForm(TAjtoBeallDlg, AjtoBeallDlg);
  Application.CreateForm(TDlgForgatas, DlgForgatas);
  Application.CreateForm(TDlgBeallit, DlgBeallit);
  Application.CreateForm(TObjNevForm, ObjNevForm);
  Application.CreateForm(TObjektumokDlg, ObjektumokDlg);
  Application.CreateForm(TUjBerendDlg, UjBerendDlg);
  Application.CreateForm(TBerendezesDlg, BerendezesDlg);
  Application.CreateForm(TMonitorDlg, MonitorDlg);
  Application.CreateForm(TObjListaDlg, ObjListaDlg);
  Application.CreateForm(TOpenDlg, OpenDlg);
  Application.CreateForm(TUjEpEgysegDlg, UjEpEgysegDlg);
  Beallitas;
  Application.Run;
  ShowTaskbar;
  FreeAndNil(Resolution);
End.
