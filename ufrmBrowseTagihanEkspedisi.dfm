inherited frmBrowseTagihanEkspedisi: TfrmBrowseTagihanEkspedisi
  Left = 391
  Top = 162
  Caption = 'Browse Tagihan Ekspedisi'
  ClientWidth = 945
  OldCreateOrder = True
  WindowState = wsNormal
  PixelsPerInch = 96
  TextHeight = 13
  inherited AdvPanel1: TAdvPanel
    Width = 945
    FullHeight = 0
    inherited cxButton1: TcxButton
      Visible = False
    end
    inherited cxButton2: TcxButton
      OnClick = cxButton2Click
    end
    inherited cxButton3: TcxButton
      OnClick = cxButton3Click
    end
    inherited cxButton4: TcxButton
      Visible = False
    end
    inherited cxButton8: TcxButton
      Left = 856
    end
  end
  inherited AdvPanel2: TAdvPanel
    Width = 945
    Height = 49
    FullHeight = 0
    inherited Label1: TLabel
      Top = 21
      Width = 39
      Caption = 'Tanggal'
    end
    inherited Label2: TLabel
      Top = 21
    end
    inherited btnRefresh: TcxButton
      Left = 856
      Height = 45
    end
    inherited startdate: TDateTimePicker
      Top = 16
    end
    inherited enddate: TDateTimePicker
      Top = 16
    end
  end
  inherited AdvPanel3: TAdvPanel
    Top = 49
    Width = 945
    Height = 391
    FullHeight = 0
    inherited cxGrid: TcxGrid
      Width = 941
      Height = 387
    end
  end
  object cxStyleRepository2: TcxStyleRepository
    Left = 766
    Top = 155
    PixelsPerInch = 96
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = clYellow
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 432
    Top = 145
  end
end
