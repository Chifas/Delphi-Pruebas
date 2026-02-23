object FormClientes: TFormClientes
  Left = 0
  Top = 0
  Caption = 'Gesti'#243'n de Clientes'
  ClientHeight = 680
  ClientWidth = 1000
  Color = 16053490
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 1000
    Height = 72
    Align = alTop
    BevelOuter = bvNone
    Color = 3954494
    ParentBackground = False
    TabOrder = 0
    object lblTituloHeader: TLabel
      Left = 20
      Top = 12
      Width = 200
      Height = 28
      Caption = 'Gesti'#243'n de Clientes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSubHeader: TLabel
      Left = 22
      Top = 44
      Width = 280
      Height = 15
      Caption = 'Alta, baja y modificaci'#243'n de clientes  '#8212'  Firebird DB'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 11592640
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlToolbar: TPanel
    Left = 0
    Top = 72
    Width = 1000
    Height = 52
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    object btnNuevo: TButton
      Left = 12
      Top = 10
      Width = 110
      Height = 34
      Caption = '+ Nuevo'
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnNuevoClick
    end
    object btnEditar: TButton
      Left = 132
      Top = 10
      Width = 110
      Height = 34
      Caption = 'Editar'
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnEditarClick
    end
    object btnEliminar: TButton
      Left = 252
      Top = 10
      Width = 110
      Height = 34
      Caption = 'Eliminar'
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnEliminarClick
    end
    object btnActualizar: TButton
      Left = 372
      Top = 10
      Width = 110
      Height = 34
      Caption = 'Actualizar'
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btnActualizarClick
    end
    object lblBuscar: TLabel
      Left = 510
      Top = 18
      Width = 46
      Height = 15
      Caption = 'Buscar:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7368816
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edtBuscar: TEdit
      Left = 562
      Top = 12
      Width = 280
      Height = 28
      Hint = 'Buscar por nombre, apellido o email...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnChange = edtBuscarChange
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 124
    Width = 680
    Height = 516
    Align = alNone
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    object dbgClientes: TDBGrid
      Left = 0
      Top = 0
      Width = 680
      Height = 516
      Align = alClient
      DataSource = dsClientes
      DefaultDrawing = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ParentFont = False
      ReadOnly = True
      DefaultRowHeight = 26
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWhite
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = [fsBold]
      OnDblClick = dbgClientesDblClick
      OnDrawColumnCell = dbgClientesDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'ID_CLIENTE'
          Title.Caption = 'ID'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMBRE'
          Title.Caption = 'Nombre'
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'APELLIDO'
          Title.Caption = 'Apellido'
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMAIL'
          Title.Caption = 'Email'
          Width = 180
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TELEFONO'
          Title.Caption = 'Tel'#233'fono'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FECHA_ALTA'
          Title.Caption = 'Alta'
          Width = 80
          Visible = True
        end>
    end
  end
  object pnlEdicion: TPanel
    Left = 690
    Top = 124
    Width = 310
    Height = 516
    Anchors = [akTop, akRight, akBottom]
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 3
    Visible = False
    object pnlSeparador: TPanel
      Left = 0
      Top = 0
      Width = 4
      Height = 516
      Align = alLeft
      BevelOuter = bvNone
      Color = 2026899
      ParentBackground = False
      TabOrder = 0
    end
    object lblEdicionTitulo: TLabel
      Left = 20
      Top = 16
      Width = 120
      Height = 22
      Caption = 'Nuevo Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2026899
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblNombre: TLabel
      Left = 20
      Top = 60
      Width = 48
      Height = 15
      Caption = 'Nombre*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7368816
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edtNombre: TEdit
      Left = 20
      Top = 78
      Width = 270
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      TabOrder = 1
    end
    object lblApellido: TLabel
      Left = 20
      Top = 116
      Width = 52
      Height = 15
      Caption = 'Apellido*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7368816
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edtApellido: TEdit
      Left = 20
      Top = 134
      Width = 270
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      TabOrder = 2
    end
    object lblEmail: TLabel
      Left = 20
      Top = 172
      Width = 29
      Height = 15
      Caption = 'Email'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7368816
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edtEmail: TEdit
      Left = 20
      Top = 190
      Width = 270
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 150
      ParentFont = False
      TabOrder = 3
    end
    object lblTelefono: TLabel
      Left = 20
      Top = 228
      Width = 49
      Height = 15
      Caption = 'Tel'#233'fono'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7368816
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edtTelefono: TEdit
      Left = 20
      Top = 246
      Width = 270
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 30
      ParentFont = False
      TabOrder = 4
    end
    object lblDireccion: TLabel
      Left = 20
      Top = 284
      Width = 56
      Height = 15
      Caption = 'Direcci'#243'n'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7368816
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edtDireccion: TEdit
      Left = 20
      Top = 302
      Width = 270
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 200
      ParentFont = False
      TabOrder = 5
    end
    object btnGuardar: TButton
      Left = 20
      Top = 356
      Width = 128
      Height = 36
      Caption = 'Guardar'
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = btnGuardarClick
    end
    object btnCancelar: TButton
      Left = 162
      Top = 356
      Width = 128
      Height = 36
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = btnCancelarClick
    end
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 640
    Width = 1000
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    Color = 3954494
    ParentBackground = False
    TabOrder = 4
    object lblEstado: TLabel
      Left = 0
      Top = 12
      Width = 700
      Height = 15
      Caption = '  Listo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 11592640
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblContador: TLabel
      Left = 870
      Top = 12
      Width = 120
      Height = 15
      Alignment = taRightJustify
      Caption = '0 clientes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 11592640
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
  end
  object FDConnection: TFDConnection
    LoginPrompt = False
    Left = 880
    Top = 130
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    Left = 880
    Top = 190
  end
  object dsClientes: TDataSource
    DataSet = FDQuery
    Left = 880
    Top = 250
  end
end
