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

unit uScroll;

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

const
  // player
  PLAYER_TURNRATE            = 162;
  PLAYER_FRICTION            = 1;
  PLAYER_ACCEL               = 7;
  PLAYER_MAGNITUDE           = 14;
  PLAYER_SIZE_HALF           = 32.0;
  PLAYER_FRAME_FPS           = 12;
  PLAYER_FRAME_NEUTRAL       = 0;
  PLAYER_FRAME_FIRST         = 1;
  PLAYER_FRAME_LAST          = 3;
  PLAYER_TURN_ACCEL          = 300;
  PLAYER_TURN_MAX            = 150;
  PLAYER_TURN_DRAG           = 150;


type
  { TView }
  TView = record
    Move     : Single;
    Bounce   : Single;
    Dir      : TVector;
    FixOffset: TVector;
    RunAhead : TVector;
    Pos      : TVector;
  end;

  { TPlayer }
  TPlayer = record
    Timer    : Single;
    Frame    : Integer;
    Thrusting: Boolean;
    Angle    : Single;
    Dir      : TVector;
    WorldPos : TVector;
    ScreenPos: TVector;
    TurnSpeed: Single;
  end;

  { TScrollDemo }
  TScroll = class(TCustomExample)
  protected
    FTimer      : Single;
    FColor      : TColor;
    FBackground : array[0..3] of TBitmap;
    FPlanet     : TBitmap;
    FView       : TView;
    FPlayer     : TPlayer;
    FMusic      : Integer;
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnLoad; override;
    procedure OnExit; override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
  end;

implementation

{ TScrollDemo }
procedure TScroll.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Scroll Demo';
  aConfig.DisplayClearColor := BLACK;
end;

procedure TScroll.OnLoad;
begin
  inherited;

end;

procedure TScroll.OnExit;
begin
  inherited;

end;

procedure TScroll.OnStartup;
begin
  inherited;

  // init colors
  FColor := WHITE;
  FColor.Alpha := 128;

  // init textures
  FBackground[0] := TBitmap.LoadBitmap('arc/bitmaps/backgrounds/space.png',  @BLACK);
  FBackground[1] := TBitmap.LoadBitmap('arc/bitmaps/backgrounds/nebula.png', @BLACK);
  FBackground[2] := TBitmap.LoadBitmap('arc/bitmaps/backgrounds/spacelayer1.png', @BLACK);
  FBackground[3] := TBitmap.LoadBitmap('arc/bitmaps/backgrounds/spacelayer2.png', @BLACK);

  FPlanet := TBitmap.LoadBitmap('arc/bitmaps/backgrounds/planet.png', nil);

  // init spirtes
  Sprite.LoadPage('arc/bitmaps/sprites/ship.png', nil);
  Sprite.AddGroup;
  Sprite.AddImageFromGrid(0, 0, 0, 0, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 1, 0, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 2, 0, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 3, 0, 64, 64);

  FillChar(FView, SizeOf(FView), 0);
  FillChar(FPlayer, SizeOf(FPlayer), 0);

  FView.Move := 0.004;
  FView.Bounce := 1.10;
  FView.RunAhead.X := 45;
  FView.RunAhead.Y := 35;
  FView.Pos.X := 1000;
  FView.Pos.Y := 1000;
  FPlayer.Angle      := 0;
  FPlayer.WorldPos.X := Config.DisplayWidth  / 2;
  FPlayer.WorldPos.Y := Config.DisplayHeight / 2;

  FMusic := Audio.LoadMusic('arc/audio/music/song05.ogg');
  Audio.PlayMusic(FMusic, 0.5, True);
end;

procedure TScroll.OnShutdown;
begin
  Audio.UnloadMusic(FMusic);
  FreeAndNil(FPlanet);
  FreeAndNil(FBackground[3]);
  FreeAndNil(FBackground[2]);
  FreeAndNil(FBackground[1]);
  FreeAndNil(FBackground[0]);

  inherited;
end;

procedure TScroll.OnUpdate(aDeltaTime: Double);
begin
  inherited;

  // update keys
  if Input.KeyboardDown(KEY_RIGHT) then
  begin
    Math.SmoothMove(FPlayer.TurnSpeed, PLAYER_TURN_ACCEL*aDeltaTime, PLAYER_TURN_MAX, PLAYER_TURN_DRAG*aDeltaTime);
  end
  else if Input.KeyboardDown(KEY_LEFT) then
    begin
      Math.SmoothMove(FPlayer.TurnSpeed, -PLAYER_TURN_ACCEL*aDeltaTime, PLAYER_TURN_MAX, PLAYER_TURN_DRAG*aDeltaTime);
    end
  else
    begin
      Math.SmoothMove(FPlayer.TurnSpeed, 0, PLAYER_TURN_MAX, PLAYER_TURN_DRAG*aDeltaTime);
    end;

  FPlayer.Angle := FPlayer.Angle + (FPlayer.TurnSpeed*aDeltaTime);
  if FPlayer.Angle > 360 then
    FPlayer.Angle := FPlayer.Angle - 360
  else if FPlayer.Angle < 0 then
    FPlayer.Angle := FPlayer.Angle + 360;

  FPlayer.Thrusting := False;
  if (Input.KeyboardDown(KEY_UP)) then
  begin
    FPlayer.Thrusting := True;

    //if (Vector_Magnitude(FPlayer.Dir) < PLAYER_MAGNITUDE) then
    if (FPlayer.Dir.Magnitude < PLAYER_MAGNITUDE) then
    begin
      //Vector_Thrust(FPlayer.Dir, FPlayer.Angle, PLAYER_ACCEL*aDeltaTime);
      FPlayer.Dir.Thrust(FPlayer.Angle, PLAYER_ACCEL*aDeltaTime);
    end;
  end;

  Math.SmoothMove(FPlayer.Dir.X, 0, PLAYER_MAGNITUDE, PLAYER_FRICTION*aDeltaTime);
  Math.SmoothMove(FPlayer.Dir.Y, 0, PLAYER_MAGNITUDE, PLAYER_FRICTION*aDeltaTime);

  FPlayer.WorldPos.X := FPlayer.WorldPos.X + FPlayer.Dir.X;
  FPlayer.WorldPos.Y := FPlayer.WorldPos.Y + FPlayer.Dir.Y;

  if (FPlayer.Thrusting) then
    begin
      if (Engine.FrameSpeed(FPlayer.Timer, PLAYER_FRAME_FPS)) then
      begin
        FPlayer.Frame := FPlayer.Frame + 1;
        if (FPlayer.Frame > PLAYER_FRAME_LAST) then
        begin
          FPlayer.Frame := PLAYER_FRAME_FIRST;
        end
      end
    end
  else
    begin
      FPlayer.Timer := 0;
      FPlayer.Frame := PLAYER_FRAME_NEUTRAL;
    end;

  // update world
  FView.Dir.X := (FView.Dir.X+(FPlayer.WorldPos.X - FView.Fixoffset.X - FView.Pos.X + FView.RunAhead.X * FPlayer.Dir.X) * FView.Move) / FView.Bounce;
  FView.Dir.Y := (FView.Dir.Y+(FPlayer.WorldPos.Y - FView.Fixoffset.y - FView.Pos.Y + FView.RunAhead.Y * FPlayer.Dir.Y) * FView.Move) / FView.Bounce;
  FView.Pos.X := FView.Pos.X + FView.Dir.X;
  FView.Pos.Y := FView.Pos.Y + FView.Dir.Y;

  // update FPlayer
  FPlayer.ScreenPos.X := FPlayer.WorldPos.X - FView.Pos.X + Config.DisplayWidth  /2;
  FPlayer.ScreenPos.Y := FPlayer.WorldPos.Y - FView.Pos.Y + Config.DisplayHeight /2;
end;

procedure TScroll.OnRender;
var
  LOrigin: TVector;
begin
  // render FBackground
  FBackground[0].DrawTiled(-(FView.Pos.X/1.9), -(FView.Pos.Y/1.9));
  //GV_SetDisplayBlender(BLEND_ADD, BLEND_ALPHA, BLEND_INVERSE_ALPHA);
  Display.SetBlendMode(bmAdditiveAlpha);
  FBackground[1].DrawTiled(-(FView.Pos.X/1.9), -(FView.Pos.Y/1.9));
  Display.RestoreDefaultBlendMode;
  FBackground[2].DrawTiled(-(FView.Pos.X/1.6), -(FView.Pos.Y/1.6));
  FBackground[3].DrawTiled(-(FView.Pos.X/1.3), -(FView.Pos.Y/1.3));

  FPlanet.Draw(
    -Round(FView.Pos.X/1.0)+(Config.DisplayWidth),
    -Round(FView.Pos.Y/1.0)+(Config.DisplayHeight),
    1.0, 0.0, WHITE, haCenter, vaCenter);

  // render FPlayer
  LOrigin.X := 0.50;
  LOrigin.Y := 0.50;
  Sprite.DrawImage(FPlayer.Frame, 0, FPlayer.ScreenPos.X, FPlayer.ScreenPos.Y, @LOrigin, nil, FPlayer.Angle, WHITE, False, False, False);

  inherited;
end;

procedure TScroll.OnRenderHUD;
begin
  inherited;

  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, GREEN,  haLeft, 'F11       - Fullscreen toggle', []);
  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, GREEN,  haLeft, 'F12       - Screenshot', []);
  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, GREEN,  haLeft, 'Left      - Rotate left', []);
  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, GREEN,  haLeft, 'Right     - Rotate right', []);
  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, GREEN,  haLeft, 'Up        - Thrust', []);
  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, YELLOW, haLeft, 'Pos:        [X:%7.0f Y:%7.0f]', [FPlayer.WorldPos.X, FPlayer.WorldPos.Y]);
end;


end.
