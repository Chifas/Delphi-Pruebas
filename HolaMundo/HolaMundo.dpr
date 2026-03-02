program HolaMundo;

uses
  FMX.Forms,
  frmPrincipal in 'frmPrincipal.pas' {FormPrincipal},
  frmClientes in 'frmClientes.pas' {FormClientes};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Hola Mundo - Delphi 12';
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
