object HomeroBeallDlg: THomeroBeallDlg
  Left = 308
  Top = 114
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Hõmérõ beállítása'
  ClientHeight = 368
  ClientWidth = 530
  Color = clBtnFace
  Font.Charset = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Times New Roman'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel2: TBevel
    Left = 8
    Top = 80
    Width = 289
    Height = 248
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 11
    Top = 11
    Width = 59
    Height = 17
    Caption = 'Hõmérõ:'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Bevel1: TBevel
    Left = 8
    Top = 43
    Width = 289
    Height = 30
    Shape = bsFrame
  end
  object Label4: TLabel
    Left = 43
    Top = 48
    Width = 234
    Height = 17
    Caption = 'Naplózás, ha változik a hõmérséklet'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    OnClick = Label4Click
  end
  object Label5: TLabel
    Left = 14
    Top = 83
    Width = 276
    Height = 17
    Caption = 'A hõmérõhöz kapcsolódó berendezés(ek):'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object ComboBox1: TComboBox
    Left = 73
    Top = 8
    Width = 224
    Height = 25
    Style = csDropDownList
    Color = clInfoBk
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clMaroon
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ItemHeight = 17
    ParentFont = False
    TabOrder = 0
    OnChange = ComboBox1Change
  end
  object OKBtn: TBitBtn
    Left = 161
    Top = 336
    Width = 97
    Height = 25
    Caption = 'Rendben'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = OKBtnClick
    Kind = bkOK
  end
  object Panel1: TPanel
    Left = 304
    Top = 8
    Width = 217
    Height = 321
    BevelInner = bvLowered
    Color = clTeal
    TabOrder = 2
    object Bevel4: TBevel
      Left = 72
      Top = 224
      Width = 113
      Height = 41
      Shape = bsFrame
    end
    object Bevel3: TBevel
      Left = 56
      Top = 72
      Width = 145
      Height = 97
      Shape = bsFrame
    end
    object FokLabel: TLabel
      Left = 80
      Top = 232
      Width = 97
      Height = 26
      Alignment = taCenter
      AutoSize = False
      Caption = 'FokLabel'
      Color = clOlive
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clMaroon
      Font.Height = -24
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object MaxLabel: TLabel
      Left = 61
      Top = 91
      Width = 75
      Height = 17
      Alignment = taCenter
      Caption = 'Max érték:'
      Color = clOlive
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object MinLabel: TLabel
      Left = 61
      Top = 132
      Width = 72
      Height = 17
      Alignment = taCenter
      Caption = 'Min érték:'
      Color = clOlive
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 64
      Top = 200
      Width = 128
      Height = 22
      Caption = 'Beállított érték:'
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object MaxFokLabel: TLabel
      Left = 42
      Top = 6
      Width = 74
      Height = 15
      Caption = 'MaxFokLabel'
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object MinFokLabel: TLabel
      Left = 42
      Top = 300
      Width = 73
      Height = 15
      Caption = 'MinFokLabel'
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 56
      Top = 48
      Width = 101
      Height = 22
      Caption = 'Méréshatár:'
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object HomeroBar: TTrackBar
      Left = 2
      Top = 2
      Width = 39
      Height = 317
      Cursor = crHandPoint
      Align = alLeft
      Max = 40
      Orientation = trVertical
      Frequency = 1
      Position = 20
      SelEnd = 0
      SelStart = 0
      TabOrder = 0
      TickMarks = tmBoth
      TickStyle = tsAuto
      OnChange = HomeroBarChange
    end
    object MaxEdit: TSpinEdit
      Left = 144
      Top = 88
      Width = 49
      Height = 24
      Color = clInfoBk
      EditorEnabled = False
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      MaxValue = 100
      MinValue = -50
      ParentFont = False
      TabOrder = 1
      Value = 0
      OnChange = MaxEditChange
    end
    object MinEdit: TSpinEdit
      Left = 144
      Top = 128
      Width = 49
      Height = 24
      Color = clInfoBk
      EditorEnabled = False
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      MaxValue = 100
      MinValue = -50
      ParentFont = False
      TabOrder = 2
      Value = 0
      OnChange = MinEditChange
    end
  end
  object CancelBtn: TBitBtn
    Left = 273
    Top = 336
    Width = 97
    Height = 25
    Caption = 'Kilép'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = CancelBtnClick
    Kind = bkCancel
  end
  object NaplozBox: TCheckBox
    Left = 20
    Top = 52
    Width = 13
    Height = 11
    Checked = True
    Color = clBlack
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clSilver
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    State = cbChecked
    TabOrder = 4
    OnClick = NaplozBoxClick
  end
  object ListBox1: TListBox
    Left = 16
    Top = 104
    Width = 273
    Height = 185
    Color = clInfoBk
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ItemHeight = 19
    ParentFont = False
    Sorted = True
    TabOrder = 5
  end
  object Button1: TBitBtn
    Left = 101
    Top = 296
    Width = 103
    Height = 25
    Caption = 'Beállítás...'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = Button1Click
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      88888888888888800888837088888809B0888B370888809B990888B3708809B9
      9088888B37001B9908888888B3019B90888888888B3B1B0888888888880FB088
      8088888880FB3708070888880F88B37078088800F8888B777888808F88888077
      7888878F8888878888888F088888088888888888888808888888}
  end
  object AlkalmazBtn: TButton
    Left = 440
    Top = 336
    Width = 75
    Height = 25
    Caption = 'Alkalmaz'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = AlkalmazBtnClick
  end
end
