unit uTJSONToTreeView;

interface

uses Classes, Vcl.ComCtrls, System.JSON, System.SysUtils, Vcl.Dialogs;

Type

  TJsonToTreeView = class(TObject)
  private
    FTreeView: TTreeView;

    procedure _generarArbol(ss: string; parent: TTreeNode);
    procedure Imprimir(ss: string; padre: TTreeNode);
    procedure setTreeView(const Value: TTreeView);
  public
    constructor create;
    destructor destroy; override;

    procedure generarArbol(JsonString: string);

  published
    property TreeView: TTreeView read FTreeView write setTreeView;
  end;

implementation

{ TJsonToTreeView }

constructor TJsonToTreeView.create;
begin

end;

destructor TJsonToTreeView.destroy;
begin

  inherited;
end;

procedure TJsonToTreeView.generarArbol(JsonString: string);
begin
  if Assigned(FTreeView) then
    _generarArbol(JsonString, nil)
  else
    MessageDlg('El TreeView de destino no esta asignado', mtError, [], 0);
end;

procedure TJsonToTreeView._generarArbol(ss: string; parent: TTreeNode);
var
  JSON: TJSONObject;
  JSONArray: TJSONArray;

  i, j, cantidad: integer;
  JSONValue: TJSONValue;
  JsonString: TJSONString;
  nPadre: TTreeNode;
begin
  JSON := TJSONObject.ParseJSONValue(ss) as TJSONObject;

  nPadre := TTreeNode.create(nil);

  for i := 1 to JSON.Count do
  begin
    JSONValue := JSON.Pairs[i - 1].JSONValue;
    JsonString := JSON.Pairs[i - 1].JsonString;

    if JSONValue.ToString[1] = '[' then
    begin

      JSONArray := TJSONObject.ParseJSONValue(JSONValue.ToString) as TJSONArray;
      cantidad := JSONArray.Count;

      nPadre := FTreeView.Items.AddChild(parent, JsonString.Value);

      for j := 1 to cantidad do
      begin

        _generarArbol(JSONArray.Get(j - 1).ToString,
          FTreeView.Items.AddChild(nPadre, IntToStr(j - 1)));
      end;
    end
    else
      nPadre := FTreeView.Items.AddChild(parent, JsonString.Value);

    Imprimir(JSONValue.Value, nPadre);

    if JSONValue is TJSONObject then
      _generarArbol(JSONValue.ToString, nPadre);
  end;
end;

procedure TJsonToTreeView.Imprimir(ss: string; padre: TTreeNode);
begin
  if ss <> '' then
    padre.Text := padre.Text + '=' + ss;
end;

procedure TJsonToTreeView.setTreeView(const Value: TTreeView);
begin
  FTreeView := Value;
end;

end.