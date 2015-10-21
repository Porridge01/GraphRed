unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, Buttons, Menus, ExtDlgs, UTools, UFigures, UAbout;

type

  { TMainForm }

  TMainForm = class(TForm)
    Save: TMenuItem;
    MMenu: TMainMenu;
    Fail: TMenuItem;
    Help: TMenuItem;
    Dlg1: TSavePictureDialog;
    SaveDialog1: TSaveDialog;
    YExit: TMenuItem;
    About: TMenuItem;
    PaintBox: TPaintBox;
    Panel: TPanel;
    ScrollBox: TScrollBox;
    Stat1: TStatusBar;
    procedure AboutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxPaint(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure ToolClick(Sender: TObject);
    procedure YExitClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;
  PictureNum: integer;
  IndexOfBtn: integer;
  point: Tpoint;
  SetBtn: TBitBtn;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
var
  i, SetTop, SetLeft: integer;
begin
  SetLeft:=0;
  SetTop:=0;
  for i:=0 to high(TTool.Tools) do begin
    SetBtn:=TBitBtn.Create(Self);
    with SetBtn do begin
      Name:=TTool.Tools[i].ToString+IntToStr(i);
      Caption:='';
      Parent:=Self;
      Width:=25;
      Spacing:=1;
      Height:=25;
      Glyph:=TTool.Tools[i].SetImgBtn;
      SetTop:=(i div 2) * 35;
      Top:=10+SetTop;
      Left:=10+SetLeft;
      if SetLeft = 0 then SetLeft:=35
         else SetLeft:=0;
      OnClick:= @mainForm.ToolClick;
      Tag:=i;
      if i = 0 then SetBtn.Click;
    end;
  end;
end;

procedure TMainForm.PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) and (ssRight in Shift) then exit;
  point.x:=x;
  point.y:=y;
  TTool.Tools[IndexOfBtn].OnMouseDown(Sender, Shift, Point);
end;

procedure TMainForm.PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  stat1.Panels[0].Text := 'Область для рисования';
  stat1.Panels[1].text := 'x:'+inttostr(x)+ '  y:'+inttostr(y);
  if (ssLeft in Shift) then begin
  point.x:=x;
  point.y:=y;
  TTool.Tools[IndexOfBtn].OnMouseMove(Sender, Shift, point);
  PaintBox.Invalidate;
  end;
end;

procedure TMainForm.PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) then begin
  point.x:=x;
  point.y:=y;
  TTool.Tools[IndexOfBtn].OnMouseUp(Sender, Shift, Point);
  end;
end;

procedure TMainForm.AboutClick(Sender: TObject);
begin
  AboutForm.ShowModal;
end;

procedure TMainForm.PaintBoxPaint(Sender: TObject);
var figure: TFigure;
begin
  for figure in TFigure.YFigures do
      figure.Draw(PaintBox.Canvas);
end;

procedure TMainForm.SaveClick(Sender: TObject);
var bmp1: TBitmap;
    Dest, Source: TRect;
begin
  SaveDialog1.Execute;
  exit;
  PictureNum+=1;
  bmp1 := TBitmap.Create;
  try
    with bmp1 do
    begin
      Width   := PaintBox.Width;
      Height  := PaintBox.Height;
      Dest    := Rect(0, 0, Width, Height);
    end;
    with PaintBox do
      Source := Rect(0, 0, Width, Height);
      bmp1.Canvas.CopyRect(Dest, PaintBox.Canvas, Source);
      bmp1.SaveToFile('Безымянный '+IntToStr(PictureNum)+'.bmp');
  finally
    bmp1.Free;
  end;
end;

procedure TMainForm.ToolClick(Sender: TObject);
begin
  IndexOfBtn:=(Sender as TBitBtn).Tag;
end;

procedure TMainForm.YExitClick(Sender: TObject);
begin
  MainForm.Close;
end;

end.

