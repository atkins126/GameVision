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

unit GameVision.Input;

{$I GameVision.Defines.inc }

interface

uses
  GameVision.CLib.Allegro,
  GameVision.Common,
  GameVision.System;

const
  MAX_AXES = 3;
  MAX_STICKS = 16;
  MAX_BUTTONS = 32;

  MOUSE_BUTTON_LEFT = 1;
  MOUSE_BUTTON_RIGHT = 2;
  MOUSE_BUTTON_MIDDLE = 3;

{$REGION 'Keyboard Constants'}

const
  // Keyboard Constants
  KEY_A = 1;
  KEY_B = 2;
  KEY_C = 3;
  KEY_D = 4;
  KEY_E = 5;
  KEY_F = 6;
  KEY_G = 7;
  KEY_H = 8;
  KEY_I = 9;
  KEY_J = 10;
  KEY_K = 11;
  KEY_L = 12;
  KEY_M = 13;
  KEY_N = 14;
  KEY_O = 15;
  KEY_P = 16;
  KEY_Q = 17;
  KEY_R = 18;
  KEY_S = 19;
  KEY_T = 20;
  KEY_U = 21;
  KEY_V = 22;
  KEY_W = 23;
  KEY_X = 24;
  KEY_Y = 25;
  KEY_Z = 26;
  KEY_0 = 27;
  KEY_1 = 28;
  KEY_2 = 29;
  KEY_3 = 30;
  KEY_4 = 31;
  KEY_5 = 32;
  KEY_6 = 33;
  KEY_7 = 34;
  KEY_8 = 35;
  KEY_9 = 36;
  KEY_PAD_0 = 37;
  KEY_PAD_1 = 38;
  KEY_PAD_2 = 39;
  KEY_PAD_3 = 40;
  KEY_PAD_4 = 41;
  KEY_PAD_5 = 42;
  KEY_PAD_6 = 43;
  KEY_PAD_7 = 44;
  KEY_PAD_8 = 45;
  KEY_PAD_9 = 46;
  KEY_F1 = 47;
  KEY_F2 = 48;
  KEY_F3 = 49;
  KEY_F4 = 50;
  KEY_F5 = 51;
  KEY_F6 = 52;
  KEY_F7 = 53;
  KEY_F8 = 54;
  KEY_F9 = 55;
  KEY_F10 = 56;
  KEY_F11 = 57;
  KEY_F12 = 58;
  KEY_ESCAPE = 59;
  KEY_TILDE = 60;
  KEY_MINUS = 61;
  KEY_EQUALS = 62;
  KEY_BACKSPACE = 63;
  KEY_TAB = 64;
  KEY_OPENBRACE = 65;
  KEY_CLOSEBRACE = 66;
  KEY_ENTER = 67;
  KEY_SEMICOLON = 68;
  KEY_QUOTE = 69;
  KEY_BACKSLASH = 70;
  KEY_BACKSLASH2 = 71;
  KEY_COMMA = 72;
  KEY_FULLSTOP = 73;
  KEY_SLASH = 74;
  KEY_SPACE = 75;
  KEY_INSERT = 76;
  KEY_DELETE = 77;
  KEY_HOME = 78;
  KEY_END = 79;
  KEY_PGUP = 80;
  KEY_PGDN = 81;
  KEY_LEFT = 82;
  KEY_RIGHT = 83;
  KEY_UP = 84;
  KEY_DOWN = 85;
  KEY_PAD_SLASH = 86;
  KEY_PAD_ASTERISK = 87;
  KEY_PAD_MINUS = 88;
  KEY_PAD_PLUS = 89;
  KEY_PAD_DELETE = 90;
  KEY_PAD_ENTER = 91;
  KEY_PRINTSCREEN = 92;
  KEY_PAUSE = 93;
  KEY_ABNT_C1 = 94;
  KEY_YEN = 95;
  KEY_KANA = 96;
  KEY_CONVERT = 97;
  KEY_NOCONVERT = 98;
  KEY_AT = 99;
  KEY_CIRCUMFLEX = 100;
  KEY_COLON2 = 101;
  KEY_KANJI = 102;
  KEY_PAD_EQUALS = 103;
  KEY_BACKQUOTE = 104;
  KEY_SEMICOLON2 = 105;
  KEY_COMMAND = 106;
  KEY_BACK = 107;
  KEY_VOLUME_UP = 108;
  KEY_VOLUME_DOWN = 109;
  KEY_SEARCH = 110;
  KEY_DPAD_CENTER = 111;
  KEY_BUTTON_X = 112;
  KEY_BUTTON_Y = 113;
  KEY_DPAD_UP = 114;
  KEY_DPAD_DOWN = 115;
  KEY_DPAD_LEFT = 116;
  KEY_DPAD_RIGHT = 117;
  KEY_SELECT = 118;
  KEY_START = 119;
  KEY_BUTTON_L1 = 120;
  KEY_BUTTON_R1 = 121;
  KEY_BUTTON_L2 = 122;
  KEY_BUTTON_R2 = 123;
  KEY_BUTTON_A = 124;
  KEY_BUTTON_B = 125;
  KEY_THUMBL = 126;
  KEY_THUMBR = 127;
  KEY_UNKNOWN = 128;
  KEY_MODIFIERS = 215;
  KEY_LSHIFT = 215;
  KEY_RSHIFT = 216;
  KEY_LCTRL = 217;
  KEY_RCTRL = 218;
  KEY_ALT = 219;
  KEY_ALTGR = 220;
  KEY_LWIN = 221;
  KEY_RWIN = 222;
  KEY_MENU = 223;
  KEY_SCROLLLOCK = 224;
  KEY_NUMLOCK = 225;
  KEY_CAPSLOCK = 226;
  KEY_MAX = 227;
  KEYMOD_SHIFT = $0001;
  KEYMOD_CTRL = $0002;
  KEYMOD_ALT = $0004;
  KEYMOD_LWIN = $0008;
  KEYMOD_RWIN = $0010;
  KEYMOD_MENU = $0020;
  KEYMOD_COMMAND = $0040;
  KEYMOD_SCROLOCK = $0100;
  KEYMOD_NUMLOCK = $0200;
  KEYMOD_CAPSLOCK = $0400;
  KEYMOD_INALTSEQ = $0800;
  KEYMOD_ACCENT1 = $1000;
  KEYMOD_ACCENT2 = $2000;
  KEYMOD_ACCENT3 = $4000;
  KEYMOD_ACCENT4 = $8000;
{$ENDREGION}

var
  // sticks
  JOY_STICK_LS: Integer = 0;
  JOY_STICK_RS: Integer = 1;
  JOY_STICK_LT: Integer = 2;
  JOY_STICK_RT: Integer = 3;

  // axes
  JOY_AXES_X: Integer = 0;
  JOY_AXES_Y: Integer = 1;
  JOY_AXES_Z: Integer = 2;

  // buttons
  JOY_BTN_A: Integer = 0;
  JOY_BTN_B: Integer = 1;
  JOY_BTN_X: Integer = 2;
  JOY_BTN_Y: Integer = 3;
  JOY_BTN_RB: Integer = 4;
  JOY_BTN_LB: Integer = 5;
  JOY_BTN_RT: Integer = 6;
  JOY_BTN_LT: Integer = 7;
  JOY_BTN_BACK: Integer = 8;
  JOY_BTN_START: Integer = 9;
  JOY_BTN_RDPAD: Integer = 10;
  JOY_BTN_LDPAD: Integer = 11;
  JOY_BTN_DDPAD: Integer = 12;
  JOY_BTN_UDPAD: Integer = 13;

type

  { TJoystick }
  TJoystick = record
    Name: string;
    Sticks: Integer;
    Buttons: Integer;
    StickName: array [0 .. MAX_STICKS - 1] of string;
    Axes: array [0 .. MAX_STICKS - 1] of Integer;
    AxesName: array [0 .. MAX_STICKS - 1, 0 .. MAX_AXES - 1] of string;
    Pos: array [0 .. MAX_STICKS - 1, 0 .. MAX_AXES - 1] of Single;
    Button: array [0 .. MAX_BUTTONS - 1] of Boolean;
    ButtonName: array [0 .. MAX_BUTTONS - 1] of string;
    procedure Setup(aNum: Integer);
    function GetPos(aStick: Integer; aAxes: Integer): Single;
    function GetButton(aButton: Integer): Boolean;
  end;

  { Input }
  Input = record
  private
    class var
    FMouseButtons: array [0 .. 256] of Boolean;
    FKeyButtons: array [0 .. 256] of Boolean;
    FJoyButtons: array [0 .. 256] of Boolean;
    var
  public
    class var
      Joystick: TJoystick;
    var
    class procedure Setup; static;
    class procedure Shutdown; static;

    class procedure Clear; static;

    class function  KeyboardPressed(aKey: Integer): Boolean; static;
    class function  KeyboardReleased(aKey: Integer): Boolean; static;
    class function  KeyboardDown(aKey: Integer): Boolean; static;
    class function  KeyboardGetPressed: Integer; static;

    class function  MousePressed(aButton: Integer): Boolean; static;
    class function  MouseReleased(aButton: Integer): Boolean; static;
    class function  MouseDown(aButton: Integer): Boolean; static;
    class procedure MouseGetInfo(aX: PInteger; aY: PInteger; aWheel: PInteger); overload; static;
    class procedure MouseGetInfo(var aPos: TVector); overload; static;
    class procedure MouseSetPos(aX: Integer; aY: Integer); static;
    class procedure MouseShowCursor(aShow: Boolean); static;

    class function  JoystickPressed(aButton: Integer): Boolean; static;
    class function  JoystickReleased(aButton: Integer): Boolean; static;
    class function  JoystickDown(aButton: Integer): Boolean; static;
    class function  JoystickGetPos(aStick: Integer; aAxes: Integer): Single; static;
  end;

implementation

uses
  System.Math,
  WinApi.Windows,
  GameVision.Utils,
  GameVision.Graphics;

{ TJoystick }
procedure TJoystick.Setup(aNum: Integer);
var
  LJoyCount: Integer;
  LJoy: PALLEGRO_JOYSTICK;
  LJoyState: ALLEGRO_JOYSTICK_STATE;
  LI, LJ: Integer;
begin
  LJoyCount := al_get_num_joysticks;
  if (aNum < 0) or (aNum > LJoyCount - 1) then
    Exit;

  LJoy := al_get_joystick(aNum);
  if LJoy = nil then
  begin
    Sticks := 0;
    Buttons := 0;
    Exit;
  end;

  Name := string(al_get_joystick_name(LJoy));

  al_get_joystick_state(LJoy, @LJoyState);

  Sticks := al_get_joystick_num_sticks(LJoy);
  if (Sticks > MAX_STICKS) then
    Sticks := MAX_STICKS;

  for LI := 0 to Sticks - 1 do
  begin
    StickName[LI] := string(al_get_joystick_stick_name(LJoy, LI));
    Axes[LI] := al_get_joystick_num_axes(LJoy, LI);
    for LJ := 0 to Axes[LI] - 1 do
    begin
      Pos[LI, LJ] := LJoyState.stick[LI].axis[LJ];
      AxesName[LI, LJ] := string(al_get_joystick_axis_name(LJoy, LI, LJ));
    end;
  end;

  Buttons := al_get_joystick_num_buttons(LJoy);
  if (Buttons > MAX_BUTTONS) then
    Buttons := MAX_BUTTONS;

  for LI := 0 to Buttons - 1 do
  begin
    ButtonName[LI] := string(al_get_joystick_button_name(LJoy, LI));
    Button[LI] := Boolean(LJoyState.Button[LI] >= 16384);
  end
end;

function TJoystick.GetPos(aStick: Integer; aAxes: Integer): Single;
begin
  Result := Pos[aStick, aAxes];
end;

function TJoystick.GetButton(aButton: Integer): Boolean;
begin
  Result := Button[aButton];
end;


{ Input }
class procedure Input.Setup;
begin
  Clear;
  Logger.Log('Initialized %s Subsystem', ['Input']);
end;

class procedure Input.Shutdown;
begin
  Logger.Log('Shutdown %s Subsystem', ['Input']);
end;

class procedure Input.Clear;
begin
  FillChar(FMouseButtons, SizeOf(FMouseButtons), False);
  FillChar(FKeyButtons, SizeOf(FKeyButtons), False);
  FillChar(FJoyButtons, SizeOf(FJoyButtons), False);

  if Display.GetHandle <> nil then
  begin
    al_clear_keyboard_state(Display.GetHandle);
  end;
end;

// Keyboard
class function Input.KeyboardPressed(aKey: Integer): Boolean;
begin
  Result := False;
  if not InRange(aKey, 0, 255) then  Exit;
  if KeyboardDown(aKey) and (not FKeyButtons[aKey]) then
  begin
    FKeyButtons[aKey] := True;
    Result := True;
  end
  else if (not KeyboardDown(aKey)) and (FKeyButtons[aKey]) then
  begin
    FKeyButtons[aKey] := False;
    Result := False;
  end;
end;

class function Input.KeyboardReleased(aKey: Integer): Boolean;
begin
  Result := False;
  if not InRange(aKey, 0, 255) then Exit;
  if KeyboardDown(aKey) and (not FKeyButtons[aKey]) then
  begin
    FKeyButtons[aKey] := True;
    Result := False;
  end
  else if (not KeyboardDown(aKey)) and (FKeyButtons[aKey]) then
  begin
    FKeyButtons[aKey] := False;
    Result := True;
  end;
end;

class function Input.KeyboardDown(aKey: Integer): Boolean;
begin
  Result := False;
  if not InRange(aKey, 0, 255) then Exit;
  Result := al_key_down(@Engine.KeyboardState, aKey);
end;

class function Input.KeyboardGetPressed: Integer;
begin
  Result := Engine.KeyCode;
end;

// Mouse
class function Input.MousePressed(aButton: Integer): Boolean;
begin
  Result := False;
  if not InRange(aButton, MOUSE_BUTTON_LEFT, MOUSE_BUTTON_MIDDLE) then Exit;

  if MouseDown(aButton) and (not FMouseButtons[aButton]) then
  begin
    FMouseButtons[aButton] := True;
    Result := True;
  end
  else if (not MouseDown(aButton)) and (FMouseButtons[aButton]) then
  begin
    FMouseButtons[aButton] := False;
    Result := False;
  end;
end;

class function Input.MouseReleased(aButton: Integer): Boolean;
begin
  Result := False;
  if not InRange(aButton, MOUSE_BUTTON_LEFT, MOUSE_BUTTON_MIDDLE) then Exit;

  if MouseDown(aButton) and (not FMouseButtons[aButton]) then
  begin
    FMouseButtons[aButton] := True;
    Result := False;
  end
  else if (not MouseDown(aButton)) and (FMouseButtons[aButton]) then
  begin
    FMouseButtons[aButton] := False;
    Result := True;
  end;

end;

class function Input.MouseDown(aButton: Integer): Boolean;
var
  LState: ALLEGRO_MOUSE_STATE;
begin
  Result := False;
  if not InRange(aButton, MOUSE_BUTTON_LEFT, MOUSE_BUTTON_MIDDLE) then Exit;
  al_get_mouse_state(@LState);
  Result := al_mouse_button_down(@LState, aButton);
end;

class procedure Input.MouseGetInfo(var aPos: TVector);
var
  LX, LY, LZ: Integer;
begin
  MouseGetInfo(@LX, @LY, @LZ);
  aPos.x := LX;
  aPos.y := LY;
  aPos.z := LZ;
end;

class procedure Input.MouseGetInfo(aX: PInteger; aY: PInteger; aWheel: PInteger);
var
  LState: ALLEGRO_MOUSE_STATE;
  LMX, LMY, LMW: Integer;
  LVX, LVY: Integer;
begin
  LVX := Round(Display.GetTransSize.x);
  LVY := Round(Display.GetTransSize.y);

  al_get_mouse_state(@LState);
  LMX := al_get_mouse_state_axis(@LState, 0);
  LMY := al_get_mouse_state_axis(@LState, 1);
  LMW := al_get_mouse_state_axis(@LState, 2);

  var LDpi: Integer := GetDpiForWindow(al_get_win_window_handle(Display.GetHandle));
  if (LDpi <> DISPLAY_DEFAULT_DPI) then
  begin
    LMX := Round((LMX - LVX) / Display.GetTransScale);
    LMY := Round((LMY - LVY) / Display.GetTransScale);
  end;

  if aX <> nil then
  begin
    aX^ := LMX;
  end;

  if aY <> nil then
  begin
    aY^ := LMY;
  end;

  if aWheel <> nil then
  begin
    aWheel^ := LMW;
  end;

end;

class procedure Input.MouseSetPos(aX: Integer; aY: Integer);
var
  LMX, LMY: Integer;
  LVX, LVY: Integer;
begin
  LMX := aX;
  LMY := aY;

  LVX := Round(Display.GetTransSize.x);
  LVY := Round(Display.GetTransSize.y);

  var LDpi: Integer := GetDpiForWindow(al_get_win_window_handle(Display.GetHandle));
  if (LDpi <> DISPLAY_DEFAULT_DPI) then
  begin
    LMX := Round(LMX * Display.GetTransScale) + LVX;
    LMY := Round(LMY * Display.GetTransScale) + LVY;
  end;

  al_set_mouse_xy(Display.GetHandle, LMX, LMY);
end;

class procedure Input.MouseShowCursor(aShow: Boolean);
begin
  //ShowCursor(aShow);
  //al_set_system_mouse_cursor(Display.GetHandle, ALLEGRO_SYSTEM_MOUSE_CURSOR_ARROW);
//  if aShow then
//    al_show_mouse_cursor(Display.GetHandle)
//  else
//    al_hide_mouse_cursor(Display.GetHandle);
  //al_set_system_mouse_cursor(Display.GetHandle, ALLEGRO_SYSTEM_MOUSE_CURSOR_ARROW);
  //al_set_system_mouse_cursor(Display.GetHandle, ALLEGRO_SYSTEM_MOUSE_CURSOR_ARROW);
end;

class function Input.JoystickGetPos(aStick: Integer; aAxes: Integer): Single;
begin
  Result := Joystick.Pos[aStick, aAxes];
end;

class function Input.JoystickDown(aButton: Integer): Boolean;
begin
  Result := Joystick.Button[aButton];
end;

class function Input.JoystickPressed(aButton: Integer): Boolean;
begin
  Result := False;
  if not InRange(aButton, 0, MAX_BUTTONS) then Exit;

  if JoystickDown(aButton) and (not FJoyButtons[aButton]) then
  begin
    FJoyButtons[aButton] := True;
    Result := True;
  end
  else if (not JoystickDown(aButton)) and (FJoyButtons[aButton]) then
  begin
    FJoyButtons[aButton] := False;
    Result := False;
  end;
end;

class function Input.JoystickReleased(aButton: Integer): Boolean;
begin
  Result := False;
  if not InRange(aButton, 0, MAX_BUTTONS) then Exit;

  if JoystickDown(aButton) and (not FJoyButtons[aButton]) then
  begin
    FJoyButtons[aButton] := True;
    Result := False;
  end
  else if (not JoystickDown(aButton)) and (FJoyButtons[aButton]) then
  begin
    FJoyButtons[aButton] := False;
    Result := True;
  end;
end;

end.
