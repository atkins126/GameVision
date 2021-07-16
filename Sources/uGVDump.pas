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

unit uGVDump;

{$I GameVision.Defines.inc}

interface

uses
  GameVision.Utility.common,
  GameVision.Common;

const
  GVDUMP_DESCRIPTION = 'GameVision Toolkit™ Dump Utility';

type

  { TGVDump }
  TGVDump = class(TUtilityObject)
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure ShowHeader;
    procedure ShowUsage;
    procedure Run;
  end;

procedure RunDump;

implementation

uses
  System.SysUtils,
  System.IOUtils,
  System.Classes;

procedure RunDump;
var
  Dump: TGVDump;
begin
  Dump := TGVDump.Create;
  try
    Dump.Run;
  finally
    FreeAndNil(Dump);
  end;
end;

{ TGVDump }
constructor TGVDump.Create;
begin
  inherited;
end;

destructor TGVDump.Destroy;
begin
  inherited;
end;

procedure TGVDump.ShowHeader;
begin
  PrintLn('%s v%s', [GVDUMP_DESCRIPTION, GAMEVISION_VERSION]);
  PrintLn(GAMEVISION_LEGALCOPYRIGHT, []);
  PrintLn(GAMEVISION_LEGALTRADEMARK, []);
  PrintLn;
end;

procedure TGVDump.ShowUsage;
begin
  PrintLn('Usage: GVDump filename', []);
  PrintLn;
end;

procedure TGVDump.Run;
var
  InFilename: string;
  OutFilename: string;
  Line: string;
  InFile: TFileStream;
  OutFile: TStringBuilder;
  List: TStringList;
  C: Cardinal;
  S,E: Integer;
  B: Byte;
begin
  ShowHeader;

  if ParamCount < 1 then
  begin
    ShowUsage;
    Exit;
  end;

  InFilename := ParamStr(1);

  if not TFile.Exists(InFilename) then
  begin
    PrintLn('File was not found: "%s"', [InFilename]);
    ShowUsage;
    Exit;
  end;

  OutFilename := TPath.GetFileName(InFilename);
  OutFilename := OutFilename.Replace('.', '_');
  OutFilename := OutFilename + '.inc';
  OutFilename := TPath.Combine(TPath.GetDirectoryName(InFilename), OutFilename);

  PrintLn('Dumping %s...', [InFilename]);
  InFile := TFile.OpenRead(InFilename);
  OutFile := TStringBuilder.Create;
  List := TStringList.Create;
  try
    C := 0;
    S := 0;
    OutFile.Append(Format('const c%s : array[1..', [TPath.GetFileNameWithoutExtension(OutFilename).ToUpper]));
    OutFile.Append(InFile.Size);
    OutFile.Append('] of Byte = (');
    OutFile.AppendLine;

    while InFile.Position < InFile.Size do
    begin
      InFile.Read(B, 1);

      Inc(c, 1);
      if (c = 16) then
      begin
        if (InFile.Position = InFile.Size) then
        begin
          OutFile.Append('$');
          OutFile.Append(IntToHex(B, 2));
          OutFile.AppendLine;
        end
        else
        begin
          OutFile.Append('$');
          OutFile.Append(IntToHex(B, 2));
          OutFile.Append(',');
          OutFile.AppendLine;
        end;
        C := 0;
        E := (OutFile.Length-S)-1;
        Line := OutFile.ToString(S, E);
        S := OutFile.Length-1;
        Print(#13'  Writing %d/%d...', [InFile.Position, InFile.Size]);
      end
      else if (InFile.Position = InFile.Size) then
      begin
        OutFile.Append('$');
        OutFile.Append(IntToHex(B, 2));
        OutFile.AppendLine;
      end
      else
      begin
        OutFile.Append('$');
        OutFile.Append(IntToHex(B, 2));
        OutFile.Append(', ');
      end;
    end;
    OutFile.Append(');');
    List.Add(OutFile.ToString);
    List.SaveToFile(OutFilename);
    PrintLn;
    PrintLn('Done!', []);
  finally
    FreeAndNil(List);
    FreeAndNil(OutFile);
    FreeAndNil(InFile);
  end;
end;

end.
