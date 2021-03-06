unit tTManualTecnico;

interface

uses
  classes, uTLatexExporter, dialogs, contnrs, Winapi.Windows, ShellApi,
  System.SysUtils,
  Utilidades;

type

  TVentana = class(TObject)
  private
    FNombre: string;
    FDescripcion: string;
    FParte, FDescripcionParte: TStringList;

    procedure setDescripcion(const Value: string);
    procedure setNombre(const Value: string);
  public
    constructor create;
    destructor destroy; override;

    procedure agregarParte(nombre, descripcion: string);
  published
    property nombre: string read FNombre write setNombre;
    property descripcion: string read FDescripcion write setDescripcion;
  end;

  TDescripcionVentanas = class(TObject)
  private
    FVentanas: TObjectList;

  public
    constructor create;
    destructor destroy; override;
  published
  end;

  TCodigoDescripcion = record
    Ruta, descripcion: string;
  end;

  TCarpetaCodigo = class(TObject)
  private
    SLRutasCodigo: TStringList;
    SLDescripcionCodigo: TStringList;
    FNombre: string;
    FDescripcion: string;
    function getCount: integer;
    procedure setDescripcion(const Value: string);
  public
    constructor create(nombre: string);
    destructor destroy; override;

    procedure agregarCodigo(Ruta, descripcion: string);
    function obtenerCodigo(id: integer): TCodigoDescripcion;
  published
    property nombre: string read FNombre;
    property Count: integer read getCount;
    property descripcion: string read FDescripcion write setDescripcion;
  end;

  TCarpetasCodigos = class(TObject)
  private
    FCarpetas: TObjectList;
    FCount: integer;
    FCarpetaTemp: integer;
    FRutaActual: string;
    function getCount: integer;
    procedure setRutaActual(const Value: string);

    procedure _agregarCodigo(Ruta, descripcion: string; carpeta: integer);
  public
    constructor create;
    destructor destroy; override;

    function agregarCarpeta(nombre, descripcion: string): integer;
    function obtenerCarpeta(id: integer): TCarpetaCodigo;

    procedure agregarCodigo(nombre, descripcion: string);
  published
    property Count: integer read getCount;
    property RutaActual: string read FRutaActual write setRutaActual;
  end;

  TPasoInstalacion = record
    Titulo, descripcion, Imagen: string;
  end;

  TLinkDescargaManual = record
    Usuario: string;
    Tecnico: string;
    Codigo: string;
  end;

  TManualTecnico = class(TObject)
  private
    LEManTec: TLatexExporter;
    LEManCod: TLatexExporter;
    LEManUse: TLatexExporter;
    SLAutores: TStringList;
    SLIntroduccion: TStringList;
    SLSoftwareSimilares: TStringList;
    SLDescripcion: TStringList;
    SLRequisitosInstalacion: TStringList;
    SLImagenes: TStringList;
    SLHerramientasDesarrollo: TStringList;
    SLInstalacion: TStringList;
    SLBibliografia: TStringList;

    FrutaExportar: string;
    FIp, FRuta: string;
    FTitulo: string;
    FSubtitulo: string;
    FAutoresCorto: string;
    FVersion: string;
    FUniversidad: string;
    FFecha: string;
    FCiudad: string;
    FPrograma: string;
    FFacultad: string;
    FGrupo: string;
    FObjetivo: string;
    FEsAplicacionEscritorio: boolean;
    FnombreManualTecnico: string;
    FHandle: HWND;
    FnombreManualCodigo: string;
    FnombreManualUsuario: string;
    FCarpetasCodigo: TCarpetasCodigos;

    procedure setrutaExportar(const Value: string);
    procedure setTitulo(const Value: string);
    procedure setSubtitulo(const Value: string);
    procedure setAutoresCorto(const Value: string);
    procedure setCiudad(const Value: string);
    procedure setFacultad(const Value: string);
    procedure setFecha(const Value: string);
    procedure setGrupo(const Value: string);
    procedure setPrograma(const Value: string);
    procedure setUniversidad(const Value: string);
    procedure setVersion(const Value: string);
    procedure setObjetivo(const Value: string);
    procedure setEsAplicacionEscritorio(const Value: boolean);
    procedure setnombreManual(const Value: string);
    procedure setHandle(const Value: HWND);
    procedure setnombreManualCodigo(const Value: string);
    procedure setnombreManualUsuario(const Value: string);
    procedure setCarpetasCodigo(const Value: TCarpetasCodigos);
  public
    constructor create;
    destructor destroy;

    procedure exportarManualTecnico;
    procedure exportarManualCodigoFuente;
    procedure exportarManualUsuario;

    procedure exportarArchivoRC;
    procedure exportarImagenes;

    procedure agregarAutor(ss: string);

    procedure agregarIntroduccion(ss: string);
    procedure leerIntroduccion(Ruta: string);
    procedure agregarDescripcion(ss: string);
    procedure leerDescripcion(Ruta: string);
    procedure agregarHerramientasDesarrollo(ss: string);
    procedure leerHerramientasDesarrollo(Ruta: string);
    procedure agregarRequisitoSistema(ss: string);
    procedure leerRequisitosSistema(Ruta: string);
    procedure agregarPasoInstalacion(ss: string);
    procedure leerPasosInstalacion(Ruta: string);
    procedure agregarBibliografia(ss: string);
    procedure leerBibliografia(Ruta: string);

    procedure agregarImagen(nombre: string);
    procedure agregarSoftwareSimilar(nombre: string);

    procedure datosDescarga(ip, Ruta: string);
    function rutaDescargaHttp: TLinkDescargaManual;
  published
    property Handle: HWND read FHandle write setHandle;

    property rutaExportar: string read FrutaExportar write setrutaExportar;
    property nombreManualTecnico: string read FnombreManualTecnico
      write setnombreManual;
    property nombreManualUsuario: string read FnombreManualUsuario
      write setnombreManualUsuario;
    property nombreManualCodigo: string read FnombreManualCodigo
      write setnombreManualCodigo;

    property Titulo: string read FTitulo write setTitulo;
    property Subtitulo: string read FSubtitulo write setSubtitulo;
    property AutoresCorto: string read FAutoresCorto write setAutoresCorto;
    property Universidad: string read FUniversidad write setUniversidad;
    property Facultad: string read FFacultad write setFacultad;
    property Programa: string read FPrograma write setPrograma;
    property Grupo: string read FGrupo write setGrupo;
    property Ciudad: string read FCiudad write setCiudad;
    property Fecha: string read FFecha write setFecha;
    property Version: string read FVersion write setVersion;
    property Objetivo: string read FObjetivo write setObjetivo;
    property EsAplicacionEscritorio: boolean read FEsAplicacionEscritorio
      write setEsAplicacionEscritorio;

    property CarpetasCodigo: TCarpetasCodigos read FCarpetasCodigo
      write setCarpetasCodigo;
  end;

implementation

{ TManualTecnico }

{$R Win32/Debug/Recursos/Latex.RES}

procedure TManualTecnico.agregarAutor(ss: string);
begin
  SLAutores.Add(ss);
end;

procedure TManualTecnico.agregarBibliografia(ss: string);
begin

end;

procedure TManualTecnico.agregarDescripcion(ss: string);
begin
  SLDescripcion.Add(ss);
end;

procedure TManualTecnico.agregarHerramientasDesarrollo(ss: string);
begin

end;

procedure TManualTecnico.agregarImagen(nombre: string);
begin
  SLImagenes.Add(nombre);
end;

procedure TManualTecnico.agregarIntroduccion(ss: string);
begin
  SLIntroduccion.Add(ss);
end;

procedure TManualTecnico.agregarPasoInstalacion(ss: string);
begin
  SLInstalacion.Add(ss);
end;

procedure TManualTecnico.agregarRequisitoSistema(ss: string);
begin
  SLRequisitosInstalacion.Add(ss);
end;

procedure TManualTecnico.agregarSoftwareSimilar(nombre: string);
begin
  SLSoftwareSimilares.Add(nombre);
end;

constructor TManualTecnico.create;
begin
  SLAutores := TStringList.create;
  SLIntroduccion := TStringList.create;
  SLDescripcion := TStringList.create;
  SLSoftwareSimilares := TStringList.create;
  SLRequisitosInstalacion := TStringList.create;
  SLImagenes := TStringList.create;
  SLHerramientasDesarrollo := TStringList.create;
  SLInstalacion := TStringList.create;
  SLBibliografia := TStringList.create;

  FCarpetasCodigo := TCarpetasCodigos.create;

  LEManTec := TLatexExporter.create;
  LEManCod := TLatexExporter.create;
  LEManUse := TLatexExporter.create;
end;

procedure TManualTecnico.datosDescarga(ip, Ruta: string);
begin
  FIp := ip;
  FRuta := Ruta;
end;

destructor TManualTecnico.destroy;
begin

end;

procedure TManualTecnico.exportarArchivoRC;
var
  Ruta: string;
  archivo, batFile, pasFile: TStringList;
  nombre, nombreUC, nombreCarpeta: string;
  i: integer;
  j: integer;
begin
  Ruta := ExtractFilePath(ParamStr(0)) + '\Recursos';
  if not DirectoryExists(Ruta) then
    CreateDir(Ruta);

  archivo := TStringList.create;
  batFile := TStringList.create;
  pasFile := TStringList.create;

  for i := 1 to SLImagenes.Count do
  begin
    nombre := SLImagenes[i - 1];
    nombreUC := UpperCase(StringReplace(nombre, '.', '_', [rfReplaceAll]));

    archivo.Add(nombreUC + ' RCDATA "' + nombre + '"');

    pasFile.Add('Recursos := TResourceStream.create(HInstance, ' + #39 +
      nombreUC + #39 + ', RT_RCDATA);');
    pasFile.Add('Recursos.SaveToFile(directorio + ' + #39 + '\Imagenes\' +
      nombre + #39 + ');');
    pasFile.Add('Recursos.Free;');
    pasFile.Add('');
  end;

  { Exportar el archivo en la ruta }
  archivo.SaveToFile(Ruta + '\Imagenes.rc');

  batFile.Add('@echo off');
  batFile.Add('title Creando Recursos RecursosSAE.RES');
  batFile.Add('cd ' + Ruta);
  batFile.Add('echo Paquete de recursos creado. Presione ENTER para salir.');
  batFile.Add('brc32 -r -v Imagenes.rc');
  batFile.Add('exit');
  batFile.SaveToFile(Ruta + '\CompilarRecursos.bat');

  pasFile.Add(ExtractFilePath(ParamStr(0)));
  pasFile.Add(ExtractFilePath(ParamStr(0) + '..\..\..'));
  pasFile.SaveToFile(Ruta + '\codigoManua.pas');

  { Ejecutar el bat para generar el Imagenes.RES }

  ShellExecute(Handle, 'open', pchar(Ruta + '\CompilarRecursos.bat'), nil, nil,
    SW_NORMAL);
end;

procedure TManualTecnico.exportarImagenes;
var
  Recursos: TResourceStream;
  i: integer;
  j: integer;
  Ruta: string;
  nombreUC, nombre: string;
  nCarpeta: TCarpetaCodigo;
begin

  { Determinar si la carpeta de Im?genes Existe }
  Ruta := FrutaExportar + '\Imagenes';

  if not DirectoryExists(Ruta) then
    CreateDir(Ruta);

  for i := 1 to SLImagenes.Count do
  begin
    nombre := SLImagenes[i - 1];
    nombreUC := UpperCase(StringReplace(nombre, '.', '_', [rfReplaceAll]));

    Recursos := TResourceStream.create(HInstance, nombreUC, RT_RCDATA);
    Recursos.SaveToFile(FrutaExportar + '\Imagenes\' + nombre);
    Recursos.Free;
  end;
end;

procedure TManualTecnico.exportarManualCodigoFuente;
var
  i, j, ld: integer;
  LCodigo: TStringList;
  nombre, descripcion, Ruta: string;
  CarpetaCodigo: TCarpetaCodigo;
  Encoding: TEncoding;
begin
  LEManCod.documentClass('12pt,landscape,twoside,spanish', 'Plantilla');

  LEManCod.usePackage('fontenc', 'T1');
  LEManCod.usePackage('inputenc', 'latin9');
  LEManCod.usePackage('inputenc', 'letterpaper');
  LEManCod.usePackage('babel');
  LEManCod.usePackage('array');
  LEManCod.usePackage('longtable');
  LEManCod.usePackage('pifont');
  LEManCod.usePackage('float');
  LEManCod.usePackage('textcomp');
  LEManCod.usePackage('url');
  LEManCod.usePackage('graphicx');
  LEManCod.usePackage('Plantilla');
  LEManCod.usePackage('fancyhdr');
  LEManCod.usePackage('hyperref', 'unicode=true,pdfusetitle,bookmarks=true,' +
    'bookmarksnumbered=false,bookmarksopen=false,breaklinks=false,' +
    'pdfborder={0 0 0},pdfborderstyle={},backref=false,colorlinks=false');

  LEManCod.pagestyle('fancy');
  LEManCod.setcounter('secnumdepth', '3');
  LEManCod.setcounter('tocdepth', '1');

  LEManCod.geometry('3cm', '3cm', '3cm', '3cm', '1cm', '1cm', '1cm');

  LEManCod.agregarLinea('\addto\shorthandsspanish{\spanishdeactivate{~<>.}}');

  LEManCod.makeatletter;
  LEManCod.agregarLinea('\providecommand{\tabularnewline}{\\}');

  LEManCod.agregarLinea('\AtBeginDocument{');
  LEManCod.agregarLinea('  \def\labelitemi{\ding{111}}');
  LEManCod.agregarLinea('  \def\labelitemii{\ding{109}}');
  LEManCod.agregarLinea('  \def\labelitemiii{\ding{237}}');
  LEManCod.agregarLinea('  \def\labelitemiv{\(\bullet\)}');
  LEManCod.agregarLinea('}');

  LEManCod.makeatother;

  LEManCod.defineLenguajeHTML;
  LEManCod.defineLenguajePascal;
  LEManCod.defineLenguajeTypeScript;
  LEManCod.defineLenguajeCss;

  LEManCod.agregarLinea('');
  LEManCod.beginEnviroment('document');
  LEManCod.agregarLinea('');

  { Datos de la Aplicaci?n $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
  LEManCod.Titulo(FTitulo);
  LEManCod.Subtitulo(FSubtitulo);

  LEManCod.agregarLinea('\Autores{%');
  LEManCod.agregarLinea('\begin{tabular}{c}');
  for i := 1 to SLAutores.Count do
  begin
    LEManCod.agregarLinea(SLAutores[i - 1] + '\tabularnewline');
  end;
  LEManCod.agregarLinea('\end{tabular}}');

  LEManCod.agregarLinea('\AutoresCorto{' + FAutoresCorto + '}');
  LEManCod.agregarLinea('');
  LEManCod.agregarLinea('\Institucion{' + FUniversidad + '}');
  LEManCod.agregarLinea('');
  LEManCod.agregarLinea('\Facultad{' + FFacultad + '}');
  LEManCod.agregarLinea('');
  LEManCod.agregarLinea('\Programa{' + FPrograma + '}');
  LEManCod.agregarLinea('');
  LEManCod.agregarLinea('\Grupo{' + FGrupo + '}');
  LEManCod.agregarLinea('');
  LEManCod.agregarLinea('\Ciudad{' + FCiudad + '}');
  LEManCod.agregarLinea('');
  LEManCod.agregarLinea('\Fecha{' + FFecha + '}');
  LEManCod.agregarLinea('');
  LEManCod.agregarLinea('\TipoCapitulo{Proyecto}');
  LEManCod.agregarLinea('');
  LEManCod.agregarLinea('.');
  LEManCod.agregarLinea('');

  { Generar la portada principal $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
  LEManCod.agregarLinea
    ('\PortadaInicial{\includegraphics[width=6cm]{Imagenes/man_Logo}}{' +
    FTitulo + '}{Versi?n ' + FVersion + '}{C?digo Fuente}{}');
  LEManCod.agregarLinea('');
  LEManCod.agregarLinea('\GenerarPortada{}');
  LEManCod.agregarLinea('');
  LEManCod.agregarLinea('\DerechosAutor{}{}');
  LEManCod.agregarLinea('');
  LEManCod.agregarLinea('\tableofcontents{}');
  LEManCod.agregarLinea('');

  { Agregar la Introducci?n $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
  LEManCod.agregarLinea('\chapter*{Introducci?n}');
  LEManCod.agregarLinea('');
  for i := 1 to SLIntroduccion.Count do
  begin
    LEManCod.agregarLinea(SLIntroduccion[i - 1] + ' \\');
  end;

  for i := 1 to FCarpetasCodigo.Count do
  begin
    CarpetaCodigo := FCarpetasCodigo.obtenerCarpeta(i - 1);
    nombre := CarpetaCodigo.nombre;
    descripcion := CarpetaCodigo.descripcion;

    LEManCod.chapter(nombre);
    LEManCod.agregarLinea(descripcion);

    for j := 1 to CarpetaCodigo.Count do
    begin
      try
        LCodigo := TStringList.create;

        Ruta := CarpetaCodigo.obtenerCodigo(j - 1).Ruta;
        descripcion := CarpetaCodigo.obtenerCodigo(j - 1).descripcion;

        Encoding := TUTF8Encoding.create;
        LCodigo.LoadFromFile(Ruta, Encoding);

        ld := LastDelimiter('\', Ruta);
        nombre := Copy(Ruta, ld + 1, length(Ruta) - ld);
        nombre := StringReplace(nombre, '_', '\_', [rfReplaceAll]);
        LEManCod.section(nombre);
        LEManCod.agregarLinea(descripcion);

        LEManCod.agregarCodigo(LCodigo, nombre);

        LCodigo.Free;
      except
        on E: Exception do
        begin
          LEManCod.guardarCopia;
        end;
      end;
    end;
  end;

  LEManCod.endEnviroment('document');

  LEManCod.exportarCompilar(FrutaExportar + '\' + FnombreManualCodigo);
end;

procedure TManualTecnico.exportarManualTecnico;
var
  i: integer;
begin
  LEManTec.documentClass('12pt,twoside,spanish', 'Plantilla');

  LEManTec.usePackage('fontenc', 'T1');
  LEManTec.usePackage('inputenc', 'latin9');
  LEManTec.usePackage('inputenc', 'letterpaper');
  LEManTec.usePackage('babel');
  LEManTec.usePackage('array');
  LEManTec.usePackage('longtable');
  LEManTec.usePackage('pifont');
  LEManTec.usePackage('float');
  LEManTec.usePackage('textcomp');
  LEManTec.usePackage('url');
  LEManTec.usePackage('graphicx');
  LEManTec.usePackage('Plantilla');
  LEManTec.usePackage('fancyhdr');
  LEManTec.usePackage('hyperref', 'unicode=true,pdfusetitle,bookmarks=true,' +
    'bookmarksnumbered=false,bookmarksopen=false,breaklinks=false,' +
    'pdfborder={0 0 0},pdfborderstyle={},backref=false,colorlinks=false');

  LEManTec.pagestyle('fancy');
  LEManTec.setcounter('secnumdepth', '3');
  LEManTec.setcounter('tocdepth', '1');

  LEManTec.geometry('5cm', '3cm', '3cm', '3cm', '1cm', '1cm', '1cm');

  LEManTec.agregarLinea('\addto\shorthandsspanish{\spanishdeactivate{~<>.}}');

  LEManTec.makeatletter;
  LEManTec.agregarLinea('\providecommand{\tabularnewline}{\\}');

  LEManTec.agregarLinea('\AtBeginDocument{');
  LEManTec.agregarLinea('  \def\labelitemi{\ding{111}}');
  LEManTec.agregarLinea('  \def\labelitemii{\ding{109}}');
  LEManTec.agregarLinea('  \def\labelitemiii{\ding{237}}');
  LEManTec.agregarLinea('  \def\labelitemiv{\(\bullet\)}');
  LEManTec.agregarLinea('}');

  LEManTec.makeatother;

  LEManTec.agregarLinea('');
  LEManTec.beginEnviroment('document');
  LEManTec.agregarLinea('');

  { Datos de la Aplicaci?n $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
  LEManTec.Titulo(FTitulo);
  LEManTec.Subtitulo(FSubtitulo);

  LEManTec.agregarLinea('\Autores{%');
  LEManTec.agregarLinea('\begin{tabular}{c}');
  for i := 1 to SLAutores.Count do
  begin
    LEManTec.agregarLinea(SLAutores[i - 1] + '\tabularnewline');
  end;
  LEManTec.agregarLinea('\end{tabular}}');

  LEManTec.agregarLinea('\AutoresCorto{' + FAutoresCorto + '}');
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\Institucion{' + FUniversidad + '}');
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\Facultad{' + FFacultad + '}');
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\Programa{' + FPrograma + '}');
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\Grupo{' + FGrupo + '}');
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\Ciudad{' + FCiudad + '}');
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\Fecha{' + FFecha + '}');
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\TipoCapitulo{Secci?n}');
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('.');
  LEManTec.agregarLinea('');

  { Generar la portada principal $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
  LEManTec.agregarLinea
    ('\PortadaInicial{\includegraphics[width=6cm]{Imagenes/man_Logo}}{' +
    FTitulo + '}{Versi?n ' + FVersion + '}{Manual T?cnico}{}');
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\GenerarPortada{}');
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\DerechosAutor{}{}');
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\tableofcontents{}');
  LEManTec.agregarLinea('');

  { Agregar la Introducci?n $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
  LEManTec.agregarLinea('\chapter*{Introducci?n}');
  LEManTec.agregarLinea('');
  for i := 1 to SLIntroduccion.Count do
  begin
    LEManTec.agregarLinea(SLIntroduccion[i - 1] + ' \\');
  end;

  { Descripci?n de la aplicaci?n $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
  LEManTec.agregarLinea('\chapter{' + FTitulo + '}');
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\Descripcion{');
  LEManTec.agregarLinea('\noindent\begin{minipage}[t]{1\columnwidth}');
  LEManTec.agregarLinea('En esta secci?n se explicar?:');
  LEManTec.agregarLinea('\begin{itemize}');
  LEManTec.agregarLinea('\item C?mo instalar el software \NombreSoftware{' +
    FTitulo + '}');
  LEManTec.agregarLinea('\item Cu?les son los requisitos del sistema');
  LEManTec.agregarLinea('\item La preparaci?n para la instalaci?n ');
  LEManTec.agregarLinea('\item Las opciones de instalaci?n');
  LEManTec.agregarLinea('\item Herramientas para el dise?o y desarrollo');
  LEManTec.agregarLinea('\end{itemize}');
  LEManTec.agregarLinea
    ('\end{minipage}}{\includegraphics[width=3cm]{Imagenes/man_Logo}}{}');
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea
    ('A continuaci?n se hace una descripci?n t?cnica del software:');
  LEManTec.agregarLinea('');

  { Descripci?n T?cnica del Software $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
  LEManTec.agregarLinea('\begin{itemize}');
  LEManTec.agregarLinea('\item \textbf{Nombre:} ' + FTitulo);
  LEManTec.agregarLinea('\item \textbf{Objetivo:} ' + FObjetivo);
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\item \textbf{Requisitos de Instalaci?n:} ');
  LEManTec.agregarLinea('\begin{itemize}');
  for i := 1 to SLRequisitosInstalacion.Count do
  begin
    LEManTec.agregarLinea('\item ' + SLRequisitosInstalacion[i - 1]);
  end;
  LEManTec.agregarLinea('\end{itemize}');
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\item \textbf{Versi?n:} ' + FVersion);
  LEManTec.agregarLinea('\item \textbf{Software Similares:}');

  { Software Similares $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
  LEManTec.agregarLinea('\begin{itemize}');
  for i := 1 to SLSoftwareSimilares.Count do
  begin
    LEManTec.agregarLinea(SLSoftwareSimilares[i - 1]);
  end;
  LEManTec.agregarLinea('\end{itemize}');
  LEManTec.agregarLinea('\end{itemize}');

  { Descripci?n de la Aplicaci?n $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\section{Descripci?n}');
  for i := 1 to SLDescripcion.Count do
  begin
    LEManTec.agregarLinea(SLDescripcion[i - 1] + ' \\');
  end;

  { Instalaci?n de la Aplicaci?n $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
  LEManTec.agregarLinea
    ('\chapter{Instalaci?n de la Aplicaci?n y Herramientas de Desarrollo}');
  LEManTec.agregarLinea('');

  LEManTec.agregarLinea('\Descripcion{');
  LEManTec.agregarLinea('En esta secci?n se explicar?:');
  LEManTec.agregarLinea('\begin{itemize}');
  LEManTec.agregarLinea('\item C?mo instalar el software \NombreSoftware{' +
    FTitulo + '}');
  LEManTec.agregarLinea('\item Cu?les son los requisitos del sistema');
  LEManTec.agregarLinea('\item La preparaci?n para la instalaci?n ');
  LEManTec.agregarLinea('\item Las opciones de instalaci?n');
  LEManTec.agregarLinea('\item Herramientas para el dise?o y desarrollo');
  LEManTec.agregarLinea('\end{itemize}}' +
    '{\includegraphics[width=3cm]{Imagenes/inst_Instalacion}}{}');
  LEManTec.agregarLinea('');

  LEManTec.agregarLinea('\section{Instalaci?n del Software}');
  LEManTec.agregarLinea
    ('A continuaci?n encontrar? los requisitos del sistema para la instalaci?n,'
    + ' guia para instalar la aplicaci?n y opciones de instalaci?n.');

  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\section{Requisitos del Sistema}');
  LEManTec.agregarLinea
    ('En el siguiente listado se muestran los requisitos m?nimos del sistema.' +
    ' Para asegurar el buen funcionamiento del software se recomienda un' +
    ' sistema que sobrepase estos requisitos m?nimos.');
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\begin{itemize}');
  for i := 1 to SLRequisitosInstalacion.Count do
  begin
    LEManTec.agregarLinea('\item ' + SLRequisitosInstalacion[i - 1]);
  end;
  LEManTec.agregarLinea('\end{itemize}');

  { Herramientas de Desarrollo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\section{Herramientas para el Desarrollo}');
  LEManTec.agregarLinea('');
  for i := 1 to SLHerramientasDesarrollo.Count do
  begin
    LEManTec.agregarLinea(SLHerramientasDesarrollo[i - 1]);
  end;

  { Instalaci?n de la Aplicaci?n $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea('\section{Instalaci?n de la Aplicaci?n}');
  LEManTec.agregarLinea('');
  LEManTec.agregarLinea
    ('Para instalar el software se deben seguir los siguientes pasos:');
  LEManTec.agregarLinea('');

  LEManTec.agregarLinea('');
  for i := 1 to SLInstalacion.Count do
  begin
    LEManTec.agregarLinea(SLInstalacion[i - 1]);
  end;
  LEManTec.agregarLinea('');

  { Exportar la Bibliografia }
  LEManTec.agregarLinea('\begin{thebibliography}{1}');
  for i := 1 to SLBibliografia.Count do
  begin
    LEManTec.agregarLinea(SLBibliografia[i - 1]);
  end;
  LEManTec.agregarLinea('\end{thebibliography}');

  LEManTec.agregarLinea('');
  LEManTec.endEnviroment('document');

  { Exportar el Manual }
  LEManTec.exportarCompilar(FrutaExportar + '\' + FnombreManualTecnico);
end;

procedure TManualTecnico.exportarManualUsuario;
var
  i: integer;
begin
  LEManUse.documentClass('12pt,twoside,spanish', 'Plantilla');

  LEManUse.usePackage('fontenc', 'T1');
  LEManUse.usePackage('inputenc', 'latin9');
  LEManUse.usePackage('inputenc', 'letterpaper');
  LEManUse.usePackage('babel');
  LEManUse.usePackage('array');
  LEManUse.usePackage('longtable');
  LEManUse.usePackage('pifont');
  LEManUse.usePackage('float');
  LEManUse.usePackage('textcomp');
  LEManUse.usePackage('url');
  LEManUse.usePackage('graphicx');
  LEManUse.usePackage('Plantilla');
  LEManUse.usePackage('fancyhdr');
  LEManUse.usePackage('hyperref', 'unicode=true,pdfusetitle,bookmarks=true,' +
    'bookmarksnumbered=false,bookmarksopen=false,breaklinks=false,' +
    'pdfborder={0 0 0},pdfborderstyle={},backref=false,colorlinks=false');

  LEManUse.pagestyle('fancy');
  LEManUse.setcounter('secnumdepth', '3');
  LEManUse.setcounter('tocdepth', '1');

  LEManUse.geometry('3cm', '3cm', '3cm', '3cm', '1cm', '1cm', '1cm');

  LEManUse.agregarLinea('\addto\shorthandsspanish{\spanishdeactivate{~<>.}}');

  LEManUse.makeatletter;
  LEManUse.agregarLinea('\providecommand{\tabularnewline}{\\}');

  LEManUse.agregarLinea('\AtBeginDocument{');
  LEManUse.agregarLinea('  \def\labelitemi{\ding{111}}');
  LEManUse.agregarLinea('  \def\labelitemii{\ding{109}}');
  LEManUse.agregarLinea('  \def\labelitemiii{\ding{237}}');
  LEManUse.agregarLinea('  \def\labelitemiv{\(\bullet\)}');
  LEManUse.agregarLinea('}');

  LEManUse.makeatother;

  LEManUse.agregarLinea('');
  LEManUse.beginEnviroment('document');
  LEManUse.agregarLinea('');

  { Datos de la Aplicaci?n $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
  LEManUse.Titulo(FTitulo);
  LEManUse.Subtitulo(FSubtitulo);

  LEManUse.agregarLinea('\Autores{%');
  LEManUse.agregarLinea('\begin{tabular}{c}');
  for i := 1 to SLAutores.Count do
  begin
    LEManUse.agregarLinea(SLAutores[i - 1] + '\tabularnewline');
  end;
  LEManUse.agregarLinea('\end{tabular}}');

  LEManUse.agregarLinea('\AutoresCorto{' + FAutoresCorto + '}');
  LEManUse.agregarLinea('');
  LEManUse.agregarLinea('\Institucion{' + FUniversidad + '}');
  LEManUse.agregarLinea('');
  LEManUse.agregarLinea('\Facultad{' + FFacultad + '}');
  LEManUse.agregarLinea('');
  LEManUse.agregarLinea('\Programa{' + FPrograma + '}');
  LEManUse.agregarLinea('');
  LEManUse.agregarLinea('\Grupo{' + FGrupo + '}');
  LEManUse.agregarLinea('');
  LEManUse.agregarLinea('\Ciudad{' + FCiudad + '}');
  LEManUse.agregarLinea('');
  LEManUse.agregarLinea('\Fecha{' + FFecha + '}');
  LEManUse.agregarLinea('');
  LEManUse.agregarLinea('\TipoCapitulo{Secci?n}');
  LEManUse.agregarLinea('');
  LEManUse.agregarLinea('.');
  LEManUse.agregarLinea('');

  { Generar la portada principal $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
  LEManUse.agregarLinea
    ('\PortadaInicial{\includegraphics[width=6cm]{Imagenes/man_Logo}}{' +
    FTitulo + '}{Versi?n ' + FVersion + '}{Manual T?cnico}{}');
  LEManUse.agregarLinea('');
  LEManUse.agregarLinea('\GenerarPortada{}');
  LEManUse.agregarLinea('');
  LEManUse.agregarLinea('\DerechosAutor{}{}');
  LEManUse.agregarLinea('');
  LEManUse.agregarLinea('\tableofcontents{}');
  LEManUse.agregarLinea('');

  { Agregar la Introducci?n $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
  LEManUse.agregarLinea('\chapter*{Introducci?n}');
  LEManUse.agregarLinea('');
  for i := 1 to SLIntroduccion.Count do
  begin
    LEManUse.agregarLinea(SLIntroduccion[i - 1] + ' \\');
  end;

  LEManUse.endEnviroment('document');

  { Exportar el Manual }
  LEManUse.exportarCompilar(FrutaExportar + '\' + FnombreManualUsuario);
end;

procedure TManualTecnico.leerBibliografia(Ruta: string);
var
  LSBibligrafia: TStringList;
begin
  LSBibligrafia := TStringList.create;
  LSBibligrafia.LoadFromFile(Ruta);

  SLBibliografia.AddStrings(LSBibligrafia);
end;

procedure TManualTecnico.leerDescripcion(Ruta: string);
var
  LSDescripcion: TStringList;
  Encoding: TEncoding;
begin
  Encoding := TUTF8Encoding.create;
  LSDescripcion := TStringList.create;
  // LSDescripcion.DefaultEncoding := Encoding;
  LSDescripcion.LoadFromFile(Ruta);

  SLDescripcion.AddStrings(LSDescripcion);
end;

procedure TManualTecnico.leerHerramientasDesarrollo(Ruta: string);
var
  LSHerramientas: TStringList;
  local: string;
  Encoding: TEncoding;
begin
  Encoding := TUTF8Encoding.create;
  local := ExtractFilePath(ParamStr(0)) + '\';
  LSHerramientas := TStringList.create;
  // LSHerramientas.DefaultEncoding := Encoding;
  LSHerramientas.LoadFromFile(local + Ruta);

  SLHerramientasDesarrollo.AddStrings(LSHerramientas);
end;

procedure TManualTecnico.leerIntroduccion(Ruta: string);
var
  LSIntroduccion: TStringList;
  Encoding: TEncoding;
begin
  Encoding := TUTF8Encoding.create;
  LSIntroduccion := TStringList.create;
  // LSIntroduccion.DefaultEncoding := Encoding;
  LSIntroduccion.LoadFromFile(Ruta);

  SLIntroduccion.AddStrings(LSIntroduccion);
end;

procedure TManualTecnico.leerPasosInstalacion(Ruta: string);
var
  LSPasosInstalacion: TStringList;
  local: string;
  Encoding: TEncoding;
begin
  Encoding := TUTF8Encoding.create;
  local := ExtractFilePath(ParamStr(0)) + '\';
  LSPasosInstalacion := TStringList.create;
  // LSPasosInstalacion.DefaultEncoding := Encoding;
  LSPasosInstalacion.LoadFromFile(local + Ruta);

  SLInstalacion.AddStrings(LSPasosInstalacion);
end;

procedure TManualTecnico.leerRequisitosSistema(Ruta: string);
var
  LSRequisitos: TStringList;
  Encoding: TEncoding;
begin
  Encoding := TUTF8Encoding.create;
  LSRequisitos := TStringList.create;
  // LSRequisitos.DefaultEncoding := Encoding;
  LSRequisitos.LoadFromFile(Ruta);

  SLRequisitosInstalacion.AddStrings(LSRequisitos);
end;

function TManualTecnico.rutaDescargaHttp: TLinkDescargaManual;
begin
  Result.Tecnico := 'http://' + FIp + FRuta + FnombreManualTecnico + '.pdf';
  Result.Usuario := 'http://' + FIp + FRuta + FnombreManualUsuario + '.pdf';
  Result.Codigo := 'http://' + FIp + FRuta + FnombreManualCodigo + '.pdf';
end;

procedure TManualTecnico.setAutoresCorto(const Value: string);
begin
  FAutoresCorto := Value;
end;

procedure TManualTecnico.setCarpetasCodigo(const Value: TCarpetasCodigos);
begin
  FCarpetasCodigo := Value;
end;

procedure TManualTecnico.setCiudad(const Value: string);
begin
  FCiudad := Value;
end;

procedure TManualTecnico.setEsAplicacionEscritorio(const Value: boolean);
begin
  FEsAplicacionEscritorio := Value;
end;

procedure TManualTecnico.setFacultad(const Value: string);
begin
  FFacultad := Value;
end;

procedure TManualTecnico.setFecha(const Value: string);
begin
  FFecha := Value;
end;

procedure TManualTecnico.setGrupo(const Value: string);
begin
  FGrupo := Value;
end;

procedure TManualTecnico.setHandle(const Value: HWND);
begin
  FHandle := Value;
end;

procedure TManualTecnico.setnombreManual(const Value: string);
begin
  FnombreManualTecnico := Value;
end;

procedure TManualTecnico.setnombreManualCodigo(const Value: string);
begin
  FnombreManualCodigo := Value;
end;

procedure TManualTecnico.setnombreManualUsuario(const Value: string);
begin
  FnombreManualUsuario := Value;
end;

procedure TManualTecnico.setObjetivo(const Value: string);
begin
  FObjetivo := Value;
end;

procedure TManualTecnico.setPrograma(const Value: string);
begin
  FPrograma := Value;
end;

procedure TManualTecnico.setrutaExportar(const Value: string);
begin
  FrutaExportar := Value;
end;

procedure TManualTecnico.setSubtitulo(const Value: string);
begin
  FSubtitulo := Value;
end;

procedure TManualTecnico.setTitulo(const Value: string);
begin
  FTitulo := Value;
end;

procedure TManualTecnico.setUniversidad(const Value: string);
begin
  FUniversidad := Value;
end;

procedure TManualTecnico.setVersion(const Value: string);
begin
  FVersion := Value;
end;

{ TVentana }

procedure TVentana.agregarParte(nombre, descripcion: string);
begin
  FParte.Add(nombre);
  FDescripcionParte.Add(descripcion);
end;

constructor TVentana.create;
begin
  FParte := TStringList.create;
  FDescripcionParte := TStringList.create;
end;

destructor TVentana.destroy;
begin

  inherited;
end;

procedure TVentana.setDescripcion(const Value: string);
begin
  FDescripcion := Value;
end;

procedure TVentana.setNombre(const Value: string);
begin
  FNombre := Value;
end;

{ TDescripcionVentanas }

constructor TDescripcionVentanas.create;
begin

end;

destructor TDescripcionVentanas.destroy;
begin

  inherited destroy;
end;

{ TCarpetaImagenes }

procedure TCarpetaCodigo.agregarCodigo(Ruta, descripcion: string);
begin
  SLRutasCodigo.Add(Ruta);
  SLDescripcionCodigo.Add(descripcion);
end;

constructor TCarpetaCodigo.create(nombre: string);
begin
  SLRutasCodigo := TStringList.create;
  SLDescripcionCodigo := TStringList.create;

  FNombre := nombre;
end;

destructor TCarpetaCodigo.destroy;
begin
  SLRutasCodigo.Free;

  inherited destroy;
end;

function TCarpetaCodigo.getCount: integer;
begin
  Result := SLRutasCodigo.Count;
end;

function TCarpetaCodigo.obtenerCodigo(id: integer): TCodigoDescripcion;
begin
  Result.Ruta := SLRutasCodigo[id];
  Result.descripcion := SLDescripcionCodigo[id];
end;

procedure TCarpetaCodigo.setDescripcion(const Value: string);
begin
  FDescripcion := Value;
end;

{ TCarpetasImagenes }

function TCarpetasCodigos.agregarCarpeta(nombre, descripcion: string): integer;
begin
  FCarpetaTemp := FCarpetas.Add(TCarpetaCodigo.create(nombre));
  obtenerCarpeta(FCarpetaTemp).descripcion := descripcion;
  Result := FCarpetaTemp;
end;

procedure TCarpetasCodigos._agregarCodigo(Ruta, descripcion: string;
  carpeta: integer);
begin
  (FCarpetas.Items[carpeta] as TCarpetaCodigo).agregarCodigo(Ruta, descripcion);
end;

procedure TCarpetasCodigos.agregarCodigo(nombre, descripcion: string);
begin
  _agregarCodigo(FRutaActual + nombre, descripcion, FCarpetaTemp);
end;

constructor TCarpetasCodigos.create;
begin
  FCarpetas := TObjectList.create;
end;

destructor TCarpetasCodigos.destroy;
begin
  FCarpetas.Free;
  inherited destroy;
end;

function TCarpetasCodigos.getCount: integer;
begin
  Result := FCarpetas.Count;
end;

function TCarpetasCodigos.obtenerCarpeta(id: integer): TCarpetaCodigo;
begin
  Result := (FCarpetas.Items[id] as TCarpetaCodigo);
end;

procedure TCarpetasCodigos.setRutaActual(const Value: string);
begin
  FRutaActual := Value;
end;

end.
