program Tesztelo;

uses
  Forms,
  Windows,
  Classes,
  SysUtils,
  InstanceHandler,
  TeszteloUnit in 'TeszteloUnit.pas' {FormTesztelo},
  MegnyitasUnit in 'MegnyitasUnit.pas' {OpenDlg},
  BerendezesekLancUnit in 'BerendezesekLancUnit.pas',
  BerendTablaUnit in 'BerendTablaUnit.pas',
  EpuletLancUnit in 'EpuletLancUnit.pas',
  FileTablaUnit in 'FileTablaUnit.pas',
  ObjektumUnit in 'ObjektumUnit.pas',
  PontLancUnit in 'PontLancUnit.pas',
  InditUnit in 'InditUnit.pas' {InditasDlg},
  KodolasUnit in 'KodolasUnit.pas',
  KuldThreadUnit in 'KuldThreadUnit.pas',
  ResolutionUnit in 'ResolutionUnit.pas',
  DataModulUnit in 'DataModulUnit.pas' {DM: TDataModule};

{$R *.RES}
{$R Hourglas.RES}

Const CursorName = 'Hourglas.ani';

Var Resolution    : TResolution;
    InstancesInfo : IInstancesInfo;

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
  Application.Title:='Tesztelõ';
  Application.CreateForm(TFormTesztelo, FormTesztelo);
  Application.CreateForm(TOpenDlg, OpenDlg);
  Application.CreateForm(TInditasDlg, InditasDlg);
  Application.CreateForm(TDM, DM);
  Application.Run;
  FreeAndNil(Resolution);
End.
