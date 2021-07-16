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

program GVExamples;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  GameVision.CLib.Allegro in '..\sources\GameVision.CLib.Allegro.pas',
  GameVision.Common in '..\sources\GameVision.Common.pas',
  GameVision.Input in '..\sources\GameVision.Input.pas',
  GameVision.Graphics in '..\sources\GameVision.Graphics.pas',
  GameVision.Audio in '..\sources\GameVision.Audio.pas',
  GameVision.System in '..\sources\GameVision.System.pas',
  GameVision.Game in '..\sources\GameVision.Game.pas',
  GameVision.UI in '..\sources\GameVision.UI.pas',
  GameVision.Network in '..\sources\GameVision.Network.pas',
  GameVision.Utils in '..\sources\GameVision.Utils.pas',
  GameVision.Form.StartupDialog in '..\sources\GameVision.Form.StartupDialog.pas' {StartupDialogForm},
  GameVision.CLib.Nuklear in '..\sources\GameVision.CLib.Nuklear.pas',
  GameVision.TLB.SpeechLib in '..\sources\GameVision.TLB.SpeechLib.pas',
  uTestbed in 'uTestbed.pas',
  GameVision.Form.TreeMenu in '..\sources\GameVision.Form.TreeMenu.pas' {TreeMenuForm},
  uCommon in 'uCommon.pas',
  uAudio in 'uAudio.pas',
  uGraphics in 'uGraphics.pas',
  uInput in 'uInput.pas',
  uSystem in 'uSystem.pas',
  uUI in 'uUI.pas',
  uNetwork in 'uNetwork.pas',
  GameVision.CLib.CSFMLAudio in '..\sources\GameVision.CLib.CSFMLAudio.pas',
  uElastic in 'uElastic.pas',
  uAstroBlaster in 'uAstroBlaster.pas';

begin
  try
    Engine.RunGame(TTestbed);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
