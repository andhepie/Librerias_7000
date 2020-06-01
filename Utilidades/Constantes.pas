unit Constantes;

interface

uses System.SysUtils;

const

  { Encabezados }
  S_CONFIGURACION = 'Configuracion';
  S_USUARIO = 'Usuario';

  { Variables }
  V_SERVIDOR_CONECTADO = 'ServidorConectado';
  V_CANTIDAD = 'Cantidad';
  V_CONSULTAS = 'Consultas';

  { Valores }
  DS_ = '';
  DI_ = 0;
  DB_ = False;

function VarToStr(ss: string; n: integer): string;

implementation

function VarToStr(ss: string; n: integer): string;
begin
  result := ss + IntToStr(n);
end;

end.
