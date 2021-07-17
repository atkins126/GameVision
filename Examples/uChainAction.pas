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

unit uChainAction;

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
  // scene
  SCN_COUNT  = 2;
  SCN_CIRCLE = 0;
  SCN_EXPLO  = 1;

  // circle
  SHRINK_FACTOR = 0.65;

  CIRCLE_SCALE = 0.125;
  CIRCLE_SCALE_SPEED   = 0.95;

  CIRCLE_EXP_SCALE_MIN = 0.05;
  CIRCLE_EXP_SCALE_MAX = 0.49;

  CIRCLE_MIN_COLOR = 64;
  CIRCLE_MAX_COLOR = 255;

  CIRCLE_COUNT = 80;

type
  { TCommonEntity }
  TCommonEntity = class(TEntityActor)
  public
    constructor Create; override;
    procedure OnCollide(aActor: TActor; aHitPos: TVector); override;
    function  Collide(aActor: TActor; var aHitPos: TVector): Boolean; override;
  end;

  { TCircle }
  TCircle = class(TCommonEntity)
  protected
    FColor: TColor;
    FSpeed: Single;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnRender; override;
    procedure OnCollide(aActor: TActor; aHitPos: TVector); override;
    property Speed: Single read FSpeed;
  end;

  { TCircleExplosion }
  TCircleExplosion = class(TCommonEntity)
  protected
    FColor: array[0..1] of TColor;
    FState: Integer;
    FFade: Single;
    FSpeed: Single;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Setup(aX, aY: Single; aColor: TColor); overload;
    procedure Setup(aCircle: TCircle); overload;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnRender; override;
    procedure OnCollide(aActor: TActor; aHitPos: TVector); override;
  end;

  { TChainAction }
  TChainAction = class(TCustomExample)
  protected
    FExplosions: Integer;
    FChainActive: Boolean;
    FMusic: Integer;
    FStarfield: TStarfield;
  public
    property Explosions: Integer read FExplosions write FExplosions;
    constructor Create; override;
    destructor Destroy; override;
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnLoad; override;
    procedure OnExit; override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
    procedure OnBeforeRenderScene(aSceneNum: Integer); override;
    procedure OnAfterRenderScene(aSceneNum: Integer); override;
    procedure SpawnCircle(aNum: Integer); overload;
    procedure SpawnCircle; overload;
    procedure SpawnExplosion(aX, aY: Single; aColor: TColor); overload;
    procedure SpawnExplosion(aCircle: TCircle); overload;
    procedure CheckCollision(aEntity: TEntityActor);
    procedure StartChain;
    procedure PlayLevel;
    function  ChainEnded: Boolean;
    function  LevelClear: Boolean;
  end;

var
  Game: TChainAction = nil;

implementation

{ TCommonEntity }
constructor TCommonEntity.Create;
begin
  inherited;

  CanCollide := True;
end;

procedure TCommonEntity.OnCollide(aActor: TActor; aHitPos: TVector);
begin
  inherited;

end;

function  TCommonEntity.Collide(aActor: TActor; var aHitPos: TVector): Boolean;
begin
  Result := False;

  if Overlap(aActor) then
  begin
    aHitPos := Entity.GetPos;
    Result := True;
  end;
end;


{ TCircle }
constructor TCircle.Create;
var
  LOK: Boolean;
  LVP: TRectangle;
  LA: Single;
begin
  inherited;

  Display.GetViewportSize(LVP);

  Init(Game.Sprite, 0);
  Entity.SetShrinkFactor(SHRINK_FACTOR);
  Entity.SetScaleAbs(CIRCLE_SCALE);
  Entity.SetPosAbs(Math.RandomRange(32, (LVP.Width-1)-32), Math.RandomRange(32, (LVP.Width-1)-32));

  LOK := False;
  repeat
    Sleep(1);
    FColor.Make(
      Math.RandomRange(CIRCLE_MIN_COLOR, CIRCLE_MAX_COLOR),
      Math.RandomRange(CIRCLE_MIN_COLOR, CIRCLE_MAX_COLOR),
      Math.RandomRange(CIRCLE_MIN_COLOR, CIRCLE_MAX_COLOR),
      Math.RandomRange(CIRCLE_MIN_COLOR, CIRCLE_MAX_COLOR)
    );

    if FColor.Equal(BLACK) or
       FColor.Equal(WHITE) then
      continue;

    LOK := True;
  until LOK;

  LOK := False;
  repeat
    Sleep(1);
    LA := Math.RandomRange(0, 359);
    if (Abs(LA) >=90-10) and (Abs(LA) <= 90+10) then continue;
    if (Abs(LA) >=270-10) and (Abs(LA) <= 270+10) then continue;

    LOK := True;
  until LOK;

  Entity.RotateAbs(LA);
  Entity.SetColor(FColor);
  FSpeed := Math.RandomRange(3*35, 7*35);
end;

destructor TCircle.Destroy;
begin

  inherited;
end;

procedure TCircle.OnUpdate(aDeltaTime: Double);
var
  LV: TVector;
  LVP: TRectangle;
  LR: Single;
begin
  Display.GetViewportSize(LVP);

  Entity.Thrust(FSpeed * aDeltaTime);

  LV := Entity.GetPos;

  LR := Entity.GetRadius / 2;

  if LV.x < -LR then
    LV.x := LVP.Width-1
  else if LV.x > (LVP.Width-1)+LR then
    LV.x := -LR;

  if LV.y < -LR then
    LV.y := (LVP.Height-1)
  else if LV.y > (LVP.Height-1)+LR then
    LV.y := -LR;

  Entity.SetPosAbs(LV.X, LV.Y);
end;

procedure TCircle.OnRender;
begin
  inherited;

end;

procedure TCircle.OnCollide(aActor: TActor; aHitPos: TVector);
var
  LPos: TVector;
begin
  Terminated := True;
  LPos := Entity.GetPos;

  Game.SpawnExplosion(LPos.X, LPos.Y, FColor);
  Game.Explosions := Game.Explosions + 1;
end;


{ TCircleExplosion }
constructor TCircleExplosion.Create;
begin
  inherited;

  Init(Game.Sprite, 0);

  Entity.SetShrinkFactor(SHRINK_FACTOR);
  Entity.SetScaleAbs(CIRCLE_SCALE);

  FState := 0;
  FFade := 0;
  FSpeed := 0;
end;

destructor TCircleExplosion.Destroy;
begin

  inherited;
end;

procedure TCircleExplosion.Setup(aX, aY: Single; aColor: TColor);
begin
  FColor[0] := aColor;
  FColor[1] := aColor;
  Entity.SetPosAbs(aX, aY);
end;

procedure TCircleExplosion.Setup(aCircle: TCircle);
var
  LPos: TVector;
begin
  LPos := aCircle.Entity.GetPos;
  Setup(LPos.X, LPos.Y, aCircle.Entity.GetColor);
  Entity.RotateAbs(aCircle.Entity.GetAngle);
  FSpeed := aCircle.Speed;
end;

procedure TCircleExplosion.OnUpdate(aDeltaTime: Double);
begin
  Entity.Thrust(FSpeed*aDeltaTime);

  case FState of
    0: // expand
    begin
      Entity.SetScaleRel(CIRCLE_SCALE_SPEED*aDeltaTime);
      if Entity.GetScale > CIRCLE_EXP_SCALE_MAX then
      begin
        FState := 1;
      end;
      Entity.SetColor(FColor[0]);
    end;

    1: // contract
    begin
      Entity.SetScaleRel(-CIRCLE_SCALE_SPEED*aDeltaTime);
      FFade := CIRCLE_SCALE_SPEED*aDeltaTime / Entity.GetScale;
      if Entity.GetScale < CIRCLE_EXP_SCALE_MIN then
      begin
        FState := 2;
        FFade := 1.0;
        Terminated := True;
      end;
      //C := Engine.Color.Fade(FColor[0], FColor[1], FFade);
      //Entity.SetColor(C);
    end;

    2: // kill
    begin
      Terminated := True;
    end;

  end;

  Game.CheckCollision(Self);
end;

procedure TCircleExplosion.OnRender;
begin
  inherited;

end;

procedure TCircleExplosion.OnCollide(aActor: TActor; aHitPos: TVector);
begin
end;


{ TChainAction }
constructor TChainAction.Create;
begin
  inherited;

  Game := Self;
end;

destructor TChainAction.Destroy;
begin
  Game := nil;

  inherited;
end;

procedure TChainAction.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'ChainAction Demo';
  aConfig.DisplayClearColor := BLACK;
  aConfig.SceneCount := SCN_COUNT;
end;

procedure TChainAction.OnLoad;
begin
  inherited;

end;

procedure TChainAction.OnExit;
begin
  inherited;

end;

procedure TChainAction.OnStartup;
var
  LPage: Integer;
  LGroup: Integer;
begin
  inherited;

  // init circle sprite
  LPage := Sprite.LoadPage('arc/bitmaps/sprites/light.png', @COLORKEY);
  LGroup := Sprite.AddGroup;
  Sprite.AddImageFromGrid(LPage, LGroup, 0, 0, 256, 256);

  // init music
  FMusic := Audio.LoadMusic('arc/audio/music/song06.ogg');
  Audio.PlayMusic(FMusic, 1.0, True);

  // init starfield
  FStarfield := TStarfield.Create;

  PlayLevel;
end;

procedure TChainAction.OnShutdown;
begin
  FreeAndNil(FStarfield);
  Audio.UnloadMusic(FMusic);

  inherited;
end;

procedure TChainAction.OnUpdate(aDeltaTime: Double);
begin

  // start  new level
  if Input.KeyboardPressed(KEY_SPACE) then
  begin
    if LevelClear then
      PlayLevel;
  end;

  // start chain reaction
  if Input.MousePressed(MOUSE_BUTTON_LEFT) then
  begin
    if ChainEnded then
      StartChain;
  end;

  FStarfield.Update(aDeltaTime);

  inherited;
end;

procedure TChainAction.OnRender;
begin
  FStarfield.Render;

  inherited;
end;

procedure TChainAction.OnRenderHUD;
var
  LVP: TRectangle;
  LX: Single;
  LC: TColor;
begin
  inherited;

  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, YELLOW, haLeft, 'Circles:    %d', [Scene[SCN_CIRCLE].Count]);

  Display.GetViewportSize(LVP);
  LX := LVP.Width / 2;

  if ChainEnded and (not LevelClear) then
    LC := WHITE
  else
    LC := DIMWHITE;

  Font.Print(LX, 120, LC, haCenter, 'Click mouse to start chain reaction', []);

  if LevelClear then
  begin
    Font.Print(LX, 120+21, ORANGE, haCenter, 'Press SPACE to start new level', []);
  end;
end;

procedure TChainAction.OnBeforeRenderScene(aSceneNum: Integer);
begin
  case aSceneNum of
    SCN_CIRCLE, SCN_EXPLO:
    begin
      Display.SetBlendMode(bmAdditiveAlpha);
    end;
  end;
end;

procedure TChainAction.OnAfterRenderScene(aSceneNum: Integer);
begin
  case aSceneNum of
    SCN_CIRCLE, SCN_EXPLO:
    begin
      Display.RestoreDefaultBlendMode;
    end;
  end;
end;

procedure TChainAction.SpawnCircle(aNum: Integer);
var
  I: Integer;
begin
  for I := 0 to aNum - 1 do
    Scene[SCN_CIRCLE].Add(TCircle.Create);
end;

procedure TChainAction.SpawnCircle;
begin
  SpawnCircle(Math.RandomRange(10, 40));
end;

procedure TChainAction.SpawnExplosion(aX, aY: Single; aColor: TColor);
var
  obj: TCircleExplosion;
begin
  obj := TCircleExplosion.Create;
  obj.Setup(aX, aY, aColor);
  Scene[SCN_EXPLO].Add(obj);
end;

procedure TChainAction.SpawnExplosion(aCircle: TCircle);
var
  obj: TCircleExplosion;
begin
  obj := TCircleExplosion.Create;
  obj.Setup(aCircle);
  Scene[SCN_EXPLO].Add(obj);
end;

procedure TChainAction.CheckCollision(aEntity: TEntityActor);
begin
  Scene[SCN_CIRCLE].CheckCollision([], aEntity);
end;

procedure TChainAction.StartChain;
begin
  if not FChainActive then
  begin
    SpawnExplosion(MousePos.X, MousePos.Y, WHITE);
    FChainActive := True;
  end;
end;

procedure TChainAction.PlayLevel;
begin
  Scene.ClearAll;
  SpawnCircle(CIRCLE_COUNT);
  FChainActive := False;
  FExplosions := 0;
end;

function  TChainAction.ChainEnded: Boolean;
begin
  Result := True;

  if FChainActive then
  begin
    Result := Boolean(Scene[SCN_EXPLO].Count = 0);
    if Result  then
      FChainActive := False;
  end;
end;

function  TChainAction.LevelClear: Boolean;
begin
  Result := Boolean(Scene[SCN_CIRCLE].Count = 0);
end;


end.
