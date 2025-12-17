object UjBerendDlg: TUjBerendDlg
  Left = 505
  Top = 125
  AutoScroll = False
  BorderIcons = []
  Caption = 'Új berendezés'
  ClientHeight = 131
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Times New Roman'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 409
    Height = 73
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 15
    Top = 19
    Width = 119
    Height = 17
    Caption = 'Berendezés neve:'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 15
    Top = 51
    Width = 194
    Height = 17
    Caption = 'Melyik objektumhoz tartozik:'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object BerendezesEdit: TEdit
    Left = 216
    Top = 16
    Width = 193
    Height = 25
    Color = clInfoBk
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clMaroon
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ObjektumComboBox: TComboBox
    Left = 216
    Top = 48
    Width = 193
    Height = 25
    Style = csDropDownList
    Color = clInfoBk
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clMaroon
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ItemHeight = 17
    ParentFont = False
    TabOrder = 1
    Items.Strings = (
      'Egyikhez sem')
  end
  object OKBtn: TBitBtn
    Left = 108
    Top = 96
    Width = 97
    Height = 25
    Caption = 'Rendben'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = OKBtnClick
    Kind = bkOK
  end
  object CancelBtn: TBitBtn
    Left = 220
    Top = 96
    Width = 97
    Height = 25
    Caption = 'Mégsem'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Kind = bkCancel
  end
end
