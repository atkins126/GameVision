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

program GVExamples;

{$APPTYPE CONSOLE}
//{$APPTYPE GUI}

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
  uAstroBlaster in 'uAstroBlaster.pas',
  uChainAction in 'uChainAction.pas';

begin
  try
    Engine.RunGame(TTestbed);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
