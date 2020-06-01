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

    procedure exportarDocumento(ss: string; handle: HWND; verPdf: boolean);
  published
    property Lines: TStringList read Archivo;
  end;

implementation

{$R PlantillaLatexInvestigacion.RES}
{ TLatexExporter }

procedure TLatexExporter.Abstract_(valor: string);
begin
  Archivo.Add('\Abstract{' + valor + '}{}');
end;

procedure TLatexExporter.AddContentsLine(tipo, valor: string);
begin
  Archivo.Add('\addcontentsline{toc}{' + tipo + '}{' + valor + '}');
end;

procedure TLatexExporter.Agradecimiento(ss: string);
begin
  Archivo.Add('\Agradecimiento{\noindent\begin{minipage}[t]{1\columnwidth}%');
  Archivo.Add(ss);
  Archivo.Add('\end{minipage}}{}');
end;

procedure TLatexExporter.agregarLinea(ss: string);
begin
  Archivo.Add(ss);
end;

procedure TLatexExporter.AreaProfundizacion(ss: string);
begin
  Archivo.Add('\AreaProfundizacion{' + ss + '}');
end;

procedure TLatexExporter.Autores(ss: string);
begin
  Archivo.Add('\Autores{' + ss + '}');
end;

procedure TLatexExporter.beginEnviroment(ss: string);
begin
  Archivo.Add('\begin{' + ss + '}');
end;

procedure TLatexExporter.chapter(ss: string);
begin
  Archivo.Add('\chapter{' + ss + '}');
end;

procedure TLatexExporter.chapter_(ss: string);
begin
  Archivo.Add('\chapter*{' + ss + '}');
end;

procedure TLatexExporter.Ciudad(ss: string);
begin
  Archivo.Add('\Ciudad{' + ss + '}')
end;

procedure TLatexExporter.comentario(ss: string);
begin
  Archivo.Add('%%' + ss)
end;

constructor TLatexExporter.create;
begin
  Archivo := TStringList.create;
end;

procedure TLatexExporter.Dedicatoria(ss: string);
begin
  Archivo.Add('\Dedicatoria{' + ss + '}{}');
end;

destructor TLatexExporter.destroy;
begin

end;

procedure TLatexExporter.Director(ss: string);
begin
  Archivo.Add('\Director{' + ss + '}')
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
  Archivo.Add('\Facultad{' + ss + '}')
end;

procedure TLatexExporter.Fecha(ss: string);
begin
  Archivo.Add('\Fecha{' + ss + '}')
end;

procedure TLatexExporter.GenerarPortada;
begin
  Archivo.Add('\GenerarPortada{}');
end;

procedure TLatexExporter.geometry(top, bottom, left, right, headheight, headsep,
  footskip: string);
begin
  Archivo.Add('\geometry{verbose,tmargin=' + top + ',bmargin=' + bottom +
    ',lmargin=' + left + ',rmargin=' + right + ',headheight=' + headheight +
    ',headsep=' + headsep + ',footskip=' + footskip + '}');
end;

procedure TLatexExporter.GrupoInvestigacion(ss: string);
begin
  Archivo.Add('\GrupoInvestigacion{' + ss + '}');
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
  Archivo.Add('\makeatletter');
end;

procedure TLatexExporter.makeatother;
begin
  Archivo.Add('\makeatother');
end;

procedure TLatexExporter.Modalidad(ss: string);
begin
  Archivo.Add('\Modalidad{' + ss + '}');
end;

procedure TLatexExporter.numberwithin(tipo, parte: string);
begin
  Archivo.Add('\numberwithin{' + tipo + '}{' + parte + '}');
end;

procedure TLatexExporter.PageNumbering(ss: string);
begin
  Archivo.Add('\pagenumbering{' + ss + '}');
end;

procedure TLatexExporter.pagestyle(estilo: string);
begin
  Archivo.Add('\pagestyle{' + estilo + '}');
end;

procedure TLatexExporter.paragraph(valor: string);
begin
  Archivo.Add('\paragraph{' + valor + '}');
end;

procedure TLatexExporter.Programa(ss: string);
begin
  Archivo.Add('\Programa{' + ss + '}')
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
  Archivo.Add('\section{' + ss + '}');
end;

procedure TLatexExporter.section_(ss: string);
begin
  Archivo.Add('\section*{' + ss + '}');
end;

procedure TLatexExporter.setcounter(contador, valor: string);
begin
  Archivo.Add('\setcounter{' + contador + '}{' + valor + '}');
end;

procedure TLatexExporter.subsection(ss: string);
begin
  Archivo.Add('\subsection{' + ss + '}');
end;

procedure TLatexExporter.subsection_(ss: string);
begin
  Archivo.Add('\subsection*{' + ss + '}');
end;

procedure TLatexExporter.TableOfContents;
begin
  Archivo.Add('\tableofcontents{}');
end;

procedure TLatexExporter.Titulo(ss: string);
begin
  Archivo.Add('\Titulo{' + ss + '}')
end;

procedure TLatexExporter.TituloProfesional(ss: string);
begin
  Archivo.Add('\TituloProfesional{' + ss + '}');
end;

procedure TLatexExporter.Universidad(ss: string);
begin
  Archivo.Add('\Universidad{' + ss + '}')
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
