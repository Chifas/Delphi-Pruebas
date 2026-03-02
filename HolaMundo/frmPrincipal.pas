unit frmPrincipal;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
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
    rectFondo     : TRectangle;
    layContenido  : TLayout;
    lblTitulo     : TLabel;
    shadowTitulo  : TShadowEffect;
    lblSubtitulo  : TLabel;
    layBotones    : TLayout;
    btnSaludar    : TRectangle;
    txtBtnSaludar : TLabel;
    btnClientes   : TRectangle;
    txtBtnClientes: TLabel;
    btnSalir      : TRectangle;
    txtBtnSalir   : TLabel;
    btnTema       : TRectangle;
    txtBtnTema    : TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSaludarClick(Sender: TObject);
    procedure btnClientesClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure btnTemaClick(Sender: TObject);
  private
    procedure AplicarTema;
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  frmClientes,
  uTema;

{$R *.fmx}

// ---------------------------------------------------------------------------
// FormCreate
// ---------------------------------------------------------------------------
procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  AplicarTema;
end;

// ---------------------------------------------------------------------------
// Tema
// ---------------------------------------------------------------------------
procedure TFormPrincipal.AplicarTema;
var
  T: TTemaColors;
begin
  T := GetTema(GTipoTema);

  rectFondo.Fill.Color       := T.AppBG;
  lblTitulo.TextSettings.FontColor    := T.TxtTitulo;
  lblSubtitulo.TextSettings.FontColor := T.TxtSubtitulo;

  btnTema.Fill.Color               := T.BtnTemaBG;
  txtBtnTema.TextSettings.FontColor := T.BtnTemaTxt;
  txtBtnTema.Text                  := T.BtnTemaTxt2;
end;

procedure TFormPrincipal.btnTemaClick(Sender: TObject);
begin
  if GTipoTema = tmClaro then
    GTipoTema := tmOscuro
  else
    GTipoTema := tmClaro;
  AplicarTema;
end;

// ---------------------------------------------------------------------------
// Acciones
// ---------------------------------------------------------------------------
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
