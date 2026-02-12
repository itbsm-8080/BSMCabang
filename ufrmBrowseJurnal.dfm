inherited frmBrowseJurnal: TfrmBrowseJurnal
  Left = 394
  Top = 139
  Caption = 'Browse Jurnal'
  ClientWidth = 969
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited AdvPanel1: TAdvPanel
    Width = 969
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
      Caption = '&Update Status'
      Visible = False
    end
    inherited cxButton7: TcxButton
      Left = 368
    end
    inherited cxButton6: TcxButton
      Left = 455
    end
    inherited cxButton8: TcxButton
      Left = 880
    end
    object cxButton5: TcxButton
      Left = 556
      Top = 2
      Width = 133
      Height = 32
      Caption = 'Kirim Jurnal ke pusat'
      TabOrder = 7
      OnClick = cxButton5Click
      Align = alLeft
    end
  end
  inherited AdvPanel2: TAdvPanel
    Width = 969
    FullHeight = 0
    inherited btnRefresh: TcxButton
      Left = 880
    end
  end
  inherited AdvPanel3: TAdvPanel
    Width = 969
    FullHeight = 0
    inherited cxGrid: TcxGrid
      Width = 965
      inherited cxGrdMaster: TcxGridDBTableView
        OptionsView.Footer = True
      end
    end
  end
end
