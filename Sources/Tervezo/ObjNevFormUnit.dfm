object ObjNevForm: TObjNevForm
  Left = 273
  Top = 397
  AutoScroll = False
  BorderIcons = []
  Caption = 'Objektum neve'
  ClientHeight = 81
  ClientWidth = 388
  Color = clBtnFace
  Font.Charset = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Times New Roman'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 9
    Top = 11
    Width = 107
    Height = 19
    Caption = 'Objektum neve:'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object OKBtn: TBitBtn
    Left = 94
    Top = 48
    Width = 97
    Height = 25
    Caption = 'Rendben'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = OKBtnClick
    Kind = bkOK
  end
  object CancelBtn: TBitBtn
    Left = 198
    Top = 48
    Width = 97
    Height = 25
    Caption = 'Mégsem'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    Kind = bkCancel
  end
  object NevEdit: TEdit
    Left = 124
    Top = 8
    Width = 249
    Height = 27
    Color = clInfoBk
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    MaxLength = 30
    ParentFont = False
    TabOrder = 2
    OnKeyPress = NevEditKeyPress
  end
end
