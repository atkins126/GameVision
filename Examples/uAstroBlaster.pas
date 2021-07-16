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

unit uAstroBlaster;

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
  cMultiplier = 60;
  cPlayerMultiplier = 600;

  // player
  cPlayerTurnRate      = 2.7 * cPlayerMultiplier;
  cPlayerFriction      = 0.005* cPlayerMultiplier;
  cPlayerAccel         = 0.1* cPlayerMultiplier;
  cPlayerMagnitude     = 10 * 14;
  cPlayerHalfSize      = 32.0;
  cPlayerFrameFPS      = 12;
  cPlayerNeutralFrame  = 0;
  cPlayerFirstFrame    = 1;
  cPlayerLastFrame     = 3;
  cPlayerTurnAccel     = 300;
  cPlayerMaxTurn       = 150;
  cPlayerTurnDrag      = 150;

  // scene
  cSceneBkgrnd         = 0;
  cSceneRocks          = 1;
  cSceneRockExp        = 2;
  cSceneEnemyWeapon    = 3;
  cSceneEnemy          = 4;
  cSceneEnemyExp       = 5;
  cScenePlayerWeapon   = 6;
  cScenePlayer         = 7;
  cScenePlayerExp      = 8;
  cSceneCount          = 9;

  // sound effects
  cSfxRockExp          = 0;
  cSfxPlayerExp        = 1;
  cSfxEnemyExp         = 2;
  cSfxPlayerEngine     = 3;
  cSfxPlayerWeapon     = 4;

  // volume
  cVolPlayerEngine     = 0.40;
  cVolPlayerWeapon     = 0.30;
  cVolRockExp          = 0.25;
  cVolSong             = 0.55;

  // rocks
  cRocksMin            = 7;
  cRocksMax            = 21;

  DEBUG_RENDERPOLYPOINT = False;

type

  { TSpriteID }
  PSpriteID = ^TSpriteID;
  TSpriteID = record
    Page : Integer;
    Group: Integer;
  end;

  { TRockSize }
  TRockSize = (rsLarge, rsMedium, rsSmall);

  { TEntity }
  TBaseEntity = class(TEntityActor)
  protected
    FTest: string;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure WrapPosAtEdge(var aPos: TVector);
  end;

  { TWeapon }
  TWeapon = class(TBaseEntity)
  protected
    FSpeed: Single;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure OnRender; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnCollide(aActor: TActor; aHitPos: TVector); override;
    procedure Spawn(aId: Integer; aPos: TVector; aAngle, aSpeed: Single);
  end;

  { TExplosion }
  TExplosion = class(TBaseEntity)
  protected
    FSpeed: Single;
    FCurDir: TVector;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure OnRender; override;
    procedure OnUpdate(aElapsedTime: Double); override;
    procedure Spawn(aPos: TVector; aDir: TVector; aSpeed, aScale: Single);
  end;

  { TParticle }
  TParticle = class(TBaseEntity)
  protected
    FSpeed: Single;
    FFadeSpeed: Single;
    FAlpha: Single;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure OnRender; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure Spawn(aId: Integer; aPos: TVector; aAngle, aSpeed, aScale, aFadeSpeed: Single; aScene: Integer);
  end;

  { TRock }
  TRock = class(TBaseEntity)
  protected
    FCurDir: TVector;
    FSpeed: Single;
    FRotSpeed: Single;
    FSize: TRockSize;
    function CalcScale(aSize: TRockSize): Single;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure OnRender; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnCollide(aActor: TActor; aHitPos: TVector); override;
    procedure Spawn(aId: Integer; aSize: TRockSize; aPos: TVector; aAngle: Single);
    procedure Split(aHitPos: TVector);
  end;

  { TPlayer }
  TPlayer = class(TBaseEntity)
  protected
    FTimer    : Single;
    FCurFrame : Integer;
    FThrusting: Boolean;
    FCurAngle : Single;
    FTurnSpeed: Single;
  public
    DirVec    : TVector;
    constructor Create; override;
    destructor Destroy; override;
    procedure OnRender; override;
    procedure OnUpdate(aDelta: Double); override;
    procedure Spawn(aX, aY: Single);
    procedure FireWeapon(aSpeed: Single);
  end;


  { TAstroBlaster }
{ TAstroBlasterDemo }
  TAstroBlasterDemo = class(TCustomExample)
  protected
    FBkPos: TVector;
    FBkColor: TColor;
    FMusic: Integer;
  public
    Sfx: array[0..7] of Integer;
    Background : array[0..3] of TBitmap;
    PlayerSprID: TSpriteID;
    EnemySprID: TSpriteID;
    RocksSprID: TSpriteID;
    ShieldsSprID: TSpriteID;
    WeaponSprID: TSpriteID;
    ExplosionSprID: TSpriteID;
    ParticlesSprID: TSpriteID;
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
    procedure SpawnRocks;
    procedure SpawnPlayer;
    procedure SpawnLevel;
    function  LevelCleared: Boolean;
  end;
implementation

const
  cChanPlayerEngine = 0;
  cChanPlayerWeapon = 1;

var
  Player: TPlayer;
  Game: TAstroBlasterDemo;


function RandomRangedslNP(aMin, aMax: Single): Single;
begin
  Result := Math.RandomRange(aMin, aMax);
  if Math.RandomBool then Result := -Result;
end;

function RangeRangeIntNP(aMin, aMax: Integer): Integer;
begin
  Result := Math.RandomRange(aMin, aMax);
  if Math.RandomBool then Result := -Result;
end;


{ TBaseEntity }
constructor TBaseEntity.Create;
begin
  inherited;

  CanCollide := True;
end;

destructor TBaseEntity.Destroy;
begin

  inherited;
end;

procedure  TBaseEntity.WrapPosAtEdge(var aPos: TVector);
var
  LHH,LHW: Single;
begin
  LHW := Entity.GetWidth  / 2;
  LHH := Entity.GetHeight /2 ;

  if (aPos.X > (Game.Config.DisplayWidth-1)+LHW) then
    aPos.X := -LHW
  else if (aPos.X < -LHW) then
    aPos.X := (Game.Config.DisplayWidth-1)+LHW;

  if (aPos.Y > (Game.Config.DisplayHeight-1)+LHH) then
    aPos.Y := -LHH
  else if (aPos.Y < -LHW) then
    aPos.Y := (Game.Config.DisplayHeight-1)+LHH;
end;


{ TWeapon }
constructor TWeapon.Create;
begin
  inherited;

  Init(Game.Sprite, Game.WeaponSprId.Group);
  Entity.TracePolyPoint(6, 12, 70);
  Entity.SetRenderPolyPoint(DEBUG_RENDERPOLYPOINT);
end;

destructor TWeapon.Destroy;
begin

  inherited;
end;

procedure TWeapon.OnRender;
begin
  inherited;
end;

procedure TWeapon.OnUpdate(aDeltaTime: Double);
begin
  inherited;

  if Entity.IsVisible(0,0) then
    begin
      Entity.Thrust(FSpeed*aDeltaTime);
      Game.Scene[cSceneRocks].CheckCollision([], Self);
    end
  else
    Terminated := True;
end;

procedure TWeapon.OnCollide(aActor: TActor; aHitPos: TVector);
begin
  CanCollide := False;
  Terminated := True;
end;

procedure  TWeapon.Spawn(aId: Integer; aPos: TVector; aAngle, aSpeed: Single);
begin
  FSpeed := aSpeed;
  Entity.SetFrame(aId);
  Entity.SetPosAbs(aPos.X, aPos.Y);
  Entity.RotateAbs(aAngle);
end;


{ TExplosion }
constructor TExplosion.Create;
begin
  inherited;

  FSpeed := 0;
  FCurDir.X := 0;
  FCurDir.Y := 0;
end;

destructor TExplosion.Destroy;
begin

  inherited;
end;

procedure TExplosion.OnRender;
begin
  inherited;

end;

procedure TExplosion.OnUpdate(aElapsedTime: Double);
var
  LP, LV: TVector;
begin
  if Entity.NextFrame then
  begin
    Terminated := True;
  end;

  LV.X := (FCurDir.X + FSpeed) * aElapsedTime;
  LV.Y := (FCurDir.Y + FSpeed) * aElapsedTime;

  LP := Entity.GetPos;

  LP.X := LP.X + LV.X;
  LP.Y := LP.Y + LV.Y;

  Entity.SetPosAbs(LP.X, LP.Y);

  inherited;
end;

procedure TExplosion.Spawn(aPos: TVector; aDir: TVector; aSpeed, aScale: Single);
begin
  FSpeed := aSpeed;
  FCurDir := aDir;

  Init(Game.Sprite, Game.ExplosionSprID.Group);

  Entity.SetFrameFPS(14);
  Entity.SetScaleAbs(aScale);
  Entity.SetPosAbs(aPos.X, aPos.Y);

  Game.Scene[cSceneRockExp].Add(Self);
end;


{ TParticle }
constructor TParticle.Create;
begin
  inherited;

end;

destructor TParticle.Destroy;
begin

  inherited;
end;

procedure TParticle.OnRender;
begin
  inherited;

end;

procedure TParticle.OnUpdate(aDeltaTime: Double);
var
  LC,LC2: TColor;
  LA: Single;
begin
  Entity.Thrust(FSpeed*aDeltaTime);

  if Entity.IsVisible(0, 0) then
    begin
      FAlpha := FAlpha - (FFadeSpeed * aDeltaTime);
      if FAlpha <= 0 then
      begin
        FAlpha := 0;
        Terminated := True;
      end;
      LA := FAlpha / 255.0;
      LC2.Red := 1*LA; LC2.Green := 1*LA; LC2.Blue := 1*LA; LC2.Alpha := LA;
      LC.Make(LC2.Red, LC2.Green, LC2.Blue, LC2.Alpha);
      Entity.SetColor(LC);
    end
  else
    Terminated := True;

  inherited;
end;

procedure TParticle.Spawn(aId: Integer; aPos: TVector; aAngle, aSpeed, aScale, aFadeSpeed: Single; aScene: Integer);
begin
  FSpeed := aSpeed;
  FFadeSpeed := aFadeSpeed;
  FAlpha := 255;

  Init(Game.Sprite, Game.ParticlesSprID.Group);

  Entity.SetFrame(aId);
  Entity.SetScaleAbs(aScale);
  Entity.SetPosAbs(aPos.X, aPos.Y);
  Entity.RotateAbs(aAngle);

  Game.Scene[aScene].Add(Self);
end;


{ TRock }
function TRock.CalcScale(aSize: TRockSize): Single;
begin
  case aSize of
    rsLarge: Result := 1.0;
    rsMedium: Result := 0.65;
    rsSmall: Result := 0.45;
  else
    Result := 1.0;
  end;
end;

constructor TRock.Create;
begin
  inherited;
  FSpeed := 0;
  FRotSpeed := 0;
  FSize := rsLarge;

  Init(Game.Sprite, Game.RocksSprId.Group);

  Entity.TracePolyPoint(6, 12, 70);
  Entity.SetRenderPolyPoint(DEBUG_RENDERPOLYPOINT);
end;

destructor TRock.Destroy;
begin

  inherited;
end;

procedure TRock.OnRender;
begin
  inherited;

end;

procedure TRock.OnUpdate(aDeltaTime: Double);
var
  LP: TVector;
  LV: TVector;
begin
  inherited;

  Entity.RotateRel(FRotSpeed*aDeltaTime);
  LV.X := (FCurDir.X + FSpeed);
  LV.Y := (FCurDir.Y + FSpeed);
  LP := Entity.GetPos;
  LP.X := LP.X + LV.X*aDeltaTime;
  LP.Y := LP.Y + LV.Y*aDeltaTime;
  WrapPosAtEdge(LP);
  Entity.SetPosAbs(LP.X, LP.Y);
end;

procedure TRock.OnCollide(aActor: TActor; aHitPos: TVector);
begin
  CanCollide := False;
  Split(aHitPos);
end;

procedure TRock.Spawn(aId: Integer; aSize: TRockSize; aPos: TVector; aAngle: Single);
begin
  FSpeed := RandomRangedslNP(0.2*cMultiplier, 2*cMultiplier);
  FRotSpeed := RandomRangedslNP(0.2*cMultiplier, 2*cMultiplier);

  FSize := aSize;
  Entity.SetFrame(aId);
  Entity.SetPosAbs(aPos.X, aPos.Y);
  Entity.RotateAbs(Math.RandomRange(0, 259));
  Entity.Thrust(1);

  FCurDir := Entity.GetDir;
  FCurDir.Normalize;
  Entity.SetScaleAbs(CalcScale(FSize));
end;

procedure TRock.Split(aHitPos: TVector);

  procedure DoSplit(aId: Integer; aSize: TRockSize; aPos: TVector);
  var
    LR: TRock;
  begin
    LR := TRock.Create;
    LR.Spawn(aId, aSize, aPos, 0);
    Game.Scene[cSceneRocks].Add(LR);
  end;

  procedure DoExplosion(aScale: Single);
  var
    LP: TVector;
    LE: TExplosion;
  begin
    LP := Entity.GetPos;
    LE := TExplosion.Create;
    LE.Spawn(LP, FCurDir, FSpeed, aScale);
  end;

  procedure DoParticles;
  var
    LC, LI: Integer;
    LP: TParticle;
    LAngle, LSpeed, LFade: Single;
  begin
    LC := 0;
    case FSize of
      rsLarge :
        begin
          LC := 50;
          Screenshake.Start(30, 3);
        end;
      rsMedium:
        begin
          LC := 25;
          Screenshake.Start(30, 2);
        end;
      rsSmall :
        begin
          LC := 15;
          Screenshake.Start(30, 1);
        end;
    end;

    for LI := 1 to LC do
    begin
      LP := TParticle.Create;
      LAngle := Math.RandomRange(0, 255);
      LSpeed := Math.RandomRange(1*cMultiplier, 7*cMultiplier);
      LFade := Math.RandomRange(3*cMultiplier, 7*cMultiplier);

      LP.Spawn(0, aHitPos, LAngle, LSpeed, 0.10, LFade, cSceneRockExp);
    end;
  end;

begin
  case FSize of
    rsLarge:
      begin
        DoSplit(Entity.GetFrame, rsMedium, Entity.GetPos);
        DoSplit(Entity.GetFrame, rsMedium, Entity.GetPos );
        DoExplosion(3.0);
        DoParticles;
        Audio.PlaySound(AUDIO_DYNAMIC_CHANNEL, Game.Sfx[cSfxRockExp], cVolRockExp, False);
      end;

    rsMedium:
      begin
        DoSplit(Entity.GetFrame, rsSmall, Entity.GetPos);
        DoSplit(Entity.GetFrame, rsSmall, Entity.GetPos);
        DoExplosion(2.5);
        DoParticles;
        Audio.PlaySound(AUDIO_DYNAMIC_CHANNEL, Game.Sfx[cSfxRockExp], cVolRockExp, False);

      end;

    rsSmall:
      begin
        DoExplosion(1.5);
        DoParticles;
        Audio.PlaySound(AUDIO_DYNAMIC_CHANNEL, Game.Sfx[cSfxRockExp], cVolRockExp, False);
      end;
  end;

  Terminated := True;
end;


{ TPlayer }
constructor TPlayer.Create;
begin
  Player := Self;

  inherited;

  FTimer    := 0;
  FCurFrame := 0;
  FThrusting:= False;
  FCurAngle := 0;
  DirVec.Clear;
  FTurnSpeed := 0;

  Init(Game.Sprite, Game.PlayerSprID.Group);
  Entity.TracePolyPoint(6, 12, 70);
  Entity.SetPosAbs(Game.Config.DisplayWidth /2, Game.Config.DisplayHeight /2);
  Entity.SetRenderPolyPoint(DEBUG_RENDERPOLYPOINT);
end;

destructor TPlayer.Destroy;
begin
  inherited;

  Player := nil;
end;

procedure TPlayer.OnRender;
begin
  inherited;
end;

procedure TPlayer.OnUpdate(aDelta: Double);
var
  LP: TVector;
  LFire: Boolean;
  LTurn: Integer;
  LAccel: Boolean;
begin
  if Input.KeyboardPressed(KEY_LCTRL) or
     Input.KeyboardPressed(KEY_RCTRL) or
     Input.JoystickPressed(JOY_BTN_RB) then
    LFire := True
  else
    LFire := False;

  if Input.KeyboardDown(KEY_RIGHT) or
     Input.JoystickDown(JOY_BTN_RDPAD) then
    LTurn := 1
  else
  if Input.KeyboardDown(KEY_LEFT) or
     Input.JoystickDown(JOY_BTN_LDPAD) then
    LTurn := -1
  else
    LTurn := 0;

  if (Input.KeyboardDown(KEY_UP)) or
     Input.JoystickDown(JOY_BTN_UDPAD) then
    LAccel := true
  else
    LAccel := False;

  // update keys
  if LFire then
  begin
    FireWeapon(10*cMultiplier);
  end;

  if LTurn = 1 then
  begin
    Math.SmoothMove(FTurnSpeed, cPlayerTurnAccel*aDelta, cPlayerMaxTurn, cPlayerTurnDrag*aDelta);
  end
  else if LTurn = -1 then
    begin
      Math.SmoothMove(FTurnSpeed, -cPlayerTurnAccel*aDelta, cPlayerMaxTurn, cPlayerTurnDrag*aDelta);
    end
  else
    begin
      Math.SmoothMove(FTurnSpeed, 0, cPlayerMaxTurn, cPlayerTurnDrag*aDelta);
    end;

  FCurAngle := FCurAngle + FTurnSpeed*aDelta;
  if FCurAngle > 360 then
    FCurAngle := FCurAngle - 360
  else if FCurAngle < 0 then
    FCurAngle := FCurAngle + 360;

  FThrusting := False;
  if (LAccel) then
  begin
    FThrusting := True;

    if (DirVec.Magnitude < cPlayerMagnitude) then
    begin
      DirVec.Thrust(FCurAngle, cPlayerAccel*aDelta);
    end;

    if Audio.GetChannelStatus(cChanPlayerEngine) = asStopped then
    begin
      Audio.PlaySound(cChanPlayerEngine, Game.Sfx[cSfxPlayerEngine], cVolPlayerEngine, True);
    end;

  end;

  Math.SmoothMove(DirVec.X, 0, cPlayerMagnitude, cPlayerFriction*aDelta);
  Math.SmoothMove(DirVec.Y, 0, cPlayerMagnitude, cPlayerFriction*aDelta);

  LP := Entity.GetPos;
  LP.X := LP.X + DirVec.X*aDelta;
  LP.Y := LP.Y + DirVec.Y*aDelta;

  WrapPosAtEdge(LP);

  if (FThrusting) then
    begin
      if (Engine.FrameSpeed(FTimer, cPlayerFrameFPS)) then
      begin
        FCurFrame := FCurFrame + 1;
        if (FCurFrame > cPlayerLastFrame) then
        begin
          FCurFrame := cPlayerFirstFrame;
        end
      end;

    end
  else
    begin
      FCurFrame := cPlayerNeutralFrame;

      if Audio.GetChannelStatus(cChanPlayerEngine) = asPlaying then
      begin
        Audio.StopChannel(cChanPlayerEngine);
      end;
    end;

  Entity.RotateAbs(FCurAngle);
  Entity.SetFrame(FCurFrame);
  Entity.SetPosAbs(LP.X, LP.Y);
end;

procedure TPlayer.Spawn(aX, aY: Single);
begin
end;

procedure TPlayer.FireWeapon(aSpeed: Single);
var
  LP: TVector;
  LW: TWeapon;
begin
  LP := Entity.GetPos;
  LP.Thrust(Entity.GetAngle, 16);
  LW := TWeapon.Create;
  LW.Spawn(0, LP, Entity.GetAngle, aSpeed);
  Game.Scene[cScenePlayerWeapon].Add(LW);
  Audio.PlaySound(cChanPlayerWeapon, Game.Sfx[cSfxPlayerWeapon], cVolPlayerWeapon, False);
end;


{ TAstroBlasterDemo }
constructor TAstroBlasterDemo.Create;
begin
  inherited;

  Game := Self;
end;

destructor TAstroBlasterDemo.Destroy;
begin
  Game := nil;

  inherited;
end;

procedure TAstroBlasterDemo.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'AstroBlaster Demo';
  aConfig.DisplayClearColor := BLACK;
  aConfig.SceneCount := cSceneCount;
end;

procedure TAstroBlasterDemo.OnLoad;
begin
  inherited;
end;

procedure TAstroBlasterDemo.OnExit;
begin
  inherited;
end;

procedure TAstroBlasterDemo.OnStartup;
begin
  inherited;

  // init background
  FBkColor.Make(255,255,255,128);

  Background[0] := TBitmap.LoadBitmap('arc/bitmaps/backgrounds/space.png',  @BLACK);
  Background[1] := TBitmap.LoadBitmap('arc/bitmaps/backgrounds/nebula.png', @BLACK);
  Background[2] := TBitmap.LoadBitmap('arc/bitmaps/backgrounds/spacelayer1.png', @BLACK);
  Background[3] := TBitmap.LoadBitmap('arc/bitmaps/backgrounds/spacelayer2.png', @BLACK);

    // init player sprites
  PlayerSprID.Page := Sprite.LoadPage('arc/bitmaps/sprites/ship.png', nil);
  PlayerSprID.Group := Sprite.AddGroup;
  Sprite.AddImageFromGrid(PlayerSprID.Page, PlayerSprID.Group, 0, 0, 64, 64);
  Sprite.AddImageFromGrid(PlayerSprID.Page, PlayerSprID.Group, 1, 0, 64, 64);
  Sprite.AddImageFromGrid(PlayerSprID.Page, PlayerSprID.Group, 2, 0, 64, 64);
  Sprite.AddImageFromGrid(PlayerSprID.Page, PlayerSprID.Group, 3, 0, 64, 64);


  // init enemy sprites
  EnemySprID.Page := PlayerSprID.Page;
  EnemySprID.Group := Sprite.AddGroup;
  Sprite.AddImageFromGrid(EnemySprID.Page, EnemySprID.Group, 0, 1, 64, 64);
  Sprite.AddImageFromGrid(EnemySprID.Page, EnemySprID.Group, 1, 1, 64, 64);
  Sprite.AddImageFromGrid(EnemySprID.Page, EnemySprID.Group, 2, 1, 64, 64);

  // init shield sprites
  ShieldsSprID.Page := PlayerSprID.Page;
  ShieldsSprID.Group := Sprite.AddGroup;
  Sprite.AddImageFromGrid(ShieldsSprID.Page, ShieldsSprID.Group, 0, 4, 32, 32);
  Sprite.AddImageFromGrid(ShieldsSprID.Page, ShieldsSprID.Group, 1, 4, 32, 32);
  Sprite.AddImageFromGrid(ShieldsSprID.Page, ShieldsSprID.Group, 2, 4, 32, 32);

  // init wepason sprites
  WeaponSprID.Page := PlayerSprID.Page;
  WeaponSprID.Group := Sprite.AddGroup;
  Sprite.AddImageFromGrid(WeaponSprID.Page, WeaponSprID.Group, 3, 4, 32, 32);
  Sprite.AddImageFromGrid(WeaponSprID.Page, WeaponSprID.Group, 4, 4, 32, 32);
  Sprite.AddImageFromGrid(WeaponSprID.Page, WeaponSprID.Group, 5, 4, 32, 32);

  // init rock sprites
  RocksSprID.Page := Sprite.LoadPage('arc/bitmaps/sprites/rocks.png', nil);
  RocksSprID.Group := Sprite.AddGroup;
  Sprite.AddImageFromGrid(RocksSprID.Page, RocksSprID.Group, 0, 0, 128, 128);
  Sprite.AddImageFromGrid(RocksSprID.Page, RocksSprID.Group, 1, 0, 128, 128);
  Sprite.AddImageFromGrid(RocksSprID.Page, RocksSprID.Group, 0, 1, 128, 128);


  // init explosion sprites
  ExplosionSprID.Page := Sprite.LoadPage('arc/bitmaps/sprites/explosion.png', nil);
  ExplosionSprID.Group := Sprite.AddGroup;
  Sprite.AddImageFromGrid(ExplosionSprID.Page, ExplosionSprID.Group, 0, 0, 64, 64);
  Sprite.AddImageFromGrid(ExplosionSprID.Page, ExplosionSprID.Group, 1, 0, 64, 64);
  Sprite.AddImageFromGrid(ExplosionSprID.Page, ExplosionSprID.Group, 2, 0, 64, 64);
  Sprite.AddImageFromGrid(ExplosionSprID.Page, ExplosionSprID.Group, 3, 0, 64, 64);

  Sprite.AddImageFromGrid(ExplosionSprID.Page, ExplosionSprID.Group, 0, 1, 64, 64);
  Sprite.AddImageFromGrid(ExplosionSprID.Page, ExplosionSprID.Group, 1, 1, 64, 64);
  Sprite.AddImageFromGrid(ExplosionSprID.Page, ExplosionSprID.Group, 2, 1, 64, 64);
  Sprite.AddImageFromGrid(ExplosionSprID.Page, ExplosionSprID.Group, 3, 1, 64, 64);

  Sprite.AddImageFromGrid(ExplosionSprID.Page, ExplosionSprID.Group, 0, 2, 64, 64);
  Sprite.AddImageFromGrid(ExplosionSprID.Page, ExplosionSprID.Group, 1, 2, 64, 64);
  Sprite.AddImageFromGrid(ExplosionSprID.Page, ExplosionSprID.Group, 2, 2, 64, 64);
  Sprite.AddImageFromGrid(ExplosionSprID.Page, ExplosionSprID.Group, 3, 2, 64, 64);

  Sprite.AddImageFromGrid(ExplosionSprID.Page, ExplosionSprID.Group, 0, 3, 64, 64);
  Sprite.AddImageFromGrid(ExplosionSprID.Page, ExplosionSprID.Group, 1, 3, 64, 64);
  Sprite.AddImageFromGrid(ExplosionSprID.Page, ExplosionSprID.Group, 2, 3, 64, 64);
  Sprite.AddImageFromGrid(ExplosionSprID.Page, ExplosionSprID.Group, 3, 3, 64, 64);

  // init particles
  ParticlesSprID.Page := Sprite.LoadPage('arc/bitmaps/sprites/particles.png', nil);
  ParticlesSprID.Group := Sprite.AddGroup;
  Sprite.AddImageFromGrid(ParticlesSprID.Page, ParticlesSprID.Group, 0, 0, 64, 64);

  Audio.SetChannelReserved(0, True);
  Audio.SetChannelReserved(1, True);

  // init sfx
  Sfx[cSfxRockExp] := Audio.LoadSound('arc/audio/sfx/explo_rock.ogg');
  Sfx[cSfxPlayerExp] := Audio.LoadSound('arc/audio/sfx/explo_player.ogg');
  Sfx[cSfxEnemyExp] := Audio.LoadSound('arc/audio/sfx/explo_enemy.ogg');
  Sfx[cSfxPlayerEngine] := Audio.LoadSound('arc/audio/sfx/engine_player.ogg');
  Sfx[cSfxPlayerWeapon] := Audio.LoadSound('arc/audio/sfx/weapon_player.ogg');

  FMusic := Audio.LoadMusic('arc/audio/music/song13.ogg');
  Audio.PlayMusic(FMusic, 1.0, True);

  // init scene
  //Scene.Alloc(cSceneCount);
end;

procedure TAstroBlasterDemo.OnShutdown;
begin
  Scene.ClearAll;

  Audio.UnloadMusic(FMusic);

  Audio.UnloadSound(Sfx[cSfxRockExp]);
  Audio.UnloadSound(Sfx[cSfxPlayerExp]);
  Audio.UnloadSound(Sfx[cSfxEnemyExp]);
  Audio.UnloadSound(Sfx[cSfxPlayerEngine]);
  Audio.UnloadSound(Sfx[cSfxPlayerWeapon]);

  FreeAndNil(Background[3]);
  FreeAndNil(Background[2]);
  FreeAndNil(Background[1]);
  FreeAndNil(Background[0]);

  inherited;
end;

procedure TAstroBlasterDemo.OnUpdate(aDeltaTime: Double);
var
  LP: TVector;
begin
  if Assigned(Player) then
  begin
    LP := Player.DirVec;
    FBkPos.X := FBkPos.X + (LP.X * aDeltaTime);
    FBkPos.Y := FBkPos.Y + (LP.Y * aDeltaTime);
  end;

  if LevelCleared then
  begin
    SpawnLevel;
  end;

  //Scene.Update([], aDeltaTime);
  inherited;
end;

const
  mBM = 3;

procedure TAstroBlasterDemo.OnRender;
begin
  // render background
  Background[0].DrawTiled(-(FBkPos.X/1.9*mBM), -(FBkPos.Y/1.9*mBM));

  Display.SetBlendMode(bmAdditiveAlpha);
  Background[1].DrawTiled(-(FBkPos.X/1.9*mBM), -(FBkPos.Y/1.9*mBM));
  Display.RestoreDefaultBlendMode;
  Background[2].DrawTiled(-(FBkPos.X/1.6*mBM), -(FBkPos.Y/1.6*mBM));
  Background[3].DrawTiled(-(FBkPos.X/1.3*mBM), -(FBkPos.Y/1.3*mBM));

  //Scene.Render([], OnBeforeRenderScene, OnAfterRenderScene);

  inherited;
end;

procedure TAstroBlasterDemo.OnRenderHUD;
begin
  inherited;

  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, GREEN, haLeft, 'Left      - Rotate left', []);
  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, GREEN, haLeft, 'Right     - Rotate right', []);
  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, GREEN, haLeft, 'Up        - Thrust', []);
  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, GREEN, haLeft, 'Ctrl      - Fire', []);
  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, YELLOW, haLeft, 'Count:      %d', [Scene[cSceneRocks].Count]);
end;

procedure TAstroBlasterDemo.OnBeforeRenderScene(aSceneNum: Integer);
begin
  case aSceneNum of
    cSceneRockExp:
    begin
      Display.SetBlendMode(bmAdditiveAlpha);
    end;
  end;
end;

procedure TAstroBlasterDemo.OnAfterRenderScene(aSceneNum: Integer);
begin
  case aSceneNum of
    cSceneRockExp:
    begin
      Display.RestoreDefaultBlendMode;
    end;
  end;
end;

procedure TAstroBlasterDemo.SpawnRocks;
var
  LI, LC: Integer;
  LId: Integer;
  LSize: TRockSize;
  LAngle: Single;
  LRock: TRock;
  LRadius : Single;
  LPos: TVector;
begin

  LC := Math.RandomRange(cRocksMin, cRocksMax);

  for LI := 1 to LC do
  begin
    LId := Math.RandomRange(0, 2);
    LSize := TRockSize(Math.RandomRange(0, 2));

    LPos.x := Config.DisplayWidth / 2;
    LPos.y := Config.DisplayHeight /2;

    LRadius := (LPos.x + LPos.y) / 2;
    LAngle := Math.RandomRange(0, 359);
    LPos.Thrust(LAngle, LRadius);

    LRock := TRock.Create;
    LRock.Spawn(LId, LSize, LPos, LAngle);
    Game.Scene[cSceneRocks].Add(LRock);
  end;
end;

procedure TAstroBlasterDemo.SpawnPlayer;
begin
  Scene.Lists[cScenePlayer].Add(TPlayer.Create);
end;

procedure TAstroBlasterDemo.SpawnLevel;
begin
  Scene.ClearAll;
  SpawnRocks;
  SpawnPlayer;
end;

function TAstroBlasterDemo.LevelCleared: Boolean;
begin
  if (Scene[cSceneRocks].Count        > 0) or
     (Scene[cSceneRockExp].Count      > 0) or
     (Scene[cScenePlayerWeapon].Count > 0) then
    Result := False
  else
    Result := True;
end;


end.
