//Figyelmeztetõ hangjelzést vezérlõ szál
Unit HangThreadUnit;

Interface

Uses Classes, Bleeper;

Const Freq  = 200;   //frekvencia
      MSecs = 500;   //milliszekundum

Type
  //szál típus
  THangThread = Class(TThread)
  Private
    Procedure Sipol;
  Protected
    procedure Execute; Override;
  Public
    Constructor Create;
    Destructor Destroy; Override;
  End;

Implementation

//szál létrehozása
Constructor THangThread.Create;
Begin
  Inherited Create(True);
  //prioritás alacsony
  Self.Priority:=tpLower;
End;

//szál megszüntetése
Destructor THangThread.Destroy;
Begin
  //szál terminálása
  Self.Terminate;
  Inherited Destroy;
End;

//szál mûvelet
Procedure THangThread.Execute;
Begin
  Repeat
    Synchronize(Sipol);
  Until Terminated;
End;

//hang elõállítása
Procedure THangThread.Sipol;
Begin
  DoBleep(Freq,MSecs);
  //szál felfüggesztése
  Self.Suspend;
End;

End.
 