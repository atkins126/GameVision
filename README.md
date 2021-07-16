![GameVision Logo](Media/Logo.png)

[![Chat on Discord](https://img.shields.io/discord/754884471324672040.svg?logo=discord)](https://discord.gg/tPWjMwK) [![GitHub stars](https://img.shields.io/github/stars/tinyBigGAMES/GameVision?style=social)](https://github.com/tinyBigGAMES/GameVision/stargazers) [![GitHub Watchers](https://img.shields.io/github/watchers/tinyBigGAMES/GameVision?style=social)](https://github.com/tinyBigGAMES/GameVision/network/members) [![GitHub forks](https://img.shields.io/github/forks/tinyBigGAMES/GameVision?style=social)](https://github.com/tinyBigGAMES/GameVision/network/members)
[![Twitter Follow](https://img.shields.io/twitter/follow/tinyBigGAMES?style=social)](https://twitter.com/tinyBigGAMES)

## Overview
GameVision Toolkit&trade; is 2D indie game SDK to allow easy, fast & fun 2D game development in <a href="https://www.embarcadero.com/products/delphi" target="_blank">Delphi</a> on desktop PC's running Microsoft Windows® and uses Direct3D® for hardware accelerated rendering.

It's robust, designed for easy, fast & fun use an suitable for making all types of 2D games and other graphic simulations, You access the features from a simple and intuitive API, to allow you to rapidly and efficiently develop your graphics simulations. There is support for bitmaps, audio samples, streaming music, video playback, loading resources directly from a standard ZIP archive and much more.

## Downloads
<a href="https://github.com/tinyBigGAMES/GameVision/archive/main.zip" target="_blank">**Development**</a> - This build represent the most recent development state an as such may or may not be as stable as the official release versions. If you like living on the bleeding edge, it's updated frequently (often daily) and will contain bug fixes and new features.

<a href="https://github.com/tinyBigGAMES/GameVision/releases" target="_blank">**Releases**</a> - These are the official release versions and deemed to be the most stable.

## Features
- **Free and open source**
- All required libraries are **bundled** in Vivace (<a href="https://github.com/liballeg/allegro5" target="_blank">Allegro</a>, <a href="https://github.com/Immediate-Mode-UI/Nuklear" target="_blank">Nulkear</a>, <a href="https://github.com/SFML/CSFML" target="_blank">CSFMLAudio</a>, <a href="https://github.com/LuaJIT/LuaJIT" target="_blank">LuaJIT</a>)
- Written in **Object Pascal**, optimized for Delphi 11
- Support 64bit platform only
- Hardware accelerated with **Direct3D**
- You interact with the toolkit via **routines**, **class objects** and a thin **OOP framework**
- **Archive** (mount/unmount, ZIP format )
- **Display** ( Direct3D, antialiasing, vsync, viewports, primitives, blending)
- **Input** (keyboard, mouse and joystick)
- **Bitmap** (color key transparency, scaling, rotation, flipped, titled,  BMP, DDS, PCX, TGA, JPEG, PNG)
- **Video** (play, pause, rewind, OGV format)
- **Sprite** (pages, groups, animation, polypoint collision)
- **Entity** (defined from a sprite, position, scale, rotation, collision)
- **Actor** (list, scene, statemachine)
- **Audio** (samples, streams, WAV, OGG/Vorbis, FLAC formats)
- **Speech** (multiple voices, play, pause)
- **Font** (true type, scale, rotate, 2 builtin)
- **Timing** (time-based, frame elapsed, frame speed)
- **Scripting** (load, save, easy manual binding to Pascal, FFI from script)
- **Shaders** (vertex, pixel, HLSL)
- **Misc** (screenshake, screenshot, starfied, colors, ini based config files, startup dialog, treeview menu)

## Minimum System Requirements
- <a href="https://www.embarcadero.com/products/delphi" target="_blank">Delphi 11</a>
- Microsoft Windows 10, 64bits
- DirectX 9

## How to use in Delphi
- Unzip the archive to a desired location.
- Add `installdir\source\library` and `installdir\source\utils`to Delphi's library path so the toolkit source files can be found for any project or for a specific project add to projects search path.
- See examples in the `installdir\examples` for more information about usage. You can load all examples using the `GameVision Toolkit` project group file located in the `installdir\source` folder.
- Build `ViArc` utility for making .ARC files (standard zip archives). Running the `makearc.bat` in `installdir\bin` will build `Data.arc` that is used by the examples.
- Build `GVDump` utiltiy if you need convert a small binary file to Pascal source format that can be included `{$I MyBinaryFile.inc}` in your project.
- Build `GVExamples`that showcase will showcase many of the features and capabilities of the toolkit.

## Known Issues
- This project is in active development so changes will be frequent 
- Documentation is WIP. They will continue to evolve
- More examples will continually be added over time

## A Tour of Vivace
### Game Object
You just have to derive a new class from the `TCustomGame` base class and override a few callback methods. You access the toolkit functionality from the classes in the various `GameVision.XXX` units.
```pascal
uses
  GameVision.Common,
  GameVision.Audio,
  GameVision.Graphics,
  GameVision.Input,
  GameVision.System,
  GameVision.UI,
  GameVision.Game;
  
const
  cArchiveFilename   = 'Data.arc';

  cDisplayTitle      = 'MyGame';
  cDisplayWidth      = 800;
  cDisplayHeight     = 480;
  cDisplayFullscreen = False;

type
  { TMyGame }
  TMyGame = class(TCustomGame)
  protected
    FFont: TFont;
  public
    procedure OnLoad; override;
    procedure OnExit; override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnClearDisplay; override;
    procedure OnShowDisplay; override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
  end;
```
### How to use
A minimal implementation example:
```pascal
uses
  System.SysUtils;

{ TMyGame }
procedure TMyGame.OnLoad;
begin
  // open archive file
  Engine.OpenArchive(cArchiveFilename);
end;

procedure TMyGame.OnExit;
begin
  // close archive file
  Engine.CloseArchive(cArchiveFilename);
end;

procedure TMyGame.OnStartup;
begin
  // open display
  Display.Open(cDisplayWidth, cDisplayHeight,  cDisplayFullscreen, cDisplayTitle);

  // create font, use buildin
  FFont := TFont.Create;
end;

procedure TMyGame.OnShutdown;
begin
  // free font
  FreeAndNil(FFont);

  // close display
  Display.Close;
end;

procedure TMyGame.OnUpdate(aDeltaTime: Double);
begin
  // process input
  if Input.KeyboardPressed(KEY_ESCAPE) then
    Engine.SetTerminate(True);
end;

procedure TMyGame.OnClearDisplay;
begin
  // clear display
  Display.Clear(BLACK);
end;

procedure TMyGame.OnShowDisplay;
begin
  // show display
  Display.Show;
end;

procedure TMyGame.OnRender;
begin
  // render any graphics here
end;

procedure TMyGame.OnRenderHUD;
var
  Pos: TVector;
begin
  // assign hud start pos
  Pos.Assign(3, 3, 0);

  // display hud text
  FFont.Print(Pos.X, Pos.Y, Pos.Z, WHITE, alLeft, 'fps %d', [Engine.GetFrameRate]);
  FFont.Print(Pos.X, Pos.Y, 0, GREEN, alLeft, 'Esc - Quit', []);
end;
```
To run your game, call
```pascal
  Engine.RunGame(TMyGame);
```
See the examples for more information on usage.

## Media


## Support
<table>
<tbody>
	<tr>
		<td>Website</td>
		<td><a href="https://tinybiggames.com">https://tinybiggames.com</a></td>
	</tr>
	<tr>
		<td>E-Mail</td>
		<td><a href="mailto:support@tinybiggames.com">support@tinybiggames.com</a></td>
	</tr>
	<tr>
		<td>Discord</td>
		<td><a href="https://discord.gg/tPWjMwK">https://discord.gg/tPWjMwK</a></td>
	</tr>
	<tr>
		<td>Twitter</td>
		<td><a href="https://twitter.com/tinyBigGAMES">https://twitter.com/tinyBigGAMES</a></td>
	</tr>
	<tr>
		<td>Dailymotion</td>
		<td><a href="https://dailymotion.com/tinyBigGAMES">https://dailymotion.com/tinyBigGAMES</a></td>
	</tr>
</tbody>
</table>

<p align="center">
 <a href="https://www.embarcadero.com/products/delphi" target="_blank"><img src="Media/Delphi.png"></a>
</p>

