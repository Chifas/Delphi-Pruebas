unit uTema;

{ ============================================================
  Sistema de temas Claro / Oscuro para la aplicacion FMX
  Paleta moderna: Indigo + Slate (inspirada en Tailwind CSS)
  ============================================================ }

interface

uses
  System.UITypes;

type
  TTipoTema = (tmClaro, tmOscuro);

  TTemaColors = record
    // Fondos
    AppBG        : TAlphaColor;  // Fondo general de la app
    PanelBG      : TAlphaColor;  // Toolbar, panel de edicion
    CardBG       : TAlphaColor;  // Tarjeta elevada (card)
    // Header / Footer
    HeaderBG     : TAlphaColor;
    FooterBG     : TAlphaColor;
    TxtFooter    : TAlphaColor;
    // Textos generales
    TxtNormal    : TAlphaColor;
    TxtSub       : TAlphaColor;  // Labels de campo
    TxtSubHeader : TAlphaColor;  // Subtitulo en header
    // Titulo principal (frmPrincipal)
    TxtTitulo    : TAlphaColor;
    TxtSubtitulo : TAlphaColor;
    // Acento (titulo de edicion, separador, tira de color)
    TxtAcento    : TAlphaColor;
    Separador    : TAlphaColor;
    // Boton de cambio de tema
    BtnTemaBG    : TAlphaColor;
    BtnTemaTxt   : TAlphaColor;
    BtnTemaTxt2  : string;       // Etiqueta del boton segun tema activo
  end;

// ---------------------------------------------------------------------------
// Colores de accion — paleta moderna Indigo / Emerald / Red / Slate
// ---------------------------------------------------------------------------
const
  CLR_BTN_SALUDAR    = TAlphaColor($FF6366F1); // Indigo-500
  CLR_BTN_CLIENTES   = TAlphaColor($FF10B981); // Emerald-500
  CLR_BTN_SALIR      = TAlphaColor($FFEF4444); // Red-500
  CLR_BTN_NUEVO      = TAlphaColor($FF10B981); // Emerald-500
  CLR_BTN_EDITAR     = TAlphaColor($FF6366F1); // Indigo-500
  CLR_BTN_ELIMINAR   = TAlphaColor($FFEF4444); // Red-500
  CLR_BTN_ACTUALIZAR = TAlphaColor($FF64748B); // Slate-500
  CLR_BTN_GUARDAR    = TAlphaColor($FF10B981); // Emerald-500
  CLR_BTN_CANCELAR   = TAlphaColor($FF64748B); // Slate-500
  CLR_BTN_TXT        = TAlphaColor($FFFFFFFF); // Blanco

var
  GTipoTema: TTipoTema = tmClaro;

function GetTema(Tipo: TTipoTema): TTemaColors;

implementation

function GetTema(Tipo: TTipoTema): TTemaColors;
begin
  case Tipo of
    tmClaro:
    begin
      Result.AppBG        := TAlphaColor($FFF1F5F9); // slate-100
      Result.PanelBG      := TAlphaColor($FFFFFFFF); // white
      Result.CardBG       := TAlphaColor($FFFFFFFF); // white
      Result.HeaderBG     := TAlphaColor($FF4338CA); // indigo-700
      Result.FooterBG     := TAlphaColor($FF1E293B); // slate-800
      Result.TxtFooter    := TAlphaColor($FF94A3B8); // slate-400
      Result.TxtNormal    := TAlphaColor($FF0F172A); // slate-900
      Result.TxtSub       := TAlphaColor($FF64748B); // slate-500
      Result.TxtSubHeader := TAlphaColor($FFCDD5F0); // indigo-200 (sobre header oscuro)
      Result.TxtTitulo    := TAlphaColor($FF6366F1); // indigo-500
      Result.TxtSubtitulo := TAlphaColor($FF64748B); // slate-500
      Result.TxtAcento    := TAlphaColor($FF6366F1); // indigo-500
      Result.Separador    := TAlphaColor($FF6366F1); // indigo-500
      Result.BtnTemaBG    := TAlphaColor($FF4338CA); // indigo-700
      Result.BtnTemaTxt   := TAlphaColor($FFFFFFFF); // white
      Result.BtnTemaTxt2  := 'Modo Oscuro';
    end;
    tmOscuro:
    begin
      Result.AppBG        := TAlphaColor($FF0F172A); // slate-900
      Result.PanelBG      := TAlphaColor($FF1E293B); // slate-800
      Result.CardBG       := TAlphaColor($FF1E293B); // slate-800
      Result.HeaderBG     := TAlphaColor($FF1E1B4B); // indigo-950
      Result.FooterBG     := TAlphaColor($FF0A0E1E); // casi negro
      Result.TxtFooter    := TAlphaColor($FF64748B); // slate-500
      Result.TxtNormal    := TAlphaColor($FFF1F5F9); // slate-100
      Result.TxtSub       := TAlphaColor($FF94A3B8); // slate-400
      Result.TxtSubHeader := TAlphaColor($FF818CF8); // indigo-400
      Result.TxtTitulo    := TAlphaColor($FF818CF8); // indigo-400
      Result.TxtSubtitulo := TAlphaColor($FF94A3B8); // slate-400
      Result.TxtAcento    := TAlphaColor($FF818CF8); // indigo-400
      Result.Separador    := TAlphaColor($FF6366F1); // indigo-500
      Result.BtnTemaBG    := TAlphaColor($FF818CF8); // indigo-400 (claro sobre oscuro)
      Result.BtnTemaTxt   := TAlphaColor($FF0F172A); // texto oscuro sobre boton claro
      Result.BtnTemaTxt2  := 'Modo Claro';
    end;
  end;
end;

end.
