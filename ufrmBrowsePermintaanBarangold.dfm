inherited frmBrowsePermintaanBarang: TfrmBrowsePermintaanBarang
  Left = 507
  Top = 249
  Caption = 'Browse Permintaan Barang'
  ClientWidth = 939
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited AdvPanel1: TAdvPanel
    Width = 939
    FullHeight = 0
    inherited cxButton1: TcxButton
      OnClick = cxButton1Click
    end
    inherited cxButton2: TcxButton
      OnClick = cxButton2Click
    end
    inherited cxButton3: TcxButton
      Visible = False
    end
    inherited cxButton4: TcxButton
      OnClick = cxButton4Click
    end
    inherited cxButton7: TcxButton
      Visible = False
    end
    inherited cxButton8: TcxButton
      Left = 850
    end
  end
  inherited AdvPanel2: TAdvPanel
    Width = 939
    FullHeight = 0
    inherited btnRefresh: TcxButton
      Left = 850
    end
  end
  inherited AdvPanel3: TAdvPanel
    Width = 939
    FullHeight = 0
    inherited cxGrid: TcxGrid
      Width = 935
      PopupMenu = PopupMenu1
      inherited cxGrdMaster: TcxGridDBTableView
        Styles.OnGetContentStyle = cxGrdMasterStylesGetContentStyle
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 360
    Top = 273
    object UpdateStatusKembali1: TMenuItem
      Caption = 'Update Status Kembali'
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 216
    Top = 185
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clAqua
    end
    object cxStyle2: TcxStyle
    end
  end
end
