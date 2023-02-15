object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 593
  ClientWidth = 662
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 240
    Width = 626
    Height = 345
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object buFb25backup: TButton
    Left = 15
    Top = 8
    Width = 75
    Height = 25
    Caption = 'fb25 backup'
    TabOrder = 1
    OnClick = buFb25backupClick
  end
  object buFb30backup: TButton
    Left = 377
    Top = 8
    Width = 82
    Height = 25
    Caption = 'fb30 backup'
    TabOrder = 2
    OnClick = buFb30backupClick
  end
  object buKonweruj: TButton
    Left = 240
    Top = 209
    Width = 169
    Height = 25
    Caption = 'Konwertuj 2.5 -> 3.0'
    TabOrder = 3
    OnClick = buKonwerujClick
  end
  object edBaza25: TEdit
    Left = 136
    Top = 59
    Width = 496
    Height = 21
    TabOrder = 4
  end
  object buSelBaza25: TButton
    Left = 8
    Top = 51
    Width = 122
    Height = 25
    Caption = 'Baza 2.5'
    TabOrder = 5
    OnClick = buSelBaza25Click
  end
  object edBaza30: TEdit
    Left = 136
    Top = 127
    Width = 496
    Height = 21
    TabOrder = 6
  end
  object buBaza30: TButton
    Left = 8
    Top = 125
    Width = 122
    Height = 25
    Caption = 'Baza 3.0'
    TabOrder = 7
    OnClick = buSelBaza25Click
  end
  object buFb25restore: TButton
    Left = 96
    Top = 8
    Width = 75
    Height = 25
    Caption = 'fb25 restore'
    TabOrder = 8
    OnClick = buFb25restoreClick
  end
  object buFb30restore: TButton
    Left = 465
    Top = 8
    Width = 81
    Height = 25
    Caption = 'fb30 restore'
    TabOrder = 9
    OnClick = buFb30restoreClick
  end
  object buFb25info: TButton
    Left = 177
    Top = 8
    Width = 75
    Height = 25
    Caption = 'fb25 info'
    TabOrder = 10
    OnClick = buFb25infoClick
  end
  object buFb30info: TButton
    Left = 552
    Top = 8
    Width = 80
    Height = 25
    Caption = 'fb30 info'
    TabOrder = 11
    OnClick = buFb30infoClick
  end
  object edBak25: TEdit
    Left = 136
    Top = 88
    Width = 496
    Height = 21
    TabOrder = 12
  end
  object Button1: TButton
    Left = 8
    Top = 86
    Width = 122
    Height = 25
    Caption = 'Backup 2.5'
    TabOrder = 13
    OnClick = buSelBaza25Click
  end
  object Button2: TButton
    Left = 8
    Top = 165
    Width = 122
    Height = 25
    Caption = 'Backup 3.0'
    TabOrder = 14
    OnClick = buSelBaza25Click
  end
  object edBak30: TEdit
    Left = 136
    Top = 167
    Width = 496
    Height = 21
    TabOrder = 15
  end
  object OD1: TOpenDialog
    Left = 200
    Top = 232
  end
end
