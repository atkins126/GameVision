object StartupDialogForm: TStartupDialogForm
  Left = 337
  Top = 343
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Startup Dialog'
  ClientHeight = 369
  ClientWidth = 532
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object LogoImage: TImage
    Left = 33
    Top = 12
    Width = 461
    Height = 60
    Cursor = crHandPoint
    Stretch = True
    OnClick = LogoImageClick
    OnDblClick = LogoImageDblClick
  end
  object Bevel: TBevel
    Left = 10
    Top = 315
    Width = 509
    Height = 9
    Shape = bsBottomLine
  end
  object MoreButton: TButton
    Left = 259
    Top = 330
    Width = 75
    Height = 25
    Caption = '&More...'
    TabOrder = 0
    OnClick = MoreButtonClick
  end
  object RunButton: TButton
    Left = 339
    Top = 330
    Width = 75
    Height = 25
    Caption = '&Run'
    TabOrder = 1
    OnClick = RunButtonClick
  end
  object QuitButton: TButton
    Left = 419
    Top = 330
    Width = 75
    Height = 25
    Caption = '&Quit'
    TabOrder = 2
    OnClick = QuitButtonClick
  end
  object RelTypePanel: TPanel
    Left = 8
    Top = 331
    Width = 217
    Height = 25
    BevelOuter = bvLowered
    Caption = 'Full Version'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object PageControl: TPageControl
    Left = 8
    Top = 84
    Width = 511
    Height = 225
    ActivePage = tbReadme
    TabOrder = 4
    object tbReadme: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Readme'
      ImageIndex = 1
      object ReadmeMemo: TRichEdit
        Left = 0
        Top = 0
        Width = 503
        Height = 197
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        Color = 12189695
        EnableURLs = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'Segoe UI'
        Font.Style = []
        HideScrollBars = False
        Lines.Strings = (
          'README.TXT was found or could not be read!')
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        ShowURLHint = True
        SpellChecking = True
        TabOrder = 0
        OnLinkClick = ReadmeMemoLinkClick
      end
    end
    object tbLicense: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'License'
      object LicenseMemo: TRichEdit
        Left = 0
        Top = 0
        Width = 503
        Height = 197
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        Color = 12189695
        EnableURLs = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'Segoe UI'
        Font.Style = []
        HideScrollBars = False
        Lines.Strings = (
          'LICENSE.TXT was found or could not be read!')
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        ShowURLHint = True
        TabOrder = 0
        OnLinkClick = LicenseMemoLinkClick
      end
    end
    object tbConfig: TTabSheet
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Configuration'
      ImageIndex = 2
      object StringGrid: TStringGrid
        Left = 0
        Top = 0
        Width = 759
        Height = 303
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        Color = 12189695
        ColCount = 2
        DefaultColWidth = 96
        DefaultRowHeight = 36
        DoubleBuffered = True
        DrawingStyle = gdsClassic
        FixedCols = 0
        RowCount = 8
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSizing, goColSizing, goFixedRowDefAlign]
        ParentDoubleBuffered = False
        TabOrder = 0
        ColWidths = (
          96
          645)
      end
    end
  end
end
