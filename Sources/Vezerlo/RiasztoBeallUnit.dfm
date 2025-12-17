object RiasztoBeallDlg: TRiasztoBeallDlg
  Left = 195
  Top = 122
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Riasztó beállítása'
  ClientHeight = 376
  ClientWidth = 305
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
    Width = 53
    Height = 17
    Caption = 'Riasztó:'
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
  object Label2: TLabel
    Left = 72
    Top = 48
    Width = 191
    Height = 17
    Caption = 'Naplózás, ha riasztás történik'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    OnClick = Label2Click
  end
  object Label3: TLabel
    Left = 18
    Top = 83
    Width = 269
    Height = 17
    Caption = 'A riasztóhoz kapcsolódó berendezés(ek):'
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
    Left = 8
    Top = 340
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
  object CancelBtn: TBitBtn
    Left = 112
    Top = 340
    Width = 97
    Height = 25
    Caption = 'Kilép'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = CancelBtnClick
    Kind = bkCancel
  end
  object NaplozBox: TCheckBox
    Left = 47
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
    TabOrder = 3
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
    TabOrder = 4
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
    TabOrder = 5
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
    Left = 222
    Top = 340
    Width = 75
    Height = 25
    Caption = 'Alkalmaz'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = AlkalmazBtnClick
  end
end
