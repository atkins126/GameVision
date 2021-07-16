{==============================================================================
   ___              __   ___    _
  / __|__ _ _ __  __\ \ / (_)__(_)___ _ _
 | (_ / _` | '  \/ -_) V /| (_-< / _ \ ' \
  \___\__,_|_|_|_\___|\_/ |_/__/_\___/_||_|
                   Toolkit™

  Copyright © 2020-21 tinyBigGAMES™ LLC
  All rights reserved.

  Website: https://tinybiggames.com
  Email  : support@tinybiggames.com

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software in
     a product, an acknowledgment in the product documentation would be
     appreciated but is not required.

  2. Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.

  3. Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in
     the documentation and/or other materials provided with the
     distribution.

  4. Neither the name of the copyright holder nor the names of its
     contributors may be used to endorse or promote products derived
     from this software without specific prior written permission.

  5. All video, audio, graphics and other content accessed through the
     software in this distro is the property of the applicable content owner
     and may be protected by applicable copyright law. This License gives
     Customer no rights to such content, and Company disclaims any liability
     for misuse of content.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
  COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
  STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
  OF THE POSSIBILITY OF SUCH DAMAGE.
============================================================================== }

unit GameVision.Form.StartupDialog;

{$I GameVision.Defines.inc }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, OleCtrls, SHDocVw, Vcl.ComCtrls,
  Vcl.Grids, GameVision.Common;

type

  { TStartupDialogForm }
  TStartupDialogForm = class(TForm)
    LogoImage: TImage;
    Bevel: TBevel;
    MoreButton: TButton;
    RunButton: TButton;
    QuitButton: TButton;
    RelTypePanel: TPanel;
    PageControl: TPageControl;
    tbLicense: TTabSheet;
    tbReadme: TTabSheet;
    ReadmeMemo: TRichEdit;
    LicenseMemo: TRichEdit;
    tbConfig: TTabSheet;
    StringGrid: TStringGrid;
    procedure MoreButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RunButtonClick(Sender: TObject);
    procedure QuitButtonClick(Sender: TObject);
    procedure LogoImageDblClick(Sender: TObject);
    procedure LogoImageClick(Sender: TObject);
    procedure ReadmeMemoLinkClick(Sender: TCustomRichEdit; const URL: string;
      Button: TMouseButton);
    procedure LicenseMemoLinkClick(Sender: TCustomRichEdit; const URL: string;
      Button: TMouseButton);
  private
    { Private declarations }
    FState: TStartupDialogState;
    FRunOnce: Boolean;
    FClickUrl: string;
    procedure DoClickUrl;
    procedure UpdateConfigInfo;
  public
    property State: TStartupDialogState read FState write FState;

    { Public declarations }
    procedure SetCaption(aCaption: string);

    procedure SetIcon(aFilename: string);

    procedure SetLogo(aFilename: string);
    procedure SetLogoClickUrl(aURL: string);

    procedure SetReadme(aFilename: string);
    procedure SetReadmeText(aText: string);

    procedure SetLicense(aFilename: string);
    procedure SetLicenseText(aText: string);

    procedure SetReleaseInfo(aReleaseInfo: string);

    procedure SetWordWrap(aWrap: Boolean);
  end;

var
  StartupDialogForm: TStartupDialogForm;

implementation

uses
  System.IOUtils,
  pngimage,
  GameVision.Utils,
  GameVision.System;

{$R *.dfm}

{ TStartupDialogForm }
procedure TStartupDialogForm.DoClickUrl;
begin
  GotoURL(FClickUrl);
end;

procedure TStartupDialogForm.UpdateConfigInfo;
//var
//  LFreeSpace: Int64;
//  LTotalSpace: Int64;
//  LAvailMem: UInt64;
//  LTotalMem: UInt64;
begin
  //StringGrid.RowCount := 6;
  (*
  StringGrid.ColWidths[0] := 200;
  StringGrid.ColWidths[1] := 530;

  StringGrid.Cells[0,0] := 'Application';
  StringGrid.Cells[1,0] := TOS.GetAppName;

  StringGrid.Cells[0,1] := 'Path';
  StringGrid.Cells[1,1] := TOS.GetAppPath;

  StringGrid.Cells[0,2] := 'CPU cores';
  StringGrid.Cells[1,2] := TOS.GetCPUCount.ToString;

  StringGrid.Cells[0,3] := 'OS version';
  StringGrid.Cells[1,3] := TOS.GetVersion;

  TOS.GetMemoryFree(LAvailMem, LTotalMem);
  StringGrid.Cells[0,4] := 'Memory Freel/Total';
  StringGrid.Cells[1,4] := Format('%3.2f/%3.2f Gigabytes', [(LAvailMem/1073741824), (LTotalMem/1073741824)]);

  TOS.GetDiskFreeSpace(LFreeSpace, LTotalSpace);
  StringGrid.Cells[0,5] := 'HD Free/Total';
  StringGrid.Cells[1,5] := Format('%3.2f/%3.2f Gigabytes', [(LFreeSpace/1073741824), (LTotalSpace/1073741824)]);

  StringGrid.Cells[0,6] := 'Video Card';
  StringGrid.Cells[1,6] := TOS.GetVideoCard;

  //TODO: figure how to get video card memory
  //StringGrid.Cells[0,7] := 'Video Memory';
  //StringGrid.Cells[1,7] := Format('%d Gigabytes', [(GetVideoCardMemory)]);
  *)
end;

procedure TStartupDialogForm.SetCaption(aCaption: string);
begin
  Caption := aCaption;
end;

procedure TStartupDialogForm.SetIcon(aFilename: string);
var
  LBuffer: TBuffer;
begin
  if aFilename.IsEmpty then Exit;
  LBuffer := TBuffer.FromFile(aFilename);
  try
    if LBuffer <> nil then
    begin
      Icon.LoadFromStream(LBuffer);
    end;
  finally
    FreeAndNil(LBuffer);
  end;
end;

procedure TStartupDialogForm.SetLogo(aFilename: string);
var
  LBuffer: TBuffer;
  LPng: TPngImage;
begin
  if aFilename.IsEmpty then Exit;
  LBuffer := TBuffer.FromFile(aFilename);
  try
    if LBuffer <> nil then
    begin
      LPng := TPngImage.Create;
      try
        LPng.LoadFromStream(LBuffer);
        LogoImage.Picture.Bitmap.Assign(LPng);
      finally
        FreeAndNil(LPng);
      end;
    end;
  finally
    FreeAndNil(LBuffer);
  end;
end;

procedure TStartupDialogForm.SetLogoClickUrl(aURL: string);
begin
  FClickUrl := aURL;
end;

procedure TStartupDialogForm.SetReadme(aFilename: string);
var
  LBuffer: TBuffer;
begin
  if aFilename.IsEmpty then Exit;
  LBuffer := TBuffer.FromFile(aFilename);
  try
    if LBuffer <> nil then
    begin
      ReadMeMemo.WordWrap := True;
      ReadMeMemo.Lines.Clear;
      ReadMeMemo.Lines.LoadFromStream(LBuffer, TEncoding.UTF8);
    end;
  finally
    FreeAndNil(LBuffer);
  end;
end;

procedure TStartupDialogForm.SetReadmeText(aText: string);
begin
  ReadMeMemo.Lines.Clear;
  ReadMeMemo.Lines.Text := aText;
end;

procedure TStartupDialogForm.SetLicense(aFilename: string);
var
  LBuffer: TBuffer;
begin
  if aFilename.IsEmpty then Exit;
  LBuffer := TBuffer.FromFile(aFilename);
  try
    if LBuffer <> nil then
    begin
      LicenseMemo.WordWrap := True;
      LicenseMemo.Lines.Clear;
      LicenseMemo.Lines.LoadFromStream(LBuffer, TEncoding.UTF8);
    end;
  finally
    FreeAndNil(LBuffer);
  end;
end;

procedure TStartupDialogForm.SetLicenseText(aText: string);
begin
  LicenseMemo.Lines.Clear;
  LicenseMemo.Lines.Text := aText;
end;

procedure TStartupDialogForm.SetReleaseInfo(aReleaseInfo: string);
begin
  RelTypePanel.Caption := aReleaseInfo;
end;

procedure TStartupDialogForm.SetWordWrap(aWrap: Boolean);
begin
  ReadMeMemo.WordWrap := aWrap;
  LicenseMemo.WordWrap := aWrap;
  if aWrap then
  begin
    ReadMeMemo.ScrollBars := ssVertical;
    LicenseMemo.ScrollBars := ssVertical;
  end
  else
  begin
    ReadMeMemo.ScrollBars := ssBoth;
    LicenseMemo.ScrollBars := ssBoth;
  end;
end;

procedure TStartupDialogForm.FormActivate(Sender: TObject);
begin
  if not FRunOnce then
  begin
    FRunOnce := True;
    ReadMeMemo.SetFocus;
    ReadMeMemo.SelLength := 0;
    ReadMeMemo.SelStart := 0;

    LicenseMemo.SelLength := 0;
    LicenseMemo.SelStart := 0;
  end;
end;

procedure TStartupDialogForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TStartupDialogForm.FormCreate(Sender: TObject);
begin
  FClickUrl := '';
  Scaled := False;
  if (not(Screen.PixelsPerInch = PixelsPerInch)) then
  begin
    ScaleBy(Screen.PixelsPerInch, PixelsPerInch);
  end;

  FRunOnce := False;
  FState := sdsQuit;

  UpdateConfigInfo;
end;

procedure TStartupDialogForm.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TStartupDialogForm.LicenseMemoLinkClick(Sender: TCustomRichEdit;
  const URL: string; Button: TMouseButton);
begin
  GotoURL(URL);
end;

procedure TStartupDialogForm.LogoImageClick(Sender: TObject);
begin
  //
  DoClickUrl;
end;

procedure TStartupDialogForm.LogoImageDblClick(Sender: TObject);
begin
  //
end;

procedure TStartupDialogForm.MoreButtonClick(Sender: TObject);
begin
  FState := sdsMore;
  Close;
end;

procedure TStartupDialogForm.ReadmeMemoLinkClick(Sender: TCustomRichEdit;
  const URL: string; Button: TMouseButton);
begin
  GotoURL(URL);
end;

procedure TStartupDialogForm.RunButtonClick(Sender: TObject);
begin
  FState := sdsRun;
  Close;
end;

procedure TStartupDialogForm.QuitButtonClick(Sender: TObject);
begin
  FState := sdsQuit;
  Close;
end;

end.
