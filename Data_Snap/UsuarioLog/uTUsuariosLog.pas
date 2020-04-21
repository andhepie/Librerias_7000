unit uTUsuariosLog;

interface

uses Classes, contnrs, uUsuarioLog;

type
  TUsuariosLog = class(TObject)
  private
    FListaUsuarios: TObjectList;

    procedure agregarUsuario(IdUsuario, Nombre, Evento: string);

    function existeUsuario(IdUsuario: string): boolean;

    function getCantidad: integer;
  public
    constructor create;
    destructor destroy; override;

    procedure AgregarEvento(IdUsuario, Nombre, Evento: string);

    function Usuario(IdUsuario: string): TUsuarioLog;
    function obtenerUsuario(id: integer): TUsuarioLog;
  published
    property Cantidad: integer read getCantidad;
  end;

implementation

{ TUsuariosLog }

procedure TUsuariosLog.AgregarEvento(IdUsuario, Nombre, Evento: string);
begin
  if existeUsuario(IdUsuario) then
    Usuario(IdUsuario).AgregarEvento(Evento)
  else
    agregarUsuario(IdUsuario, Nombre, Evento);
end;

procedure TUsuariosLog.agregarUsuario(IdUsuario, Nombre, Evento: string);
var
  id: integer;
begin
  id := FListaUsuarios.Add(TUsuarioLog.create);
  obtenerUsuario(id).IdUsuario := IdUsuario;
  obtenerUsuario(id).Nombre := Nombre;
  obtenerUsuario(id).AgregarEvento(Evento);
end;

constructor TUsuariosLog.create;
begin
  FListaUsuarios := TObjectList.create;
end;

destructor TUsuariosLog.destroy;
begin
  FListaUsuarios.Free;
  inherited destroy;
end;

function TUsuariosLog.existeUsuario(IdUsuario: string): boolean;
var
  i: integer;
begin
  Result := false;

  for i := 1 to Cantidad do
  begin
    if obtenerUsuario(i - 1).IdUsuario = IdUsuario then
    begin
      Result := true;
      exit;
    end;
  end;
end;

function TUsuariosLog.getCantidad: integer;
begin
  Result := FListaUsuarios.Count;
end;

function TUsuariosLog.obtenerUsuario(id: integer): TUsuarioLog;
begin
  Result := FListaUsuarios.Items[id] as TUsuarioLog;
end;

function TUsuariosLog.Usuario(IdUsuario: string): TUsuarioLog;
var
  i: integer;
begin
  Result := nil;
  for i := 1 to Cantidad do
  begin
    if obtenerUsuario(i - 1).IdUsuario = IdUsuario then
    begin
      Result := obtenerUsuario(i - 1);
      exit;
    end;
  end;
end;

end.
