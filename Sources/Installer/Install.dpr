program Install;

uses
  Forms,
  FormInstallUnit in 'FormInstallUnit.pas' {FormInstall},
  FormFestoUnit in 'FormFestoUnit.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormInstall, FormInstall);
  Application.Run;
end.
