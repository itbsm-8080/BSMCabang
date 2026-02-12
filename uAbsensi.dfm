object Form1: TForm1
  Left = 208
  Top = 140
  Width = 641
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 200
    Top = 176
    Width = 201
    Height = 89
    Caption = 'ABSEN'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object MyConnection1: TMyConnection
    Database = 'hrd_roti'
    Left = 344
    Top = 24
  end
end
