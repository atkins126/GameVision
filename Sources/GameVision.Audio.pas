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

unit GameVision.Audio;

{$I GameVision.Defines.inc }

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  GameVision.TLB.SpeechLib,
  GameVision.CLib.Allegro,
  GameVision.CLib.CSFMLAudio;

const
  AUDIO_BUFFER_COUNT = 256;
  AUDIO_CHANNEL_COUNT = 16;
  AUDIO_DYNAMIC_CHANNEL = -1;
  AUDIO_INVALID_INDEX = -2;

type
  { TAudioStatus }
  TAudioStatus = (asStopped, asPaused, asPlaying);

  { TMusicItem }
  TMusicItem = record
    FileHandle: Pointer;
    MusicHandle: PsfMusic;
    Buffer: TObject;
    Size: Int64;
    Filename: string;
  end;

  { TAudioChannel }
  TAudioChannel = record
    Sound: PsfSound;
    Reserved: Boolean;
    Priority: Byte;
  end;

  { TAudioBuffer }
  TAudioBuffer = record
    Buffer: PsfSoundBuffer;
    Filename: string;
  end;

  { Audio }
  Audio = record
  private
    class var
      FMusicList: TList<TMusicItem>;
      FBuffer: array [0 .. AUDIO_BUFFER_COUNT - 1] of TAudioBuffer;
      FChannel: array [0 .. AUDIO_CHANNEL_COUNT - 1] of TAudioChannel;
      FOpened: Boolean;
    class function TimeAsSeconds(aValue: Single): TsfTime; static;
    //class function TimeAsMilliSeconds(aValue: Integer): TsfTime; static;
    class function GetMusicItem(var aMusicItem: TMusicItem; aMusic: Integer): Boolean; static;
    class function AddMusicItem(var aMusicItem: TMusicItem): Integer; static;
    class function FindFreeBuffer(aFilename: string): Integer; static;
    class function FindFreeChannel: Integer; static;
  public

    // General
    class procedure Setup; static;
    class procedure Shutdown; static;
    class procedure Open; static;
    class procedure Close; static;
    class procedure Pause(aPause: Boolean); static;
    class procedure Reset; static;

    // Music
    class function  LoadMusic(aFilename: string): Integer; static;
    class procedure UnloadMusic(var aMusic: Integer); static;
    class procedure UnloadAllMusic; static;
    class procedure PlayMusic(aMusic: Integer); overload; static;
    class procedure PlayMusic(aMusic: Integer; aVolume: Single; aLoop: Boolean); overload; static;
    class procedure StopMusic(aMusic: Integer); static;
    class procedure PauseMusic(aMusic: Integer); static;
    class procedure PauseAllMusic(aPause: Boolean); static;
    class procedure SetMusicLoop(aMusic: Integer; aLoop: Boolean); static;
    class function  GetMusicLoop(aMusic: Integer): Boolean; static;
    class procedure SetMusicVolume(aMusic: Integer; aVolume: Single); static;
    class function  GetMusicVolume(aMusic: Integer): Single; static;
    class function  GetMusicStatus(aMusic: Integer): TAudioStatus; static;
    class procedure SetMusicOffset(aMusic: Integer; aSeconds: Single); static;

    // Sound
    class function  LoadSound(aFilename: string): Integer; static;
    class procedure UnloadSound(aSound: Integer); static;
    class function  PlaySound(aChannel: Integer; aSound: Integer): Integer; overload; static;
    class function  PlaySound(aChannel: Integer; aSound: Integer; aVolume: Single; aLoop: Boolean): Integer; overload; static;

    // Channel
    class procedure SetChannelReserved(aChannel: Integer; aReserve: Boolean); static;
    class function  GetChannelReserved(aChannel: Integer): Boolean; static;
    class procedure PauseChannel(aChannel: Integer; aPause: Boolean); static;
    class function  GetChannelStatus(aChannel: Integer): TAudioStatus; static;
    class procedure SetChannelVolume(aChannel: Integer; aVolume: Single); static;
    class function  GetChannelVolume(aChannel: Integer): Single; static;
    class procedure SetChannelLoop(aChannel: Integer; aLoop: Boolean); static;
    class function  GetChannelLoop(aChannel: Integer): Boolean; static;
    class procedure SetChannelPitch(aChannel: Integer; aPitch: Single); static;
    class function  GetChannelPitch(aChannel: Integer): Single; static;
    class procedure SetChannelPosition(aChannel: Integer; aX: Single; aY: Single); static;
    class procedure GetChannelPosition(aChannel: Integer; var aX: Single; var aY: Single); static;
    class procedure SetChannelMinDistance(aChannel: Integer; aDistance: Single); static;
    class function  GetChannelMinDistance(aChannel: Integer): Single; static;
    class procedure SetChannelRelativeToListener(aChannel: Integer; aRelative: Boolean); static;
    class function  GetChannelRelativeToListener(aChannel: Integer): Boolean; static;
    class procedure SetChannelAttenuation(aChannel: Integer; aAttenuation: Single); static;
    class function  GetChannelAttenuation(aChannel: Integer): Single; static;
    class procedure StopChannel(aChannel: Integer); static;
    class procedure StopAllChannels; static;

    // Listener
    class procedure SetListenerGlobalVolume(aVolume: Single); static;
    class function  GetListenerGlobalVolume: Single; static;
    class procedure SetListenerPosition(aX: Single; aY: Single); static;
    class procedure GetListenerPosition(var aX: Single; var aY: Single); static;
  end;

{ --- SPEECH ---------------------------------------------------------------- }
type
  { TSpeechVoiceAttribute }
  TSpeechVoiceAttribute = (vaDescription, vaName, vaVendor, vaAge, vaGender, vaLanguage, vaId);

  { Speech }
  Speech = class
  private
    class var
      FSpVoice: TSpVoice;
      FVoiceList: TInterfaceList;
      FVoiceDescList: TStringList;
      FPaused: Boolean;
      FText: string;
      FWord: string;
    class procedure OnWord(aSender: TObject; aStreamNumber: Integer; aStreamPosition: OleVariant; aCharacterPosition, aLength: Integer);
//    class procedure OnStartStream(aSender: TObject; aStreamNumber: Integer; aStreamPosition: OleVariant);
    class procedure DoSpeak(aText: string; aFlags: Integer); static;
    class procedure EnumVoices; static;
    class procedure FreeVoices; static;
  public
    class procedure Setup; static;
    class procedure Shutdown; static;

    class function  GetVoiceCount: Integer; static;
    class function  GetVoiceAttribute(aIndex: Integer; aAttribute: TSpeechVoiceAttribute): string; static;
    class procedure ChangeVoice(aIndex: Integer); static;

    class procedure SetVolume(aVolume: Single); static;
    class function  GetVolume: Single; static;

    class procedure SetRate(aRate: Single); static;
    class function  GetRate: Single; static;

    class procedure Clear; static;
    class procedure Speak(aText: string; aPurge: Boolean); static;
    class procedure SpeakXML(aText: string; aPurge: Boolean); static;

    class function  Active: Boolean; static;
    class procedure Pause; static;
    class procedure Resume; static;
    class procedure Reset; static;
  end;

implementation

uses
  System.IOUtils,
  GameVision.System,
  GameVision.Utils;


{ TAudio }
class function Audio.TimeAsSeconds(aValue: Single): TsfTime;
begin
  Result.MicroSeconds := Round(aValue * 1000000);
end;

//class function Audio.TimeAsMilliSeconds(aValue: Integer): TsfTime;
//begin
//  Result.MicroSeconds := Round(aValue * 1000);
//end;

class function Audio.GetMusicItem(var aMusicItem: TMusicItem; aMusic: Integer): Boolean;
begin
  // assume false
  Result := False;

  // check for valid music id
  if (aMusic < 0) or (aMusic > FMusicList.Count-1) then Exit;

  // get item
  aMusicItem := FMusicList.Items[aMusic];

  // check if valid
  if aMusicItem.MusicHandle = nil then
    Result := False
  else
    // return true
    Result := True;
end;

class function Audio.AddMusicItem(var aMusicItem: TMusicItem): Integer;
var
  LIndex: Integer;
  LItem: TMusicItem;
begin
  Result := -1;
  for LIndex := 0 to FMusicList.Count-1 do
  begin
    LItem := FMusicList.Items[LIndex];
    if LItem.MusicHandle = nil then
    begin
      FMusicList.Items[LIndex] := aMusicItem;
      Result := LIndex;
      Exit;
    end;
  end;

  if LItem.MusicHandle <> nil then
  begin
    Result := FMusicList.Add(aMusicItem);
  end;
end;

class function Audio.FindFreeBuffer(aFilename: string): Integer;
var
  LI: Integer;
begin
  Result := AUDIO_INVALID_INDEX;
  for LI := 0 to AUDIO_BUFFER_COUNT - 1 do
  begin
    if FBuffer[LI].Filename = aFilename then
    begin
      Exit;
    end;

    if FBuffer[LI].Buffer = nil then
    begin
      Result := LI;
      Break;
    end;
  end;
end;

class function Audio.FindFreeChannel: Integer;
var
  LI: Integer;
begin
  Result := AUDIO_INVALID_INDEX;
  for LI := 0 to AUDIO_CHANNEL_COUNT - 1 do
  begin
    if sfSound_getStatus(FChannel[LI].Sound) = sfStopped then
    begin
      if not FChannel[LI].Reserved then
      begin
        Result := LI;
        Break;
      end;
    end;
  end;
end;

class procedure Audio.Setup;
var
  LI: Integer;
begin
  if FOpened then Exit;

  FillChar(FBuffer, SizeOf(FBuffer), 0);
  FillChar(FChannel, SizeOf(FChannel), 0);
  FOpened := False;

  // init music list
  FMusicList := TList<TMusicItem>.Create;

  // init channels
  for LI := 0 to AUDIO_CHANNEL_COUNT - 1 do
  begin
    FChannel[LI].Sound := sfSound_create;
    FChannel[LI].Reserved := False;
    FChannel[LI].Priority := 0;
  end;

  // init buffers
  for LI := 0 to AUDIO_BUFFER_COUNT - 1 do
  begin
    FBuffer[LI].Buffer := nil;
  end;

  FOpened := True;

  Reset;

  Logger.Log('Initialized %s Subsystem', ['Audio']);
end;

class procedure Audio.Shutdown;
var
  LI: Integer;
begin
  if not FOpened then Exit;

  // shutdown music
  UnloadAllMusic;
  FreeAndNil(FMusicList);

  // shutdown channels
  for LI := 0 to AUDIO_CHANNEL_COUNT - 1 do
  begin
    if FChannel[LI].Sound <> nil then
    begin
      sfSound_destroy(FChannel[LI].Sound);
      FChannel[LI].Reserved := False;
      FChannel[LI].Priority := 0;
      FChannel[LI].Sound := nil;
    end;
  end;

  // shutdown buffers
  for LI := 0 to AUDIO_BUFFER_COUNT - 1 do
  begin
    if FBuffer[LI].Buffer <> nil then
    begin
      sfSoundBuffer_destroy(FBuffer[LI].Buffer);
      FBuffer[LI].Buffer := nil;
    end;
  end;

  FillChar(FBuffer, SizeOf(FBuffer), 0);
  FillChar(FChannel, SizeOf(FChannel), 0);
  FOpened := False;

  Logger.Log('Shutdown %s Subsystem', ['Audio']);
end;

class procedure Audio.Open;
begin
  Setup;
end;

class procedure Audio.Close;
begin
  Shutdown;
end;

class procedure Audio.Pause(aPause: Boolean);
var
  LI: Integer;
begin
  if not FOpened then Exit;

  PauseAllMusic(aPause);

  // pause channel
  for LI := 0 to AUDIO_CHANNEL_COUNT - 1 do
  begin
    PauseChannel(LI, aPause);
  end;
end;

class procedure Audio.Reset;
var
  LVec: TsfVector3f;
begin
  if not FOpened then Exit;

  sfListener_setGlobalVolume(100);

  LVec.X := 0; LVec.Y := 0; LVec.Z := 0;
  sfListener_setPosition(LVec);

  LVec.X := 0; LVec.Y := 0; LVec.Z := -1;
  sfListener_setDirection(LVec);

  LVec.X := 0; LVec.Y := 1; LVec.Z := 0;
  sfListener_setUpVector(LVec);
end;

//TODO: check of music is already loaded
class function Audio.LoadMusic(aFilename: string): Integer;
var
  LMarshaller: TMarshaller;
  LItem: TMusicItem;
begin
  Result := -1;

  if not FOpened then Exit;

  // init music item
  LItem.FileHandle := nil;
  LItem.MusicHandle := nil;
  LItem.Buffer := nil;
  LItem.Size := 0;

  // try to load from PhysicalFS
  if PHYSFS_isInit then
  begin
    //LItem.FileHandle := PHYSFS_openRead(LMarshaller.AsAnsi(aFilename).ToPointer);
    LItem.FileHandle := PHYSFS_openRead(Engine.GetArchiveItemFilename(aFilename));
    if LItem.FileHandle <> nil then
    begin
      LItem.Size := PHYSFS_fileLength(LItem.FileHandle);
      TBuffer(LItem.Buffer) := TBuffer.Create(LItem.Size);
      PHYSFS_readBytes(LItem.FileHandle, TBuffer(LItem.Buffer).Memory, LItem.Size);
      LItem.MusicHandle := sfMusic_createFromMemory(TBuffer(LItem.Buffer).Memory, LItem.Size);
      LItem.Filename := aFilename;
    end;
  end;

  // try to load from filesystem
  if LItem.FileHandle = nil then
  begin
    if not TFile.Exists(aFilename) then Exit;
    LItem.Size := GetFileSize(aFilename);
    LItem.MusicHandle := sfMusic_createFromFile(LMarshaller.AsAnsi(aFilename).ToPointer);
    if LItem.MusicHandle = nil then Exit;
    LItem.Buffer := nil;
  end;

  // add to list
  Result := AddMusicItem(LItem);

  Logger.Log('Sucessfully loaded music "%s"', [aFilename]);
end;

class procedure Audio.UnloadMusic(var aMusic: Integer);
var
  LItem: TMusicItem;
begin
  if not FOpened then Exit;

  // check for valid music id
  if not GetMusicItem(LItem, aMusic) then Exit;

  // stop music
  StopMusic(aMusic);

  // free music handle
  sfMusic_destroy(LItem.MusicHandle);

  // free music buffer
  if LItem.Buffer <> nil then
  begin
    FreeAndNil(LItem.Buffer);
  end;

  // close PhsycialFS handle
  if LItem.FileHandle <> nil then
  begin
    PHYSFS_close(LItem.FileHandle);
  end;

  // clear item data
  LItem.FileHandle := nil;
  LItem.MusicHandle := nil;
  LItem.Buffer := nil;
  LItem.Size := 0;
  FMusicList.Items[aMusic] := LItem;

  Logger.Log('Unloaded music "%s"', [LItem.Filename]);

  // return handle as invalid
  aMusic := -1;
end;

class procedure Audio.UnloadAllMusic;
var
  LIndex: Integer;
  LMusic: Integer;
begin
  if not FOpened then Exit;

  for LIndex := 0 to FMusicList.Count-1 do
  begin
    LMusic := LIndex;
    StopMusic(LMusic);
    UnloadMusic(LMusic);
  end;
end;

class procedure Audio.PlayMusic(aMusic: Integer);
var
  LItem: TMusicItem;
begin
  if not FOpened then Exit;

  // check for valid music id
  if not GetMusicItem(LItem, aMusic) then Exit;

  // play music
  sfMusic_play(LItem.MusicHandle);
end;

class procedure Audio.PlayMusic(aMusic: Integer; aVolume: Single; aLoop: Boolean);
begin
  if not FOpened then Exit;

  PlayMusic(aMusic);
  SetMusicVolume(aMusic, aVolume);
  SetMusicLoop(aMusic, aLoop);
end;

class procedure Audio.StopMusic(aMusic: Integer);
var
  LItem: TMusicItem;
begin
  if not FOpened then Exit;

  // check for valid music id
  if not GetMusicItem(LItem, aMusic) then Exit;

  // stop music playing
  sfMusic_stop(LItem.MusicHandle);
end;

class procedure Audio.PauseMusic(aMusic: Integer);
var
  LItem: TMusicItem;
begin
  if not FOpened then Exit;

  // check for valid music id
  if not GetMusicItem(LItem, aMusic) then Exit;

  // pause audio
  sfMusic_pause(LItem.MusicHandle);
end;

class procedure Audio.PauseAllMusic(aPause: Boolean);
var
  LItem: TMusicItem;
  LIndex: Integer;
begin
  if not FOpened then Exit;

  for LIndex := 0 to FMusicList.Count-1 do
  begin
    if GetMusicItem(LItem, LIndex) then
    begin
      if aPause then
        PauseMusic(LIndex)
      else
        PlayMusic(LIndex);
    end;
  end;
end;

class procedure Audio.SetMusicLoop(aMusic: Integer; aLoop: Boolean);
var
  LItem: TMusicItem;
begin
  if not FOpened then Exit;

  // check for valid music id
  if not GetMusicItem(LItem, aMusic) then Exit;

  // set music loop status
  sfMusic_setLoop(LItem.MusicHandle, Ord(aLoop));
end;

class function Audio.GetMusicLoop(aMusic: Integer): Boolean;
var
  LItem: TMusicItem;
begin
  Result := False;

  if not FOpened then Exit;

  // check for valid music id
  if not GetMusicItem(LItem, aMusic) then Exit;

  // get music loop status
  Result := Boolean(sfMusic_getLoop(LItem.MusicHandle));
end;

class procedure Audio.SetMusicVolume(aMusic: Integer; aVolume: Single);
var
  LVol: Single;
  LItem: TMusicItem;
begin
  if not FOpened then Exit;

  // check for valid music id
  if not GetMusicItem(LItem, aMusic) then Exit;

  // check volume range
  if aVolume < 0 then
    aVolume := 0
  else if aVolume > 1 then
    aVolume := 1;

  // unnormalize value
  LVol := aVolume * 100;

  // set music volume
  sfMusic_setVolume(LItem.MusicHandle, LVol);
end;

class function Audio.GetMusicVolume(aMusic: Integer): Single;
var
  LItem: TMusicItem;
begin
  Result := 0;
  if not FOpened then Exit;
  if not GetMusicItem(LItem, aMusic) then Exit;
  Result := sfMusic_getVolume(LItem.MusicHandle);
  Result := Result / 100;
end;

class function Audio.GetMusicStatus(aMusic: Integer): TAudioStatus;
var
  LItem: TMusicItem;
begin
  Result := asStopped;
  if not FOpened then Exit;
  if not GetMusicItem(LItem, aMusic) then Exit;
  Result := TAudioStatus(sfMusic_getStatus(LItem.MusicHandle));
end;

class procedure Audio.SetMusicOffset(aMusic: Integer; aSeconds: Single);
var
  LItem: TMusicItem;
begin
  if not FOpened then Exit;
  if not GetMusicItem(LItem, aMusic) then Exit;
  sfMusic_setPlayingOffset(LItem.MusicHandle, TimeAsSeconds(aSeconds));
end;

class procedure Audio.SetChannelReserved(aChannel: Integer; aReserve: Boolean);
begin
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then Exit;
  FChannel[aChannel].Reserved := aReserve;
end;

class function Audio.GetChannelReserved(aChannel: Integer): Boolean;
begin
  Result := False;
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then  Exit;
  Result := FChannel[aChannel].Reserved;
end;

class function Audio.LoadSound(aFilename: string): Integer;
var
  LI: Integer;
  LFileHandle: Pointer;
  LMarshaller: TMarshaller;
  LSize: Int64;
  LBuffer: TBuffer;
begin
  Result := AUDIO_INVALID_INDEX;

  if not FOpened then Exit;

  if aFilename.IsEmpty then Exit;

  LI := FindFreeBuffer(aFilename);
  if LI = AUDIO_INVALID_INDEX then Exit;

  LFileHandle := nil;

  // try to load from PhysicalFS
  if PHYSFS_isInit then
  begin
    LFileHandle := PHYSFS_openRead(Engine.GetArchiveItemFilename(aFilename));
    if LFileHandle <> nil then
    begin
      try
        LSize := PHYSFS_fileLength(LFileHandle);
        LBuffer := TBuffer.Create(LSize);
        try
          PHYSFS_readBytes(LFileHandle, LBuffer.Memory, LSize);
          FBuffer[LI].Buffer := sfSoundBuffer_createFromMemory(LBuffer.Memory, LSize);
        finally
          FreeAndNil(LBuffer);
        end;
      finally
        PHYSFS_close(LFileHandle);
      end;
    end;
  end;

  // try to load from filesystem
  if LFileHandle = nil then
  begin
    if not TFile.Exists(aFilename) then Exit;
    FBuffer[LI].Buffer := sfSoundBuffer_createFromFile(LMarshaller.AsAnsi(aFilename).ToPointer);
    if FBuffer[LI].Buffer = nil then Exit;
  end;

  FBuffer[LI].Filename := aFilename;
  Logger.Log('Sucessfully loaded sound "%s"', [aFilename]);

  Result := LI;
end;

class procedure Audio.UnloadSound(aSound: Integer);
var
  LBuff: PsfSoundBuffer;
  LSnd: PsfSound;
  LI: Integer;
begin
  if not FOpened then Exit;

  if (aSound < 0) or (aSound > AUDIO_BUFFER_COUNT - 1) then  Exit;
  LBuff := FBuffer[aSound].Buffer;
  if LBuff = nil then Exit;

  // stop all channels playing this buffer
  for LI := 0 to AUDIO_CHANNEL_COUNT - 1 do
  begin
    LSnd := FChannel[LI].Sound;
    if LSnd <> nil then
    begin
      if sfSound_getBuffer(LSnd) = LBuff then
      begin
        sfSound_stop(LSnd);
        sfSound_destroy(LSnd);
        FChannel[LI].Sound := nil;
        FChannel[LI].Reserved := False;
        FChannel[LI].Priority := 0;
      end;
    end;
  end;

  // destroy this buffer
  sfSoundBuffer_destroy(LBuff);
  Logger.Log('Unloaded sound "%s"', [FBuffer[aSound].Filename]);
  FBuffer[aSound].Buffer := nil;
  FBuffer[aSound].Filename := '';
end;

class function Audio.PlaySound(aChannel: Integer; aSound: Integer): Integer;
var
  LI: Integer;
  LVec: TsfVector3f;
begin
  Result := AUDIO_INVALID_INDEX;
  if not FOpened then Exit;

  // check if sound is in range
  if (aSound < 0) or (aSound > AUDIO_BUFFER_COUNT - 1) then Exit;

  // check if channel is in range
  LI := aChannel;
  if LI = AUDIO_DYNAMIC_CHANNEL then LI := FindFreeChannel
  else if (LI < 0) or (LI > AUDIO_CHANNEL_COUNT - 1) then Exit;

  // play sound
  sfSound_setBuffer(FChannel[LI].Sound, FBuffer[aSound].Buffer);
  sfSound_play(FChannel[LI].Sound);

  sfSound_setLoop(FChannel[LI].Sound, sfFalse);
  sfSound_setPitch(FChannel[LI].Sound, 1);
  sfSound_setVolume(FChannel[LI].Sound, 100);

  LVec.X := 0; LVec.Y := 0; LVec.Z := 0;
  sfSound_setPosition(FChannel[LI].Sound, LVec);

  sfSound_setRelativeToListener(FChannel[LI].Sound, sfFalse);
  sfSound_setMinDistance(FChannel[LI].Sound, 1);
  sfSound_setAttenuation(FChannel[LI].Sound, 0);

  Result := LI;
end;

class function Audio.PlaySound(aChannel: Integer; aSound: Integer; aVolume: Single; aLoop: Boolean): Integer;
begin
  Result := AUDIO_INVALID_INDEX;
  if not FOpened then Exit;

  Result := PlaySound(aChannel, aSound);
  SetChannelVolume(Result, aVolume);
  SetChannelLoop(Result, aLoop);
end;

class procedure Audio.PauseChannel(aChannel: Integer; aPause: Boolean);
var
  LStatus: TsfSoundStatus;
begin
  if not FOpened then Exit;

  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then Exit;

  LStatus := sfSound_getStatus(FChannel[aChannel].Sound);

  case aPause of
    False:
      begin
        if LStatus = sfPaused then
          sfSound_play(FChannel[aChannel].Sound);
      end;
    True:
      begin
        if LStatus = sfPlaying then
          sfSound_pause(FChannel[aChannel].Sound);
      end;
  end;
end;

class function Audio.GetChannelStatus(aChannel: Integer): TAudioStatus;
begin
  Result := asStopped;
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then Exit;
  Result := TAudioStatus(sfSound_getStatus(FChannel[aChannel].Sound));
end;

class procedure Audio.SetChannelVolume(aChannel: Integer; aVolume: Single);
var
  LV: Single;
begin
  if not FOpened then Exit;

  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then Exit;

  if aVolume < 0 then
    aVolume := 0
  else if aVolume > 1 then
    aVolume := 1;

  LV := aVolume * 100;
  sfSound_setVolume(FChannel[aChannel].Sound, LV);
end;

class function Audio.GetChannelVolume(aChannel: Integer): Single;
begin
  Result := 0;
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then Exit;
  Result := sfSound_getVolume(FChannel[aChannel].Sound);
  Result := Result / 100;
end;

class procedure Audio.SetChannelLoop(aChannel: Integer; aLoop: Boolean);
begin
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then Exit;
  sfSound_setLoop(FChannel[aChannel].Sound, Ord(aLoop));
end;

class function Audio.GetChannelLoop(aChannel: Integer): Boolean;
begin
  Result := False;
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then Exit;
  Result := Boolean(sfSound_getLoop(FChannel[aChannel].Sound));
end;

class procedure Audio.SetChannelPitch(aChannel: Integer; aPitch: Single);
begin
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then Exit;
  sfSound_setPitch(FChannel[aChannel].Sound, aPitch);
end;

class function Audio.GetChannelPitch(aChannel: Integer): Single;
begin
  Result := 0;
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then  Exit;
  Result := sfSound_getPitch(FChannel[aChannel].Sound);
end;

class procedure Audio.SetChannelPosition(aChannel: Integer; aX: Single; aY: Single);
var
  LV: TsfVector3f;
begin
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then Exit;
  LV.X := aX;
  LV.Y := 0;
  LV.Z := aY;
  sfSound_setPosition(FChannel[aChannel].Sound, LV);
end;

class procedure Audio.GetChannelPosition(aChannel: Integer; var aX: Single; var aY: Single);
var
  LV: TsfVector3f;
begin
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then Exit;
  LV := sfSound_getPosition(FChannel[aChannel].Sound);
  aX := LV.X;
  aY := LV.Z;
end;

class procedure Audio.SetChannelMinDistance(aChannel: Integer; aDistance: Single);
begin
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then Exit;
  if aDistance < 1 then  aDistance := 1;
  sfSound_setMinDistance(FChannel[aChannel].Sound, aDistance);
end;

class function Audio.GetChannelMinDistance(aChannel: Integer): Single;
begin
  Result := 0;
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then Exit;
  Result := sfSound_getMinDistance(FChannel[aChannel].Sound);
end;

class procedure Audio.SetChannelRelativeToListener(aChannel: Integer; aRelative: Boolean);
begin
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then Exit;
  sfSound_setRelativeToListener(FChannel[aChannel].Sound, Ord(aRelative));
end;

class function Audio.GetChannelRelativeToListener(aChannel: Integer): Boolean;
begin
  Result := False;
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then Exit;
  Result := Boolean(sfSound_isRelativeToListener(FChannel[aChannel].Sound));
end;

class procedure Audio.SetChannelAttenuation(aChannel: Integer; aAttenuation: Single);
begin
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then  Exit;
  sfSound_setAttenuation(FChannel[aChannel].Sound, aAttenuation);
end;

class function Audio.GetChannelAttenuation(aChannel: Integer): Single;
begin
  Result := 0;
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then Exit;
  Result := sfSound_getAttenuation(FChannel[aChannel].Sound);
end;

class procedure Audio.StopChannel(aChannel: Integer);
begin
  if not FOpened then Exit;
  if (aChannel < 0) or (aChannel > AUDIO_CHANNEL_COUNT - 1) then Exit;
  sfSound_stop(FChannel[aChannel].Sound);
end;

class procedure Audio.StopAllChannels;
var
  LI: Integer;
begin
  if not FOpened then Exit;
  for LI := 0 to AUDIO_CHANNEL_COUNT-1 do
  begin
    sfSound_stop(FChannel[LI].Sound);
  end;
end;

class procedure Audio.SetListenerGlobalVolume(aVolume: Single);
var
  LV: Single;
begin
  if not FOpened then Exit;
  LV := aVolume;
  if (LV < 0) then
    LV := 0
  else if (LV > 1) then
    LV := 1;

  LV := LV * 100;
  sfListener_setGlobalVolume(LV);
end;

class function Audio.GetListenerGlobalVolume: Single;
begin
  Result := 0;
  if not FOpened then Exit;
  Result := sfListener_getGlobalVolume;
  Result := Result / 100;
end;

class procedure Audio.SetListenerPosition(aX: Single; aY: Single);
var
  LV: TsfVector3f;
begin
  if not FOpened then Exit;
  LV.X := aX;
  LV.Y := 0;
  LV.Z := aY;
  sfListener_setPosition(LV);
end;

class procedure Audio.GetListenerPosition(var aX: Single; var aY: Single);
var
  LV: TsfVector3f;
begin
  if not FOpened then Exit;
  LV := sfListener_getPosition;
  aX := LV.X;
  aY := LV.Z;
end;

{ --- SPEECH ---------------------------------------------------------------- }
{  Speech }
class procedure Speech.OnWord(aSender: TObject; aStreamNumber: Integer; aStreamPosition: OleVariant; aCharacterPosition, aLength: Integer);
begin
  if FText.IsEmpty then Exit;
  FWord := FText.Substring(aCharacterPosition, aLength);
  Engine.OnSpeechWord(FWord, FText);
end;

//class procedure Speech.OnStartStream(aSender: TObject; aStreamNumber: Integer; aStreamPosition: OleVariant);
//begin
//end;

class procedure Speech.DoSpeak(aText: string; aFlags: Integer);
begin
  if FSpVoice = nil then Exit;
  if aText.IsEmpty then Exit;
  if FPaused then Resume;
  FSpVoice.Speak(aText, aFlags);
  FText := aText;
end;

class procedure Speech.EnumVoices;
var
  LI: Integer;
  LSOToken: ISpeechObjectToken;
  LSOTokens: ISpeechObjectTokens;
begin
  FVoiceList := TInterfaceList.Create;
  FVoiceDescList := TStringList.Create;
  LSOTokens := FSpVoice.GetVoices('', '');
  for LI := 0 to LSOTokens.Count - 1 do
  begin
    LSOToken := LSOTokens.Item(LI);
    FVoiceDescList.Add(LSOToken.GetDescription(0));
    FVoiceList.Add(LSOToken);
  end;
end;

class procedure Speech.FreeVoices;
begin
  FreeAndNil(FVoiceDescList);
  FreeAndNil(FVoiceList);
end;

class procedure Speech.Setup;
begin
  FPaused := False;
  FText := '';
  FWord := '';
  FSpVoice := TSpVoice.Create(nil);
  FSpVoice.EventInterests := SVEAllEvents;
  EnumVoices;
  //FSpVoice.OnStartStream := OnStartStream;
  FSpVoice.OnWord := OnWord;
  Logger.Log('Initialized %s Subsystem', ['Speech']);
end;

class procedure Speech.Shutdown;
begin
  FreeVoices;
  FSpVoice.OnWord := nil;
  FSpVoice.Free;

  Logger.Log('Shutdown %s Subsystem', ['Speech']);
end;

class function Speech.GetVoiceCount: Integer;
begin
  Result := FVoiceList.Count;
end;

class function Speech.GetVoiceAttribute(aIndex: Integer; aAttribute: TSpeechVoiceAttribute): string;
var
  LSOToken: ISpeechObjectToken;

  function GetAttr(aItem: string): string;
  begin
    if aItem = 'Id' then
      Result := LSOToken.Id
    else
      Result := LSOToken.GetAttribute(aItem);
  end;

begin
  Result := '';
  if (aIndex < 0) or (aIndex > FVoiceList.Count - 1) then
    Exit;
  LSOToken := ISpeechObjectToken(FVoiceList.Items[aIndex]);
  case aAttribute of
    vaDescription:
      Result := FVoiceDescList[aIndex];
    vaName:
      Result := GetAttr('Name');
    vaVendor:
      Result := GetAttr('Vendor');
    vaAge:
      Result := GetAttr('Age');
    vaGender:
      Result := GetAttr('Gender');
    vaLanguage:
      Result := GetAttr('Language');
    vaId:
      Result := GetAttr('Id');
  end;
end;

class procedure Speech.ChangeVoice(aIndex: Integer);
var
  LSOToken: ISpeechObjectToken;
begin
  if (aIndex < 0) or (aIndex > FVoiceList.Count - 1) then Exit;
  LSOToken := ISpeechObjectToken(FVoiceList.Items[aIndex]);
  FSpVoice.Voice := LSOToken;
end;

class procedure Speech.SetVolume(aVolume: Single);
var
  LVolume: Integer;
begin
  if aVolume < 0 then
    aVolume := 0
  else if aVolume > 1 then
    aVolume := 1;

  LVolume := Round(100.0 * aVolume);

  if FSpVoice = nil then
    Exit;
  FSpVoice.Volume := LVolume;
end;

class function Speech.GetVolume: Single;
begin
  Result := 0;
  if FSpVoice = nil then Exit;
  Result := FSpVoice.Volume / 100.0;
end;

class procedure Speech.SetRate(aRate: Single);
var
  LVolume: Integer;
begin
  if aRate < 0 then
    aRate := 0
  else if aRate > 1 then
    aRate := 1;

  LVolume := Round(20.0 * aRate) - 10;

  if LVolume < -10 then
    LVolume := -10
  else if LVolume > 10 then
    LVolume := 10;

  if FSpVoice = nil then
    Exit;
  FSpVoice.Rate := LVolume;
end;

class function Speech.GetRate: Single;
begin
  Result := 0;
  if FSpVoice = nil then Exit;
  Result := (FSpVoice.Rate + 10.0) / 20.0;
end;

class procedure Speech.Speak(aText: string; aPurge: Boolean);
var
  LFlag: Integer;
  LText: string;
begin
  LFlag := SVSFlagsAsync;
  LText := aText;
  if aPurge then
    LFlag := LFlag or SVSFPurgeBeforeSpeak;
  DoSpeak(LText, LFlag);
end;

class procedure Speech.SpeakXML(aText: string; aPurge: Boolean);
var
  LFlag: Integer;
  LText: string;
begin
  LFlag := SVSFlagsAsync or SVSFIsXML;
  if aPurge then
    LFlag := LFlag or SVSFPurgeBeforeSpeak;
  LText := aText;
  DoSpeak(aText, LFlag);
end;

class procedure Speech.Clear;
begin
  if FSpVoice = nil then Exit;
  if Active then
  begin
    FSpVoice.Skip('Sentence', MaxInt);
    Speak(' ', True);
  end;
  FText := '';
end;

class function Speech.Active: Boolean;
begin
  Result := False;
  if FSpVoice = nil then Exit;
  Result := Boolean(FSpVoice.Status.RunningState <> SRSEDone);
end;

class procedure Speech.Pause;
begin
  if FSpVoice = nil then Exit;
  FSpVoice.Pause;
  FPaused := True;
end;

class procedure Speech.Resume;
begin
  if FSpVoice = nil then Exit;
  FSpVoice.Resume;
  FPaused := False;
end;

class procedure Speech.Reset;
begin
  Clear;
  FreeAndNil(FSpVoice);
  FPaused := False;
  FText := '';
  FWord := '';
  FSpVoice := TSpVoice.Create(nil);
  FSpVoice.EventInterests := SVEAllEvents;
  EnumVoices;
  //FSpVoice.OnStartStream := OnStartStream;
  FSpVoice.OnWord := OnWord;
end;

initialization
begin
  Audio.FOpened := False;
end;

end.
