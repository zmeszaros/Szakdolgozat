object BeallitDlg: TBeallitDlg
  Left = 265
  Top = 113
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Beállítások'
  ClientHeight = 510
  ClientWidth = 412
  Color = clBtnFace
  Font.Charset = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Times New Roman'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 17
  object OKBtn: TBitBtn
    Left = 96
    Top = 472
    Width = 97
    Height = 25
    Caption = 'Rendben'
    TabOrder = 0
    OnClick = OKBtnClick
    Kind = bkOK
  end
  object CancelBtn: TBitBtn
    Left = 220
    Top = 472
    Width = 97
    Height = 25
    Caption = 'Mégsem'
    TabOrder = 1
    OnClick = CancelBtnClick
    Kind = bkCancel
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 395
    Height = 451
    AutoSize = True
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object PageControl1: TPageControl
      Left = 2
      Top = 2
      Width = 391
      Height = 447
      ActivePage = KapcsTabSheet
      MultiLine = True
      Style = tsFlatButtons
      TabOrder = 0
      object AltTabSheet: TTabSheet
        Caption = 'Általános beállítások'
        object GroupBox2: TGroupBox
          Left = 8
          Top = 136
          Width = 177
          Height = 97
          Caption = 'Képernyõ'
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object SzinAtmenetBox: TCheckBox
            Left = 8
            Top = 42
            Width = 163
            Height = 17
            Caption = 'Színátmenetes ablakok'
            Checked = True
            State = cbChecked
            TabOrder = 0
            OnClick = SzinAtmenetBoxClick
          end
        end
        object GroupBox1: TGroupBox
          Left = 6
          Top = 11
          Width = 369
          Height = 105
          Caption = 'Alapértelmezett épület'
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object FileNevEdit: TEdit
            Left = 8
            Top = 30
            Width = 353
            Height = 23
            TabStop = False
            AutoSelect = False
            Color = clInfoBk
            Font.Charset = EASTEUROPE_CHARSET
            Font.Color = clMaroon
            Font.Height = -13
            Font.Name = 'Times New Roman'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            OnChange = FileNevEditChange
            OnDblClick = FileNevEditDblClick
          end
          object BtnBeallit: TBitBtn
            Left = 88
            Top = 64
            Width = 89
            Height = 25
            Caption = 'Beállít...'
            TabOrder = 1
            OnClick = BtnBeallitClick
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              04000000000080000000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555777555
              5555555555000757755555575500005007555570058880000075570870088078
              007555787887087777755550880FF0800007708080888F7088077088F0708F78
              88077000F0778080005555508F0008800755557878FF88777075570870080088
              0755557075888070755555575500075555555555557775555555}
          end
          object BtnTorles: TBitBtn
            Left = 192
            Top = 64
            Width = 89
            Height = 25
            Cancel = True
            Caption = 'Törlés'
            TabOrder = 2
            OnClick = BtnTorlesClick
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
              555557777F777555F55500000000555055557777777755F75555005500055055
              555577F5777F57555555005550055555555577FF577F5FF55555500550050055
              5555577FF77577FF555555005050110555555577F757777FF555555505099910
              555555FF75777777FF555005550999910555577F5F77777775F5500505509990
              3055577F75F77777575F55005055090B030555775755777575755555555550B0
              B03055555F555757575755550555550B0B335555755555757555555555555550
              BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
              50BB555555555555575F555555555555550B5555555555555575}
            NumGlyphs = 2
          end
        end
        object RadioGroup1: TRadioGroup
          Left = 200
          Top = 136
          Width = 177
          Height = 97
          Caption = 'Hangjelzés riasztás esetén'
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object FolyamatosHangBtn: TRadioButton
          Left = 216
          Top = 184
          Width = 113
          Height = 17
          Caption = 'Folyamatos'
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = FolyamatosHangBtnClick
        end
        object EgyHangBtn: TRadioButton
          Left = 216
          Top = 160
          Width = 113
          Height = 17
          Caption = 'Egyszeri'
          Checked = True
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          TabStop = True
          OnClick = EgyHangBtnClick
        end
        object NincsHangBtn: TRadioButton
          Left = 216
          Top = 208
          Width = 113
          Height = 17
          Caption = 'Nincs'
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = NincsHangBtnClick
        end
      end
      object KapcsTabSheet: TTabSheet
        Caption = 'Kapcsolat'
        ImageIndex = 1
        object Bevel1: TBevel
          Left = 152
          Top = 280
          Width = 209
          Height = 50
          Shape = bsFrame
        end
        object Label1: TLabel
          Left = 144
          Top = 68
          Width = 51
          Height = 19
          Caption = 'Stop bit:'
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 144
          Top = 6
          Width = 130
          Height = 19
          Caption = 'Kommunikációs port:'
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
        end
        object BaudRateRadio: TComRadioGroup
          Left = 16
          Top = 0
          Width = 113
          Height = 409
          Hint = 'Átviteli sebesség'
          ComProperty = cpBaudRate
          Caption = 'Baud Rate:'
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = BaudRateRadioClick
        end
        object DataBitRadio: TComRadioGroup
          Left = 152
          Top = 136
          Width = 73
          Height = 121
          ComProperty = cpDataBits
          Caption = 'Data Bit:'
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 3
          OnClick = DataBitRadioClick
        end
        object ComBox: TComComboBox
          Left = 144
          Top = 26
          Width = 225
          Height = 27
          ComProperty = cpPort
          Text = 'COM1'
          Style = csDropDownList
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          ItemHeight = 19
          ItemIndex = 0
          ParentFont = False
          TabOrder = 1
          OnChange = ComBoxChange
        end
        object StopBitBox: TComComboBox
          Left = 144
          Top = 88
          Width = 225
          Height = 27
          ComProperty = cpStopBits
          Text = '1'
          Style = csDropDownList
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          ItemHeight = 19
          ItemIndex = 0
          ParentFont = False
          TabOrder = 2
          OnChange = StopBitBoxChange
        end
        object FlowControlRadio: TComRadioGroup
          Left = 256
          Top = 136
          Width = 105
          Height = 121
          ComProperty = cpFlowControl
          Caption = 'Flow Control:'
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 4
          OnClick = FlowControlRadioClick
        end
        object AutInditBox: TCheckBox
          Left = 171
          Top = 296
          Width = 169
          Height = 17
          Hint = 'Indításkor létrehozza a kapcsolatot'
          Caption = 'Automatikus csatlakozás'
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = AutInditBoxClick
        end
      end
    end
  end
end
