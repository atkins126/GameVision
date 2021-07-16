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

unit uGraphics;

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
  uCommon;

type

  { TTemplate }
  TTemplate = class(TCustomExample)
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnLoad; override;
    procedure OnExit; override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
    procedure OnUpdate(aDeltaTime: Double); override;
  end;

  { TBitmapTiled }
  TBitmapTiled = class(TCustomExample)
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnLoad; override;
    procedure OnExit; override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
    procedure OnUpdate(aDeltaTime: Double); override;
  end;

  { TBitmapFlipped }
  TBitmapFlipped = class(TCustomExample)
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnLoad; override;
    procedure OnExit; override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
    procedure OnUpdate(aDeltaTime: Double); override;
  end;

  { TBitmapAllocate }
  TBitmapAllocate = class(TCustomExample)
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnLoad; override;
    procedure OnExit; override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
    procedure OnUpdate(aDeltaTime: Double); override;
  end;

  { TBitmapGetPixel }
  TBitmapGetPixel = class(TCustomExample)
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnLoad; override;
    procedure OnExit; override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
    procedure OnUpdate(aDeltaTime: Double); override;
  end;

  { TBitmapSetPixel }
  TBitmapSetPixel = class(TCustomExample)
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnLoad; override;
    procedure OnExit; override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
    procedure OnUpdate(aDeltaTime: Double); override;
  end;

  { TBitmapTrueTrans }
  TBitmapPNGTrans = class(TCustomExample)
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnLoad; override;
    procedure OnExit; override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
    procedure OnUpdate(aDeltaTime: Double); override;
  end;

  { TBitmapColorKeyTrans }
  TBitmapColorKeyTrans = class(TCustomExample)
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnLoad; override;
    procedure OnExit; override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
    procedure OnUpdate(aDeltaTime: Double); override;
  end;

  { TBitmapAlignment }
  TBitmapAlignment = class(TCustomExample)
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnLoad; override;
    procedure OnExit; override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
    procedure OnUpdate(aDeltaTime: Double); override;
  end;



implementation

{ TTemplate }
procedure TTemplate.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Example Template';
end;

procedure TTemplate.OnLoad;
begin
  inherited;

end;

procedure TTemplate.OnExit;
begin
  inherited;

end;

procedure TTemplate.OnStartup;
begin
  inherited;

end;

procedure TTemplate.OnShutdown;
begin
  inherited;

end;

procedure TTemplate.OnRender;
begin
  inherited;

end;

procedure TTemplate.OnRenderHUD;
begin
  inherited;

end;

procedure TTemplate.OnUpdate(aDeltaTime: Double);
begin
  inherited;

end;


{ TBitmapExample }
procedure TBitmapPNGTrans.OnExit;
begin
  inherited;

end;

procedure TBitmapPNGTrans.OnLoad;
begin
  inherited;

end;

procedure TBitmapPNGTrans.OnRender;
begin
  inherited;

end;

procedure TBitmapPNGTrans.OnRenderHUD;
begin
  inherited;

end;

procedure TBitmapPNGTrans.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Bitmap PNG Transparancy';
end;

procedure TBitmapPNGTrans.OnShutdown;
begin
  inherited;

end;

procedure TBitmapPNGTrans.OnStartup;
begin
  inherited;

end;

procedure TBitmapPNGTrans.OnUpdate(aDeltaTime: Double);
begin
  inherited;

end;

{ TBitmapColorKeyTrans }
procedure TBitmapColorKeyTrans.OnExit;
begin
  inherited;

end;

procedure TBitmapColorKeyTrans.OnLoad;
begin
  inherited;

end;

procedure TBitmapColorKeyTrans.OnRender;
begin
  inherited;

end;

procedure TBitmapColorKeyTrans.OnRenderHUD;
begin
  inherited;

end;

procedure TBitmapColorKeyTrans.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Bitmap ColorKey Transparancy';

end;

procedure TBitmapColorKeyTrans.OnShutdown;
begin
  inherited;

end;

procedure TBitmapColorKeyTrans.OnStartup;
begin
  inherited;

end;

procedure TBitmapColorKeyTrans.OnUpdate(aDeltaTime: Double);
begin
  inherited;

end;

{ TBitmapAlignment }
procedure TBitmapAlignment.OnExit;
begin
  inherited;

end;

procedure TBitmapAlignment.OnLoad;
begin
  inherited;

end;

procedure TBitmapAlignment.OnRender;
begin
  inherited;

end;

procedure TBitmapAlignment.OnRenderHUD;
begin
  inherited;

end;

procedure TBitmapAlignment.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Bitmap Alignment';

end;

procedure TBitmapAlignment.OnShutdown;
begin
  inherited;

end;

procedure TBitmapAlignment.OnStartup;
begin
  inherited;

end;

procedure TBitmapAlignment.OnUpdate(aDeltaTime: Double);
begin
  inherited;

end;

{ TBitmapAllocate }
procedure TBitmapAllocate.OnExit;
begin
  inherited;

end;

procedure TBitmapAllocate.OnLoad;
begin
  inherited;

end;

procedure TBitmapAllocate.OnRender;
begin
  inherited;

end;

procedure TBitmapAllocate.OnRenderHUD;
begin
  inherited;

end;

procedure TBitmapAllocate.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Bitmap Allocate';

end;

procedure TBitmapAllocate.OnShutdown;
begin
  inherited;

end;

procedure TBitmapAllocate.OnStartup;
begin
  inherited;

end;

procedure TBitmapAllocate.OnUpdate(aDeltaTime: Double);
begin
  inherited;

end;

{ TBitmapGetPixel }
procedure TBitmapGetPixel.OnExit;
begin
  inherited;

end;

procedure TBitmapGetPixel.OnLoad;
begin
  inherited;

end;

procedure TBitmapGetPixel.OnRender;
begin
  inherited;

end;

procedure TBitmapGetPixel.OnRenderHUD;
begin
  inherited;

end;

procedure TBitmapGetPixel.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Bitmap GetPixel';

end;

procedure TBitmapGetPixel.OnShutdown;
begin
  inherited;

end;

procedure TBitmapGetPixel.OnStartup;
begin
  inherited;

end;

procedure TBitmapGetPixel.OnUpdate(aDeltaTime: Double);
begin
  inherited;

end;

{ TBitmapSetPixel }
procedure TBitmapSetPixel.OnExit;
begin
  inherited;

end;

procedure TBitmapSetPixel.OnLoad;
begin
  inherited;

end;

procedure TBitmapSetPixel.OnRender;
begin
  inherited;

end;

procedure TBitmapSetPixel.OnRenderHUD;
begin
  inherited;

end;

procedure TBitmapSetPixel.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Bitmap SetPixel';

end;

procedure TBitmapSetPixel.OnShutdown;
begin
  inherited;

end;

procedure TBitmapSetPixel.OnStartup;
begin
  inherited;

end;

procedure TBitmapSetPixel.OnUpdate(aDeltaTime: Double);
begin
  inherited;

end;

{ TBitmapFlipped }
procedure TBitmapFlipped.OnExit;
begin
  inherited;

end;

procedure TBitmapFlipped.OnLoad;
begin
  inherited;

end;

procedure TBitmapFlipped.OnRender;
begin
  inherited;

end;

procedure TBitmapFlipped.OnRenderHUD;
begin
  inherited;

end;

procedure TBitmapFlipped.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Bitmap Flipped';
end;

procedure TBitmapFlipped.OnShutdown;
begin
  inherited;

end;

procedure TBitmapFlipped.OnStartup;
begin
  inherited;

end;

procedure TBitmapFlipped.OnUpdate(aDeltaTime: Double);
begin
  inherited;

end;

{ TBitmapTiled }
procedure TBitmapTiled.OnExit;
begin
  inherited;

end;

procedure TBitmapTiled.OnLoad;
begin
  inherited;

end;

procedure TBitmapTiled.OnRender;
begin
  inherited;

end;

procedure TBitmapTiled.OnRenderHUD;
begin
  inherited;

end;

procedure TBitmapTiled.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Bitmap Tiled';

end;

procedure TBitmapTiled.OnShutdown;
begin
  inherited;

end;

procedure TBitmapTiled.OnStartup;
begin
  inherited;

end;

procedure TBitmapTiled.OnUpdate(aDeltaTime: Double);
begin
  inherited;

end;

end.
