program UpdateExe;

uses
  Forms,
  ufrmUpdate in '..\updateExe\ufrmUpdate.pas' {frmUpdate};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmUpdate, frmUpdate);
  Application.Run;
end.
