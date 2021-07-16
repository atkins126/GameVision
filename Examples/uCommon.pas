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

unit uCommon;

interface

uses
  System.SysUtils,
  GameVision.Common,
  GameVision.Audio,
  GameVision.Graphics,
  GameVision.Input,
  GameVision.System,
  GameVision.UI,
  GameVision.Game;

const
  cAppTitle = 'GameVision: Examples';
  cExampleTitle = 'GameVision: ';

  cArchiveFilename = 'Data.arc';

type

  { TCustomExample }
  TCustomExample = class(TCustomGameApp)
  protected
    FLogo: TBitmap;
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnRenderHUD; override;
    procedure OnDisplayShow; override;
    procedure OnUpdate(aDeltaTime: Double); override;
  end;

implementation

{ TCustomExample }
procedure TCustomExample.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.ConfigFilename := 'examples.cfg';
  aConfig.ArchiveFilename := '';
  aConfig.DisplayTitle := 'TCustomExample';
end;

procedure TCustomExample.OnStartup;
begin
  inherited;

  FLogo := TBitmap.LoadBitmap('arc/bitmaps/sprites/icon.png', nil);
end;

procedure TCustomExample.OnShutdown;
begin
  FreeAndNil(FLogo);
  inherited;
end;

procedure TCustomExample.OnRenderHUD;
begin
  inherited;

  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, DARKGREEN, haLeft, 'ESC       - Quit', []);
  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, DARKGREEN, haLeft, 'F10       - Fullscreen toggle', []);
  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, DARKGREEN, haLeft, 'F11       - Screenshot', []);

  var LLogoPos: TVector;
  FLogo.GetSize(LLogoPos);
  LLogoPos.Scale(0.3);
  LLogoPos.X := Config.DisplayWidth - (LLogoPos.X + 3);
  LLogoPos.Y := Config.DisplayHeight - (LLogoPos.Y + 3);

  FLogo.Draw(LLogoPos.X, LLogoPos.Y, 0.3, 0, WHITE, haLeft, vaTop);
end;

procedure TCustomExample.OnDisplayShow;
begin
  inherited;

end;

procedure TCustomExample.OnUpdate(aDeltaTime: Double);
begin
  inherited;

  if Input.KeyboardPressed(KEY_ESCAPE) then
    Engine.SetTerminate(True);

  if Input.KeyboardPressed(KEY_F10) then
    Display.ToggleFullscreen;

  if Input.KeyboardPressed(KEY_F11) then
    Screenshot.Take;

end;

end.
