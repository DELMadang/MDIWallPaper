object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'MDI Wallpaper'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  TextHeight = 15
  object MainMenu1: TMainMenu
    Left = 32
    Top = 56
    object mmFile: TMenuItem
      Caption = #54028#51068'(&F)'
      object mmNew: TMenuItem
        Caption = #49352#47196' '#47564#46308#44592'(&N)...'
        ShortCut = 16462
        OnClick = mmNewClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mmclose: TMenuItem
        Caption = #45149#45236#44592'(&X)'
        OnClick = mmcloseClick
      end
    end
  end
end
