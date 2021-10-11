object Form3: TForm3
  Left = 521
  Top = 475
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 4
  Caption = 'MODIFY'
  ClientHeight = 92
  ClientWidth = 277
  Color = clWhite
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 12
    Top = 6
    Width = 176
    Height = 12
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1085#1091#1078#1085#1091#1102' '#1082#1072#1090#1088#1077#1075#1086#1088#1080#1102':'
  end
  object ComboBox1: TComboBox
    Left = 14
    Top = 30
    Width = 251
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -10
    Font.Name = 'Verdana'
    Font.Style = []
    ItemHeight = 12
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 115
    Top = 66
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'Verdana'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 193
    Top = 66
    Width = 75
    Height = 25
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'Verdana'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 2
    OnClick = Button2Click
  end
end
