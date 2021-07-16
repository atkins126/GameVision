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

unit GameVision.Graphics;

{$I GameVision.Defines.inc }

interface

uses
  System.Generics.Collections,
  WinApi.Windows,
  WinApi.Messages,
  GameVision.CLib.Allegro,
  GameVision.Common,
  GameVision.System;

{ --- COLOR ----------------------------------------------------------------- }
type
  { TColor }
  PColor = ^TColor;
  TColor = record
    Red: Single;
    Green: Single;
    Blue: Single;
    Alpha: Single;
    function Make(aRed: Byte; aGreen: Byte; aBlue: Byte; aAlpha: Byte): TColor; overload;
    function Make(aRed: Single; aGreen: Single; aBlue: Single; aAlpha: Single): TColor; overload;
    function Make(const aName: string): TColor; overload;

    function Fade(aTo: TColor; aPos: Single): TColor;

    function Equal(aColor: TColor): Boolean;
  end;

{$REGION 'Common Colors'}
var
  ALICEBLUE: TColor;
  ANTIQUEWHITE: TColor;
  AQUA: TColor;
  AQUAMARINE: TColor;
  AZURE: TColor;
  BEIGE: TColor;
  BISQUE: TColor;
  BLACK: TColor;
  BLANCHEDALMOND: TColor;
  BLUE: TColor;
  BLUEVIOLET: TColor;
  BROWN: TColor;
  BURLYWOOD: TColor;
  CADETBLUE: TColor;
  CHARTREUSE: TColor;
  CHOCOLATE: TColor;
  CORAL: TColor;
  CORNFLOWERBLUE: TColor;
  CORNSILK: TColor;
  CRIMSON: TColor;
  CYAN: TColor;
  DARKBLUE: TColor;
  DARKCYAN: TColor;
  DARKGOLDENROD: TColor;
  DARKGRAY: TColor;
  DARKGREEN: TColor;
  DARKKHAKI: TColor;
  DARKMAGENTA: TColor;
  DARKOLIVEGREEN: TColor;
  DARKORANGE: TColor;
  DARKORCHID: TColor;
  DARKRED: TColor;
  DARKSALMON: TColor;
  DARKSEAGREEN: TColor;
  DARKSLATEBLUE: TColor;
  DARKSLATEGRAY: TColor;
  DARKTURQUOISE: TColor;
  DARKVIOLET: TColor;
  DEEPPINK: TColor;
  DEEPSKYBLUE: TColor;
  DIMGRAY: TColor;
  DODGERBLUE: TColor;
  FIREBRICK: TColor;
  FLORALWHITE: TColor;
  FORESTGREEN: TColor;
  FUCHSIA: TColor;
  GAINSBORO: TColor;
  GHOSTWHITE: TColor;
  GOLDENROD: TColor;
  GOLD: TColor;
  GRAY: TColor;
  GREEN: TColor;
  GREENYELLOW: TColor;
  HONEYDEW: TColor;
  HOTPINK: TColor;
  INDIANRED: TColor;
  INDIGO: TColor;
  IVORY: TColor;
  KHAKI: TColor;
  LAVENDERBLUSH: TColor;
  LAVENDER: TColor;
  LAWNGREEN: TColor;
  LEMONCHIFFON: TColor;
  LIGHTBLUE: TColor;
  LIGHTCORAL: TColor;
  LIGHTCYAN: TColor;
  LIGHTGOLDENRODYELLOW: TColor;
  LIGHTGREEN: TColor;
  LIGHTGREY: TColor;
  LIGHTPINK: TColor;
  LIGHTSALMON: TColor;
  LIGHTSEAGREEN: TColor;
  LIGHTSKYBLUE: TColor;
  LIGHTSLATEGRAY: TColor;
  LIGHTSTEELBLUE: TColor;
  LIGHTYELLOW: TColor;
  LIME: TColor;
  LIMEGREEN: TColor;
  LINEN: TColor;
  MAGENTA: TColor;
  MAROON: TColor;
  MEDIUMAQUAMARINE: TColor;
  MEDIUMBLUE: TColor;
  MEDIUMORCHID: TColor;
  MEDIUMPURPLE: TColor;
  MEDIUMSEAGREEN: TColor;
  MEDIUMSLATEBLUE: TColor;
  MEDIUMSPRINGGREEN: TColor;
  MEDIUMTURQUOISE: TColor;
  MEDIUMVIOLETRED: TColor;
  MIDNIGHTBLUE: TColor;
  MINTCREAM: TColor;
  MISTYROSE: TColor;
  MOCCASIN: TColor;
  AVAJOWHITE: TColor;
  NAVY: TColor;
  OLDLACE: TColor;
  OLIVE: TColor;
  OLIVEDRAB: TColor;
  ORANGE: TColor;
  ORANGERED: TColor;
  ORCHID: TColor;
  PALEGOLDENROD: TColor;
  PALEGREEN: TColor;
  PALETURQUOISE: TColor;
  PALEVIOLETRED: TColor;
  PAPAYAWHIP: TColor;
  PEACHPUFF: TColor;
  PERU: TColor;
  PINK: TColor;
  PLUM: TColor;
  POWDERBLUE: TColor;
  PURPLE: TColor;
  REBECCAPURPLE: TColor;
  RED: TColor;
  ROSYBROWN: TColor;
  ROYALBLUE: TColor;
  SADDLEBROWN: TColor;
  SALMON: TColor;
  SANDYBROWN: TColor;
  SEAGREEN: TColor;
  SEASHELL: TColor;
  SIENNA: TColor;
  SILVER: TColor;
  SKYBLUE: TColor;
  SLATEBLUE: TColor;
  SLATEGRAY: TColor;
  SNOW: TColor;
  SPRINGGREEN: TColor;
  STEELBLUE: TColor;
  TAN: TColor;
  TEAL: TColor;
  THISTLE: TColor;
  TOMATO: TColor;
  TURQUOISE: TColor;
  VIOLET: TColor;
  WHEAT: TColor;
  WHITE: TColor;
  WHITESMOKE: TColor;
  YELLOW: TColor;
  YELLOWGREEN: TColor;
  BLANK: TColor;
  WHITE2: TColor;
  RED2: TColor;
  COLORKEY: TColor;
  OVERLAY1: TColor;
  OVERLAY2: TColor;
  DIMWHITE: TColor;
{$ENDREGION}

{ --- BITMAP ---------------------------------------------------------------- }
type
  { TBitmapData }
  PBitmapData = ^TBitmapData;
  TBitmapData = record
    Memory: Pointer;
    Format: Integer;
    Pitch: Integer;
    PixelSize: Integer;
  end;

  { TBitmap }
  TBitmap = class(TBaseObject)
  protected
    FHandle: PALLEGRO_BITMAP;
    FWidth: Single;
    FHeight: Single;
    FLocked: Boolean;
    FLockedRegion: TRectangle;
    FFilename: string;
  public
    property Handle: PALLEGRO_BITMAP read FHandle;
    constructor Create; override;
    destructor Destroy; override;

    procedure Allocate(aWidth: Integer; aHeight: Integer);
    procedure Load(aFilename: string; aColorKey: PColor);
    procedure Unload;

    procedure GetSize(var aSize: TVector); overload;
    procedure GetSize(aWidth: PSingle; aHeight: PSingle); overload;

    procedure Lock(aRegion: PRectangle; aData: PBitmapData=nil);
    procedure Unlock;

    function  GetPixel(aX: Integer; aY: Integer): TColor;
    procedure PutPixel(aX: Integer; aY: Integer; aColor: TColor);

    procedure Draw(aX, aY: Single; aRegion: PRectangle; aCenter: PVector;  aScale: PVector; aAngle: Single; aColor: TColor; aHFlip: Boolean; aVFlip: Boolean); overload;
    procedure Draw(aX, aY, aScale, aAngle: Single; aColor: TColor; aHAlign: THAlign; aVAlign: TVAlign; aHFlip: Boolean=False; aVFlip: Boolean=False); overload;
    procedure DrawTiled(aDeltaX: Single; aDeltaY: Single);

    class function LoadBitmap(aFilename: string; aColorKey: PColor): TBitmap; inline;
  end;

{ === VIEWPORT ============================================================== }
type
{ TViewport }
  TViewport = class(TBaseObject)
  protected
    FBitmap: TBitmap;
    FActive: Boolean;
    FPos: TRectangle;
    FHalf: TVector;
    FAngle: Single;
    FCenter: TVector;
    procedure Clean;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Init(aX: Integer; aY: Integer; aWidth: Integer; aHeight: Integer);

    procedure SetActive(aActive: Boolean);
    function  GetActive: Boolean;

    procedure SetPosition(aX: Integer; aY: Integer);
    procedure GetSize(aX: PInteger; aY: PInteger; aWidth: PInteger; aHeight: PInteger);

    procedure SetAngle(aAngle: Single);
    function  GetAngle: Single;

    procedure Align(var aX: Single; var aY: Single); overload;
    procedure Align(var aPos: TVector); overload;

    class function CreateViewport(aX: Integer; aY: Integer; aWidth: Integer; aHeight: Integer): TViewport;
  end;

{ --- DISPLAY --------------------------------------------------------------- }
const
  DISPLAY_DEFAULT_DPI = 96;

  BLEND_ZERO = 0;
  BLEND_ONE = 1;
  BLEND_ALPHA = 2;
  BLEND_INVERSE_ALPHA = 3;
  BLEND_SRC_COLOR = 4;
  BLEND_DEST_COLOR = 5;
  BLEND_INVERSE_SRC_COLOR = 6;
  BLEND_INVERSE_DEST_COLOR = 7;
  BLEND_CONST_COLOR = 8;
  BLEND_INVERSE_CONST_COLOR = 9;
  BLEND_ADD = 0;
  BLEND_SRC_MINUS_DEST = 1;
  BLEND_DEST_MINUS_SRC = 2;

type
  { TBlendMode }
  TBlendMode = (bmPreMultipliedAlpha, bmNonPreMultipliedAlpha, bmAdditiveAlpha, bmCopySrcToDest, bmMultiplySrcAndDest);

  { TBlendModeColor }
  TBlendModeColor = (bcColorNormal, bcColorAvgSrcDest);

  { Display }
  Display = record
  private
    class var
    FHandle: PALLEGRO_DISPLAY;
    FSize: TVector;
    FTransScale: Single;
    FTransSize: TRectangle;
    FTrans: ALLEGRO_TRANSFORM;
    FBlackbar: array[ 0..3 ] of TRectangle;
    FFullscreen: Boolean;
    FReady: Boolean;
    FViewport: TViewport;
    var
    class function TransformScale(aFullscreen: Boolean): Single; static;
    class procedure ResizeForDPI; static;
    class procedure FixupWindow; static;
    class procedure LoadDefaultIcon; static;
    class procedure Clearblackbars; static;
  public

    class function GetHandle: PALLEGRO_DISPLAY; static;
    class function GetFullscreen: Boolean; static;
    class function GetReady: Boolean; static;
    class procedure SetReady(aReady: Boolean); static;
    class function GetTransSize: TRectangle; static;
    class function GetTransScale: Single; static;
    class function GetTrans: ALLEGRO_TRANSFORM; static;

    class procedure Setup; static;
    class procedure Shutdown; static;

    class function  Open(aWidth: Integer; aHeight: Integer; aFullscreen: Boolean; aTitle: string): Boolean; static;
    class function  Close: Boolean; static;
    class function  Opened: Boolean; static;

    class procedure SetPosition(aX: Integer; aY: Integer); static;

    class procedure Clear(aColor: TColor); static;

    class procedure Show; static;
    class procedure ToggleFullscreen; static;

    class procedure ResetTransform; static;
    class procedure SetTransformPosition(aX: Integer; aY: Integer); static;
    class procedure SetTransformAngle(aAngle: Single); static;

    class procedure GetSize(aWidth: PInteger; aHeight: PInteger; aAspectRatio: PSingle=nil); static;

    class procedure SetTarget(aBitmap: TBitmap); static;
    class procedure ResetTarget; static;

    class procedure AlignToViewport(var aX: Single; var aY: Single); static;
    class procedure SetViewport(aViewport: TViewport); static;
    class procedure GetViewportSize(aX: PInteger; aY: PInteger; aWidth: PInteger; aHeight: PInteger); overload; static;
    class procedure GetViewportSize(var aSize: TRectangle); overload; static;
    class procedure ResetViewport; static;

    class procedure DrawLine(aX1, aY1, aX2, aY2: Single; aColor: TColor; aThickness: Single); static;
    class procedure DrawRectangle(aX, aY, aWidth, aHeight, aThickness: Single; aColor: TColor); static;
    class procedure DrawFilledRectangle(aX, aY, aWidth, aHeight: Single; aColor: TColor); static;
    class procedure DrawCircle(aX, aY, aRadius, aThickness: Single;  aColor: TColor); static;
    class procedure DrawFilledCircle(aX, aY, aRadius: Single; aColor: TColor); static;
    class procedure DrawPolygon(aVertices: System.PSingle; aVertexCount: Integer; aThickness: Single; aColor: TColor); static;
    class procedure DrawFilledPolygon(aVertices: System.PSingle; aVertexCount: Integer; aColor: TColor); static;
    class procedure DrawTriangle(aX1, aY1, aX2, aY2, aX3, aY3, aThickness: Single; aColor: TColor); static;
    class procedure DrawFilledTriangle(aX1, aY1, aX2, aY2, aX3, aY3: Single; aColor: TColor); static;

    class procedure SetBlender(aOperation: Integer; aSource: Integer; aDestination: Integer); static;
    class procedure GetBlender(aOperation: PInteger; aSource: PInteger; aDestination: PInteger); static;
    class procedure SetBlendColor(aColor: TColor); static;
    class function  GetBlendColor: TColor; static;
    class procedure SetBlendMode(aMode: TBlendMode); static;
    class procedure SetBlendModeColor(aMode: TBlendModeColor; aColor: TColor); static;
    class procedure RestoreDefaultBlendMode; static;

    class procedure Save(aFilename: string); static;

    class procedure GetTransInfo(var aSize: TRectangle; var aScale: Single); static;
    class procedure GetMonitorSize(var aSize: TVector); static;

    class function  GetMemorySize: UInt64; static;
  end;

{ === FONT ================================================================== }
type
  { TFont }
  TFont = class(TBaseObject)
  protected
    FHandle: PALLEGRO_FONT;
    FFilename: string;
    FPadding: TVector;
    procedure Default;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure LoadBuiltIn;

    procedure Load(aSize: Cardinal); overload;
    procedure Load(aSize: Cardinal; aFilename: string); overload;
    procedure Load(aSize: Cardinal; aMemory: Pointer; aLength: Int64); overload;

    procedure Unload;
    procedure Print(aX: Single; aY: Single; aColor: TColor; aAlign: THAlign; const aMsg: string; const aArgs: array of const); overload;
    procedure Print(aX: Single; var aY: Single; aLineSpace: Single; aColor: TColor; aAlign: THAlign; const aMsg: string; const aArgs: array of const); overload;
    procedure Print(aX: Single; aY: Single; aColor: TColor; aAngle: Single; const aMsg: string; const aArgs: array of const); overload;

    function  GetTextWidth(const aMsg: string; const aArgs: array of const): Single;
    function  GetLineHeight: Single;
  end;

{ --- TEXT ------------------------------------------------------------------ }
type
  { TTextItem }
  TTextItem = class(TBaseObject)
  protected
    FBitmap: TBitmap;
    FText: string;
    FFont: TFont;
    procedure Clear;
  public
    property Text: string read FText;
    property Font: TFont read FFont;

    constructor Create; override;
    destructor Destroy; override;

    procedure Print(aFont: TFont; aColors: array of TColor; const aMsg: string; const aArgs: array of const);
    procedure Render(aX: Single; aY: Single; aScale: Single; aAngle: Single);
  end;

  { TTextCacheItem }
  TTextCacheItem = class(TBaseObject)
  protected
    FText: TTextItem;
    FX: Single;
    FY: Single;
    FScale: Single;
    FAngle: Single;
  public
    property Text: TTextItem read FText;
    property X: Single read FX;
    property Y: Single read FY;
    property Scale: Single read FScale;
    property Angle: Single read FAngle;

    constructor Create; override;
    destructor Destroy; override;

    procedure Print(aFont: TFont; aX: Single; aY: Single; aScale: Single; aAngle: Single; aColors: array of TColor; const aMsg: string; const aArgs: array of const);

    procedure Render;
  end;

  { TText }
  TText = class(TBaseObject)
  protected
    FPos: TVector;
    FCache: TObjectList<TTextCacheItem>;
    function IsCached(aFont: TFont; aX: Single; aY: Single; aScale: Single; aAngle: Single; const aMsg: string; const aArgs: array of const): Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Clear;

    procedure Print(aFont: TFont; aX: Single; aY: Single; aScale: Single; aAngle: Single; aColors: array of TColor; const aMsg: string; const aArgs: array of const); overload;
    procedure Print(aFont: TFont; aX: Single; var aY: Single; aLineSpace: Single; aColors: array of TColor; const aMsg: string; const aArgs: array of const); overload;

    procedure Render;
  end;

{ --- STARFIELD ------------------------------------------------------------- }
type
  { TStarfieldItem }
  TStarfieldItem = record
    X, Y, Z: Single;
    Speed: Single;
  end;

  { TStarfield }
  TStarfield = class(TBaseObject)
  protected
    FCenter: TVector;
    FMin: TVector;
    FMax: TVector;
    FViewScaleRatio: Single;
    FViewScale: Single;
    FStarCount: Cardinal;
    FStar: array of TStarfieldItem;
    FSpeed: TVector;
    FVirtualPos: TVector;
  protected
    procedure TransformDrawPoint(aX, aY, aZ: Single; aVPX, aVPY, aVPW, aVPH: Integer);
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Done;
    procedure Init(aStarCount: Cardinal; aMinX, aMinY, aMinZ, aMaxX, aMaxY, aMaxZ, aViewScale: Single);

    procedure SetVirtualPos(aX, aY: Single);
    procedure GetVirtualPos(var aX: Single; var aY: Single);

    procedure SetXSpeed(aSpeed: Single);
    procedure SetYSpeed(aSpeed: Single);
    procedure SetZSpeed(aSpeed: Single);

    procedure Update(aDeltaTime: Single);

    procedure Render;
  end;

{ --- POLYGON --------------------------------------------------------------- }
type
  { TPolygonSegment }
  TPolygonSegment = record
    Point: TVector;
    Visible: Boolean;
  end;

  { TPolygon }
  TPolygon = class(TBaseObject)
  protected
    FSegment: array of TPolygonSegment;
    FWorldPoint: array of TVector;
    FItemCount: Integer;
    procedure Clear;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Save(aFilename: string);
    procedure Load(aFilename: string);
    procedure CopyFrom(aPolygon: TPolygon);

    procedure AddLocalPoint(aX: Single; aY: Single; aVisible: Boolean);
    function  Transform(aX: Single; aY: Single; aScale: Single; aAngle: Single; aOrigin: PVector; aHFlip: Boolean; aVFlip: Boolean): Boolean;

    procedure Render(aX: Single; aY: Single; aScale: Single; aAngle: Single; aThickness: Integer; aColor: TColor; aOrigin: PVector; aHFlip: Boolean; aVFlip: Boolean);

    procedure SetSegmentVisible(aIndex: Integer; aVisible: Boolean);
    function  GetSegmentVisible(aIndex: Integer): Boolean;

    function  GetPointCount: Integer;

    function  GetWorldPoint(aIndex: Integer): PVector;
    function  GetLocalPoint(aIndex: Integer): PVector;
  end;

{ --- SPRITE ---------------------------------------------------------------- }
type
  { TSpriteImageRegion }
  PSpriteImageRegion = ^TSpriteImageRegion;
  TSpriteImageRegion = record
    Rect: TRectangle;
    Page: Integer;
  end;

  { TSpriteGroup }
  PSpriteGroup = ^TSpriteGroup;
  TSpriteGroup = record
    Image: array of TSpriteImageRegion;
    Count: Integer;
    PolyPoint: Pointer;
  end;

  { TSprite }
  TSprite = class(TBaseObject)
  protected
    FBitmap: array of TBitmap;
    FGroup: array of TSpriteGroup;
    FPageCount: Integer;
    FGroupCount: Integer;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Clear;
    function LoadPage(aFilename: string; aColorKey: PColor): Integer;

    function AddGroup: Integer;
    function GetGroupCount: Integer;

    function AddImageFromRect(aPage: Integer; aGroup: Integer; aRect: TRectangle): Integer;
    function AddImageFromGrid(aPage: Integer; aGroup: Integer; aGridX: Integer; aGridY: Integer; aGridWidth: Integer; aGridHeight: Integer): Integer;

    function GetImageCount(aGroup: Integer): Integer;
    function GetImageWidth(aNum: Integer; aGroup: Integer): Single;
    function GetImageHeight(aNum: Integer; aGroup: Integer): Single;
    function GetImageTexture(aNum: Integer; aGroup: Integer): TBitmap;
    function GetImageRect(aNum: Integer; aGroup: Integer): TRectangle;

    procedure DrawImage(aNum: Integer; aGroup: Integer; aX: Single; aY: Single; aOrigin: PVector; aScale: PVector; aAngle: Single; aColor: TColor; aHFlip: Boolean; aVFlip: Boolean; aDrawPolyPoint: Boolean);

    function GroupPolyPoint(aGroup: Integer): Pointer;
    procedure GroupPolyPointTrace(aGroup: Integer; aMju: Single=6; aMaxStepBack: Integer=12; aAlphaThreshold: Integer=70; aOrigin: PVector=nil);
    function GroupPolyPointCollide(aNum1: Integer; aGroup1: Integer;
      aX1: Single; aY1: Single; aScale1: Single; aAngle1: Single;
      aOrigin1: PVector; aHFlip1: Boolean; aVFlip1: Boolean; aSprite2: TSprite;
      aNum2: Integer; aGroup2: Integer; aX2: Single; aY2: Single;
      aScale2: Single; aAngle2: Single; aOrigin2: PVector; aHFlip2: Boolean;
      aVFlip2: Boolean; aShrinkFactor: Single; var aHitPos: TVector): Boolean;
    function GroupPolyPointCollidePoint(aNum: Integer; aGroup: Integer;
      aX: Single; aY: Single; aScale: Single; aAngle: Single; aOrigin: PVector;
      aHFlip: Boolean; aVFlip: Boolean; aShrinkFactor: Single;
      var aPoint: TVector): Boolean;
  end;

{ --- POLYPOINT ------------------------------------------------------------- }
type
  { TPolyPoint }
  TPolyPoint = class(TBaseObject)
  protected
    FPolygon: array of TPolygon;
    FCount: Integer;
    procedure Clear;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Save(aFilename: string);
    procedure Load(aFilename: string);
    procedure CopyFrom(aPolyPoint: TPolyPoint);
    procedure AddPoint(aNum: Integer; aX: Single; aY: Single; aOrigin: PVector);
    function TraceFromBitmap(aBitmap: TBitmap; aMju: Single; aMaxStepBack: Integer; aAlphaThreshold: Integer; aOrigin: PVector): Integer;
    procedure TraceFromSprite(aSprite: TSprite; aGroup: Integer; aMju: Single; aMaxStepBack: Integer; aAlphaThreshold: Integer; aOrigin: PVector);
    function Count: Integer;
    procedure Render(aNum: Integer; aX: Single; aY: Single; aScale: Single; aAngle: Single; aColor: TColor; aOrigin: PVector; aHFlip: Boolean; aVFlip: Boolean);
    function Collide(aNum1: Integer; aGroup1: Integer; aX1: Single; aY1: Single;
      aScale1: Single; aAngle1: Single; aOrigin1: PVector; aHFlip1: Boolean;
      aVFlip1: Boolean; aPolyPoint2: TPolyPoint; aNum2: Integer;
      aGroup2: Integer; aX2: Single; aY2: Single; aScale2: Single;
      aAngle2: Single; aOrigin2: PVector; aHFlip2: Boolean; aVFlip2: Boolean;
      var aHitPos: TVector): Boolean;
    function CollidePoint(aNum: Integer; aGroup: Integer; aX: Single;
      aY: Single; aScale: Single; aAngle: Single; aOrigin: PVector;
      aHFlip: Boolean; aVFlip: Boolean; var aPoint: TVector): Boolean;
    function Polygon(aNum: Integer): TPolygon;
    function Valid(aNum: Integer): Boolean;
  end;

{ --- POLYPOINTTRACE -------------------------------------------------------- }
type
  { PolyPointTrace }
  PolyPointTrace = record
  private
    class var
      mPolyArr: array of TPointi;
      mPntCount: Integer;
      mMju: Extended;
      mMaxStepBack: Integer;
      mAlphaThreshold: Byte; // alpha channel threshhold
    class function IsNeighbour(X1, Y1, X2, Y2: Integer): Boolean; static;
    class function IsPixEmpty(Tex: TBitmap; X, Y: Integer; W, H: Single): Boolean; static;
    class procedure AddPoint(X, Y: Integer); static;
    class procedure DelPoint(Index: Integer); static;
    class function IsInList(X, Y: Integer): Boolean; static;
    class procedure FindStartingPoint(Tex: TBitmap; var X, Y: Integer; W, H: Single); static;
    class function CountEmptyAround(Tex: TBitmap; X, Y: Integer; W, H: Single): Integer; static;
    class function FindNearestButNotNeighbourOfOther(Tex: TBitmap; Xs, Ys, XOther, YOther: Integer; var XF, YF: Integer; W, H: Single): Boolean; static;
    class function LineLength(X1, Y1, X2, Y2: Integer): Extended; static;
    //class function TriangleSquare(X1, Y1, X2, Y2, X3, Y3: Integer): Extended; static;
    class function TriangleThinness(X1, Y1, X2, Y2, X3, Y3: Integer): Extended; static;
  public
    class procedure Init(aMju: Extended = 6; aMaxStepBack: Integer = 10; aAlphaThreshold: Byte = 70); static;
    class procedure Done; static;
    class function  GetPointCount: Integer; static;
    class procedure PrimaryTrace(aTex: TBitmap; aWidth, aHeight: Single); static;
    class procedure SimplifyPoly; static;
    class procedure ApplyPolyPoint(aPolyPoint: TPolyPoint; aNum: Integer; aOrigin: PVector); static;
  end;

{ --- ENTITY ---------------------------------------------------------------- }
{ TEntity }
  TEntity = class(TBaseObject)
  protected
    FSprite      : TSprite;
    FGroup       : Integer;
    FFrame       : Integer;
    FFrameFPS    : Single;
    FFrameTimer  : Single;
    FPos         : TVector;
    FDir         : TVector;
    FScale       : Single;
    FAngle       : Single;
    FAngleOffset : Single;
    FColor       : TColor;
    FHFlip       : Boolean;
    FVFlip       : Boolean;
    FLoopFrame   : Boolean;
    FWidth       : Single;
    FHeight      : Single;
    FRadius      : Single;
    FFirstFrame  : Integer;
    FLastFrame   : Integer;
    FShrinkFactor: Single;
    FOrigin      : TVector;
    FRenderPolyPoint: Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Init(aSprite: TSprite; aGroup: Integer);

    procedure SetFrameRange(aFirst: Integer; aLast: Integer);
    function  NextFrame: Boolean;
    function  PrevFrame: Boolean;
    function  GetFrame: Integer;
    procedure SetFrame(aFrame: Integer);
    function  GetFrameFPS: Single;
    procedure SetFrameFPS(aFrameFPS: Single);
    function  GetFirstFrame: Integer;
    function  GetLastFrame: Integer;

    procedure SetPosAbs(aX: Single; aY: Single);
    procedure SetPosRel(aX: Single; aY: Single);
    function  GetPos: TVector;
    function  GetDir: TVector;

    procedure SetScaleAbs(aScale: Single);
    procedure SetScaleRel(aScale: Single);
    function  GetAngle: Single;

    function  GetAngleOffset: Single;
    procedure SetAngleOffset(aAngle: Single);

    procedure RotateAbs(aAngle: Single);
    procedure RotateRel(aAngle: Single);
    function  RotateToAngle(aAngle: Single; aSpeed: Single): Boolean;
    function  RotateToPos(aX: Single; aY: Single; aSpeed: Single): Boolean;
    function  RotateToPosAt(aSrcX: Single; aSrcY: Single; aDestX: Single; aDestY: Single; aSpeed: Single): Boolean;

    procedure Thrust(aSpeed: Single);
    procedure ThrustAngle(aAngle: Single; aSpeed: Single);
    function  ThrustToPos(aThrustSpeed: Single; aRotSpeed: Single; aDestX: Single; aDestY: Single; aSlowdownDist: Single; aStopDist: Single; aStopSpeed: Single; aStopSpeedEpsilon: Single; aDeltaTime: Single): Boolean;

    function  IsVisible(aVirtualX: Single; aVirtualY: Single): Boolean;
    function  IsFullyVisible(aVirtualX: Single; aVirtualY: Single): Boolean;

    function  Overlap(aX: Single; aY: Single; aRadius: Single; aShrinkFactor: Single): Boolean; overload;
    function  Overlap(aEntity: TEntity): Boolean; overload;

    procedure Render(aVirtualX: Single; aVirtualY: Single);
    procedure RenderAt(aX: Single; aY: Single);

    function  GetSprite: TSprite;
    function  GetGroup: Integer;
    function  GetScale: Single;

    function  GetColor: TColor;
    procedure SetColor(aColor: TColor);

    procedure GetFlipMode(aHFlip: PBoolean; aVFlip: PBoolean);
    procedure SetFlipMode(aHFlip: PBoolean; aVFlip: PBoolean);

    function  GetLoopFrame: Boolean;
    procedure SetLoopFrame(aLoop: Boolean);

    function  GetWidth: Single;
    function  GetHeight: Single;
    function  GetRadius: Single;

    function  GetShrinkFactor: Single;
    procedure SetShrinkFactor(aShrinkFactor: Single);

    procedure SetRenderPolyPoint(aRenderPolyPoint: Boolean);
    function  GetRenderPolyPoint: Boolean;
    procedure TracePolyPoint(aMju: Single=6; aMaxStepBack: Integer=12; aAlphaThreshold: Integer=70; aOrigin: PVector=nil);
    function  CollidePolyPoint(aEntity: TEntity; var aHitPos: TVector): Boolean;
    function  CollidePolyPointPoint(var aPoint: TVector): Boolean;
  end;

{ --- VIDEO ----------------------------------------------------------------- }
type
  { Video }
  Video = record
  //protected
  private
    class var
      FVoice: PALLEGRO_VOICE;
      FMixer: PALLEGRO_MIXER;
      FHandle: PALLEGRO_VIDEO;
      FLoop: Boolean;
      FPlaying: Boolean;
      FPaused: Boolean;
      FFilename: string;
    var
    class procedure InitAudio; static;
    class procedure ShutdownAudio; static;
  public
    class procedure FinishedEvent(aHandle: PALLEGRO_VIDEO); static;
    class procedure Setup; static;
    class procedure Shutdown; static;
    //class function  GetHandle: PALLEGRO_VIDEO;

    class procedure Load(aFilename: string); static;
    class procedure Unload; static;

    class function  GetPause: Boolean; static;
    class procedure SetPause(aPause: Boolean); static;
    class function  GetLooping:  Boolean; static;
    class procedure SetLooping(aLoop: Boolean); static;
    class function  GetPlaying: Boolean; static;
    class procedure SetPlaying(aPlay: Boolean); static;
    class function  GetFilename: string; static;

    class procedure Play(aFilename: string; aLoop: Boolean; aGain: Single); overload; static;
    class procedure Play(aLoop: Boolean; aGain: Single); overload; static;
    class procedure Draw(aX: Single; aY: Single); static;

    class procedure GetSize(aWidth: PSingle; aHeight: PSingle); static;
    class procedure Seek(aPos: Single); static;
    class procedure Rewind; static;
  end;

{ --- SCREENSHOT ------------------------------------------------------------ }
type
  { Screenshot }
  Screenshot = record
  private
    class var
      FFlag: Boolean;
      FDir: string;
      FBaseFilename: string;
      FFilename: string;
  public
    class procedure Setup; static;
    class procedure Shutdown; static;
    class procedure Process; static;
    class procedure Init(const aDir: string; const aBaseFilename: string); static;
    class procedure Take; static;
  end;

{ --- SCREENSHAKE ----------------------------------------------------------- }
  { TAScreenshake }
  TAScreenshake = class
  protected
    FActive: Boolean;
    FDuration: Single;
    FMagnitude: Single;
    FTimer: Single;
    FPos: TPointi;
  public
    constructor Create(aDuration: Single; aMagnitude: Single);
    destructor Destroy; override;
    procedure Process(aSpeed: Single; aDeltaTime: Double);
    property Active: Boolean read FActive;
  end;

  { Screenshake }
  Screenshake = record
  private
    class var
      FTrans: ALLEGRO_TRANSFORM;
      FList: TObjectList<TAScreenshake>;
  public
    class procedure Setup; static;
    class procedure Shutdown; static;

    class procedure Process(aSpeed: Single; aDeltaTime: Double); static;

    class procedure Start(aDuration: Single; aMagnitude: Single); static;
    class procedure Clear; static;
    class function  Active: Boolean; static;
  end;

implementation

{$R GameVision.Font.res}

uses
  System.SysUtils,
  System.IOUtils,
  System.Classes,
  System.Math,
  VCL.Graphics,
  VCL.Forms,
  GameVision.Utils,
  GameVision.Input;

{ --- COLOR ----------------------------------------------------------------- }
{ TColor }
function TColor.Make(aRed: Byte; aGreen: Byte; aBlue: Byte; aAlpha: Byte): TColor;
var
  LColor: ALLEGRO_COLOR absolute Result;
begin
  LColor := al_map_rgba(aRed, aGreen, aBlue, aAlpha);
  Red := LColor.r;
  Green := LColor.g;
  Blue := LColor.b;
  Alpha := LColor.a;
end;

function TColor.Make(aRed: Single; aGreen: Single; aBlue: Single; aAlpha: Single): TColor;
var
  LColor: ALLEGRO_COLOR absolute Result;
begin
  LColor := al_map_rgba_f(aRed, aGreen, aBlue, aAlpha);
  Red := LColor.r;
  Green := LColor.g;
  Blue := LColor.b;
  Alpha := LColor.a;
end;

function TColor.Make(const aName: string): TColor;
var
  LColor: ALLEGRO_COLOR absolute Result;
begin
  LColor := al_color_name(PAnsiChar(AnsiString(aName)));
  Red := LColor.r;
  Green := LColor.g;
  Blue := LColor.b;
  Alpha := LColor.a;
end;

function TColor.Fade(aTo: TColor; aPos: Single): TColor;
var
  LColor: TColor;
begin
  // clip to ranage 0.0 - 1.0
  if aPos < 0 then
    aPos := 0
  else if aPos > 1.0 then
    aPos := 1.0;

  // fade colors
  LColor.Alpha := Alpha + ((aTo.Alpha - Alpha) * aPos);
  LColor.Blue := Blue + ((aTo.Blue - Blue) * aPos);
  LColor.Green := Green + ((aTo.Green - Green) * aPos);
  LColor.Red := Red + ((aTo.Red - Red) * aPos);
  Result := Make(LColor.Red, LColor.Green, LColor.Blue, LColor.Alpha);
  Red := LColor.Red;
  Green := LColor.Green;
  Blue := LColor.Blue;
  Alpha := LColor.Alpha;
end;

function TColor.Equal(aColor: TColor): Boolean;
begin
  if (Red = aColor.Red) and (Green = aColor.Green) and
    (Blue = aColor.Blue) and (Alpha = aColor.Alpha) then
    Result := True
  else
    Result := False;
end;

{ --- VIEWPORT -------------------------------------------------------------- }
{ TViewport }
procedure TViewport.Clean;
begin
  if FBitmap <> nil then
  begin
    if FActive then
    begin
      // this fixes the is issue where if the active viewport is destroyed
      // while active, then just pass nil to Display.SetViewport to restore
      // the fullscreen viewport instead
      Display.SetViewport(nil);
    end;
    SetActive(False);
    FreeAndNil(FBitmap);
    FActive := FAlse;
    FBitmap := nil;
    FPos.X := 0;
    FPos.Y := 0;
    FPos.Width := 0;
    FPos.Height := 0;
    FAngle := 0;
  end;
end;

constructor TViewport.Create;
begin
  inherited;

  FBitmap := nil;
  FActive := False;
  FPos.X := 0;
  FPos.Y := 0;
  FPos.Width := 0;
  FPos.Height := 0;
  FAngle := 0;
  FCenter.X := 0.5;
  FCenter.Y := 0.5;
end;

destructor TViewport.Destroy;
begin
  Clean;

  inherited;
end;

procedure TViewport.Init(aX: Integer; aY: Integer; aWidth: Integer; aHeight: Integer);
begin
  Clean;
  FActive := False;
  FBitmap := TBitmap.Create;
  if FBitmap <> nil then
  begin
    FBitmap.Allocate(aWidth, aHeight);
    FPos.X := aX;
    FPos.Y := aY;
    FPos.Width := aWidth;
    FPos.Height := aHeight;

    FHalf.X := aWidth/2;
    FHalf.Y := aHeight/2;
  end;
end;

procedure TViewport.SetActive(aActive: Boolean);
begin
  if FBitmap = nil then Exit;

  if aActive then
    begin
      if FActive then Exit;
      Display.SetTarget(FBitmap);
    end
  else
    begin
      if not FActive then Exit;
      Display.ResetTarget;
      FBitmap.Draw(FPos.X+FHalf.X, FPos.Y+FHalf.Y, nil, @FCenter, nil, FAngle, WHITE, False, False);
    end;

  FActive := aActive;
end;

function TViewport.GetActive: Boolean;
begin
  Result := FActive;
end;

procedure TViewport.SetPosition(aX: Integer; aY: Integer);
begin
  if FBitmap = nil then Exit;
  FPos.X := aX;
  FPos.Y := aY;
end;

procedure TViewport.GetSize(aX: PInteger; aY: PInteger; aWidth: PInteger; aHeight: PInteger);
begin
  if FBitmap = nil then Exit;

  if aX <> nil then
    aX^ := Round(FPos.X);
  if aY <>nil then
    aY^ := Round(FPos.Y);
  if aWidth <> nil then
    aWidth^ := Round(FPos.Width);
  if aHeight <> nil then
    aHeight^ := Round(FPos.Height);
end;

procedure TViewport.SetAngle(aAngle: Single);
begin
  FAngle := aAngle;
  //gEngine.Math.ClipValue(FAngle, 0, 359, True);
  if FAngle > 359 then
    begin
      while FAngle > 359 do
      begin
        FAngle := FAngle - 359;
      end;
    end
  else
  if FAngle < 0 then
    begin
      while FAngle < 0 do
      begin
        FAngle := FAngle + 359;
      end;
    end;
end;

function  TViewport.GetAngle: Single;
begin
  Result := FAngle;
end;

procedure TViewport.Align(var aX: Single; var aY: Single);
begin
  aX := FPos.X + aX;
  aY := FPos.Y + aY;
end;

procedure TViewport.Align(var aPos: TVector);
begin
  aPos.X := FPos.X + aPos.X;
  aPos.Y := FPos.Y + aPos.Y;
end;

class function TViewport.CreateViewport(aX: Integer; aY: Integer; aWidth: Integer; aHeight: Integer): TViewport;
begin
  Result := TViewport.Create;
  Result.Init(aX, aY, aWidth, aHeight);
end;

{ --- BITMAP ---------------------------------------------------------------- }
{ TBitmap }
constructor TBitmap.Create;
begin
  inherited;

  FHandle := nil;
  Unload;
end;

destructor TBitmap.Destroy;
begin
  Unload;

  inherited;
end;

procedure TBitmap.Allocate(aWidth: Integer; aHeight: Integer);
begin
  Unload;
  al_set_new_bitmap_flags(ALLEGRO_MIN_LINEAR or ALLEGRO_MAG_LINEAR or ALLEGRO_MIPMAP or ALLEGRO_VIDEO_BITMAP);
  FHandle := al_create_bitmap(aWidth, aHeight);
  if FHandle <> nil then
    begin
      FWidth := al_get_bitmap_width(FHandle);
      FHeight := al_get_bitmap_height(FHandle);
      FFilename := '';
      Logger.Log('Successfully allocated (%d x %d) bitmap', [aWidth, aHeight]);
    end
  else
    begin
      Logger.Log('Failed to allocate (%d x %d) bitmap', [aWidth, aHeight]);
    end;
end;

procedure TBitmap.Load(aFilename: string; aColorKey: PColor);
var
  LMarsheller: TMarshaller;
  LColorKey: PALLEGRO_COLOR absolute aColorKey;
begin
  if aFilename.IsEmpty then Exit;

  if not al_filename_exists(LMarsheller.AsAnsi(aFilename).ToPointer) then
  begin
    Logger.Log('Bitmap file was not found: %s', [aFilename]);
    Exit;
  end;

  Unload;

  al_set_new_bitmap_flags(ALLEGRO_MIN_LINEAR or ALLEGRO_MAG_LINEAR or ALLEGRO_VIDEO_BITMAP);
  FHandle := al_load_bitmap(Engine.GetArchiveItemFilename(aFilename));
  if FHandle <> nil then
    begin
      FWidth := al_get_bitmap_width(FHandle);
      FHeight := al_get_bitmap_height(FHandle);

      // apply colorkey
      if aColorKey <> nil then
      begin
        al_convert_mask_to_alpha(FHandle, LColorKey^)
      end;

      FFilename := aFilename;
      Logger.Log('Successfully loaded bitmap "%s"', [aFilename]);
    end
  else
    begin
      Logger.Log('Failed to load bitmap "%s"', [aFilename]);
    end;
end;

procedure TBitmap.Unload;
begin
  if FHandle <> nil then
  begin
    al_destroy_bitmap(FHandle);
    FHandle := nil;
    if not FFilename.IsEmpty then
      Logger.Log('Unloaded bitmap "%s"', [FFilename])
    else
      Logger.Log('Unloaded (%f x %f) bitmap', [FWidth, FHeight]);
    FFilename := ''
  end;
  FWidth := 0;
  FHeight := 0;
  FLocked := False;
  FLockedRegion.X := 0;
  FLockedRegion.Y := 0;
  FLockedRegion.Width := 0;
  FLockedRegion.Height := 0;
end;

procedure TBitmap.GetSize(var aSize: TVector);
begin
  aSize.X := FWidth;
  aSize.Y := FHeight;
end;

procedure TBitmap.GetSize(aWidth: PSingle; aHeight: PSingle);
begin
  if aWidth <> nil then aWidth^ := FWidth;
  if aHeight <> nil then aHeight^ := FHeight;
end;

procedure TBitmap.Lock(aRegion: PRectangle; aData: PBitmapData);
var
  LLock: PALLEGRO_LOCKED_REGION;
begin
  if FHandle = nil then Exit;

  LLock := nil;

  if not FLocked then
  begin
    if aRegion <> nil then
      begin
        LLock := al_lock_bitmap_region(FHandle, Round(aRegion.X), Round(aRegion.Y), Round(aRegion.Width), Round(aRegion.Height), ALLEGRO_PIXEL_FORMAT_ANY, ALLEGRO_LOCK_READWRITE);
        FLockedRegion.X := aRegion.X;
        FLockedRegion.Y := aRegion.Y;
        FLockedRegion.Width := aRegion.Width;
        FLockedRegion.Height := aRegion.Height;
      end
    else
      begin
        LLock := al_lock_bitmap(FHandle, ALLEGRO_PIXEL_FORMAT_ANY, ALLEGRO_LOCK_READWRITE);
        FLockedRegion.X := 0;
        FLockedRegion.Y := 0;
        FLockedRegion.Width := FWidth;
        FLockedRegion.Height := FHeight;
      end;
    FLocked := True;
    Display.SetTarget(FHandle);
  end;

  if LLock <> nil then
  begin
    if aData <> nil then
    begin
      aData.Memory := LLock.data;
      aData.Format := LLock.format;
      aData.Pitch := LLock.pitch;
      aData.PixelSize := LLock.pixel_size;
    end;
  end;

end;

procedure TBitmap.Unlock;
begin
  if FHandle = nil then Exit;
  if FLocked then
  begin
    al_unlock_bitmap(FHandle);
    FLocked := False;
    FLockedRegion.X := 0;
    FLockedRegion.Y := 0;
    FLockedRegion.Width := 0;
    FLockedRegion.Height := 0;
    Display.ResetTarget;
  end;
end;

function TBitmap.GetPixel(aX: Integer; aY: Integer): TColor;
var
  LX,LY: Integer;
  LResult: ALLEGRO_COLOR absolute Result;
begin
  if FHandle = nil then Exit;

  LX := Round(aX + FLockedRegion.X);
  LY := Round(aY + FlockedRegion.Y);
  LResult := al_get_pixel(FHandle, LX, LY);
end;

procedure TBitmap.PutPixel(aX: Integer; aY: Integer; aColor: TColor);
var
  LX,LY: Integer;
  LColor: ALLEGRO_COLOR absolute aColor;
begin
  if FHandle = nil then Exit;

  LX := Round(aX + FLockedRegion.X);
  LY := Round(aY + FlockedRegion.Y);
  al_put_pixel(LX, LY, LColor);
end;

procedure TBitmap.Draw(aX, aY: Single; aRegion: PRectangle; aCenter: PVector; aScale: PVector; aAngle: Single; aColor: TColor; aHFlip: Boolean; aVFlip: Boolean);
var
  LA: Single;
  LRG: TRectangle;
  LCP: TVector;
  LSC: TVector;
  LC: ALLEGRO_COLOR absolute aColor;
  LFlags: Integer;
begin
  if FHandle = nil then Exit;

  // angle
  LA := aAngle * DEG2RAD;

  // region
  if Assigned(aRegion) then
    begin
      LRG.X := aRegion.X;
      LRG.Y := aRegion.Y;
      LRG.Width := aRegion.Width;
      LRG.Height := aRegion.Height;
    end
  else
    begin
      LRG.X := 0;
      LRG.Y := 0;
      LRG.Width := FWidth;
      LRG.Height := FHeight;
    end;

  if LRG.X < 0 then
    LRG.X := 0;
  if LRG.X > FWidth - 1 then
    LRG.X := FWidth - 1;

  if LRG.Y < 0 then
    LRG.Y := 0;
  if LRG.Y > FHeight - 1 then
    LRG.Y := FHeight - 1;

  if LRG.Width < 0 then
    LRG.Width := 0;
  if LRG.Width > FWidth then
    LRG.Width := LRG.Width;

  if LRG.Height < 0 then
    LRG.Height := 0;
  if LRG.Height > FHeight then
    LRG.Height := LRG.Height;

  // center
  if Assigned(aCenter) then
    begin
      LCP.X := (LRG.Width * aCenter.X);
      LCP.Y := (LRG.Height * aCenter.Y);
    end
  else
    begin
      LCP.X := 0;
      LCP.Y := 0;
    end;

  // scale
  if Assigned(aScale) then
    begin
      LSC.X := aScale.X;
      LSC.Y := aScale.Y;
    end
  else
    begin
      LSC.X := 1;
      LSC.Y := 1;
    end;

  // flags
  LFlags := 0;
  if aHFlip then LFlags := LFlags or ALLEGRO_FLIP_HORIZONTAL;
  if aVFlip then LFlags := LFlags or ALLEGRO_FLIP_VERTICAL;

  // render
  al_draw_tinted_scaled_rotated_bitmap_region(FHandle, LRG.X, LRG.Y, LRG.Width, LRG.Height, LC, LCP.X, LCP.Y, aX, aY, LSC.X, LSC.Y, LA, LFlags);
end;

procedure TBitmap.Draw(aX, aY, aScale, aAngle: Single; aColor: TColor; aHAlign: THAlign; aVAlign: TVAlign; aHFlip: Boolean=False; aVFlip: Boolean=False);
var
  LCenter: TVector;
  LScale: TVector;
begin
  LCenter.X := 0;
  LCenter.Y := 0;

  LScale.X := aScale;
  LScale.Y := aScale;

  case aHAlign of
    haLeft  : LCenter.X := 0;
    haCenter: LCenter.X := 0.5;
    haRight : LCenter.X := 1;
  end;

  case aVAlign of
    vaTop   : LCenter.Y := 0;
    vaCenter: LCenter.Y := 0.5;
    vaBottom: LCenter.Y := 1;
  end;

  Draw(aX, aY, nil, @LCenter, @LScale, aAngle, aColor, aHFlip, aVFlip);
end;

procedure TBitmap.DrawTiled(aDeltaX: Single; aDeltaY: Single);
var
  LW,LH    : Integer;
  LOX,LOY  : Integer;
  LPX,LPY  : Single;
  LFX,LFY  : Single;
  LTX,LTY  : Integer;
  LVPW,LVPH: Integer;
  LVR,LVB  : Integer;
  LIX,LIY  : Integer;
begin
  Display.GetViewportSize(nil, nil, @LVPW, @LVPH);

  LW := Round(FWidth);
  LH := Round(FHeight);

  LOX := -LW+1;
  LOY := -LH+1;

  LPX := aDeltaX;
  LPY := aDeltaY;

  LFX := LPX-floor(LPX);
  LFY := LPY-floor(LPY);

  LTX := floor(LPX)-LOX;
  LTY := floor(LPY)-LOY;

  if (LTX>=0) then LTX := LTX mod LW + LOX else LTX := LW - -LTX mod LW + LOX;
  if (LTY>=0) then LTY := LTY mod LH + LOY else LTY := LH - -LTY mod LH + LOY;

  LVR := LVPW;
  LVB := LVPH;
  LIY := LTY;

  while LIY<LVB do
  begin
    LIX := LTX;
    while LIX<LVR do
    begin
      al_draw_bitmap(FHandle, LIX+LFX, LIY+LFY, 0);
      LIX := LIX+LW;
    end;
   LIY := LIY+LH;
  end;
end;

class function TBitmap.LoadBitmap(aFilename: string; aColorKey: PColor): TBitmap;
begin
  Result := TBitmap.Create;
  Result.Load(aFilename, aColorKey);
end;

{ --- DISPLAY --------------------------------------------------------------- }
{ Display }
class procedure Display.ResizeForDPI;
begin
  var LDpi: Integer := GetDpiForWindow(al_get_win_window_handle(FHandle));
  var LSX,LSY: Integer;
  LSX := MulDiv(Round(FSize.X), LDPI, DISPLAY_DEFAULT_DPI);
  LSY := MulDiv(Round(FSize.Y), LDpi, DISPLAY_DEFAULT_DPI);

  var LWH: HWND := al_get_win_window_handle(FHandle);
  var LWX,LWY,LHW,LHH: integer;
  al_get_window_position(FHandle, @LWX, @LWY);

  LHW := (LSX - Round(FSize.X)) div 2;
  LHH := (LSY - Round(FSize.Y)) div 2;

  al_set_window_position(FHandle, LWX-LHW, LWY-LHH);
  al_resize_display(FHandle, LSX, LSY);

  var LScale: Single := min(LSX / FSize.x, LSY / FSize.Y);
  al_set_clipping_rectangle(0, 0, LSX, LSY);
  FTransSize.X := 0;
  FTransSize.Y := 0;
  FTransSize.Width := LSX;
  FTransSize.Height := LSY;
  FTransScale := LScale;
  al_build_transform(@FTrans, 0, 0, LScale, LScale, 0);
  al_use_transform(@FTrans);

  SetWindowLong(LWH, GWL_STYLE, GetWindowLong(LWH, GWL_STYLE) and (not WS_SIZEBOX));
  FixupWindow;
end;

class procedure Display.FixupWindow;
begin
  var LWW: Integer := al_get_display_width(FHandle);
  var LWH: Integer := al_get_display_height(FHandle);
  al_resize_display(FHandle, LWW+1, LWH+1);
  al_resize_display(FHandle, LWW, LWH);
end;

class function Display.TransformScale(aFullscreen: Boolean): Single;
var
  LScreenX, LScreenY: Integer;
  LScaleX, LScaleY: Single;
  LClipX, LClipY: Single;
  LScale: Single;
begin
  Result := 1;
  if FHandle = nil then Exit;

  LScreenX := al_get_display_width(FHandle);
  LScreenY := al_get_display_height(FHandle);

  if aFullscreen then
    begin
      LScaleX := LScreenX / FSize.X;
      LScaleY := LScreenY / FSize.Y;
      LScale := min(LScaleX, LScaleY);
      LClipX := (LScreenX - LScale * FSize.X) / 2;
      LClipY := (LScreenY - LScale * FSize.Y) / 2;
      al_build_transform(@FTrans, LClipX, LClipY, LScale, LScale, 0);
      al_use_transform(@FTrans);
      al_set_clipping_rectangle(Round(LClipX), Round(LClipY), Round(LScreenX - 2 * LClipX), Round(LScreenY - 2 * LClipY));
      FTransSize.X := LClipX;
      FTransSize.Y := LClipY;
      FTransSize.Width := LScreenX - 2 * LClipX;
      FTransSize.Height := LScreenY - 2 * LClipY;
      Result := LScale;
      FTransScale := LScale;

      // calc left blackbar
      FBlackbar[0].X := 0;
      FBlackbar[0].Y := 0;
      FBlackbar[0].Width := FTransSize.X;
      FBlackbar[0].Height := LScreenY;

      // calc right blackbar
      FBlackbar[1].X := FTransSize.X + FTransSize.Width;
      Fblackbar[1].Y := 0;
      FBlackbar[1].Width := LScreenX - FBlackbar[1].X;
      FBlackbar[1].Height := LScreenY;

      // calc top blackbar
      FBlackbar[2].X := FTransSize.X;
      FBlackbar[2].Y := 0;
      FBlackbar[2].Width := FTransSize.Width;
      FBlackbar[2].Height := FTransSize.Y;

      // calc bottom blackbar
      FBlackbar[3].X := FTransSize.X;
      FBlackbar[3].Y := FTransSize.Y+FTransSize.Height;
      FBlackbar[3].Width := FTransSize.Width;
      FBlackbar[3].Height := LScreenY - FBlackbar[3].Y;

    end
  else
    begin
      al_identity_transform(@FTrans);
      al_use_transform(@FTrans);
      al_set_clipping_rectangle(0, 0, Round(LScreenX), Round(LScreenY));
      FTransSize.X := 0;
      FTransSize.Y := 0;
      FTransSize.Width := LScreenX;
      FTransSize.Height := LScreenY;
      FTransScale := 1;
    end;
end;

class procedure Display.LoadDefaultIcon;
var
  LWnd: HWND;
  LHnd: THandle;
  LIco: TIcon;
begin
  if FHandle = nil then Exit;
  LHnd := GetModuleHandle(nil);
  if LHnd <> 0 then
  begin
    if FindResource(LHnd, 'MAINICON', RT_GROUP_ICON) <> 0 then
    begin
      LIco := TIcon.Create;
      LIco.LoadFromResourceName(LHnd, 'MAINICON');
      LWnd := al_get_win_window_handle(FHandle);
      SendMessage(LWnd, WM_SETICON, ICON_BIG, LIco.Handle);
      FreeAndNil(LIco);
    end;
  end;
end;

class procedure Display.ClearBlackbars;
var
  I: Integer;
  cx,cy,cw,ch: Integer;
begin
  if not FFullscreen then exit;
  al_get_clipping_rectangle(@cx, @cy, @cw, @ch);
  al_reset_clipping_rectangle;
  for I := 0 to 3 do
  begin
    al_set_clipping_rectangle(Round(FBlackbar[I].X), Round(FBlackbar[I].Y), Round(FBlackbar[I].Width), Round(FBlackbar[I].Height));
    Clear(BLACK);
  end;
  al_set_clipping_rectangle(cx, cy, cw, ch);
end;

class function Display.GetHandle: PALLEGRO_DISPLAY;
begin
  Result := FHandle;
end;

class function Display.GetFullscreen: Boolean;
begin
  Result := FFullscreen;
end;

class function Display.GetReady: Boolean;
begin
  Result := FReady;
end;

class procedure Display.SetReady(aReady: Boolean);
begin
  FReady := aReady;
end;

class function Display.GetTransSize: TRectangle;
begin
  Result := FTransSize;
end;

class function Display.GetTransScale: Single;
begin
  Result := FTransScale;
end;

class function Display.GetTrans: ALLEGRO_TRANSFORM;
begin
  Result := FTrans;
end;

class procedure Display.Setup;
begin
  FHandle := nil;
  Logger.Log('Initialized %s Subsystem', ['Display']);
end;

class procedure Display.Shutdown;
begin
  Close;
  Logger.Log('Shutdown %s Subsystem', ['Display']);
end;

class function Display.Open(aWidth: Integer; aHeight: Integer; aFullscreen: Boolean; aTitle: string): Boolean;
var
  LFlags: Integer;
begin
  Result := False;
  //LFlags :=  ALLEGRO_OPENGL or ALLEGRO_RESIZABLE or ALLEGRO_PROGRAMMABLE_PIPELINE;
  LFlags :=  ALLEGRO_DIRECT3D or ALLEGRO_RESIZABLE or ALLEGRO_PROGRAMMABLE_PIPELINE;
  if aFullscreen then LFlags := LFlags or ALLEGRO_FULLSCREEN_WINDOW;
  al_set_new_display_option(ALLEGRO_COMPATIBLE_DISPLAY, 1, ALLEGRO_REQUIRE);
  al_set_new_display_option(ALLEGRO_VSYNC, 1, ALLEGRO_SUGGEST);
  al_set_new_display_option(ALLEGRO_CAN_DRAW_INTO_BITMAP, 1, ALLEGRO_SUGGEST);
  al_set_new_window_title(PAnsiChar(AnsiString(aTitle)));
  al_set_new_display_flags(LFlags);
  al_set_new_display_option(ALLEGRO_SAMPLE_BUFFERS, 1, ALLEGRO_SUGGEST);
  al_set_new_display_option(ALLEGRO_SAMPLES, 8, ALLEGRO_SUGGEST);
  Engine.OnDisplayOpenBefore;

  FHandle := al_create_display(aWidth, aHeight);
  if FHandle <> nil then begin
    Clear(BLACK); Show;
    al_register_event_source(Engine.Queue, al_get_display_event_source(FHandle));
    LoadDefaultIcon;
    FSize.X := aWidth;
    FSize.Y := aHeight;
    TransformScale(aFullscreen);
    ResizeForDPI;
    Clear(BLACK); Show;
    FFullscreen := aFullscreen;
    FReady := True;
    Result := True;
    Engine.OnDisplayOpenAfter;
    Logger.Log('Succesfully initialized Display to %d x %d resolution', [aWidth, aHeight]);
  end
  else begin
    Logger.Log('Failed to initialize.', [aWidth, aHeight]);
  end;
end;

class function Display.Close: Boolean;
var
  LWH: HWND;
begin
  Result := False;
  if FHandle <> nil then
  begin
    al_unregister_event_source(Engine.Queue,  al_get_display_event_source(FHandle));

    // NOTE: hide window to prevent show default icon for a split second when
    // you have a custom icon set. It's annoying!!! Apparently, allegro restores
    // the defalt icon during destry.
    LWH := al_get_win_window_handle(FHandle);
    ShowWindow(LWH, SW_HIDE);
    Engine.OnDisplayCloseBefore;
    al_destroy_display(FHandle);
    FHandle := nil;
    Result := True;
    Engine.OnDisplayCloseAfter;
    Logger.Log('Succesfully Closed Display', []);
  end;
end;

class function Display.Opened: Boolean;
begin
  Result := Boolean(FHandle <> nil);
end;

class procedure Display.SetPosition(aX: Integer; aY: Integer);
begin
  if FHandle = nil then Exit;
  al_set_window_position(FHandle, aX, aY);
end;

class procedure Display.Clear(aColor: TColor);
var
  color: ALLEGRO_COLOR absolute aColor;
begin
  if FHandle = nil then Exit;
  al_clear_to_color(color);
end;

class procedure Display.Show;
begin
  if FHandle = nil then Exit;
  Clearblackbars;
  al_flip_display;
end;

class procedure Display.ToggleFullscreen;
var
  LFlags: Integer;
  LFullscreen: Boolean;
  LMX, LMY: Integer;

  function IsOnPrimaryMonitor: Boolean;
  begin
    Result := Screen.MonitorFromWindow(al_get_win_window_handle(FHandle), mdPrimary).Primary
  end;

begin
  if FHandle = nil then Exit;
  Input.MouseGetInfo(@LMX, @LMY, nil);
  LFlags := al_get_display_flags(FHandle);
  LFullscreen := Boolean(LFlags and ALLEGRO_FULLSCREEN_WINDOW = ALLEGRO_FULLSCREEN_WINDOW);
  LFullscreen := not LFullscreen;

  // we can only go fullscreen on primrary monitor
  if LFullscreen and (not IsOnPrimaryMonitor) then Exit;

  al_set_display_flag(FHandle, ALLEGRO_FULLSCREEN_WINDOW, LFullscreen);
  TransformScale(LFullscreen);
  FFullscreen := LFullscreen;
  if not FFullscreen then ResizeForDPI;
  Input.MouseSetPos(LMX, LMY);
  Engine.OnDisplayToggleFullscreen(FFullscreen);
  Input.MouseShowCursor(True);
end;

class procedure Display.ResetTransform;
begin
  if FHandle = nil then Exit;
  al_use_transform(@FTrans);
end;

class procedure Display.SetTransformPosition(aX: Integer; aY: Integer);
var
  LTrans: ALLEGRO_TRANSFORM;
begin
  if FHandle = nil then Exit;
  al_copy_transform(@LTrans, al_get_current_transform);
  al_translate_transform(@LTrans, aX, aY);
  al_use_transform(@LTrans);
end;

class procedure Display.SetTransformAngle(aAngle: Single);
var
  LTrans: ALLEGRO_TRANSFORM;
  LX, LY: Integer;
begin
  if FHandle = nil then Exit;
  LX := al_get_display_width(FHandle);
  LY := al_get_display_height(FHandle);

  al_copy_transform(@FTrans, al_get_current_transform);
  al_translate_transform(@FTrans, -(LX div 2), -(LY div 2));
  al_rotate_transform(@LTrans, aAngle * DEG2RAD);
  al_translate_transform(@LTrans, 0, 0);
  al_translate_transform(@LTrans, LX div 2, LY div 2);
  al_use_transform(@LTrans);
end;

class procedure Display.GetSize(aWidth: PInteger; aHeight: System.PInteger; aAspectRatio: PSingle=nil);
begin
  if FHandle = nil then  Exit;
  if aWidth <> nil then
    aWidth^ := Round(FSize.X);

  if aHeight <> nil then
    aHeight^ := Round(FSize.Y);

  if aAspectRatio <> nil then
    aAspectRatio^ := FSize.X / FSize.Y;
end;

class procedure Display.SetTarget(aBitmap: TBitmap);
begin
  if aBitmap <> nil then
  begin
    if aBitmap.Handle <> nil then
    begin
      al_set_target_bitmap(aBitmap.Handle);
    end;
  end;
end;

class procedure Display.ResetTarget;
begin
  if FHandle = nil then Exit;
  al_set_target_backbuffer(FHandle);
end;

class procedure Display.AlignToViewport(var aX: Single; var aY: Single);
var
  LVP: TRectangle;
begin
  GetViewportSize(LVP);
  aX := LVP.X + aX;
  aY := LVP.Y + aY;
end;

// TODO: handle case where viewport object is destroyed
// while still being active, FViewport will then be
// invalid. A possible solution would be to have a parent
// in TViewport and if its destroyed then let parent know
// so it can take appropriet action
// UPDATE: now what I do is if the current view is about
// to be destroyed, if its active, it call SetViewport(nil)
// to deactivate before its released to set the viewport
// back to full screen.
class procedure Display.SetViewport(aViewport: TViewport);
begin
  if FHandle = nil then Exit;

  if aViewport <> nil then
    begin
      // check if same as current
      if FViewport = aViewport then
        Exit
      else
      // setting a new viewport when one is current
      begin
        // set to not active to show it
        if FViewport <> nil then
        begin
          TViewport(FViewport).SetActive(False);
        end;
      end;

      FViewport := aViewport;
      TViewport(FViewport).SetActive(True);
    end
  else
    begin
      if FViewport <> nil then
      begin
        TViewport(FViewport).SetActive(False);
        FViewport := nil;
      end;
    end;
end;

class procedure Display.ResetViewport;
begin
  if FHandle = nil then Exit;
  if FViewport <> nil then
  begin
    TViewport(FViewport).SetActive(False);
  end;
end;

class procedure Display.GetViewportSize(aX: PInteger; aY: PInteger; aWidth: PInteger; aHeight: PInteger);
begin
  if FHandle = nil then Exit;

  if FViewport <> nil then
    begin
      FViewport.GetSize(aX, aY, aWidth, aHeight);
    end
  else
    begin
      if aX <> nil then
        aX^ := 0;
      if aY <> nil then
        aY^ := 0;
      GetSize(aWidth, aHeight);
    end;
end;

class procedure Display.GetViewportSize(var aSize: TRectangle);
var
  LVX,LVY,LVW,LVH: Integer;
begin
  GetViewportSize(@LVX, @LVY, @LVW, @LVH);
  aSize.X := LVX;
  aSize.Y := LVY;
  aSize.Width := LVW;
  aSize.Height := LVH;
end;

class procedure Display.DrawLine(aX1, aY1, aX2, aY2: Single; aColor: TColor; aThickness: Single);
var
  LColor: ALLEGRO_COLOR absolute aColor;
begin
  if FHandle = nil then Exit;
  al_draw_line(aX1, aY1, aX2, aY2, LColor, aThickness);
end;

class procedure Display.DrawRectangle(aX, aY, aWidth, aHeight, aThickness: Single; aColor: TColor);
var
  LColor: ALLEGRO_COLOR absolute aColor;
begin
  if FHandle = nil then Exit;
  al_draw_rectangle(aX, aY, aX + aWidth, aY + aHeight, LColor, aThickness);
end;

class procedure Display.DrawFilledRectangle(aX, aY, aWidth, aHeight: Single; aColor: TColor);
var
  LColor: ALLEGRO_COLOR absolute aColor;
begin
  if FHandle= nil then Exit;
  al_draw_filled_rectangle(aX, aY, aX + aWidth, aY + aHeight, LColor);
end;

class procedure Display.DrawCircle(aX, aY, aRadius, aThickness: Single; aColor: TColor);
var
  LColor: ALLEGRO_COLOR absolute aColor;
begin
  if FHandle = nil then Exit;
  al_draw_circle(aX, aY, aRadius, LColor, aThickness);
end;

class procedure Display.DrawFilledCircle(aX, aY, aRadius: Single; aColor: TColor);
var
  LColor: ALLEGRO_COLOR absolute aColor;
begin
  if FHandle = nil then Exit;
  al_draw_filled_circle(aX, aY, aRadius, LColor);
end;

class procedure Display.DrawPolygon(aVertices: System.PSingle; aVertexCount: Integer; aThickness: Single; aColor: TColor);
var
  LColor: ALLEGRO_COLOR absolute aColor;
begin
  if FHandle = nil then Exit;
  al_draw_polygon(WinApi.Windows.PSingle(aVertices), aVertexCount, ALLEGRO_LINE_JOIN_ROUND, LColor, aThickness, 1.0);
end;

class procedure Display.DrawFilledPolygon(aVertices: System.PSingle; aVertexCount: Integer; aColor: TColor);
var
  LColor: ALLEGRO_COLOR absolute aColor;
begin
  if FHandle = nil then Exit;
  al_draw_filled_polygon(WinApi.Windows.PSingle(aVertices), aVertexCount, LColor);
end;

class procedure Display.DrawTriangle(aX1, aY1, aX2, aY2, aX3, aY3, aThickness: Single; aColor: TColor);
var
  LColor: ALLEGRO_COLOR absolute aColor;
begin
  if FHandle = nil then Exit;
  al_draw_triangle(aX1, aY1, aX2, aY2, aX3, aY3, LColor, aThickness);
end;

class procedure Display.DrawFilledTriangle(aX1, aY1, aX2, aY2, aX3, aY3: Single; aColor: TColor);
var
  LColor: ALLEGRO_COLOR absolute aColor;
begin
  if FHandle = nil then Exit;
  al_draw_filled_triangle(aX1, aY1, aX2, aY2, aX3, aY3, LColor);
end;

class procedure Display.SetBlender(aOperation: Integer; aSource: Integer; aDestination: Integer);
begin
  if FHandle = nil then Exit;
  al_set_blender(aOperation, aSource, aDestination);
end;

class procedure Display.GetBlender(aOperation: PInteger; aSource: PInteger; aDestination: PInteger);
begin
  if FHandle = nil then Exit;
  al_get_blender(aOperation, aSource, aDestination);
end;

class procedure Display.SetBlendColor(aColor: TColor);
var
  LColor: ALLEGRO_COLOR absolute aColor;
begin
  if FHandle = nil then Exit;
  al_set_blend_color(LColor);
end;

class function Display.GetBlendColor: TColor;
var
  LResult: ALLEGRO_COLOR absolute Result;
begin
  Result := BLANK;
  if FHandle = nil then Exit;
  LResult := al_get_blend_color;
end;

class procedure Display.SetBlendMode(aMode: TBlendMode);
begin
  if FHandle = nil then Exit;

  case aMode of
    bmPreMultipliedAlpha:
      begin
        al_set_blender(ALLEGRO_ADD, ALLEGRO_ONE, ALLEGRO_INVERSE_ALPHA);
      end;
    bmNonPreMultipliedAlpha:
      begin
        al_set_blender(ALLEGRO_ADD, ALLEGRO_ALPHA, ALLEGRO_INVERSE_ALPHA);
      end;
    bmAdditiveAlpha:
      begin
        al_set_blender(ALLEGRO_ADD, ALLEGRO_ONE, ALLEGRO_ONE);
      end;
    bmCopySrcToDest:
      begin
        al_set_blender(ALLEGRO_ADD, ALLEGRO_ONE, ALLEGRO_ZERO);
      end;
    bmMultiplySrcAndDest:
      begin
        al_set_blender(ALLEGRO_ADD, ALLEGRO_DEST_COLOR, ALLEGRO_ZERO)
      end;
  end;
end;

class procedure Display.SetBlendModeColor(aMode: TBlendModeColor; aColor: TColor);
begin
  if FHandle = nil then Exit;
  case aMode of
    bcColorNormal:
      begin
        al_set_blender(ALLEGRO_ADD, ALLEGRO_CONST_COLOR, ALLEGRO_ONE);
        al_set_blend_color(al_map_rgba_f(aColor.red, aColor.green, aColor.blue, aColor.alpha));
      end;
    bcColorAvgSrcDest:
      begin
        al_set_blender(ALLEGRO_ADD, ALLEGRO_CONST_COLOR, ALLEGRO_CONST_COLOR);
        al_set_blend_color(al_map_rgba_f(aColor.red, aColor.green, aColor.blue, aColor.alpha));
      end;
  end;
end;

class procedure Display.RestoreDefaultBlendMode;
begin
  if FHandle = nil then  Exit;
  al_set_blender(ALLEGRO_ADD, ALLEGRO_ONE, ALLEGRO_INVERSE_ALPHA);
  al_set_blend_color(al_map_rgba(255, 255, 255, 255));
end;

class procedure Display.Save(aFilename: string);
var
  LBackbuffer: PALLEGRO_BITMAP;
  LScreenshot: PALLEGRO_BITMAP;
  LVX, LVY, LVW, LVH: Integer;
  LFilename: string;
begin
  if FHandle = nil then Exit;

  // get viewport size
  LVX := Round(FTransSize.X);
  LVY := Round(FTransSize.Y);
  LVW := Round(FTransSize.Width);
  LVH := Round(FTransSize.Height);

  // create LScreenshot bitmpat
  al_set_new_bitmap_flags(ALLEGRO_MIN_LINEAR or ALLEGRO_MAG_LINEAR);
  LScreenshot := al_create_bitmap(LVW, LVH);

  // exit if failed to create LScreenshot bitmap
  if LScreenshot = nil then Exit;

  // get LBackbuffer
  LBackbuffer := al_get_backbuffer(FHandle);

  // set target to LScreenshot bitmap
  al_set_target_bitmap(LScreenshot);

  // draw viewport area of LBackbuffer to LScreenshot bitmap
  al_draw_bitmap_region(LBackbuffer, LVX, LVY, LVW, LVH, 0, 0, 0);

  // restore LBackbuffer target
  al_set_target_bitmap(LBackbuffer);

  // make sure filename is a PNG file
  LFilename := aFilename;
  LFilename := TPath.ChangeExtension(LFilename, cPngExt);

  // save screen bitmap to PNG filename
  Engine.EnablePhysFS(False);
  if not al_save_bitmap(PAnsiChar(AnsiString(LFilename)), LScreenshot) then
  Engine.EnablePhysFS(True);

  // destroy LScreenshot bitmap
  al_destroy_bitmap(LScreenshot);
end;

class procedure Display.GetTransInfo(var aSize: TRectangle; var aScale: Single);
begin
  aSize := FTransSize;
  aScale := FTransScale;
end;

class procedure Display.GetMonitorSize(var aSize: TVector);
begin
  aSize.X := al_get_display_width(FHandle);
  aSize.Y := al_get_display_height(FHandle);
  aSize.Z := aSize.X / aSize.Y;
end;

class function  Display.GetMemorySize: UInt64;
var
  LD3d: LPDIRECT3DDEVICE9;
begin
  Result := 0;
  if FHandle = nil then Exit;
  LD3d := al_get_d3d_device(FHandle);
  Result := LD3d.GetAvailableTextureMem;
end;

{ --- FONT ------------------------------------------------------------------ }
{ TFont }
procedure TFont.Unload;
begin
  if FHandle <> nil then
  begin
    al_destroy_font(FHandle);
    FHandle := nil;
    if not FFilename.IsEmpty then
      Logger.Log('Sucessfully unloaded font "%s"', [FFilename]);
    FFilename := '';
    FPadding.Assign(0,0);
  end;
end;

constructor TFont.Create;
begin
  inherited;

  FHandle := nil;
  FFilename := '';
  Unload;
  Default;
end;

destructor TFont.Destroy;
begin
  Unload;

  inherited;
end;

procedure TFont.Default;
begin
  Unload;
  LoadBuiltIn;
end;

procedure TFont.LoadBuiltIn;
begin
  Unload;
  FHandle := al_create_builtin_font;
  if FHandle <> nil then
    begin
      //FPadding.Assign(0, 3);
    end
  else
    Logger.Log('Failed to load builtin font', [])
end;

procedure TFont.Load(aSize: Cardinal);
var
  LResStream: TResourceStream;
begin
  if not ResourceExists('DEFAULTFONT') then Exit;
  LResStream := TResourceStream.Create(HInstance, 'DEFAULTFONT', RT_RCDATA);
  try
    Load(aSize, LResStream.Memory, LResStream.Size);
  finally
    FreeAndNil(LResStream);
  end;
end;

procedure TFont.Load(aSize: Cardinal; aFilename: string);
var
  LMarshaller: TMarshaller;
  LSize: Integer;
begin
  if aFilename.IsEmpty then Exit;

  if not al_filename_exists(LMarshaller.AsAnsi(aFilename).ToPointer) then
  begin
    Logger.Log('Font file "%s" was not found', [aFilename]);
    Exit;
  end;

  LSize := -aSize;
  Unload;
  al_set_new_bitmap_flags(ALLEGRO_MIN_LINEAR or ALLEGRO_MAG_LINEAR or ALLEGRO_MIPMAP or ALLEGRO_VIDEO_BITMAP);
  FHandle := al_load_font(Engine.GetArchiveItemFilename(aFilename), LSize, 0);
  if FHandle <> nil then
    begin
      FFilename := aFilename;
      Logger.Log('Successfully loaded font "%s"', [aFilename])
    end
  else
    begin
      Logger.Log('Failed to load font "%s"', [aFilename])
    end;
end;

procedure TFont.Load(aSize: Cardinal; aMemory: Pointer; aLength: Int64);
var
  LMemFile: PALLEGRO_FILE;
  LSize: Integer;
begin
  LMemFile := al_open_memfile(aMemory, aLength, 'rb');
  LSize := -aSize;
  if LMemFile <> nil then
    begin
      Unload;
      al_set_new_bitmap_flags(ALLEGRO_MIN_LINEAR or ALLEGRO_MAG_LINEAR or ALLEGRO_MIPMAP or ALLEGRO_VIDEO_BITMAP);
      FHandle := al_load_ttf_font_f(LMemFile, '', LSize, 0);
      if FHandle = nil then
        Logger.Log('Failed to load font from memory', [])
    end
  else
    begin
      Logger.Log('Failed to access memory font', [])
    end;
end;

procedure TFont.Print(aX: Single; aY: Single; aColor: TColor; aAlign: THAlign; const aMsg: string; const aArgs: array of const);
var
  LUstr: PALLEGRO_USTR;
  LText: string;
  LColor: ALLEGRO_COLOR absolute aColor;
begin
  if FHandle = nil then Exit;
  LText := Format(aMsg, aArgs);
  if LText.IsEmpty then  Exit;
  LUstr := al_ustr_new_from_utf16(PUInt16(PChar(LText)));
  al_draw_ustr(FHandle, LColor, aX, aY, Ord(aAlign) or ALLEGRO_ALIGN_INTEGER, LUstr);
  al_ustr_free(LUstr);
end;

procedure TFont.Print(aX: Single; var aY: Single; aLineSpace: Single; aColor: TColor; aAlign: THAlign; const aMsg: string; const aArgs: array of const);
begin
  Print(aX, aY, aColor, aAlign, aMsg, aArgs);
  aY := aY + GetLineHeight + aLineSpace;
end;

function TFont.GetTextWidth(const aMsg: string; const aArgs: array of const): Single;
var
  LUstr: PALLEGRO_USTR;
  LText: string;
begin
  Result := 0;
  if FHandle = nil then Exit;
  LText := Format(aMsg, aArgs);
  if LText.IsEmpty then  Exit;
  LUstr := al_ustr_new_from_utf16(PUInt16(PChar(LText)));
  Result := al_get_ustr_width(FHandle, LUstr);
  al_ustr_free(LUstr);
end;

function TFont.GetLineHeight: Single;
begin
  if FHandle = nil then
    Result := 0
  else
    Result := al_get_font_line_height(FHandle) + FPadding.Y;
end;

procedure TFont.Print(aX: Single; aY: Single; aColor: TColor; aAngle: Single; const aMsg: string; const aArgs: array of const);
var
  LUstr: PALLEGRO_USTR;
  LText: string;
  LFX, LFY: Single;
  LTR: ALLEGRO_TRANSFORM;
  LColor: ALLEGRO_COLOR absolute aColor;
begin
  if FHandle = nil then Exit;
  LText := Format(aMsg, aArgs);
  if LText.IsEmpty then Exit;
  LFX := GetTextWidth(LText, []) / 2;
  LFY := GetLineHeight / 2;
  al_identity_transform(@LTR);
  al_translate_transform(@LTR, -LFX, -LFY);
  al_rotate_transform(@LTR, aAngle * DEG2RAD);
  Math.AngleRotatePos(aAngle, LFX, LFY);
  al_translate_transform(@LTR, aX + LFX, aY + LFY);
  al_compose_transform(@LTR, @Display.GetTrans);
  al_use_transform(@LTR);
  LUstr := al_ustr_new_from_utf16(PUInt16(PChar(LText)));
  al_draw_ustr(FHandle, LColor, 0, 0, ALLEGRO_ALIGN_LEFT or ALLEGRO_ALIGN_INTEGER, LUstr);
  al_ustr_free(LUstr);
  al_use_transform(@Display.GetTrans);
end;

{ --- TEXT ------------------------------------------------------------------ }
{ TTextItem }
procedure TTextItem.Clear;
begin
  FBitmap.Unload;
  FText := '';
  FFont := nil;
end;

constructor TTextItem.Create;
begin
  inherited;
  FBitmap := TBitmap.Create;
  FText := '';
  FFont := nil;
end;

destructor TTextItem.Destroy;
begin
  FreeAndNil(FBitmap);
  inherited;
end;

procedure TTextItem.Print(aFont: TFont; aColors: array of TColor; const aMsg: string; const aArgs: array of const);
var
  LX: Single;
  LC: string;
  LText: string;
  LTempText: string;
  LTextWidth: Single;
  LTextHeight: Single;
  LColor: TColor;
  LMode: Integer;
  LColorCount: Integer;
  LColorIndex: Integer;
begin
  LText := Format(aMsg, aArgs);
  if (LText = FText) and (aFont = FFont) then
    Exit;
  LColorCount := Length(aColors);
  LColor := aColors[0];
  LTempText := '';
  LMode := -1;
  for LC in LText do
  begin
    if LC = '^' then
    begin
      if LMode = -1 then
        LMode := 0
      else if LMode = 0 then
      begin
        LMode := -1;
        continue;
      end;
    end;

    if LMode <> -1 then
      continue;
    LTempText := LTempText + LC;
  end;

  LTextWidth := aFont.GetTextWidth(LTempText, []);
  LTextHeight := aFont.GetLineHeight;

  Clear;
  FBitmap.Allocate(Round(LTextWidth), Round(LTextHeight));
  Display.SetTarget(FBitmap);

  LX := 0;
  LMode := -1;
  for LC in LText do
  begin
    if LMode = 2 then
    begin
      if LC = '^' then
      begin
        LMode := -1;
      end;
      continue;
    end;
    // do change LColor
    if LMode = 1 then
    begin
      LColorIndex := LC.ToInteger;
      if (LColorIndex < 0) or (LColorIndex > LColorCount - 1) then
      begin
        LMode := -1;
        continue;
      end;
      LColor := aColors[LColorIndex];
      LMode := 2;
      continue;
    end;
    // check change LColor
    if LMode = 0 then
    begin
      if (LC = 'c') or (LC = 'C') then
      begin
        LMode := 1;
        continue;
      end;
    end;

    // set change LColor
    if LC = '^' then
    begin
      LMode := 0;
      continue;
    end;
    aFont.Print(LX, 0, LColor, haLeft, LC, []);
    LX := LX + aFont.GetTextWidth(LC, []);
  end;

  Display.ResetTarget;

  FText := LText;
  FFont := aFont;
end;

procedure TTextItem.Render(aX: Single; aY: Single; aScale: Single; aAngle: Single);
begin
  FBitmap.Draw(aX, aY, aScale, aAngle, WHITE, haLeft, vaTop);
end;

{ TTextCacheItem }
constructor TTextCacheItem.Create;
begin
  inherited;
  FText := TTextItem.Create;
  FX := 0;
  FY := 0;
  FScale := 0;
  FAngle := 0;
end;

destructor TTextCacheItem.Destroy;
begin
  FreeAndNil(FText);
  inherited;
end;

procedure TTextCacheItem.Print(aFont: TFont; aX: Single; aY: Single; aScale: Single; aAngle: Single; aColors: array of TColor; const aMsg: string; const aArgs: array of const);
begin
  FText.Print(aFont, aColors, aMsg, aArgs);
  FX := aX;
  FY := aY;
  FScale := aScale;
  FAngle := aAngle;
end;

procedure TTextCacheItem.Render;
begin
  FText.Render(FX, FY, FScale, FAngle);
end;

{ TText }
function TText.IsCached(aFont: TFont; aX: Single; aY: Single; aScale: Single; aAngle: Single; const aMsg: string; const aArgs: array of const): Boolean;
var
  LItem: TTextCacheItem;
  LText: string;
begin
  Result := False;
  LText := Format(aMsg, aArgs);
  for LItem in FCache do
  begin
    if (LItem.Text.Text = LText) and (LItem.Text.Font = aFont) and (LItem.X = aX)
      and (LItem.Y = aY) and (LItem.Scale = aScale) and
      (LItem.Angle = aAngle) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

constructor TText.Create;
begin
  inherited;
  FCache := TObjectList<TTextCacheItem>.Create;
end;

destructor TText.Destroy;
begin
  Clear;
  FreeAndNil(FCache);
  inherited;
end;

procedure TText.Clear;
begin
  FCache.Clear;
end;

procedure TText.Print(aFont: TFont; aX: Single; aY: Single; aScale: Single; aAngle: Single; aColors: array of TColor; const aMsg: string; const aArgs: array of const);
var
  LItem: TTextCacheItem;
begin
  if IsCached(aFont, aX, aY, aScale, aAngle, aMsg, aArgs) then Exit;
  LItem := TTextCacheItem.Create;
  LItem.Print(aFont, aX, aY, aScale, aAngle, aColors, aMsg, aArgs);
  FCache.Add(LItem);
end;

procedure TText.Print(aFont: TFont; aX: Single; var aY: Single; aLineSpace: Single; aColors: array of TColor; const aMsg: string; const aArgs: array of const);
begin
  Print(aFont, aX, aY, 1, 0, aColors, aMsg, aArgs);
end;

procedure TText.Render;
var
  LItem: TTextCacheItem;
begin
  for LItem in FCache do
  begin
    LItem.Render;
  end;
end;

{ --- STARFIELD ------------------------------------------------------------- }
{ TStarfield }
procedure TStarfield.TransformDrawPoint(aX, aY, aZ: Single; aVPX, aVPY, aVPW, aVPH: Integer);
var
  LX, LY: Single;
  LSW, LSH: Single;
  LOOZ: Single;
  LCV: byte;
  LColor: TColor;

  function IsVisible(vx, vy, vw, vh: Single): Boolean;
  begin
    Result := False;
    if ((vx - vw) < 0) then
      Exit;
    if (vx > (aVPW - 1)) then
      Exit;
    if ((vy - vh) < 0) then
      Exit;
    if (vy > (aVPH - 1)) then
      Exit;
    Result := True;
  end;

begin
  FViewScaleRatio := aVPW / aVPH;
  FCenter.X := (aVPW / 2) + aVPX;
  FCenter.Y := (aVPH / 2) + aVPY;

  LOOZ := ((1.0 / aZ) * FViewScale);
  LX := (FCenter.X - aVPX) - (aX * LOOZ) * FViewScaleRatio;
  LY := (FCenter.Y - aVPY) + (aY * LOOZ) * FViewScaleRatio;
  LSW := (1.0 * LOOZ);
  if LSW < 1 then
    LSW := 1;
  LSH := (1.0 * LOOZ);
  if LSH < 1 then
    LSH := 1;
  if not IsVisible(LX, LY, LSW, LSH) then
    Exit;
  LCV := round(255.0 - (((1.0 / FMax.Z) / (1.0 / aZ)) * 255.0));

  LColor.Make(LCV, LCV, LCV, LCV);

  LX := LX - FVirtualPos.X;
  LY := LY - FVirtualPos.Y;

  Display.DrawFilledRectangle(LX, LY, LSW, LSH, LColor);
end;

constructor TStarfield.Create;
begin
  inherited;

  Init(250, -1000, -1000, 10, 1000, 1000, 1000, 120);
end;

destructor TStarfield.Destroy;
begin
  Done;

  inherited;
end;

procedure TStarfield.Init(aStarCount: Cardinal; aMinX, aMinY, aMinZ, aMaxX, aMaxY, aMaxZ, aViewScale: Single);
var
  LVPX, LVPY: Integer;
  LVPW, LVPH: Integer;
  LI: Integer;
begin
  Done;

  FStarCount := aStarCount;
  SetLength(FStar, FStarCount);

  Display.GetViewportSize(@LVPX, @LVPY, @LVPW, @LVPH);

  FViewScale := aViewScale;
  FViewScaleRatio := LVPW / LVPH;
  FCenter.X := (LVPW / 2) + LVPX;
  FCenter.Y := (LVPH / 2) + LVPY;
  FCenter.Z := 0;

  FMin.X := aMinX;
  FMin.Y := aMinY;
  FMin.Z := aMinZ;
  FMax.X := aMaxX;
  FMax.Y := aMaxY;
  FMax.Z := aMaxZ;

  for LI := 0 to FStarCount - 1 do
  begin
    FStar[LI].X := Math.RandomRange(FMin.X, FMax.X);
    FStar[LI].Y := Math.RandomRange(FMin.Y, FMax.Y);
    FStar[LI].Z := Math.RandomRange(FMin.Z, FMax.Z);
  end;

  SetXSpeed(0.0);
  SetYSpeed(0.0);
  SetZSpeed(-60*3);
  SetVirtualPos(0, 0);
end;

procedure TStarfield.Done;
begin
  FStar := nil;
end;

procedure TStarfield.SetVirtualPos(aX, aY: Single);
begin
  FVirtualPos.X := aX;
  FVirtualPos.Y := aY;
  FVirtualPos.Z := 0;
end;

procedure TStarfield.GetVirtualPos(var aX: Single; var aY: Single);
begin
  aX := FVirtualPos.X;
  aY := FVirtualPos.Y;
end;

procedure TStarfield.SetXSpeed(aSpeed: Single);
begin
  FSpeed.X := aSpeed;
end;

procedure TStarfield.SetYSpeed(aSpeed: Single);
begin
  FSpeed.Y := aSpeed;
end;

procedure TStarfield.SetZSpeed(aSpeed: Single);
begin

  FSpeed.Z := aSpeed;
end;

procedure TStarfield.Update(aDeltaTime: Single);
var
  LI: Integer;

  procedure SetRandomPos(aIndex: Integer);
  begin
    FStar[aIndex].X := Math.RandomRange(FMin.X, FMax.X);
    FStar[aIndex].Y := Math.RandomRange(FMin.Y, FMax.Y);
    FStar[aIndex].Z := Math.RandomRange(FMin.Z, FMax.Z);
  end;

begin

  for LI := 0 to FStarCount - 1 do
  begin
    FStar[LI].X := FStar[LI].X + (FSpeed.X * aDeltaTime);
    FStar[LI].Y := FStar[LI].Y + (FSpeed.Y * aDeltaTime);
    FStar[LI].Z := FStar[LI].Z + (FSpeed.Z * aDeltaTime);

    if FStar[LI].X < FMin.X then
    begin
      SetRandomPos(LI);
      FStar[LI].X := FMax.X;
    end;

    if FStar[LI].X > FMax.X then
    begin
      SetRandomPos(LI);
      FStar[LI].X := FMin.X;
    end;

    if FStar[LI].Y < FMin.Y then
    begin
      SetRandomPos(LI);
      FStar[LI].Y := FMax.Y;
    end;

    if FStar[LI].Y > FMax.Y then
    begin
      SetRandomPos(LI);
      FStar[LI].Y := FMin.Y;
    end;

    if FStar[LI].Z < FMin.Z then
    begin
      SetRandomPos(LI);
      FStar[LI].Z := FMax.Z;
    end;

    if FStar[LI].Z > FMax.Z then
    begin
      SetRandomPos(LI);
      FStar[LI].Z := FMin.Z;
    end;

  end;
end;

procedure TStarfield.Render;
var
  LI: Integer;
  LVPX, LVPY, LVPW, LVPH: Integer;
begin
  Display.GetViewportSize(@LVPX, @LVPY, @LVPW, @LVPH);
  for LI := 0 to FStarCount - 1 do
  begin
    TransformDrawPoint(FStar[LI].X, FStar[LI].Y, FStar[LI].Z, LVPX, LVPY, LVPW, LVPH);
  end;
end;

{ --- POLYGON --------------------------------------------------------------- }
{ TPolygon }
procedure TPolygon.Clear;
begin
  FSegment := nil;
  FWorldPoint := nil;
  FItemCount := 0;
end;

constructor TPolygon.Create;
begin
  inherited;

  Clear;
end;

destructor TPolygon.Destroy;
begin

  inherited;
end;

procedure TPolygon.Save(aFilename: string);
var
  LMarshaller: TMarshaller;
  LSize: Integer;
  LHandle: PALLEGRO_FILE;
begin
  if aFilename.IsEmpty then Exit;

  LHandle := al_fopen(LMarshaller.AsAnsi(aFilename).ToPointer, 'wb');
  if LHandle <> nil then
  begin
    try
      // FItemCount
      al_fwrite(LHandle, @FItemCount, SizeOf(FItemCount));

      // FItem
      LSize := SizeOf(FSegment[0]) * FItemCount;

      // fs.WriteData(FSegment, Size);
      al_fwrite(LHandle, FSegment, LSize);

      // FWorldPoint
      LSize := SizeOf(FWorldPoint[0]) * FItemCount;

      // fs.WriteData(FWorldPoint, Size);
      al_fwrite(LHandle, FWorldPoint, LSize);

    finally
      al_fclose(LHandle);
    end;
  end;
end;

procedure TPolygon.Load(aFilename: string);
var
  LMarshaller: TMarshaller;
  LSize: Integer;
  FStream: PALLEGRO_FILE;
begin
  if aFilename.IsEmpty then  Exit;
  if not al_filename_exists(LMarshaller.AsAnsi(aFilename).ToPointer) then Exit;
  FStream := al_fopen(Engine.GetArchiveItemFilename(aFilename), 'rb');
  if FStream <> nil then
  begin
    try
      Clear;

      // FItemCount
      al_fread(FStream, @FItemCount, SizeOf(FItemCount));

      // FItem
      SetLength(FSegment, FItemCount);
      LSize := SizeOf(FSegment[0]) * FItemCount;
      al_fread(FStream, FSegment, LSize);

      // FWorldPoint
      SetLength(FWorldPoint, FItemCount);
      LSize := SizeOf(FWorldPoint[0]) * FItemCount;
      al_fread(FStream, FWorldPoint, LSize);
    finally
      al_fclose(FStream);
    end;
  end;

end;

procedure TPolygon.CopyFrom(aPolygon: TPolygon);
var
  LI: Integer;
begin
  Clear;
  with aPolygon do
  begin
    for LI := 0 to FItemCount - 1 do
    begin
      with FSegment[LI] do
      begin
        Self.AddLocalPoint(Round(Point.X), Round(Point.Y), Visible);
      end;
    end;
  end;
end;

procedure TPolygon.AddLocalPoint(aX: Single; aY: Single; aVisible: Boolean);
begin
  Inc(FItemCount);
  SetLength(FSegment, FItemCount);
  SetLength(FWorldPoint, FItemCount);
  FSegment[FItemCount - 1].Point.X := aX;
  FSegment[FItemCount - 1].Point.Y := aY;
  FSegment[FItemCount - 1].Visible := aVisible;
  FWorldPoint[FItemCount - 1].X := 0;
  FWorldPoint[FItemCount - 1].Y := 0;
end;

function TPolygon.Transform(aX: Single; aY: Single; aScale: Single; aAngle: Single; aOrigin: PVector; aHFlip: Boolean; aVFlip: Boolean): Boolean;
var
  LI: Integer;
  LP: TVector;
begin
  Result := False;

  if FItemCount < 2 then
    Exit;

  for LI := 0 to FItemCount - 1 do
  begin
    // get local coord
    LP.X := FSegment[LI].Point.X;
    LP.Y := FSegment[LI].Point.Y;

    // move point to origin
    if aOrigin <> nil then
    begin
      LP.X := LP.X - aOrigin.X;
      LP.Y := LP.Y - aOrigin.Y;
    end;

    // horizontal flip
    if aHFlip then
    begin
      LP.X := -LP.X;
    end;

    // virtical flip
    if aVFlip then
    begin
      LP.Y := -LP.Y;
    end;

    // scale
    LP.X := LP.X * aScale;
    LP.Y := LP.Y * aScale;

    // rotate
    Math.AngleRotatePos(aAngle, LP.X, LP.Y);

    // convert to world
    LP.X := LP.X + aX;
    LP.Y := LP.Y + aY;

    // set world point
    FWorldPoint[LI].X := LP.X;
    FWorldPoint[LI].Y := LP.Y;
  end;

  Result := True;
end;

procedure TPolygon.Render(aX: Single; aY: Single; aScale: Single; aAngle: Single; aThickness: Integer; aColor: TColor; aOrigin: PVector; aHFlip: Boolean; aVFlip: Boolean);
var
  LI: Integer;
begin
  if not Transform(aX, aY, aScale, aAngle, aOrigin, aHFlip, aVFlip) then Exit;

  // draw line segments
  for LI := 0 to FItemCount - 2 do
  begin
    if FSegment[LI].Visible then
    begin
      Display.DrawLine(FWorldPoint[LI].X, FWorldPoint[LI].Y, FWorldPoint[LI + 1].X, FWorldPoint[LI + 1].Y, aColor, aThickness);
    end;
  end;
end;

procedure TPolygon.SetSegmentVisible(aIndex: Integer; aVisible: Boolean);
begin
  FSegment[aIndex].Visible := True;
end;

function TPolygon.GetSegmentVisible(aIndex: Integer): Boolean;
begin
  Result := FSegment[aIndex].Visible;
end;

function TPolygon.GetPointCount: Integer;
begin
  Result := FItemCount;
end;

function TPolygon.GetWorldPoint(aIndex: Integer): PVector;
begin
  Result := @FWorldPoint[aIndex];
end;

function TPolygon.GetLocalPoint(aIndex: Integer): PVector;
begin
  Result := @FSegment[aIndex].Point;
end;

{ --- SPRITE ---------------------------------------------------------------- }
{ TSprite }
procedure TSprite.Clear;
var
  LI: Integer;
begin
  if FBitmap <> nil then
  begin
    // free group data
    for LI := 0 to FGroupCount - 1 do
    begin
      // free image array
      FGroup[LI].Image := nil;

      // free polypoint
      FreeAndNil(FGroup[LI].PolyPoint);
    end;

    // free page
    for LI := 0 to FPageCount - 1 do
    begin
      if Assigned(FBitmap[LI]) then
      begin
        FreeAndNil(FBitmap[LI]);
      end;
    end;

    FBitmap := nil;
    FGroup := nil;
    FPageCount := 0;
    FGroupCount := 0;
  end;
end;

constructor TSprite.Create;
begin
  inherited;

  FBitmap := nil;
  FGroup := nil;
  FPageCount := 0;
  FGroupCount := 0;
end;

destructor TSprite.Destroy;
begin
  Clear;

  inherited;
end;

function TSprite.LoadPage(aFilename: string; aColorKey: PColor): Integer;
begin
  Result := FPageCount;
  Inc(FPageCount);
  SetLength(FBitmap, FPageCount);
  FBitmap[Result] := TBitmap.Create;
  FBitmap[Result].Load(aFilename, aColorKey);
end;

function TSprite.AddGroup: Integer;
begin
  Result := FGroupCount;
  Inc(FGroupCount);
  SetLength(FGroup, FGroupCount);
  FGroup[Result].PolyPoint := TPolyPoint.Create;
end;

function TSprite.GetGroupCount: Integer;
begin
  Result := FGroupCount;
end;

function TSprite.AddImageFromRect(aPage: Integer; aGroup: Integer;
  aRect: TRectangle): Integer;
begin
  Result := FGroup[aGroup].Count;
  Inc(FGroup[aGroup].Count);
  SetLength(FGroup[aGroup].Image, FGroup[aGroup].Count);

  FGroup[aGroup].Image[Result].Rect.X := aRect.X;
  FGroup[aGroup].Image[Result].Rect.Y := aRect.Y;
  FGroup[aGroup].Image[Result].Rect.Width := aRect.Width;
  FGroup[aGroup].Image[Result].Rect.Height := aRect.Height;
  FGroup[aGroup].Image[Result].Page := aPage;
end;

function TSprite.AddImageFromGrid(aPage: Integer; aGroup: Integer;
  aGridX: Integer; aGridY: Integer; aGridWidth: Integer;
  aGridHeight: Integer): Integer;
begin
  Result := FGroup[aGroup].Count;
  Inc(FGroup[aGroup].Count);
  SetLength(FGroup[aGroup].Image, FGroup[aGroup].Count);

  FGroup[aGroup].Image[Result].Rect.X := aGridWidth * aGridX;
  FGroup[aGroup].Image[Result].Rect.Y := aGridHeight * aGridY;
  FGroup[aGroup].Image[Result].Rect.Width := aGridWidth;
  FGroup[aGroup].Image[Result].Rect.Height := aGridHeight;
  FGroup[aGroup].Image[Result].Page := aPage;
end;

function TSprite.GetImageCount(aGroup: Integer): Integer;
begin
  Result := FGroup[aGroup].Count;
end;

function TSprite.GetImageWidth(aNum: Integer; aGroup: Integer): Single;
begin
  Result := FGroup[aGroup].Image[aNum].Rect.Width;
end;

function TSprite.GetImageHeight(aNum: Integer; aGroup: Integer): Single;
begin
  Result := FGroup[aGroup].Image[aNum].Rect.Height;
end;

function TSprite.GetImageTexture(aNum: Integer; aGroup: Integer): TBitmap;
begin
  Result := FBitmap[FGroup[aGroup].Image[aNum].Page];
end;

procedure TSprite.DrawImage(aNum: Integer; aGroup: Integer; aX: Single;
  aY: Single; aOrigin: PVector; aScale: PVector; aAngle: Single; aColor: TColor;
  aHFlip: Boolean; aVFlip: Boolean; aDrawPolyPoint: Boolean);
var
  LPageNum: Integer;
  LRectP: PRectangle;
  LOXY: TVector;
begin
  LRectP := @FGroup[aGroup].Image[aNum].Rect;
  LPageNum := FGroup[aGroup].Image[aNum].Page;
  FBitmap[LPageNum].Draw(aX, aY, LRectP, aOrigin, aScale, aAngle, aColor, aHFlip, aVFlip);

  if aDrawPolyPoint then
  begin
    LOXY.X := 0;
    LOXY.Y := 0;
    if aOrigin <> nil then
    begin
      LOXY.X := FGroup[aGroup].Image[aNum].Rect.Width;
      LOXY.Y := FGroup[aGroup].Image[aNum].Rect.Height;

      LOXY.X := Round(LOXY.X * aOrigin.X);
      LOXY.Y := Round(LOXY.Y * aOrigin.Y);
    end;
    TPolyPoint(FGroup[aGroup].PolyPoint).Render(aNum, aX, aY, aScale.X, aAngle,
      YELLOW, @LOXY, aHFlip, aVFlip);
  end;
end;

function TSprite.GetImageRect(aNum: Integer; aGroup: Integer): TRectangle;
begin
  Result := FGroup[aGroup].Image[aNum].Rect;
end;

function TSprite.GroupPolyPoint(aGroup: Integer): Pointer;
begin
  Result := FGroup[aGroup].PolyPoint;
end;

procedure TSprite.GroupPolyPointTrace(aGroup: Integer; aMju: Single = 6;
  aMaxStepBack: Integer = 12; aAlphaThreshold: Integer = 70;
  aOrigin: PVector = nil);
begin
  TPolyPoint(FGroup[aGroup].PolyPoint).TraceFromSprite(Self, aGroup, aMju,
    aMaxStepBack, aAlphaThreshold, aOrigin);
end;

function TSprite.GroupPolyPointCollide(aNum1: Integer; aGroup1: Integer;
  aX1: Single; aY1: Single; aScale1: Single; aAngle1: Single; aOrigin1: PVector;
  aHFlip1: Boolean; aVFlip1: Boolean; aSprite2: TSprite; aNum2: Integer;
  aGroup2: Integer; aX2: Single; aY2: Single; aScale2: Single; aAngle2: Single;
  aOrigin2: PVector; aHFlip2: Boolean; aVFlip2: Boolean; aShrinkFactor: Single;
  var aHitPos: TVector): Boolean;
var
  LPP1, LPP2: TPolyPoint;
  LRadius1: Integer;
  LRadius2: Integer;
  LOrigini1, LOrigini2: TVector;
  LOrigini1P, LOrigini2P: PVector;
begin
  Result := False;

  if (aSprite2 = nil) then
    Exit;

  LPP1 := FGroup[aGroup1].PolyPoint;
  LPP2 := aSprite2.FGroup[aGroup2].PolyPoint;

  if not LPP1.Valid(aNum1) then
    Exit;
  if not LPP2.Valid(aNum2) then
    Exit;

  LRadius1 := Round(FGroup[aGroup1].Image[aNum1].Rect.Height + FGroup[aGroup1]
    .Image[aNum1].Rect.Width) div 2;

  LRadius2 := Round(aSprite2.FGroup[aGroup2].Image[aNum2].Rect.Height +
    aSprite2.FGroup[aGroup2].Image[aNum2].Rect.Width) div 2;

  if not Collision.RadiusOverlap(LRadius1, aX1, aY1, LRadius2, aX2, aY2, aShrinkFactor) then Exit;

  LOrigini2.X := aSprite2.FGroup[aGroup2].Image[aNum2].Rect.Width;
  LOrigini2.Y := aSprite2.FGroup[aGroup2].Image[aNum2].Rect.Height;

  LOrigini1P := nil;
  if aOrigin1 <> nil then
  begin
    LOrigini1.X := Round(FGroup[aGroup1].Image[aNum1].Rect.Width * aOrigin1.X);
    LOrigini1.Y := Round(FGroup[aGroup1].Image[aNum1].Rect.Height * aOrigin1.Y);
    LOrigini1P := @LOrigini1;
  end;

  LOrigini2P := nil;
  if aOrigin2 <> nil then
  begin
    LOrigini2.X := Round(aSprite2.FGroup[aGroup2].Image[aNum2]
      .Rect.Width * aOrigin2.X);
    LOrigini2.Y := Round(aSprite2.FGroup[aGroup2].Image[aNum2]
      .Rect.Height * aOrigin2.Y);
    LOrigini2P := @LOrigini2;
  end;

  Result := LPP1.Collide(aNum1, aGroup1, aX1, aY1, aScale1, aAngle1, LOrigini1P,
    aHFlip1, aVFlip1, LPP2, aNum2, aGroup2, aX2, aY2, aScale2, aAngle2,
    LOrigini2P, aHFlip2, aVFlip2, aHitPos);
end;

function TSprite.GroupPolyPointCollidePoint(aNum: Integer; aGroup: Integer;
  aX: Single; aY: Single; aScale: Single; aAngle: Single; aOrigin: PVector;
  aHFlip: Boolean; aVFlip: Boolean; aShrinkFactor: Single;
  var aPoint: TVector): Boolean;
var
  LPP1: TPolyPoint;
  LRadius1: Integer;
  LRadius2: Integer;
  LOrigini1: TVector;
  LOrigini1P: PVector;

begin
  Result := False;

  LPP1 := FGroup[aGroup].PolyPoint;

  if not LPP1.Valid(aNum) then
    Exit;

  LRadius1 := Round(FGroup[aGroup].Image[aNum].Rect.Height + FGroup[aGroup].Image
    [aNum].Rect.Width) div 2;

  LRadius2 := 2;

  if not Collision.RadiusOverlap(LRadius1, aX, aY, LRadius2, aPoint.X, aPoint.Y,
    aShrinkFactor) then
    Exit;

  LOrigini1P := nil;
  if aOrigin <> nil then
  begin
    LOrigini1.X := FGroup[aGroup].Image[aNum].Rect.Width * aOrigin.X;
    LOrigini1.Y := FGroup[aGroup].Image[aNum].Rect.Height * aOrigin.Y;
    LOrigini1P := @LOrigini1;
  end;

  Result := LPP1.CollidePoint(aNum, aGroup, aX, aY, aScale, aAngle, LOrigini1P,
    aHFlip, aVFlip, aPoint);
end;

{ --- POLYPOINT ------------------------------------------------------------- }
{ TPolyPoint }
procedure TPolyPoint.Clear;
var
  LI: Integer;
begin
  for LI := 0 to Count - 1 do
  begin
    if Assigned(FPolygon[LI]) then
    begin
      FreeAndNil(FPolygon[LI]);
    end;
  end;
  FPolygon := nil;
  FCount := 0;
end;

constructor TPolyPoint.Create;
begin
  inherited;

  FPolygon := nil;
  FCount := 0;
end;

destructor TPolyPoint.Destroy;
begin
  Clear;

  inherited;
end;

procedure TPolyPoint.Save(aFilename: string);
begin
end;

procedure TPolyPoint.Load(aFilename: string);
begin
end;

procedure TPolyPoint.CopyFrom(aPolyPoint: TPolyPoint);
begin
end;

procedure TPolyPoint.AddPoint(aNum: Integer; aX: Single; aY: Single; aOrigin: PVector);
var
  LX, LY: Single;
begin
  LX := aX;
  LY := aY;

  if aOrigin <> nil then
  begin
    LX := LX - aOrigin.X;
    LY := LY - aOrigin.Y;
  end;

  FPolygon[aNum].AddLocalPoint(LX, LY, True);
end;

function TPolyPoint.TraceFromBitmap(aBitmap: TBitmap; aMju: Single; aMaxStepBack: Integer; aAlphaThreshold: Integer; aOrigin: PVector): Integer;
var
  LI: Integer;
  LW, LH: Single;
  //LData: TBitmapData;
begin
  Inc(FCount);
  SetLength(FPolygon, FCount);
  LI := FCount - 1;
  FPolygon[LI] := TPolygon.Create;
  aBitmap.GetSize(@LW, @LH);
  //aBitmap.Lock(nil, LData);
  aBitmap.Lock(nil);
  PolyPointTrace.Init(aMju, aMaxStepBack, aAlphaThreshold);
  PolyPointTrace.PrimaryTrace(aBitmap, LW, LH);
  PolyPointTrace.SimplifyPoly;
  PolyPointTrace.ApplyPolyPoint(Self, LI, aOrigin);
  PolyPointTrace.Done;
  aBitmap.Unlock;

  Result := LI;
end;

procedure TPolyPoint.TraceFromSprite(aSprite: TSprite; aGroup: Integer; aMju: Single; aMaxStepBack: Integer; aAlphaThreshold: Integer; aOrigin: PVector);
var
  LI: Integer;
  LRect: TRectangle;
  LTex: TBitmap;
  LW, LH: Integer;
  //LData: TBitmapData;
begin
  Clear;
  FCount := aSprite.GetImageCount(aGroup);
  SetLength(FPolygon, Count);
  for LI := 0 to Count - 1 do
  begin
    FPolygon[LI] := TPolygon.Create;
    LTex := aSprite.GetImageTexture(LI, aGroup);
    LRect := aSprite.GetImageRect(LI, aGroup);
    LW := Round(LRect.width);
    LH := Round(LRect.height);
    //LTex.Lock(@LRect, LData);
    LTex.Lock(@LRect);
    PolyPointTrace.Init(aMju, aMaxStepBack, aAlphaThreshold);
    PolyPointTrace.PrimaryTrace(LTex, LW, LH);
    PolyPointTrace.SimplifyPoly;
    PolyPointTrace.ApplyPolyPoint(Self, LI, aOrigin);
    PolyPointTrace.Done;
    LTex.Unlock;
  end;
end;

function TPolyPoint.Count: Integer;
begin
  Result := FCount;
end;

procedure TPolyPoint.Render(aNum: Integer; aX: Single; aY: Single;
  aScale: Single; aAngle: Single; aColor: TColor; aOrigin: PVector;
  aHFlip: Boolean; aVFlip: Boolean);
begin
  if aNum >= FCount then Exit;
  FPolygon[aNum].Render(aX, aY, aScale, aAngle, 1, aColor, aOrigin,
    aHFlip, aVFlip);
end;

function TPolyPoint.Collide(aNum1: Integer; aGroup1: Integer; aX1: Single;
  aY1: Single; aScale1: Single; aAngle1: Single; aOrigin1: PVector;
  aHFlip1: Boolean; aVFlip1: Boolean; aPolyPoint2: TPolyPoint; aNum2: Integer;
  aGroup2: Integer; aX2: Single; aY2: Single; aScale2: Single; aAngle2: Single;
  aOrigin2: PVector; aHFlip2: Boolean; aVFlip2: Boolean;
  var aHitPos: TVector): Boolean;
var
  LL1, LL2, LIX, LIY: Integer;
  LCnt1, LCnt2: Integer;
  LPos: array [0 .. 3] of PVector;
  LPoly1, LPoly2: TPolygon;
begin
  Result := False;

  if (aPolyPoint2 = nil) then Exit;

  LPoly1 := FPolygon[aNum1];
  LPoly2 := aPolyPoint2.Polygon(aNum2);

  // transform to world points
  LPoly1.Transform(aX1, aY1, aScale1, aAngle1, aOrigin1, aHFlip1, aVFlip1);
  LPoly2.Transform(aX2, aY2, aScale2, aAngle2, aOrigin2, aHFlip2, aVFlip2);

  LCnt1 := LPoly1.GetPointCount;
  LCnt2 := LPoly2.GetPointCount;

  if LCnt1 < 2 then Exit;
  if LCnt2 < 2 then Exit;

  for LL1 := 0 to LCnt1 - 2 do
  begin
    LPos[0] := LPoly1.GetWorldPoint(LL1);
    LPos[1] := LPoly1.GetWorldPoint(LL1 + 1);

    for LL2 := 0 to LCnt2 - 2 do
    begin

      LPos[2] := LPoly2.GetWorldPoint(LL2);
      LPos[3] := LPoly2.GetWorldPoint(LL2 + 1);
      if Collision.LineIntersection(Round(LPos[0].X), Round(LPos[0].Y), Round(LPos[1].X),
        Round(LPos[1].Y), Round(LPos[2].X), Round(LPos[2].Y), Round(LPos[3].X),
        Round(LPos[3].Y), LIX, LIY) = liTRUE then
      begin
        aHitPos.X := LIX;
        aHitPos.Y := LIY;
        Result := True;
        Exit;
      end;
    end;
  end;
end;

function TPolyPoint.CollidePoint(aNum: Integer; aGroup: Integer; aX: Single;
  aY: Single; aScale: Single; aAngle: Single; aOrigin: PVector; aHFlip: Boolean;
  aVFlip: Boolean; var aPoint: TVector): Boolean;
var
  LL1, LIX, LIY: Integer;
  LCnt1: Integer;
  LPos: array [0 .. 3] of PVector;
  LPoint2: TVector;
  LPoly1: TPolygon;
begin
  Result := False;

  LPoly1 := FPolygon[aNum];

  // transform to world points
  LPoly1.Transform(aX, aY, aScale, aAngle, aOrigin, aHFlip, aVFlip);

  LCnt1 := LPoly1.GetPointCount;

  if LCnt1 < 2 then
    Exit;

  LPoint2.X := aPoint.X + 1;
  LPoint2.Y := aPoint.Y + 1;
  LPos[2] := @aPoint;
  LPos[3] := @LPoint2;

  for LL1 := 0 to LCnt1 - 2 do
  begin
    LPos[0] := LPoly1.GetWorldPoint(LL1);
    LPos[1] := LPoly1.GetWorldPoint(LL1 + 1);

    if Collision.LineIntersection(Round(LPos[0].X), Round(LPos[0].Y), Round(LPos[1].X),
      Round(LPos[1].Y), Round(LPos[2].X), Round(LPos[2].Y), Round(LPos[3].X),
      Round(LPos[3].Y), LIX, LIY) = liTrue then
    begin
      aPoint.X := LIX;
      aPoint.Y := LIY;
      Result := True;
      Exit;
    end;
  end;

end;

function TPolyPoint.Polygon(aNum: Integer): TPolygon;
begin
  Result := FPolygon[aNum];
end;

function TPolyPoint.Valid(aNum: Integer): Boolean;
begin
  Result := False;
  if aNum >= FCount then Exit;
  Result := Boolean(FPolygon[aNum].GetPointCount >= 2);
end;

{ --- POLYPOINTTRACE -------------------------------------------------------- }
{ PolyPointTrace  }
class function PolyPointTrace.IsNeighbour(X1, Y1, X2, Y2: Integer): Boolean;
begin
  Result := (Abs(X2 - X1) <= 1) and (Abs(Y2 - Y1) <= 1);
end;

class function PolyPointTrace.IsPixEmpty(Tex: TBitmap; X, Y: Integer; W, H: Single): Boolean;
var
  LColor: TColor;
begin
  if (X < 0) or (Y < 0) or (X > W - 1) or (Y > H - 1) then
    Result := true
  else
  begin
    LColor := Tex.GetPixel(X, Y);
    Result := Boolean(LColor.alpha * 255 < mAlphaThreshold);
  end;
end;

// some point list functions
class procedure PolyPointTrace.AddPoint(X, Y: Integer);
var
  LL: Integer;
begin
  Inc(mPntCount);
  // L := Length(PolyArr);
  LL := High(mPolyArr) + 1;
  if LL < mPntCount then
    SetLength(mPolyArr, LL + mMaxStepBack);
  mPolyArr[mPntCount - 1].X := X;
  mPolyArr[mPntCount - 1].Y := Y;
end;

class procedure PolyPointTrace.DelPoint(Index: Integer);
var
  LI: Integer;
begin
  if mPntCount > 1 then
    for LI := Index to mPntCount - 2 do
      mPolyArr[LI] := mPolyArr[LI + 1];
  Dec(mPntCount);
end;

class function PolyPointTrace.IsInList(X, Y: Integer): Boolean;
var
  LI: Integer;
begin
  Result := False;
  for LI := 0 to mPntCount - 1 do
  begin
    Result := (mPolyArr[LI].X = X) and (mPolyArr[LI].Y = Y);
    if Result then
      Break;
  end;
end;

class procedure PolyPointTrace.FindStartingPoint(Tex: TBitmap; var X, Y: Integer; W, H: Single);
var
  LI, LJ: Integer;
begin
  X := 1000000; // init X and Y with huge values
  Y := 1000000;
  // and simply find the non-zero point with lowest Y
  LI := 0;
  LJ := 0;
  while (X = 1000000) and (LI <= H) and (LJ <= W) do
  begin
    if not IsPixEmpty(Tex, LI, LJ, W, H) then
    begin
      X := LI;
      Y := LJ;
    end;
    Inc(LI);
    if LI = W then
    begin
      LI := 0;
      Inc(LJ);
    end;
  end;
  if X = 1000000 then
  begin
    // do something awful - texture is empty!
     //ShowMessage('do something awful - texture is empty!', [], SHOWMESSAGE_ERROR);
     raise Exception.Create('do something awful - texture is empty!');
  end;
end;

const
  // this is an order of looking for neighbour. Order is quite important
  Neighbours: array [1 .. 8, 1 .. 2] of Integer = ((0, -1), (-1, 0), (0, 1),
    (1, 0), (-1, -1), (-1, 1), (1, 1), (1, -1));

class function PolyPointTrace.CountEmptyAround(Tex: TBitmap; X, Y: Integer; W, H: Single): Integer;
var
  LI: Integer;
begin
  Result := 0;
  for LI := 1 to 8 do
    if IsPixEmpty(Tex, X + Neighbours[LI, 1], Y + Neighbours[LI, 2], W, H) then
      Inc(Result);
end;

// finds nearest non-empty pixel with maximum empty neighbours which is NOT neighbour of some other pixel
// Returns true if found and XF,YF - coordinates
// This function may look odd but I need it for finding primary circumscribed poly which later will be
// simplified
class function PolyPointTrace.FindNearestButNotNeighbourOfOther(Tex: TBitmap; Xs, Ys, XOther, YOther: Integer; var XF, YF: Integer; W, H: Single): Boolean;
var
  LI, LMaxEmpty, LE: Integer;
  LXt, LYt: Integer;
begin
  LMaxEmpty := 0;
  Result := False;
  for LI := 1 to 8 do
  begin
    LXt := Xs + Neighbours[LI, 1];
    LYt := Ys + Neighbours[LI, 2];
    // is it non-empty and not-a-neighbour point?
    if (not IsInList(LXt, LYt)) and (not IsNeighbour(LXt, LYt, XOther, YOther)) and
      (not IsPixEmpty(Tex, LXt, LYt, W, H)) then
    begin
      LE := CountEmptyAround(Tex, LXt, LYt, W, H); // ok. count empties around
      if LE > LMaxEmpty then // the best choice point has max empty neighbours
      begin
        XF := LXt;
        YF := LYt;
        LMaxEmpty := LE;
        Result := true;
      end;
    end;
  end;
end;

// simplifying procedures
class function PolyPointTrace.LineLength(X1, Y1, X2, Y2: Integer): Extended;
var
  LA, LB: Integer;
begin
  LA := Abs(X2 - X1);
  LB := Abs(Y2 - Y1);
  Result := Sqrt(LA * LA + LB * LB);
end;

//class function PolyPointTrace.TriangleSquare(X1, Y1, X2, Y2, X3, Y3: Integer): Extended;
//var
//  LP: Extended;
//  LA, LB, LC: Extended;
//begin
//  LA := LineLength(X1, Y1, X2, Y2);
//  LB := LineLength(X2, Y2, X3, Y3);
//  LC := LineLength(X3, Y3, X1, Y1);
//  LP := LA + LB + LC;
//  Result := Sqrt(LP * (LP - LA) * (LP - LB) * (LP - LC)); // using Heron's formula
//end;

// for alternate method simplifying I decided to use "thinness" of triangles
// the idea is that if square of triangle is small but his perimeter is big it means that
// triangle is "thin" - so it can be approximated to line
class function PolyPointTrace.TriangleThinness(X1, Y1, X2, Y2, X3, Y3: Integer): Extended;
var
  LP: Extended;
  LA, LB, LC, LS: Extended;
begin
  LA := LineLength(X1, Y1, X2, Y2);
  LB := LineLength(X2, Y2, X3, Y3);
  LC := LineLength(X3, Y3, X1, Y1);
  LP := LA + LB + LC;
  LS := Sqrt(LP * (LP - LA) * (LP - LB) * (LP - LC));
  // using Heron's formula to find triangle'LS square
  Result := LS / LP;
  // so if this result less than some Mju then we can approximate particular triangle
end;

class procedure PolyPointTrace.ApplyPolyPoint(aPolyPoint: TPolyPoint; aNum: Integer; aOrigin: PVector);
var
  LI: Integer;
begin
  for LI := 0 to mPntCount - 1 do
  begin
    aPolyPoint.AddPoint(aNum, mPolyArr[LI].X, mPolyArr[LI].Y, aOrigin);
  end;
end;

class procedure PolyPointTrace.Init(aMju: Extended = 6; aMaxStepBack: Integer = 10; aAlphaThreshold: Byte = 70);
begin
  Done;
  mMju := aMju;
  mMaxStepBack := aMaxStepBack;
  mAlphaThreshold := aAlphaThreshold;
end;

class procedure PolyPointTrace.Done;
begin
  mPntCount := 0;
  mPolyArr := nil;
end;

class function PolyPointTrace.GetPointCount: Integer;
begin
  Result := mPntCount;
end;

// primarily tracer procedure (gives too precise polyline - need to simplify later)
class procedure PolyPointTrace.PrimaryTrace(aTex: TBitmap; aWidth, aHeight: Single);
var
  LI: Integer;
  LXn, LYn, LXnn, LYnn: Integer;
  LNextPointFound: Boolean;
  LBack: Integer;
  LLStepBack: Integer;
begin
  FindStartingPoint(aTex, LXn, LYn, aWidth, aHeight);
  LNextPointFound := LXn <> 1000000;
  LLStepBack := 0;
  while LNextPointFound do
  begin
    LNextPointFound := False;
    // checking if we got LBack to starting point...
    if not((mPntCount > 3) and IsNeighbour(LXn, LYn, mPolyArr[0].X, mPolyArr[0].Y))
    then
    begin
      if mPntCount > 7 then
        LBack := 7
      else
        LBack := mPntCount;
      if LBack = 0 then // no points in list - take any near point
        LNextPointFound := FindNearestButNotNeighbourOfOther(aTex, LXn, LYn, -100,
          -100, LXnn, LYnn, aWidth, aHeight)
      else
        // checking near but not going LBack
        for LI := 1 to LBack do
        begin
          LNextPointFound := FindNearestButNotNeighbourOfOther(aTex, LXn, LYn,
            mPolyArr[mPntCount - LI].X, mPolyArr[mPntCount - LI].Y, LXnn, LYnn, aWidth, aHeight);
          LNextPointFound := LNextPointFound and (not IsInList(LXnn, LYnn));
          if LNextPointFound then
            Break;
        end;
      AddPoint(LXn, LYn);
      if LNextPointFound then
      begin
        LXn := LXnn;
        LYn := LYnn;
        LLStepBack := 0;
      end
      else if LLStepBack < mMaxStepBack then
      begin
        LXn := mPolyArr[mPntCount - LLStepBack * 2 - 2].X;
        LYn := mPolyArr[mPntCount - LLStepBack * 2 - 2].Y;
        Inc(LLStepBack);
        LNextPointFound := true;
      end;
    end;
  end;
  // close the poly
  if mPntCount > 0 then
    AddPoint(mPolyArr[0].X, mPolyArr[0].Y);
end;

class procedure PolyPointTrace.SimplifyPoly;
var
  I: Integer;
  Finished: Boolean;
  Thinness: Extended;
begin
  Finished := False;
  while not Finished do
  begin
    I := 0;
    Finished := true;
    while I <= mPntCount - 3 do
    begin
      Thinness := TriangleThinness(mPolyArr[I].X, mPolyArr[I].Y, mPolyArr[I + 1].X,
        mPolyArr[I + 1].Y, mPolyArr[I + 2].X, mPolyArr[I + 2].Y);
      if Thinness < mMju then
      // the square of triangle is too thin - we can approximate it!
      begin
        DelPoint(I + 1); // so delete middle point
        Finished := False;
      end;
      Inc(I);
    end;
  end;
end;

{ --- ENTITY ---------------------------------------------------------------- }
{ TEntity }
constructor TEntity.Create;
begin
  inherited;

end;

destructor TEntity.Destroy;
begin

  inherited;
end;

procedure  TEntity.Init(aSprite: TSprite; aGroup: Integer);
begin
  FSprite      := aSprite;
  FGroup       := aGroup;
  FFrame       := 0;
  FFrameFPS    := 15;
  FScale       := 1.0;
  FAngle       := 0;
  FAngleOffset := 0;
  FColor       := WHITE;
  FHFlip       := False;
  FVFlip       := False;
  FLoopFrame   := True;
  FRenderPolyPoint := False;
  FShrinkFactor:= 1.0;
  FOrigin.X := 0.5;
  FOrigin.Y := 0.5;
  FFrameTimer := 0;
  SetPosAbs(0, 0);
  SetFrameRange(0, aSprite.GetImageCount(FGroup)-1);
  SetFrame(FFrame);
end;

procedure TEntity.SetFrameRange(aFirst: Integer; aLast: Integer);
begin
  FFirstFrame := aFirst;
  FLastFrame  := aLast;
end;

function  TEntity.NextFrame: Boolean;
begin
  Result := False;
  if Engine.FrameSpeed(FFrameTimer, FFrameFPS) then
  begin
    Inc(FFrame);
    if FFrame > FLastFrame then
    begin
      if FLoopFrame then
        FFrame := FFirstFrame
      else
        FFrame := FLastFrame;
      Result := True;
    end;
  end;
  SetFrame(FFrame);
end;

function  TEntity.PrevFrame: Boolean;
begin
  Result := False;
  if Engine.FrameSpeed(FFrameTimer, FFrameFPS) then
  begin
    Dec(FFrame);
    if FFrame < FFirstFrame then
    begin
      if FLoopFrame then
        FFrame := FLastFrame
      else
        FFrame := FFirstFrame;
      Result := True;
    end;
  end;

  SetFrame(FFrame);
end;

procedure TEntity.SetPosAbs(aX: Single; aY: Single);
begin
  FPos.X := aX;
  FPos.Y := aY;
  FDir.X := 0;
  FDir.Y := 0;
end;

procedure TEntity.SetPosRel(aX: Single; aY: Single);
begin
  FPos.X := FPos.X + aX;
  FPos.Y := FPos.Y + aY;
  FDir.X := aX;
  FDir.Y := aY;
end;

procedure TEntity.SetScaleAbs(aScale: Single);
begin
  FScale := aScale;
  SetFrame(FFrame);
end;

procedure TEntity.SetScaleRel(aScale: Single);
begin
  FScale := FScale + aScale;
  SetFrame(FFrame);
end;

procedure TEntity.SetAngleOffset(aAngle: Single);
begin
  aAngle := aAngle + FAngleOffset;
  Math.ClipValue(aAngle, 0, 360, True);
  FAngleOffset := aAngle;
end;

procedure TEntity.RotateAbs(aAngle: Single);
begin
  Math.ClipValue(aAngle, 0, 360, True);
  FAngle := aAngle;
end;

procedure TEntity.RotateRel(aAngle: Single);
begin
  aAngle := aAngle + FAngle;
  Math.ClipValue(aAngle, 0, 360, True);
  FAngle := aAngle;
end;

function  TEntity.RotateToAngle(aAngle: Single; aSpeed: Single): Boolean;
var
  Step: Single;
  Len : Single;
  S   : Single;
begin
  Result := False;
  Step := Math.AngleDifference(FAngle, aAngle);
  Len  := Sqrt(Step*Step);
  if Len = 0 then
    Exit;
  S    := (Step / Len) * aSpeed;
  FAngle := FAngle + S;
  if Math.SameValue(Step, 0, S) then
  begin
    RotateAbs(aAngle);
    Result := True;
  end;
end;

function  TEntity.RotateToPos(aX: Single; aY: Single; aSpeed: Single): Boolean;
var
  LAngle: Single;
  LStep: Single;
  LLen: Single;
  LS: Single;
  LTmpPos: TVector;
begin
  Result := False;
  LTmpPos.X  := aX;
  LTmpPos.Y  := aY;

  LAngle := -FPos.Angle(LTmpPos);
  LStep := Math.AngleDifference(FAngle, LAngle);
  LLen  := Sqrt(LStep*LStep);
  if LLen = 0 then
    Exit;
  LS := (LStep / LLen) * aSpeed;

  if not Math.SameValue(LStep, LS, aSpeed) then
    RotateRel(LS)
  else begin
    RotateRel(LStep);
    Result := True;
  end;
end;

function  TEntity.RotateToPosAt(aSrcX: Single; aSrcY: Single; aDestX: Single; aDestY: Single; aSpeed: Single): Boolean;
var
  LAngle: Single;
  LStep : Single;
  LLen  : Single;
  LS    : Single;
  LSPos,LDPos : TVector;
begin
  Result := False;
  LSPos.X := aSrcX;
  LSPos.Y := aSrcY;
  LDPos.X  := aDestX;
  LDPos.Y  := aDestY;

  LAngle := LSPos.Angle(LDPos);
  LStep := Math.AngleDifference(FAngle, LAngle);
  LLen  := Sqrt(LStep*LStep);
  if LLen = 0 then
    Exit;
  LS := (LStep / LLen) * aSpeed;
  if not Math.SameValue(LStep, LS, aSpeed) then
    RotateRel(LS)
  else begin
    RotateRel(LStep);
    Result := True;
  end;
end;

procedure TEntity.Thrust(aSpeed: Single);
var
  LA, LS: Single;
begin
  LA := FAngle + 90.0;
  Math.ClipValue(LA, 0, 360, True);

  LS := -aSpeed;

  FDir.x := Math.AngleCos(Round(LA)) * LS;
  FDir.y := Math.AngleSin(Round(LA)) * LS;

  FPos.x := FPos.x + FDir.x;
  FPos.y := FPos.y + FDir.y;
end;

procedure TEntity.ThrustAngle(aAngle: Single; aSpeed: Single);
var
  LA, LS: Single;
begin
  LA := aAngle;

  Math.ClipValue(LA, 0, 360, True);

  LS := -aSpeed;

  FDir.x := Math.AngleCos(Round(LA)) * LS;
  FDir.y := Math.AngleSin(Round(LA)) * LS;

  FPos.x := FPos.x + FDir.x;
  FPos.y := FPos.y + FDir.y;
end;

function  TEntity.ThrustToPos(aThrustSpeed: Single; aRotSpeed: Single; aDestX: Single; aDestY: Single; aSlowdownDist: Single; aStopDist: Single; aStopSpeed: Single; aStopSpeedEpsilon: Single; aDeltaTime: Single): Boolean;
var
  LDist : Single;
  LStep : Single;
  LSpeed: Single;
  LDestPos: TVector;
begin
  Result := False;

  if aSlowdownDist <= 0 then Exit;
  if aStopDist < 0 then aStopDist := 0;

  LDestPos.X := aDestX;
  LDestPos.Y := aDestY;
  LDist := FPos.Distance(LDestPos);

  LDist := LDist - aStopDist;

  if LDist > aSlowdownDist then
    begin
      LSpeed := aThrustSpeed;
    end
  else
    begin
      LStep := (LDist/aSlowdownDist);
      LSpeed := (aThrustSpeed * LStep);
      if LSpeed <= aStopSpeed then
      begin
        LSpeed := 0;
        Result := True;
      end;
    end;

  if RotateToPos(aDestX, aDestY, aRotSpeed*aDeltaTime) then
  begin
    Thrust(LSpeed*aDeltaTime);
  end;
end;

function  TEntity.IsVisible(aVirtualX: Single; aVirtualY: Single): Boolean;
var
  LHW,LHH: Single;
  LVPX,LVPY,LVPW,LVPH: Integer;
  LX,LY: Single;
begin
  Result := False;

  LHW := FWidth / 2;
  LHH := FHeight / 2;

  Display.GetViewportSize(@LVPX, @LVPY, @LVPW, @LVPH);

  Dec(LVPW); Dec(LVPH);

  LX := FPos.X - aVirtualX;
  LY := FPos.Y - aVirtualY;

  if LX > (LVPW + LHW) then Exit;
  if LX < -LHW    then Exit;
  if LY > (LVPH + LHH) then Exit;
  if LY < -LHH    then Exit;

  Result := True;
end;

function  TEntity.IsFullyVisible(aVirtualX: Single; aVirtualY: Single): Boolean;
var
  LHW,LHH: Single;
  LVPX,LVPY,LVPW,LVPH: Integer;
  LX,LY: Single;
begin
  Result := False;

  LHW := FWidth / 2;
  LHH := FHeight / 2;

  Display.GetViewportSize(@LVPX, @LVPY, @LVPW, @LVPH);

  Dec(LVPW); Dec(LVPH);

  LX := FPos.X - aVirtualX;
  LY := FPos.Y - aVirtualY;

  if LX > (LVPW - LHW) then Exit;
  if LX <  LHW       then Exit;
  if LY > (LVPH - LHH) then Exit;
  if LY <  LHH       then Exit;

  Result := True;
end;

function  TEntity.Overlap(aX: Single; aY: Single; aRadius: Single; aShrinkFactor: Single): Boolean;
var
  LDist: Single;
  LR1,LR2: Single;
  LV0,LV1: TVector;
begin
  LR1  := FRadius * aShrinkFactor;
  LR2  := aRadius * aShrinkFactor;

  LV0.X := FPos.X;
  LV0.Y := FPos.Y;

  LV1.x := aX;
  LV1.y := aY;

  LDist := LV0.Distance(LV1);

  if (LDist < LR1) or (LDist < LR2) then
    Result := True
  else
   Result := False;
end;

function  TEntity.Overlap(aEntity: TEntity): Boolean;
begin
  Result := Overlap(aEntity.GetPos.X, aEntity.GetPos.Y, aEntity.GetRadius, aEntity.GetShrinkFactor);
end;

procedure TEntity.Render(aVirtualX: Single; aVirtualY: Single);
var
  LX,LY: Single;
  LSV: TVector;
begin
  LX := FPos.X - aVirtualX;
  LY := FPos.Y - aVirtualY;
  LSV.Assign(FScale, FScale);
  FSprite.DrawImage(FFrame, FGroup, LX, LY, @FOrigin, @LSV, FAngle, FColor, FHFlip, FVFlip, FRenderPolyPoint);
end;

procedure TEntity.RenderAt(aX: Single; aY: Single);
var
  LSV: TVector;
begin
  LSV.Assign(FScale, FScale);
  FSprite.DrawImage(FFrame, FGroup, aX, aY, @FOrigin, @LSV, FAngle, FColor, FHFlip, FVFlip, FRenderPolyPoint);
end;

function  TEntity.GetSprite: TSprite;
begin
  Result := FSprite;
end;

function  TEntity.GetGroup: Integer;
begin
  Result := FGroup;
end;

function  TEntity.GetFrame: Integer;
begin
  Result := FFrame;
end;

procedure TEntity.SetFrame(aFrame: Integer);
var
  LW, LH, LR: Single;
begin
  if aFrame > FSprite.GetImageCount(FGroup)-1  then
    FFrame := FSprite.GetImageCount(FGroup)-1
  else
    FFrame := aFrame;

  LW := FSprite.GetImageWidth(FFrame, FGroup);
  LH := FSprite.GetImageHeight(FFrame, FGroup);

  LR := (LW + LH) / 2;

  FWidth  := LW * FScale;
  FHeight := LH * FScale;
  FRadius := LR * FScale;
end;

function  TEntity.GetFrameFPS: Single;
begin
  Result := FFrameFPS;
end;

procedure TEntity.SetFrameFPS(aFrameFPS: Single);
begin
  FFrameFPS := aFrameFPS;
  FFrameTimer := 0;
end;

function  TEntity.GetFirstFrame: Integer;
begin
  Result := FFirstFrame;
end;

function  TEntity.GetLastFrame: Integer;
begin
  Result := FLastFrame;
end;

function  TEntity.GetPos: TVector;
begin
  Result := FPos;
end;

function  TEntity.GetDir: TVector;
begin
  Result := FDir;
end;

function  TEntity.GetScale: Single;
begin
  Result := FScale;
end;

function  TEntity.GetAngle: Single;
begin
  Result := FAngle;
end;

function  TEntity.GetAngleOffset: Single;
begin
  Result := FAngleOffset;
end;

function  TEntity.GetColor: TColor;
begin
 Result := FColor;
end;

procedure TEntity.SetColor(aColor: TColor);
begin
  FColor := aColor;
end;

procedure TEntity.GetFlipMode(aHFlip: PBoolean; aVFlip: PBoolean);
begin
  if Assigned(aHFlip) then
    aHFlip^ := FHFlip;
  if Assigned(aVFlip) then
    aVFlip^ := FVFlip;
end;

procedure TEntity.SetFlipMode(aHFlip: PBoolean; aVFlip: PBoolean);
begin
  if aHFlip <> nil then
    FHFlip := aHFlip^;

  if aVFlip <> nil then
    FVFlip := aVFlip^;
end;

function  TEntity.GetLoopFrame: Boolean;
begin
  Result := FLoopFrame;
end;

procedure TEntity.SetLoopFrame(aLoop: Boolean);
begin
  FLoopFrame := aLoop;
end;

function  TEntity.GetWidth: Single;
begin
  Result := FWidth;
end;

function  TEntity.GetHeight: Single;
begin
  Result := FHeight;
end;

function  TEntity.GetRadius: Single;
begin
  Result := FRadius;
end;

function  TEntity.GetShrinkFactor: Single;
begin
  Result := FShrinkFactor;
end;

procedure TEntity.SetShrinkFactor(aShrinkFactor: Single);
begin
  FShrinkFactor := aShrinkFactor;
end;

procedure TEntity.SetRenderPolyPoint(aRenderPolyPoint: Boolean);
begin
  FRenderPolyPoint := aRenderPolyPoint;
end;

function  TEntity.GetRenderPolyPoint: Boolean;
begin
  Result := FRenderPolyPoint;
end;

procedure TEntity.TracePolyPoint(aMju: Single=6; aMaxStepBack: Integer=12; aAlphaThreshold: Integer=70; aOrigin: PVector=nil);
begin
  FSprite.GroupPolyPointTrace(FGroup, aMju, aMaxStepBack, aAlphaThreshold, aOrigin);
end;

function  TEntity.CollidePolyPoint(aEntity: TEntity; var aHitPos: TVector): Boolean;
var
  LShrinkFactor: Single;
  LHFlip,LVFlip: Boolean;
begin
  LShrinkFactor := (FShrinkFactor + aEntity.GetShrinkFactor) / 2.0;

  aEntity.GetFlipMode(@LHFlip, @LVFlip);

  Result := FSprite.GroupPolyPointCollide(
    FFrame, FGroup, Round(FPos.X), Round(FPos.Y), FScale, FAngle, @FOrigin,
    FHFlip, FVFlip, aEntity.FSprite, aEntity.FFrame, aEntity.FGroup,
    Round(aEntity.FPos.X), Round(aEntity.FPos.Y), aEntity.FScale,
    aEntity.FAngle, @aEntity.FOrigin, LHFlip, LVFlip,
    LShrinkFactor, aHitPos);
end;

function  TEntity.CollidePolyPointPoint(var aPoint: TVector): Boolean;
var
  LShrinkFactor: Single;
begin
  LShrinkFactor := FShrinkFactor;

  Result := FSprite.GroupPolyPointCollidePoint(FFrame, FGroup, FPos.X, FPos.Y,
    FScale, FAngle, @FOrigin, FHFlip, FVFlip, LShrinkFactor, aPoint);
end;

{ --- VIDEO ----------------------------------------------------------------- }
class procedure Video.InitAudio;
begin
  if al_is_audio_installed then
  begin
    if FVoice = nil then
    begin
      FVoice := al_create_voice(44100, ALLEGRO_AUDIO_DEPTH_INT16, ALLEGRO_CHANNEL_CONF_2);
      FMixer := al_create_mixer(44100, ALLEGRO_AUDIO_DEPTH_FLOAT32, ALLEGRO_CHANNEL_CONF_2);
      al_attach_mixer_to_voice(FMixer, FVoice);
    end;
  end;
end;

class procedure Video.ShutdownAudio;
begin
  if al_is_audio_installed then
  begin
    al_detach_mixer(FMixer);
    al_destroy_mixer(FMixer);
    al_destroy_voice(FVoice);
    FMixer := nil;
    FVoice := nil;
  end;
end;

class procedure Video.Setup;
begin
  FHandle := nil;
  FLoop := False;
  FPlaying := False;
  FPaused := False;
  FVoice := nil;
  FMixer := nil;
  FFilename := '';
  Logger.Log('Initialized %s Subsystem', ['Video']);
end;

class procedure Video.Shutdown;
begin
  Unload;
  Logger.Log('Shutdown %s Subsystem', ['Video']);
end;

class procedure Video.Unload;
begin
  if FHandle <> nil then
  begin
    Engine.OnVideoUnload(FFilename);
    al_set_video_playing(FHandle, False);
    al_unregister_event_source(Engine.Queue, al_get_video_event_source(FHandle));
    al_close_video(FHandle);
    ShutdownAudio;
    FHandle := nil;
    FFilename := '';
    FLoop := False;
    FPlaying := False;
    FPaused := False;
  end;
end;

//class function  TVideo.GetHandle: PALLEGRO_VIDEO;
//begin
//  Result := FHandle;
//end;

class procedure Video.Draw(aX, aY: Single);
var
  LFrame: PALLEGRO_BITMAP;
begin
  if FHandle = nil then Exit;
  if (not GetPlaying) and (not FPaused) then Exit;

  LFrame := al_get_video_frame(FHandle);
  if LFrame <> nil then
  begin
    al_draw_scaled_bitmap(LFrame, 0, 0, al_get_bitmap_width(LFrame),
      al_get_bitmap_height(LFrame), aX, aY, al_get_video_scaled_width(FHandle),
      al_get_video_scaled_height(FHandle), 0);
  end;
end;

class function Video.GetLooping: Boolean;
begin
  Result := FLoop;
end;

class function Video.GetPlaying: Boolean;
begin
  if FHandle = nil then
    Result := False
  else
    Result := al_is_video_playing(FHandle);
end;

class procedure Video.Load(aFilename: string);
var
  LMarsheller: TMarshaller;
begin
  if aFilename.IsEmpty then  Exit;

  if not al_filename_exists(LMarsheller.AsAnsi(aFilename).ToPointer) then Exit;
  Unload;
  InitAudio;
  FHandle := al_open_video(Engine.GetArchiveItemFilename(aFilename));
  if FHandle <> nil then
  begin
    al_register_event_source(Engine.Queue, al_get_video_event_source(FHandle));
    al_set_video_playing(FHandle, False);
    FFilename := aFilename;
    Engine.OnVideoLoad(FFilename);
  end;
end;

class procedure Video.Play(aFilename: string; aLoop: Boolean; aGain: Single);
begin
  Load(aFilename);
  Play(aLoop, aGain);
end;

class procedure Video.Play(aLoop: Boolean; aGain: Single);
begin
  if FHandle = nil then Exit;
  al_start_video(FHandle, FMixer);
  al_set_mixer_gain(FMixer, aGain);
  al_set_video_playing(FHandle, True);
  FLoop := aLoop;
  FPlaying := True;
  FPaused := False;
end;

class procedure Video.SetLooping(aLoop: Boolean);
begin
  FLoop := aLoop;
end;

class procedure Video.SetPlaying(aPlay: Boolean);
begin
  if FHandle = nil then Exit;
  if FPaused then Exit;
  al_set_video_playing(FHandle, aPlay);
  FPlaying := aPlay;
  FPaused := False;
end;

class function  Video.GetFilename: string;
begin
  Result := FFilename;
end;

class procedure Video.GetSize(aWidth: PSingle; aHeight: PSingle);
begin
  if FHandle = nil then
  begin
    if aWidth <> nil then
      aWidth^ := 0;
    if aHeight <> nil then
      aHeight^ := 0;
    Exit;
  end;
  if aWidth <> nil then
    aWidth^ := al_get_video_scaled_width(FHandle);
  if aHeight <> nil then
    aHeight^ := al_get_video_scaled_height(FHandle);
end;

class procedure Video.Seek(aPos: Single);
begin
  if FHandle = nil then Exit;
  al_seek_video(FHandle, aPos);
end;

class procedure Video.SetPause(aPause: Boolean);
begin
  // if not FPlaying then Exit;
  if FHandle = nil then Exit;

  // if trying to pause and video is not playing, just exit
  if (aPause = True) then
  begin
    if not al_is_video_playing(FHandle) then
    Exit;
  end;

  // if trying to unpause without first being paused, just exit
  if (aPause = False) then
  begin
    if FPaused = False then
      Exit;
  end;

  al_set_video_playing(FHandle, not aPause);
  FPaused := aPause;
end;

class function Video.GetPause: Boolean;
begin
  Result := FPaused;
end;

class procedure Video.Rewind;
begin
  if FHandle = nil then Exit;
  al_seek_video(FHandle, 0);
end;

class procedure Video.FinishedEvent(aHandle: PALLEGRO_VIDEO);
begin
  if FHandle <> aHandle then Exit;
  if FLoop then
    begin
      Rewind;
      if not FPaused then
        SetPlaying(True);
    end
  else
    begin
      Engine.OnVideoFinished(FFilename);
    end;
end;

{ --- SCREENSHOT ------------------------------------------------------------ }
{ Screenshot }
class procedure Screenshot.Setup;
begin
  FFlag := False;
  FFilename := '';
  FDir := 'Screenshots';
  FBaseFilename := 'Screen';
  Init('', '');
end;

class procedure Screenshot.Shutdown;
begin
end;

class procedure Screenshot.Init(const aDir: string; const aBaseFilename: string);
var
  LDir: string;
  LBaseFilename: string;
begin
  FFilename := '';
  FFlag := False;

  LDir := aDir;
  LBaseFilename := aBaseFilename;

  if LDir.IsEmpty then
    LDir := 'Screenshots';
  FDir := LDir;

  if LBaseFilename.IsEmpty then
    LBaseFilename := 'Screen';
  FBaseFilename := LBaseFilename;

  ChangeFileExt(FBaseFilename, '');
end;

class procedure Screenshot.Take;
begin
  FFlag := True;
end;

class procedure Screenshot.Process;
var
  LC: Integer;
  LF, LD, LB: string;
begin
  if Screenshake.Active then Exit;
  if not FFlag then Exit;

  FFlag := False;

  // director
  LD := ExpandFilename(FDir);
  ForceDirectories(LD);

  // base name
  LB := FBaseFilename;

  // search file maks
  LF := LB + '*.png';

  // file count
  LC := FileCount(LD, LF);

  // screenshot file mask
  LF := Format('%s\%s (%.3d).png', [LD, LB, LC]);
  FFilename := LF;

  // save screenshot
  Display.Save(LF);
end;

{ --- SCREENSHAKE ----------------------------------------------------------- }
{ TAScreenshake }
constructor TAScreenshake.Create(aDuration: Single; aMagnitude: Single);
begin
  inherited Create;

  FActive := True;
  FDuration := aDuration;
  FMagnitude := aMagnitude;
  FTimer := 0;
  FPos.x := 0;
  FPos.y := 0;
end;

destructor TAScreenshake.Destroy;
begin

  inherited;
end;

function lerp(t: Single; a: Single; b: Single): Single; inline;
begin
  Result := (1 - t) * a + t * b;
end;

procedure TAScreenshake.Process(aSpeed: Single; aDeltaTime: Double);
begin
  if not FActive then Exit;

  FDuration := FDuration - (aSpeed * aDeltaTime);
  if FDuration <= 0 then
  begin
    Display.SetTransformPosition(-FPos.x, -FPos.y);
    FActive := False;
    Exit;
  end;

  if Round(FDuration) <> Round(FTimer) then
  begin
    Display.SetTransformPosition(-FPos.x, -FPos.y);

    FPos.x := Round(Math.RandomRange(-FMagnitude, FMagnitude));
    FPos.y := Round(Math.RandomRange(-FMagnitude, FMagnitude));

    Display.SetTransformPosition(FPos.x, FPos.y);

    FTimer := FDuration;
  end;
end;

{ Screenshake }
class procedure Screenshake.Setup;
begin
  FList := TObjectList<TAScreenshake>.Create(True);
  al_identity_transform(@FTrans);
end;

class procedure Screenshake.Shutdown;
begin
  FreeAndNil(FList);
end;

class procedure Screenshake.Start(aDuration: Single; aMagnitude: Single);
var
  LShake: TAScreenshake;
begin
  LShake := TAScreenshake.Create(aDuration, aMagnitude);
  FList.Add(LShake);
end;

class procedure Screenshake.Clear;
begin
  FList.Clear;
end;

class function Screenshake.Active: Boolean;
begin
  Result := Boolean(FList.Count > 0);
end;

class procedure Screenshake.Process(aSpeed: Single; aDeltaTime: Double);
var
  LShake: TAScreenshake;
  LFlag: Boolean;
begin
  // process shakes
  LFlag := Active;
  for LShake in FList do
  begin
    if LShake.Active then
    begin
      LShake.Process(aSpeed, aDeltaTime);
    end
    else
    begin
      FList.Remove(LShake);
    end;
  end;

  if LFlag then
  begin
    if not Active then
    begin
      // Lib.Display.ResetTransform;
    end;
  end;

end;

end.
