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

  { TFontUnicodee }
  TFontUnicode = class(TCustomExample)
  protected
    FUnicodeFont: TFont;
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
  protected
    FTexture: array[0..3] of TBitmap;
    FSpeed: array[0..3] of Single;
    FPos: array[0..3] of TVector;
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
  protected
    FBmp: TBitmap;
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
  protected
    FBmp: array[ 0..1 ] of TBitmap;
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

  { TEntityBasic }
  TEntityBasic = class(TCustomExample)
  protected
    FShip: TEntity;
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
  end;

  { TEntityBlendMode }
  TEntityBlendMode = class(TCustomExample)
  protected
    FBlendMode: Boolean;
    FExplo: TEntity;
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
  end;

  { TEntityPolyPointCollision }
  TEntityPolyPointCollision = class(TCustomExample)
  protected
    FBoss: TEntity;
    FFigure: TEntity;
    FFigureAngle: Single;
    FCollide: Boolean;
    FHitPos: TVector;
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
  end;

  { TEntityPolyPointCollisionPoint }
  TEntityPolyPointCollisionPoint = class(TCustomExample)
  protected
    FFigure: TEntity;
    FFigureAngle: Single;
    FCollide: Boolean;
    FHitPos: TVector;
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
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

  FBmp.Draw(Config.DisplayWidth/2, Config.DisplayHeight/2, 1, 0, WHITE, haCenter, vaCenter);

  var LSize: TVector;
  FBmp.GetSize(LSize);

  Font.Print(Config.DisplayWidth/2, (Config.DisplayHeight/2)+(LSize.Y/3.5), DARKORANGE, haCenter, 'PNG transparency', []);

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
  FreeAndNil(FBmp);

  inherited;
end;

procedure TBitmapPNGTrans.OnStartup;
begin
  inherited;

  FBmp := TBitmap.LoadBitmap('arc/bitmaps/sprites/alphacheese.png', nil);

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

  var LCenterPos: TVector;
  LCenterPos.Assign(Config.DisplayWidth/2, Config.DisplayHeight/2);

  var LSize: TVector;
  FBmp[0].GetSize(LSize);

  FBmp[0].Draw(LCenterPos.X, LCenterPos.Y-LSize.Y, 1.0, 0.0, WHITE, haCenter, vaCenter);
  FBmp[1].Draw(LCenterPos.X, LCenterPos.Y+LSize.Y, 1.0, 0.0, WHITE, haCenter, vaCenter);

  Font.Print(LCenterPos.X, LCenterPos.Y-(LSize.Y/2), DARKORANGE, haCenter, 'without colorkey', []);
  Font.Print(LCenterPos.X, LCenterPos.Y+(LSize.Y*1.5), DARKORANGE, haCenter, 'with colorkey', []);

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
  FreeAndNil(FBmp[1]);
  FreeAndNil(FBmp[0]);

  inherited;
end;

procedure TBitmapColorKeyTrans.OnStartup;
begin
  inherited;

  FBmp[0] := TBitmap.LoadBitmap('arc/bitmaps/sprites/circle00.png', nil);
  FBmp[1] := TBitmap.LoadBitmap('arc/bitmaps/sprites/circle00.png', @COLORKEY);

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
procedure TBitmapTiled.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Bitmap Tiled';
end;

procedure TBitmapTiled.OnLoad;
begin
  inherited;

end;

procedure TBitmapTiled.OnExit;
begin

  inherited;
end;

procedure TBitmapTiled.OnStartup;
begin
  inherited;

  // Load bitmap images
  FTexture[0] := TBitmap.LoadBitmap('arc/bitmaps/backgrounds/space.png', nil);
  FTexture[1] := TBitmap.LoadBitmap('arc/bitmaps/backgrounds/nebula.png', @BLACK);
  FTexture[2] := TBitmap.LoadBitmap('arc/bitmaps/backgrounds/spacelayer1.png', @BLACK);
  FTexture[3] := TBitmap.LoadBitmap('arc/bitmaps/backgrounds/spacelayer2.png', @BLACK);

  // Set bitmap speeds
  FSpeed[0] := 0.3 * 30;
  FSpeed[1] := 0.5 * 30;
  FSpeed[2] := 1.0 * 30;
  FSpeed[3] := 2.0 * 30;

  // Clear pos
  FPos[0].Clear;
  FPos[1].Clear;
  FPos[2].Clear;
  FPos[3].Clear;
end;

procedure TBitmapTiled.OnShutdown;
var
  LI: Integer;
begin
  for LI := 0 to 3 do
    FreeAndNil(FTexture[LI]);

  inherited;
end;

procedure TBitmapTiled.OnUpdate(aDeltaTime: Double);
var
  LI: Integer;
begin
  inherited;

  // update bitmap position
  for LI := 0 to 3 do
  begin
    FPos[LI].Y := FPos[LI].Y + (FSpeed[LI] * aDeltaTime);
  end;
end;

procedure TBitmapTiled.OnRender;
var
  LI: Integer;
begin
  inherited;

  // render bitmaps
  for LI := 0 to 3 do
  begin
    if LI = 1 then
    begin
      Display.SetBlendMode(bmAdditiveAlpha);
    end;
    FTexture[LI].DrawTiled(FPos[LI].X, FPos[LI].Y);
    if LI = 1 then Display.RestoreDefaultBlendMode;
  end;
end;

procedure TBitmapTiled.OnRenderHUD;
begin
  inherited;

end;

{ TFontUnicode }

procedure TFontUnicode.OnExit;
begin
  inherited;

end;

procedure TFontUnicode.OnLoad;
begin
  inherited;

end;

procedure TFontUnicode.OnRender;
begin
  inherited;

end;

procedure TFontUnicode.OnRenderHUD;
begin
  inherited;

  FUnicodeFont.Print(Config.DisplayWidth div 2, Config.DisplayHeight div 2, YELLOW, haCenter, ' en   zh      ja       ko        de   es   pt     fr      vi    id', []);
  FUnicodeFont.Print(Config.DisplayWidth div 2, (Config.DisplayHeight div 2)+18, GREEN, haCenter, 'Hello|你好|こんにちは|안녕하세요|Hallo|Hola|Olá|Bonjour|Xin chào|Halo', []);

end;

procedure TFontUnicode.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Font Unicode';

end;

procedure TFontUnicode.OnShutdown;
begin
  FreeAndNil(FUnicodeFont);

  inherited;
end;

procedure TFontUnicode.OnStartup;
begin
  inherited;

  FUnicodeFont := TFont.LoadFont(16, 'arc/fonts/default-mono.ttf');
end;

procedure TFontUnicode.OnUpdate(aDeltaTime: Double);
begin
  inherited;

end;

{ TEntityBasic }
procedure TEntityBasic.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Basic Entity';
  aConfig.DisplayClearColor := BLACK;
end;

procedure TEntityBasic.OnStartup;
begin
  inherited;

  // init ship sprite
  Sprite.LoadPage('arc/bitmaps/sprites/ship.png', nil);
  Sprite.AddGroup;
  Sprite.AddImageFromGrid(0, 0, 0, 0, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 1, 0, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 2, 0, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 3, 0, 64, 64);

  // init ship entity
  FShip := TEntity.Create;
  FShip.Init(Sprite, 0);
  FShip.SetFrameFPS(17);
  FShip.SetScaleAbs(1);
  FShip.SetPosAbs(Config.DisplayWidth/2, Config.DisplayHeight/2);
  FShip.SetFrameRange(1, 3);
end;

procedure TEntityBasic.OnShutdown;
begin
  FreeAndNil(FShip);

  inherited;
end;

procedure TEntityBasic.OnUpdate(aDeltaTime: Double);
begin
  inherited;

  FShip.NextFrame;
end;

procedure TEntityBasic.OnRender;
begin
  inherited;

  FShip.Render(0, 0);
end;

procedure TEntityBasic.OnRenderHUD;
begin
  inherited;

end;


{ TEntityPolyPointCollision }
procedure TEntityPolyPointCollision.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Entity Collision';
end;

procedure TEntityPolyPointCollision.OnStartup;
begin
  inherited;

  // init boss sprite
  Sprite.LoadPage('arc/bitmaps/sprites/boss.png', @COLORKEY);
  Sprite.AddGroup;
  Sprite.AddImageFromGrid(0, 0, 0, 0, 128, 128);
  Sprite.AddImageFromGrid(0, 0, 1, 0, 128, 128);
  Sprite.AddImageFromGrid(0, 0, 0, 1, 128, 128);

  // init figure sprite
  Sprite.LoadPage('arc/bitmaps/sprites/figure.png', @COLORKEY);
  Sprite.AddGroup;
  Sprite.AddImageFromGrid(1, 1, 0, 0, 128, 128);

  // init boss entity
  FBoss := TEntity.Create;
  FBoss.Init(Sprite, 0);
  FBoss.SetFrameFPS(14);
  FBoss.SetScaleAbs(1);
  FBoss.SetPosAbs(Config.DisplayWidth/2, (Config.DisplayHeight/2)-100);
  FBoss.TracePolyPoint(6, 12, 70);
  FBoss.SetRenderPolyPoint(True);

  // init figure entity
  FFigure := TEntity.Create;
  FFigure.Init(Sprite, 1);
  FFigure.SetFrameFPS(17);
  FFigure.SetScaleAbs(1);
  FFigure.SetPosAbs(Config.DisplayWidth/2, Config.DisplayHeight/2);
  FFigure.TracePolyPoint(6, 12, 70);
  FFigure.SetRenderPolyPoint(True);
end;

procedure TEntityPolyPointCollision.OnShutdown;
begin
  FreeAndNil(FFigure);
  FreeAndNil(FBoss);

  inherited;
end;

procedure TEntityPolyPointCollision.OnUpdate(aDeltaTime: Double);
begin
  inherited;

  FBoss.NextFrame;
  FBoss.ThrustToPos(30*50, 14*50, MousePos.X, MousePos.Y, 128, 32, 5*50, 0.001, aDeltaTime);
  if FBoss.CollidePolyPoint(FFigure, FHitPos) then
    FCollide := True
  else
    FCollide := False;

  FFigureAngle := FFigureAngle + (30.0 * aDeltaTime);
  Math.ClipValue(FFigureAngle, 0, 359, True);
  FFigure.RotateAbs(FFigureAngle);
end;

procedure TEntityPolyPointCollision.OnRender;
begin
  inherited;

  FFigure.Render(0, 0);
  FBoss.Render(0, 0);
  if FCollide then Display.DrawFilledRectangle(FHitPos.X, FHitPos.Y, 10, 10, RED);
end;

procedure TEntityPolyPointCollision.OnRenderHUD;
begin
  inherited;

end;


{ TEntityPolyPointCollisionPoint }
procedure TEntityPolyPointCollisionPoint.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Entity Collision Point';
end;

procedure TEntityPolyPointCollisionPoint.OnStartup;
begin
  inherited;

  // init figure sprite
  Sprite.LoadPage('arc/bitmaps/sprites/figure.png', @COLORKEY);
  Sprite.AddGroup;
  Sprite.AddImageFromGrid(0, 0, 0, 0, 128, 128);

  // init figure entity
  FFigure := TEntity.Create;
  FFigure.Init(Sprite, 0);
  FFigure.SetFrameFPS(17);
  FFigure.SetScaleAbs(1);
  FFigure.SetPosAbs(Config.DisplayWidth/2, Config.DisplayHeight/2);
  FFigure.TracePolyPoint(6, 12, 70);
  FFigure.SetRenderPolyPoint(True);
end;

procedure TEntityPolyPointCollisionPoint.OnShutdown;
begin
  FreeAndNil(FFigure);

  inherited;
end;

procedure TEntityPolyPointCollisionPoint.OnUpdate(aDeltaTime: Double);
begin
  inherited;

  FHitPos.Assign(MousePos);

  if FFigure.CollidePolyPointPoint(FHitPos) then
    FCollide := True
  else
    FCollide := False;

  FFigureAngle := FFigureAngle + (30.0 * aDeltaTime);
  Math.ClipValue(FFigureAngle, 0, 359, True);
  FFigure.RotateAbs(FFigureAngle);
end;

procedure TEntityPolyPointCollisionPoint.OnRender;
var
  LPos: TVector;
begin
  inherited;

  FFigure.Render(0, 0);
  if FCollide then
  begin
    LPos := FFigure.GetPos;
    Font.Print(LPos.X-64, LPos.Y-64, WHITE, haLeft, '(%3f,%3f)', [FHitPos.X, FHitPos.Y]);
    Display.DrawFilledRectangle(FHitPos.X, FHitPos.Y, 10, 10, RED);
  end;
end;

procedure TEntityPolyPointCollisionPoint.OnRenderHUD;
begin
  inherited;

  Font.Print(Config.DisplayWidth/2, (Config.DisplayHeight/2) - 100, YELLOW, haCenter, 'Move mouse pointer over figure outline', []);
end;


{ TEntityBlendMode }
procedure TEntityBlendMode.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'Entity Blend Mode';
end;

procedure TEntityBlendMode.OnStartup;
begin
  inherited;

  // init explosion sprite
  Sprite.LoadPage('arc/bitmaps/sprites/explosion.png', nil);
  Sprite.AddGroup;
  Sprite.AddImageFromGrid(0, 0, 0, 0, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 1, 0, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 2, 0, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 3, 0, 64, 64);

  Sprite.AddImageFromGrid(0, 0, 0, 1, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 1, 1, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 2, 1, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 3, 1, 64, 64);

  Sprite.AddImageFromGrid(0, 0, 0, 2, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 1, 2, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 2, 2, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 3, 2, 64, 64);

  Sprite.AddImageFromGrid(0, 0, 0, 3, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 1, 3, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 2, 3, 64, 64);
  Sprite.AddImageFromGrid(0, 0, 3, 3, 64, 64);

  // init explosion entity
  FExplo := TEntity.Create;
  FExplo.Init(Sprite, 0);
  FExplo.SetFrameFPS(14);
  FExplo.SetScaleAbs(1);
  FExplo.SetPosAbs(Config.DisplayWidth/2, Config.DisplayHeight/2);

  FBlendMode := False;
end;

procedure TEntityBlendMode.OnShutdown;
begin
  FreeAndNil(FExplo);

  inherited;
end;

procedure TEntityBlendMode.OnUpdate(aDeltaTime: Double);
begin
  inherited;

  if Input.KeyboardPressed(KEY_B) then
  begin
    FBlendMode := not FBlendMode;
  end;

  FExplo.NextFrame;
end;

procedure TEntityBlendMode.OnRender;
begin
  inherited;

  if FBlendMode then Display.SetBlendMode(bmAdditiveAlpha);
  FExplo.SetPosAbs(Config.DisplayWidth/2, Config.DisplayHeight/2);
  FExplo.Render(0,0);

  FExplo.SetPosAbs((Config.DisplayWidth/2)+16, (Config.DisplayHeight/2)+16);
  FExplo.Render(0,0);

  Display.RestoreDefaultBlendMode;
end;

procedure TEntityBlendMode.OnRenderHUD;
begin
  inherited;

  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, GREEN,  haLeft, 'B         - Toggle blending', []);
  Font.Print(HudPos.X, HudPos.Y, HudPos.Z, YELLOW, haLeft, 'Blend:      %s', [cTrueFalseStr[FBlendMode]]);
end;

end.
