object OpenDlg: TOpenDlg
  Left = 115
  Top = 90
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Megnyitás'
  ClientHeight = 401
  ClientWidth = 662
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
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 18
    Width = 41
    Height = 19
    Caption = 'Hely :'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 336
    Top = 19
    Width = 313
    Height = 18
    AutoSize = False
    Caption = 'C:\Zoli\Programozás\IntellHouse\Tervezo'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object DriveComboBox1: TDriveComboBox
    Left = 64
    Top = 16
    Width = 257
    Height = 25
    DirList = DirectoryListBox1
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 8
    Top = 56
    Width = 313
    Height = 329
    DirLabel = Label2
    FileList = FileListBox1
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
    ItemHeight = 19
    ParentFont = False
    TabOrder = 1
    OnChange = DirectoryListBox1Change
  end
  object FileListBox1: TFileListBox
    Left = 336
    Top = 56
    Width = 313
    Height = 273
    Enabled = False
    ExtendedSelect = False
    FileType = [ftDirectory, ftNormal]
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
    ItemHeight = 19
    Mask = '*.db'
    ParentFont = False
    ShowGlyphs = True
    TabOrder = 2
  end
  object OpenBtn: TBitBtn
    Left = 368
    Top = 352
    Width = 113
    Height = 33
    Caption = 'Megnyitás'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = OpenBtnClick
    Kind = bkOK
  end
  object CloseBtn: TBitBtn
    Left = 512
    Top = 352
    Width = 113
    Height = 33
    Caption = 'Mégsem'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = CloseBtnClick
    Kind = bkCancel
  end
end
