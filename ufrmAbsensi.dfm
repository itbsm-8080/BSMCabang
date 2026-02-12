object frmApproveAbsensi: TfrmApproveAbsensi
  Left = 315
  Top = 243
  Width = 1170
  Height = 398
  Caption = 'Approve Absensi'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 41
    Width = 1154
    Height = 48
    Align = alTop
    BevelInner = bvRaised
    Color = clWhite
    TabOrder = 0
    UseDockManager = True
    AnchorHint = False
    AutoSize.Enabled = False
    AutoSize.Height = True
    AutoSize.Width = True
    AutoHideChildren = True
    BackgroundPosition = bpTopLeft
    BorderColor = clBlack
    BorderShadow = False
    Buffered = True
    CanMove = False
    CanSize = False
    Caption.ButtonPosition = cbpRight
    Caption.Color = clHighlight
    Caption.ColorTo = clNone
    Caption.CloseColor = clBtnFace
    Caption.CloseButton = False
    Caption.CloseButtonColor = clWhite
    Caption.Flat = False
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clHighlightText
    Caption.Font.Height = -11
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.Height = 20
    Caption.Indent = 0
    Caption.MinMaxButton = False
    Caption.MinMaxButtonColor = clWhite
    Caption.ShadeLight = 200
    Caption.ShadeGrain = 32
    Caption.ShadeType = stNormal
    Caption.Shape = csRectangle
    Caption.TopIndent = 0
    Caption.Visible = False
    Collaps = False
    CollapsColor = clGray
    CollapsDelay = 20
    CollapsSteps = 0
    ColorTo = clNone
    FixedTop = False
    FixedLeft = False
    FixedHeight = False
    FixedWidth = False
    FreeOnClose = False
    Hover = False
    HoverColor = clNone
    HoverFontColor = clNone
    Indent = 0
    LineSpacing = 0
    Position.Save = False
    Position.Location = clRegistry
    ShadowColor = clGray
    ShadowOffset = 2
    ShowMoveCursor = False
    TextVAlign = tvaTop
    TopIndent = 0
    URLColor = clBlue
    FullHeight = 0
    object Label3: TLabel
      Left = 16
      Top = 14
      Width = 36
      Height = 13
      Caption = 'Periode'
    end
    object Label2: TLabel
      Left = 216
      Top = 16
      Width = 11
      Height = 13
      Caption = 'sd'
    end
    object Refresh: TButton
      Left = 392
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Refresh'
      TabOrder = 0
      OnClick = RefreshClick
    end
    object startdate: TDateTimePicker
      Left = 64
      Top = 11
      Width = 145
      Height = 21
      Date = 42350.468570856480000000
      Time = 42350.468570856480000000
      TabOrder = 1
    end
    object enddate: TDateTimePicker
      Left = 240
      Top = 11
      Width = 145
      Height = 21
      Date = 42350.468570856480000000
      Time = 42350.468570856480000000
      TabOrder = 2
    end
  end
  object AdvPanel3: TAdvPanel
    Left = 0
    Top = 324
    Width = 1154
    Height = 35
    Align = alBottom
    BevelInner = bvRaised
    Color = clWhite
    TabOrder = 1
    UseDockManager = True
    AnchorHint = False
    AutoSize.Enabled = False
    AutoSize.Height = True
    AutoSize.Width = True
    AutoHideChildren = True
    BackgroundPosition = bpTopLeft
    BorderColor = clBlack
    BorderShadow = False
    Buffered = True
    CanMove = False
    CanSize = False
    Caption.ButtonPosition = cbpRight
    Caption.Color = clHighlight
    Caption.ColorTo = clNone
    Caption.CloseColor = clBtnFace
    Caption.CloseButton = False
    Caption.CloseButtonColor = clWhite
    Caption.Flat = False
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clHighlightText
    Caption.Font.Height = -11
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.Height = 20
    Caption.Indent = 0
    Caption.MinMaxButton = False
    Caption.MinMaxButtonColor = clWhite
    Caption.ShadeLight = 200
    Caption.ShadeGrain = 32
    Caption.ShadeType = stNormal
    Caption.Shape = csRectangle
    Caption.TopIndent = 0
    Caption.Visible = False
    Collaps = False
    CollapsColor = clGray
    CollapsDelay = 20
    CollapsSteps = 0
    ColorTo = clNone
    FixedTop = False
    FixedLeft = False
    FixedHeight = False
    FixedWidth = False
    FreeOnClose = False
    Hover = False
    HoverColor = clNone
    HoverFontColor = clNone
    Indent = 0
    LineSpacing = 0
    Position.Save = False
    Position.Location = clRegistry
    ShadowColor = clGray
    ShadowOffset = 2
    ShowMoveCursor = False
    TextVAlign = tvaTop
    TopIndent = 0
    URLColor = clBlue
    FullHeight = 0
    object cxButton8: TcxButton
      Left = 1065
      Top = 2
      Width = 87
      Height = 31
      Caption = '&Tutup'
      TabOrder = 0
      OnClick = cxButton8Click
      Align = alRight
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF001D63
        9B1619609839145D9562105A92880D5890A4135C92FC0C578FED999999FF7171
        71FF545454FF515151FF4F4F4FFF4C4C4CFF4A4A4AFF474747FF454545FF2567
        9DFF3274A8FF3D7CAFFF4784B5FF4E8ABAFF3E7EADFF0C578FEAFFFFFF00FFFF
        FF00585858FFA2A2A2FFA2A2A2FFA3A3A3FFA4A4A4FFA4A4A4FFA5A5A5FF2F6F
        A5FF78ABD2FF78ABD3FF73A7D1FF69A0CDFF407FAEFF0F5991EAFFFFFF00FFFF
        FF005C5C5CFFA1A1A1FF3C7340FFA0A1A1FFA3A3A3FFA3A3A3FFA4A4A4FF3674
        AAFF7DAFD4FF5B9AC9FF5495C7FF5896C8FF4180AEFF135C94EAFFFFFF00FFFF
        FF00606060FFA0A0A0FF3D7641FF367139FFA2A2A2FFA2A2A2FFA3A3A3FF3D79
        B0FF82B3D7FF629FCCFF5A9AC9FF5E9BCAFF4381AFFF196098EA37823EFF347E
        3BFF317937FF2E7534FF499150FF468F4CFF39733DFFA1A1A1FFA2A2A2FF457E
        B4FF88B7D9FF67A3CFFF619ECCFF639FCCFF4583B1FF1F649CEA3B8742FF89CB
        92FF84C88DFF80C688FF7BC383FF77C17FFF478F4DFF3B743FFFA1A1A1FF4C84
        BAFF8DBBDBFF6EA8D1FF66A6D1FF5FB4DFFF4785B1FF2569A1EA3E8B46FF8FCE
        99FF7DC687FF78C381FF73C07CFF74C07CFF79C281FF49904FFF547F57FF5489
        BFFF94BFDDFF75ADD4FF63B8E1FF4BD4FFFF428BB8FF2C6EA6EA41904AFF94D2
        9FFF91D09AFF8DCD96FF89CB92FF84C88DFF519858FF417C46FF9F9F9FFF5A8E
        C4FF98C3E0FF7CB3D7FF74AFD6FF5EC4EDFF4B88B3FF3473ABEA44944DFF4291
        4BFF3F8D48FF3D8945FF5DA465FF5AA061FF45834BFF9E9E9EFF9E9E9EFF6092
        C9FF9EC7E2FF83B8DAFF7DB4D7FF7EB3D7FF4F89B4FF3B79B1EAFFFFFF00FFFF
        FF00777777FF9A9A9AFF3D8A45FF498A4FFF9C9C9CFF9D9D9DFF9D9D9DFF6696
        CCFFA2CBE3FF89BDDCFF83B9DAFF84B9DAFF518BB5FF437EB6EAFFFFFF00FFFF
        FF007A7A7AFF999999FF529159FF999A99FF9B9B9BFF9C9C9CFF9C9C9CFF6C9A
        D0FFA7CEE5FF8FC1DFFF89BDDCFF8BBDDCFF538DB6FF4B84BCEAFFFFFF00FFFF
        FF007D7D7DFF999999FF999999FF9A9A9AFF9A9A9AFF9B9B9BFF9B9B9BFF6F9D
        D3FFAAD1E7FFABD1E7FF98C7E1FF91C2DEFF568FB7FF5289C1EAFFFFFF00FFFF
        FF00808080FF7E7E7EFF7C7C7CFF7A7A7AFF777777FF757575FF727272FF719E
        D4FF6F9ED6FF87B2DCFFABD3E8FFA9D0E6FF5890B8FF598EC6EAFFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00709ED6DB6D9CD4FF85B1DAFF5A91B9FF6093CBEAFFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF006D9CD4896A9AD2FB6697CFEE}
      LookAndFeel.Kind = lfStandard
      LookAndFeel.SkinName = 'LondonLiquidSky'
    end
    object cxButton1: TcxButton
      Left = 2
      Top = 2
      Width = 103
      Height = 31
      Caption = '&Approve'
      TabOrder = 1
      Align = alLeft
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000BA6A368FB969
        35B5B86935EEB76835FFB56835FFB46734FFB26634FFB06533FFAE6433FFAC63
        32FFAA6232FFA96132FFA86031FFA76031FEA66031F1A86131C4BA6A35DEEBC6
        ADFFEAC5ADFFFEFBF8FFFEFBF8FFFEFBF8FFFEFBF8FFFEFBF8FFFEFBF8FFFEFB
        F8FFFEFBF8FFFEFBF8FFFEFBF8FFC89A7CFFC79879FFA76031EDBA6B37FEEDCA
        B3FFE0A27AFFFEFAF7FF62C088FF62C088FF62C088FF62C088FF62C088FF62C0
        88FF62C088FF62C088FFFDF9F6FFCA8D65FFC99B7CFFA76031FEBB6C38FFEECC
        B6FFE1A27AFFFEFAF7FFBFDCC2FFBFDCC2FFBFDCC2FFBFDCC2FFBFDCC2FFBFDC
        C2FFBFDCC2FFBFDCC2FFFDF9F6FFCD9068FFCC9E81FFA86132FFBB6B38FFEFCE
        B8FFE1A279FFFEFAF7FF62C088FF62C088FF62C088FF62C088FF62C088FF62C0
        88FF62C088FF62C088FFFDF9F6FFCF936AFFCEA384FFAA6132FFBA6A36FFEFD0
        BBFFE2A27AFFFEFBF8FFFEFBF8FFFEFBF8FFFEFBF8FFFEFBF8FFFEFBF8FFFEFB
        F8FFFEFBF8FFFEFBF8FFFEFBF8FFD3966DFFD2A78AFFAB6232FFBB6A36FFF0D2
        BEFFE2A37AFFE2A37AFFE1A37AFFE2A37BFFE1A37BFFE0A178FFDE9F77FFDD9F
        76FFDC9D74FFD99B72FFD89971FFD69970FFD5AB8EFFAD6333FFBB6A36FFF2D5
        C2FFE3A37AFFE3A37AFFE2A37BFFE2A37BFFE2A47BFFE1A279FFE0A178FFDEA0
        77FFDE9E75FFDC9D74FFDA9B73FFD99B73FFDAB095FFAF6433FFBB6A36FFF2D8
        C5FFE3A47BFFE3A37AFFE3A47AFFE2A47BFFE2A37BFFE1A37BFFE1A279FFDFA0
        77FFDE9F76FFDD9E74FFDB9C72FFDC9D74FFDDB59AFFB16534FFBB6B36FFF4D9
        C7FFE6A67DFFC88C64FFC98D65FFC98E67FFCB926CFFCB926DFFCA9069FFC88C
        65FFC88C64FFC88C64FFC88C64FFDA9C74FFE1BA9FFFB36634FFBB6B36FEF4DC
        C9FFE7A77DFFF9ECE1FFF9ECE1FFF9EDE3FFFCF4EEFFFDFAF7FFFDF7F3FFFAED
        E5FFF7E7DBFFF7E5D9FFF6E5D8FFDEA077FFE4BEA4FFB46734FFBC6B36FAF5DD
        CCFFE7A87EFFFAF0E8FFFAF0E8FFC98D66FFFAF0E9FFFDF8F3FFFEFAF8FFFCF4
        EFFFF9E9DFFFF7E7DBFFF7E5D9FFE0A278FFE7C2A9FFB66835FFBC6B36F0F6DF
        D0FFE8A87EFFFCF6F1FFFCF6F1FFC88C64FFFAF1E9FFFBF4EEFFFDFAF7FFFDF9
        F6FFFAF0E8FFF8E8DDFFF7E6DBFFE1A37AFFEFD5C3FFB76935FEBC6B36D8F6DF
        D1FFE9AA80FFFEFAF6FFFDFAF6FFC88C64FFFBF3EEFFFBF1EAFFFCF6F2FFFEFB
        F8FFFCF6F1FFF9ECE2FFF8E7DBFFEED0BAFFECD0BDFFBB703EF8BC6B369BF6E0
        D1FFF7E0D1FFFEFBF8FFFEFBF7FFFDF9F6FFFCF5F0FFFAF0EAFFFBF2EDFFFDF9
        F6FFFDFAF7FFFBF1EBFFF8E9DFFEECD0BDFBC9895EECB5693563BC6B3671BC6B
        3690BC6B36CCBC6B36EEBC6B36FABB6B36FEBB6B36FFBB6A36FFBB6A36FFBC6C
        39FFBD6E3BFFBB6D3AFFBB6B38EFBB703ECBB6693554FFFFFF00}
      LookAndFeel.Kind = lfStandard
      LookAndFeel.SkinName = 'LondonLiquidSky'
    end
    object cxButton7: TcxButton
      Left = 192
      Top = 2
      Width = 87
      Height = 31
      Caption = '&Export'
      TabOrder = 2
      OnClick = cxButton7Click
      Align = alLeft
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00CE8C6300C6845200D68C6300E78C
        6B00DE8C6B00DE8C6B00D68C6B00CE8C6B00AD6B4200A55A2900FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00C6845200EFCEBD00DEFFFF0084EF
        C600A5F7D600A5F7D6008CEFC600E7FFFF00DEA58400AD6B3900DEB59400D69C
        7300D6946300CE946300CE8C5A00CE8C5A00C67B5200EFB59C00EFF7EF0052BD
        84006BCE940073CE9C0052BD8400E7F7EF00DE9C7B00AD6B3900D6A57300FFF7
        EF00F7F7EF00F7EFE700F7EFE700F7E7DE00C6845200EFB59400F7F7EF00EFF7
        E700EFF7E700EFF7E700EFF7E700F7F7EF00D69C7B00AD6B4200DEA57B00FFF7
        EF00EFD6BD00FFFFFF00EFD6BD00FFFFFF00CE8C6300E7B59400E7A58400E7A5
        8400DEA57B00DEA57B00DE9C7B00DE9C7300D69C7300BD7B5200DEA57B00FFF7
        EF00EFD6BD00EFD6BD00EFD6BD00EFD6BD00CE8C6300EFB59C00DEA57B00DEA5
        7B00DEA57B00DE9C7B00DE9C7B00DE9C7300DE9C7300BD845A00DEAD8400FFF7
        EF00EFCEB500FFFFFF00EFD6BD00FFFFFF00CE845A00EFBDA500FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEA58400C67B5200E7AD8400FFF7
        F700EFCEB500EFCEB500EFCEB500EFCEB500C6845A00EFBD9C00FFFFFF00CE94
        6B00FFFFFF00FFFFFF00FFFFF700FFFFF700E7AD8C00C68C6300E7B58C00FFF7
        F700EFCEAD00FFFFFF00EFCEAD00FFFFFF00CE8C6300F7CEAD00FFFFFF00E7C6
        B500FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFBDA500CE8C5A00E7B58C00FFF7
        F700EFC6AD00EFC6AD00EFC6AD00EFC6AD00D6946B00D69C7B00D6947300D6A5
        8400CE8C6300CE8C6B00D69C7300D69C7300CE8C6300EFDECE00E7B59400FFF7
        F700EFC6A500FFFFFF00EFC6AD00FFFFFF00FFFFFF00FFFFFF00EFC6AD00FFFF
        FF00FFFFFF00FFFFFF00F7F7EF00CE8C5A00FF00FF00FF00FF00EFBD9400FFF7
        F700EFC6A500EFC6A500EFC6A500EFC6A500EFC6A500EFC6A500EFC6A500EFC6
        A500EFC6A500EFC6A500FFF7F700CE946300FF00FF00FF00FF00EFBD9C00FFF7
        F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFF7F700D6946B00FF00FF00FF00FF00EFBD9C00FFF7
        F7009CD6A50094D6A50094D69C008CCE94008CCE940084CE8C0084C68C007BC6
        84007BC67B0073BD7B00FFF7F700D69C6B00FF00FF00FF00FF00EFC6A500FFF7
        F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7
        F700FFF7F700FFF7F700FFF7F700DEA57300FF00FF00FF00FF00F7E7D600F7C6
        AD00EFBD9C00EFBD9C00EFBD9C00EFBD9400E7B59400E7B58C00E7B58C00E7AD
        8400E7AD8400DEAD7B00DEA57B00E7B59400FF00FF00FF00FF00}
      LookAndFeel.Kind = lfStandard
      LookAndFeel.SkinName = 'LondonLiquidSky'
    end
    object cxButton4: TcxButton
      Left = 105
      Top = 2
      Width = 87
      Height = 31
      Caption = '&Reject'
      TabOrder = 3
      Align = alLeft
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00DEE7
        E700ADA5A500ADA5A500ADA5A500ADA5A500ADA5A500ADA5A500ADA5A500ADA5
        A500ADA5A500ADA5A500ADA5A500ADA5A500FF00FF00FF00FF00FF00FF00DEE7
        E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00ADA5A500FF00FF00FF00FF00FF00FF00DEE7
        E700FFFFFF00FFFFFF007B94FF00ADB5FF00FFFFFF00F7FFFF00FFFFFF00635A
        FF008C84F700FFFFFF00FFFFFF00ADA5A500FF00FF00FF00FF00FF00FF00DEE7
        E700FFFFFF00C6D6FF00294AFF000829FF00ADB5FF00FFFFFF005A5AF7000000
        FF000000FF00DEE7F700FFFFFF00ADA5A500FF00FF00FF00FF00FF00FF00DEE7
        E700FFFFFF00F7FFFF00ADBDFF001842FF002142FF005A6BFF000000FF000000
        FF00A5A5FF00FFFFFF00FFFFFF00ADA5A500FF00FF00FF00FF00FF00FF00DEE7
        E700FFFFFF00F7FFFF00FFFFFF00B5BDFF002142FF001031FF000821FF00ADB5
        FF00FFFFFF00F7FFFF00FFFFFF00ADA5A500FF00FF00FF00FF00FF00FF00DEE7
        E700FFFFFF00F7FFFF00FFFFFF00A5B5FF004263FF00294AFF002142FF00ADB5
        F700FFFFFF00F7FFFF00FFFFFF00ADA5A500FF00FF00FF00FF00FF00FF00DEE7
        E700FFFFFF00F7FFFF00BDCEFF006384FF005273FF008494F7001039FF001031
        FF00ADB5F700FFFFFF00FFFFFF00ADA5A500FF00FF00FF00FF00FF00FF00DEE7
        E700FFFFFF00DEEFFF0094ADFF0084A5FF00D6E7FF00FFFFFF00ADBDF700294A
        FF000021FF00D6D6F700FFFFFF00ADA5A500FF00FF00FF00FF00FF00FF00DEE7
        E700FFFFFF00F7FFFF00D6DEFF00D6E7FF00FFFFFF00F7FFFF00F7FFFF009CAD
        F700A5B5FF00FFFFFF00FFFFFF00ADA5A500FF00FF00FF00FF00FF00FF00DEE7
        E700FFFFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
        FF00FFFFFF00F7FFFF00FFFFFF00ADA5A500FF00FF00FF00FF00FF00FF00DEE7
        E700FFFFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00EFF7F700CECE
        CE00D6CED600D6CECE00D6CECE00D6CECE00FF00FF00FF00FF00FF00FF00DEE7
        E700FFFFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00E7EFEF00CECE
        CE00F7FFFF00F7FFFF00D6CECE00FF00FF00FF00FF00FF00FF00FF00FF00DEE7
        E700FFFFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00EFF7F700CECE
        CE00FFFFFF00D6CECE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEE7
        E700FFFFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00EFF7F700CECE
        CE00D6CECE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEE7
        E700DEE7E700DEE7E700DEE7E700DEE7E700DEE7E700DEE7E700DEDEE700D6CE
        CE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      LookAndFeel.Kind = lfStandard
      LookAndFeel.SkinName = 'LondonLiquidSky'
    end
  end
  object AdvPanel2: TAdvPanel
    Left = 0
    Top = 0
    Width = 1154
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    Color = clWhite
    TabOrder = 2
    UseDockManager = True
    AnchorHint = False
    AutoSize.Enabled = False
    AutoSize.Height = True
    AutoSize.Width = True
    AutoHideChildren = True
    BackgroundPosition = bpTopLeft
    BorderColor = clBlack
    BorderShadow = False
    Buffered = True
    CanMove = False
    CanSize = False
    Caption.ButtonPosition = cbpRight
    Caption.Color = clHighlight
    Caption.ColorTo = clNone
    Caption.CloseColor = clBtnFace
    Caption.CloseButton = False
    Caption.CloseButtonColor = clWhite
    Caption.Flat = False
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clHighlightText
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    Caption.Height = 20
    Caption.Indent = 0
    Caption.MinMaxButton = False
    Caption.MinMaxButtonColor = clWhite
    Caption.ShadeLight = 200
    Caption.ShadeGrain = 32
    Caption.ShadeType = stNormal
    Caption.Shape = csRectangle
    Caption.TopIndent = 0
    Caption.Visible = False
    Collaps = False
    CollapsColor = clGray
    CollapsDelay = 20
    CollapsSteps = 0
    ColorTo = clNone
    FixedTop = False
    FixedLeft = False
    FixedHeight = False
    FixedWidth = False
    FreeOnClose = False
    Hover = False
    HoverColor = clNone
    HoverFontColor = clNone
    Indent = 0
    LineSpacing = 0
    Position.Save = False
    Position.Location = clRegistry
    ShadowColor = clGray
    ShadowOffset = 2
    ShowMoveCursor = False
    TextVAlign = tvaTop
    TopIndent = 0
    URLColor = clBlue
    FullHeight = 0
    object lbljudul: TLabel
      Left = 15
      Top = 11
      Width = 136
      Height = 19
      Caption = 'Approve Absensi'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object AdvPanel4: TAdvPanel
    Left = 0
    Top = 89
    Width = 1154
    Height = 235
    Align = alClient
    BevelInner = bvRaised
    Color = clWhite
    TabOrder = 3
    UseDockManager = True
    AnchorHint = False
    AutoSize.Enabled = False
    AutoSize.Height = True
    AutoSize.Width = True
    AutoHideChildren = True
    BackgroundPosition = bpTopLeft
    BorderColor = clBlack
    BorderShadow = False
    Buffered = True
    CanMove = False
    CanSize = False
    Caption.ButtonPosition = cbpRight
    Caption.Color = clHighlight
    Caption.ColorTo = clNone
    Caption.CloseColor = clBtnFace
    Caption.CloseButton = False
    Caption.CloseButtonColor = clWhite
    Caption.Flat = False
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clHighlightText
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    Caption.Height = 20
    Caption.Indent = 0
    Caption.MinMaxButton = False
    Caption.MinMaxButtonColor = clWhite
    Caption.ShadeLight = 200
    Caption.ShadeGrain = 32
    Caption.ShadeType = stNormal
    Caption.Shape = csRectangle
    Caption.TopIndent = 0
    Caption.Visible = False
    Collaps = False
    CollapsColor = clGray
    CollapsDelay = 20
    CollapsSteps = 0
    ColorTo = clNone
    FixedTop = False
    FixedLeft = False
    FixedHeight = False
    FixedWidth = False
    FreeOnClose = False
    Hover = False
    HoverColor = clNone
    HoverFontColor = clNone
    Indent = 0
    LineSpacing = 0
    Position.Save = False
    Position.Location = clRegistry
    ShadowColor = clGray
    ShadowOffset = 2
    ShowMoveCursor = False
    TextVAlign = tvaTop
    TopIndent = 0
    URLColor = clBlue
    FullHeight = 0
    object cxGrid1: TcxGrid
      Left = 2
      Top = 2
      Width = 1150
      Height = 231
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      object cxGridLembur: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Kind = skCount
            Position = spFooter
            Column = clNik
          end>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracImmediately
        OptionsData.Editing = False
        OptionsView.GroupFooterMultiSummaries = True
        OptionsView.GroupFooters = gfAlwaysVisible
        Styles.OnGetContentStyle = cxGridLemburStylesGetContentStyle
        object clNik: TcxGridDBColumn
          Caption = 'Nik'
          DataBinding.FieldName = 'nik'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.ReadOnly = True
          Options.Editing = False
          Width = 124
        end
        object clNama: TcxGridDBColumn
          Caption = 'Nama'
          DataBinding.FieldName = 'nama'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.ReadOnly = True
          Options.Editing = False
          Width = 204
        end
        object cljabatan: TcxGridDBColumn
          Caption = 'Jabatan'
          DataBinding.FieldName = 'jabatan'
          Width = 192
        end
        object clunit: TcxGridDBColumn
          Caption = 'Unit'
          DataBinding.FieldName = 'unit'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.ReadOnly = True
          Options.Editing = False
          Width = 190
        end
        object cltanggal: TcxGridDBColumn
          Caption = 'Tanggal'
          DataBinding.FieldName = 'tanggal'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.ReadOnly = True
          Options.Editing = False
          Width = 134
        end
        object cljam: TcxGridDBColumn
          DataBinding.FieldName = 'jam'
          Options.Editing = False
          Width = 91
        end
        object clstatus: TcxGridDBColumn
          DataBinding.FieldName = 'status'
          PropertiesClassName = 'TcxTextEditProperties'
          Options.Editing = False
          Width = 96
        end
        object clketerangan: TcxGridDBColumn
          DataBinding.FieldName = 'Keterangan'
          PropertiesClassName = 'TcxTextEditProperties'
          Options.Editing = False
          Width = 100
        end
        object clalasan: TcxGridDBColumn
          DataBinding.FieldName = 'alasan'
          Options.Editing = False
          Width = 82
        end
        object clapprove: TcxGridDBColumn
          Caption = 'Keputusan HRD'
          DataBinding.FieldName = 'approve'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.ReadOnly = True
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGridLembur
      end
    end
  end
  object savedlg: TSaveDialog
    Left = 256
    Top = 80
  end
  object MyConnection1: TMyConnection
    Database = 'hrd'
    Port = 3307
    Username = 'root'
    Password = 'Zainal_12345'
    Server = '188.166.226.122'
    LoginPrompt = False
    Left = 672
    Top = 49
  end
  object MyQuery1: TMyQuery
    Connection = MyConnection1
    Left = 664
    Top = 169
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
  object cxStyleRepository1: TcxStyleRepository
    Left = 360
    Top = 145
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clLime
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 488
    Top = 201
    object erlambat1: TMenuItem
      Caption = 'Terlambat'
      OnClick = erlambat1Click
    end
    object idakMasuk1: TMenuItem
      Caption = 'Tidak Masuk'
      OnClick = idakMasuk1Click
    end
    object Masuk1: TMenuItem
      Caption = 'Masuk'
      OnClick = Masuk1Click
    end
  end
end
