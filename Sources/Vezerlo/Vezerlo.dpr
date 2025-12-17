program Vezerlo;

uses
  Forms,
  Classes,
  Windows,
  SysUtils,
  InstanceHandler,
  FileTablaUnit in 'FileTablaUnit.pas',
  VezerloUnit in 'VezerloUnit.pas' {FormVezerlo},
  UtilUnit in 'UtilUnit.pas',
  BeallitUnit in 'BeallitUnit.pas' {BeallitDlg},
  BerendDlgUnit in 'BerendDlgUnit.pas' {BerendezesDlg},
  HomeroBeallUnit in 'HomeroBeallUnit.pas' {HomeroBeallDlg},
  HozzaadUnit in 'HozzaadUnit.pas' {HozzaadListDlg},
  MegnyitasUnit in 'MegnyitasUnit.pas' {OpenDlg},
  RiasztoBeallUnit in 'RiasztoBeallUnit.pas' {RiasztoBeallDlg},
  TuzjelzoBeallUnit in 'TuzjelzoBeallUnit.pas' {TuzjelzoBeallDlg},
  HomeroLancUnit in 'HomeroLancUnit.pas',
  KapcsBerendLancUnit in 'KapcsBerendLancUnit.pas',
  AboutUnit in 'AboutUnit.pas' {AboutBox},
  InditUnit in 'InditUnit.pas' {InditasDlg},
  RiasztoLancUnit in 'RiasztoLancUnit.pas',
  TuzjelzoLancUnit in 'TuzjelzoLancUnit.pas',
  VegberendDlgUnit in 'VegberendDlgUnit.pas' {VegberendDlg},
  VegBerendLancUnit in 'VegBerendLancUnit.pas',
  EgyebDlgUnit in 'EgyebDlgUnit.pas' {EgyebDlg},
  FutotestDlgUnit in 'FutotestDlgUnit.pas' {FutotestDlg},
  BerendTablaUnit in 'BerendTablaUnit.pas',
  DlgUnit in 'DlgUnit.pas',
  BerendInspUnit in 'BerendInspUnit.pas' {BerendInspector},
  KodolasUnit in 'KodolasUnit.pas',
  KuldThreadUnit in 'KuldThreadUnit.pas',
  ResolutionUnit in 'ResolutionUnit.pas',
  NyugtaDlgUnit in 'NyugtaDlgUnit.pas' {NyugtaDlg},
  ObjektumUnit in 'ObjektumUnit.pas',
  HangThreadUnit in 'HangThreadUnit.pas',
  NaploDlgUnit in 'NaploDlgUnit.pas' {NaploDlg},
  DataModulUnit in 'DataModulUnit.pas' {DM: TDataModule},
  frmNyomtatUnit in 'FrmNyomtatUnit.pas' {frmNyomtat};

{$R *.RES}
{$R Hourglas.RES}

Const CursorName = 'Hourglas.ani';

Var InstancesInfo : IInstancesInfo;
    Resolution    : TResolution;

Begin
  //Ellenõrzi, hogy fut-e egy példány a programból
  InstancesInfo:=GetInstancesInfo;
  If (InstancesInfo.Count > 1) Then
  Begin
    //Elõzõ programpéldány aktiválása
    InstancesInfo[0].ActivateAppWnd;
    Exit;
  End;
  InstancesInfo:=Nil;

  //Felbontás beállítása
  Resolution:=TResolution.Create;
  If (Not Resolution.BestOfRes) Then
  Begin
    Application.MessageBox('A felbontást nem lehet beállítani!','HIBA',MB_OK);
    Exit;
  End;

  //Ha nem létezik az kurzor
  If Not FileExists(CursorName) Then
    //kimeti egy file-ba az erõforrást (platformfüggõ az .ani)
    With TResourceStream.Create(hInstance,'MYCURSOR','ANICURSOR') Do
    Try
      SaveToFile(CursorName);
    Finally
      Free;
    End;
  //betölti a kurzort
  Screen.Cursors[1]:=Windows.LoadImage(0,PChar(CursorName),IMAGE_CURSOR,0,0,LR_DEFAULTSIZE Or LR_LOADFROMFILE);

  Application.Initialize;
  Application.HelpFile:='C:\Programozas\IntellHouse\Vezerlo\Súgó.hlp';
  Application.Title:='Vezérlõ';
  Application.CreateForm(TFormVezerlo, FormVezerlo);
  Application.CreateForm(TBeallitDlg, BeallitDlg);
  Application.CreateForm(TBerendezesDlg, BerendezesDlg);
  Application.CreateForm(THomeroBeallDlg, HomeroBeallDlg);
  Application.CreateForm(THozzaadListDlg, HozzaadListDlg);
  Application.CreateForm(TOpenDlg, OpenDlg);
  Application.CreateForm(TRiasztoBeallDlg, RiasztoBeallDlg);
  Application.CreateForm(TTuzjelzoBeallDlg, TuzjelzoBeallDlg);
  Application.CreateForm(TInditasDlg, InditasDlg);
  Application.CreateForm(TVegberendDlg, VegberendDlg);
  Application.CreateForm(TEgyebDlg, EgyebDlg);
  Application.CreateForm(TFutotestDlg, FutotestDlg);
  Application.CreateForm(TBerendInspector, BerendInspector);
  Application.CreateForm(TNyugtaDlg, NyugtaDlg);
  Application.CreateForm(TNaploDlg, NaploDlg);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmNyomtat, frmNyomtat);
  Application.Run;
  FreeAndNil(Resolution);
End.
