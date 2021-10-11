unit Unit2;

interface

uses
  Windows,
  Forms,
  Messages,
  ExtCtrls,
  Controls,
  Graphics,
  SysUtils,
  Classes,
  Shellapi,
  StdCtrls;

type
  TAbt = class(TForm)
    Shape1: TShape;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Shape2: TShape;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Shape1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label1MouseLeave(Sender: TObject);
    procedure Label11MouseLeave(Sender: TObject);
    procedure Label11MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label11Click(Sender: TObject);
    procedure NewButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure CMMouseLeave(var msg: TMessage);
    message CM_MOUSELEAVE;
  public
    { Public declarations }
  end;

var
  Abt: TAbt; YSS: boolean = false;

implementation

{$R *.dfm}

{ определение имени пользователя }
function GetUserName:string;
{Определение имени пользователя}
var
 Buffer: array[0..MAX_PATH] of Char;
 sz:DWORD;
begin
 sz:=MAX_PATH-1;
 if windows.GetUserName(Buffer,sz)
 then begin
  if sz>0 then dec(sz);
  SetString(Result,Buffer,sz);
 end else begin
  Result:='Error '+inttostr(GetLastError);
 end;
end;

procedure TAbt.CMMouseLeave(var msg: TMessage);
label 1;
begin
if YSS then goto 1;
image1.left:= 8; image1.top:= 8;
1:
end;

procedure TAbt.FormShow(Sender: TObject);
var
  MS: TMemoryStatus;
begin
  GlobalMemoryStatus(MS);
  Label5.Caption := GetUserName;
  Label7.Caption := FormatFloat('#,###" KB"', MS.dwTotalPhys / 1024);
  Label8.Caption := Format('%d %%', [MS.dwMemoryLoad]);

end;
procedure TAbt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key = vk_escape then abt.modalresult:= 1;
end;

procedure TAbt.Shape1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     image1.left:= x; image1.top:= y+10;
end;

procedure TAbt.Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     yss:= true;
end;

procedure TAbt.Label1MouseLeave(Sender: TObject);
begin
     yss:= false;
end;

procedure TAbt.Label11MouseLeave(Sender: TObject);
begin
     label11.font.color:= clgreen;
     label11.font.style:= label11.font.style - [fsunderline];
     yss:= false;
end;

procedure TAbt.Label11MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     label11.font.color:= clblue;
     label11.font.style:= label11.font.style + [fsunderline];
     yss:= false;
end;

procedure TAbt.Label11Click(Sender: TObject);
begin
     abt.modalresult:= 1;
     ShellExecute(Handle,'open',
     'mailto:alexblackhome@mail.ru?Subject=ABOUT_YOUR_PR+'+
     '',
     '','',SW_SHOW);
end;

procedure TAbt.NewButton1Click(Sender: TObject);
begin
    abt.modalresult:= 1;
end;

procedure TAbt.Button1Click(Sender: TObject);
begin
 Close;
end;

end.
