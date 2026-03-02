unit frmClientes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.Rtti,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts, FMX.Objects,
  FMX.Edit, FMX.Grid, FMX.Grid.Style, FMX.ScrollBox,
  Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.FMXUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TModoEdicion = (meNone, meNuevo, meEditar);

  TFormClientes = class(TForm)
    // --- Conexion Firebird ---
    FDConnection: TFDConnection;
    FDQuery: TFDQuery;

    // --- Layout principal ---
    rectFondo     : TRectangle;
    rectHeader    : TRectangle;
    layToolbar    : TLayout;
    layGrid       : TLayout;
    layEdicion    : TLayout;
    rectFooter    : TRectangle;

    // --- Header ---
    lblTituloHeader : TLabel;
    lblSubHeader    : TLabel;
    btnTemaCli      : TRectangle;
    txtBtnTemaCli   : TLabel;

    // --- Toolbar ---
    rectToolbar      : TRectangle;
    btnNuevo         : TRectangle;
    txtBtnNuevo      : TLabel;
    btnEditar        : TRectangle;
    txtBtnEditar     : TLabel;
    btnEliminar      : TRectangle;
    txtBtnEliminar   : TLabel;
    btnActualizar    : TRectangle;
    txtBtnActualizar : TLabel;
    lblBuscar        : TLabel;
    edtBuscar        : TEdit;

    // --- Grid ---
    grdClientes  : TStringGrid;
    colID        : TStringColumn;
    colNombre    : TStringColumn;
    colApellido  : TStringColumn;
    colEmail     : TStringColumn;
    colTelefono  : TStringColumn;
    colFechaAlta : TStringColumn;

    // --- Panel Edicion ---
    rectEdicion    : TRectangle;
    rectSeparador  : TRectangle;
    lblEdicionTitulo: TLabel;
    lblNombre      : TLabel;
    lblApellido    : TLabel;
    lblEmail       : TLabel;
    lblTelefono    : TLabel;
    lblDireccion   : TLabel;
    edtNombre      : TEdit;
    edtApellido    : TEdit;
    edtEmail       : TEdit;
    edtTelefono    : TEdit;
    edtDireccion   : TEdit;
    btnGuardar     : TRectangle;
    txtBtnGuardar  : TLabel;
    btnCancelar    : TRectangle;
    txtBtnCancelar : TLabel;

    // --- Footer ---
    lblEstado   : TLabel;
    lblContador : TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnActualizarClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnTemaCliClick(Sender: TObject);
    procedure edtBuscarChangeTracking(Sender: TObject);
    procedure grdClientesCellDblClick(const Column: TColumn; const Row: Integer);

  private
    FModoEdicion    : TModoEdicion;
    FIDClienteEditar: Integer;
    FIDList         : TArray<Integer>;

    procedure ConectarFirebird;
    procedure CargarClientes(const Filtro: string = '');
    procedure LimpiarEdicion;
    procedure MostrarEdicion(AVisible: Boolean);
    procedure CargarClienteEnEdicion;
    procedure ActualizarContador;
    procedure SetEstado(const Msg: string);
    procedure PoblarGrid;
    function  GetSelectedID: Integer;
    procedure AplicarTema;
    procedure SetRectEnabled(R: TRectangle; AEnabled: Boolean);
  end;

var
  FormClientes: TFormClientes;

implementation

{$R *.fmx}

uses
  uTema;

// ---------------------------------------------------------------------------
// FormCreate / Destroy
// ---------------------------------------------------------------------------
procedure TFormClientes.FormCreate(Sender: TObject);
begin
  FModoEdicion     := meNone;
  FIDClienteEditar := 0;
  MostrarEdicion(False);
  AplicarTema;

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
// Tema
// ---------------------------------------------------------------------------
procedure TFormClientes.AplicarTema;
var
  T: TTemaColors;
begin
  T := GetTema(GTipoTema);

  rectFondo.Fill.Color      := T.AppBG;
  rectHeader.Fill.Color     := T.HeaderBG;
  rectFooter.Fill.Color     := T.FooterBG;
  rectToolbar.Fill.Color    := T.PanelBG;
  rectEdicion.Fill.Color    := T.PanelBG;

  lblSubHeader.TextSettings.FontColor    := T.TxtSubHeader;
  lblBuscar.TextSettings.FontColor       := T.TxtSub;
  lblEdicionTitulo.TextSettings.FontColor:= T.TxtAcento;
  rectSeparador.Fill.Color               := T.Separador;

  lblNombre.TextSettings.FontColor    := T.TxtSub;
  lblApellido.TextSettings.FontColor  := T.TxtSub;
  lblEmail.TextSettings.FontColor     := T.TxtSub;
  lblTelefono.TextSettings.FontColor  := T.TxtSub;
  lblDireccion.TextSettings.FontColor := T.TxtSub;

  lblEstado.TextSettings.FontColor    := T.TxtFooter;
  lblContador.TextSettings.FontColor  := T.TxtFooter;

  btnTemaCli.Fill.Color                := T.BtnTemaBG;
  txtBtnTemaCli.TextSettings.FontColor := T.BtnTemaTxt;
  txtBtnTemaCli.Text                   := T.BtnTemaTxt2;
end;

procedure TFormClientes.btnTemaCliClick(Sender: TObject);
begin
  if GTipoTema = tmClaro then
    GTipoTema := tmOscuro
  else
    GTipoTema := tmClaro;
  AplicarTema;
end;

// ---------------------------------------------------------------------------
// Helper: habilitar/deshabilitar un boton-rectangulo visualmente
// ---------------------------------------------------------------------------
procedure TFormClientes.SetRectEnabled(R: TRectangle; AEnabled: Boolean);
begin
  R.Enabled := AEnabled;
  if AEnabled then
    R.Opacity := 1.0
  else
    R.Opacity := 0.35;
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
  FDConnection.Params.Add('CharacterSet=WIN1252');
  FDConnection.Params.Add('SQLDialect=1');
  FDConnection.LoginPrompt := False;
  FDConnection.Connected := True;
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
  FDQuery.FetchAll;
  PoblarGrid;
  ActualizarContador;
end;

// ---------------------------------------------------------------------------
// Poblar el StringGrid desde el FDQuery
// ---------------------------------------------------------------------------
procedure TFormClientes.PoblarGrid;
var
  Row: Integer;
begin
  grdClientes.RowCount := 0;

  if not FDQuery.Active then
    Exit;

  grdClientes.RowCount := FDQuery.RecordCount;
  SetLength(FIDList, FDQuery.RecordCount);

  FDQuery.First;
  Row := 0;
  while not FDQuery.Eof do
  begin
    FIDList[Row] := FDQuery.FieldByName('ID_CLIENTE').AsInteger;
    grdClientes.Cells[0, Row] := FDQuery.FieldByName('ID_CLIENTE').AsString;
    grdClientes.Cells[1, Row] := FDQuery.FieldByName('NOMBRE').AsString;
    grdClientes.Cells[2, Row] := FDQuery.FieldByName('APELLIDO').AsString;
    grdClientes.Cells[3, Row] := FDQuery.FieldByName('EMAIL').AsString;
    grdClientes.Cells[4, Row] := FDQuery.FieldByName('TELEFONO').AsString;
    grdClientes.Cells[5, Row] := FormatDateTime('dd/mm/yyyy',
      FDQuery.FieldByName('FECHA_ALTA').AsDateTime);
    FDQuery.Next;
    Inc(Row);
  end;
end;

// ---------------------------------------------------------------------------
// Obtener el ID del cliente seleccionado en el grid
// ---------------------------------------------------------------------------
function TFormClientes.GetSelectedID: Integer;
begin
  Result := -1;
  if (grdClientes.Selected >= 0) and (grdClientes.Selected < Length(FIDList)) then
    Result := FIDList[grdClientes.Selected];
end;

// ---------------------------------------------------------------------------
// Botones CRUD
// ---------------------------------------------------------------------------
procedure TFormClientes.btnNuevoClick(Sender: TObject);
begin
  FModoEdicion := meNuevo;
  FIDClienteEditar := 0;
  LimpiarEdicion;
  lblEdicionTitulo.Text := 'Nuevo Cliente';
  MostrarEdicion(True);
  edtNombre.SetFocus;
end;

procedure TFormClientes.btnEditarClick(Sender: TObject);
begin
  if (not FDQuery.Active) or (grdClientes.RowCount = 0) or
     (grdClientes.Selected < 0) then
  begin
    SetEstado('Seleccione un cliente para editar');
    Exit;
  end;

  FModoEdicion     := meEditar;
  FIDClienteEditar := GetSelectedID;

  FDQuery.First;
  while not FDQuery.Eof do
  begin
    if FDQuery.FieldByName('ID_CLIENTE').AsInteger = FIDClienteEditar then
      Break;
    FDQuery.Next;
  end;

  lblEdicionTitulo.Text := 'Editar Cliente';
  CargarClienteEnEdicion;
  MostrarEdicion(True);
  edtNombre.SetFocus;
end;

procedure TFormClientes.grdClientesCellDblClick(const Column: TColumn;
  const Row: Integer);
begin
  btnEditarClick(nil);
end;

procedure TFormClientes.btnEliminarClick(Sender: TObject);
var
  ID     : Integer;
  Nombre : string;
  SelRow : Integer;
begin
  if (not FDQuery.Active) or (grdClientes.RowCount = 0) or
     (grdClientes.Selected < 0) then
  begin
    SetEstado('Seleccione un cliente para eliminar');
    Exit;
  end;

  SelRow := grdClientes.Selected;
  ID     := FIDList[SelRow];
  Nombre := grdClientes.Cells[1, SelRow] + ' ' + grdClientes.Cells[2, SelRow];

  MessageDlg(
    Format('Eliminar al cliente "%s"? Esta accion no se puede deshacer.', [Nombre]),
    TMsgDlgType.mtWarning, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
    procedure(const AResult: TModalResult)
    begin
      if AResult <> mrYes then
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
          ShowMessage('Error al eliminar: ' + E.Message);
          SetEstado('Error al eliminar cliente');
        end;
      end;
    end
  );
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
  if Trim(edtNombre.Text) = '' then
  begin
    ShowMessage('El nombre es obligatorio.');
    edtNombre.SetFocus;
    Exit;
  end;
  if Trim(edtApellido.Text) = '' then
  begin
    ShowMessage('El apellido es obligatorio.');
    edtApellido.SetFocus;
    Exit;
  end;

  try
    if FModoEdicion = meNuevo then
    begin
      FDConnection.ExecSQL(
        'INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION, FECHA_ALTA) ' +
        'VALUES (:nom, :ape, :email, :tel, :dir, CURRENT_TIMESTAMP)',
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
      ShowMessage('Error al guardar: ' + E.Message);
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
procedure TFormClientes.edtBuscarChangeTracking(Sender: TObject);
begin
  if FDConnection.Connected then
    CargarClientes(edtBuscar.Text);
end;

// ---------------------------------------------------------------------------
// Helpers privados
// ---------------------------------------------------------------------------
procedure TFormClientes.LimpiarEdicion;
begin
  edtNombre.Text    := '';
  edtApellido.Text  := '';
  edtEmail.Text     := '';
  edtTelefono.Text  := '';
  edtDireccion.Text := '';
end;

procedure TFormClientes.MostrarEdicion(AVisible: Boolean);
begin
  // Ajustar Align del panel de edicion para que el grid ocupe el espacio correctamente
  if AVisible then
    layEdicion.Align := TAlignLayout.Right
  else
    layEdicion.Align := TAlignLayout.None;
  layEdicion.Visible := AVisible;

  SetRectEnabled(btnNuevo,    not AVisible);
  SetRectEnabled(btnEditar,   not AVisible);
  SetRectEnabled(btnEliminar, not AVisible);
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
    lblContador.Text := Format('%d cliente(s)', [FDQuery.RecordCount])
  else
    lblContador.Text := '0 clientes';
end;

procedure TFormClientes.SetEstado(const Msg: string);
begin
  lblEstado.Text := '  ' + Msg;
end;

end.
