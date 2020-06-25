unit uMd5;

interface

uses
  System.SysUtils, System.Classes, IdHashMessageDigest, idHash, IdGlobal;

type
  TMD5 = class(TComponent)
  private
    FText: string;
    function getMD5: string;
    procedure setText(const Value: string);
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    property Text: string read FText write setText;
    property MD5: string read getMD5;
  end;

procedure Register;

implementation

function TMD5.getMD5: string;
var
  hashMessageDigest5: TIdHashMessageDigest5;
begin
  hashMessageDigest5 := nil;
  try
    hashMessageDigest5 := TIdHashMessageDigest5.Create;
    Result := IdGlobal.IndyLowerCase(hashMessageDigest5.HashStringAsHex(FText));
  finally
    hashMessageDigest5.Free;
  end;
end;

procedure Register;
begin
  RegisterComponents('Utilidades', [TMD5]);
end;

procedure TMD5.setText(const Value: string);
begin
  FText := Value;
  getMD5;
end;

end.
