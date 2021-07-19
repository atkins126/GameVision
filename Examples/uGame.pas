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

unit uGame;

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

  { TMyActor }
  TMyActor = class(TActor)
  protected
    FPos: TVector;
    FRange: TRange;
    FSpeed: TVector;
    FColor: TColor;
    FSize: Integer;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnRender; override;
  end;

  { TGameActorBasic }
  TGameActorBasic = class(TCustomExample)
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnStartup; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
    procedure Spawn;
  end;

implementation

var
  Game: TGameActorBasic = nil;


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


{ TMyActor }
constructor TMyActor.Create;
var
  LR,LG,LB: Byte;
begin
  inherited;

  FPos.Assign( Math.RandomRange(0, Game.Config.DisplayWidth-1), Math.RandomRange(0, Game.Config.DisplayHeight-1));

  FRange.MinX := 0;
  FRange.MinY := 0;

  FSize := Math.RandomRange(25, 100);

  FRange.MaxX := (Game.Config.DisplayWidth-1) - FSize;
  FRange.MaxY := (Game.Config.DisplayHeight-1) - FSize;

  FSpeed.x := Math.RandomRange(120, 120*3);
  FSpeed.y := Math.RandomRange(120, 120*3);

  LR := Math.RandomRange(1, 255);
  LG := Math.RandomRange(1, 255);
  LB := Math.RandomRange(1, 255);
  FColor.Make(LR,LG,LB,255);
end;

destructor TMyActor.Destroy;
begin

  inherited;
end;

procedure TMyActor.OnUpdate(aDeltaTime: Double);
begin
  // update horizontal movement
  FPos.x := FPos.x + (FSpeed.x * aDeltaTime);
  if (FPos.x < FRange.MinX) then
    begin
      FPos.x  := FRange.Minx;
      FSpeed.x := -FSpeed.x;
    end
  else if (FPos.x > FRange.Maxx) then
    begin
      FPos.x  := FRange.Maxx;
      FSpeed.x := -FSpeed.x;
    end;

  // update horizontal movement
  FPos.y := FPos.y + (FSpeed.y * aDeltaTime);
  if (FPos.y < FRange.Miny) then
    begin
      FPos.y  := FRange.Miny;
      FSpeed.y := -FSpeed.y;
    end
  else if (FPos.y > FRange.Maxy) then
    begin
      FPos.y  := FRange.Maxy;
      FSpeed.y := -FSpeed.y;
    end;
end;

procedure TMyActor.OnRender;
begin
  Display.DrawFilledRectangle(FPos.X, FPos.Y, FSize, FSize, FColor);
end;


{ TActorBasic }
constructor TGameActorBasic.Create;
begin
  inherited;

  Game := Self;
end;

destructor TGameActorBasic.Destroy;
begin
  Game := nil;

  inherited;
end;

procedure TGameActorBasic.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Basic Actor';
end;

procedure TGameActorBasic.OnStartup;
begin
  inherited;

  Spawn;
end;

procedure TGameActorBasic.OnUpdate(aDeltaTime: Double);
begin
  inherited;

  if Input.KeyboardPressed(KEY_S) then Spawn;
end;

procedure TGameActorBasic.OnRender;
begin
  inherited;

end;

procedure TGameActorBasic.OnRenderHUD;
begin
  inherited;

  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, GREEN, haLeft, 'S         - Spawn actors', []);
  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, YELLOW, haLeft, 'Count       %d', [Scene.Lists[0].Count]);
end;

procedure TGameActorBasic.Spawn;
var
  LI, LCount: Integer;
begin
  Scene.ClearAll;
  LCount := Math.RandomRange(3, 25);
  for LI := 1 to LCount do
    Scene.Lists[0].Add(TMyActor.Create);
end;


end.
