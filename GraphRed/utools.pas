unit UTools;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Menus, Buttons, UFigures;

Type
  TTool = Class(TObject)
    public
      Tools: array of TTool; static;
      SetImgBtn: TBitMap;
      constructor Create(PathToFile: String); overload;
      Class procedure addTool(Tool: TTool); static;
      procedure OnMouseDown(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       virtual; abstract;
      procedure onMouseMove(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       virtual; abstract;
      procedure onMouseUp(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       virtual; abstract;
  end;


  TTPen = Class(TTool)
    public
      procedure onMouseDown(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
      procedure onMouseMove(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
      procedure onMouseUp(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
  end;

  TTErase = Class(TTool)
    public
      procedure onMouseDown(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
      procedure onMouseMove(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
      procedure onMouseUp(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
  end;

  TTLine = Class(TTool)
    public
      procedure onMouseDown(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
      procedure onMouseMove(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
      procedure onMouseUp(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
  end;

  TTPolyline = Class(TTool)
    public
      Onclick: boolean;
      procedure onMouseDown(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
      procedure onMouseMove(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
      procedure onMouseUp(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
  end;

  TTRectangle = Class(TTool)
    public
      procedure onMouseDown(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
      procedure onMouseMove(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
      procedure onMouseUp(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
  end;

  TTRoundRectangle = Class(TTool)
    public
      procedure onMouseDown(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
      procedure onMouseMove(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
      procedure onMouseUp(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
  end;

  TTEllipse = Class(TTool)
    public
      procedure onMouseDown(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
      procedure onMouseMove(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
      procedure onMouseUp(Sender: TObject; Shift: TShiftState; Point: Tpoint);
       override;
  end;


implementation

constructor TTool.Create(PathToFile: string);
begin
  SetImgBtn:=TBitmap.Create;
  SetImgBtn.LoadFromFile(PathToFile);
end;

class procedure TTool.addTool(tool: TTool);
begin
  SetLength(Tools, Length(Tools) + 1);
  Tools[High(Tools)]:= tool;
end;


procedure TTPen.onMouseDown(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then
     TFigure.addFigure(Tpen.Create);
end;

procedure TTPen.onMouseMove(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then
    (TFigure.RecentFigure() as Tpen).addPoint(point);
end;

procedure TTPen.onMouseUp(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin

end;


procedure TTErase.onMouseDown(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then
     TFigure.addFigure(TErase.Create);
end;

procedure TTErase.onMouseMove(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then
    (TFigure.RecentFigure() as TErase).addPoint(point);
end;

procedure TTErase.onMouseUp(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin

end;


procedure TTLine.onMouseDown(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then begin
    TFigure.addFigure(TLine.Create);
    (TFigure.RecentFigure() as Tline).TopLeft:=point;
  end;
end;

procedure TTLine.onMouseMove(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then
    (TFigure.RecentFigure() as TLine).BottomRight:=point;
end;

procedure TTLine.onMouseUp(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then
  (TFigure.RecentFigure() as TLine).BottomRight:=point;
end;


procedure TTPolyline.onMouseDown(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssRight in Shift) and Onclick then begin
     OnClick:=False;
     (Tfigure.RecentFigure() as TPolyline).RecentLine().BottomRight:=point;
     Exit;
  end;

  if OnClick then begin
     (TFigure.RecentFigure() as TPolyline).RecentLine().BottomRight:=point;
  end else
    OnClick:=true;
  if (ssLeft in Shift) then begin
     TFigure.AddFigure(TPolyline.Create);
     (TFIgure.RecentFigure() as TPolyline).addLine;
     (Tfigure.RecentFigure() as TPolyline).RecentLine().TopLeft:=point;
  end;
end;

procedure TTPolyline.onMouseMove(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then
    (TFigure.RecentFigure() as TPolyline).RecentLine().BottomRight:=point;
end;

procedure TTPolyline.onMouseUp(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin

end;


procedure TTRectangle.onMouseDown(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then begin
     TFigure.addFigure(TRectangle.Create);
    (TFigure.RecentFigure() as TRectangle).TopLeft:=point;
  end;
end;

procedure TTRectangle.onMouseMove(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then
    (TFigure.RecentFigure() as TRectangle).BottomRight:=point;
end;

procedure TTRectangle.onMouseUp(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then
    (TFigure.RecentFigure() as TRectangle).BottomRight:=point;
end;


procedure TTRoundRectangle.onMouseDown(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then begin
     TFigure.addFigure(TRoundRectangle.Create);
    (TFigure.RecentFigure() as TRoundRectangle).TopLeft:=point;
  end;
end;

procedure TTRoundRectangle.onMouseMove(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then
    (TFigure.RecentFigure() as TRoundRectangle).BottomRight:=point;
end;

procedure TTRoundRectangle.onMouseUp(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then
    (TFigure.RecentFigure() as TROundRectangle).BottomRight:=point;
end;


procedure TTEllipse.onMouseDown(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then begin
     TFigure.addFigure(TEllipse.Create);
    (TFigure.RecentFigure() as TEllipse).TopLeft:=point;
  end;
end;

procedure TTEllipse.onMouseMove(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then
    (TFigure.RecentFigure() as TEllipse).BottomRight:=point;
end;

procedure TTEllipse.onMouseUp(Sender: TObject; Shift: TShiftState; Point: Tpoint);
begin
  if (ssLeft in Shift) then
    (TFigure.RecentFigure() as TEllipse).BottomRight:=point;
end;

initialization
TTool.addTool(TTPen.Create('img\pen.bmp'));
TTool.addTool(TTErase.Create('img\Erease.bmp'));
TTool.addTool(TTLine.Create('img\line.bmp'));
TTool.addTool(TTPolyline.Create('img\polyline.bmp'));
TTool.addTool(TTRectangle.Create('img\rectangle.bmp'));
TTool.addTool(TTRoundRectangle.Create('img\RoundRectangle.bmp'));
TTool.addTool(TTEllipse.Create('img\Ellipse.bmp'));

end.

