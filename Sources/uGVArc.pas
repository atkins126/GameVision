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

unit uGVArc;

{$I GameVision.Defines.inc}

interface

uses
  System.Zip,
  GameVision.Utility.Common;

const
  GVARC_DESCRIPTION = 'GameVision Toolkit™ Archive Utility';

type

  { TGVArc }
  TGVArc = class(TUtilityObject)
  protected
    FHandle: TZipFile;
    FCurFilename: string;
    procedure ShowHeader;
    procedure ShowUsage;
    procedure OnProgress(aSender: TObject; aFilename: string; aHeader: TZipHeader; aPosition: Int64);
    procedure Build(aFilename: string; aPath: string);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Run;
  end;

procedure RunArc;

implementation

uses
  System.Types,
  System.SysUtils,
  System.IOUtils,
  GameVision.Common;

procedure RunArc;
var
  Arc: TGVArc;
begin
  Arc := TGVArc.Create;
  try
    Arc.Run;
  finally
    FreeAndNil(Arc);
  end;
end;

procedure TGVArc.ShowHeader;
begin
  PrintLn('%s v%s', [GVARC_DESCRIPTION, GAMEVISION_VERSION]);
  PrintLn(GAMEVISION_LEGALCOPYRIGHT, []);
  PrintLn(GAMEVISION_LEGALTRADEMARK, []);
  PrintLn;
end;

procedure TGVArc.ShowUsage;
begin
  PrintLn('Usage: GVArc filename[.arc] directory', []);
  PrintLn;
end;

procedure TGVArc.OnProgress(aSender: TObject; aFilename: string; aHeader: TZipHeader; aPosition: Int64);
var
  Done: Integer;
begin
  if FCurFilename <> aFilename then
  begin
    PrintLn;
    FCurFilename := aFilename;
  end;
  Done := Round((aPosition / aHeader.UncompressedSize) * 100);
  Print(#13'   Adding %s (%d%s)...', [aFilename, Done, '%']);
end;

procedure TGVArc.Build(aFilename: string; aPath: string);
var
  LPath: string;
  LFile: string;
  LFiles: TStringDynArray;
begin
  //FHandle.Encoding :=
  FHandle.OnProgress := OnProgress;
  if TFile.Exists(aFilename) then
    TFile.Delete(aFilename);
  LPath := System.SysUtils.IncludeTrailingPathDelimiter(aPath);
  LFiles := TDirectory.GetFiles(LPath, '*', TSearchOption.soAllDirectories);
  FHandle.Open(aFilename, zmWrite);
  for LFile in LFiles do
  begin
   FHandle.Add(LFile, LFile, zcDeflate);
  end;
end;

constructor TGVArc.Create;
begin
  inherited;

  FHandle := TZipFile.Create;
  FCurFilename := '';
end;

destructor TGVArc.Destroy;
begin
  FreeAndNil(FHandle);

  inherited;
end;

procedure TGVArc.Run;
var
  Dir: string;
  FName: string;
begin
  ShowHeader;

  // check correct number of params
  if ParamCount < 2 then
  begin
    ShowUsage;
    Exit;
  end;

  // check filename
  FName := ParamStr(1);
  FName := TPath.ChangeExtension(FName, '.arc');

  // check directory
  Dir := ParamStr(2);
  if not TDirectory.Exists(Dir) then
  begin
    PrintLn('Directory was not found: "%s"', [Dir]);
    ShowUsage;
    Exit;
  end;

  PrintLn('Creating %s...', [FName]);

  // create zip archive and show progress
  Build(FName, Dir);

  PrintLn;
  PrintLn;

  // check if zip archive was created
  if TFile.Exists(FName) then
    PrintLn('Done!', [])
  else
    PrintLn('Error creating %s...', [FName]);

end;

end.
