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

unit GameVision.System;

{$I GameVision.Defines.inc }

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  System.Classes,
  System.IniFiles,
  System.SyncObjs,
  GameVision.CLib.Allegro,
  GameVision.Common,
  GameVision.Audio;

{ --- MATH ------------------------------------------------------------------ }
const
  // Degree/Radian conversion
  RAD2DEG = 180.0 / PI;
  DEG2RAD = PI / 180.0;

  { Misc }
  EPSILON = 0.00001;

type

  { TPointi }
  PPointi = ^TPointi;
  TPointi = record
    X, Y: Integer;
  end;

  { TPoint }
  PPointf = ^TPointi;
  TPointf = record
    X, Y: Single;
  end;

  { TRange }
  PRange = ^TRange;
  TRange = record
    MinX, MinY, MaxX, MaxY: Single;
  end;

  { TVector }
  PVector = ^TVector;
  TVector = record
    X, Y, Z: Single;
    constructor Create(aX: Single; aY: Single);
    procedure Assign(aX: Single; aY: Single); overload; inline;
    procedure Assign(aX: Single; aY: Single; aZ: Single); overload; inline;
    procedure Assign(aVector: TVector); overload; inline;
    procedure Clear; inline;
    procedure Add(aVector: TVector); inline;
    procedure Subtract(aVector: TVector); inline;
    procedure Multiply(aVector: TVector); inline;
    procedure Divide(aVector: TVector); inline;
    function  Magnitude: Single; inline;
    function  MagnitudeTruncate(aMaxMagitude: Single): TVector; inline;
    function  Distance(aVector: TVector): Single; inline;
    procedure Normalize; inline;
    function  Angle(aVector: TVector): Single; inline;
    procedure Thrust(aAngle: Single; aSpeed: Single); inline;
    function  MagnitudeSquared: Single; inline;
    function  DotProduct(aVector: TVector): Single; inline;
    procedure Scale(aValue: Single); inline;
    procedure DivideBy(aValue: Single); inline;
    function  Project(aVector: TVector): TVector; inline;
    procedure Negate; inline;
  end;

  { TRectangle }
  PRectangle = ^TRectangle;
  TRectangle = record
    X: Single;
    Y: Single;
    Width: Single;
    Height: Single;
    constructor Create(aX: Single; aY: Single; aWidth: Single; aHeight: Single);
    procedure Assign(aX: Single; aY: Single; aWidth: Single; aHeight: Single); inline;
    function  Intersect(aRect: TRectangle): Boolean; inline;
  end;

type
  { TMath }
  Math = record
  private
    class var
      FCosTable: array [0 .. 360] of Single;
      FSinTable: array [0 .. 360] of Single;
    var
    class procedure Setup; static;
    class procedure Shutdown; static;
  public
    class procedure Randomize; static;
    class function  RandomRange(aMin, aMax: Integer): Integer; overload; static;
    class function  RandomRange(aMin, aMax: Single): Single; overload; static;
    class function  RandomBool: Boolean; static;
    class function  GetRandomSeed: Integer; static;
    class procedure SetRandomSeed(aValue: Integer); static;

    class function  AngleCos(aAngle: Integer): Single; static;
    class function  AngleSin(aAngle: Integer): Single; static;
    class function  AngleDifference(aSrcAngle: Single; aDestAngle: Single): Single; static;
    class procedure AngleRotatePos(aAngle: Single; var aX: Single; var aY: Single); static;

    class function  ClipValue(var aValue: Single; aMin: Single; aMax: Single; aWrap: Boolean): Single; overload; static;
    class function  ClipValue(var aValue: Integer; aMin: Integer; aMax: Integer; aWrap: Boolean): Integer; overload; static;

    class function  SameSign(aValue1: Integer; aValue2: Integer): Boolean; overload; static;
    class function  SameSign(aValue1: Single; aValue2: Single): Boolean; overload; static;

    class function  SameValue(aA: Double; aB: Double; aEpsilon: Double = 0): Boolean; overload; static;
    class function  SameValue(aA: Single; aB: Single; aEpsilon: Single = 0): Boolean; overload; static;

    class function  Pointi(aX: Integer; aY: Integer): TPointi; inline; static;
    class function  Pointf(aX: Single; aY: Single): TPointf; inline; static;
    class function  Vector(aX: Single; aY: Single): TVector; inline; static;
    class function  Rectangle(aX: Single; aY: Single; aWidth: Single; aHeight: Single): TRectangle; inline; static;

    class procedure SmoothMove(var aValue: Single; aAmount: Single; aMax: Single; aDrag: Single); inline; static;
  end;

{ --- EASING ---------------------------------------------------------------- }
type
  { TEaseType }
  TEaseType = (etLinearTween, etInQuad, etOutQuad, etInOutQuad, etInCubic,
    etOutCubic, etInOutCubic, etInQuart, etOutQuart, etInOutQuart, etInQuint,
    etOutQuint, etInOutQuint, etInSine, etOutSine, etInOutSine, etInExpo,
    etOutExpo, etInOutExpo, etInCircle, etOutCircle, etInOutCircle);

  { TEase }
  Ease = record
    class function Value(aCurrentTime: Double; aStartValue: Double; aChangeInValue: Double; aDuration: Double; aEaseType: TEaseType): Double; static;
    class function Position(aStartPos: Double; aEndPos: Double; aCurrentPos: Double; aEaseType: TEaseType): Double; static;
  end;

{ --- COLLISION ------------------------------------------------------------- }
type
  { TLineIntersection }
  TLineIntersection = (liNone, liTrue, liParallel);

  { TCollision }
  Collision = record
  public
    class function PointInRectangle(aPoint: TVector; aRect: TRectangle): Boolean; static;
    class function PointInCircle(aPoint, aCenter: TVector; aRadius: Single): Boolean; static;
    class function PointInTriangle(aPoint, aP1, aP2, aP3: TVector): Boolean; static;
    class function CirclesOverlap(aCenter1: TVector; aRadius1: Single; aCenter2: TVector; aRadius2: Single): Boolean; static;
    class function CircleInRectangle(aCenter: TVector; aRadius: Single; aRect: TRectangle): Boolean; static;
    class function RectanglesOverlap(aRect1, aRect2: TRectangle): Boolean; static;
    class function RectangleIntersection(aRect1, aRect2: TRectangle): TRectangle; static;
    class function LineIntersection(aX1, aY1, aX2, aY2, aX3, aY3, aX4, aY4: Integer; var aX: Integer; var aY: Integer): TLineIntersection; static;
    class function RadiusOverlap(aRadius1, aX1, aY1, aRadius2, aX2, aY2, aShrinkFactor: Single): Boolean; static;
  end;

{ --- BUFFER ---------------------------------------------------------------- }
type
  { EBufferException }
  EBufferException = class(Exception);

  { TBuffer }
  TBuffer = class(TCustomMemoryStream)
  protected
    FHandle: THandle;
    FName: string;
  public
    property Name: string read FName;

    constructor Create(aSize: Integer);
    destructor Destroy; override;

    function  Write(const aBuffer; aCount: Longint): Longint; override;
    function  Write(const aBuffer: TBytes; aOffset, aCount: Longint): Longint; override;

    procedure SaveToFile(aFilename: string);

    class function FromFile(aFilename: string): TBuffer;
  end;

{ --- LOGGER ---------------------------------------------------------------- }
type
  { Logger }
  Logger = record
  private
    class var
      FFormatSettings : TFormatSettings;
      FFilename: string;
      FText: Text;
      FBuffer: array[Word] of Byte;
      FOpen: Boolean;
    var
  public
    class procedure Open(aFilename: string=''); static;
    class procedure Close; static;
    class procedure Log(const aMsg: string; const aArgs: array of const); static;
    class procedure Exception(const aMsg: string; const aArgs: array of const); static;
  end;

{ --- SHADER ---------------------------------------------------------------- }
type
  { TShader }
  TShader = class(TBaseObject)
  protected
    FHandle: PALLEGRO_SHADER;
    FName: string;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Load(const aBaseFilename: string): Boolean;
    function Unload: Boolean;
    function Enable(aEnable: Boolean): Boolean;
    function Log: string;
    function SetIntUniform(aName: string; aValue: Integer): Boolean; overload;
    function SetIntUniform(aName: string; aNumComponents: Integer; aValue: PInteger; aNumElements: Integer): Boolean; overload;
    function SetFloatUniform(aName: string; aValue: Single): Boolean; overload;
    function SetFloatUniform(aName: string; aNumComponents: Integer; aValue: System.PSingle; aNumElements: Integer): Boolean; overload;
    function SetBoolUniform(aName: string; aValue: Boolean): Boolean;
  end;

{ --- CONFIGFILE ------------------------------------------------------------ }
type
  { TConfigFile }
  TConfigFile = class(TBaseObject)
  protected
    FHandle: TIniFile;
    FFilename: string;
    FSection: TStringList;
  public
    property  Handle: TIniFile read FHandle;

    constructor Create; override;
    destructor Destroy; override;

    function  Open(aFilename: string=''): Boolean;
    procedure Close;
    function  IsOpen: Boolean;

    procedure Update;

    function  RemoveSection(aName: string): Boolean;

    procedure SetValue(aSection: string; aKey: string; aValue: string);  overload;
    procedure SetValue(aSection: string; aKey: string; aValue: Integer); overload;
    procedure SetValue(aSection: string; aKey: string; aValue: Boolean); overload;

    function  GetValue(aSection: string; aKey: string; aDefaultValue: string): string; overload;
    function  GetValue(aSection: string; aKey: string; aDefaultValue: Integer): Integer; overload;
    function  GetValue(aSection: string; aKey: string; aDefaultValue: Boolean): Boolean; overload;

    function  RemoveKey(aSection: string; aKey: string): Boolean;

    function  GetSectionValues(aSection: string): Integer;

    function  GetSectionValue(aIndex: Integer; aDefaultValue: string): string; overload;
    function  GetSectionValue(aIndex: Integer; aDefaultValue: Integer): Integer; overload;
    function  GetSectionValue(aIndex: Integer; aDefaultValue: Boolean): Boolean; overload;
  end;

{ --- ASYNC ----------------------------------------------------------------- }
type
  { TAsyncThread }
  TAsyncThread = class(TThread)
  protected
    FTask: TProc;
    FWait: TProc;
    FFinished: Boolean;
  public
    property TaskProc: TProc read FTask write FTask;
    property WaitProc: TProc read FWait write FWait;
    property Finished: Boolean read FFinished;
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Execute; override;
  end;

  { Async }
  Async = record
  private
    class var
      FCriticalSection: TCriticalSection;
      FQueue: TList<TAsyncThread>;
  public
    class procedure Setup; static;
    class procedure Shutdown; static;

    class procedure Run(aTask: TProc; aWait: TProc); static;

    class procedure Enter; static;
    class procedure Leave; static;

    class procedure Process; static;
  end;

{ --- GAME ------------------------------------------------------------------ }
type
  { TBaseGame }
  TBaseGame = class(TBaseObject)
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Run; virtual;
  end;

  { TCustomGame }
  TCustomGame = class(TBaseGame)
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Run; override;
    procedure OnLoad; virtual;
    procedure OnExit; virtual;
    procedure OnStartup; virtual;
    procedure OnShutdown; virtual;
    function  OnStartupDialogShow: Boolean; virtual;
    procedure OnStartupDialogMore; virtual;
    function  OnStartupDialogRun: Boolean; virtual;
    procedure OnProcessIMGUI; virtual;
    procedure OnDisplayOpenBefore; virtual;
    procedure OnDisplayOpenAfter; virtual;
    procedure OnDisplayCloseBefore; virtual;
    procedure OnDisplayCloseAfter; virtual;
    procedure OnDisplayReady(aReady: Boolean); virtual;
    procedure OnDisplayClear; virtual;
    procedure OnDisplayToggleFullscreen(aFullscreen: Boolean); virtual;
    procedure OnRender; virtual;
    procedure OnRenderHUD; virtual;
    procedure OnDisplayShow; virtual;
    procedure OnSpeechWord(const aWord: string; const aText: string); virtual;
    procedure OnUpdate(aDeltaTime: Double); virtual;
    procedure OnVideoFinished(const aFilename: string); virtual;
    procedure OnVideoLoad(const aFilename: string); virtual;
    procedure OnVideoUnload(const aFilename: string); virtual;
    procedure OnCmdConsoleOpen; virtual;
    procedure OnCmdConsoleClose; virtual;
  end;

  { TCustomGameClass }
  TCustomGameClass = class of TCustomGame;

{ --- ENGINE ---------------------------------------------------------------- }
type
  { TEngine }
  Engine = record
    private
      class var
        FGame: TCustomGame;
        FTerminate: Boolean;
        FArchivePassword: string;
        FArchiveFilename: string;
        FFIState: array[False..True] of ALLEGRO_STATE;
        FTimer: record
          LNow: Double;
          Passed: Double;
          Last: Double;
          Accumulator: Double;
          FrameAccumulator: Double;
          DeltaTime: Double;
          FrameCount: Cardinal;
          FrameRate: Cardinal;
          UpdateSpeed: Single;
        end;
      var
    public
      class var
        UserEventSrc: ALLEGRO_EVENT_SOURCE;
        CmdConActive: ALLEGRO_EVENT;
        CmdConInactive: ALLEGRO_EVENT;
        Queue: PALLEGRO_EVENT_QUEUE;
        Event: ALLEGRO_EVENT;
        Voice: PALLEGRO_VOICE;
        Mixer: PALLEGRO_MIXER;
        MouseState: ALLEGRO_MOUSE_STATE;
        KeyboardState: ALLEGRO_KEYBOARD_STATE;
        KeyCode: Integer;
        //StartupDialog: TStartupDialog;
      var
    private
      class procedure Setup; static;
      class procedure Shutdown; static;

      class procedure UpdateTiming; static;

    public
      class procedure EmitCmdConInactiveEvent; static;
      class procedure EmitCmdConActiveEvent; static;

      class procedure OnLoad; static;
      class procedure OnExit; static;
      class procedure OnStartup; static;
      class procedure OnShutdown; static;
      class function  OnStartupDialogShow: Boolean; static;
      class procedure OnStartupDialogMore; static;
      class function  OnStartupDialogRun: Boolean; static;
      class procedure OnProcessIMGUI; static;
      class procedure OnDisplayOpenBefore; static;
      class procedure OnDisplayOpenAfter; static;
      class procedure OnDisplayCloseBefore; static;
      class procedure OnDisplayCloseAfter; static;
      class procedure OnDisplayReady(aReady: Boolean); static;
      class procedure OnDisplayClear; static;
      class procedure OnDisplayToggleFullscreen(aFullscreen: Boolean); static;
      class procedure OnRender; static;
      class procedure OnRenderHUD; static;
      class procedure OnDisplayShow; static;
      class procedure OnSpeechWord(const aWord: string; const aText: string); static;
      class procedure OnUpdate(aDeltaTime: Double); static;
      class procedure OnVideoFinished(const aFilename: string); static;
      class procedure OnVideoLoad(const aFilename: string); static;
      class procedure OnVideoUnload(const aFilename: string); static;
      class procedure OnCmdConsoleOpen; static;
      class procedure OnCmdConsoleClose; static;

      class procedure CheckSingleInstance; static;

      class function  GetVersion: string; static;

      class function  GetTerminate: Boolean; static;
      class procedure SetTerminate(aTerminate: Boolean); static;

      class function  GetTime: Double; static;
      class procedure ResetTiming; static;

      class procedure SetUpdateSpeed(aSpeed: Single); static;
      class function  GetUpdateSpeed: Single; static;

      class function  GetDeltaTime: Double; static;
      class function  GetFrameRate: Cardinal; static;

      class function  FrameSpeed(var aTimer: Single; aSpeed: Single): Boolean; static;
      class function  FrameElapsed(var aTimer: Single; aFrames: Single): Boolean; static;

      class procedure EnablePhysFS(aEnable: Boolean); static;
      class function  OpenArchive(aFilename: string; aPassword: string=''): Boolean; static;
      class function  CloseArchive: Boolean; static;
      class function  GetArchivePassword: string; static;
      class function  GetArchiveItemFilename(aFilename: string): PAnsiChar; static;

      class procedure GameLoop; static;
      class procedure RunGame(aGame: TCustomGameClass); static;
  end;

implementation

{$R GameVision.Styles.res}

uses
  System.Math,
  System.IOUtils,
  WinApi.Windows,
  WinApi.MMSystem,
  GameVision.Utils,
  GameVision.Graphics,
  GameVision.Input,
  GameVision.UI;

{ --- MATH ------------------------------------------------------------------ }
{ TMath }
class procedure Math.Setup;
var
  I: Integer;
begin
  for I := 0 to 360 do
  begin
    FCosTable[I] := cos((I * PI / 180.0));
    FSinTable[I] := sin((I * PI / 180.0));
  end;

  Logger.Log('Initialized %s Subsystem', ['Math']);
end;

class procedure Math.Shutdown;
begin
  Logger.Log('Shutdown %s Subsystem', ['Math']);
end;

class procedure Math.Randomize;
begin
  System.Randomize;
end;

class function Math.RandomRange(aMin, aMax: Integer): Integer;
begin
  Result := System.Math.RandomRange(aMin, aMax + 1);
end;

class function Math.RandomRange(aMin, aMax: Single): Single;
var
  LN: Single;
begin
  LN := System.Math.RandomRange(0, MaxInt) / MaxInt;
  Result := aMin + (LN * (aMax - aMin));
end;

class function Math.RandomBool: Boolean;
begin
  Result := Boolean(System.Math.RandomRange(0, 2) = 1);
end;

class function Math.GetRandomSeed: Integer;
begin
  Result := RandSeed;
end;

class procedure Math.SetRandomSeed(aValue: Integer);
begin
  RandSeed := aValue;
end;

class function Math.AngleCos(aAngle: Integer): Single;
begin
  Result := 0;
  if (aAngle < 0) or (aAngle > 360) then Exit;
  Result := FCosTable[aAngle];
end;

class function Math.AngleSin(aAngle: Integer): Single;
begin
  Result := 0;
  if (aAngle < 0) or (aAngle > 360) then Exit;
  Result := FSinTable[aAngle];
end;

class function Math.AngleDifference(aSrcAngle: Single; aDestAngle: Single): Single;
var
  LC: Single;
begin
  LC := aDestAngle - aSrcAngle -
    (Floor((aDestAngle - aSrcAngle) / 360.0) * 360.0);

  if LC >= (360.0 / 2) then
  begin
    LC := LC - 360.0;
  end;
  Result := LC;
end;

class procedure Math.AngleRotatePos(aAngle: Single; var aX: Single; var aY: Single);
var
  LNX, LNY: Single;
  LIA: Integer;
begin
  ClipValue(aAngle, 0, 359, True);

  LIA := Round(aAngle);

  LNX := aX * FCosTable[LIA] - aY * FSinTable[LIA];
  LNY := aY * FCosTable[LIA] + aX * FSinTable[LIA];

  aX := LNX;
  aY := LNY;
end;

class function Math.ClipValue(var aValue: Single; aMin: Single; aMax: Single; aWrap: Boolean): Single;
begin
  if aWrap then
    begin
      if (aValue > aMax) then
      begin
        aValue := aMin + Abs(aValue - aMax);
        if aValue > aMax then
          aValue := aMax;
      end
      else if (aValue < aMin) then
      begin
        aValue := aMax - Abs(aValue - aMin);
        if aValue < aMin then
          aValue := aMin;
      end
    end
  else
    begin
      if aValue < aMin then
        aValue := aMin
      else if aValue > aMax then
        aValue := aMax;
    end;

  Result := aValue;

end;

class function Math.ClipValue(var aValue: Integer; aMin: Integer; aMax: Integer; aWrap: Boolean): Integer;
begin
  if aWrap then
    begin
      if (aValue > aMax) then
      begin
        aValue := aMin + Abs(aValue - aMax);
        if aValue > aMax then
          aValue := aMax;
      end
      else if (aValue < aMin) then
      begin
        aValue := aMax - Abs(aValue - aMin);
        if aValue < aMin then
          aValue := aMin;
      end
    end
  else
    begin
      if aValue < aMin then
        aValue := aMin
      else if aValue > aMax then
        aValue := aMax;
    end;

  Result := aValue;
end;

class function Math.SameSign(aValue1: Integer; aValue2: Integer): Boolean;
begin
  if Sign(aValue1) = Sign(aValue2) then
    Result := True
  else
    Result := False;
end;

class function Math.SameSign(aValue1: Single; aValue2: Single): Boolean;
begin
  if Sign(aValue1) = Sign(aValue2) then
    Result := True
  else
    Result := False;
end;

class function Math.SameValue(aA: Double; aB: Double; aEpsilon: Double = 0): Boolean;
begin
  Result := System.Math.SameValue(aA, aB, aEpsilon);
end;

class function Math.SameValue(aA: Single; aB: Single; aEpsilon: Single = 0): Boolean;
begin
  Result := System.Math.SameValue(aA, aB, aEpsilon);
end;

class function Math.Pointi(aX: Integer; aY: Integer): TPointi;
begin
  Result.X := aX;
  Result.Y := aY;
end;

class function Math.Pointf(aX: Single; aY: Single): TPointf;
begin
  Result.X := aX;
  Result.Y := aY;
end;

class function Math.Vector(aX: Single; aY: Single): TVector;
begin
  Result.X := aX;
  Result.Y := aY;
  Result.Z := 0;
end;

class function Math.Rectangle(aX: Single; aY: Single; aWidth: Single; aHeight: Single): TRectangle;
begin
  Result.X := aX;
  Result.Y := aY;
  Result.Width := aWidth;
  Result.Height := aHeight;
end;

class procedure Math.SmoothMove(var aValue: Single; aAmount: Single; aMax: Single; aDrag: Single);
var
  LAmt: Single;
begin
  LAmt := aAmount;

  if LAmt > 0 then
  begin
    aValue := aValue + LAmt;
    if aValue > aMax then
      aValue := aMax;
  end else if LAmt < 0 then
  begin
    aValue := aValue + LAmt;
    if aValue < -aMax then
      aValue := -aMax;
  end else
  begin
    if aValue > 0 then
    begin
      aValue := aValue - aDrag;
      if aValue < 0 then
        aValue := 0;
    end else if aValue < 0 then
    begin
      aValue := aValue + aDrag;
      if aValue > 0 then
        aValue := 0;
    end;
  end;
end;

{ TVector }
constructor TVector.Create(aX: Single; aY: Single);
begin
  Assign(aX, aY);
  Z := 0;
end;

procedure TVector.Assign(aX: Single; aY: Single);
begin
  X := aX;
  Y := aY;
end;

procedure TVector.Assign(aX: Single; aY: Single; aZ: Single);
begin
  X := aX;
  Y := aY;
  Z := aZ;
end;

procedure TVector.Clear;
begin
  X := 0;
  Y := 0;
  Z := 0;
end;

procedure TVector.Assign(aVector: TVector);
begin
  X := aVector.X;
  Y := aVector.Y;
end;

procedure TVector.Add(aVector: TVector);
begin
  X := X + aVector.X;
  Y := Y + aVector.Y;
end;

procedure TVector.Subtract(aVector: TVector);
begin
  X := X - aVector.X;
  Y := Y - aVector.Y;
end;

procedure TVector.Multiply(aVector: TVector);
begin
  X := X * aVector.X;
  Y := Y * aVector.Y;
end;

procedure TVector.Divide(aVector: TVector);
begin
  X := X / aVector.X;
  Y := Y / aVector.Y;

end;

function TVector.Magnitude: Single;
begin
  Result := Sqrt((X * X) + (Y * Y));
end;

function TVector.MagnitudeTruncate(aMaxMagitude: Single): TVector;
var
  LMaxMagSqrd: Single;
  LVecMagSqrd: Single;
  LTruc: Single;
begin
  Result.Assign(X, Y);
  LMaxMagSqrd := aMaxMagitude * aMaxMagitude;
  LVecMagSqrd := Result.Magnitude;
  if LVecMagSqrd > LMaxMagSqrd then
  begin
    LTruc := (aMaxMagitude / Sqrt(LVecMagSqrd));
    Result.X := Result.X * LTruc;
    Result.Y := Result.Y * LTruc;
  end;
end;

function TVector.Distance(aVector: TVector): Single;
var
  LDirVec: TVector;
begin
  LDirVec.X := X - aVector.X;
  LDirVec.Y := Y - aVector.Y;
  Result := LDirVec.Magnitude;
end;

procedure TVector.Normalize;
var
  LLen, LOOL: Single;
begin
  LLen := self.Magnitude;
  if LLen <> 0 then
  begin
    LOOL := 1.0 / LLen;
    X := X * LOOL;
    Y := Y * LOOL;
  end;
end;

function TVector.Angle(aVector: TVector): Single;
var
  LXOY: Single;
  LR: TVector;
begin
  LR.Assign(self);
  LR.Subtract(aVector);
  LR.Normalize;

  if LR.Y = 0 then
  begin
    LR.Y := 0.001;
  end;

  LXOY := LR.X / LR.Y;

  Result := ArcTan(LXOY) * RAD2DEG;
  if LR.Y < 0 then
    Result := Result + 180.0;

end;

procedure TVector.Thrust(aAngle: Single; aSpeed: Single);
var
  LA: Single;
begin
  LA := aAngle + 90.0;
  Math.ClipValue(LA, 0, 360, True);

  X := X + Math.AngleCos(Round(LA)) * -(aSpeed);
  Y := Y + Math.AngleSin(Round(LA)) * -(aSpeed);
end;

function TVector.MagnitudeSquared: Single;
begin
  Result := (X * X) + (Y * Y);
end;

function TVector.DotProduct(aVector: TVector): Single;
begin
  Result := (X * aVector.X) + (Y * aVector.Y);
end;

procedure TVector.Scale(aValue: Single);
begin
  X := X * aValue;
  Y := Y * aValue;
end;

procedure TVector.DivideBy(aValue: Single);
begin
  X := X / aValue;
  Y := Y / aValue;
end;

function TVector.Project(aVector: TVector): TVector;
var
  LDP: Single;
begin
  LDP := self.DotProduct(aVector);
  Result.X := (LDP / (aVector.X * aVector.X + aVector.Y * aVector.Y)) * aVector.X;
  Result.Y := (LDP / (aVector.X * aVector.X + aVector.Y * aVector.Y)) * aVector.Y;
end;

procedure TVector.Negate;
begin
  X := -X;
  Y := -Y;
end;

{ TRectangle }
constructor TRectangle.Create(aX: Single; aY: Single; aWidth: Single; aHeight: Single);
begin
  Assign(aX, aY, aWidth, aHeight);
end;

procedure TRectangle.Assign(aX: Single; aY: Single; aWidth: Single; aHeight: Single);
begin
  X := aX;
  Y := aY;
  Width := aWidth;
  Height := aHeight;
end;

function TRectangle.Intersect(aRect: TRectangle): Boolean;
var
  LR1R, LR1B: Single;
  LR2R, LR2B: Single;
begin
  LR1R := X - (Width - 1);
  LR1B := Y - (Height - 1);
  LR2R := aRect.X - (aRect.Width - 1);
  LR2B := aRect.Y - (aRect.Height - 1);

  Result := (X < LR2R) and (LR1R > aRect.X) and (Y < LR2B) and (LR1B > aRect.Y);
end;


{ --- EASING ---------------------------------------------------------------- }
{ TEase }
class function Ease.Value(aCurrentTime: Double; aStartValue: Double; aChangeInValue: Double; aDuration: Double; aEaseType: TEaseType): Double;
begin
  Result := 0;
  case aEaseType of
    etLinearTween:
      begin
        Result := aChangeInValue * aCurrentTime / aDuration + aStartValue;
      end;

    etInQuad:
      begin
        aCurrentTime := aCurrentTime / aDuration;
        Result := aChangeInValue * aCurrentTime * aCurrentTime + aStartValue;
      end;

    etOutQuad:
      begin
        aCurrentTime := aCurrentTime / aDuration;
        Result := -aChangeInValue * aCurrentTime * (aCurrentTime-2) + aStartValue;
      end;

    etInOutQuad:
      begin
        aCurrentTime := aCurrentTime / (aDuration / 2);
        if aCurrentTime < 1 then
          Result := aChangeInValue / 2 * aCurrentTime * aCurrentTime + aStartValue
        else
        begin
          aCurrentTime := aCurrentTime - 1;
          Result := -aChangeInValue / 2 * (aCurrentTime * (aCurrentTime - 2) - 1) + aStartValue;
        end;
      end;

    etInCubic:
      begin
        aCurrentTime := aCurrentTime / aDuration;
        Result := aChangeInValue * aCurrentTime * aCurrentTime * aCurrentTime + aStartValue;
      end;

    etOutCubic:
      begin
        aCurrentTime := (aCurrentTime / aDuration) - 1;
        Result := aChangeInValue * ( aCurrentTime * aCurrentTime * aCurrentTime + 1) + aStartValue;
      end;

    etInOutCubic:
      begin
        aCurrentTime := aCurrentTime / (aDuration/2);
        if aCurrentTime < 1 then
          Result := aChangeInValue / 2 * aCurrentTime * aCurrentTime * aCurrentTime + aStartValue
        else
        begin
          aCurrentTime := aCurrentTime - 2;
          Result := aChangeInValue / 2 * (aCurrentTime * aCurrentTime * aCurrentTime + 2) + aStartValue;
        end;
      end;

    etInQuart:
      begin
        aCurrentTime := aCurrentTime / aDuration;
        Result := aChangeInValue * aCurrentTime * aCurrentTime * aCurrentTime * aCurrentTime + aStartValue;
      end;

    etOutQuart:
      begin
        aCurrentTime := (aCurrentTime / aDuration) - 1;
        Result := -aChangeInValue * (aCurrentTime * aCurrentTime * aCurrentTime * aCurrentTime - 1) + aStartValue;
      end;

    etInOutQuart:
      begin
        aCurrentTime := aCurrentTime / (aDuration / 2);
        if aCurrentTime < 1 then
          Result := aChangeInValue / 2 * aCurrentTime * aCurrentTime * aCurrentTime * aCurrentTime + aStartValue
        else
        begin
          aCurrentTime := aCurrentTime - 2;
          Result := -aChangeInValue / 2 * (aCurrentTime * aCurrentTime * aCurrentTime * aCurrentTime - 2) + aStartValue;
        end;
      end;

    etInQuint:
      begin
        aCurrentTime := aCurrentTime / aDuration;
        Result := aChangeInValue * aCurrentTime * aCurrentTime * aCurrentTime * aCurrentTime * aCurrentTime + aStartValue;
      end;

    etOutQuint:
      begin
        aCurrentTime := (aCurrentTime / aDuration) - 1;
        Result := aChangeInValue * (aCurrentTime * aCurrentTime * aCurrentTime * aCurrentTime * aCurrentTime + 1) + aStartValue;
      end;

    etInOutQuint:
      begin
        aCurrentTime := aCurrentTime / (aDuration / 2);
        if aCurrentTime < 1 then
          Result := aChangeInValue / 2 * aCurrentTime * aCurrentTime * aCurrentTime * aCurrentTime * aCurrentTime + aStartValue
        else
        begin
          aCurrentTime := aCurrentTime - 2;
          Result := aChangeInValue / 2 * (aCurrentTime * aCurrentTime * aCurrentTime * aCurrentTime * aCurrentTime + 2) + aStartValue;
        end;
      end;

    etInSine:
      begin
        Result := -aChangeInValue * Cos(aCurrentTime / aDuration * (PI / 2)) + aChangeInValue + aStartValue;
      end;

    etOutSine:
      begin
        Result := aChangeInValue * Sin(aCurrentTime / aDuration * (PI / 2)) + aStartValue;
      end;

    etInOutSine:
      begin
        Result := -aChangeInValue / 2 * (Cos(PI * aCurrentTime / aDuration) - 1) + aStartValue;
      end;

    etInExpo:
      begin
        Result := aChangeInValue * Power(2, 10 * (aCurrentTime/aDuration - 1) ) + aStartValue;
      end;

    etOutExpo:
      begin
        Result := aChangeInValue * (-Power(2, -10 * aCurrentTime / aDuration ) + 1 ) + aStartValue;
      end;

    etInOutExpo:
      begin
        aCurrentTime := aCurrentTime / (aDuration/2);
        if aCurrentTime < 1 then
          Result := aChangeInValue / 2 * Power(2, 10 * (aCurrentTime - 1) ) + aStartValue
        else
         begin
           aCurrentTime := aCurrentTime - 1;
           Result := aChangeInValue / 2 * (-Power(2, -10 * aCurrentTime) + 2 ) + aStartValue;
         end;
      end;

    etInCircle:
      begin
        aCurrentTime := aCurrentTime / aDuration;
        Result := -aChangeInValue * (Sqrt(1 - aCurrentTime * aCurrentTime) - 1) + aStartValue;
      end;

    etOutCircle:
      begin
        aCurrentTime := (aCurrentTime / aDuration) - 1;
        Result := aChangeInValue * Sqrt(1 - aCurrentTime * aCurrentTime) + aStartValue;
      end;

    etInOutCircle:
      begin
        aCurrentTime := aCurrentTime / (aDuration / 2);
        if aCurrentTime < 1 then
          Result := -aChangeInValue / 2 * (Sqrt(1 - aCurrentTime * aCurrentTime) - 1) + aStartValue
        else
        begin
          aCurrentTime := aCurrentTime - 2;
          Result := aChangeInValue / 2 * (Sqrt(1 - aCurrentTime * aCurrentTime) + 1) + aStartValue;
        end;
      end;
  end;
end;

class function Ease.Position(aStartPos: Double; aEndPos: Double; aCurrentPos: Double; aEaseType: TEaseType): Double;
var
  LT, LB, LC, LD: Double;
begin
  LC := aEndPos - aStartPos;
  LD := 100;
  LT := aCurrentPos;
  LB := aStartPos;
  Result := Value(LT, LB, LC, LD, aEaseType);
  if Result > 100 then
    Result := 100;
end;

{ --- COLLISION ------------------------------------------------------------- }
{ Collision }
class function Collision.PointInRectangle(aPoint: TVector; aRect: TRectangle): Boolean;
begin
  if ((aPoint.x >= aRect.x) and (aPoint.x <= (aRect.x + aRect.width)) and
    (aPoint.y >= aRect.y) and (aPoint.y <= (aRect.y + aRect.height))) then
    Result := True
  else
    Result := False;
end;

class function Collision.PointInCircle(aPoint: TVector; aCenter: TVector; aRadius: Single): Boolean;
begin
  Result := CirclesOverlap(aPoint, 0, aCenter, aRadius);
end;

class function Collision.PointInTriangle(aPoint: TVector; aP1: TVector; aP2: TVector; aP3: TVector): Boolean;
var
  LAlpha, LBeta, LGamma: Single;
begin
  LAlpha := ((aP2.y - aP3.y) * (aPoint.x - aP3.x) + (aP3.x - aP2.x) *
    (aPoint.y - aP3.y)) / ((aP2.y - aP3.y) * (aP1.x - aP3.x) + (aP3.x - aP2.x) *
    (aP1.y - aP3.y));

  LBeta := ((aP3.y - aP1.y) * (aPoint.x - aP3.x) + (aP1.x - aP3.x) *
    (aPoint.y - aP3.y)) / ((aP2.y - aP3.y) * (aP1.x - aP3.x) + (aP3.x - aP2.x) *
    (aP1.y - aP3.y));

  LGamma := 1.0 - LAlpha - LBeta;

  if ((LAlpha > 0) and (LBeta > 0) and (LGamma > 0)) then
    Result := True
  else
    Result := False;
end;

class function Collision.CirclesOverlap(aCenter1: TVector; aRadius1: Single; aCenter2: TVector; aRadius2: Single): Boolean;
var
  LDX, LDY, LDistance: Single;
begin
  LDX := aCenter2.x - aCenter1.x; // X distance between centers
  LDY := aCenter2.y - aCenter1.y; // Y distance between centers

  LDistance := sqrt(LDX * LDX + LDY * LDY); // Distance between centers

  if (LDistance <= (aRadius1 + aRadius2)) then
    Result := True
  else
    Result := False;
end;

class function Collision.CircleInRectangle(aCenter: TVector; aRadius: Single; aRect: TRectangle): Boolean;
var
  LDX, LDY: Single;
  LCornerDistanceSq: Single;
  LRecCenterX: Integer;
  LRecCenterY: Integer;
begin
  LRecCenterX := Round(aRect.x + aRect.width / 2);
  LRecCenterY := Round(aRect.y + aRect.height / 2);

  LDX := abs(aCenter.x - LRecCenterX);
  LDY := abs(aCenter.y - LRecCenterY);

  if (LDX > (aRect.width / 2.0 + aRadius)) then
  begin
    Result := False;
    Exit;
  end;

  if (LDY > (aRect.height / 2.0 + aRadius)) then
  begin
    Result := False;
    Exit;
  end;

  if (LDX <= (aRect.width / 2.0)) then
  begin
    Result := True;
    Exit;
  end;
  if (LDY <= (aRect.height / 2.0)) then
  begin
    Result := True;
    Exit;
  end;

  LCornerDistanceSq := (LDX - aRect.width / 2.0) * (LDX - aRect.width / 2.0) +
    (LDY - aRect.height / 2.0) * (LDY - aRect.height / 2.0);

  Result := Boolean(LCornerDistanceSq <= (aRadius * aRadius));
end;

class function Collision.RectanglesOverlap(aRect1: TRectangle; aRect2: TRectangle): Boolean;
var
  LDX, LDY: Single;
begin
  LDX := abs((aRect1.x + aRect1.width / 2) - (aRect2.x + aRect2.width / 2));
  LDY := abs((aRect1.y + aRect1.height / 2) - (aRect2.y + aRect2.height / 2));

  if ((LDX <= (aRect1.width / 2 + aRect2.width / 2)) and
    ((LDY <= (aRect1.height / 2 + aRect2.height / 2)))) then
    Result := True
  else
    Result := False;
end;

class function Collision.RectangleIntersection(aRect1, aRect2: TRectangle): TRectangle;
var
  LDXX, LDYY: Single;
begin
  Result.Assign(0, 0, 0, 0);

  if RectanglesOverlap(aRect1, aRect2) then
  begin
    LDXX := abs(aRect1.x - aRect2.x);
    LDYY := abs(aRect1.y - aRect2.y);

    if (aRect1.x <= aRect2.x) then
    begin
      if (aRect1.y <= aRect2.y) then
      begin
        Result.x := aRect2.x;
        Result.y := aRect2.y;
        Result.width := aRect1.width - LDXX;
        Result.height := aRect1.height - LDYY;
      end
      else
      begin
        Result.x := aRect2.x;
        Result.y := aRect1.y;
        Result.width := aRect1.width - LDXX;
        Result.height := aRect2.height - LDYY;
      end
    end
    else
    begin
      if (aRect1.y <= aRect2.y) then
      begin
        Result.x := aRect1.x;
        Result.y := aRect2.y;
        Result.width := aRect2.width - LDXX;
        Result.height := aRect1.height - LDYY;
      end
      else
      begin
        Result.x := aRect1.x;
        Result.y := aRect1.y;
        Result.width := aRect2.width - LDXX;
        Result.height := aRect2.height - LDYY;
      end
    end;

    if (aRect1.width > aRect2.width) then
    begin
      if (Result.width >= aRect2.width) then
        Result.width := aRect2.width;
    end
    else
    begin
      if (Result.width >= aRect1.width) then
        Result.width := aRect1.width;
    end;

    if (aRect1.height > aRect2.height) then
    begin
      if (Result.height >= aRect2.height) then
        Result.height := aRect2.height;
    end
    else
    begin
      if (Result.height >= aRect1.height) then
        Result.height := aRect1.height;
    end
  end;
end;

class function Collision.LineIntersection(aX1, aY1, aX2, aY2, aX3, aY3, aX4, aY4: Integer; var aX: Integer; var aY: Integer): TLineIntersection;
var
  LAX, LBX, LCX, LAY, LBY, LCY, LD, LE, LF, LNum: Integer;
  LOffset: Integer;
  LX1Lo, LX1Hi, LY1Lo, LY1Hi: Integer;
begin
  Result := liNone;

  LAX := aX2 - aX1;
  LBX := aX3 - aX4;

  if (LAX < 0) then // X bound box test
  begin
    LX1Lo := aX2;
    LX1Hi := aX1;
  end
  else
  begin
    LX1Hi := aX2;
    LX1Lo := aX1;
  end;

  if (LBX > 0) then
  begin
    if (LX1Hi < aX4) or (aX3 < LX1Lo) then
      Exit;
  end
  else
  begin
    if (LX1Hi < aX3) or (aX4 < LX1Lo) then
      Exit;
  end;

  LAY := aY2 - aY1;
  LBY := aY3 - aY4;

  if (LAY < 0) then // Y bound box test
  begin
    LY1Lo := aY2;
    LY1Hi := aY1;
  end
  else
  begin
    LY1Hi := aY2;
    LY1Lo := aY1;
  end;

  if (LBY > 0) then
  begin
    if (LY1Hi < aY4) or (aY3 < LY1Lo) then
      Exit;
  end
  else
  begin
    if (LY1Hi < aY3) or (aY4 < LY1Lo) then
      Exit;
  end;

  LCX := aX1 - aX3;
  LCY := aY1 - aY3;
  LD := LBY * LCX - LBX * LCY; // alpha numerator
  LF := LAY * LBX - LAX * LBY; // both denominator

  if (LF > 0) then // alpha tests
  begin
    if (LD < 0) or (LD > LF) then
      Exit;
  end
  else
  begin
    if (LD > 0) or (LD < LF) then
      Exit
  end;

  LE := LAX * LCY - LAY * LCX; // beta numerator
  if (LF > 0) then // beta tests
  begin
    if (LE < 0) or (LE > LF) then
      Exit;
  end
  else
  begin
    if (LE > 0) or (LE < LF) then
      Exit;
  end;

  // compute intersection coordinates

  if (LF = 0) then
  begin
    Result := liParallel;
    Exit;
  end;

  LNum := LD * LAX; // numerator
  // if SameSigni(num, f) then
  if Sign(LNum) = Sign(LF) then

    LOffset := LF div 2
  else
    LOffset := -LF div 2;
  aX := aX1 + (LNum + LOffset) div LF; // intersection x

  LNum := LD * LAY;
  // if SameSigni(num, f) then
  if Sign(LNum) = Sign(LF) then
    LOffset := LF div 2
  else
    LOffset := -LF div 2;

  aY := aY1 + (LNum + LOffset) div LF; // intersection y

  Result := liTrue;
end;

class function Collision.RadiusOverlap(aRadius1: Single; aX1: Single; aY1: Single; aRadius2: Single; aX2: Single; aY2: Single; aShrinkFactor: Single): Boolean;

var
  LDist: Single;
  LR1, LR2: Single;
  LV1, LV2: TVector;
begin
  LR1 := aRadius1 * aShrinkFactor;
  LR2 := aRadius2 * aShrinkFactor;

  LV1.x := aX1;
  LV1.y := aY1;
  LV2.x := aX2;
  LV2.y := aY2;

  LDist := LV1.distance(LV2);

  if (LDist < LR1) or (LDist < LR2) then
    Result := True
  else
    Result := False;
end;

{ --- BUFFER ---------------------------------------------------------------- }
{ TBuffer }
constructor TBuffer.Create(aSize: Integer);
var
  LPtr: Pointer;
begin
  inherited Create;

  FName := TPath.GetGUIDFileName;
  FHandle := CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, aSize, PChar(FName));
  if FHandle = 0 then
    begin
      raise EBufferException.Create('Error creating memory mapping');
      FHandle := 0;
      Destroy;
    end
  else
    begin
      LPtr := MapViewOfFile(FHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0);
      if LPtr = nil then
        begin
          raise EBufferException.Create('Error creating memory mapping');
          Destroy;
        end
      else
        begin
          Self.SetPointer(LPtr, aSize);
          Position := 0;
        end;
    end;
end;

destructor TBuffer.Destroy;
begin
  if (Memory <> nil) then
  begin
    if not UnmapViewOfFile(Memory) then
      raise EBufferException.Create('Error deallocating mapped memory');
  end;

  if (FHandle <> 0) then
  begin
    if not CloseHandle(FHandle) then
      raise EBufferException.Create('Error freeing memory mapping handle');
  end;

  inherited;
end;

function TBuffer.Write(const aBuffer; aCount: Longint): Longint;
var
  LPos: Int64;
begin
  if (Position >= 0) and (aCount >= 0) then
  begin
    LPos := Position + aCount;
    if LPos > 0 then
    begin
      if LPos > Size then
      begin
        Result := 0;
        Exit;
      end;
      System.Move(aBuffer, (PByte(Memory) + Position)^, aCount);
      Position := LPos;
      Result := aCount;
      Exit;
    end;
  end;
  Result := 0;
end;

function TBuffer.Write(const aBuffer: TBytes; aOffset, aCount: Longint): Longint;
var
  LPos: Int64;
begin
  if (Position >= 0) and (aCount >= 0) then
  begin
    LPos := Position + aCount;
    if LPos > 0 then
    begin
      if LPos > Size then
      begin
        Result := 0;
        Exit;
      end;
      System.Move(aBuffer[aOffset], (PByte(Memory) + Position)^, aCount);
      Position := LPos;
      Result := aCount;
      Exit;
    end;
  end;
  Result := 0;
end;

procedure TBuffer.SaveToFile(aFilename: string);
var
  LFileStream: TFileStream;
begin
  LFileStream := TFile.Create(aFilename);
  try
    LFileStream.Write(Memory^, Size);
  finally
    LFileStream.Free;
  end;
end;

class function TBuffer.FromFile(aFilename: string): TBuffer;
var
  LMarshaller: TMarshaller;
  LStream: PALLEGRO_FILE;
  LSize: Int64;
begin
  Result := nil;
  if aFilename.IsEmpty then Exit;
  if not al_filename_exists(LMarshaller.AsAnsi(aFilename).ToPointer) then Exit;
  //LStream := al_fopen(LMarshaller.AsAnsi(Engine.GetArchiveFilenameWithPassword(aFilename)).ToPointer, 'rb');
  LStream := al_fopen(Engine.GetArchiveItemFilename(aFilename), 'rb');
  try
    LSize := al_fsize(LStream);
    Result := TBuffer.Create(LSize);
    al_fread(LStream, Result.Memory, LSize);
  finally
    al_fclose(LStream);
  end;
end;

{ --- LOGGER ---------------------------------------------------------------- }
{ TLogger }
class procedure Logger.Open(aFilename: string);
begin
  if FOpen then Exit;

  FFormatSettings.DateSeparator := '/';
  FFormatSettings.TimeSeparator := ':';
  FFormatSettings.ShortDateFormat := 'DD-MM-YYY HH:NN:SS';
  FFormatSettings.ShortTimeFormat := 'HH:NN:SS';

  if aFilename.IsEmpty then
  begin
    aFilename := ChangeFileExt(ParamStr(0), '.'+cLogExt);
  end;
  AssignFile(FText, aFilename);
  ReWrite(FText);
  SetTextBuf(FText, FBuffer);
  FOpen := True;
  FFilename := aFilename;
end;

class procedure Logger.Close;
begin
  if not FOpen then Exit;
  CloseFile(FText);
  FOpen := False;
end;

class procedure Logger.Log(const aMsg: string; const aArgs: array of const);
var
  LLine: string;
begin
  // get line
  LLine := Format(aMsg, aArgs);

  // write to console
  if HasConsoleOutput then
    WriteLn(LLine);

  // write to logfile
  {$I-}
  LLine := Format('%s %s', [DateTimeToStr(Now, FFormatSettings), LLine]);
  Writeln(FText, LLine);
  Flush(FText);
  {$I+}
end;

class procedure Logger.Exception(const aMsg: string; const aArgs: array of const);
var
  LMsg: string;
begin
  LMsg := Format(aMsg, aArgs);
  Log(LMsg, []);
  raise System.SysUtils.Exception.Create(LMsg);
end;

{ --- SHADER ---------------------------------------------------------------- }
constructor TShader.Create;
begin
  inherited;
  FHandle := nil;
  FName := '';
end;

destructor TShader.Destroy;
begin
  Unload;
  inherited;
end;

function TShader.Load(const aBaseFilename: string): Boolean;
var
  LMarshaller: TMarshaller;
  LVSFilename: string;
  LPSFilename: string;
begin
  Result := False;
  if FHandle <> nil then Exit;

  LVSFilename := aBaseFilename + '_vertex.hlsl';
  if not al_filename_exists(LMarshaller.AsAnsi(LVSFilename).ToPointer) then Exit;
  LPSFilename := aBaseFilename + '_pixel.hlsl';
  if not al_filename_exists(LMarshaller.AsAnsi(LPSFilename).ToPointer) then Exit;

  Unload;
  FHandle := al_create_shader(ALLEGRO_SHADER_HLSL);
  if FHandle = nil then Exit;
  //if al_attach_shader_source_file(FHandle, ALLEGRO_VERTEX_SHADER, LMarshaller.AsAnsi(Engine.GetArchiveFilenameWithPassword(LVSFilename)).ToPointer) then
  if al_attach_shader_source_file(FHandle, ALLEGRO_VERTEX_SHADER, Engine.GetArchiveItemFilename(LVSFilename)) then
  begin
    //if al_attach_shader_source_file(FHandle, ALLEGRO_PIXEL_SHADER, LMarshaller.AsAnsi(Engine.GetArchiveFilenameWithPassword(LPSFilename)).ToPointer) then
    if al_attach_shader_source_file(FHandle, ALLEGRO_PIXEL_SHADER, Engine.GetArchiveItemFilename(LPSFilename)) then
    begin
      if al_build_shader(FHandle) then
      begin
        FName := aBaseFilename;
        Result := True;
      end;
    end;
  end;

  if Result then
    begin
      Logger.Log('Succesfully loaded vertex shader: "%s"', [LVSFilename]);
      Logger.Log('Succesfully loaded pixel shader: "%s"', [LPSFilename]);
      Logger.Log('Built shader: "%s"', [FName]);
    end
  else
    begin
      Unload;
    end;
end;

function TShader.Unload: Boolean;
begin
  Result := False;
  if FHandle = nil then Exit;
  al_use_shader(nil);
  al_destroy_shader(FHandle);
  FHandle := nil;
  FName := '';
end;

function TShader.Enable(aEnable: Boolean): Boolean;
begin
  Result := False;
  if FHandle = nil then Exit;
  if aEnable then
    al_use_shader(FHandle)
  else
    al_use_shader(nil);
end;

function TShader.Log: string;
begin
  Result := '';
  if FHandle = nil then Exit;
  Result := string(al_get_shader_log(FHandle));
end;

function TShader.SetIntUniform(aName: string; aValue: Integer): Boolean;
var
  LMarshaller: TMarshaller;
begin
  Result := False;
  if aName.IsEmpty then Exit;
  if FHandle = nil then Exit;
  Result := al_set_shader_int(LMarshaller.AsAnsi(aName).ToPointer, aValue);
end;

function TShader.SetIntUniform(aName: string; aNumComponents: Integer; aValue: PInteger; aNumElements: Integer): Boolean;
var
  LMarshaller: TMarshaller;
begin
  Result := False;
  if aName.IsEmpty then Exit;
  if FHandle = nil then Exit;
  Result := al_set_shader_int_vector(LMarshaller.AsAnsi(aName).ToPointer, aNumComponents, aValue, aNumElements);
end;

function TShader.SetFloatUniform(aName: string; aValue: Single): Boolean;
var
  LMarshaller: TMarshaller;
begin
  Result := False;
  if aName.IsEmpty then Exit;
  if FHandle = nil then Exit;
  Result := al_set_shader_float(LMarshaller.AsAnsi(aName).ToPointer, aValue);
end;

function TShader.SetFloatUniform(aName: string; aNumComponents: Integer; aValue: System.PSingle; aNumElements: Integer): Boolean;
var
  LMarshaller: TMarshaller;
begin
  Result := False;
  if aName.IsEmpty then Exit;
  if FHandle = nil then Exit;
  Result := al_set_shader_float_vector(LMarshaller.AsAnsi(aName).ToPointer, aNumComponents, aValue, aNumElements);
end;

function TShader.SetBoolUniform(aName: string; aValue: Boolean): Boolean;
var
  LMarshaller: TMarshaller;
begin
  Result := False;
  if aName.IsEmpty then Exit;
  if FHandle = nil then Exit;
  Result := al_set_shader_bool(LMarshaller.AsAnsi(aName).ToPointer, aValue);
end;

{ --- CONFIGFILE ------------------------------------------------------------ }
{ TConfigFile }
constructor TConfigFile.Create;
begin
  inherited;

  FHandle := nil;
  FSection := TStringList.Create;
end;

destructor TConfigFile.Destroy;
begin
  Close;
  FreeAndNil(FSection);

  inherited;
end;

function TConfigFile.Open(aFilename: string): Boolean;
var
  LFilename: string;
begin
  Result := False;
  if IsOpen then Exit;
  LFilename := aFilename;
  if LFilename.IsEmpty then LFilename := TPath.ChangeExtension(ParamStr(0), cCfgExt);
  FHandle := TIniFile.Create(LFilename);
  Result := Boolean(FHandle <> nil);
  FFilename := LFilename;
end;

procedure TConfigFile.Close;
begin
  if not IsOpen then Exit;
  FHandle.UpdateFile;
  FreeAndNil(FHandle);
end;

function TConfigFile.IsOpen: Boolean;
begin
  Result := Boolean(FHandle <> nil);
end;

procedure TConfigFile.Update;
begin
  if not IsOpen then Exit;
  FHandle.UpdateFile;
end;

function TConfigFile.RemoveSection(aName: string): Boolean;
var
  LName: string;
begin
  Result := False;
  if FHandle = nil then Exit;
  LName := aName;
  if LName.IsEmpty then Exit;
  FHandle.EraseSection(LName);
  Result := True;
end;

procedure TConfigFile.SetValue(aSection: string; aKey: string; aValue: string);
begin
  if FHandle = nil then Exit;
  FHandle.WriteString(aSection, aKey, aValue);
end;

procedure TConfigFile.SetValue(aSection: string; aKey: string; aValue: Integer);
begin
  SetValue(aSection, aKey, aValue.ToString);
end;

procedure TConfigFile.SetValue(aSection: string; aKey: string; aValue: Boolean);
begin
  SetValue(aSection, aKey, aValue.ToInteger);
end;

function TConfigFile.GetValue(aSection: string; aKey: string; aDefaultValue: string): string;
begin
  Result := '';
  if FHandle = nil then Exit;
  Result := FHandle.ReadString(aSection, aKey, aDefaultValue);
end;

function TConfigFile.GetValue(aSection: string; aKey: string; aDefaultValue: Integer): Integer;
var
  LResult: string;
begin
  LResult := GetValue(aSection, aKey, aDefaultValue.ToString);
  Integer.TryParse(LResult, Result);
end;

function TConfigFile.GetValue(aSection: string; aKey: string; aDefaultValue: Boolean): Boolean;
begin
  Result := GetValue(aSection, aKey, aDefaultValue.ToInteger).ToBoolean;
end;

function TConfigFile.RemoveKey(aSection: string; aKey: string): Boolean;
var
  LSection: string;
  LKey: string;
begin
  Result := False;
  if FHandle = nil then Exit;
  LSection := aSection;
  LKey := aKey;
  if LSection.IsEmpty then Exit;
  if LKey.IsEmpty then Exit;
  FHandle.DeleteKey(LSection, LKey);
  Result := True;
end;

function TConfigFile.GetSectionValues(aSection: string): Integer;
var
  LSection: string;
begin
  Result := 0;
  if LSection.IsEmpty then Exit;
  LSection := aSection;
  FSection.Clear;
  FHandle.ReadSectionValues(LSection, FSection);
  Result := FSection.Count;
end;

function TConfigFile.GetSectionValue(aIndex: Integer; aDefaultValue: string): string;
begin
  Result := '';
  if (aIndex < 0) or (aIndex > FSection.Count - 1) then Exit;
  Result := FSection.ValueFromIndex[aIndex];
  if Result.IsEmpty then Result := aDefaultValue;
end;

function TConfigFile.GetSectionValue(aIndex: Integer; aDefaultValue: Integer): Integer;
begin
  Result := GetSectionValue(aIndex, aDefaultValue.ToString).ToInteger
end;

function TConfigFile.GetSectionValue(aIndex: Integer; aDefaultValue: Boolean): Boolean;
begin
  Result := GetSectionValue(aIndex, aDefaultValue.ToString).ToBoolean
end;

{ --- ASYNC ----------------------------------------------------------------- }
{ TAsyncThread }
constructor TAsyncThread.Create;
begin
  inherited Create(True);

  FTask := nil;
  FWait := nil;
  FFinished := False;
end;

destructor TAsyncThread.Destroy;
begin

  inherited;
end;

procedure TAsyncThread.Execute;
begin
  FFinished := False;

  if Assigned(FTask) then
  begin
    FTask();
  end;

  FFinished := True;
end;


{ Async }
class procedure Async.Setup;
begin
  FCriticalSection := TCriticalSection.Create;
  FQueue := TList<TAsyncThread>.Create;
end;

class procedure Async.Shutdown;
begin
  FreeAndNil(FQueue);
  FreeAndNil(FCriticalSection);
end;

class procedure Async.Run(aTask: TProc; aWait: TProc);
var
  LAsyncThread: TAsyncThread;
begin
  if not Assigned(aTask) then Exit;
  //Enter;
  LAsyncThread := TAsyncThread.Create;
  LAsyncThread.TaskProc := aTask;
  if Assigned(aWait) then LAsyncThread.WaitProc := aWait;
  FQueue.Add(LAsyncThread);
  LAsyncThread.Start;
  //Leave;
end;

class procedure Async.Process;
var
  LAsyncThread: TAsyncThread;
begin
  Enter;

  if TThread.CurrentThread.ThreadID = MainThreadID then
  begin
    for LAsyncThread in FQueue do
    begin
      if Assigned(LAsyncThread) then
      begin
        if LAsyncThread.Finished then
        begin
          LAsyncThread.WaitFor;
          if Assigned(LAsyncThread.WaitProc) then
            LAsyncThread.WaitProc();
          FQueue.Remove(LAsyncThread);
          FreeAndNil(LAsyncThread);
        end;
      end;
    end;
    FQueue.Pack;
  end;

  Leave;
end;

class procedure Async.Enter;
begin
  FCriticalSection.Enter;
end;

class procedure Async.Leave;
begin
  FCriticalSection.Leave;
end;

{ --- GAME ------------------------------------------------------------------ }
{ TBaseGame }
constructor TBaseGame.Create;
begin
  inherited;
end;

destructor TBaseGame.Destroy;
begin
  inherited;
end;

procedure TBaseGame.Run;
begin
end;


{ TCustomGame }
constructor TCustomGame.Create;
begin
  inherited;

end;

destructor TCustomGame.Destroy;
begin

  inherited;
end;

procedure TCustomGame.Run;
var
  LQuit: Boolean;
begin
  try
    OnLoad;
    if OnStartupDialogShow then
      begin
        LQuit := False;
        repeat
          case StartupDialog.Show of
            sdsMore:
              begin
                OnStartupDialogMore;
              end;
            sdsRun:
              begin
                if OnStartupDialogRun then
                  Engine.GameLoop;
              end;
            sdsQuit:
              begin
                LQuit := True;
              end;
          end;
        until LQuit;
      end
    else
      begin
        Engine.GameLoop;
      end;
  finally
    OnExit;
  end;
end;

procedure TCustomGame.OnLoad;
begin
end;

procedure TCustomGame.OnExit;
begin
end;

procedure TCustomGame.OnStartup;
begin
end;

procedure TCustomGame.OnShutdown;
begin
end;

function  TCustomGame.OnStartupDialogShow: Boolean;
begin
  Result := False;
end;

procedure TCustomGame.OnStartupDialogMore;
begin
end;

function  TCustomGame.OnStartupDialogRun: Boolean;
begin
  Result := False;
end;

procedure TCustomGame.OnProcessIMGUI;
begin
end;

procedure TCustomGame.OnDisplayOpenBefore;
begin
end;

procedure TCustomGame.OnDisplayOpenAfter;
begin
end;

procedure TCustomGame.OnDisplayCloseBefore;
begin
end;

procedure TCustomGame.OnDisplayCloseAfter;
begin
end;

procedure TCustomGame.OnDisplayReady(aReady: Boolean);
begin
end;

procedure TCustomGame.OnDisplayClear;
begin
end;

procedure TCustomGame.OnDisplayToggleFullscreen(aFullscreen: Boolean);
begin
end;

procedure TCustomGame.OnRender;
begin
end;

procedure TCustomGame.OnRenderHUD;
begin
end;

procedure TCustomGame.OnDisplayShow;
begin
end;

procedure TCustomGame.OnSpeechWord(const aWord: string; const aText: string);
begin
end;

procedure TCustomGame.OnUpdate(aDeltaTime: Double);
begin
end;

procedure TCustomGame.OnVideoFinished(const aFilename: string);
begin
end;

procedure TCustomGame.OnVideoLoad(const aFilename: string);
begin
end;

procedure TCustomGame.OnVideoUnload(const aFilename: string);
begin
end;

procedure TCustomGame.OnCmdConsoleOpen;
begin
end;

procedure TCustomGame.OnCmdConsoleClose;
begin
end;

{ --- ENGINE ---------------------------------------------------------------- }
{ Engine }
class procedure Engine.Setup;
begin
  Logger.Log('Initializing %s v%s', [GAMEVISION_DESCRIPTION, GAMEVISION_VERSION]);

  LoadAllegroDLL;

  //al_set_config_value(al_get_system_config(), 'trace', 'level', 'debug');

  if al_is_system_installed then Exit;

  // init allegro
  if al_install_system(ALLEGRO_VERSION_INT, nil) then
    Logger.Log('Sucessfully initialized Allegro', [])
  else
    Logger.Log('Was not able initialized Allegro', []);

  // init addons
  if al_init_video_addon then Logger.Log('Sucessfully initialized Allegro Video addon', []) else Logger.Log('Failed to initialize Allegro Video addon', []);
  if al_init_font_addon then Logger.Log('Sucessfully initialized Allegro Font addon', []) else Logger.Log('Failed to initialize Allegro Font addon', []);
  if al_init_ttf_addon then Logger.Log('Sucessfully initialized Allegro TTF addon', []) else Logger.Log('Failed to initialize Allegro TTF addon', []);
  if al_init_primitives_addon then Logger.Log('Sucessfully initialized Allegro Primitives addon', []) else Logger.Log('Failed to initialize Allegro Primitives addon', []);
  if al_init_native_dialog_addon then Logger.Log('Sucessfully initialized Allegro Native Dialog addon', []) else Logger.Log('Failed to initialize Allegro Native Dialog addon', []);
  if al_init_image_addon then Logger.Log('Sucessfully initialized Allegro Image addon', []) else Logger.Log('Failed to initialize Allegro Image addon', []);

  // install devices
  if al_install_keyboard then Logger.Log('Sucessfully installed Allegro keyboard support', []) else Logger.Log('Failed to install Allegro keyboard support', []);
  if al_install_mouse then Logger.Log('Sucessfully initialized Allegro mouse support', []) else Logger.Log('Failed to install Allegro mouse support', []);
  if al_install_joystick then
  begin
    Logger.Log('Sucessfully initialized Allegro joystick support', []);
    Input.Joystick.Setup(0);
    Logger.Log('Setup default joystick', []);
  end
  else
    Logger.Log('Failed to install Allegro joystick support', []);

  // int user event source
  al_init_user_event_source(@UserEventSrc);

  // init event queues
  Queue := al_create_event_queue;
  al_register_event_source(Queue, al_get_keyboard_event_source);
  al_register_event_source(Queue, al_get_mouse_event_source);
  al_register_event_source(Queue, al_get_joystick_event_source);
  al_register_event_source(Queue , @UserEventSrc);
  Logger.Log('Registered Allegro event queues', []);

  CmdConActive.&type := EVENT_CMDCON_ACTIVE;
  CmdConInactive.&type := EVENT_CMDCON_INACTIVE;

  // init audio
  if not al_is_audio_installed then
  begin
    // init audio
    if al_install_audio then Logger.Log('Sucessfully initialized Allegro audio', []);
    if al_init_acodec_addon then Logger.Log('Sucessfully initialized Allegro audio codec addon', []);
    Voice := al_create_voice(44100, ALLEGRO_AUDIO_DEPTH_INT16,  ALLEGRO_CHANNEL_CONF_2);
    if Voice <> nil then Logger.Log('Sucessfully created Allegro default voice', []) else Logger.Log('Failed to create Allegro default voice', []);
    Mixer := al_create_mixer(44100, ALLEGRO_AUDIO_DEPTH_FLOAT32,  ALLEGRO_CHANNEL_CONF_2);
    if Mixer <> nil then Logger.Log('Sucessfully created Allegro default mixer', []) else Logger.Log('Failed to createAllegro default mixer', []);
    if al_set_default_mixer(Mixer) then Logger.Log('Sucessfully setup Allegro default audio mixer', []);
    if al_attach_mixer_to_voice(Mixer, Voice) then Logger.Log('Sucessfully Allegro default audio mixer to default voice', []);
    if al_reserve_samples(ALLEGRO_MAX_CHANNELS) then Logger.Log('Sucessfully reserved %d Allegro samples', [ALLEGRO_MAX_CHANNELS]);
  end;

  // inif PhysicalFS
  al_store_state(@FFIState[False], ALLEGRO_STATE_NEW_FILE_INTERFACE);
  al_store_state(@FFIState[True], ALLEGRO_STATE_NEW_FILE_INTERFACE);
  if PHYSFS_init(nil) then
    begin
      Logger.Log('Sucessfully initialized PhysicalFS', []);
      al_set_physfs_file_interface;
      al_store_state(@FFIState[True], ALLEGRO_STATE_NEW_FILE_INTERFACE);
      PHYSFS_mount('./', nil, True);
    end
  else
    Logger.Log('Was not able to initialized PhysicalFS', []);

  // init timing
  FTimer.LNow := 0;
  FTimer.Passed := 0;
  FTimer.Last := 0;
  FTimer.Accumulator := 0;
  FTimer.FrameAccumulator := 0;
  FTimer.DeltaTime := 0;
  FTimer.FrameCount := 0;
  FTimer.FrameRate := 0;
  SetUpdateSpeed(60);
  FTimer.Last := GetTime;

  // archive
  FArchiveFilename := '';
  FArchivePassword := '';

  // init objects
  FGame := nil;
  Styles.Setup;
  Math.Setup;
  Display.Setup;
  Input.Setup;
  GUI.Setup;
  CmdConsole.Setup;
  StartupDialog.Setup;
  Video.Setup;
  Speech.Setup;
  Audio.Setup;
  Screenshake.Setup;
  Screenshot.Setup;
  Async.Setup;

  {$REGION 'Init common colors'}
  ALICEBLUE.Make('aliceblue');
  ANTIQUEWHITE.Make('antiquewhite');
  AQUA.Make('aqua');
  AQUAMARINE.Make('aquamarine');
  AZURE.Make('azure');
  BEIGE.Make('beige');
  BISQUE.Make('bisque');
  BLACK.Make('black');
  BLANCHEDALMOND.Make('blanchedalmond');
  BLUE.Make('blue');
  BLUEVIOLET.Make('blueviolet');
  BROWN.Make('brown');
  BURLYWOOD.Make('burlywood');
  CADETBLUE.Make('cadetblue');
  CHARTREUSE.Make('chartreuse');
  CHOCOLATE.Make('chocolate');
  CORAL.Make('coral');
  CORNFLOWERBLUE.Make('cornflowerblue');
  CORNSILK.Make('cornsilk');
  CRIMSON.Make('crimson');
  CYAN.Make('cyan');
  DARKBLUE.Make('darkblue');
  DARKCYAN.Make('darkcyan');
  DARKGOLDENROD.Make('darkgoldenrod');
  DARKGRAY.Make('darkgray');
  DARKGREEN.Make('darkgreen');
  DARKKHAKI.Make('darkkhaki');
  DARKMAGENTA.Make('darkmagenta');
  DARKOLIVEGREEN.Make('darkolivegreen');
  DARKORANGE.Make('darkorange');
  DARKORCHID.Make('darkorchid');
  DARKRED.Make('darkred');
  DARKSALMON.Make('darksalmon');
  DARKSEAGREEN.Make('darkseagreen');
  DARKSLATEBLUE.Make('darkslateblue');
  DARKSLATEGRAY.Make('darkslategray');
  DARKTURQUOISE.Make('darkturquoise');
  DARKVIOLET.Make('darkviolet');
  DEEPPINK.Make('deeppink');
  DEEPSKYBLUE.Make('deepskyblue');
  DIMGRAY.Make('dimgray');
  DODGERBLUE.Make('dodgerblue');
  FIREBRICK.Make('firebrick');
  FLORALWHITE.Make('floralwhite');
  FORESTGREEN.Make('forestgreen');
  FUCHSIA.Make('fuchsia');
  GAINSBORO.Make('gainsboro');
  GHOSTWHITE.Make('ghostwhite');
  GOLDENROD.Make('goldenrod');
  GOLD.Make('gold');
  GRAY.Make('gray');
  GREEN.Make('green');
  GREENYELLOW.Make('greenyellow');
  HONEYDEW.Make('honeydew');
  HOTPINK.Make('hotpink');
  INDIANRED.Make('indianred');
  INDIGO.Make('indigo');
  IVORY.Make('ivory');
  KHAKI.Make('khaki');
  LAVENDERBLUSH.Make('lavenderblush');
  LAVENDER.Make('lavender');
  LAWNGREEN.Make('lawngreen');
  LEMONCHIFFON.Make('lemonchiffon');
  LIGHTBLUE.Make('lightblue');
  LIGHTCORAL.Make('lightcoral');
  LIGHTCYAN.Make('lightcyan');
  LIGHTGOLDENRODYELLOW.Make('lightgoldenrodyellow');
  LIGHTGREEN.Make('lightgreen');
  LIGHTGREY.Make('lightgrey');
  LIGHTPINK.Make('lightpink');
  LIGHTSALMON.Make('lightsalmon');
  LIGHTSEAGREEN.Make('lightseagreen');
  LIGHTSKYBLUE.Make('lightskyblue');
  LIGHTSLATEGRAY.Make('lightslategray');
  LIGHTSTEELBLUE.Make('lightsteelblue');
  LIGHTYELLOW.Make('lightyellow');
  LIME.Make('lime');
  LIMEGREEN.Make('limegreen');
  LINEN.Make('linen');
  MAGENTA.Make('magenta');
  MAROON.Make('maroon');
  MEDIUMAQUAMARINE.Make('mediumaquamarine');
  MEDIUMBLUE.Make('mediumblue');
  MEDIUMORCHID.Make('mediumorchid');
  MEDIUMPURPLE.Make('mediumpurple');
  MEDIUMSEAGREEN.Make('mediumseagreen');
  MEDIUMSLATEBLUE.Make('mediumslateblue');
  MEDIUMSPRINGGREEN.Make('mediumspringgreen');
  MEDIUMTURQUOISE.Make('mediumturquoise');
  MEDIUMVIOLETRED.Make('mediumvioletred');
  MIDNIGHTBLUE.Make('midnightblue');
  MINTCREAM.Make('mintcream');
  MISTYROSE.Make('mistyrose');
  MOCCASIN.Make('moccasin');
  AVAJOWHITE.Make('avajowhite');
  NAVY.Make('navy');
  OLDLACE.Make('oldlace');
  OLIVE.Make('olive');
  OLIVEDRAB.Make('olivedrab');
  ORANGE.Make('orange');
  ORANGERED.Make('orangered');
  ORCHID.Make('orchid');
  PALEGOLDENROD.Make('palegoldenrod');
  PALEGREEN.Make('palegreen');
  PALETURQUOISE.Make('paleturquoise');
  PALEVIOLETRED.Make('palevioletred');
  PAPAYAWHIP.Make('papayawhip');
  PEACHPUFF.Make('peachpuff');
  PERU.Make('peru');
  PINK.Make('pink');
  PLUM.Make('plum');
  POWDERBLUE.Make('powderblue');
  PURPLE.Make('purple');
  REBECCAPURPLE.Make('rebeccapurple');
  RED.Make('red');
  ROSYBROWN.Make('rosybrown');
  ROYALBLUE.Make('royalblue');
  SADDLEBROWN.Make('saddlebrown');
  SALMON.Make('salmon');
  SANDYBROWN.Make('sandybrown');
  SEAGREEN.Make('seagreen');
  SEASHELL.Make('seashell');
  SIENNA.Make('sienna');
  SILVER.Make('silver');
  SKYBLUE.Make('skyblue');
  SLATEBLUE.Make('slateblue');
  SLATEGRAY.Make('slategray');
  SNOW.Make('snow');
  SPRINGGREEN.Make('springgreen');
  STEELBLUE.Make('steelblue');
  TAN.Make('tan');
  TEAL.Make('teal');
  THISTLE.Make('thistle');
  TOMATO.Make('tomato');
  TURQUOISE.Make('turquoise');
  VIOLET.Make('violet');
  WHEAT.Make('wheat');
  WHITE.Make('white');
  WHITESMOKE.Make('whitesmoke');
  YELLOW.Make('yellow');
  YELLOWGREEN.Make('yellowgreen');
  BLANK.Make(0, 0, 0, 0);
  WHITE2.Make(245, 245, 245, 255);
  RED2.Make(126, 50, 63, 255);
  COLORKEY.Make(255, 000, 255, 255);
  OVERLAY1.Make(000, 032, 041, 180);
  OVERLAY2.Make(001, 027, 001, 255);
  DIMWHITE.Make(16, 16, 16, 16);
 {$ENDREGION}

end;

class procedure Engine.Shutdown;
begin
  if not al_is_system_installed then Exit;

  // free objects
  Async.Shutdown;
  Screenshot.Shutdown;
  Screenshake.Shutdown;
  Audio.Shutdown;
  Speech.Shutdown;
  Video.Shutdown;
  StartupDialog.Shutdown;
  CmdConsole.Shutdown;
  GUI.Shutdown;
  Input.Shutdown;
  Display.Shutdown;
  Math.Shutdown;
  Styles.Shutdown;

  // shutdown PhyscalFS
  if PHYSFS_isInit then
  begin
    if PHYSFS_deinit then
    Logger.Log('Sucessfully deinitialized PhysicalFS', [])
  else
    Logger.Log('Was not able to deinitialized PhysicalFS', []);
  end;

  // shutdown audio
  if al_is_audio_installed then
  begin
    al_stop_samples;
    if al_detach_mixer(Mixer) then Logger.Log('Sucessfully detached Allegro default audio mixer', []);
    al_destroy_mixer(Mixer);
    al_destroy_voice(Voice);
    al_uninstall_audio;
    Logger.Log('Sucessfully shutdown Allegro audio support', []);
  end;

  // shutdown event queues
  if al_is_event_source_registered(Queue, @UserEventSrc) then
    al_unregister_event_source(Queue, @UserEventSrc);

  if al_is_event_source_registered(Queue, al_get_keyboard_event_source) then
    al_unregister_event_source(Queue, al_get_keyboard_event_source);

  if al_is_event_source_registered(Queue, al_get_mouse_event_source) then
    al_unregister_event_source(Queue, al_get_mouse_event_source);

  if al_is_event_source_registered(Queue, al_get_joystick_event_source) then
    al_unregister_event_source(Queue, al_get_joystick_event_source);

  // destroy user event source
  al_destroy_user_event_source(@UserEventSrc);

  Logger.Log('Unregistered all Allegro events', []);


  // destroy event queue
  if Queue <> nil then
  begin
    al_destroy_event_queue(Queue);
    Logger.Log('Destroyed Allegro event queue', []);
  end;


  // uninstall allegro
  al_uninstall_system;
  Logger.Log('Shutdown Allegro', []);
  UnloadAllegroDLL;

  Logger.Log('Shutting down %s', [GAMEVISION_DESCRIPTION]);
end;

class procedure Engine.CheckSingleInstance;
var
  LFilename: string;
  LText: Text;
  LOk: Boolean;
begin
  LFilename := ChangeFileExt(ParamStr(0), '.'+cLogExt);
  {$I-}
  AssignFile(LText, LFilename);
  Reset(LText);
  LOk :=  Boolean(IOResult = 0);
  {$I+}
  if LOk then
    CloseFile(LText)
  else
    begin
      if HasConsoleOutput then
        WriteLn('An instance of this app is already running, terminating!');
    end;
end;

class function Engine.GetVersion: string;
begin
  Result := GAMEVISION_VERSION;
end;

class procedure Engine.EmitCmdConInactiveEvent;
begin
 al_emit_user_event(@UserEventSrc , @CmdConInactive , nil);
end;

class procedure Engine.EmitCmdConActiveEvent;
begin
  al_emit_user_event(@UserEventSrc , @CmdConActive , nil);
end;

class procedure Engine.OnLoad;
begin
  if Assigned(FGame) then
    FGame.OnLoad;
end;

class procedure Engine.OnExit;
begin
  if Assigned(FGame) then
    FGame.OnExit;
end;

class procedure Engine.OnStartup;
begin
  if Assigned(FGame) then
    FGame.OnStartup;
end;

class procedure Engine.OnShutdown;
begin
  if Assigned(FGame) then
    FGame.OnShutdown;
end;

class function  Engine.OnStartupDialogShow: Boolean;
begin
  Result := False;
  if Assigned(FGame) then
    Result := FGame.OnStartupDialogShow;
end;

class procedure Engine.OnStartupDialogMore;
begin
  if Assigned(FGame) then
    FGame.OnStartupDialogMore;
end;

class function  Engine.OnStartupDialogRun: Boolean;
begin
  Result := False;
  if Assigned(FGame) then
    Result := FGame.OnStartupDialogRun;
end;

class procedure Engine.OnProcessIMGUI;
begin
  if Assigned(FGame) then
    FGame.OnProcessIMGUI;
end;

class procedure Engine.OnDisplayOpenBefore;
begin
  if Assigned(FGame) then
    FGame.OnDisplayOpenBefore;
end;

class procedure Engine.OnDisplayOpenAfter;
begin
  if Assigned(FGame) then
    FGame.OnDisplayOpenAfter;
end;

class procedure Engine.OnDisplayCloseBefore;
begin
  if Assigned(FGame) then
    FGame.OnDisplayCloseBefore;
end;

class procedure Engine.OnDisplayCloseAfter;
begin
  if Assigned(FGame) then
    FGame.OnDisplayCloseAfter;
end;

class procedure Engine.OnDisplayReady(aReady: Boolean);
begin
  if Assigned(FGame) then
    FGame.OnDisplayReady(aReady);
end;

class procedure Engine.OnDisplayClear;
begin
  if Assigned(FGame) then
    FGame.OnDisplayClear;
end;

class procedure Engine.OnDisplayToggleFullscreen(aFullscreen: Boolean);
begin
  if Assigned(FGame) then
    FGame.OnDisplayToggleFullscreen(aFullscreen);
end;

class procedure Engine.OnRender;
begin
  if Assigned(FGame) then
    FGame.OnRender;
end;

class procedure Engine.OnRenderHUD;
begin
  if Assigned(FGame) then
    FGame.OnRenderHUD;
  CmdConsole.Render;
end;

class procedure Engine.OnDisplayShow;
begin
  if Assigned(FGame) then
    FGame.OnDisplayShow;
end;

class procedure Engine.OnSpeechWord(const aWord: string; const aText: string);
begin
  if Assigned(FGame) then
    FGame.OnSpeechWord(aWord, aText);
end;

class procedure Engine.OnUpdate(aDeltaTime: Double);
begin
  if not CmdConsole.GetActive then
  begin
    if Assigned(FGame) then
      FGame.OnUpdate(aDeltaTime);
     Screenshake.Process(FTimer.UpdateSpeed, aDeltaTime);
  end;

  CmdConsole.Update(aDeltaTime);
end;

class procedure Engine.OnVideoFinished(const aFilename: string);
begin
  if Assigned(FGame) then
    FGame.OnVideoFinished(aFilename);
end;

class procedure Engine.OnVideoLoad(const aFilename: string);
begin
  if Assigned(FGame) then
    FGame.OnVideoLoad(aFilename);
end;

class procedure Engine.OnVideoUnload(const aFilename: string);
begin
  if Assigned(FGame) then
    FGame.OnVideoUnload(aFilename);
end;

class procedure Engine.OnCmdConsoleOpen;
begin
  if Assigned(FGame) then
    FGame.OnCmdConsoleOpen;
end;

class procedure Engine.OnCmdConsoleClose;
begin
  if Assigned(FGame) then
    FGame.OnCmdConsoleClose;
end;

class function  Engine.GetTerminate: Boolean;
begin
  Result := FTerminate;
end;

class procedure Engine.SetTerminate(aTerminate: Boolean);
begin
  FTerminate:= aTerminate;
end;

class function  Engine.GetTime: Double;
begin
  Result := al_get_time;
end;

class procedure Engine.ResetTiming;
begin
  FTimer.LNow := 0;
  FTimer.Passed := 0;
  FTimer.Last := 0;

  FTimer.Accumulator := 0;
  FTimer.FrameAccumulator := 0;

  FTimer.DeltaTime := 0;

  FTimer.FrameCount := 0;
  FTimer.FrameRate := 0;

  SetUpdateSpeed(FTimer.UpdateSpeed);

  FTimer.Last := GetTime;
end;

class procedure Engine.UpdateTiming;
begin
  FTimer.LNow := GetTime;
  FTimer.Passed := FTimer.LNow - FTimer.Last;
  FTimer.Last := FTimer.LNow;

  // process framerate
  Inc(FTimer.FrameCount);
  FTimer.FrameAccumulator := FTimer.FrameAccumulator + FTimer.Passed + EPSILON;
  if FTimer.FrameAccumulator >= 1 then
  begin
    FTimer.FrameAccumulator := 0;
    FTimer.FrameRate := FTimer.FrameCount;
    FTimer.FrameCount := 0;
  end;

  // process variable update
  FTimer.Accumulator := FTimer.Accumulator + FTimer.Passed;
  while (FTimer.Accumulator >= FTimer.DeltaTime) do
  begin
    OnUpdate(FTimer.DeltaTime);
    FTimer.Accumulator := FTimer.Accumulator - FTimer.DeltaTime;
  end;
end;

class procedure Engine.SetUpdateSpeed(aSpeed: Single);
begin
  FTimer.UpdateSpeed := aSpeed;
  FTimer.DeltaTime := 1.0 / FTimer.UpdateSpeed;
end;

class function  Engine.GetUpdateSpeed: Single;
begin
  Result := FTimer.UpdateSpeed;
end;

class function  Engine.GetDeltaTime: Double;
begin
  Result := FTimer.DeltaTime;
end;

class function  Engine.GetFrameRate: Cardinal;
begin
  Result := FTimer.FrameRate;
end;

class function  Engine.FrameSpeed(var aTimer: Single; aSpeed: Single): Boolean;
begin
  Result := False;
  aTimer := aTimer + (aSpeed / FTimer.UpdateSpeed);
  if aTimer >= 1.0 then
  begin
    aTimer := 0;
    Result := True;
  end;
end;

class function  Engine.FrameElapsed(var aTimer: Single; aFrames: Single): Boolean;
begin
  Result := False;
  aTimer := aTimer + FTimer.DeltaTime;
  if aTimer > aFrames then
  begin
    aTimer := 0;
    Result := True;
  end;
end;

class procedure Engine.EnablePhysFS(aEnable: Boolean);
begin
  al_restore_state(@FFIState[aEnable]);
end;

class function  Engine.OpenArchive(aFilename: string; aPassword: string): Boolean;
var
  LMarsheller: TMarshaller;
begin
  Result := False;
  if aFilename.IsEmpty then Exit;
  if al_filename_exists(LMarsheller.AsAnsi(aFilename).ToPointer) then
    begin
      CloseArchive;
      Result := PHYSFS_mount(LMarsheller.AsAnsi(aFilename).ToPointer, nil, True);
      if Result then
        begin
          FArchiveFilename := aFilename;
          FArchivePassword := aPassword;
          Logger.Log('Successfull opened archive: "%s"', [aFilename])
        end
      else
        Logger.Log('Failed to mounte archive: "%s"', [aFilename])
    end
  else
    begin
      Logger.Log('Archive was not found: "%s"', [aFilename]);
    end;
end;

class function  Engine.CloseArchive: Boolean;
var
  LMarsheller: TMarshaller;
begin
  Result := False;
  if FArchiveFilename.IsEmpty then Exit;
  if al_filename_exists(LMarsheller.AsAnsi(FArchiveFilename).ToPointer) then
    begin
      Result := PHYSFS_unmount(LMarsheller.AsAnsi(FArchiveFilename).ToPointer);
      if Result then
        begin
          Logger.Log('Successfull closed archive: "%s"', [FArchiveFilename]);
          FArchiveFilename := '';
          FArchivePassword := '';
        end
      else
        Logger.Log('Failed to close archive: "%s"', [FArchiveFilename])
    end
  else
    begin
      Logger.Log('Archive was not found: "%s"', [FArchiveFilename]);
    end;
end;

class function  Engine.GetArchivePassword: string;
begin
  Result := FArchivePassword;
end;

class function  Engine.GetArchiveItemFilename(aFilename: string): PAnsiChar;
begin
  if FArchivePassword.IsEmpty then
    Result := PAnsiChar(AnsiString(aFilename))
  else
    Result := PAnsiChar(AnsiString(aFilename + '$' + FArchivePassword));
end;

class procedure Engine.GameLoop;
begin
  Logger.Log('Entering GameLoop', []);

  try
    Audio.Setup;

    Speech.Clear;

    OnStartup;

    Input.Clear;

    GUI.Open;

    CmdConsole.Open;

    FTerminate := False;

    ResetTiming;

    while not FTerminate do
    begin

      // process OS messages
      ProcessMessages;

      //ProcessAsync;
      Async.Process;

      timeBeginPeriod(1);

      if not Display.GetReady then
      begin
        // allow background tasks to runn
        Sleep(1);
      end;

      timeEndPeriod(1);

      // input
      KeyCode := 0;
      al_get_keyboard_state(@KeyboardState);
      al_get_mouse_state(@MouseState);

      // start imgui input processing
      GUI.InputBegin;

      repeat
        //FLua.CollectGarbage;

        if al_get_next_event(Queue, @Event) then
        begin

          // process imgui events
          GUI.HandleEvent(Event);

          case Event.&type of
            EVENT_CMDCON_ACTIVE:
              begin
                Audio.Pause(True);
                Video.SetPause(True);
                if Speech.Active then Speech.Pause;
                if al_is_audio_installed then al_set_mixer_playing(Mixer, False);
                OnCmdConsoleOpen;
              end;

            EVENT_CMDCON_INACTIVE:
              begin
                Audio.Pause(False);
                Video.SetPause(False);
                if Speech.Active then Speech.Resume;
                if al_is_audio_installed then al_set_mixer_playing(Mixer, True);
                OnCmdConsoleClose;
              end;

            ALLEGRO_EVENT_DISPLAY_CLOSE:
              begin
                FTerminate := True;
              end;

            ALLEGRO_EVENT_DISPLAY_RESIZE:
              begin
              end;

            ALLEGRO_EVENT_DISPLAY_DISCONNECTED,
            ALLEGRO_EVENT_DISPLAY_HALT_DRAWING, ALLEGRO_EVENT_DISPLAY_LOST,
            ALLEGRO_EVENT_DISPLAY_SWITCH_OUT:
              begin
                // display switch out
                if Event.&type = ALLEGRO_EVENT_DISPLAY_SWITCH_OUT then
                begin
                  Input.Clear;
                end;

                // pause speech engine
                if Speech.Active then
                begin
                  Speech.Pause;
                end;

                // pause audio
                if al_is_audio_installed then
                begin
                  al_set_mixer_playing(Mixer, False);
                end;

                Audio.Pause(True);

                // pause video
                Video.SetPause(True);

                // set display not ready
                Display.SetReady(False);
                OnDisplayReady(Display.GetReady);
              end;

            ALLEGRO_EVENT_DISPLAY_CONNECTED,
            ALLEGRO_EVENT_DISPLAY_RESUME_DRAWING, ALLEGRO_EVENT_DISPLAY_FOUND,
            ALLEGRO_EVENT_DISPLAY_SWITCH_IN:
              begin
                // resume speech engine
                if Speech.Active then
                begin
                  Speech.Resume;
                end;

                // resume audio
                if al_is_audio_installed then
                begin
                  al_set_mixer_playing(Mixer, True);
                end;

                Audio.Pause(False);

                // resume video
                Video.SetPause(False);

                // set display ready
                ResetTiming;
                Display.SetReady(True);
                OnDisplayReady(Display.GetReady);
              end;

            ALLEGRO_EVENT_KEY_CHAR:
              begin
                KeyCode := Event.keyboard.unichar;
              end;

            ALLEGRO_EVENT_VIDEO_FINISHED:
              begin
                Video.FinishedEvent(PALLEGRO_VIDEO(Event.user.data1));
              end;

            ALLEGRO_EVENT_JOYSTICK_AXIS:
              begin
                if (Event.Joystick.stick < MAX_STICKS) and
                  (Event.Joystick.axis < MAX_AXES) then
                begin
                  Input.Joystick.Pos[Event.Joystick.stick][Event.Joystick.axis] :=
                    Event.Joystick.Pos;
                end;
              end;

            ALLEGRO_EVENT_JOYSTICK_BUTTON_DOWN:
              begin
                Input.Joystick.Button[Event.Joystick.Button] := True;
              end;

            ALLEGRO_EVENT_JOYSTICK_BUTTON_UP:
              begin
                Input.Joystick.Button[Event.Joystick.Button] := False;
              end;

            ALLEGRO_EVENT_JOYSTICK_CONFIGURATION:
              begin
                al_reconfigure_joysticks;
                Input.Joystick.Setup(0);
              end;

          end;
        end;

      until al_is_event_queue_empty(Queue);

      // end imgui input processing
      GUI.InputEnd;

      if Display.GetReady then
      begin
        // reset transform
        Display.ResetTransform;

        // process IMGUI
        //OnProcessIMGUI;

        //FPhysics.Update;

        UpdateTiming;

        // process IMGUI
        OnProcessIMGUI;

        // clear frame
        OnDisplayClear;

        // render
        OnRender;

        // save the current transform
        var trans: ALLEGRO_TRANSFORM := al_get_current_transform^;

        // reset transform
        Display.ResetTransform;

        // render imgui
        GUI.Render;

        // clear imgui resources
        GUI.Clear;

        // render normal HUD
        OnRenderHUD;

        // got back to current transform
        al_use_transform(@trans);

        // process screen shots
        Screenshot.Process;

        // show display
        OnDisplayShow;

      end;

    end;


  finally

    CmdConsole.Close;

    GUI.Close;

    Input.Clear;

    OnShutdown;

    Speech.Clear;

    Audio.Shutdown;
    Video.Unload;
  end;

  Logger.Log('Exiting GameLoop', []);
end;

class procedure Engine.RunGame(aGame: TCustomGameClass);
var
  LGame: TCustomGame;
begin
  ReportMemoryLeaksOnShutdown := True;

  try
    // save current game
    LGame := FGame;
    try
      // create new game
      FGame := aGame.Create;
      try
        // run new game
        FGame.Run;
      finally
        // free new game
        FreeAndNil(FGame);
      end;
    finally
      // retore old game
      FGame := LGame;
    end;
  except
    on E: Exception do
      Logger.Log('%s: %s', [E.ClassName, E.Message]);
  end;
end;

{ --- UNIT INITIALIZATION --------------------------------------------------- }
var
  mCodePage: Cardinal;

initialization
begin
  // report memory leaks
  ReportMemoryLeaksOnShutdown := True;

  // terminate if not single instance
  Engine.CheckSingleInstance;

  // set console codepage to utf8
  mCodePage := GetConsoleOutputCP;
  SetConsoleOutputCP(WinApi.Windows.CP_UTF8);

  Randomize;

  // init logger
  Logger.FOpen := False;
  Logger.Open;

  // init engine
  Engine.Setup;
end;

finalization
begin
  // shutdown engine
  Engine.Shutdown;

  // shutdown logger
  Logger.Close;

  // restore console codepage
  SetConsoleOutputCP(mCodePage);
end;

end.
