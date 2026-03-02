unit uTema;

{ ============================================================
  Sistema de temas Claro / Oscuro para la aplicacion FMX
  Todos los colores de la UI se definen aqui.
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
    // Acento (titulo de edicion)
    TxtAcento    : TAlphaColor;
    Separador    : TAlphaColor;  // Barra lateral izda del panel edicion
    // Boton de cambio de tema
    BtnTemaBG    : TAlphaColor;
    BtnTemaTxt   : TAlphaColor;
    BtnTemaTxt2  : string;       // Etiqueta del boton segun tema activo
  end;

// ---------------------------------------------------------------------------
// Colores de accion (iguales en ambos temas: siempre coloreados)
// ---------------------------------------------------------------------------
const
  CLR_BTN_SALUDAR   = TAlphaColor($FF1565C0); // Azul intenso
  CLR_BTN_CLIENTES  = TAlphaColor($FF2E7D32); // Verde intenso
  CLR_BTN_SALIR     = TAlphaColor($FFC62828); // Rojo intenso
  CLR_BTN_NUEVO     = TAlphaColor($FF2E7D32); // Verde
  CLR_BTN_EDITAR    = TAlphaColor($FF1565C0); // Azul
  CLR_BTN_ELIMINAR  = TAlphaColor($FFC62828); // Rojo
  CLR_BTN_ACTUALIZAR= TAlphaColor($FF37474F); // Gris azulado
  CLR_BTN_GUARDAR   = TAlphaColor($FF2E7D32); // Verde
  CLR_BTN_CANCELAR  = TAlphaColor($FF616161); // Gris
  CLR_BTN_TXT       = TAlphaColor($FFFFFFFF); // Blanco

var
  GTipoTema: TTipoTema = tmClaro;

function GetTema(Tipo: TTipoTema): TTemaColors;

implementation

function GetTema(Tipo: TTipoTema): TTemaColors;
begin
  case Tipo of
    tmClaro:
    begin
      Result.AppBG        := TAlphaColor($FFF0F2F5);
      Result.PanelBG      := TAlphaColor($FFFFFFFF);
      Result.HeaderBG     := TAlphaColor($FF1A237E);
      Result.FooterBG     := TAlphaColor($FF1A237E);
      Result.TxtFooter    := TAlphaColor($FFB0BEC5);
      Result.TxtNormal    := TAlphaColor($FF212121);
      Result.TxtSub       := TAlphaColor($FF616161);
      Result.TxtSubHeader := TAlphaColor($FFB0BEC5);
      Result.TxtTitulo    := TAlphaColor($FF1565C0);
      Result.TxtSubtitulo := TAlphaColor($FF757575);
      Result.TxtAcento    := TAlphaColor($FF1565C0);
      Result.Separador    := TAlphaColor($FF1565C0);
      Result.BtnTemaBG    := TAlphaColor($FF37474F);
      Result.BtnTemaTxt   := TAlphaColor($FFFFFFFF);
      Result.BtnTemaTxt2  := 'Modo Oscuro';
    end;
    tmOscuro:
    begin
      Result.AppBG        := TAlphaColor($FF121212);
      Result.PanelBG      := TAlphaColor($FF1E1E2E);
      Result.HeaderBG     := TAlphaColor($FF0D0D1A);
      Result.FooterBG     := TAlphaColor($FF0D0D1A);
      Result.TxtFooter    := TAlphaColor($FF8899BB);
      Result.TxtNormal    := TAlphaColor($FFE8E8F4);
      Result.TxtSub       := TAlphaColor($FFAAAACC);
      Result.TxtSubHeader := TAlphaColor($FF8899BB);
      Result.TxtTitulo    := TAlphaColor($FF82B1FF);
      Result.TxtSubtitulo := TAlphaColor($FF8899BB);
      Result.TxtAcento    := TAlphaColor($FF82B1FF);
      Result.Separador    := TAlphaColor($FF5C85D6);
      Result.BtnTemaBG    := TAlphaColor($FF82B1FF);
      Result.BtnTemaTxt   := TAlphaColor($FF121212);
      Result.BtnTemaTxt2  := 'Modo Claro';
    end;
  end;
end;

end.
