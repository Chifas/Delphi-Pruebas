object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Hola Mundo - Delphi 12'
  ClientHeight = 300
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnlCentro: TPanel
    Left = 0
    Top = 0
    Width = 480
    Height = 300
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 0
      Top = 60
      Width = 480
      Height = 51
      Alignment = taCenter
      AutoSize = False
      Caption = #161'Hola Mundo!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7864319
      Font.Height = -37
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSubtitulo: TLabel
      Left = 0
      Top = 120
      Width = 480
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = 'Mi primer programa en Embarcadero'#174' Delphi 12'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object btnSaludar: TButton
      Left = 120
      Top = 200
      Width = 110
      Height = 40
      Caption = 'Saludar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnSaludarClick
    end
    object btnSalir: TButton
      Left = 250
      Top = 200
      Width = 110
      Height = 40
      Caption = 'Salir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnSalirClick
    end
  end
end
