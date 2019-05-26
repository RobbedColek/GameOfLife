unit frmMainView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, cCellularAutomata, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Image: TImage;
    MainMenu: TPanel;
    ActionList: TActionList;
    ActDraw: TAction;
    ActClear: TAction;
    Label1: TLabel;
    EdtIterationsGameOfLife: TEdit;
    EdtWidthGameOfLife: TEdit;
    Label2: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    ActGameOfLifeRandom: TAction;
    ActGameOfLifeGlider: TAction;
    TimerGameOfLife: TTimer;
    SpeedButton8: TSpeedButton;
    ActGameOfLifeTimer: TAction;
    EdtInterval: TEdit;
    LblInterval: TLabel;
    ActGameOfLifeNotChanging: TAction;
    ActGameOfLifeOscilator: TAction;
    ActClearButton: TAction;
    procedure ActClearExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DrawGrid;
    procedure Draw;
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ActGameOfLifeRandomExecute(Sender: TObject);
    procedure ActGameOfLifeGliderExecute(Sender: TObject);
    procedure TimerGameOfLifeTimer(Sender: TObject);
    procedure ActGameOfLifeTimerExecute(Sender: TObject);
    procedure ActGameOfLifeNotChangingExecute(Sender: TObject);
    procedure ActGameOfLifeOscilatorExecute(Sender: TObject);
    procedure ActClearButtonExecute(Sender: TObject);
  private
    FCellularAutomata : TCellularAutomata;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ActClearButtonExecute(Sender: TObject);
begin
  ActClear.Execute;

  FCellularAutomata.Free;
  FCellularAutomata := TCellularAutomata.Create;
  FCellularAutomata.PrepareGridGameOfLife(StrToInt(EdtIterationsGameOfLife.Text), StrToInt(EdtWidthGameOfLife.Text));
end;

procedure TForm1.ActClearExecute(Sender: TObject);
begin
  Image.Canvas.Brush.Color := clWhite;
  Image.Canvas.FillRect(Rect(0, 0, Image.Width, Image.Height));

  DrawGrid;
end;

procedure TForm1.ActGameOfLifeGliderExecute(Sender: TObject);
var tempX, tempY : Integer;
begin
  if Assigned(FCellularAutomata) then begin
    FCellularAutomata.Free;
    FCellularAutomata := TCellularAutomata.Create;
    FCellularAutomata.PrepareGridGameOfLife(StrToInt(EdtIterationsGameOfLife.Text), StrToInt(EdtWidthGameOfLife.Text));
  end else begin
    FCellularAutomata := TCellularAutomata.Create;
    FCellularAutomata.PrepareGridGameOfLife(StrToInt(EdtIterationsGameOfLife.Text), StrToInt(EdtWidthGameOfLife.Text));
  end;

  ActClear.Execute;

  tempX := StrToInt(EdtWidthGameOfLife.Text) div 2;
  tempY := StrToInt(EdtIterationsGameOfLife.Text) div 2;

  FCellularAutomata.SetValue(tempY, tempX, 1);
  FCellularAutomata.SetValue(tempY, tempX + 1, 1);
  FCellularAutomata.SetValue(tempY - 1, tempX + 1,  1);
  FCellularAutomata.SetValue(tempY - 1, tempX + 2, 1);
  FCellularAutomata.SetValue(tempY + 1, tempX + 2, 1);

  Draw;
end;

procedure TForm1.ActGameOfLifeNotChangingExecute(Sender: TObject);
var tempX, tempY : Integer;
begin
  if Assigned(FCellularAutomata) then begin
    FCellularAutomata.Free;
    FCellularAutomata := TCellularAutomata.Create;
    FCellularAutomata.PrepareGridGameOfLife(StrToInt(EdtIterationsGameOfLife.Text), StrToInt(EdtWidthGameOfLife.Text));
  end else begin
    FCellularAutomata := TCellularAutomata.Create;
    FCellularAutomata.PrepareGridGameOfLife(StrToInt(EdtIterationsGameOfLife.Text), StrToInt(EdtWidthGameOfLife.Text));
  end;

  ActClear.Execute;

  tempX := StrToInt(EdtWidthGameOfLife.Text) div 2;
  tempY := StrToInt(EdtIterationsGameOfLife.Text) div 2;

  FCellularAutomata.SetValue(tempY, tempX, 1);
  FCellularAutomata.SetValue(tempY + 1, tempX + 1, 1);
  FCellularAutomata.SetValue(tempY + 1, tempX + 2, 1);
  FCellularAutomata.SetValue(tempY - 1, tempX + 1, 1);
  FCellularAutomata.SetValue(tempY - 1, tempX + 2,  1);
  FCellularAutomata.SetValue(tempY, tempX + 3, 1);

  Draw;
end;

procedure TForm1.ActGameOfLifeRandomExecute(Sender: TObject);
var I: Integer;
begin
  if Assigned(FCellularAutomata) then begin
    FCellularAutomata.Free;
    FCellularAutomata := TCellularAutomata.Create;
    FCellularAutomata.PrepareGridGameOfLife(StrToInt(EdtIterationsGameOfLife.Text), StrToInt(EdtWidthGameOfLife.Text));
  end else begin
    FCellularAutomata := TCellularAutomata.Create;
    FCellularAutomata.PrepareGridGameOfLife(StrToInt(EdtIterationsGameOfLife.Text), StrToInt(EdtWidthGameOfLife.Text));
  end;

  ActClear.Execute;

  Randomize;
  for I := 0 to Random(StrToInt(EdtWidthGameOfLife.Text) * StrToInt(EdtIterationsGameOfLife.Text)) do begin
    FCellularAutomata.SetValue(Random(StrToInt(EdtIterationsGameOfLife.Text)), Random(StrToInt(EdtWidthGameOfLife.Text)), 1);
  end;

  Draw;
end;

procedure TForm1.ActGameOfLifeTimerExecute(Sender: TObject);
begin
  timerGameOfLife.Interval := StrToInt(EdtInterval.Text);
  timerGameOfLife.Enabled := not timerGameOfLife.Enabled;

  if timerGameOfLife.Enabled then begin
    ActGameOfLifeTimer.Caption := 'Stop';
    EdtInterval.Enabled := False;
    SpeedButton3.Enabled := False;
  end else begin
    ActGameOfLifeTimer.Caption := 'Start';
    EdtInterval.Enabled := True;
    SpeedButton3.Enabled := True;
  end;
end;

procedure TForm1.ActGameOfLifeOscilatorExecute(Sender: TObject);
var tempX, tempY : Integer;
begin
  if Assigned(FCellularAutomata) then begin
    FCellularAutomata.Free;
    FCellularAutomata := TCellularAutomata.Create;
    FCellularAutomata.PrepareGridGameOfLife(StrToInt(EdtIterationsGameOfLife.Text), StrToInt(EdtWidthGameOfLife.Text));
  end else begin
    FCellularAutomata := TCellularAutomata.Create;
    FCellularAutomata.PrepareGridGameOfLife(StrToInt(EdtIterationsGameOfLife.Text), StrToInt(EdtWidthGameOfLife.Text));
  end;

  ActClear.Execute;

  tempX := StrToInt(EdtWidthGameOfLife.Text) div 2;
  tempY := StrToInt(EdtIterationsGameOfLife.Text) div 2;

  FCellularAutomata.SetValue(tempY, tempX, 1);
  FCellularAutomata.SetValue(tempY + 1, tempX, 1);
  FCellularAutomata.SetValue(tempY + 2, tempX, 1);

  Draw;
end;

procedure TForm1.Draw;
var xScale, yScale, x, y, I, J, Width, Iterations, Scale : Integer;
begin
  if Assigned(FCellularAutomata) then begin

    Image.Canvas.Pen.Color := clBlack;
    Image.Canvas.Brush.Color := clBlack;

    Width := StrToInt(EdtWidthGameOfLife.Text);
    Iterations := StrToInt(EdtIterationsGameOfLife.Text);

    xScale := Image.Width div Width;
    yScale := Image.Height div StrToInt(EdtIterationsGameOfLife.Text);

    if xScale > yScale then Scale := yScale else Scale := xScale;

    y := 0;
    for I := 0 to Iterations - 1 do begin
      x := 0;
      for J := 0 to Width - 1 do begin
        if FCellularAutomata.GetValue(I, J) = 1 then begin
          Image.Canvas.Rectangle(x, y, x + Scale, y + Scale);
        end;
        x := x + Scale;
      end;
      y := y + Scale;
    end;
  end;
end;

procedure TForm1.DrawGrid;
var xScale, yScale, I, Width, Iterations, Scale: Integer;
begin
  Image.Canvas.Pen.Color := clBlack;

  Width := StrToInt(EdtWidthGameOfLife.Text);
  Iterations := StrToInt(EdtIterationsGameOfLife.Text);

  xScale := Image.Width div Width;
  yScale := Image.Height div Iterations;

  if xScale > yScale then Scale := yScale else Scale := xScale;


  for I := 0 to Width do begin
    Image.Canvas.MoveTo(Scale * I, 0);
    Image.Canvas.LineTo(Scale * I, Iterations * 4 * (Scale div 4));
  end;

  for I := 0 to Iterations do begin
    Image.Canvas.MoveTo(0, Scale * I);
    Image.Canvas.LineTo(Width * 4 * (Scale div 4), Scale * I);
  end;

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Image.Canvas.Brush.Color := clWhite;
  Image.Canvas.FillRect(Rect(0, 0, Image.Width, Image.Height));

  DrawGrid;

  FCellularAutomata := TCellularAutomata.Create;
  FCellularAutomata.PrepareGridGameOfLife(StrToInt(EdtIterationsGameOfLife.Text), StrToInt(EdtWidthGameOfLife.Text));
end;

procedure TForm1.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var xScale, yScale, Value, Scale: Integer;
begin
  if Assigned(FCellularAutomata) then begin
    xScale := Image.Width div StrToInt(EdtWidthGameOfLife.Text);
    yScale := Image.Height div StrToInt(EdtIterationsGameOfLife.Text);

    if xScale > yScale then Scale := yScale else Scale := xScale;

    if (x > FCellularAutomata.Width * Scale) then Exit;
    if (y > FCellularAutomata.Iterations * Scale) then Exit;


    Value := FCellularAutomata.GetValue(y div Scale, x div Scale);

    if Value <> 0 then Value := 0 else Value := 1;

    FCellularAutomata.SetValue(y div Scale, x div Scale, Value);

    ActClear.Execute;
    Draw;
  end;

end;

procedure TForm1.TimerGameOfLifeTimer(Sender: TObject);
begin
  Try
    FCellularAutomata.StepGameOfLife(StrToInt(EdtIterationsGameOfLife.Text), StrToInt(EdtWidthGameOfLife.Text));

    actClear.Execute;
    Draw;
  Except
    on E : Exception do
    begin
      ActGameOfLifeTimer.Execute;
      ShowMessage('Exception class name = '+E.ClassName);
      ShowMessage('Exception message = '+E.Message);
    end;
  End;
end;

end.
