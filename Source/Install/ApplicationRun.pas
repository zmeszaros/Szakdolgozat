unit ApplicationRun;

interface

uses Windows, Messages, SysUtils, ShellApi, Classes, Graphics,
     Controls, Forms, Dialogs;

type
  TFinishEvent=procedure(filename: string) of object;

  TApplicationRun = class(TComponent)
  private
    FOnFinish: TFinishEvent;
    procedure DoTerminate(Sender: TObject);
    procedure SetOnFinish(const Value: TFinishEvent);
  public
    procedure Start(filename: string);
  published
    property OnFinish: TFinishEvent read FOnFinish write SetOnFinish;
  end;

  TApplicationRunThread = class(TThread)
  private
    FFileName: string;
  protected
    procedure Execute; override;
  public
    constructor Create(filename: string);
    property FileName: string read FFileName;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('ApplicationRun', [TApplicationRun]);
end;

{ TApplicationRunThread }

constructor TApplicationRunThread.Create(filename: string);
begin
  inherited Create(true);
  FreeOnTerminate:=true;
  FFileName:=filename;
  Resume;
end;
                        
procedure TApplicationRunThread.Execute;
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  FillChar(StartupInfo, Sizeof(StartupInfo), 0);
  StartupInfo.cb:=Sizeof(TStartupInfo);
  StartupInfo.dwFlags:=STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow:=SW_SHOW;
  if CreateProcess(nil, PChar(FFileName), nil, nil, false, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo) then
  begin
    WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end;
end;

{ TApplicationRun }

procedure TApplicationRun.DoTerminate(Sender: TObject);
begin
  if Assigned(FOnFinish) then begin
    FOnFinish((Sender as TApplicationRunThread).FileName);
  end;
end;

procedure TApplicationRun.SetOnFinish(const Value: TFinishEvent);
begin
  FOnFinish := Value;
end;

procedure TApplicationRun.Start(filename: string);
var
  v: TApplicationRunThread;
begin
  v:=TApplicationRunThread.Create(filename);
  v.OnTerminate:=DoTerminate;
end;

end.
