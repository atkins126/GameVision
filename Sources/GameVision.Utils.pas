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

unit GameVision.Utils;

{$I GameVision.Defines.inc }

interface

function  HasConsoleOutput: Boolean;
procedure ProcessMessages;
procedure GotoURL(aURL: string);
function  ResourceExists(aResName: string): Boolean;
function  FileCount(const aPath: string; const aSearchMask: string): Int64;
function  GetFileSize(const aFilename: string): Int64;

implementation

uses
  System.SysUtils,
  System.IOUtils,
  WinApi.Windows,
  WinApi.ShellAPI;

function HasConsoleOutput: Boolean;
var
  Stdout: THandle;
begin
  Stdout := GetStdHandle(Std_Output_Handle);
  Win32Check(Stdout <> Invalid_Handle_Value);
  Result := Stdout <> 0;
end;

procedure ProcessMessages;
var
  LMsg: TMsg;
begin
  while Integer(PeekMessage(LMsg, 0, 0, 0, PM_REMOVE)) <> 0 do
  begin
    TranslateMessage(LMsg);
    DispatchMessage(LMsg);
  end;
end;

procedure GotoURL(aURL: string);
begin
  if aURL.IsEmpty then Exit;
  ShellExecute(0, 'OPEN', PChar(aURL), '', '', SW_SHOWNORMAL);
end;

function ResourceExists(aResName: string): Boolean;
begin
  Result := Boolean((FindResource(hInstance, PChar(aResName), RT_RCDATA) <> 0));
end;

function FileCount(const aPath: string; const aSearchMask: string): Int64;
var
  LSearchRec: TSearchRec;
  LPath: string;
begin
  Result := 0;
  LPath := aPath;
  LPath := System.IOUtils.TPath.Combine(aPath, aSearchMask);
  if FindFirst(LPath, faAnyFile, LSearchRec) = 0 then
    repeat
      if LSearchRec.Attr <> faDirectory then
        Inc(Result);
    until FindNext(LSearchRec) <> 0;
end;

function GetFileSize(const aFilename: string): Int64;
var
  LInfo: TWin32FileAttributeData;
begin
  Result := -1;

  if NOT GetFileAttributesEx(PWideChar(aFileName), GetFileExInfoStandard, @LInfo) then Exit;
  Result := Int64(LInfo.nFileSizeLow) or Int64(LInfo.nFileSizeHigh shl 32);
end;

end.
