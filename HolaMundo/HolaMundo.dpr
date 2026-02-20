program HolaMundo;

uses
  Vcl.Forms,
  frmPrincipal in 'frmPrincipal.pas' {FormPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Hola Mundo - Delphi 12';
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
