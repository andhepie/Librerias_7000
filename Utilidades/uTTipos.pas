unit uTTipos;

interface

type

  TToken = record
    Token: string;
    IdUsuario: string;
    Nombre: string;
    IpCliente: string;
  end;

  TAutores = record
    Autores: string;
    Cantidad: integer;
  end;

  TAutor = record
    IdUsuario: string;
    Nombre: string;
  end;

  TConsultaUsuario = record
    Consulta: string;
    Tipo: string;
    Fecha: String;
    Hora: String;
    IdUsuario: string;
    IpCliente: string;
  end;

  TColorRGB = record
    r, g, b: integer;
  end;

  TFecha = record
    Y, M, D: integer;
  end;

implementation

end.
