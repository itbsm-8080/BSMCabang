inherited frmBrowseInkasoBawahHet: TfrmBrowseInkasoBawahHet
  Left = 394
  Top = 139
  Caption = 'Browse Inkaso Bawah Het'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited AdvPanel1: TAdvPanel
    FullHeight = 0
    inherited cxButton1: TcxButton
      Visible = False
      OnClick = cxButton1Click
    end
    inherited cxButton2: TcxButton
      Visible = False
      OnClick = cxButton2Click
    end
    inherited cxButton3: TcxButton
      Left = 281
      Visible = False
      OnClick = cxButton3Click
    end
    inherited cxButton4: TcxButton
      Width = 105
      Visible = False
      OnClick = cxButton4Click
    end
    inherited cxButton7: TcxButton
      Left = 368
    end
    inherited cxButton6: TcxButton
      Left = 455
    end
  end
  inherited AdvPanel2: TAdvPanel
    FullHeight = 0
    inherited Label1: TLabel
      Left = 16
      Top = 34
      Visible = False
    end
    inherited Label2: TLabel
      Left = 256
      Top = 34
      Visible = False
    end
    object Label3: TLabel [2]
      Left = 27
      Top = 11
      Width = 36
      Height = 13
      Caption = 'Periode'
    end
    object Label4: TLabel [3]
      Left = 259
      Top = 11
      Width = 31
      Height = 13
      Caption = 'Tahun'
    end
    inherited startdate: TDateTimePicker
      Left = 104
      Top = 29
      Visible = False
    end
    inherited enddate: TDateTimePicker
      Left = 280
      Top = 29
      Visible = False
    end
    object cbbbulan: TAdvComboBox
      Left = 90
      Top = 7
      Width = 145
      Height = 21
      Color = clWindow
      AutoFocus = False
      ButtonWidth = 19
      Flat = True
      FlatLineColor = clBlack
      FlatParentColor = True
      Etched = False
      FocusBorder = False
      DropWidth = 0
      Enabled = True
      ItemHeight = 13
      Items.Strings = (
        'Januari'
        'Februari'
        'Maret'
        'April'
        'Mei'
        'Juni'
        'Juli'
        'Agustus'
        'September'
        'Oktober'
        'November'
        'Desember')
      LabelPosition = lpLeftTop
      LabelMargin = 4
      LabelTransparent = False
      LabelAlwaysEnabled = False
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      TabOrder = 3
    end
    object edtTahun: TComboBox
      Left = 324
      Top = 7
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      Text = '2021'
      Items.Strings = (
        '2018'
        '2019'
        '2020'
        '2021'
        '2022')
    end
  end
  inherited AdvPanel3: TAdvPanel
    FullHeight = 0
    inherited cxGrid: TcxGrid
      inherited cxGrdMaster: TcxGridDBTableView
        OptionsView.Footer = True
      end
    end
  end
end
