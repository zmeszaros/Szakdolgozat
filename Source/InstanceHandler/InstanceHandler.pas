//****************************************************************************//
//                                                                            //
//  InstanceHandler unit                                                      //
//                                                                            //
//  Public domain, see InstanceHandler.rtf for licence                        //
//                                                                            //
//  Usage: see InstanceHandler.rtf                                            //
//                                                                            //
//  Akácz Károly (jackson@vnet.hu)                                            //
//  Kovács Attila Zoltán (kaz@freemail.hu)                                    //
//                                                                            //
//  History:                                                                  //
//                                                                            //
//  2002.09.05 - First public release                                         //
//                                                                            //
//****************************************************************************//
unit InstanceHandler;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms;

type
  TInstanceActivateStatus =  // like C++ :)
  (
    iasSuccess,              // Sikeres végrehajtás
    iasInvalidHWND,          // Érvénytelen ablakleíró
    iasCannotRestore,        // Ikonállapotú program ablakának visszaállítása nem sikerült
    iasCannotActivateMain,   // Fõablak aktiválása sikertelen
    iasCannotActivatePopup   // Popup ablak aktiválása sikertelen
  );

  IInstanceInfo = interface(IUnknown)
    function AppHWnd: HWND;                             // A TApplication ablak azonosítója
    function MainHWnd: HWND;                            // A fõform azonosítója
    function StartTime: TDateTime;                      // A program (IH) indításának dátuma/ideje
    function ActivateAppWnd: TInstanceActivateStatus;   // Aktiválja a programot
    function ActivateMainWnd: TInstanceActivateStatus;  // Aktiválja a programot
  end;

  IInstancesInfo = interface(IUnknown)
    function GetCount: integer;
    function GetInstanceInfo(i: integer): IInstanceInfo;
    procedure SortByStartTime;
    property Count: integer read GetCount;
    property Items[i: integer]: IInstanceInfo read GetInstanceInfo; default;
  end;


const
  // Kompatibilitási okokból megmaradt konstansok
  INST_SUCCESS                   = iasSuccess;
  INST_ERR_INVALID_HANDLE        = iasInvalidHWND;
  INST_ERR_CANNOT_RESTORE        = iasCannotRestore;
  INST_ERR_CANNOT_ACTIVATE       = iasCannotActivateMain;
  INST_ERR_CANNOT_ACTIVATE_POPUP = iasCannotActivatePopup;


function ActivateInstance(hWnd: HWND): TInstanceActivateStatus;  // Programpéldány aktívvá tétele
function GetInstancesInfo: IInstancesInfo;
function GetInstanceCount: integer;
function GetStartTime: TDateTime;

implementation

const
  // Az Application objektum ablakosztálya
  AppWndClass = 'TApplication';

type
  // Programpéldány azonosításakor a megosztott memóriaterületen
  // elhelyezett információ a következõ struktúrával rendelkezik.
  // A memóriaterület handle-jét az üzenetkezelõ függvény wParam paraméterében kapjuk meg
  // IH_GETINSTANCEINFO üzenet esetén
  PInstanceID = ^TInstanceID;
  TInstanceID = record
    IDSize: Cardinal;  // A futó programpéldány mérete
    IDSum: Cardinal;   // A futó programpéldány tartalmáról készített ellenõrzõ összeg
    IDCRC: Longint;    // A futó programpéldány tartalmáról készített CRC
  end;

  // Ha IH_GETINSTANCEINFO üzenetet kapunk, akkor a két programpéldány azonosítóinak
  // egyezése esetén a megosztott memóriaterületen az üzenetet kezelõ
  // példány az információt a következõ rekord szerint helyezi el.
  // A memóriaterület handle-jét az üzenetkezelõ függvény wParam paraméterében kapjuk meg.
  PInstanceInfo = ^TInstanceInfo;
  TInstanceInfo = record
    AppHWnd: HWnd;         // A TApplication ablak azonosítója
    MainHWnd: HWnd;        // A fõform azonosítója
    StartTime: TDateTime;  // A program (IH) indításának dátuma/ideje
  end;

var
  IHGetInstanceInfo: UINT = 0; // A regisztrált üzenet azonosítója
  IIDSize: Cardinal       = 0; // A futó programpéldány mérete
  IIDSum: Cardinal        = 0; // A futó programpéldány tartalmáról készített ellenõrzõ összeg
  IIDCRC: Longint         = 0; // A futó programpéldány tartalmáról készített CRC
  StartTime: TDateTime;        // Az InstanceHandler inicializációjának dátuma/ideje
  OldHandler: LongInt;         // A TApplication eredeti üzenetkezelõjének offsetcíme
  ThisHWnd: HWND;              // A TApplication ablak azonosítója

function MsgHandler(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  PIID: PInstanceID;
  PII: PInstanceInfo;
begin
  // Ha IH_GETINSTANCEINFO üzenetet kapunk, akkor a wParam által azonosított
  // memóriaterületen megkapjuk a küldõ alkalmazás azonosító adatait
  // TInstanceID rekord szerint.
  if Msg = IHGetInstanceInfo then begin
    if BOOL(wParam) and BOOL(lParam) then
      Result := LRESULT(True)
    else begin
      Result := LRESULT(False);
      try
        PIID := PInstanceID(MapViewOfFile(wParam, FILE_MAP_READ + FILE_MAP_WRITE, 0, 0, 0));
        if Assigned(PIID) then begin
          try
            // Ha az ellenörzõ összegek megegyeznek, akkor azonosnak tekinthetõ a két fájl
            // Ha csak az egyik is különbözik, a két program különbözõ.
            if (PIID^.IDSize = IIDSize) and (PIID^.IDSum = IIDSum) and (PIID^.IDCRC = IIDCRC) then begin
              // Ha a két példány azonos, elhelyezzük az információt az adatcsere-területen
              // TInstanceInfo rekordban
              PII := pointer(PIID);
              PII^.AppHWnd := Application.Handle;
              if Assigned(Application.MainForm) and Application.MainForm.HandleAllocated then
                PII^.MainHWnd := Application.MainForm.Handle
              else
                PII^.MainHWnd := 0;
              PII^.StartTime := StartTime;
              Result := LRESULT(True);
            end;
          finally
            UnmapViewOfFile(PIID);
          end;
        end;
      finally
        CloseHandle(wParam);
      end;
    end;
  end
  else
    // Az általunk nem kezelt üzeneteket átadjuk az eredeti üzenetkezelõnek.
    Result := CallWindowProc(Pointer(OldHandler), Application.Handle, Msg, wParam, lParam);
end;

// A futó példányok információt "tartalmazó" TList objektum tartalmának törlése
procedure ClearList(InstanceList: TList); // A futó példányok információira mutató pointerek listája
var
  PII: PInstanceInfo;
  i: integer;
begin
  for i := 0 to InstanceList.Count - 1 do begin
    PII := InstanceList[i];
    Dispose(PII);
  end;
  InstanceList.Clear;
end;

// A Windows ezt a függvényt meghívja minden ablakra, miután meghívtuk
// az EnumWindows függvényt (elsõ paramétere erre a fv-re mutat)
function EnumWProc(hWnd: HWND; lParam: LPARAM): BOOL; stdcall;
var
  WClassName: string;
begin
  // Mindaddig meghívatjuk a függvényt a Windows-szal, amíg csak van ablak
  Result := True;

  // Lekérdezzük a hWnd leírójú ablak osztályát
  SetLength(WClassName, 100);
  GetClassName(hWnd, PChar(WClassName), 100);

  // Ha az osztály neve TApplication, és
  // az nem az aktuális programpéldány ablaka,
  if (StrIComp(AppWndClass, PChar(WClassName)) = 0) and (hWnd <> ThisHWnd) then
    TList(lParam).Add(pointer(hWnd));
end;

// Futó programpéldányok információinak lekérdezése
procedure GetInstancesInfoList(List: TList);
  function IMax(I1, I2: integer): integer; begin if I1 > I2 then Result := I1 else Result := I2; end;
var
  i: integer;
  hMap: THandle;
  lpMA: pointer;
  PIISrc, PII: PInstanceInfo;
  PIID: PInstanceID;
  ProcessID: Cardinal;
  TargetProcess: THandle;
  TargetHandle: THandle;
begin
  ClearList(List);
  EnumWindows(@EnumWProc, LPARAM(List));
  // A lista végére kerül az aktuális példány
  List.Add(pointer(ThisHWnd));
  // Adatcsere-terület létrehozása
  hMap := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, IMax(SizeOf(TInstanceID), SizeOf(TInstanceInfo)), nil);
  if (hMap <> 0) then
    lpMA := MapViewOfFile(hMap, FILE_MAP_ALL_ACCESS, 0, 0, 0)
  else
    lpMA := nil;
  try
    // Sorra vesszük az ablakokat. Mindaddig meghívódik a paraméterként
    // átadott függvény, amíg el nem fogynak az ablakok, vagy a CallBack
    // függvény False-szal tér vissza.
    if (hMap <> 0) and Assigned(lpMA) then begin
      for i := List.Count - 1 downto 0 do begin
        // Megfelelõ választ küld?
        if SendMessage(HWnd(List[i]), IHGetInstanceInfo, LPARAM(True), WPARAM(True)) = LRESULT(True) then begin
          GetWindowThreadProcessId(HWnd(List[i]), @ProcessID);
          TargetProcess := OpenProcess(PROCESS_DUP_HANDLE, False, ProcessID);
          try
            if DuplicateHandle(GetCurrentProcess, hMap, TargetProcess, @TargetHandle,
              FILE_MAP_READ + FILE_MAP_WRITE, False, 0) then begin
              // Elhelyezzük az aktuális programpéldány azonosítóit
              // TInstanceID rekord szerint az adatcsere-területen
              PIID := PInstanceID(lpMA);
              PIID^.IDSize := IIDSize;
              PIID^.IDSum := IIDSum;
              PIID^.IDCRC := IIDCRC;

              // Elküldjük a WM_GETINSTANCEINFO üzenetet, amire az üzenet feldolgozója
              // összehasonlítja azt a sajátjáéval, egyezés esetén elhelyezi az
              // információit az adatcsere-területen TInstanceInfo rekordban,
              // és IDOK értékkel tér vissza.
              if SendMessage(HWnd(List[i]), IHGetInstanceInfo, TargetHandle, 0) = LRESULT(True) then begin
                // Ha a két példány megegyezik, akkor memóriát foglalunk a TInstanceInfo rekordnak,
                // és átmásoljuk az adatokat.
                PII := New(PInstanceInfo);
                List[i] := PII;

                PIISrc := PInstanceInfo(lpMA);
                PII^.AppHWnd := PIISrc^.AppHWnd;
                PII^.MainHWnd := PIISrc^.MainHWnd;
                PII^.StartTime := PIISrc^.StartTime;
              end
              else
                List.Delete(i);
            end
            else
              List.Delete(i); // Nem sikerült lekérdezni
          finally
            CloseHandle(TargetProcess);
          end;
        end
        else
          List.Delete(i); // Nem megfelelõ válasz
      end; // for
    end;
  finally
    // Adatcsere-terület felszabadítása
    if Assigned(lpMA) then
      UnmapViewOfFile(lpMA);
    CloseHandle(hMap);
  end;
end;

type
  TInstanceInfoImpl = class(TInterfacedObject, IInstanceInfo)
  private
    FAppHWnd: HWND;
    FMainHWnd: HWND;
    FStartTime: TDateTime;
  protected
    function AppHWnd: HWND;         // A TApplication ablak azonosítója
    function MainHWnd: HWND;        // A fõform azonosítója
    function StartTime: TDateTime;  // A program (IH) indításának dátuma/ideje
    function ActivateAppWnd: TInstanceActivateStatus;
    function ActivateMainWnd: TInstanceActivateStatus;
  public
    constructor Create(const AAppHWnd, AMainHWnd: HWND; const AStartTime: TDateTime);
  end;

  TInstancesInfoImpl = class(TInterfacedObject, IInstancesInfo)
  private
    FInstanceInfo: TList;
  protected
    function GetCount: integer;
    function GetInstanceInfo(i: integer): IInstanceInfo;
    procedure SortByStartTime;
  public
    constructor Create(AInstanceInfo: TList);
    destructor Destroy; override;
  end;

{ TInstanceInfoImpl }

constructor TInstanceInfoImpl.Create(const AAppHWnd, AMainHWnd: HWND; const AStartTime: TDateTime);
begin
  inherited Create;
  FAppHWnd := AAppHWnd;
  FMainHWnd := AMainHWnd;
  FStartTime := AStartTime;
end;

function TInstanceInfoImpl.AppHWnd: HWND;
begin
  Result := FAppHWnd;
end;

function TInstanceInfoImpl.MainHWnd: HWND;
begin
  Result := FMainHWnd;
end;

function TInstanceInfoImpl.StartTime: TDateTime;
begin
  Result := FStartTime;
end;

function TInstanceInfoImpl.ActivateAppWnd: TInstanceActivateStatus;
begin
  Result := ActivateInstance(FAppHWnd);
end;

function TInstanceInfoImpl.ActivateMainWnd: TInstanceActivateStatus;
begin
  Result := ActivateInstance(FMainHWnd);
end;

{ TInstancesInfoImpl }

constructor TInstancesInfoImpl.Create(AInstanceInfo: TList);
var
  i: integer;
begin
  inherited Create;
  FInstanceInfo := TList.Create;
  for i := 0 to AInstanceInfo.Count - 1 do
    FInstanceInfo.Add(AInstanceInfo[i]);
end;

destructor TInstancesInfoImpl.Destroy;
begin
  ClearList(FInstanceInfo);
  FInstanceInfo.Free;
  inherited;
end;

function TInstancesInfoImpl.GetCount: integer;
begin
  Result := FInstanceInfo.Count;
end;

function TInstancesInfoImpl.GetInstanceInfo(i: integer): IInstanceInfo;
begin
  with PInstanceInfo(FInstanceInfo[i])^ do
    Result := TInstanceInfoImpl.Create(AppHWnd, MainHWnd, StartTime);
end;

function SortFunct(Item1, Item2: Pointer): Integer;
begin
  if PInstanceInfo(Item1)^.StartTime > PInstanceInfo(Item2)^.StartTime then
    Result := 1
  else if PInstanceInfo(Item1)^.StartTime < PInstanceInfo(Item2)^.StartTime then
    Result := -1
  else
    Result := 0;
end;

procedure TInstancesInfoImpl.SortByStartTime;
begin
  FInstanceInfo.Sort(SortFunct);
end;


function GetInstancesInfo: IInstancesInfo;
var
  List: TList;
begin
  List := TList.Create;
  try
    GetInstancesInfoList(List);
    Result := TInstancesInfoImpl.Create(List);
  finally
    List.Free;  // ClearList nem jó
  end;
end;

function GetInstanceCount: integer;
begin
  Result := GetInstancesInfo.Count;
end;

function GetStartTime: TDateTime;
begin
  Result := StartTime;
end;

// Programpéldány aktiválása
function ActivateInstance(hWnd: HWND): TInstanceActivateStatus;
var
  hLast, hOwner: Cardinal;
begin
  Result := iasInvalidHWND;
  // Érvényes a leíró?
  if IsWindow(hWnd) then begin
    // Tulajdonos ablak leírójának lekérdezése (TApplication).
    hOwner := GetWindow(hWnd, GW_OWNER);
    // Ha nincs tulajdonos, akkor vagy nem Delphi alkalmazás,
    // vagy a TApplication ablak leíróját kaptuk meg.
    if hOwner = 0 then
      hOwner := hWnd;
    // Ikonizálva van? ha igen, visszaállítjuk.
    if IsIconic(hOwner) and not ShowWindow(hOwner, SW_RESTORE) then
      Result := iasCannotRestore
    else begin
      // Utolsó aktív popup ablak leírójának lekérdezése.
      hLast := GetLastActivePopup(hOwner);
      // Aktívvá tesszük a program fõablakát.
      if not SetForegroundWindow(hOwner) then
        Result := iasCannotActivateMain
      else
        // Ha volt aktív popup ablak a képernyõn, akkor aktivizáljuk.
        if (Result = iasSuccess) and (hLast <> hWnd) and not SetForegroundWindow(hLast) then
          Result := iasCannotActivatePopup
        else
          Result := iasSuccess; // default OK
    end;
  end;
end;

procedure CreateIDs;
  // Ellenõrzõ összegek elõállítása
  procedure CalcChkCodes(Buffer: PChar);
  var
    Crc32Tbl: array[Byte] of Longint;
    procedure MakeCRC32Tbl; { from FPC }
    var
      crc: Longint;
      i: Byte;
      n: Byte;
    begin
      for i := Low(Crc32Tbl) to High(Crc32Tbl) do begin
        crc := i;
        for n := 1 to 8 do
          if odd(crc) then
            crc := (crc shr 1) xor Longint($edb88320)
          else
            crc := crc shr 1;
        Crc32Tbl[i] := crc;
      end;
    end;
  var
    i: integer;
  begin
    MakeCRC32Tbl;
    IIDSum := 0;
    IIDCRC := -1;
    for i := 1 to IIDSize do begin
      IIDCRC := CRC32Tbl[Byte(IIDCRC) xor ord(Buffer^)] xor (IIDCRC shr 8);
      inc(IIDSum, ord(Buffer^));
      Inc(Buffer);
    end;
  end;
var
  hFile: THandle;
  hMem: THandle;
  FContent: Pointer;
  FName: array[0..MAX_PATH] of char;
begin
  // Az aktuális fájl elérési útja és neve az elsõdleges azonosító
  if GetModuleFileName(hInstance, FName, MAX_PATH) > 0 then begin
    hFile := CreateFile(FName, GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_FLAG_SEQUENTIAL_SCAN, 0);
    if hFile <> INVALID_HANDLE_VALUE then begin // Ha sikerült megnyitni,
      try
        IIDSize := GetFileSize(hFile, nil);
        hMem := CreateFileMapping(hFile, nil, PAGE_READONLY or SEC_IMAGE, 0, 0, nil);
        if hMem <> 0 then begin
          try
            FContent := MapViewOfFile(hMem, FILE_MAP_READ, 0, 0, 0);
            if Assigned(FContent) then begin
              try
                CalcChkCodes(FContent);
              finally
                UnmapViewOfFile(FContent);
              end;
            end;
          finally
            CloseHandle(hMem);
          end;
        end;
      finally
        CloseHandle(hFile);
      end;
    end;
  end;
end;

initialization
  // Azonosítók létrehozása
  CreateIDs;
  // Application ablak leírójának lekérdezése
  ThisHWnd := Application.Handle;
  // Az InstanceHandler (~program) indításának dátuma/ideje
  StartTime := Now;
  // Saját üzenet regisztrálása
  IHGetInstanceInfo := RegisterWindowMessage('IH_GETINSTANCEINFO');
  // Alosztály létrehozása az Application ablakhoz
  OldHandler := SetWindowLong(ThisHWnd, GWL_WNDPROC, Integer(@MsgHandler));
finalization
  // Az eredeti üzenetkezelõ függvény visszaállítása
  SetWindowLong(Application.Handle, GWL_WNDPROC, OldHandler);
end.

