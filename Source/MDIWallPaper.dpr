program MDIWallPaper;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uMDIChild in 'uMDIChild.pas' {frmChild};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
