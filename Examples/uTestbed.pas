﻿{==============================================================================
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

unit uTestbed;

interface

uses
  System.SysUtils,
  GameVision.Common,
  GameVision.Audio,
  GameVision.Graphics,
  GameVision.Input,
  GameVision.System,
  GameVision.UI,
  GameVision.Game,
  uCommon,
  uAudio,
  uGraphics,
  uInput,
  uNetwork,
  uUI,
  uSystem,
  uElastic,
  uAstroBlaster;

type
  { TTestbed }
  TTestbed = class(TCustomGameApp)
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnLoad; override;
    procedure OnExit; override;
    function  OnStartupDialogShow: Boolean; override;
    procedure OnStartupDialogMore; override;
    function  OnStartupDialogRun: Boolean; override;
  end;

implementation

{ TTestbed }
procedure TTestbed.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.ArchiveFilename := cArchiveFilename;
end;

procedure TTestbed.OnLoad;
begin
  inherited;

end;

procedure TTestbed.OnExit;
begin

  inherited;
end;

function  TTestbed.OnStartupDialogShow: Boolean;
begin
  StartupDialog.SetCaption(cAppTitle);
  StartupDialog.SetReleaseInfo('Version ' + GAMEVISION_VERSION);
  StartupDialog.SetLogo('arc/startup/banner.png');
  StartupDialog.SetReadme('arc/startup/README.rtf');
  StartupDialog.SetLicense('arc/startup/LICENSE.rtf');
  Result := True;
end;

procedure TTestbed.OnStartupDialogMore;
begin
  inherited;

end;

function  TTestbed.OnStartupDialogRun: Boolean;
type
  TMenuItems = (
    // audio
    miAudio_Testbed,
    miAudio_Positional,

    // graphics
      miGraphics_BitmapTiled,
      miGraphics_BitmapFlipped,
      miGraphics_BitmapAllocate,
      miGraphics_BitmapGetPixel,
      miGraphics_BitmapSetPixel,
      miGraphics_BitmapPNGTrans,
      miGraphics_BitmapColorKeyTrans,
      miGraphics_BitmapAlignment,

    // input

    // system

    // ui

    // demos
    miDemo_Elastic,
    miDemo_AstroBlaster
    );
var
  LTreeMenu: TTreeMenu;
  LAudio: Integer;
  LGraphics: Integer;
  LGraphics_Bitmap: Integer;
  LInput: Integer;
  LSystem: Integer;
  LUI: Integer;
  LDemos: Integer;
  LNetwork: Integer;
  LSelItem: Integer;
begin
  LTreeMenu := TTreeMenu.Create;
  LTreeMenu.SetTitle(cAppTitle);
  LTreeMenu.SetStatus('Select an item to test');
  try
    // audio
    LAudio := LTreeMenu.AddItem(0, 'Audio', TREEMENU_NONE, True);
      LTreeMenu.AddItem(LAudio, 'Testbed', Ord(miAudio_Testbed), True);
      LTreeMenu.AddItem(LAudio, 'Positional', Ord(miAudio_Positional), True);
    LTreeMenu.Sort(LAudio);

    // graphics
    LGraphics := LTreeMenu.AddItem(0, 'Graphics', TREEMENU_NONE, True);
      LGraphics_Bitmap := LTreeMenu.AddItem(LGraphics, 'Bitmap', TREEMENU_NONE, True);
        LTreeMenu.AddItem(LGraphics_Bitmap, 'Tiled', Ord(miGraphics_BitmapTiled), True);
        LTreeMenu.AddItem(LGraphics_Bitmap, 'Flipped', Ord(miGraphics_BitmapFlipped), True);
        LTreeMenu.AddItem(LGraphics_Bitmap, 'Allocate', Ord(miGraphics_BitmapAllocate), True);
        LTreeMenu.AddItem(LGraphics_Bitmap, 'Getpixel', Ord(miGraphics_BitmapGetPixel), True);
        LTreeMenu.AddItem(LGraphics_Bitmap, 'Setpixel', Ord(miGraphics_BitmapSetPixel), True);
        LTreeMenu.AddItem(LGraphics_Bitmap, 'Transparancey: PNG', Ord(miGraphics_BitmapPNGTrans), True);
        LTreeMenu.AddItem(LGraphics_Bitmap, 'Transparancy: ColorKey', Ord(miGraphics_BitmapColorKeyTrans), True);
        LTreeMenu.AddItem(LGraphics_Bitmap, 'Alignment', Ord(miGraphics_BitmapAlignment), True);
      LTreeMenu.Sort(LGraphics_Bitmap);
    LTreeMenu.Sort(LGraphics);

    // input
    LInput := LTreeMenu.AddItem(0, 'Input', TREEMENU_NONE, True);
    LTreeMenu.Sort(LInput);

    // system
    LSystem := LTreeMenu.AddItem(0, 'System', TREEMENU_NONE, True);
    LTreeMenu.Sort(LSystem);

    // ui
    LUI := LTreeMenu.AddItem(0, 'UI', TREEMENU_NONE, True);
    LTreeMenu.Sort(LUI);

    // network
    LNetwork := LTreeMenu.AddItem(0, 'Network', TREEMENU_NONE, True);
    LTreeMenu.Sort(LNetwork);

    // sort list
    LTreeMenu.Sort(0);

    // demos
    LDemos := LTreeMenu.AddItem(0, 'Demos', TREEMENU_NONE, True);
      LTreeMenu.AddItem(LDemos, 'Elastic', Ord(miDemo_Elastic), True);
      LTreeMenu.AddItem(LDemos, 'AstroBlaster', Ord(miDemo_AstroBlaster), True);
    LTreeMenu.Sort(LDemos);

    LSelItem := ConfigFile.GetValue('TreeMenu', 'SelItem', TREEMENU_NONE);
    repeat
      LSelItem := LTreeMenu.Show(LSelItem);
      case TMenuItems(LSelItem) of
        // audio
        miAudio_Testbed                : Engine.RunGame(TAudioTestbed);
        miAudio_Positional             : Engine.RunGame(TAudioPositional);

        // bitmap
        miGraphics_BitmapTiled         : Engine.RunGame(TBitmapTiled);
        miGraphics_BitmapFlipped       : Engine.RunGame(TBitmapFlipped);
        miGraphics_BitmapAllocate      : Engine.RunGame(TBitmapAllocate);
        miGraphics_BitmapGetPixel      : Engine.RunGame(TBitmapGetPixel);
        miGraphics_BitmapSetPixel      : Engine.RunGame(TBitmapSetPixel);
        miGraphics_BitmapPNGTrans      : Engine.RunGame(TBitmapPNGTrans);
        miGraphics_BitmapColorKeyTrans : Engine.RunGame(TBitmapColorKeyTrans);
        miGraphics_BitmapAlignment     : Engine.RunGame(TBitmapAlignment);

        // demos
        miDemo_Elastic                 : Engine.RunGame(TElastic);
        miDemo_AstroBlaster            : Engine.RunGame(TAstroBlasterDemo);
      end;
    until LSelItem = TREEMENU_QUIT;
    ConfigFile.SetValue('TreeMenu', 'SelItem', LTreeMenu.GetLastSelectedId);

  finally
    FreeAndNil(LTreeMenu);
  end;

  Result := False;
end;


end.