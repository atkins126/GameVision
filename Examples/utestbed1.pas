unit utestbed1;

interface

uses
  System.SysUtils,
  xyengine.clib.allegro,
  xyengine.common,
  xyengine.system,
  xyengine.graphics,
  xyengine.input,
  xyengine.game,
  xyengine.ui,
  xyengine.audio;

const
  cGuiWindowFlags: array[0..4] of Cardinal = (GUI_WINDOW_BORDER, GUI_WINDOW_MOVABLE, GUI_WINDOW_SCALABLE, GUI_WINDOW_CLOSABLE, GUI_WINDOW_TITLE);
  cGuiThemes: array[0..4] of string = ('Default', 'White', 'Red', 'Blue', 'Dark');
  cPassword = 'a15bef2d07b24a589c3d78d5ba341a94';
type

  { TMyGame }
  TMyGame = class(TCustomGame)
  protected
    FFont: TFont;
    FText: TText;
    FStarfield: TStarfield;
    FShader: TShader;
    FBmp: TBitmap;
    FSong: array[ 0..1 ] of Integer;
    FSound: array [ 0..2 ] of Integer;
    FChan: Integer;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure OnLoad; override;
    procedure OnExit; override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    function  OnStartupDialogShow: Boolean; override;
    procedure OnStartupDialogMore; override;
    function  OnStartupDialogRun: Boolean; override;
    procedure OnProcessIMGUI; override;
    procedure OnDisplayOpenBefore; override;
    procedure OnDisplayOpenAfter; override;
    procedure OnDisplayCloseBefore; override;
    procedure OnDisplayCloseAfter; override;
    procedure OnDisplayReady(aReady: Boolean); override;
    procedure OnDisplayClear; override;
    procedure OnDisplayToggleFullscreen(aFullscreen: Boolean); override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
    procedure OnDisplayShow; override;
    procedure OnSpeechWord(const aWord: string; const aText: string); override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnVideoFinished(const aFilename: string); override;
    procedure OnVideoLoad(const aFilename: string); override;
    procedure OnVideoUnload(const aFilename: string); override;
    procedure OnCmdConsoleOpen; override;
    procedure OnCmdConsoleClose; override;

  end;

procedure RunTests;

implementation

var
  tints: array[0..11] of Single = (4.0, 0.0, 1.0, 0.0, 4.0, 1.0, 1.0, 0.0, 4.0,4.0, 4.0, 1.0);
  //diffuse_color[4] = {0.1, 0.1, 0.7, 1.0};
  diffuse_color: array[0..3] of Single = (0.1, 0.1, 0.7, 1.0);

procedure pause;
begin
  writeln;
  write('Press ENTER to continue...');
  readln;
end;

procedure RunTests;
begin
  Engine.RunGame(TMyGame);
  //pause;
end;

{ TMyGame }
constructor TMyGame.Create;
begin
  inherited;

end;

destructor TMyGame.Destroy;
begin

  inherited;
end;

procedure TMyGame.OnLoad;
begin
  //TStyles.SetByIndex(1);
  //Engine.OpenArchive('Data.arc', cPassword);
  Engine.OpenArchive('Data.arc');
end;

procedure TMyGame.OnExit;
begin
  Engine.CloseArchive;
end;

procedure TMyGame.OnStartup;
begin
  Display.Open(800, 500, False, 'TMyGame');

  FFont := TFont.Create;

  FText := TText.Create;
  FText.Print(FFont, 50, 250, 1.0, 0.0, [WHITE, RED, BLUE], '^c0^This^c0^ is a test. This is ^c1^red^c0^, this is ^c2^blue^c0^', []);
  FText.Print(FFont, 50, 250, 1.5, 45.0, [WHITE, GREEN], 'I''m at an ^c1^angle^c0^', []);

  FFont.Load(16);


  FStarfield := TStarfield.Create;

  FBmp := TBitmap.LoadBitmap('arc/bitmaps/sprites/kick.png', nil);

  FShader := TShader.Create;
  FShader.Load('arc/shaders/ex_shader');

  Speech.Clear;
  Speech.ChangeVoice(1);
  Speech.Speak('this is a test of using the x-y-engine speech system. x-y-engine is cool', false);

  FSong[0] := Audio.LoadStream('arc/audio/music/song01.ogg');
  FSong[1] := Audio.LoadStream('arc/audio/music/song02.ogg');
  //Audio.PlayStream(FSong[0], 0.05, True);

  FSound[0] := Audio.LoadSample('arc/audio/sfx/digthis.ogg');
  FSound[1] := Audio.LoadSample('arc/audio/sfx/samp1.ogg');
  FSound[2] := Audio.LoadSample('arc/audio/sfx/samp4.ogg');
  //Audio.PlaySample(FSound[0], 0, 1.0, AUDIO_PAN_NONE, 1.0, False);
  //Audio.PlaySample(FSound[0], AUDIO_DYNAMIC, 1.0, AUDIO_PAN_NONE, 1.0, False);
  FChan := AUDIO_INVALID;
end;

procedure TMyGame.OnShutdown;
begin
  Audio.UnloadSample(FSound[1]);
  Audio.UnloadSample(FSound[0]);

  Audio.UnloadStream(FSong[1]);
  Audio.UnloadStream(FSong[0]);
  Video.Unload;
  FreeAndNil(FShader);
  FreeAndNil(FBmp);
  FreeAndNil(FStarfield);
  FreeAndNil(FText);
  FreeAndNil(FFont);
  Display.Close;
end;

function  TMyGame.OnStartupDialogShow: Boolean;
begin
  StartupDialog.SetLogo('arc/startup/banner.png');
  StartupDialog.SetReadme('arc/startup/README.rtf');
  StartupDialog.SetLicense('arc/startup/LICENSE.rtf');
  Result := True;
end;

procedure TMyGame.OnStartupDialogMore;
begin
end;

function  TMyGame.OnStartupDialogRun: Boolean;
begin
  Result := True;
end;

procedure TMyGame.OnProcessIMGUI;
begin
  if GUI.WindowBegin('Window 1', 'Window 1', 50, 50, 270, 220, cGuiWindowFlags) then
  begin
  end;
  GUI.WindowEnd;
end;

procedure TMyGame.OnDisplayOpenBefore;
begin
end;

procedure TMyGame.OnDisplayOpenAfter;
begin
end;

procedure TMyGame.OnDisplayCloseBefore;
begin
end;

procedure TMyGame.OnDisplayCloseAfter;
begin
end;

procedure TMyGame.OnDisplayReady(aReady: Boolean);
begin
end;

procedure TMyGame.OnDisplayClear;
begin
  Display.Clear(BLACK);
end;

procedure TMyGame.OnDisplayToggleFullscreen(aFullscreen: Boolean);
begin
end;

procedure TMyGame.OnRender;
begin
  FStarfield.Render;

  Video.Draw(0,0);

  //al_use_shader(FShader);
  FShader.Enable(True);
  //al_set_shader_float_vector('tint', 3, @tints[6], 1);
  FShader.SetFloatUniform('tint', 3, @tints[6], 1);
  FBmp.Draw(400, 500/2, 1, 0, WHITE, haCenter, vaCenter);
  //al_use_shader(nil);
  FShader.Enable(False);

  //TDisplay.SetBlender(ALLEGRO_ADD, ALLEGRO_ONE, ALLEGRO_DEST_COLOR);
  Display.SetBlendMode(bmAdditiveAlpha);
  var col: TColor; col.Make(255, 255, 255, 255);
  FBmp.Draw(100, 10, 1, 0, col, haCenter, vaCenter);
  FBmp.Draw(100, 10, 1, 0, col, haCenter, vaCenter);
  Display.RestoreDefaultBlendMode;

end;

procedure TMyGame.OnRenderHUD;
var
  LPos: TVector;
begin
  LPos.Assign(3,3,0);

  FFont.Print(LPos.X, LPos.Y, LPos.Z, WHITE, haLeft, 'fps %d', [Engine.GetFrameRate]);
  FFont.Print(LPos.X, LPos.Y, LPos.Z, GREEN, haLeft, 'ESC - Quit', []);
  FFont.Print(LPos.X, LPos.Y, LPos.Z, GREEN, haLeft, 'F11 - Fullscreen toggle', []);
  FFont.Print(LPos.X, LPos.Y, LPos.Z, GREEN, haLeft, 'F12 - Print screen', []);

  FText.Render;
end;

procedure TMyGame.OnDisplayShow;
begin
  Display.Show;
end;

procedure TMyGame.OnSpeechWord(const aWord: string; const aText: string);
begin
  Logger.Log('Speech: %s', [aWord]);
end;

procedure TMyGame.OnUpdate(aDeltaTime: Double);
begin

  if Input.KeyboardPressed(KEY_F11) then
    Display.ToggleFullscreen;

  if Input.KeyboardPressed(KEY_1) then
    Video.Play('arc/videos/tbgintro.ogv', false, 1)
  else
  if Input.KeyboardPressed(KEY_2) then
    Video.Play('arc/videos/wildlife.ogv', true, 1);

  if Input.KeyboardPressed(KEY_3) then
    Audio.PlayStream(FSong[0], 0.5, True)
  else
  if Input.KeyboardPressed(KEY_4) then
    Audio.StopStream(FSong[0])
  else
  if Input.KeyboardPressed(KEY_5) then
    Audio.PlayStream(FSong[1], 0.5, True)
  else
  if Input.KeyboardPressed(KEY_6) then
    Audio.StopStream(FSong[1]);


  if Input.KeyboardPressed(KEY_7) then
    Audio.PlaySample(FSound[1], 0, 1.0, AUDIO_PAN_NONE, 1.0, False);

  if Input.KeyboardPressed(KEY_8) then
    Audio.PlaySample(FSound[0], AUDIO_DYNAMIC, 1.0, AUDIO_PAN_NONE, 1.0, False);

  if Input.KeyboardPressed(KEY_9) then
    FChan := Audio.PlaySample(FSound[2], 1, 1.0, AUDIO_PAN_NONE, 1.0, True);
  if Input.KeyboardPressed(KEY_0) then
    Audio.StopSample(FChan);

  FStarfield.Update(aDeltaTime);
end;

procedure TMyGame.OnVideoFinished(const aFilename: string);
begin
  Logger.Log('Video finished: "%s"', [aFilename]);
end;

procedure TMyGame.OnVideoLoad(const aFilename: string);
begin
  Logger.Log('Video loaded: "%s"', [aFilename]);
end;

procedure TMyGame.OnVideoUnload(const aFilename: string);
begin
  Logger.Log('Video unloaded: "%s"', [aFilename]);
end;

procedure TMyGame.OnCmdConsoleOpen;
begin
  Logger.Log('CmdConsole Open', []);
end;

procedure TMyGame.OnCmdConsoleClose;
begin
  Logger.Log('CmdConsole Close', []);
end;




end.
