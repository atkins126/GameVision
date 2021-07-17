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

unit GameVision.Game;

{$I GameVision.Defines.inc }

interface

uses
  System.Classes,
  System.Contnrs,
  GameVision.Common,
  GameVision.System,
  GameVision.Graphics;

{ --- ACTOR ----------------------------------------------------------------- }
type
  // Class Forwards
  TActorList = class;
  TAIStateMachine = class;

  { TActorAttributeSet }
  TActorAttributeSet = set of Byte;

  { TActorMessage }
  PActorMessage = ^TActorMessage;
  TActorMessage = record
    Id: Integer;
    Data: Pointer;
    DataSize: Cardinal;
  end;

  { TActor }
  TActor = class
  protected
    FOwner: TActor;
    FPrev: TActor;
    FNext: TActor;
    FAttributes: TActorAttributeSet;
    FTerminated: Boolean;
    FActorList: TActorList;
    FCanCollide: Boolean;
    FChildren: TActorList;
    function GetAttribute(aIndex: Byte): Boolean;
    procedure SetAttribute(aIndex: Byte; aValue: Boolean);
    function GetAttributes: TActorAttributeSet;
    procedure SetAttributes(aValue: TActorAttributeSet);
  public
    property Owner: TActor read FOwner write FOwner;
    property Prev: TActor read FPrev write FPrev;
    property Next: TActor read FNext write FNext;
    property Attribute[aIndex: Byte]: Boolean read GetAttribute write SetAttribute;
    property Attributes: TActorAttributeSet read GetAttributes  write SetAttributes;
    property Terminated: Boolean read FTerminated write FTerminated;
    property Children: TActorList read FChildren write FChildren;
    property ActorList: TActorList read FActorList write FActorList;
    property CanCollide: Boolean read FCanCollide write FCanCollide;
    procedure OnVisit(aSender: TActor; aEventId: Integer; var aDone: Boolean); virtual;
    procedure OnUpdate(aDeltaTime: Double); virtual;
    procedure OnRender; virtual;
    function OnMessage(aMsg: PActorMessage): TActor; virtual;
    procedure OnCollide(aActor: TActor; aHitPos: TVector); virtual;
    constructor Create; virtual;
    destructor Destroy; override;
    function AttributesAreSet(aAttrs: TActorAttributeSet): Boolean;
    function Collide(aActor: TActor; var aHitPos: TVector): Boolean; virtual;
    function Overlap(aX, aY, aRadius, aShrinkFactor: Single): Boolean; overload; virtual;
    function Overlap(aActor: TActor): Boolean; overload; virtual;
  end;

  { TActorList }
  TActorList = class
  protected
    FHead: TActor;
    FTail: TActor;
    FCount: Integer;
  public
    property Count: Integer read FCount;
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Clean;
    procedure Add(aActor: TActor);
    procedure Remove(aActor: TActor; aDispose: Boolean);
    procedure Clear(aAttrs: TActorAttributeSet);
    procedure ForEach(aSender: TActor; aAttrs: TActorAttributeSet; aEventId: Integer; var aDone: Boolean);
    procedure Update(aAttrs: TActorAttributeSet; aDeltaTime: Double);
    procedure Render(aAttrs: TActorAttributeSet);
    function SendMessage(aAttrs: TActorAttributeSet; aMsg: PActorMessage; aBroadcast: Boolean): TActor;
    procedure CheckCollision(aAttrs: TActorAttributeSet; aActor: TActor);
  end;

  { TAIState }
  TAIState = class
  protected
    FOwner: TObject;
    FChildren: TActorList;
    FStateMachine: TAIStateMachine;
  public
    property Owner: TObject read FOwner write FOwner;
    property Children: TActorList read FChildren;
    property StateMachine: TAIStateMachine read FStateMachine write FStateMachine;
    constructor Create; virtual;
    destructor Destroy; override;
    procedure OnEnter; virtual;
    procedure OnExit; virtual;
    procedure OnUpdate(aDeltaTime: Double); virtual;
    procedure OnRender; virtual;
  end;

  { TAIStateMachine }
  TAIStateMachine = class
  protected
    FOwner: TActor;
    FCurrentState: TAIState;
    FGlobalState: TAIState;
    FPreviousState: TAIState;
    FStateList: System.Contnrs.TObjectList;
    FStateIndex: Integer;
    procedure ChangeStateObj(aValue: TAIState);
    procedure SetCurrentStateObj(aValue: TAIState);
    procedure RemoveStateObj(aState: TAIState);
    procedure SetGlobalStateObj(aValue: TAIState);
    procedure SetPreviousStateObj(aValue: TAIState);
    function GetStateCount: Integer;
    function GetStateIndex: Integer;
    function GetStates(aIndex: Integer): TAIState;
    function GetCurrentState: Integer;
    procedure SetCurrentState(aIndex: Integer);
    function GetGlobalState: Integer;
    procedure SetGlobalState(aIndex: Integer);
    function GetPreviousState: Integer;
    procedure SetPreviousState(aIndex: Integer);
  public
    property Owner: TActor read FOwner write FOwner;
    property StateCount: Integer read GetStateCount;
    property StateIndex: Integer read GetStateIndex;
    property States[aIndex: Integer]: TAIState read GetStates;
    property CurrentState: Integer read GetCurrentState write SetCurrentState;
    property GlobalState: Integer read GetGlobalState write SetGlobalState;
    property PreviousState: Integer read GetPreviousState write SetPreviousState;
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Update(aDeltaTime: Double);
    procedure Render;
    procedure RevertToPreviousState;
    procedure ClearStates;
    function AddState(aState: TAIState): Integer;
    procedure RemoveState(aIndex: Integer);
    procedure ChangeState(aIndex: Integer);
    function PrevState(aWrap: Boolean): Integer;
    function NextState(aWrap: Boolean): Integer;
  end;

  { TAIActor }
  TAIActor = class(TActor)
  protected
    FStateMachine: TAIStateMachine;
  public
    property StateMachine: TAIStateMachine read FStateMachine write FStateMachine;
    constructor Create; override;
    destructor Destroy; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnRender; override;
  end;

  { TActorSceneEvent }
  TActorSceneEvent = procedure(aSceneNum: Integer) of object;

  { TActorScene }
  TActorScene = class
  protected
    FLists: array of TActorList;
    FCount: Integer;
    function GetList(aIndex: Integer): TActorList;
    function GetCount: Integer;
  public
    property Lists[aIndex: Integer]: TActorList read GetList; default;
    property Count: Integer read GetCount;
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Alloc(aNum: Integer);
    procedure Dealloc;
    procedure Clean(aIndex: Integer);
    procedure Clear(aIndex: Integer; aAttrs: TActorAttributeSet);
    procedure ClearAll;
    procedure Update(aAttrs: TActorAttributeSet; aDeltaTime: Double);
    procedure Render(aAttrs: TActorAttributeSet; aBefore: TActorSceneEvent; aAfter: TActorSceneEvent);
    function SendMessage(aAttrs: TActorAttributeSet; aMsg: PActorMessage; aBroadcast: Boolean): TActor;
  end;

  { TEntityActor }
  TEntityActor = class(TActor)
  protected
    FEntity: TEntity;
  public
    property Entity: TEntity read FEntity write FEntity;
    constructor Create; override;
    destructor Destroy; override;
    procedure Init(aSprite: TSprite; aGroup: Integer); virtual;
    function Collide(aActor: TActor; var aHitPos: TVector): Boolean; override;
    function Overlap(aX, aY, aRadius, aShrinkFactor: Single): Boolean; override;
    function Overlap(aActor: TActor): Boolean; override;
    procedure OnRender; override;
  end;

  { TAIEntityActor }
  TAIEntityActor = class(TEntityActor)
  protected
    FStateMachine: TAIStateMachine;
  public
    property StateMachine: TAIStateMachine read FStateMachine;
    constructor Create; override;
    destructor Destroy; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnRender; override;
  end;

{ --- CUSTOMGAMEAPP --------------------------------------------------------- }
type
  { TGameConfig }
  TGameConfig = record
    ConfigFilename: string;
    ArchiveFilename: string;
    DisplayWidth: Integer;
    DisplayHeight: Integer;
    DisplayFullscreen: Boolean;
    DisplayTitle: string;
    DisplayClearColor: TColor;
    SceneCount: Integer;
    SceneRenderAttr: TActorAttributeSet;
    SceneUpdateAttr: TActorAttributeSet;
    ProgrammablePipeLine: Boolean;
  end;

  { TCustomGameApp }
  TCustomGameApp = class(TCustomGame)
  protected
    FConfigFile: TConfigFile;
    FFont: TFont;
    FScene: TActorScene;
    FSprite: TSprite;
  public
    Config: TGameConfig;
    HudPos: TVector;
    MousePos: TVector;

    property ConfigFile: TConfigFile read FConfigFile;
    property Font: TFont read FFont;
    property Scene: TActorScene read FScene;
    property Sprite: TSprite read FSprite;

    constructor Create; override;
    destructor Destroy; override;
    procedure OnSetConfig(var aConfig: TGameConfig); virtual;
    procedure Run; override;
    procedure OnLoad; override;
    procedure OnExit; override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnDisplayClear; override;
    procedure OnRender; override;
    procedure OnRenderHUD; override;
    procedure OnDisplayShow; override;
    procedure OnUpdate(aDeltaTime: Double); override;
    procedure OnBeforeRenderScene(aSceneNum: Integer); virtual;
    procedure OnAfterRenderScene(aSceneNum: Integer); virtual;
  end;

implementation

uses
  System.Types,
  System.SysUtils,
  System.IOUtils,
  GameVision.Utils,
  GameVision.UI,
  GameVision.Input;

{ --- ACTOR ----------------------------------------------------------------- }
{ TActor }
function TActor.GetAttribute(aIndex: Byte): Boolean;
begin
  Result := Boolean(aIndex in FAttributes);
end;

procedure TActor.SetAttribute(aIndex: Byte; aValue: Boolean);
begin
  if aValue then
    Include(FAttributes, aIndex)
  else
    Exclude(FAttributes, aIndex);
end;

function TActor.GetAttributes: TActorAttributeSet;
begin
  Result := FAttributes;
end;

procedure TActor.SetAttributes(aValue: TActorAttributeSet);
begin
  FAttributes := aValue;
end;

procedure TActor.OnVisit(aSender: TActor; aEventId: Integer; var aDone: Boolean);
begin
  aDone := False;
end;

procedure TActor.OnUpdate(aDeltaTime: Double);
begin
  // update all children by default
  FChildren.Update([], aDeltaTime);
end;

procedure TActor.OnRender;
begin
  // render all children by default
  FChildren.Render([]);
end;

function TActor.OnMessage(aMsg: PActorMessage): TActor;
begin
  Result := nil;
end;

procedure TActor.OnCollide(aActor: TActor; aHitPos: TVector);
begin
end;

constructor TActor.Create;
begin
  inherited;

  FOwner := nil;
  FPrev := nil;
  FNext := nil;
  FAttributes := [];
  FTerminated := False;
  FActorList := nil;
  FCanCollide := False;
  FChildren := TActorList.Create;
end;

destructor TActor.Destroy;
begin
  FreeAndNil(FChildren);

  inherited;
end;

function TActor.AttributesAreSet(aAttrs: TActorAttributeSet): Boolean;
var
  LA: Byte;
begin
  Result := False;
  for LA in aAttrs do
  begin
    if LA in FAttributes then
    begin
      Result := True;
      Break;
    end;
  end;
end;

function TActor.Collide(aActor: TActor; var aHitPos: TVector): Boolean;
begin
  Result := False;
end;

function TActor.Overlap(aX, aY, aRadius, aShrinkFactor: Single): Boolean;
begin
  Result := False;
end;

function TActor.Overlap(aActor: TActor): Boolean;
begin
  Result := False;
end;


{ TAIState }
constructor TAIState.Create;
begin
  inherited;

  FStateMachine := nil;
  FOwner := nil;
  FChildren := TActorList.Create;
end;

destructor TAIState.Destroy;
begin
  FreeAndNil(FChildren);

  inherited;
end;

procedure TAIState.OnEnter;
begin
end;

procedure TAIState.OnExit;
begin
end;

procedure TAIState.OnUpdate(aDeltaTime: Double);
begin
  // update all children by default
  FChildren.Update([], aDeltaTime);
end;

procedure TAIState.OnRender;
begin
  // render all children by default
  FChildren.Render([]);
end;


{ TGVAIStateMachine }
procedure TAIStateMachine.ChangeStateObj(aValue: TAIState);
begin
  if not Assigned(aValue) then  Exit;

  FPreviousState := FCurrentState;

  if Assigned(FCurrentState) then
    FCurrentState.OnExit;

  FCurrentState := aValue;
  FCurrentState.Owner := FOwner;

  FCurrentState.OnEnter;
end;

procedure TAIStateMachine.SetCurrentStateObj(aValue: TAIState);
begin
  FCurrentState := aValue;
  FCurrentState.Owner := FOwner;
  if Assigned(FCurrentState) then
  begin
    FCurrentState.OnEnter;
  end;
end;

procedure TAIStateMachine.RemoveStateObj(aState: TAIState);
begin
  FStateList.Remove(aState);
  if FStateList.Count < 1 then
    FStateIndex := -1
  else
    FStateIndex := 0;
end;

procedure TAIStateMachine.SetGlobalStateObj(aValue: TAIState);
begin
  FGlobalState := aValue;
  FGlobalState.Owner := FOwner;
  if Assigned(FGlobalState) then
  begin
    FGlobalState.OnEnter;
  end;
end;

procedure TAIStateMachine.SetPreviousStateObj(aValue: TAIState);
begin
  FPreviousState := aValue;
  FPreviousState.Owner := FOwner;
end;

function TAIStateMachine.GetStateCount: Integer;
begin
  Result := FStateList.Count;
end;

function TAIStateMachine.GetStateIndex: Integer;
begin
  Result := FStateIndex;
end;

function TAIStateMachine.GetStates(aIndex: Integer): TAIState;
begin
  Result := nil;
  if (aIndex < 0) or (aIndex > FStateList.Count - 1) then Exit;
  Result := TAIState(FStateList.Items[aIndex]);
end;

function TAIStateMachine.GetCurrentState: Integer;
begin
  Result := FStateList.IndexOf(FCurrentState);
end;

procedure TAIStateMachine.SetCurrentState(aIndex: Integer);
var
  LObj: TAIState;
begin
  LObj := GetStates(aIndex);
  if Assigned(LObj) then
  begin
    SetCurrentStateObj(LObj);
    FStateIndex := aIndex;
  end;
end;

function TAIStateMachine.GetGlobalState: Integer;
begin
  Result := FStateList.IndexOf(FGlobalState);
end;

procedure TAIStateMachine.SetGlobalState(aIndex: Integer);
var
  LObj: TAIState;
begin
  LObj := GetStates(aIndex);
  if Assigned(LObj) then
  begin
    SetGlobalStateObj(LObj);
  end;
end;

function TAIStateMachine.GetPreviousState: Integer;
begin
  Result := FStateList.IndexOf(FPreviousState);
end;

procedure TAIStateMachine.SetPreviousState(aIndex: Integer);
var
  LObj: TAIState;
begin
  LObj := GetStates(aIndex);
  if Assigned(LObj) then
  begin
    SetPreviousStateObj(LObj);
  end;
end;

constructor TAIStateMachine.Create;
begin
  inherited;

  FOwner := nil;
  FCurrentState := nil;
  FGlobalState := nil;
  FPreviousState := nil;
  FStateList := FStateList.Create(True);
  FStateIndex := -1;
end;

destructor TAIStateMachine.Destroy;
begin
  FreeAndNil(FStateList);

  inherited;
end;

procedure TAIStateMachine.Update(aDeltaTime: Double);
begin
  if Assigned(FGlobalState) then
    FGlobalState.OnUpdate(aDeltaTime);
  if Assigned(FCurrentState) then
    FCurrentState.OnUpdate(aDeltaTime);
end;

procedure TAIStateMachine.Render;
begin
  if Assigned(FGlobalState) then
    FGlobalState.OnRender;
  if Assigned(FCurrentState) then
    FCurrentState.OnRender;
end;

procedure TAIStateMachine.RevertToPreviousState;
begin
  ChangeStateObj(FPreviousState);
end;

procedure TAIStateMachine.ClearStates;
begin
  FStateList.Clear;
  FStateIndex := -1;
end;

function TAIStateMachine.AddState(aState: TAIState): Integer;
begin
  Result := -1;
  if FStateList.IndexOf(aState) = -1 then
  begin
    Result := FStateList.Add(aState);
    if GetStateCount <= 1 then
    begin
      SetCurrentState(Result);
    end;
    aState.StateMachine := self;
  end;
end;

procedure TAIStateMachine.RemoveState(aIndex: Integer);
var
  obj: TAIState;
begin
  if (aIndex < 0) or (aIndex > FStateList.Count - 1) then
    Exit;
  obj := TAIState(FStateList.Items[aIndex]);
  RemoveStateObj(obj);
end;

procedure TAIStateMachine.ChangeState(aIndex: Integer);
var
  obj: TAIState;
begin
  obj := GetStates(aIndex);
  if Assigned(obj) then
  begin
    ChangeStateObj(obj);
    FStateIndex := aIndex;
  end;
end;

function TAIStateMachine.PrevState(aWrap: Boolean): Integer;
var
  I: Integer;
begin
  Result := -1;
  if FStateList.Count < 2 then
    Exit;

  I := FStateIndex;
  Dec(I);
  if I < 0 then
  begin
    if not aWrap then
      Exit;
    I := FStateList.Count - 1;
  end;
  ChangeState(I);
end;

function TAIStateMachine.NextState(aWrap: Boolean): Integer;
var
  LI: Integer;
begin
  Result := -1;
  if FStateList.Count < 2 then
    Exit;

  LI := FStateIndex;
  Inc(LI);
  if LI > FStateList.Count - 1 then
  begin
    if not aWrap then
      Exit;
    LI := 0;
  end;
  ChangeState(LI);
end;


{ TAIActor }
constructor TAIActor.Create;
begin
  inherited;

  FStateMachine := TAIStateMachine.Create;
  FStateMachine.Owner := self;
end;

destructor TAIActor.Destroy;
begin
  FreeAndNil(FStateMachine);

  inherited;
end;

procedure TAIActor.OnUpdate(aDeltaTime: Double);
begin
  // process states
  FStateMachine.Update(aDeltaTime);
end;

procedure TAIActor.OnRender;
begin
  // render state
  FStateMachine.Render;
end;


{ TActorList }
constructor TActorList.Create;
begin
  inherited;

  FHead := nil;
  FTail := nil;
  FCount := 0;
end;

destructor TActorList.Destroy;
begin
  Clear([]);

  inherited;
end;

procedure TActorList.Add(aActor: TActor);
begin
  if not Assigned(aActor) then Exit;

  aActor.Prev := FTail;
  aActor.Next := nil;

  if FHead = nil then
  begin
    FHead := aActor;
    FTail := aActor;
  end
  else
  begin
    FTail.Next := aActor;
    FTail := aActor;
  end;

  Inc(FCount);
end;

procedure TActorList.Remove(aActor: TActor; aDispose: Boolean);
var
  LFlag: Boolean;
begin
  if not Assigned(aActor) then Exit;

  LFlag := False;

  if aActor.Next <> nil then
  begin
    aActor.Next.Prev := aActor.Prev;
    LFlag := True;
  end;

  if aActor.Prev <> nil then
  begin
    aActor.Prev.Next := aActor.Next;
    LFlag := True;
  end;

  if FTail = aActor then
  begin
    FTail := FTail.Prev;
    LFlag := True;
  end;

  if FHead = aActor then
  begin
    FHead := FHead.Next;
    LFlag := True;
  end;

  if LFlag = True then
  begin
    Dec(FCount);
    if aDispose then
    begin
      aActor.Free;
    end;
  end;
end;

procedure TActorList.Clear(aAttrs: TActorAttributeSet);
var
  LP: TActor;
  LN: TActor;
  LNoAttrs: Boolean;
begin
  // get pointer to head
  LP := FHead;

  // exit if list is empty
  if LP = nil then Exit;

  // check if we should check for attrs
  LNoAttrs := Boolean(aAttrs = []);

  repeat
    // save pointer to next object
    LN := LP.Next;

    if LNoAttrs then
    begin
      Remove(LP, True);
    end
    else
    begin
      if LP.AttributesAreSet(aAttrs) then
      begin
        Remove(LP, True);
      end;
    end;

    // get pointer to next object
    LP := LN;

  until LP = nil;
end;

procedure TActorList.Clean;
var
  LP: TActor;
  LN: TActor;
begin
  // get pointer to head
  LP := FHead;

  // exit if list is empty
  if LP = nil then
    Exit;

  repeat
    // save pointer to next object
    LN := LP.Next;

    if LP.Terminated then
    begin
      Remove(LP, True);
    end;

    // get pointer to next object
    LP := LN;

  until LP = nil;
end;

procedure TActorList.ForEach(aSender: TActor; aAttrs: TActorAttributeSet; aEventId: Integer; var aDone: Boolean);
var
  LP: TActor;
  LN: TActor;
  LNoAttrs: Boolean;
begin
  // get pointer to head
  LP := FHead;

  // exit if list is empty
  if LP = nil then
    Exit;

  // check if we should check for attrs
  LNoAttrs := Boolean(aAttrs = []);

  repeat
    // save pointer to next actor
    LN := LP.Next;

    // destroy actor if not terminated
    if not LP.Terminated then
    begin
      // no attributes specified so update this actor
      if LNoAttrs then
      begin
        aDone := False;
        LP.OnVisit(aSender, aEventId, aDone);
        if aDone then
        begin
          Exit;
        end;
      end
      else
      begin
        // update this actor if it has specified attribute
        if LP.AttributesAreSet(aAttrs) then
        begin
          aDone := False;
          LP.OnVisit(aSender, aEventId, aDone);
          if aDone then
          begin
            Exit;
          end;
        end;
      end;
    end;

    // get pointer to next actor
    LP := LN;

  until LP = nil;
end;

procedure TActorList.Update(aAttrs: TActorAttributeSet; aDeltaTime: Double);
var
  LP: TActor;
  LN: TActor;
  LNoAttrs: Boolean;
begin
  // get pointer to head
  LP := FHead;

  // exit if list is empty
  if LP = nil then  Exit;

  // check if we should check for attrs
  LNoAttrs := Boolean(aAttrs = []);

  repeat
    // save pointer to next actor
    LN := LP.Next;

    // destroy actor if not terminated
    if not LP.Terminated then
    begin
      // no attributes specified so update this actor
      if LNoAttrs then
      begin
        // call actor's OnUpdate method
        LP.OnUpdate(aDeltaTime);
      end
      else
      begin
        // update this actor if it has specified attribute
        if LP.AttributesAreSet(aAttrs) then
        begin
          // call actor's OnUpdate method
          LP.OnUpdate(aDeltaTime);
        end;
      end;
    end;

    // get pointer to next actor
    LP := LN;

  until LP = nil;

  // perform garbage collection
  Clean;
end;

procedure TActorList.Render(aAttrs: TActorAttributeSet);
var
  LP: TActor;
  LN: TActor;
  LNoAttrs: Boolean;
begin
  // get pointer to head
  LP := FHead;

  // exit if list is empty
  if LP = nil then Exit;

  // check if we should check for attrs
  LNoAttrs := Boolean(aAttrs = []);

  repeat
    // save pointer to next actor
    LN := LP.Next;

    // destroy actor if not terminated
    if not LP.Terminated then
    begin
      // no attributes specified so update this actor
      if LNoAttrs then
      begin
        // call actor's OnRender method
        LP.OnRender;
      end
      else
      begin
        // update this actor if it has specified attribute
        if LP.AttributesAreSet(aAttrs) then
        begin
          // call actor's OnRender method
          LP.OnRender;
        end;
      end;
    end;

    // get pointer to next actor
    LP := LN;

  until LP = nil;
end;

function TActorList.SendMessage(aAttrs: TActorAttributeSet; aMsg: PActorMessage; aBroadcast: Boolean): TActor;
var
  LP: TActor;
  LN: TActor;
  LNoAttrs: Boolean;
begin
  Result := nil;

  // get pointer to head
  LP := FHead;

  // exit if list is empty
  if LP = nil then Exit;

  // check if we should check for attrs
  LNoAttrs := Boolean(aAttrs = []);

  repeat
    // save pointer to next actor
    LN := LP.Next;

    // destroy actor if not terminated
    if not LP.Terminated then
    begin
      // no attributes specified so update this actor
      if LNoAttrs then
      begin
        // send message to object
        Result := LP.OnMessage(aMsg);
        if not aBroadcast then
        begin
          if Result <> nil then
          begin
            Exit;
          end;
        end;
      end
      else
      begin
        // update this actor if it has specified attribute
        if LP.AttributesAreSet(aAttrs) then
        begin
          // send message to object
          Result := LP.OnMessage(aMsg);
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
    LP := LN;

  until LP = nil;
end;

procedure TActorList.CheckCollision(aAttrs: TActorAttributeSet; aActor: TActor);
var
  LP: TActor;
  LN: TActor;
  LNoAttrs: Boolean;
  LHitPos: TVector;
begin
  // check if terminated
  if aActor.Terminated then Exit;

  // check if can collide
  if not aActor.CanCollide then Exit;

  // get pointer to head
  LP := FHead;

  // exit if list is empty
  if LP = nil then Exit;

  // check if we should check for attrs
  LNoAttrs := Boolean(aAttrs = []);

  repeat
    // save pointer to next actor
    LN := LP.Next;

    // destroy actor if not terminated
    if not LP.Terminated then
    begin
      // no attributes specified so check collision with this actor
      if LNoAttrs then
      begin

        if LP.CanCollide then
        begin
          // HitPos.Clear;
          LHitPos.X := 0;
          LHitPos.Y := 0;
          if aActor.Collide(LP, LHitPos) then
          begin
            LP.OnCollide(aActor, LHitPos);
            aActor.OnCollide(LP, LHitPos);
            // Exit;
          end;
        end;

      end
      else
      begin
        // check collision with this actor if it has specified attribute
        if LP.AttributesAreSet(aAttrs) then
        begin
          if LP.CanCollide then
          begin
            // HitPos.Clear;
            LHitPos.X := 0;
            LHitPos.Y := 0;
            if aActor.Collide(LP, LHitPos) then
            begin
              LP.OnCollide(aActor, LHitPos);
              aActor.OnCollide(LP, LHitPos);
              // Exit;
            end;
          end;

        end;
      end;
    end;

    // get pointer to next actor
    LP := LN;

  until LP = nil;
end;


{ TActorScene }
function TActorScene.GetList(aIndex: Integer): TActorList;
begin
  Result := FLists[aIndex];
end;

function TActorScene.GetCount: Integer;
begin
  Result := FCount;
end;

constructor TActorScene.Create;
begin
  inherited;

  FLists := nil;
  FCount := 0;
end;

destructor TActorScene.Destroy;
begin
  Dealloc;

  inherited;
end;

procedure TActorScene.Alloc(aNum: Integer);
var
  LI: Integer;
begin
  Dealloc;
  FCount := aNum;
  SetLength(FLists, FCount);
  for LI := 0 to FCount - 1 do
  begin
    FLists[LI] := TActorList.Create;
  end;
end;

procedure TActorScene.Dealloc;
var
  LI: Integer;
begin
  ClearAll;
  for LI := 0 to FCount - 1 do
  begin
    FLists[LI].Free;
  end;
  FLists := nil;
  FCount := 0;
end;

procedure TActorScene.Clean(aIndex: Integer);
begin
  if (aIndex < 0) or (aIndex > FCount - 1) then Exit;
  FLists[aIndex].Clean;
end;

procedure TActorScene.Clear(aIndex: Integer; aAttrs: TActorAttributeSet);
begin
  if (aIndex < 0) or (aIndex > FCount - 1) then Exit;
  FLists[aIndex].Clear(aAttrs);
end;

procedure TActorScene.ClearAll;
var
  LI: Integer;
begin
  for LI := 0 to FCount - 1 do
  begin
    FLists[LI].Clear([]);
  end;
end;

procedure TActorScene.Update(aAttrs: TActorAttributeSet; aDeltaTime: Double);
var
  LI: Integer;
begin
  for LI := 0 to FCount - 1 do
  begin
    FLists[LI].Update(aAttrs, aDeltaTime);
  end;
end;

procedure TActorScene.Render(aAttrs: TActorAttributeSet; aBefore: TActorSceneEvent; aAfter: TActorSceneEvent);
var
  LI: Integer;
begin
  for LI := 0 to FCount - 1 do
  begin
    if Assigned(aBefore) then aBefore(LI);
    FLists[LI].Render(aAttrs);
    if Assigned(aAfter) then aAfter(LI);
  end;
end;

function TActorScene.SendMessage(aAttrs: TActorAttributeSet; aMsg: PActorMessage; aBroadcast: Boolean): TActor;
var
  LI: Integer;
begin
  Result := nil;
  for LI := 0 to FCount - 1 do
  begin
    Result := FLists[LI].SendMessage(aAttrs, aMsg, aBroadcast);
    if not aBroadcast then
    begin
      if Result <> nil then
      begin
        Exit;
      end;
    end;
  end;
end;


{ TEntityActor }
constructor TEntityActor.Create;
begin
  inherited;

  FEntity := nil;
end;

destructor TEntityActor.Destroy;
begin
  FreeAndNil(FEntity);

  inherited;
end;

procedure TEntityActor.Init(aSprite: TSprite; aGroup: Integer);
begin
  FEntity := TEntity.Create;
  FEntity.Init(aSprite, aGroup);
end;

function TEntityActor.Collide(aActor: TActor; var aHitPos: TVector): Boolean;
begin
  Result := False;
  if FEntity = nil then Exit;
  if aActor is TEntityActor then
  begin
    Result := FEntity.CollidePolyPoint(TEntityActor(aActor).Entity, aHitPos);
  end
end;

function TEntityActor.Overlap(aX, aY, aRadius, aShrinkFactor: Single): Boolean;
begin
  Result := FAlse;
  if FEntity = nil then Exit;
  Result := FEntity.Overlap(aX, aY, aRadius, aShrinkFactor);
end;

function TEntityActor.Overlap(aActor: TActor): Boolean;
begin
  Result := False;
  if FEntity = nil then Exit;
  if aActor is TEntityActor then
  begin
    Result := FEntity.Overlap(TEntityActor(aActor).Entity);
  end;
end;

procedure TEntityActor.OnRender;
begin
  if FEntity = nil then Exit;
  FEntity.Render(0, 0);
end;


{ TAIEntityActor }
constructor TAIEntityActor.Create;
begin
  inherited;

  FStateMachine := TAIStateMachine.Create;
end;

destructor TAIEntityActor.Destroy;
begin
  FreeAndNil(FStateMachine);

  inherited;
end;

procedure TAIEntityActor.OnUpdate(aDeltaTime: Double);
begin
  // process states
  FStateMachine.Update(aDeltaTime);
end;

procedure TAIEntityActor.OnRender;
begin
  // render state
  FStateMachine.Render;
end;

{ --- CUSTOMGAMEAPP --------------------------------------------------------- }

{ TCustomGameApp }
constructor TCustomGameApp.Create;
begin
  inherited;
end;

destructor TCustomGameApp.Destroy;
begin
  inherited;
end;

procedure TCustomGameApp.OnSetConfig(var aConfig: TGameConfig);
begin
end;

procedure TCustomGameApp.Run;
begin
  HudPos.Clear;
  HudPos.Assign(3, 3, 0);

  Config.ConfigFilename := TPath.ChangeExtension(ParamStr(0), cCfgExt);
  Config.ArchiveFilename := TPath.ChangeExtension(ParamStr(0), cArcExt);
  Config.DisplayWidth := 800;
  Config.DisplayHeight := 500;
  Config.DisplayFullscreen := False;
  Config.DisplayTitle := 'CustomGameApp';
  Config.DisplayClearColor.Make(22, 27, 34, 255);
  Config.SceneCount := 1;
  Config.SceneRenderAttr := [];
  Config.SceneUpdateAttr := [];
  Config.ProgrammablePipeLine := False;
  OnSetConfig(Config);

  inherited;
end;

procedure TCustomGameApp.OnLoad;
begin
  inherited;

  // open configfile
  FConfigFile := TConfigFile.Create;
  FConfigfile.Open(Config.ConfigFilename);

  // mount achive if exists
  Engine.OpenArchive(Config.ArchiveFilename);
end;

procedure TCustomGameApp.OnExit;
begin
  // unmount archive if exist
  Engine.CloseArchive;

  // close configfile
  FreeAndNil(FConfigFile);

  inherited;
end;

procedure TCustomGameApp.OnStartup;
begin
  inherited;

  // open display
  Display.Open(Config.DisplayWidth, Config.DisplayHeight, Config.DisplayFullscreen, Config.DisplayTitle, Config.ProgrammablePipeLine);

  // init font
  FFont := TFont.Create;
  FFont.Load(20);

  // init sprite
  FSprite := TSprite.Create;

  // init scene
  FScene := TActorScene.Create;
  FScene.Alloc(Config.SceneCount);
end;

procedure TCustomGameApp.OnShutdown;
begin
  // free scene
  FreeAndNil(FScene);

  // free sprite
  FreeAndNil(FSprite);

  // free font
  FreeAndNil(FFont);

  // close display
  Display.Close;

  inherited;
end;

procedure TCustomGameApp.OnDisplayClear;
begin
  // clear display
  Display.Clear(Config.DisplayClearColor);
end;

procedure TCustomGameApp.OnRender;
begin
  inherited;

  FScene.Render(Config.SceneRenderAttr, OnBeforeRenderScene, OnAfterRenderScene);
end;

procedure TCustomGameApp.OnRenderHUD;
begin
  inherited;

  HudPos.Assign(3, 3, 0);
  FFont.Print(HudPos.X, HudPos.Y, HudPos.Z, WHITE, haLeft, 'fps %d', [Engine.GetFrameRate]);
end;

procedure TCustomGameApp.OnDisplayShow;
begin
  inherited;

  // show display
  Display.Show;
end;

procedure TCustomGameApp.OnUpdate(aDeltaTime: Double);
begin
  inherited;

  // get mouse info
  Input.MouseGetInfo(MousePos);

  // update scene
  FScene.Update(Config.SceneUpdateAttr, aDeltaTime);
end;

procedure TCustomGameApp.OnBeforeRenderScene(aSceneNum: Integer);
begin
end;

procedure TCustomGameApp.OnAfterRenderScene(aSceneNum: Integer);
begin
end;

end.
