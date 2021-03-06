{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
unit uTLatexExporter;

interface

uses classes, Vcl.StdCtrls, System.SysUtils, Windows, Dialogs, ShellApi,
  Utilidades;

type
  TLatexExporter = class(TObject)
  private
    Archivo: TStringList;
  public
    constructor create;
    destructor destroy;

    procedure section(ss: string);
    procedure section_(ss: string);
    procedure subsection(ss: string);
    procedure subsection_(ss: string);
    procedure paragraph(valor: string);
    procedure item(valor: string);
    procedure chapter(ss: string);
    procedure chapter_(ss: string);
    procedure beginEnviroment(ss: string);
    procedure endEnviroment(ss: string);
    procedure Itemize(ss: string);
    procedure usePackage(contenido: string; parametro: string = '');
    procedure agregarLinea(ss: string);
    procedure saltoParrafo;
    procedure saltoLinea;
    procedure comentario(ss: string);
    procedure documentClass(parametros: string; plantilla: string);
    procedure geometry(top, bottom, left, right, headheight, headsep,
      footskip: string);
    procedure pagestyle(estilo: string);
    procedure setcounter(contador, valor: string);
    procedure makeatletter;
    procedure numberwithin(tipo, parte: string);
    procedure makeatother;
    procedure Titulo(ss: string);
    procedure SubTitulo(ss: string);
    procedure Autores(ss: string);
    procedure Universidad(ss: string);
    procedure Facultad(ss: string);
    procedure Programa(ss: string);
    procedure Director(ss: string);
    procedure Ciudad(ss: string);
    procedure Fecha(ss: string);
    procedure GrupoInvestigacion(ss: string);
    procedure AreaProfundizacion(ss: string);
    procedure Modalidad(ss: string);
    procedure TituloProfesional(ss: string);
    procedure PageNumbering(ss: string);
    procedure DoubleSpacing;
    procedure GenerarPortada;
    procedure Dedicatoria(ss: string);
    procedure Agradecimiento(ss: string);
    procedure AddContentsLine(tipo, valor: string);
    procedure Abstract_(valor: string);
    procedure TableOfContents;
    procedure agregarCodigo(codigo: TStrings; nombre: string);
    procedure defineLenguaje(ext: string);
    procedure defineLenguajeHTML;
    procedure defineLenguajeTypeScript;
    procedure defineLenguajeCss;
    procedure defineLenguajePascal;
    procedure defineColoresLenguajes;

    procedure guardarCopia;

    procedure exportarDocumento(ss: string; handle: HWND; verPdf: boolean);
    procedure exportarCompilar(ss: string);
  published
    property Lines: TStringList read Archivo;
  end;

implementation

{ TLatexExporter }

procedure TLatexExporter.Abstract_(valor: string);
begin
  Archivo.Add('');
  Archivo.Add('\Abstract{' + valor + '}{}');
  Archivo.Add('');
end;

procedure TLatexExporter.AddContentsLine(tipo, valor: string);
begin
  Archivo.Add('');
  Archivo.Add('\addcontentsline{toc}{' + tipo + '}{' + valor + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.Agradecimiento(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\Agradecimiento{\noindent\begin{minipage}[t]{1\columnwidth}%');
  Archivo.Add(ss);
  Archivo.Add('\end{minipage}}{}');
  Archivo.Add('');
end;

procedure TLatexExporter.agregarCodigo(codigo: TStrings; nombre: string);
var
  i: integer;
  ext: string;
begin
  Archivo.Add('');

  ext := ExtractFileExt(nombre);

  if (ext = '.html') then
  begin
    Archivo.Add('\lstset{mathescape, language=HTML5, style=Html5}');
    Archivo.Add('{\scriptsize{}');
    Archivo.Add('\begin{lstlisting}');
  end;

  if (ext = '.css') then
  begin
    Archivo.Add('\lstset{mathescape, language=CSS, style=Css}');
    Archivo.Add('{\scriptsize{}');
    Archivo.Add('\begin{lstlisting}');
  end;

  if (ext = '.ts') or ((ext = '.js')) then
  begin
    Archivo.Add('\lstset{mathescape, language=TYPESCRIPT, style=TypeScript}');
    Archivo.Add('{\scriptsize{}');
    Archivo.Add('\begin{lstlisting}');
  end;

  if (ext = '.pas') or (ext = '.dpr') then
  begin
    Archivo.Add('\lstset{mathscape=true, language=PASCAL, style=Pascal}');
    Archivo.Add('{\scriptsize{}');
    Archivo.Add('\begin{lstlisting}');
  end;

  if ext = '.sql' then
  begin
    Archivo.Add('\lstset{language=SQL}');
    Archivo.Add('{\scriptsize{}');
    Archivo.Add('\begin{lstlisting}');
  end;

  Archivo.AddStrings(codigo);
  endEnviroment('lstlisting');
  Archivo.Add('}');
  Archivo.Add('');
end;

procedure TLatexExporter.agregarLinea(ss: string);
begin
  Archivo.Add(ss);
end;

procedure TLatexExporter.AreaProfundizacion(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\AreaProfundizacion{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.Autores(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\Autores{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.beginEnviroment(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\begin{' + ss + '}');
end;

procedure TLatexExporter.chapter(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\chapter{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.chapter_(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\chapter*{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.Ciudad(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\Ciudad{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.comentario(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('%%' + ss);
  Archivo.Add('');
end;

constructor TLatexExporter.create;
begin
  Archivo := TStringList.create;
end;

procedure TLatexExporter.Dedicatoria(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\Dedicatoria{' + ss + '}{}');
  Archivo.Add('');
end;

procedure TLatexExporter.defineColoresLenguajes;
begin
  Archivo.Add('\definecolor{lightgray}{rgb}{0.95, 0.95, 0.95}');
  Archivo.Add('\definecolor{darkgray}{rgb}{0.4, 0.4, 0.4}');
  Archivo.Add('\definecolor{editorGray}{rgb}{0.95, 0.95, 0.95}');
  Archivo.Add
    ('\definecolor{editorOcher}{rgb}{1, 0.5, 0} % #FF7F00 -> rgb(239, 169, 0)');
  Archivo.Add
    ('\definecolor{editorGreen}{rgb}{0, 0.5, 0} % #007C00 -> rgb(0, 124, 0)');
  Archivo.Add('\definecolor{orange}{rgb}{1,0.45,0.13}		');
  Archivo.Add('\definecolor{olive}{rgb}{0.17,0.59,0.20}');
  Archivo.Add('\definecolor{brown}{rgb}{0.69,0.31,0.31}');
  Archivo.Add('\definecolor{purple}{rgb}{0.38,0.18,0.81}');
  Archivo.Add('\definecolor{lightblue}{rgb}{0.1,0.57,0.7}');
  Archivo.Add('\definecolor{lightred}{rgb}{1,0.4,0.5}');
  Archivo.Add('\usepackage{upquote}');
end;

procedure TLatexExporter.defineLenguaje(ext: string);
begin
  Archivo.Add('');
end;

procedure TLatexExporter.defineLenguajeCss;
begin
  Archivo.Add('');

  Archivo.Add('\lstdefinelanguage{CSS}{');
  Archivo.Add('  language=html,');
  Archivo.Add('  sensitive=false,	');
  Archivo.Add('  alsoletter={<>=-},	');
  Archivo.Add('  morecomment=[s]{/*}{*/},');
  Archivo.Add('  tag=[s],');
  Archivo.Add('  otherkeywords={>,<!DOCTYPE,</html, <html,<hr,<app-root,' +
    '</app-root, <head, <title, </title, <style, </style, <link, </head, ' +
    '<meta, />, </body, <body, </div, <div, </div>, </p, <p, </p>, </script,' +
    ' <script,<canvas, /canvas>, <svg, <rect, <animateTransform, </rect>, ' +
    '</svg>, <video, <source, <iframe, </iframe>, </video>, <image, </image>,' +
    ' <header, </header, <article, </article');
  Archivo.Add('  },');

  Archivo.Add('  ndkeywords={=,charset=, lang=, src=, id=, width=, ' +
    'height=, style=, type=, rel=, href=,class=,fill=, attributeName=, ' +
    'begin=, dur=, from=, to=, poster=, controls=, x=, y=, repeatCount=, ' +
    'xlink:href=,margin:, padding:, background-image:, border:, top:, left:,' +
    ' position:, width:, height:, margin-top:, margin-bottom:, font-size:, ' +
    'line-height:,transform:, -moz-transform:, -webkit-transform:,animation:,' +
    ' -webkit-animation:,transition:,  transition-duration:, transition-property:,'
    + ' transition-timing-function:,');
  Archivo.Add('  }');

  Archivo.Add('}');
  Archivo.Add('');
  Archivo.Add('\lstdefinestyle{Css} {%');
  Archivo.Add('  % General design');
  Archivo.Add('  basicstyle={\footnotesize\ttfamily},   ');
  Archivo.Add('  frame=b,');
  Archivo.Add('  % line-numbers');
  Archivo.Add('  xleftmargin={0.75cm},');
  Archivo.Add('  numbers=left,');
  Archivo.Add('  stepnumber=1,');
  Archivo.Add('  firstnumber=1,');
  Archivo.Add('  numberfirstline=true,	');
  Archivo.Add('  % Code design');
  Archivo.Add('  identifierstyle=\color{black},');
  Archivo.Add('  keywordstyle=\color{black}\bfseries,');
  Archivo.Add('  ndkeywordstyle=\color{editorGreen}\bfseries,');
  Archivo.Add('  stringstyle=\color{blue}\ttfamily,');
  Archivo.Add('  commentstyle=\color{editorGreen}\ttfamily,');
  Archivo.Add('  % Code');
  Archivo.Add('  language=Css,');
  Archivo.Add('  alsolanguage=Css,');
  Archivo.Add('  alsodigit={.:;},	');
  Archivo.Add('  tabsize=2,');
  Archivo.Add('  showtabs=false,');
  Archivo.Add('  showspaces=false,');
  Archivo.Add('  showstringspaces=false,');
  Archivo.Add('  extendedchars=true,');
  Archivo.Add('  breaklines=true,');
  Archivo.Add('  % German umlauts');
  Archivo.Add('  literate=%');
  Archivo.Add('  {?}{{\"O}}1');
  Archivo.Add('  {?}{{\"A}}1');
  Archivo.Add('  {?}{{\"U}}1');
  Archivo.Add('  {?}{{\ss}}1');
  Archivo.Add('  {?}{{\"u}}1');
  Archivo.Add('  {?}{{\"a}}1');
  Archivo.Add('  {?}{{\"o}}1');
  Archivo.Add('}');

  Archivo.Add('');
end;

procedure TLatexExporter.defineLenguajeHTML;
begin
  Archivo.Add('');

  Archivo.Add('\lstdefinelanguage{HTML5}{');
  Archivo.Add('  language=html,');
  Archivo.Add('  sensitive=false,	');
  Archivo.Add('  alsoletter={<>=-},	');
  Archivo.Add('  morecomment=[s]{<!-}{-->},');
  Archivo.Add('  tag=[s],');
  Archivo.Add('  otherkeywords={>,<!DOCTYPE,</html, <html,<hr,<app-root,' +
    '</app-root, <head, <title, </title, <style, </style, <link, </head, ' +
    '<meta, />, </body, <body, </div, <div, </div>, </p, <p, </p>, </script,' +
    ' <script,<canvas, /canvas>, <svg, <rect, <animateTransform, </rect>, ' +
    '</svg>, <video, <source, <iframe, </iframe>, </video>, <image, </image>,' +
    ' <header, </header, <article, </article');
  Archivo.Add('  },');

  Archivo.Add('  ndkeywords={=,charset=, lang=, src=, id=, width=, ' +
    'height=, style=, type=, rel=, href=,class=,fill=, attributeName=, ' +
    'begin=, dur=, from=, to=, poster=, controls=, x=, y=, repeatCount=, ' +
    'xlink:href=,margin:, padding:, background-image:, border:, top:, left:,' +
    ' position:, width:, height:, margin-top:, margin-bottom:, font-size:, ' +
    'line-height:,transform:, -moz-transform:, -webkit-transform:,animation:,' +
    ' -webkit-animation:,transition:,  transition-duration:, transition-property:,'
    + ' transition-timing-function:,');
  Archivo.Add('  }');

  Archivo.Add('}');
  Archivo.Add('');
  Archivo.Add('\lstdefinestyle{Html5} {%');
  Archivo.Add('  % General design');
  Archivo.Add('  basicstyle={\footnotesize\ttfamily},   ');
  Archivo.Add('  frame=b,');
  Archivo.Add('  % line-numbers');
  Archivo.Add('  xleftmargin={0.75cm},');
  Archivo.Add('  numbers=left,');
  Archivo.Add('  stepnumber=1,');
  Archivo.Add('  firstnumber=1,');
  Archivo.Add('  numberfirstline=true,	');
  Archivo.Add('  % Code design');
  Archivo.Add('  identifierstyle=\color{black},');
  Archivo.Add('  keywordstyle=\color{black}\bfseries,');
  Archivo.Add('  ndkeywordstyle=\color{editorGreen}\bfseries,');
  Archivo.Add('  stringstyle=\color{blue}\ttfamily,');
  Archivo.Add('  commentstyle=\color{editorGreen}\ttfamily,');
  Archivo.Add('  % Code');
  Archivo.Add('  language=HTML5,');
  Archivo.Add('  alsolanguage=JavaScript,');
  Archivo.Add('  alsodigit={.:;},	');
  Archivo.Add('  tabsize=2,');
  Archivo.Add('  showtabs=false,');
  Archivo.Add('  showspaces=false,');
  Archivo.Add('  showstringspaces=false,');
  Archivo.Add('  extendedchars=true,');
  Archivo.Add('  breaklines=true,');
  Archivo.Add('  % German umlauts');
  Archivo.Add('  literate=%');
  Archivo.Add('  {?}{{\"O}}1');
  Archivo.Add('  {?}{{\"A}}1');
  Archivo.Add('  {?}{{\"U}}1');
  Archivo.Add('  {?}{{\ss}}1');
  Archivo.Add('  {?}{{\"u}}1');
  Archivo.Add('  {?}{{\"a}}1');
  Archivo.Add('  {?}{{\"o}}1');
  Archivo.Add('}');

  Archivo.Add('');
end;

procedure TLatexExporter.defineLenguajePascal;
begin
  Archivo.Add('\lstdefinelanguage{PASCAL}{');
  Archivo.Add('  language=Pascal,');
  Archivo.Add('  sensitive=false,		');
  Archivo.Add('  morecomment=[l]{//},');
  Archivo.Add('  morecomment=[s]{\{}{\}},');
  Archivo.Add('  morestring=[b]' + #39 + ',');
  Archivo.Add('  morestring=[b]",');
  Archivo.Add('  tag=[s],');
  Archivo.Add('  otherkeywords={unit, interface, uses, type, class, private,' +
    ' string, const, procedure, public, published, constructor, destructor,' +
    ' override, read, write, property, begin, end, function, implementation,' +
    ' for, to, do, while, with, if, then, else,var},');
  Archivo.Add('  ndkeywords={var, unit}');
  Archivo.Add('}');
  Archivo.Add('');
  Archivo.Add('\lstdefinestyle{Pascal} {%');
  Archivo.Add('  % General design');
  Archivo.Add('  basicstyle={\footnotesize\ttfamily},   ');
  Archivo.Add('  frame=b,');
  Archivo.Add('  % line-numbers');
  Archivo.Add('  xleftmargin={0.75cm},');
  Archivo.Add('  numbers=left,');
  Archivo.Add('  stepnumber=1,');
  Archivo.Add('  firstnumber=1,');
  Archivo.Add('  numberfirstline=true,	');
  Archivo.Add('  % Code design');
  Archivo.Add('  identifierstyle=\color{black},');
  Archivo.Add('  keywordstyle=\color{black}\bfseries,');
  Archivo.Add('  ndkeywordstyle=\color{black}\bfseries,');
  Archivo.Add('  stringstyle=\color{blue}\ttfamily,');
  Archivo.Add('  commentstyle=\color{editorGreen}\ttfamily,');
  Archivo.Add('  % Code');
  Archivo.Add('  language=Pascal,');
  Archivo.Add('  alsolanguage=Delphi,');
  Archivo.Add('  alsodigit={.:;},	');
  Archivo.Add('  tabsize=2,');
  Archivo.Add('  showtabs=false,');
  Archivo.Add('  showspaces=false,');
  Archivo.Add('  showstringspaces=false,');
  Archivo.Add('  extendedchars=true,');
  Archivo.Add('  breaklines=true,');
  Archivo.Add('  % German umlauts');
  Archivo.Add('  literate=%');
  Archivo.Add('  {?}{{\"O}}1');
  Archivo.Add('  {?}{{\"A}}1');
  Archivo.Add('  {?}{{\"U}}1');
  Archivo.Add('  {?}{{\ss}}1');
  Archivo.Add('  {?}{{\"u}}1');
  Archivo.Add('  {?}{{\"a}}1');
  Archivo.Add('  {?}{{\"o}}1');
  Archivo.Add('}');

end;

procedure TLatexExporter.defineLenguajeTypeScript;
begin
  Archivo.Add('\lstdefinelanguage{TYPESCRIPT}{');
  Archivo.Add('  language=JavaScript,');
  Archivo.Add('  sensitive=false,		');
  Archivo.Add('  morecomment=[l]{//},');
  Archivo.Add('  morecomment=[s]{/*}{*/},');
  Archivo.Add('  morestring=[b]' + #39 + ', ');
  Archivo.Add('  morestring=[b]",');
  Archivo.Add('  tag=[s],');
  Archivo.Add
    ('  otherkeywords={import, export, @, class, implements, string, number, any, this}');
  Archivo.Add('}');
  Archivo.Add('');
  Archivo.Add('\lstdefinestyle{TypeScript} {%');
  Archivo.Add('  % General design');
  Archivo.Add('  basicstyle={\footnotesize\ttfamily},   ');
  Archivo.Add('  frame=b,');
  Archivo.Add('  % line-numbers');
  Archivo.Add('  xleftmargin={0.75cm},');
  Archivo.Add('  numbers=left,');
  Archivo.Add('  stepnumber=1,');
  Archivo.Add('  firstnumber=1,');
  Archivo.Add('  numberfirstline=true,	');
  Archivo.Add('  % Code design');
  Archivo.Add('  identifierstyle=\color{black},');
  Archivo.Add('  keywordstyle=\color{black}\bfseries,');
  Archivo.Add('  ndkeywordstyle=\color{black}\bfseries,');
  Archivo.Add('  stringstyle=\color{blue}\ttfamily,');
  Archivo.Add('  commentstyle=\color{editorGreen}\ttfamily,');
  Archivo.Add('  % Code');
  Archivo.Add('  language=TypeScript,');
  Archivo.Add('  alsolanguage=JavaScript,');
  Archivo.Add('  alsodigit={.:;},	');
  Archivo.Add('  tabsize=2,');
  Archivo.Add('  showtabs=false,');
  Archivo.Add('  showspaces=false,');
  Archivo.Add('  showstringspaces=false,');
  Archivo.Add('  extendedchars=true,');
  Archivo.Add('  breaklines=true,');
  Archivo.Add('  % German umlauts');
  Archivo.Add('  literate=%');
  Archivo.Add('  {?}{{\"O}}1');
  Archivo.Add('  {?}{{\"A}}1');
  Archivo.Add('  {?}{{\"U}}1');
  Archivo.Add('  {?}{{\ss}}1');
  Archivo.Add('  {?}{{\"u}}1');
  Archivo.Add('  {?}{{\"a}}1');
  Archivo.Add('  {?}{{\"o}}1');
  Archivo.Add('}');
end;

destructor TLatexExporter.destroy;
begin

end;

procedure TLatexExporter.Director(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\Director{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.documentClass(parametros, plantilla: string);
begin
  Archivo.Add('\documentclass[' + parametros + ']{' + plantilla + '}')
end;

procedure TLatexExporter.DoubleSpacing;
begin
  Archivo.Add('\doublespacing');
end;

procedure TLatexExporter.endEnviroment(ss: string);
begin
  Archivo.Add('\end{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.exportarCompilar(ss: string);
var
  fileBat: TStringList;
  directorio: string;
  nombreArchivo, nombreCompilador: string;
  Recursos: TResourceStream;
  Estado: integer;
  Encoding: TEncoding;
begin
  // Encoding := TUnicodeEncoding.Create;
  Archivo.SaveToFile(ss + '.tex');

  directorio := ExtractFileDir(ss);
  nombreArchivo := ExtractFileName(ss);
  nombreCompilador := StringReplace('Compilador_' + UpperCase(nombreArchivo),
    ' ', '', [rfReplaceAll]);

  if not DirectoryExists(directorio + '\Imagenes') then
    CreateDir(directorio + '\Imagenes');

  { Exportar Plantillas de Manuales }
  Recursos := TResourceStream.create(HInstance, 'PLANTILLA_CLS', RT_RCDATA);
  Recursos.SaveToFile(directorio + '\Plantilla.cls');
  Recursos.Free;

  Recursos := TResourceStream.create(HInstance, 'PLANTILLA_STY', RT_RCDATA);
  Recursos.SaveToFile(directorio + '\Plantilla.sty');
  Recursos.Free;

  fileBat := TStringList.create;
  fileBat.Add('cd ' + directorio);
  fileBat.Add('pdflatex -file-line-error ' + nombreArchivo + '.tex');
  fileBat.SaveToFile(directorio + '\' + nombreCompilador + '.bat');

  Estado := EjecutarEsperar(directorio + '\' + nombreCompilador + '.bat',
    SW_NORMAL);
end;

procedure TLatexExporter.exportarDocumento(ss: string; handle: HWND;
  verPdf: boolean);
var
  fileBat: TStringList;
  directorio: string;
  nombreArchivo: string;
  Recursos: TResourceStream;
  Estado: integer;
begin

  Archivo.SaveToFile(ss + '.tex');

  directorio := ExtractFileDir(ss);
  nombreArchivo := ExtractFileName(ss);

  if not DirectoryExists(directorio + '\Imagenes') then
    CreateDir(directorio + '\Imagenes');

  Recursos := TResourceStream.create(HInstance, 'PLANTILLACLS', RT_RCDATA);
  Recursos.SaveToFile(directorio + '\Plantilla.cls');
  Recursos.Free;

  Recursos := TResourceStream.create(HInstance, 'PLANTILLASTY', RT_RCDATA);
  Recursos.SaveToFile(directorio + '\Plantilla.sty');
  Recursos.Free;

  Recursos := TResourceStream.create(HInstance, 'PLANTILLALAYOUT', RT_RCDATA);
  Recursos.SaveToFile(directorio + '\Plantilla.layout');
  Recursos.Free;

  Recursos := TResourceStream.create(HInstance, 'LOGOUQ', RT_RCDATA);
  Recursos.SaveToFile(directorio + '\Imagenes\LogoUQ.png');
  Recursos.Free;

  fileBat := TStringList.create;
  fileBat.Add('cd ' + directorio);
  fileBat.Add('pdflatex -file-line-error ' + nombreArchivo + '.tex');
  fileBat.SaveToFile(directorio + '\compilar.bat');

  Estado := EjecutarEsperar(directorio + '\compilar.bat', SW_NORMAL);
  // ShowMessage(IntToStr(Estado));
  if (Estado = 1) and verPdf then
  begin
    ShellExecute(handle, 'open', pchar(directorio + '\' + nombreArchivo +
      '.pdf'), nil, nil, SW_NORMAL);
  end;
end;

procedure TLatexExporter.Facultad(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\Facultad{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.Fecha(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\Fecha{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.GenerarPortada;
begin
  Archivo.Add('');
  Archivo.Add('\GenerarPortada{}');
  Archivo.Add('');
end;

procedure TLatexExporter.geometry(top, bottom, left, right, headheight, headsep,
  footskip: string);
begin
  Archivo.Add('');
  Archivo.Add('\geometry{verbose,tmargin=' + top + ',bmargin=' + bottom +
    ',lmargin=' + left + ',rmargin=' + right + ',headheight=' + headheight +
    ',headsep=' + headsep + ',footskip=' + footskip + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.GrupoInvestigacion(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\GrupoInvestigacion{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.guardarCopia;
var
  Encoding: TEncoding;
begin
  Encoding := TUTF8Encoding.create;
  Archivo.SaveToFile(ExtractFilePath(ParamStr(0)) + '\Copia_' +
    StringReplace(DateToStr(now), '/', '_', [rfReplaceAll]) + '.tex', Encoding);
end;

procedure TLatexExporter.item(valor: string);
begin
  Archivo.Add('\item ' + valor + '');
end;

procedure TLatexExporter.Itemize(ss: string);
begin
  Archivo.Add('\itemize{' + ss + '}');
end;

procedure TLatexExporter.makeatletter;
begin
  Archivo.Add('');
  Archivo.Add('\makeatletter');
  Archivo.Add('');
end;

procedure TLatexExporter.makeatother;
begin
  Archivo.Add('');
  Archivo.Add('\makeatother');
  Archivo.Add('');
end;

procedure TLatexExporter.Modalidad(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\Modalidad{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.numberwithin(tipo, parte: string);
begin
  Archivo.Add('');
  Archivo.Add('\numberwithin{' + tipo + '}{' + parte + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.PageNumbering(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\pagenumbering{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.pagestyle(estilo: string);
begin
  Archivo.Add('');
  Archivo.Add('\pagestyle{' + estilo + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.paragraph(valor: string);
begin
  Archivo.Add('');
  Archivo.Add('\paragraph{' + valor + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.Programa(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\Programa{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.saltoLinea;
begin
  Archivo.Add('');
end;

procedure TLatexExporter.saltoParrafo;
begin
  Archivo.Add('\\');
end;

procedure TLatexExporter.section(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\section{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.section_(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\section*{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.setcounter(contador, valor: string);
begin
  Archivo.Add('');
  Archivo.Add('\setcounter{' + contador + '}{' + valor + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.subsection(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\subsection{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.subsection_(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\subsection*{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.SubTitulo(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\SubTitulo{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.TableOfContents;
begin
  Archivo.Add('');
  Archivo.Add('\tableofcontents{}');
  Archivo.Add('');
end;

procedure TLatexExporter.Titulo(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\Titulo{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.TituloProfesional(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\TituloProfesional{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.Universidad(ss: string);
begin
  Archivo.Add('');
  Archivo.Add('\Universidad{' + ss + '}');
  Archivo.Add('');
end;

procedure TLatexExporter.usePackage(contenido: string; parametro: string = '');
begin
  if parametro <> '' then
  begin
    Archivo.Add('\usepackage[' + parametro + ']{' + contenido + '}');
  end
  else
  begin
    Archivo.Add('\usepackage{' + contenido + '}');
  end;
end;

end.
