object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Cellular Automata - Piotr Swat'
  ClientHeight = 881
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image: TImage
    Left = 0
    Top = 81
    Width = 800
    Height = 800
    Align = alClient
    OnMouseDown = ImageMouseDown
    ExplicitWidth = 1290
    ExplicitHeight = 500
  end
  object MainMenu: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 81
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 19
      Width = 47
      Height = 13
      Caption = 'Iterations'
    end
    object Label2: TLabel
      Left = 160
      Top = 19
      Width = 28
      Height = 13
      Caption = 'Width'
    end
    object SpeedButton3: TSpeedButton
      Left = 680
      Top = 44
      Width = 97
      Height = 22
      Action = ActClearButton
      Caption = 'Clear'
    end
    object SpeedButton4: TSpeedButton
      Left = 455
      Top = 19
      Width = 82
      Height = 22
      Action = ActGameOfLifeNotChanging
    end
    object SpeedButton5: TSpeedButton
      Left = 455
      Top = 44
      Width = 82
      Height = 22
      Action = ActGameOfLifeOscilator
    end
    object SpeedButton6: TSpeedButton
      Left = 567
      Top = 19
      Width = 82
      Height = 22
      Action = ActGameOfLifeGlider
    end
    object SpeedButton7: TSpeedButton
      Left = 567
      Top = 42
      Width = 82
      Height = 22
      Action = ActGameOfLifeRandom
    end
    object SpeedButton8: TSpeedButton
      Left = 680
      Top = 19
      Width = 97
      Height = 22
      Action = ActGameOfLifeTimer
    end
    object LblInterval: TLabel
      Left = 304
      Top = 19
      Width = 38
      Height = 13
      Caption = 'Interval'
    end
    object EdtIterationsGameOfLife: TEdit
      Left = 20
      Top = 38
      Width = 121
      Height = 21
      NumbersOnly = True
      TabOrder = 0
      Text = '200'
    end
    object EdtWidthGameOfLife: TEdit
      Left = 160
      Top = 38
      Width = 121
      Height = 21
      NumbersOnly = True
      TabOrder = 1
      Text = '200'
    end
    object EdtInterval: TEdit
      Left = 304
      Top = 38
      Width = 113
      Height = 21
      TabOrder = 2
      Text = '1000'
    end
  end
  object ActionList: TActionList
    Left = 720
    Top = 104
    object ActDraw: TAction
      Caption = 'Draw'
    end
    object ActClear: TAction
      Caption = 'Clear'
      OnExecute = ActClearExecute
    end
    object ActGameOfLifeRandom: TAction
      Caption = 'Random'
      OnExecute = ActGameOfLifeRandomExecute
    end
    object ActGameOfLifeGlider: TAction
      Caption = 'Glider'
      OnExecute = ActGameOfLifeGliderExecute
    end
    object ActGameOfLifeTimer: TAction
      Caption = 'Start'
      OnExecute = ActGameOfLifeTimerExecute
    end
    object ActGameOfLifeNotChanging: TAction
      Caption = 'Not Changing'
      OnExecute = ActGameOfLifeNotChangingExecute
    end
    object ActGameOfLifeOscilator: TAction
      Caption = 'Oscilator'
      OnExecute = ActGameOfLifeOscilatorExecute
    end
    object ActClearButton: TAction
      Caption = 'ActClearButton'
      OnExecute = ActClearButtonExecute
    end
  end
  object TimerGameOfLife: TTimer
    Enabled = False
    OnTimer = TimerGameOfLifeTimer
    Left = 733
    Top = 153
  end
end
