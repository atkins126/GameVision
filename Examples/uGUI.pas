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

unit uGUI;

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
  cGuiWindowFlags: array[0..4] of Cardinal = (GUI_WINDOW_BORDER, GUI_WINDOW_MOVABLE, GUI_WINDOW_SCALABLE, GUI_WINDOW_CLOSABLE, GUI_WINDOW_TITLE);
  cGuiThemes: array[0..4] of string = ('Default', 'White', 'Red', 'Blue', 'Dark');

type
  { TGUIDemo }
  TGUIDemo = class(TCustomExample)
  protected
    MusicVolume: Single;
    Difficulty: Integer;
    Chk1: Boolean;
    Chk2: Boolean;
    Theme: Integer;
    ThemeChanged: Boolean;
    FMusic: Integer;
    FSfx: Integer;
    FStarfield: TStarfield;
  public
    procedure OnSetConfig(var aConfig: TGameConfig); override;
    procedure OnLoad; override;
    procedure OnExit; override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
    procedure OnProcessIMGUI; override;
  end;

implementation

{ TGUIDemo }
 procedure TGUIDemo.OnSetConfig(var aConfig: TGameConfig);
begin
  inherited;

  aConfig.DisplayTitle := cExampleTitle + 'GUI Demo';
  aConfig.DisplayClearColor := BLACK;
end;

procedure TGUIDemo.OnLoad;
begin
  inherited;

  MusicVolume := 0.3;
  Difficulty := 0;
  Chk1 := False;
  Chk2 := False;
  Theme := 0;
  ThemeChanged := False;
end;

procedure TGUIDemo.OnExit;
begin
  inherited;

end;

procedure TGUIDemo.OnStartup;
begin
  inherited;

  FStarfield := TStarfield.Create;
  FSfx := Audio.LoadSound('arc/audio/sfx/digthis.ogg');

  FMusic := Audio.LoadMusic('arc/audio/music/song07.ogg');
  Audio.PlayMusic(FMusic, MusicVolume, True);
end;

procedure TGUIDemo.OnShutdown;
begin
  Audio.UnloadMusic(FMusic);
  Audio.UnloadSound(FSfx);
  FreeAndNil(FStarfield);

  inherited;
end;

procedure TGUIDemo.OnUpdate(aDeltaTime: Double);
begin
  inherited;

  FStarfield.Update(aDeltaTime);
end;

procedure TGUIDemo.OnRender;
begin
  inherited;

  FStarfield.Render;

  Display.DrawFilledRectangle((Config.DisplayWidth/2)-50, (Config.DisplayHeight/2)-50, 100, 100, DARKGREEN);
end;

procedure TGUIDemo.OnRenderHUD;
begin
  inherited;

end;

procedure TGUIDemo.OnProcessIMGUI;
begin
  if GUI.WindowBegin('Window 1', 'Window 1', 50, 50, 270, 220, cGuiWindowFlags) then
  begin
    GUI.LayoutRowStatic(30, 80, 2);
    GUI.Button('One');
    GUI.Button('Two');

    GUI.LayoutRowDynamic(30, 2);
    if GUI.Option('easy', Boolean(Difficulty = 0)) then
      Difficulty := 0;

    if GUI.Option('hard', Boolean(Difficulty = 1)) then
      Difficulty := 1;

    GUI.LayoutRowBegin(GUI_STATIC, 30, 2);
    GUI.LayoutRowPush(50);
    GUI.&Label('Volume:', GUI_TEXT_LEFT);
    GUI.LayoutRowPush(110);
    if GUI.Slider(0, 1, 0.01, MusicVolume) then
      Audio.SetMusicVolume(FMusic, MusicVolume);
    GUI.LayoutRowPush(120);
    if GUI.Checkbox('Dig this', chk1) then
    begin
      if chk1 then
      begin
        Audio.PlaySound(AUDIO_DYNAMIC_CHANNEL, FSfx, 0.5, False);
      end;
    end;
    GUI.Checkbox('Change theme', chk2);
    GUI.LayoutRowEnd;
  end;
  GUI.WindowEnd;

  if chk2 then
  begin
    if GUI.WindowBegin('Window 2', 'Window 2', 350, 150, 320, 220, cGuiWindowFlags) then
      begin
       GUI.LayoutRowStatic(25, 190, 1);
       Theme := GUI.Combobox(cGuiThemes, Theme, 25, 200, 200, ThemeChanged);
      end
    else
      begin
       chk2 := False;
      end;
    GUI.WindowEnd;

    if ThemeChanged then
      GUI.SetStyle(Theme);
  end;
end;


end.
