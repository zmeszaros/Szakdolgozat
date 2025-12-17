object BerendezesDlg: TBerendezesDlg
  Left = 182
  Top = 109
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 476
  ClientWidth = 771
  Color = clBtnFace
  Font.Charset = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Times New Roman'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 753
    Height = 22
    Alignment = taCenter
    AutoSize = False
    Caption = 'Berendezések listája'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    Transparent = True
  end
  object TorlesBtn: TBitBtn
    Left = 297
    Top = 438
    Width = 75
    Height = 27
    Caption = '&Törlés'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = TorlesBtnClick
    Kind = bkAbort
  end
  object BezarBtn: TBitBtn
    Left = 399
    Top = 438
    Width = 75
    Height = 27
    Caption = '&Bezárás'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BezarBtnClick
    NumGlyphs = 2
  end
  object BerendezesGrid: TStringGrid
    Left = 8
    Top = 39
    Width = 753
    Height = 385
    DefaultRowHeight = 22
    FixedCols = 0
    RowCount = 2
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ParentFont = False
    TabOrder = 2
    ColWidths = (
      51
      145
      145
      202
      202)
  end
end
