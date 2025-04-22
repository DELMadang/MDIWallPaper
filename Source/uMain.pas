unit uMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Menus;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    mmFile: TMenuItem;
    mmNew: TMenuItem;
    N1: TMenuItem;
    mmclose: TMenuItem;
    procedure mmNewClick(Sender: TObject);
    procedure mmcloseClick(Sender: TObject);
  private
    FBitmap: TBitmap;
    NewClient: TFarProc;
    OldClient: TFarProc;
    procedure ClientProc(var Message: TMessage);
  protected
    procedure CreateWnd; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DrawImage(const ADC: HDC); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uMDIChild;

{ TfrmMain }

constructor TfrmMain.Create(AOwner: TComponent);
begin
  inherited;

  if not (csDesigning in ComponentState) then
  begin
    FBitmap := TBitmap.Create;
    FBitmap.LoadFromFile('Wallpaper.bmp');
  end;
end;

procedure TfrmMain.CreateParams(var Params: TCreateParams);
begin
  inherited;

  // 초기 깜빡거림을 막기위한 코드
  Params.ExStyle := Params.ExStyle or WS_EX_COMPOSITED;
end;

destructor TfrmMain.Destroy;
begin
  if Assigned(FBitmap) then
    FBitmap.Free;

  inherited;
end;

procedure TfrmMain.ClientProc(var Message: TMessage);
begin
  case Message.Msg of
  WM_ERASEBKGND:
    begin
      CallWindowProc(OldClient, ClientHandle, Message.Msg, Message.wParam, Message.lParam);
      DrawImage(TWMEraseBkgnd(Message).DC);
      Message.Result := 1;
    end;
  WM_VSCROLL, WM_HSCROLL:
    begin
      Message.Result := CallWindowProc(OldClient, ClientHandle, Message.Msg, Message.wParam, Message.lParam);
      InvalidateRect(ClientHandle, nil, True);
    end;
  else
    Message.Result := CallWindowProc(OldClient, ClientHandle, Message.Msg, Message.wParam, Message.lParam);
  end;
end;

procedure TfrmMain.CreateWnd;
begin
  inherited;

  OldClient := Pointer(GetWindowLong(ClientHandle, GWL_WNDPROC));
  NewClient := MakeObjectInstance(ClientProc);

  SetWindowLong(ClientHandle, GWL_WNDPROC, LongInt(NewClient));
end;

procedure TfrmMain.DrawImage(const ADC: HDC);
var
  i: Integer;
  j: Integer;
  Cols: Integer;
  Rows: Integer;
  WndRect: TRect;
begin
  GetWindowRect(ClientHandle, WndRect);

  Rows := WndRect.Height div FBitmap.Height;
  Cols := WndRect.Width div FBitmap.Width;

  for i := 0 to Rows + 1 do
    for j := 0 to Cols + 1  do
      BitBlt(ADC, j * FBitmap.Width, i * FBitmap.Height, FBitmap.Width, FBitmap.Height, FBitmap.Canvas.Handle, 0, 0, SRCCOPY);
end;

procedure TfrmMain.mmcloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.mmNewClick(Sender: TObject);
var
  LForm: TfrmChild;
begin
  LForm := TfrmChild.Create(Application);
  LForm.Show;
end;

end.
