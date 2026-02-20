unit frmPrincipal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TFormPrincipal = class(TForm)
    pnlCentro: TPanel;
    lblTitulo: TLabel;
    lblSubtitulo: TLabel;
    btnSaludar: TButton;
    btnSalir: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSaludarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
  private
    { Declaraciones privadas }
  public
    { Declaraciones publicas }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  // Centramos el formulario al iniciar
  Self.Position := poScreenCenter;
end;

procedure TFormPrincipal.btnSaludarClick(Sender: TObject);
begin
  ShowMessage(
    '¡Hola Mundo!' + sLineBreak +
    sLineBreak +
    'Este es mi primer programa en Delphi 12.' + sLineBreak +
    'Embarcadero® Delphi 12 - Version 29.0'
  );
end;

procedure TFormPrincipal.btnSalirClick(Sender: TObject);
begin
  if MessageDlg('¿Desea salir de la aplicacion?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Application.Terminate;
end;

end.
