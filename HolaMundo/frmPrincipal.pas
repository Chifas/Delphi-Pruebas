unit frmPrincipal;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Layouts,
  FMX.Objects,
  FMX.Effects;

type
  TFormPrincipal = class(TForm)
    rectFondo: TRectangle;
    layContenido: TLayout;
    lblTitulo: TLabel;
    lblSubtitulo: TLabel;
    layBotones: TLayout;
    btnSaludar: TButton;
    btnClientes: TButton;
    btnSalir: TButton;
    shadowTitulo: TShadowEffect;
    procedure btnSaludarClick(Sender: TObject);
    procedure btnClientesClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
  private
    { Declaraciones privadas }
  public
    { Declaraciones publicas }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  frmClientes;

{$R *.fmx}

procedure TFormPrincipal.btnSaludarClick(Sender: TObject);
begin
  ShowMessage(
    '!Hola Mundo!' + sLineBreak +
    sLineBreak +
    'Este es mi primer programa en Delphi 12.' + sLineBreak +
    'Embarcadero Delphi 12 - Version 29.0' + sLineBreak +
    'Ahora con FireMonkey (FMX)!'
  );
end;

procedure TFormPrincipal.btnClientesClick(Sender: TObject);
var
  Frm: TFormClientes;
begin
  Frm := TFormClientes.Create(Self);
  try
    Frm.ShowModal;
  finally
    Frm.Free;
  end;
end;

procedure TFormPrincipal.btnSalirClick(Sender: TObject);
begin
  MessageDlg('Desea salir de la aplicacion?',
    TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
    procedure(const AResult: TModalResult)
    begin
      if AResult = mrYes then
        Application.Terminate;
    end
  );
end;

end.
