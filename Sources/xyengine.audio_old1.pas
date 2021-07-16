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

unit xyengine.audio;

{$I xyengine.defines.inc }

interface

uses
  System.SysUtils,
  System.Classes,
  xyengine.tlb.speechlib,
  xyengine.clib.allegro,
  xyengine.common;

{ --- AUDIO ----------------------------------------------------------------- }
const
  AUDIO_MAX_SAMPLES     = 16;
  AUDIO_MAX_STREAMS     = 16;
  AUDIO_INVALID         = -1;
  AUDIO_DYNAMIC         = -2;
  AUDIO_PAN_NONE        = ALLEGRO_AUDIO_PAN_NONE;

type
  { Audio }
  Audio = record
    private
    class var
      FSample: array[ 0 .. AUDIO_MAX_SAMPLES-1] of PALLEGRO_SAMPLE;
      FChannel: array[ 0 .. ALLEGRO_MAX_CHANNELS-1] of ALLEGRO_SAMPLE_ID;
      FStream: array[ 0 .. AUDIO_MAX_STREAMS-1] of PALLEGRO_AUDIO_STREAM;
    var
      class function GetFreeSample: Integer; static;
      class function GetFreeChannel: Integer; static;
      class function GetFreeStream: Integer; static;
      class function ValidStreamId(aId: Integer): Boolean; static;
      class function ValidSampleId(aId: Integer): Boolean; static;
      class function ValidChannelId(aId: Integer): Boolean; static;
    public
      class procedure Setup; static;
      class procedure Shutdown; static;

      class function LoadSample(aFilename: string): Integer; static;
      class function UnloadSample(var aSample: Integer): Boolean; static;
      class function UnloadAllSamples: Boolean; static;
      class function PlaySample(aSample: Integer; aChannel: Integer; aVolume: Single; aPan: Single; aSpeed: Single; aLoop: Boolean): Integer; static;
      class function StopSample(aChannel: Integer): Boolean; static;
      class procedure StopAllSamples; static;
      class function SamplePlaying(aChannel: Integer): Boolean; static;

      class function LoadStream(aFilename: string): Integer; static;
      class function UnloadStream(var aStream: Integer): Boolean; static;
      class function UnloadAllStreams: Boolean; static;
      class function PlayStream(aStream: Integer; aVolume: Single; aLoop: Boolean): Boolean; static;
      class function StopStream(aStream: Integer): Boolean; static;
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
  xyengine.system;

{ --- AUDIO ----------------------------------------------------------------- }
  { Audio }
class function Audio.GetFreeSample: Integer;
begin
  Result := AUDIO_INVALID;
  for var I: Integer := 0 to AUDIO_MAX_SAMPLES-1 do
  begin
    if FSample[I] = nil then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

class function Audio.GetFreeChannel: Integer;
begin
  Result := AUDIO_INVALID;
  for var I: Integer := 0 to ALLEGRO_MAX_CHANNELS-1 do
  begin
    if not SamplePlaying(I) then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

class function Audio.GetFreeStream: Integer;
begin
  Result := AUDIO_INVALID;
  for var I: Integer := 0 to AUDIO_MAX_STREAMS-1 do
  begin
    if FStream[I] = nil then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

class function Audio.ValidStreamId(aId: Integer): Boolean;
begin
  Result := False;
  if (aId < 0) then exit;
  if (aId > AUDIO_MAX_STREAMS-1) then exit;
  if FStream[aId] = nil then Exit;
  Result := True;
end;

class function Audio.ValidSampleId(aId: Integer): Boolean;
begin
  Result := False;
  if (aId < 0) then exit;
  if (aId > AUDIO_MAX_SAMPLES-1) then exit;
  if FSample[aId] = nil then Exit;
  Result := True;
end;

class function Audio.ValidChannelId(aId: Integer): Boolean;
begin
  Result := False;
  if (aId < 0) then exit;
  if (aId > ALLEGRO_MAX_CHANNELS-1) then exit;
  if (FChannel[aId]._index = -1) and (FChannel[aId]._id = -1) then Exit;
  Result := True;
end;

class procedure Audio.Setup;
begin
  FillChar(FSample, SizeOf(FSample), 0);
  FillChar(FChannel, SizeOf(FChannel), -1);
  FillChar(FStream, SizeOf(FStream), 0);
  Logger.Log('Initialized %s Subsystem', ['Audio']);
end;

class procedure Audio.Shutdown;
begin
  UnloadAllSamples;
  UnloadAllStreams;
  FillChar(FSample, SizeOf(FSample), 0);
  FillChar(FChannel, SizeOf(FChannel), -1);
  FillChar(FStream, SizeOf(FStream), 0);
  Logger.Log('Shutdown %s Subsystem', ['Audio']);
end;

class function Audio.LoadSample(aFilename: string): Integer;
var
  LIndex: Integer;
begin
  Result := AUDIO_INVALID;
  if aFilename.IsEmpty then Exit;
  LIndex := GetFreeSample;
  if LIndex = AUDIO_INVALID then Exit;
  FSample[LIndex] := al_load_sample(Engine.GetArchiveItemFilename(aFilename));
  if FSample[Lindex] <> nil then
  begin
    Result := LIndex;
  end;
end;

class function Audio.UnloadSample(var aSample: Integer): Boolean;
begin
  Result := False;
  if not ValidSampleId(aSample) then Exit;
  al_destroy_sample(FSAmple[aSample]);
  FSample[aSample] := nil;
  aSample := AUDIO_INVALID;
  Result := True;
end;

class function Audio.UnloadAllSamples: Boolean;
var
  I: Integer;
  LSample: Integer;
begin
  Result := True;
  for I := 0 to AUDIO_MAX_SAMPLES-1 do
  begin
    LSample := I;
    if not UnloadSample(LSample) then
      Result := False;
  end;
end;

class function Audio.PlaySample(aSample: Integer; aChannel: Integer; aVolume: Single; aPan: Single; aSpeed: Single; aLoop: Boolean): Integer;
var
  LMode: ALLEGRO_PLAYMODE;
  LIndex: Integer;
begin
  Result := AUDIO_INVALID;
  if not ValidSampleId(aSample) then Exit;

  if aChannel = AUDIO_DYNAMIC then
    begin
      LIndex := GetFreeChannel;
      if LIndex = AUDIO_INVALID then Exit;
    end
  else
    begin
      if ValidChannelId(aChannel) then
        StopSample(aChannel);
      LIndex := aChannel;
    end;

  if aLoop then
    LMode := ALLEGRO_PLAYMODE_LOOP
  else
    LMode := ALLEGRO_PLAYMODE_ONCE;

  if al_play_sample(FSample[aSample], aVolume, aPan, aSpeed, LMode, @FChannel[LIndex]) then
  begin
    Result := LIndex;
  end;
end;

class function Audio.StopSample(aChannel: Integer): Boolean;
begin
  Result := False;
  if not ValidChannelId(aChannel) then Exit;
  if SamplePlaying(aChannel) then
    al_stop_sample(@FChannel[aChannel]);
end;

class procedure Audio.StopAllSamples;
var
  I: Integer;
begin
  for I := 0 to ALLEGRO_MAX_CHANNELS-1 do
  begin
    StopSample(I);
  end;
end;

class function Audio.SamplePlaying(aChannel: Integer): Boolean;
var
  LInstance: PALLEGRO_SAMPLE_INSTANCE;
begin
  Result := False;
  if not ValidChannelId(aChannel) then Exit;
  LInstance := al_lock_sample_id(@FChannel[aChannel]);
  if LInstance <> nil then
  begin
    Result := al_get_sample_instance_playing(LInstance);
    al_unlock_sample_id(@FChannel[aChannel]);
  end;
end;

class function Audio.LoadStream(aFilename: string): Integer;
begin
  Result := AUDIO_INVALID;
  if aFilename.IsEmpty then Exit;
  var LIndex: Integer := Audio.GetFreeStream;
  if LIndex = AUDIO_INVALID then Exit;

  FStream[LIndex] := al_load_audio_stream(Engine.GetArchiveItemFilename(aFilename), 4, 2048);
  if FStream[LIndex] <> nil then
  begin
    if al_set_audio_stream_playmode(FStream[LIndex], ALLEGRO_PLAYMODE_ONCE) then
    begin
      if al_attach_audio_stream_to_mixer(FStream[LIndex], Engine.Mixer) then
      begin
        if al_set_audio_stream_playing(FStream[LIndex], False) then
        begin
          Result := LIndex;
        end;
      end;
    end;
  end;
end;

class function Audio.UnloadStream(var aStream: Integer): Boolean;
begin
  Result := False;
  if not Audio.ValidStreamId(aStream) then Exit;
  if FStream[aStream] <> nil then
  begin
    if al_set_audio_stream_playing(FStream[aStream], False) then
    begin
      al_drain_audio_stream(FStream[aStream]);
      if al_detach_audio_stream(FStream[aStream]) then
      begin
        al_destroy_audio_stream(FStream[aStream]);
        FStream[aStream] := nil;
        aStream := AUDIO_INVALID;
        Result := True;
      end;
    end;
  end;
end;

class function Audio.UnloadAllStreams: Boolean;
begin
  Result := True;
  for var I: Integer := 0 to AUDIO_MAX_STREAMS do
  begin
    var LId: Integer := I;
    if not UnloadStream(LId) then
      Result := False;
  end;
end;

class function Audio.PlayStream(aStream: Integer; aVolume: Single; aLoop: Boolean): Boolean;
begin
  Result := False;
  if not Audio.ValidStreamId(aStream) then Exit;
  if not StopStream(aStream) then Exit;

  var LMode: ALLEGRO_PLAYMODE;
  if aLoop then LMode := ALLEGRO_PLAYMODE_LOOP else LMode := ALLEGRO_PLAYMODE_ONCE;
  if al_set_audio_stream_playmode(FStream[aStream], LMode) then
  begin
    if al_set_audio_stream_gain(FStream[aStream], aVolume) then
    begin
      if al_rewind_audio_stream(FStream[aStream]) then
      begin
        if al_set_audio_stream_playing(FStream[aStream], True) then
        begin
          Result := True;
        end;
      end;
    end;
  end;
end;

class function Audio.StopStream(aStream: Integer): Boolean;
begin
  Result := False;
  if not Audio.ValidStreamId(aStream) then Exit;
  if al_set_audio_stream_playing(FStream[aStream], False) then
  begin
    if al_rewind_audio_stream(FStream[aStream]) then
    begin
      Result := True;
    end;
  end;
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

end.
