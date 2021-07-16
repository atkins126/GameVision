{==============================================================================
                         _
 __ ___  _ ___ _ _  __ _(_)_ _  ___™
 \ \ / || / -_) ' \/ _` | | ' \/ -_)
 /_\_\\_, \___|_||_\__, |_|_||_\___|
      |__/         |___/

 Copyright © 2020-21 tinyBigGAMES™ LLC
 All rights reserved.

 website: https://tinybiggames.com
 email  : support@tinybiggames.com

============================================================================== }

unit uTemplate;

interface

uses
  System.SysUtils,
  xyengine.common,
  xyengine.audio,
  xyengine.graphics,
  xyengine.input,
  xyengine.system,
  xyengine.ui,
  xyengine.game,
  ucommon;

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



end.
