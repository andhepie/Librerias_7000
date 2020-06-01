unit Utilidades;

interface

uses
  System.SysUtils, Classes, Vcl.Graphics, Winapi.Windows, Forms, math, uTTipos,
  Vcl.StdCtrls, System.WideStrUtils, System.JSON,
  Vcl.Dialogs;

function NotacionMatriz(nombre: String; i, j: Integer): String;
function sDimension(m, n: Integer): String;
function RealRandom(Scale: Integer): Real;
function colorAleatorio: TColor;
function RealRandomIntervalo(a, b: Integer): Real;
function signo: Integer;
function ColorRGB(r, g, b: Byte): TColorRGB;
function decimalPoint(value: String): String;
function PointToComma(value: String): Real;
function StrToVar(sValue: String; nValue: Integer): String;
function StrToCelda(m, n: Integer): String;
function formatearNombreProyecto(nombre: String): String;
function formatearTexto(nombre: string): string;
function contarPalabras(sTexto: String): Integer;
function StrToCod(value: String): String;
function Val(n: Real): String;
function generarColor: TColor;
function verificarExtension(ssTexto, ssExtension: String): String;
function tieneComaDecimal: Boolean;
function obtenerReal_de_Edit(edValor: TEdit): Real;
function CifrarContra(contra: String; correo: String): String;
function DescifrarContra(contra: String; correo: String): String;
function Convertir_a_Mayusculas(ssNombre: String): String;
function FormatoCedula(ssDoc: String): String;
function formatearNumeroCelular(ssTel: String): String;
function formatearNumeroDocumento(ssDoc: String): String;
function ReemplazarLetras(ssTexto: String): String;
function DateTimeToFileName: String;
function FechaToString(Fecha: TFecha): String;
function NumeroATexto(n: Integer): string;
function StringToFloat(ss: string): Real;
function FloatToString(rr: Real): string;
function String39(ss: string): string;
function EjecutarEsperar(sProgram: string; Visible: Integer): Integer;
function Slim(ss: string): TStringList;
function StringToUpperCase(ss: string): string;
function Capitalizado(ss: string): string;
function esPreposicion(pp: string; pre, con: array of string): Boolean;
function ToJSON(nombre, propiedad: string): string;
function FormatearSimbolosEspecialesLatex(ss: string): string;
function generarID: string;
function Comillas(ss: string): string;

implementation

function Comillas(ss: string): string;
begin
  Result := #39 + ss + #39;
end;

function generarID: string;
var
  i: Integer;
begin
  Result := '';

  for i := 1 to 16 do
  begin
    Result := Result + Chr(Random(25) + 97);

    if ((i mod 4) = 0) and (i <> 16) then
      Result := Result + '-';
  end;
end;

{ Obtener la Arquitectura del Procesador }
function getArchitecture: string;
var
  sysInfo: SYSTEM_INFO;
begin
  GetSystemInfo(sysInfo);
  case sysInfo.wProcessorArchitecture of
    0:
      Result := 'x86';
    9:
      Result := 'x64';
  else
    Result := 'unknown';
  end;
end;

{ Obtener el tipo de procesador }
function ProcessorType: string;
var
  sysInfo: SYSTEM_INFO;
begin
  GetSystemInfo(sysInfo);
  case sysInfo.dwProcessorType of
    220:
      Result := 'PROCESSOR_INTEL_IA64';
    386:
      Result := 'PROCESSOR_INTEL_386';
    486:
      Result := 'PROCESSOR_INTEL_486';
    586:
      Result := 'PROCESSOR_INTEL_PENTIUM_586';
    8664:
      Result := 'PROCESSOR_AMD_X8664';
  else
    Result := 'Unknown';
  end;
end;

{ Obtener el n�mero de procesadores }
function numberOfProcessors: Dword;
var
  sysInfo: SYSTEM_INFO;
begin
  GetSystemInfo(sysInfo);
  Result := sysInfo.dwNumberOfProcessors;
end;

function FormatearSimbolosEspecialesLatex(ss: string): string;
var
  temp: string;
begin
  temp := StringReplace(ss, '$', '\$', [rfReplaceAll]);
  temp := StringReplace(ss, '#', '\#', [rfReplaceAll]);
  temp := StringReplace(ss, '%', '\%', [rfReplaceAll]);
  temp := StringReplace(ss, '&', '\&', [rfReplaceAll]);
  temp := StringReplace(ss, '^', '\^', [rfReplaceAll]);
  temp := StringReplace(ss, '_', '\_', [rfReplaceAll]);
  temp := StringReplace(ss, '~', '\~', [rfReplaceAll]);

  Result := temp;
end;

function ToJSON(nombre, propiedad: string): string;
var
  JSON: TJSONObject;
begin
  JSON := TJSONObject.Create;
  JSON.AddPair(nombre, propiedad);
  Result := JSON.ToString;
end;

function esPreposicion(pp: string; pre, con: array of string): Boolean;
var
  i: Integer;
  cont: Integer;
begin
  cont := 0;

  for i := 1 to length(pre) do
  begin
    if pp = pre[i - 1] then
      inc(cont);
  end;

  for i := 1 to length(con) do
  begin
    if pp = con[i - 1] then
      inc(cont);
  end;

  Result := cont > 0;
end;

function StringToUpperCase(ss: string): string;
var
  temp: string;
begin
  temp := UpperCase(ss);
  temp := StringReplace(temp, '�', '�', [rfReplaceAll]);
  temp := StringReplace(temp, '�', '�', [rfReplaceAll]);
  temp := StringReplace(temp, '�', '�', [rfReplaceAll]);
  temp := StringReplace(temp, '�', '�', [rfReplaceAll]);
  temp := StringReplace(temp, '�', '�', [rfReplaceAll]);

  temp := StringReplace(temp, '�', '�', [rfReplaceAll]);

  Result := temp;
end;

function StringToLowerCase(ss: string): string;
var
  temp: string;
begin
  temp := LowerCase(ss);
  temp := StringReplace(temp, '�', '�', [rfReplaceAll]);
  temp := StringReplace(temp, '�', '�', [rfReplaceAll]);
  temp := StringReplace(temp, '�', '�', [rfReplaceAll]);
  temp := StringReplace(temp, '�', '�', [rfReplaceAll]);
  temp := StringReplace(temp, '�', '�', [rfReplaceAll]);

  temp := StringReplace(temp, '�', '�', [rfReplaceAll]);

  Result := temp;
end;

function Capitalizado(ss: string): string;
var
  preposiciones: array of string;
  conectores: array of string;
  palabras: TStringList;
  i: Integer;
  pp: string;
begin
  try
    preposiciones := ['a', 'ante', 'bajo', 'con', 'contra', 'de', 'es', 'un',
      'desde', 'en', 'entre', 'hacia', 'hasta', 'durante', 'mediante', 'para',
      'por', 'pro', 'seg�n', 'sin', 'so', 'sobre', 'se', 'tras',
      'versus', 'v�a'];

    conectores := ['y', 'o', 'u', 'e', 'el', 'la'];

    palabras := TStringList.Create;
    pp := StringReplace(ss, ',', '_', [rfReplaceAll]);
    palabras.CommaText := StringReplace(StringToLowerCase(ss), ' ', ',',
      [rfReplaceAll]);

    Result := '';

    for i := 1 to palabras.Count do
    begin
      if not esPreposicion(palabras[i - 1], preposiciones, conectores) then
      begin
        if palabras[i - 1] <> '' then
        begin
          pp := StringToUpperCase(palabras[i - 1][1]) + Copy(palabras[i - 1], 2,
            length(palabras[i - 1]));
        end;
      end
      else
      begin
        pp := palabras[i - 1];
      end;

      if i = 1 then
      begin
        if palabras[i - 1] <> '' then
        begin
          pp := StringToUpperCase(palabras[i - 1][1]) + Copy(palabras[i - 1], 2,
            length(palabras[i - 1]));
        end;
      end;

      Result := Result + pp + ' ';
    end;

  except
    on E: Exception do
      Result := Result + '(' + E.Message + ')';
  end;

  Result := StringReplace(Result, '_', ',', [rfReplaceAll]);

end;

function EjecutarEsperar(sProgram: string; Visible: Integer): Integer;

var
  sApplication: array [0 .. 512] of char;
  currentDirectory: array [0 .. 255] of char;
  workingDirectory: string;
  startInformation: tstartupinfo;
  processInformation: tprocessInformation;
  iResult, iOutCode: Dword;
begin
  StrPCopy(sApplication, sProgram);
  GetDir(0, workingDirectory);
  StrPCopy(currentDirectory, workingDirectory);
  FillChar(startInformation, sizeof(startInformation), #0);
  startInformation.cb := sizeof(startInformation);

  startInformation.dwFlags := STARTF_USESHOWWINDOW;
  startInformation.wShowWindow := Visible;
  CreateProcess(nil, sApplication, nil, nil, false, CREATE_NEW_CONSOLE or
    NORMAL_PRIORITY_CLASS, nil, nil, startInformation, processInformation);

  repeat
    iOutCode := WaitForSingleObject(processInformation.hProcess, 1000);
    Application.ProcessMessages;
  until (iOutCode <> WAIT_TIMEOUT);

  GetExitCodeProcess(processInformation.hProcess, iResult);
  // MessageBeep(0);
  CloseHandle(processInformation.hProcess);
  Result := iResult;
end;

function Slim(ss: string): TStringList;
var
  temp: string;
begin
  Result := TStringList.Create;
  temp := StringReplace(ss, ' ', ',', [rfReplaceAll]);
  Result.CommaText := temp;
end;

function String39(ss: string): string;
begin
  Result := Chr(39) + ss + Chr(39);
end;

function StringToFloat(ss: string): Real;

var
  s: string;
begin
  s := ss;

  if s = '' then
    s := '0';

  if FloatToStr(0.1)[2] = ',' then
    s := StringReplace(s, '.', ',', [rfReplaceAll])
  else
    s := StringReplace(s, ',', '.', [rfReplaceAll]);

  Result := StrToFloat(s);
end;

function FloatToString(rr: Real): string;

var
  s: string;
begin
  s := FloatToStr(rr);
  s := StringReplace(s, ',', '.', [rfReplaceAll]);
  Result := s;
end;

function NumeroATexto(n: Integer): string;
begin
  if n = 1 then
    Result := 'un';

  if n = 2 then
    Result := 'dos';

  if n = 3 then
    Result := 'tres';

  if n = 4 then
    Result := 'cuatro';

  if n = 5 then
    Result := 'cinco';

  if n = 6 then
    Result := 'seis';

  if n = 7 then
    Result := 'siete';

  if n = 8 then
    Result := 'ocho';

  if n = 9 then
    Result := 'nueve';

  if n = 10 then
    Result := 'diez';

  if n = 11 then
    Result := 'once';

  if n = 12 then
    Result := 'doce';

  if n = 13 then
    Result := 'trece';

  if n = 14 then
    Result := 'catorce';

  if n = 15 then
    Result := 'quince';

  if n = 16 then
    Result := 'dieciseis';

  if n = 17 then
    Result := 'diecisiete';

  if n = 18 then
    Result := 'dieciocho';

  if n = 19 then
    Result := 'diecinueve';

  if n = 20 then
    Result := 'veinte';

  if n = 21 then
    Result := 'ventiuno';

  if n = 22 then
    Result := 'ventidos';

  if n = 23 then
    Result := 'ventitres';

  if n = 24 then
    Result := 'venticuatro';

  if n = 25 then
    Result := 'venticinco';
end;

function NotacionMatriz(nombre: String; i, j: Integer): String;
begin
  Result := nombre + '[' + IntToStr(i) + ',' + IntToStr(j) + '] = ';
end;

function sDimension(m, n: Integer): String;
begin
  Result := IntToStr(m) + 'x' + IntToStr(n);
end;

function RealRandom(Scale: Integer): Real;
begin
  Result := Random(1000000 * Scale) / 1000000;
end;

function colorAleatorio: TColor;

var
  r, g, b: Byte;
begin
  r := Random(256);
  g := Random(256);
  b := Random(256);

  Result := RGB(r, g, b);
end;

function RealRandomIntervalo(a, b: Integer): Real;
begin
  Result := RandomRange(1000000 * a, 1000000 * b) / 1000000;
end;

function signo: Integer;
begin
  Result := Round(power(-1, Random(10)));
end;

function ColorRGB(r, g, b: Byte): TColorRGB;
begin
  Result.r := r;
  Result.g := g;
  Result.b := b;
end;

function decimalPoint(value: String): String;
begin
  Result := StringReplace(value, ',', '.', [rfReplaceAll]);
end;

function PointToComma(value: String): Real;

var
  sResult: String;
begin
  sResult := StringReplace(value, '.', ',', [rfReplaceAll]);
  Result := StrToFloat(sResult);
end;

function StrToVar(sValue: String; nValue: Integer): String;
begin
  Result := sValue + IntToStr(nValue);
end;

function formatearNombreProyecto(nombre: String): String;

var
  sResult: String;
begin
  sResult := LowerCase(nombre);

  sResult := StringReplace(sResult, ' ', '_', [rfReplaceAll]);

  sResult := StringReplace(sResult, '�', 'a', [rfReplaceAll]);
  sResult := StringReplace(sResult, '�', 'e', [rfReplaceAll]);
  sResult := StringReplace(sResult, '�', 'i', [rfReplaceAll]);
  sResult := StringReplace(sResult, '�', 'o', [rfReplaceAll]);
  sResult := StringReplace(sResult, '�', 'u', [rfReplaceAll]);

  sResult := StringReplace(sResult, '�', 'n', [rfReplaceAll]);

  Result := sResult;
end;

function formatearTexto(nombre: string): string;
begin
  Result := formatearNombreProyecto(nombre);
end;

function contarPalabras(sTexto: String): Integer;

var
  i, cant: Integer;
begin
  Result := 0;
  cant := length(sTexto);
  for i := 1 to cant do
    if sTexto = ' ' then
      Result := Result + 1;
end;

function StrToCod(value: String): String;
begin
  Result := LowerCase(value);

  Result := StringReplace(Result, '�', 'a', [rfReplaceAll]);
  Result := StringReplace(Result, '�', 'e', [rfReplaceAll]);
  Result := StringReplace(Result, '�', 'i', [rfReplaceAll]);
  Result := StringReplace(Result, '�', 'o', [rfReplaceAll]);
  Result := StringReplace(Result, '�', 'u', [rfReplaceAll]);

  Result := StringReplace(Result, '�', 'A', [rfReplaceAll]);
  Result := StringReplace(Result, '�', 'E', [rfReplaceAll]);
  Result := StringReplace(Result, '�', 'I', [rfReplaceAll]);
  Result := StringReplace(Result, '�', 'O', [rfReplaceAll]);
  Result := StringReplace(Result, '�', 'U', [rfReplaceAll]);

  Result := StringReplace(Result, ' ', '_', [rfReplaceAll]);
  Result := UpperCase(Result);
end;

function Val(n: Real): String;
begin
  if n < 0 then
    Result := FloatToStr(n);
  if n > 0 then
    Result := '+' + FloatToStr(n);

  if n = 1 then
    Result := '+';
  if n = -1 then
    Result := '-';

end;

function generarColor: TColor;

var
  r, g, b: Byte;
begin
  r := Random(256);
  g := Random(256);
  b := Random(256);

  Result := RGB(r, g, b);
end;

function verificarExtension(ssTexto, ssExtension: String): String;

var
  LongExt: Integer;
begin
  LongExt := length(ssExtension);
  if Copy(ssTexto, length(ssTexto) - LongExt, LongExt) = ssExtension then
  begin
    Result := ssTexto;
  end
  else
    Result := ssTexto + ssExtension;
end;

function tieneComaDecimal: Boolean;
begin
  Result := FloatToStr(0.5)[2] = ',';
end;

function obtenerReal_de_Edit(edValor: TEdit): Real;

var
  valor: String;
begin
  if edValor.Text <> '' then
  begin
    valor := edValor.Text;
    if tieneComaDecimal then
    begin
      valor := StringReplace(valor, '.', ',', [rfReplaceAll]);
      Result := StrToFloat(valor);
    end;
  end
  else
  begin
    Result := 0;
    MessageDlg('El Editor esta Vacio', mtError, [mbYes], 0);
  end;
end;

function CifrarContra(contra: String; correo: String): String;

var
  lc: Integer;
  i, cod: Integer;
  ssCorreo: String;
begin
  Result := '';
  lc := length(contra);
  ssCorreo := UpperCase(correo);

  for i := 1 to lc do
  begin
    cod := ord(contra[i]) + ord(ssCorreo[i]) - 13;
    Result := Result + Chr(cod);
  end;

  { Se hace la siguiente cuenta
    Cod de 0: $48
    Cod de Z: $90
    M�xima Cod 138
    C�digo Normal hasta el $125
    Hay que restar 13

    C = ct+cr-13 }
end;

function DescifrarContra(contra: String; correo: String): String;

var
  lc: Integer;
  i: Integer;
  ssCorreo: String;
begin
  Result := '';
  lc := length(contra);
  ssCorreo := UpperCase(correo);

  for i := 1 to lc do
  begin
    Result := Result + Chr(ord(contra[i]) - ord(ssCorreo[i]) + 13);
  end;
end;

function Convertir_a_Mayusculas(ssNombre: String): String;
begin
  Result := UpperCase(ssNombre);

  Result := StringReplace(Result, '�', '�', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '�', '�', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '�', '�', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '�', '�', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '�', '�', [rfReplaceAll, rfIgnoreCase]);

  Result := StringReplace(Result, '�', '�', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '�', '�', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '�', '�', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '�', '�', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '�', '�', [rfReplaceAll, rfIgnoreCase]);

  Result := StringReplace(Result, '�', '�', [rfReplaceAll, rfIgnoreCase]);
end;

function FormatoCedula(ssDoc: String): String;
begin
  Result := StringReplace(ssDoc, '.', '', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(ssDoc, ',', '', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(ssDoc, 'o', '0', [rfReplaceAll, rfIgnoreCase]);
end;

function formatearNumeroCelular(ssTel: String): String;
begin
  Result := Copy(ssTel, 1, 3) + ' ' + Copy(ssTel, 4, 3) + ' ' +
    Copy(ssTel, 7, 4);
end;

function formatearNumeroDocumento(ssDoc: String): String;
begin

end;

function ReemplazarLetras(ssTexto: String): String;

var
  ssResult: String;
begin
  ssResult := StringReplace(ssTexto, '�', '�', [rfReplaceAll]);
  ssResult := StringReplace(ssResult, '�', '�', [rfReplaceAll]);
  ssResult := StringReplace(ssResult, '�', '�', [rfReplaceAll]);
  ssResult := StringReplace(ssResult, '�', '�', [rfReplaceAll]);
  ssResult := StringReplace(ssResult, '�', '�', [rfReplaceAll]);
  ssResult := StringReplace(ssResult, '�', '�', [rfReplaceAll]);

  Result := ssResult;
end;

function DateTimeToFileName: String;

var
  sDate, sTime, sResult: String;
begin
  sDate := DateToStr(now);
  sTime := TimeToStr(now);

  sResult := sDate + '_' + sTime;
  sResult := StringReplace(sResult, '/', '_', [rfReplaceAll]);
  sResult := StringReplace(sResult, ':', '_', [rfReplaceAll]);
  sResult := StringReplace(sResult, ' ', '_', [rfReplaceAll]);
  sResult := StringReplace(sResult, '.', '_', [rfReplaceAll]);
  Result := Copy(sResult, 1, length(sResult) - 1);
end;

function StrToCelda(m, n: Integer): String;
begin
  Result := 'C[' + IntToStr(m) + IntToStr(n) + ']';
end;

function FechaToString(Fecha: TFecha): String;
begin
  Result := IntToStr(Fecha.Y) + '-' + IntToStr(Fecha.m) + '-' +
    IntToStr(Fecha.D);
end;

end.
