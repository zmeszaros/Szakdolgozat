Unit Bleeper;

Interface

Procedure ShutUp;
{Added to help counter the effects of DoBleep (Freq, -1).
If you are producing a tone, & you want to stop without doing another Bleep,
call this procedure}

Procedure DoBleep(Freq : Word; MSecs : LongInt);
{Duration of -1 means bleep until the next bleep sent, or ShutUp is called}

Procedure BleepPause(MSecs : LongInt);

Implementation

Uses
{$IFDEF WIN32}Windows{$ELSE}WinProcs{$ENDIF}
{$IFNDEF CONSOLE}, Forms{$ENDIF};

Procedure AsmShutUp;
{$IFDEF WIN32}Pascal;
{$ENDIF}
Begin
  Asm
    In AL, $61
    And AL, $FC
    Out $61, AL
  End;
End;

Procedure AsmBeep(Freq : Word);
{$IFDEF WIN32}Pascal;
{$ENDIF}
Label
  Skip;
Begin
  Asm
        Push BX
        In AL, $61
        Mov BL, AL
        And AL, 3
        Jne Skip
        Mov AL, BL
        Or AL, 3
        Out $61, AL
        Mov AL, $B6
        Out $43, AL
  Skip: Mov AX, Freq
        Out $42, AL
        Mov AL, AH
        Out $42, AL
        Pop BX
  End;
End;

Procedure HardBleep(Freq : Word; MSecs : LongInt);
Begin
  If (Freq >= 20) And (Freq <= 5000) Then
  Begin
    AsmBeep (Word(1193181 Div LongInt(Freq)));
    If MSecs >= 0 Then
    Begin
      BleepPause(MSecs);
      AsmShutUp;
    End;
  End;
End;

{$IFDEF WIN32}
Var SysWinNT : Boolean;
{$ENDIF}

Procedure BleepPause (MSecs : LongInt);
Const
  HiValue = {$IFDEF WIN32}High (DWord){$ELSE}High (LongInt){$ENDIF};
Var
  iCurrTickCount, iFirstTickCount : {$IFDEF WIN32}DWord{$ELSE}LongInt{$ENDIF};
  iElapTime : LongInt;
Begin
  iFirstTickCount := GetTickCount;
  Repeat
    {$IFNDEF CONSOLE}
    If MSecs > 200 Then Application.ProcessMessages;
    {$ENDIF}
    iCurrTickCount := GetTickCount;
    { Has GetTickCount wrapped to 0 ? }
    If iCurrTickCount < iFirstTickCount Then iElapTime:=HiValue-iFirstTickCount+iCurrTickCount
    Else iElapTime := iCurrTickCount - iFirstTickCount;
  Until iElapTime >= MSecs;
End;

Procedure DoBleep (Freq : Word; MSecs : LongInt);
Begin
  If MSecs < -1 Then MSecs := 0;
  {$IFDEF WIN32}
  If SysWinNT Then Windows.Beep(Freq,MSecs) Else {$ENDIF} HardBleep(Freq,MSecs);
End;

Procedure ShutUp;
Begin
  {$IFDEF WIN32} If SysWinNT Then Windows.Beep(1, 0) Else {$ENDIF} AsmShutUp;
End;

{$IFDEF WIN32}

Procedure InitSysType;
Var
  VersionInfo : TOSVersionInfo;
Begin
  VersionInfo.dwOSVersionInfoSize := SizeOf(VersionInfo);
  GetVersionEx(VersionInfo);
  SysWinNt := VersionInfo.dwPlatformID = VER_PLATFORM_WIN32_NT;
End;

Initialization

InitSysType;

{$ENDIF}

End.
