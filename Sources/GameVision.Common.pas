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

unit GameVision.Common;

{$I GameVision.Defines.inc }

interface

uses
  System.SysUtils;

const

  {$IF CompilerVersion >= 35} // Meeds Delphi 11 or higher required
    {$IF Defined(WIN64)}
    cDllName = 'allegro_monolith-5.2.dll';
    _PU = '';
    {$ELSE}
      {$MESSAGE Error 'Unsupported platform'}
    {$ENDIF}
  {$ELSE}
    {$MESSAGE Error 'Unsupported Delphi version'}
  {$IFEND}

  // Version information
  GAMEVISION_MAJOR_VERSION  = '0';
  GAMEVISION_MINOR_VERSION  = '1';
  GAMEVISION_PATCH_VERSION  = '0';
  GAMEVISION_VERSION        = GAMEVISION_MAJOR_VERSION + '.' + GAMEVISION_MINOR_VERSION + '.' + GAMEVISION_PATCH_VERSION;
  GAMEVISION_DESCRIPTION    = 'GameVision Toolkit™';
  GAMEVISION_LEGALCOPYRIGHT = 'Copyright © 2020-21 tinyBigGAMES™ LLC';
  GAMEVISION_LEGALTRADEMARK = 'All rights reserved.';
  GAMEVISION_WEBISTE        = 'https://tinybiggames.com';
  GAMEVISION_EMAIL          = 'support@tinybiggames.com';

  // Custom events
  EVENT_CMDCON_ACTIVE   = 10000;
  EVENT_CMDCON_INACTIVE = 10001;

  { TreeMenu }
  TREEMENU_NONE         = -1;
  TREEMENU_QUIT         = -2;

  // Common Object Attributes
  cAudioObjectAttr    = 0;
  cGraphicsObjectAttr = 1;
  cInputObjectAttr    = 2;
  cNetworkObjectAttr  = 3;
  cSystemObjectAttr   = 4;
  cGameObjectAttr     = 5;

  // Common extensions
  cLogExt = 'log';
  cArcExt = 'arc';
  cPngExt = 'png';
  cCfgExt = 'cfg';

type
  { TStringArray }
  TStringArray = array of string;

  { THAlign }
  THAlign = (haLeft, haCenter, haRight);

  { TVAlign }
  TVAlign = (vaTop, vaCenter, vaBottom);

  { TStartupDialogState }
  TStartupDialogState = (sdsMore = 0, sdsRun = 1, sdsQuit = 2);

  // Class Forwards
  TObjectList = class;

  { TObjectAttributeSet }
  TObjectAttributeSet = set of Byte;

  { TObjectMessage }
  PObjectMessage = ^TObjectMessage;
  TObjectMessage = record
    Id: Integer;
    Data: Pointer;
    DataSize: Cardinal;
  end;

  { TBaseObject }
  TBaseObject = class
  protected
    FOwner: TBaseObject;
    FPrev: TBaseObject;
    FNext: TBaseObject;
    FAttributes: TObjectAttributeSet;
    FTerminated: Boolean;
    FObjectList: TObjectList;
    FChildren: TObjectList;

    function  GetAttribute(aIndex: Byte): Boolean;
    procedure SetAttribute(aIndex: Byte; aValue: Boolean);

    function  GetAttributes: TObjectAttributeSet;
    procedure SetAttributes(aValue: TObjectAttributeSet);
  public
    property Owner: TBaseObject read FOwner write FOwner;
    property Prev: TBaseObject read FPrev write FPrev;
    property Next: TBaseObject read FNext write FNext;
    property Attribute[aIndex: Byte]: Boolean read GetAttribute write SetAttribute;
    property Attributes: TObjectAttributeSet read GetAttributes  write SetAttributes;
    property Terminated: Boolean read FTerminated write FTerminated;
    property Children: TObjectList read FChildren;
    property ObjectList: TObjectList read FObjectList;

    procedure OnVisit(aSender: TBaseObject; aEventId: Integer; var aDone: Boolean); virtual;
    function  OnMessage(aMsg: PObjectMessage): TBaseObject; virtual;
    procedure OnBeforeAdd; virtual;
    procedure OnAfterAdd; virtual;
    procedure OnBeforeRemove; virtual;
    procedure OnAfterRemove; virtual;

    constructor Create; virtual;
    destructor Destroy; override;

    function  AttributesAreSet(aAttrs: TObjectAttributeSet): Boolean;
  end;

  { TObjectList }
  TObjectList = class
  protected
    FHead: TBaseObject;
    FTail: TBaseObject;
    FCount: Integer;
  public
    property Count: Integer read FCount;

    constructor Create; virtual;
    destructor Destroy; override;

    procedure Clean;
    procedure Clear(aAttrs: TObjectAttributeSet);

    function Add(aObject: TBaseObject): Boolean;
    procedure Remove(aObject: TBaseObject; aDispose: Boolean);

    procedure ForEach(aSender: TBaseObject; aAttrs: TObjectAttributeSet; aEventId: Integer; var aDone: Boolean);
    function  SendMessage(aAttrs: TObjectAttributeSet; aMsg: PObjectMessage; aBroadcast: Boolean): TBaseObject;
  end;

var
  gObjectList: TObjectList = nil;

implementation

{ TBaseObject }
function TBaseObject.GetAttribute(aIndex: Byte): Boolean;
begin
  Result := Boolean(aIndex in FAttributes);
end;

procedure TBaseObject.SetAttribute(aIndex: Byte; aValue: Boolean);
begin
  if aValue then
    Include(FAttributes, aIndex)
  else
    Exclude(FAttributes, aIndex);
end;

function TBaseObject.GetAttributes: TObjectAttributeSet;
begin
  Result := FAttributes;
end;

procedure TBaseObject.SetAttributes(aValue: TObjectAttributeSet);
begin
  FAttributes := aValue;
end;

procedure TBaseObject.OnVisit(aSender: TBaseObject; aEventId: Integer; var aDone: Boolean);
begin
  aDone := False;
end;

function TBaseObject.OnMessage(aMsg: PObjectMessage): TBaseObject;
begin
  Result := nil;
end;

procedure TBaseObject.OnBeforeAdd;
begin
end;

procedure TBaseObject.OnAfterAdd;
begin
end;

procedure TBaseObject.OnBeforeRemove;
begin
end;

procedure TBaseObject.OnAfterRemove;
begin
end;

constructor TBaseObject.Create;
begin
  inherited;

  FOwner := nil;
  FPrev := nil;
  FNext := nil;
  FAttributes := [];
  FTerminated := False;
  FObjectList := nil;
  FChildren := TObjectList.Create;

  gObjectList.Add(Self)
end;

destructor TBaseObject.Destroy;
begin
  gObjectList.Remove(Self, False);

  FreeAndNil(FChildren);

  inherited;
end;

function TBaseObject.AttributesAreSet(aAttrs: TObjectAttributeSet): Boolean;
var
  LAttr: Byte;
begin
  Result := False;
  for LAttr in aAttrs do
  begin
    if LAttr in FAttributes then
    begin
      Result := True;
      Break;
    end;
  end;
end;


{ TObjectList }
constructor TObjectList.Create;
begin
  inherited;

  FHead := nil;
  FTail := nil;
  FCount := 0;
end;

destructor TObjectList.Destroy;
begin
  Clear([]);

  inherited;
end;

function TObjectList.Add(aObject: TBaseObject): Boolean;
begin
  Result := False;
  if not Assigned(aObject) then Exit;

  // check of objects references this list
  if aObject.FObjectList = Self then Exit;

  aObject.OnBeforeAdd;

  // remove from another assigned list
  if Assigned(aObject.FObjectList) then
  begin
    aObject.FObjectList.Remove(aObject, False);
  end;

  aObject.Prev := FTail;
  aObject.Next := nil;

  if FHead = nil then begin
    FHead := aObject;
    FTail := aObject;
  end else begin
    FTail.Next := aObject;
    FTail := aObject;
  end;

  aObject.FObjectList := Self;

  Inc(FCount);

  aObject.OnAfterAdd;

  Result := True;
end;

procedure TObjectList.Remove(aObject: TBaseObject; aDispose: Boolean);
var
  LFlag: Boolean;
begin
  if not Assigned(aObject) then Exit;

  // check of objects references this list
  if aObject.FObjectList <> Self then Exit;

  aObject.OnBeforeRemove;

  LFlag := False;

  if aObject.Next <> nil then
  begin
    aObject.Next.Prev := aObject.Prev;
    LFlag := True;
  end;

  if aObject.Prev <> nil then
  begin
    aObject.Prev.Next := aObject.Next;
    LFlag := True;
  end;

  if FTail = aObject then
  begin
    FTail := FTail.Prev;
    LFlag := True;
  end;

  if FHead = aObject then
  begin
    FHead := FHead.Next;
    LFlag := True;
  end;

  if LFlag = True then
  begin
    Dec(FCount);
    aObject.FObjectList := nil;
    aObject.OnAfterRemove;
    if aDispose then
    begin
      aObject.Free;
    end;
  end;
end;

procedure TObjectList.Clear(aAttrs: TObjectAttributeSet);
var
  LHead: TBaseObject;
  LNext: TBaseObject;
  LNoAttrs: Boolean;
begin
  // get pointer to head
  LHead := FHead;

  // exit if list is empty
  if LHead = nil then Exit;

  // check if we should check for attrs
  LNoAttrs := Boolean(aAttrs = []);

  repeat
    // save pointer to next object
    LNext := LHead.Next;

    if LNoAttrs then begin
      Remove(LHead, True);
    end else begin
      if LHead.AttributesAreSet(aAttrs) then
      begin
        Remove(LHead, True);
      end;
    end;

    // get pointer to next object
    LHead := LNext;

  until LHead = nil;
end;

procedure TObjectList.Clean;
var
  LHead: TBaseObject;
  LNext: TBaseObject;
begin
  // get pointer to head
  LHead := FHead;

  // exit if list is empty
  if LHead = nil then
    Exit;

  repeat
    // save pointer to next object
    LNext := LHead.Next;

    if LHead.Terminated then
    begin
      Remove(LHead, True);
    end;

    // get pointer to next object
    LHead := LNext;

  until LHead = nil;
end;

procedure TObjectList.ForEach(aSender: TBaseObject; aAttrs: TObjectAttributeSet; aEventId: Integer; var aDone: Boolean);
var
  LHead: TBaseObject;
  LNext: TBaseObject;
  LNoAttrs: Boolean;
begin
  // get pointer to head
  LHead := FHead;

  // exit if list is empty
  if LHead = nil then Exit;

  // check if we should check for attrs
  LNoAttrs := Boolean(aAttrs = []);

  repeat
    // save pointer to next actor
    LNext := LHead.Next;

    // destroy actor if not terminated
    if not LHead.Terminated then
    begin
      // no attributes specified so update this actor
      if LNoAttrs then begin
        aDone := False;
        LHead.OnVisit(aSender, aEventId, aDone);
        if aDone then
        begin
          Exit;
        end;
      end else begin
        // update this actor if it has specified attribute
        if LHead.AttributesAreSet(aAttrs) then
        begin
          aDone := False;
          LHead.OnVisit(aSender, aEventId, aDone);
          if aDone then
          begin
            Exit;
          end;
        end;
      end;
    end;

    // get pointer to next actor
    LHead := LNext;

  until LHead = nil;
end;

function TObjectList.SendMessage(aAttrs: TObjectAttributeSet; aMsg: PObjectMessage; aBroadcast: Boolean): TBaseObject;
var
  LHead: TBaseObject;
  LNext: TBaseObject;
  LNoAttrs: Boolean;
begin
  Result := nil;

  // get pointer to head
  LHead := FHead;

  // exit if list is empty
  if LHead = nil then Exit;

  // check if we should check for attrs
  LNoAttrs := Boolean(aAttrs = []);

  repeat
    // save pointer to next actor
    LNext := LHead.Next;

    // destroy actor if not terminated
    if not LHead.Terminated then
    begin
      // no attributes specified so update this actor
      if LNoAttrs then begin
        // send message to object
        Result := LHead.OnMessage(aMsg);
        if not aBroadcast then
        begin
          if Result <> nil then
          begin
            Exit;
          end;
        end;
      end else begin
        // update this actor if it has specified attribute
        if LHead.AttributesAreSet(aAttrs) then
        begin
          // send message to object
          Result := LHead.OnMessage(aMsg);
          if not aBroadcast then
          begin
            if Result <> nil then
            begin
              Exit;
            end;
          end;
        end;
      end;
    end;

    // get pointer to next actor
    LHead := LNext;

  until LHead = nil;
end;


initialization
begin
  gObjectList := TObjectList.Create;
end;

finalization
begin
  FreeAndNil(gObjectList);
end;

end.
