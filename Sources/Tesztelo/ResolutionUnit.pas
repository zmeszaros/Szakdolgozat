//Felbontás beállítása
Unit ResolutionUnit;

Interface

Uses Windows, Classes, Graphics, Forms;

//ezen beállítások közül keresi meg a legjobbat
Const Bitek  : Array[0..2] Of Integer = (8,16,32);       //színmélység
      ResXek : Array[0..2] Of Integer = (640,800,1024);  //horiz. felbontás
      ResYok : Array[0..2] Of Integer = (480,600,768);   //vert. felbontás

Type
  //felbontás tulajdonságai
  TDevTul = Record
    FBits : Cardinal;
    FHRes : Cardinal;
    FVRes : Cardinal;
  End;

  //felbontás osztály
  TResolution = Class(TPersistent)
  Private
    FModeNum   : LongInt;    //melyik módban vagyunk
    FAktDevTul : TDevTul;    //aktuális felbontás
    FOldDevTul : TDevTul;    //elõzõ felbontás
    FModes     : Array[0..255] Of TDevMode; //a grafikus kártya által támogatott üz.módok
    Procedure ResVissza;
    Procedure GetResolutions;
    Function SetResolution(Width,Height,Bits: Cardinal): Boolean;
  Published
    Property AktDevTul : TDevTul Read FAktDevTul;
    Property OldDevTul : TDevTul Read FOldDevTul;
  Public
    Function BestOfRes : Boolean;
    Constructor Create;
    Destructor Destroy; Override;
  End;

Implementation

//osztály létrehozása
Constructor TResolution.Create;
Var DC : THandle;
Begin
  Inherited Create;
  //ablakkezelõ lekérdezése
  DC:=GetDC(GetDesktopWindow);
  //elmentjük az aktuális felbontást
  With FOldDevTul Do
  Begin
    FBits:=GetDeviceCaps(DC,BITSPIXEL);
    FHRes:=GetDeviceCaps(DC,HORZRES);
    FVRes:=GetDeviceCaps(DC,VERTRES);
  End;
  FAktDevTul:=FOldDevTul;
  //lekérdezzük a támogatott beállításokat
  GetResolutions;
End;

//osztály megszüntetése
Destructor TResolution.Destroy;
Begin
  //felbontás visszaállítása
  Self.ResVissza;
  Inherited;
End;

//lekérdezzük a támogatott beállításokat
Procedure TResolution.GetResolutions;
Var DM : TDevMode;
    Ok : Boolean;
Begin
  FModeNum:=(-1);
  OK:=True;
  //amíg igaz
  While OK Do
  Begin
    Inc(FModeNum);
    //van FModeNum felbontásunk?
    OK:=EnumDisplaySettings(Nil,FModeNum,DM);
    //ha van -> felvesszük a tömbbe
    If OK Then FModes[FModeNum]:=DM;
  End;
End;

//megpróbáljuk a legjobbat beállítani
//ha sikerült -> True, különben -> False
Function TResolution.BestOfRes : Boolean;
Var I,J : Integer;
    OK  : Boolean;
Begin
  //elindulunk a legjobb felbontásból
  For I:=High(ResXek) DownTo Low(ResXek) Do
  Begin
    For J:=High(Bitek) DownTo Low(Bitek) Do
    Begin
      //megpróbáljuk beállítani
      OK:=Self.SetResolution(ResXek[I],ResYok[I],Bitek[J]);
      //ha sikerült -> kilépünk
      If OK Then Break;
    End;
    If OK Then Break;
  End;
  Result:=OK;
End;

//felbontás visszaállítása
Procedure TResolution.ResVissza;
Begin
  With FOldDevTul Do Self.SetResolution(FHRes,FVRes,FBits);
End;

//felbontás átváltása
Function TResolution.SetResolution(Width,Height,Bits: Cardinal): Boolean;
Var Found   : Boolean;
    Mode    : Integer;
    Change  : Integer;
    NewMode : TDevMode;
Begin
  //ha az aktuális felbontással megeggyezik
  If (FAktDevTul.FHRes = Width) And (FAktDevTul.FVRes = Height) And
     (FAktDevTul.FBits = Bits) Then
  Begin
    Result:=True;
    Exit;
  End;
  Found:=False;
  //megkeresi, hogy be lehet-e állítani
  For Mode:=0 To FModeNum Do
  Begin
    NewMode:=TDevMode(FModes[Mode]);
    //ha megtalálta a tömbben
    If (Width = NewMode.dmPelsWidth) And (Height = NewMode.dmPelsHeight)
        And (Bits = NewMode.dmBitsPerPel) Then
    Begin
      Found:=True;
      Break;
    End;
  End;
  //ha nincs meg -> kilépés
  If (Not Found) Then
  Begin
    Result:=False;
    Exit;
  End;
  //az új paraméterek beállítása
  With NewMode Do
  Begin
    dmSize:=SizeOf(NewMode);
    dmDisplayFrequency:=0;
    dmFields:=DM_PELSWIDTH Or DM_PELSHEIGHT Or DM_BITSPERPEL;
    dmDisplayFlags:=DM_BITSPERPEL And DM_PELSWIDTH And
      DM_PELSHEIGHT And DM_DISPLAYFLAGS;
  End;

  {$IFOPT R+}
    {$DEFINE CKRANGE}
    {$R-}
  {$ENDIF}

  //a felbontás tényleges átváltása
  Change:=ChangeDisplaySettings(NewMode, CDS_UPDATEREGISTRY);

  {$IFDEF CKRANGE}
    {$UNDEF CKRANGE}
    {$R+}
  {$ENDIF}

  //eredmény
  Case Change Of
    //ha rendben
    DISP_CHANGE_SUCCESSFUL : Begin
                               Result:=True;
                               With FAktDevTul Do
                               Begin
                                 FHRes:=Width;
                                 FVRes:=Height;
                                 FBits:=Bits;
                               End;
                             End;
    Else Result:=False;
  End;
End;

End.
