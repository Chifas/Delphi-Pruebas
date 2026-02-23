unit frmClientes;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.Mask,
  Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

// ---------------------------------------------------------------------------
// Colores del tema moderno
// ---------------------------------------------------------------------------
const
  CLR_HEADER_BG   = $00292D3E;  // Gris azulado oscuro (fondo header)
  CLR_HEADER_TXT  = $00FFFFFF;  // Blanco
  CLR_BTN_NUEVO   = $0043A047;  // Verde moderno
  CLR_BTN_EDITAR  = $001E88E5;  // Azul moderno
  CLR_BTN_ELIMINAR= $00E53935;  // Rojo moderno
  CLR_BTN_GUARDAR = $0043A047;  // Verde
  CLR_BTN_CANCELAR= $00757575;  // Gris
  CLR_BTN_TXT     = $00FFFFFF;
  CLR_FORM_BG     = $00F5F5F5;  // Gris muy claro
  CLR_PANEL_BG    = $00FFFFFF;
  CLR_GRID_HDR    = $00455A64;  // Gris azulado grid header
  CLR_GRID_SEL    = $001565C0;  // Azul seleccion
  CLR_BORDER      = $00E0E0E0;
  CLR_ACCENT      = $001E88E5;  // Azul acento

type
  TFormClientes = class(TForm)
    // --- Conexion Firebird ---
    FDConnection: TFDConnection;
    FDQuery: TFDQuery;
    dsClientes: TDataSource;

    // --- Layout principal ---
    pnlHeader: TPanel;
    pnlToolbar: TPanel;
    pnlGrid: TPanel;
    pnlEdicion: TPanel;
    pnlFooter: TPanel;

    // --- Header ---
    lblTituloHeader: TLabel;
    lblSubHeader: TLabel;

    // --- Toolbar ---
    btnNuevo: TButton;
    btnEditar: TButton;
    btnEliminar: TButton;
    btnActualizar: TButton;
    edtBuscar: TEdit;
    lblBuscar: TLabel;

    // --- Grid ---
    dbgClientes: TDBGrid;
    sbGrid: TScrollBox;

    // --- Panel Edicion ---
    lblEdicionTitulo: TLabel;
    lblNombre: TLabel;
    lblApellido: TLabel;
    lblEmail: TLabel;
    lblTelefono: TLabel;
    lblDireccion: TLabel;
    edtNombre: TEdit;
    edtApellido: TEdit;
    edtEmail: TEdit;
    edtTelefono: TEdit;
    edtDireccion: TEdit;
    btnGuardar: TButton;
    btnCancelar: TButton;
    pnlSeparador: TPanel;

    // --- Footer ---
    lblEstado: TLabel;
    lblContador: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnActualizarClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtBuscarChange(Sender: TObject);
    procedure dbgClientesDblClick(Sender: TObject);
    procedure dbgClientesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);

  private
    FModoEdicion: (meNone, meNuevo, meEditar);
    FIDClienteEditar: Integer;

    procedure ConectarFirebird;
    procedure CargarClientes(const Filtro: string = '');
    procedure LimpiarEdicion;
    procedure MostrarEdicion(Visible: Boolean);
    procedure CargarClienteEnEdicion;
    procedure EstiloBoton(Btn: TButton);
    procedure ActualizarContador;
    procedure SetEstado(const Msg: string);
  public
  end;

var
  FormClientes: TFormClientes;

implementation

{$R *.dfm}

// ---------------------------------------------------------------------------
// FormCreate / Destroy
// ---------------------------------------------------------------------------
procedure TFormClientes.FormCreate(Sender: TObject);
begin
  FModoEdicion := meNone;
  FIDClienteEditar := 0;

  // Estilos del form
  Color := CLR_FORM_BG;
  Font.Name := 'Segoe UI';
  Font.Size := 9;

  // Header
  pnlHeader.Color     := CLR_HEADER_BG;
  pnlHeader.BevelOuter := bvNone;
  lblTituloHeader.Font.Color := CLR_HEADER_TXT;
  lblTituloHeader.Font.Size  := 16;
  lblTituloHeader.Font.Style := [fsBold];
  lblSubHeader.Font.Color    := $00B0BEC5;
  lblSubHeader.Font.Size     := 9;

  // Toolbar
  pnlToolbar.Color     := CLR_PANEL_BG;
  pnlToolbar.BevelOuter := bvNone;

  // Botones toolbar
  EstiloBoton(btnNuevo);
  EstiloBoton(btnEditar);
  EstiloBoton(btnEliminar);
  EstiloBoton(btnActualizar);

  // Buscar
  edtBuscar.Color    := CLR_PANEL_BG;
  edtBuscar.Font.Size := 9;

  // Grid
  pnlGrid.Color     := CLR_PANEL_BG;
  pnlGrid.BevelOuter := bvNone;
  dbgClientes.Color  := CLR_PANEL_BG;
  dbgClientes.Font.Size := 9;
  dbgClientes.TitleFont.Color := CLR_HEADER_TXT;
  dbgClientes.TitleFont.Style := [fsBold];

  // Panel edicion
  pnlEdicion.Color     := CLR_PANEL_BG;
  pnlEdicion.BevelOuter := bvNone;
  pnlSeparador.Color   := CLR_ACCENT;
  pnlSeparador.BevelOuter := bvNone;
  lblEdicionTitulo.Font.Size  := 11;
  lblEdicionTitulo.Font.Style := [fsBold];
  lblEdicionTitulo.Font.Color := CLR_ACCENT;
  EstiloBoton(btnGuardar);
  EstiloBoton(btnCancelar);

  // Footer
  pnlFooter.Color     := CLR_HEADER_BG;
  pnlFooter.BevelOuter := bvNone;
  lblEstado.Font.Color  := $00B0BEC5;
  lblContador.Font.Color := $00B0BEC5;

  MostrarEdicion(False);

  // Conectar a Firebird y cargar datos
  try
    ConectarFirebird;
    CargarClientes;
    SetEstado('Conectado a base de datos Firebird');
  except
    on E: Exception do
      SetEstado('Sin conexion a BD: ' + E.Message);
  end;
end;

procedure TFormClientes.FormDestroy(Sender: TObject);
begin
  if FDConnection.Connected then
    FDConnection.Connected := False;
end;

// ---------------------------------------------------------------------------
// Conexion Firebird via FireDAC
// ---------------------------------------------------------------------------
procedure TFormClientes.ConectarFirebird;
begin
  FDConnection.DriverName := 'FB';
  FDConnection.Params.Clear;
  FDConnection.Params.Add('DriverID=FB');
  FDConnection.Params.Add('Database=C:\Datos\Clientes.gdb');
  FDConnection.Params.Add('User_Name=SYSDBA');
  FDConnection.Params.Add('Password=masterkey');
  FDConnection.Params.Add('CharacterSet=UTF8');
  FDConnection.LoginPrompt := False;
  FDConnection.Connected   := True;
end;

// ---------------------------------------------------------------------------
// Cargar clientes (con filtro opcional)
// ---------------------------------------------------------------------------
procedure TFormClientes.CargarClientes(const Filtro: string);
var
  SQL: string;
begin
  SQL :=
    'SELECT ID_CLIENTE, NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION, ' +
    'FECHA_ALTA FROM CLIENTES';

  if Filtro <> '' then
    SQL := SQL + ' WHERE UPPER(NOMBRE) CONTAINING UPPER(:filtro) ' +
                 'OR UPPER(APELLIDO) CONTAINING UPPER(:filtro) ' +
                 'OR UPPER(EMAIL) CONTAINING UPPER(:filtro)';

  SQL := SQL + ' ORDER BY APELLIDO, NOMBRE';

  FDQuery.Active := False;
  FDQuery.SQL.Text := SQL;

  if Filtro <> '' then
    FDQuery.ParamByName('filtro').AsString := Filtro;

  FDQuery.Active := True;
  ActualizarContador;
end;

// ---------------------------------------------------------------------------
// Botones CRUD
// ---------------------------------------------------------------------------
procedure TFormClientes.btnNuevoClick(Sender: TObject);
begin
  FModoEdicion := meNuevo;
  FIDClienteEditar := 0;
  LimpiarEdicion;
  lblEdicionTitulo.Caption := 'Nuevo Cliente';
  MostrarEdicion(True);
  edtNombre.SetFocus;
end;

procedure TFormClientes.btnEditarClick(Sender: TObject);
begin
  if not FDQuery.Active or FDQuery.IsEmpty then
  begin
    SetEstado('Seleccione un cliente para editar');
    Exit;
  end;
  FModoEdicion := meEditar;
  FIDClienteEditar := FDQuery.FieldByName('ID_CLIENTE').AsInteger;
  lblEdicionTitulo.Caption := 'Editar Cliente';
  CargarClienteEnEdicion;
  MostrarEdicion(True);
  edtNombre.SetFocus;
end;

procedure TFormClientes.dbgClientesDblClick(Sender: TObject);
begin
  btnEditarClick(Sender);
end;

procedure TFormClientes.btnEliminarClick(Sender: TObject);
var
  ID: Integer;
  Nombre: string;
begin
  if not FDQuery.Active or FDQuery.IsEmpty then
  begin
    SetEstado('Seleccione un cliente para eliminar');
    Exit;
  end;

  ID     := FDQuery.FieldByName('ID_CLIENTE').AsInteger;
  Nombre := FDQuery.FieldByName('NOMBRE').AsString + ' ' +
            FDQuery.FieldByName('APELLIDO').AsString;

  if MessageDlg(
       Format('¿Eliminar al cliente "%s"? Esta accion no se puede deshacer.', [Nombre]),
       mtWarning, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  try
    FDConnection.ExecSQL(
      'DELETE FROM CLIENTES WHERE ID_CLIENTE = :id',
      [ID]
    );
    SetEstado(Format('Cliente "%s" eliminado correctamente', [Nombre]));
    CargarClientes(edtBuscar.Text);
  except
    on E: Exception do
    begin
      MessageDlg('Error al eliminar: ' + E.Message, mtError, [mbOK], 0);
      SetEstado('Error al eliminar cliente');
    end;
  end;
end;

procedure TFormClientes.btnActualizarClick(Sender: TObject);
begin
  edtBuscar.Text := '';
  CargarClientes;
  SetEstado('Datos actualizados');
end;

// ---------------------------------------------------------------------------
// Guardar (Nuevo o Editar)
// ---------------------------------------------------------------------------
procedure TFormClientes.btnGuardarClick(Sender: TObject);
begin
  // Validaciones basicas
  if Trim(edtNombre.Text) = '' then
  begin
    MessageDlg('El nombre es obligatorio.', mtWarning, [mbOK], 0);
    edtNombre.SetFocus;
    Exit;
  end;
  if Trim(edtApellido.Text) = '' then
  begin
    MessageDlg('El apellido es obligatorio.', mtWarning, [mbOK], 0);
    edtApellido.SetFocus;
    Exit;
  end;

  try
    if FModoEdicion = meNuevo then
    begin
      FDConnection.ExecSQL(
        'INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION, FECHA_ALTA) ' +
        'VALUES (:nom, :ape, :email, :tel, :dir, CURRENT_DATE)',
        [Trim(edtNombre.Text), Trim(edtApellido.Text),
         Trim(edtEmail.Text), Trim(edtTelefono.Text),
         Trim(edtDireccion.Text)]
      );
      SetEstado('Cliente agregado correctamente');
    end
    else
    begin
      FDConnection.ExecSQL(
        'UPDATE CLIENTES SET NOMBRE=:nom, APELLIDO=:ape, EMAIL=:email, ' +
        'TELEFONO=:tel, DIRECCION=:dir WHERE ID_CLIENTE=:id',
        [Trim(edtNombre.Text), Trim(edtApellido.Text),
         Trim(edtEmail.Text), Trim(edtTelefono.Text),
         Trim(edtDireccion.Text), FIDClienteEditar]
      );
      SetEstado('Cliente actualizado correctamente');
    end;

    MostrarEdicion(False);
    FModoEdicion := meNone;
    CargarClientes(edtBuscar.Text);
  except
    on E: Exception do
    begin
      MessageDlg('Error al guardar: ' + E.Message, mtError, [mbOK], 0);
      SetEstado('Error al guardar cliente');
    end;
  end;
end;

procedure TFormClientes.btnCancelarClick(Sender: TObject);
begin
  FModoEdicion := meNone;
  MostrarEdicion(False);
  SetEstado('Operacion cancelada');
end;

// ---------------------------------------------------------------------------
// Busqueda en tiempo real
// ---------------------------------------------------------------------------
procedure TFormClientes.edtBuscarChange(Sender: TObject);
begin
  if FDConnection.Connected then
    CargarClientes(edtBuscar.Text);
end;

// ---------------------------------------------------------------------------
// Dibujo custom del Grid (filas alternadas)
// ---------------------------------------------------------------------------
procedure TFormClientes.dbgClientesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if gdSelected in State then
  begin
    dbgClientes.Canvas.Brush.Color := CLR_GRID_SEL;
    dbgClientes.Canvas.Font.Color  := clWhite;
  end
  else if (FDQuery.RecNo mod 2 = 0) then
  begin
    dbgClientes.Canvas.Brush.Color := $00F8F9FA;
    dbgClientes.Canvas.Font.Color  := clBlack;
  end
  else
  begin
    dbgClientes.Canvas.Brush.Color := clWhite;
    dbgClientes.Canvas.Font.Color  := clBlack;
  end;

  dbgClientes.Canvas.FillRect(Rect);
  dbgClientes.Canvas.TextRect(
    Rect,
    Rect.Left + 4,
    Rect.Top + 3,
    Column.Field.DisplayText
  );
end;

// ---------------------------------------------------------------------------
// Helpers privados
// ---------------------------------------------------------------------------
procedure TFormClientes.EstiloBoton(Btn: TButton);
begin
  Btn.Font.Style := [fsBold];
  Btn.Font.Size  := 9;
  Btn.Cursor     := crHandPoint;
end;

procedure TFormClientes.LimpiarEdicion;
begin
  edtNombre.Text    := '';
  edtApellido.Text  := '';
  edtEmail.Text     := '';
  edtTelefono.Text  := '';
  edtDireccion.Text := '';
end;

procedure TFormClientes.MostrarEdicion(Visible: Boolean);
begin
  pnlEdicion.Visible := Visible;
  btnEditar.Enabled  := not Visible;
  btnEliminar.Enabled := not Visible;
  btnNuevo.Enabled   := not Visible;
end;

procedure TFormClientes.CargarClienteEnEdicion;
begin
  edtNombre.Text    := FDQuery.FieldByName('NOMBRE').AsString;
  edtApellido.Text  := FDQuery.FieldByName('APELLIDO').AsString;
  edtEmail.Text     := FDQuery.FieldByName('EMAIL').AsString;
  edtTelefono.Text  := FDQuery.FieldByName('TELEFONO').AsString;
  edtDireccion.Text := FDQuery.FieldByName('DIRECCION').AsString;
end;

procedure TFormClientes.ActualizarContador;
begin
  if FDQuery.Active then
    lblContador.Caption := Format('%d cliente(s)', [FDQuery.RecordCount])
  else
    lblContador.Caption := '0 clientes';
end;

procedure TFormClientes.SetEstado(const Msg: string);
begin
  lblEstado.Caption := '  ' + Msg;
  Application.ProcessMessages;
end;

end.
