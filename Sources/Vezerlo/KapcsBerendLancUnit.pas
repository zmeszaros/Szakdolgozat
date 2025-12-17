//Az egymáshoz tartozó berendezéseket tartalmazó lánc eljárásai, függvényei
Unit KapcsBerendLancUnit;

Interface

Uses Classes, SysUtils, BerendezesekLancUnit;

Type
  //pointerek
  PKapcsBerendElem  = ^TKapcsBerendElem;
  PKapcsBerendLanc  = ^TKapcsBerendLanc;
  TKapcsBerendLista = Class;

  //láncelem
  TKapcsBerendElem = Object
    MiKapcs    : PLancElem;  //BerendezesLista egy elemére mutat
    MihezKapcs : PLancElem;  //BerendezesLista egy elemére mutat
    Kovetkezo  : PKapcsBerendElem;
    Procedure Init(KBL: TKapcsBerendLista; Mi,Mihez: PLancElem);
  End;

  //fejelem
  TKapcsBerendLanc = Object
    Elso     : PKapcsBerendElem;  //elsõ elemre mutat
    Aktualis : PKapcsBerendElem;  //aktuális elemre mutat
    Procedure Init(KBL: TKapcsBerendLista);
  End;

  //a láncot tartalmazó osztály
  TKapcsBerendLista = Class(TPersistent)
  Private
    FValtozas        : Boolean;            //volt-e változás az adatokban
    BerendLista      : TBerendezesLista;   //berendezések lánca
    KapcsBerendElem  : PKapcsBerendElem;   //egy láncelemre mutat
    KapcsBerendLanc  : TKapcsBerendLanc;   //láncra mutat
    Procedure Vegere;
    Procedure SetValt(Ertek: Boolean);
  Public
    Property Elso : PKapcsBerendElem Read KapcsBerendLanc.Elso Write KapcsBerendLanc.Elso;
    Property Aktualis : PKapcsBerendElem Read KapcsBerendLanc.Aktualis Write KapcsBerendLanc.Aktualis;
    Property Valtozas : Boolean Read FValtozas Write SetValt;
    Function KeresBerend(Mihez: PLancElem) : TStrings;
    Function MiKapcs(Mihez: PLancElem) : TMutatoArray;
    Function Torles(Mut: PKapcsBerendElem) : Boolean;
    Procedure Kifuz(Const Miket: PLancElem);
    Procedure Felfuz(Const Mi,Mihez: PLancElem);
    Constructor Create(Const BL: TBerendezesLista); Virtual;
    Destructor Destroy; Override;
  End;

Implementation

//láncelem létrehozása
Procedure TKapcsBerendElem.Init(KBL: TKapcsBerendLista; Mi,Mihez: PLancElem);
Begin
  With KBL Do
  Begin
    New(KapcsBerendElem);
    KapcsBerendElem.MiKapcs:=Mi;
    KapcsBerendElem.MihezKapcs:=Mihez;
    KapcsBerendElem.Kovetkezo:=Nil;
  End;
End;

//fejelem létrehozása
Procedure TKapcsBerendLanc.Init(KBL: TKapcsBerendLista);
Begin
  With KBL Do
  Begin
    New(PKapcsBerendLanc);
    KapcsBerendLanc.Elso:=Nil;
    KapcsBerendLanc.Aktualis:=Nil;
  End;
End;

//lánc létrehozása
Constructor TKapcsBerendLista.Create(Const BL: TBerendezesLista);
Begin
  Inherited Create;
  Self.Valtozas:=False;
  Self.KapcsBerendElem:=Nil;
  Self.KapcsBerendLanc.Init(Self);
  Self.BerendLista:=BL;
End;

//lánc megszüntetése
Destructor TKapcsBerendLista.Destroy;
Begin
  //a lánc összes elemét felszabadítja
  Self.Aktualis:=Self.Elso;
  While (Self.Elso <> Nil) Do
  Begin
    Self.Elso:=Self.Aktualis.Kovetkezo;
    Dispose(Self.Aktualis);
    Self.Aktualis:=Self.Elso;
  End;
  Inherited;
End;

//megmondja, hogy mi kapcsolódik mihez
//visszatérési érték egy dinamikus tömb
Function TKapcsBerendLista.MiKapcs(Mihez: PLancElem): TMutatoArray;
Var I       : Integer;
    RegiMut : PKapcsBerendElem;
Begin
  I:=0;
  SetLength(Result,I);
  If (Mihez <> Nil) And (Self.Elso <> Nil) Then
  Begin
    RegiMut:=Self.Aktualis;
    //végigmegyünk a láncon
    Self.Aktualis:=Self.Elso;
    While (Self.Aktualis <> Nil) Do
    Begin
      //ha azonos, akkor felvesszük a tömbbe
      If (Self.Aktualis.MihezKapcs = Mihez) Then
      Begin
        Inc(I);
        SetLength(Result,I);
        Result[I-1]:=Self.Aktualis.MiKapcs;
      End;
      Self.Aktualis:=Self.Aktualis.Kovetkezo;
    End;
    Self.Aktualis:=RegiMut;
  End;
End;

//megmondja, hogy az adott berendezéshez mi kapcsolódik
//visszatérési érték TStrings
Function TKapcsBerendLista.KeresBerend(Mihez: PLancElem) : TStrings;
Var sID     : String;
    RegiMut : PKapcsBerendElem;
Begin
  Result:=TStringList.Create;
  Result.Clear;
  If (Mihez <> Nil) And (Self.Elso <> Nil) Then
  Begin
    RegiMut:=Self.Aktualis;
    //végigmegyünk a láncon
    Self.Aktualis:=Self.Elso;
    While (Self.Aktualis <> Nil) Do
    Begin
      //ha azonos, akkor felvesszük a listába
      If (Self.Aktualis.MihezKapcs = Mihez) Then
      Begin
        sID:=IntToStr(Self.Aktualis.MiKapcs.ID);
        Result.Add(sID+' - '+Self.Aktualis.MiKapcs.BerendezesNev);
      End;
      Self.Aktualis:=Self.Aktualis.Kovetkezo;
    End;
    Self.Aktualis:=RegiMut;
  End;
End;

//törlés a láncból az elem mutatója alapján
//ha sikerült -> True, különben -> False
Function TKapcsBerendLista.Torles(Mut: PKapcsBerendElem): Boolean;
Var UjMut : PKapcsBerendElem;
Begin
  Result:=False;
  If (Mut <> Nil) Then
  Begin
    //ha az elsõt töröljük
    If (Mut = Self.Elso) Then
    Begin
      Result:=True;
      Self.Aktualis:=Self.Elso.Kovetkezo;
      Dispose(Self.Elso);
      Self.Elso:=Self.Aktualis;
    End
    Else Begin
      Self.Aktualis:=Self.Elso;
      //megkeressi a mutatót és megáll elõtte
      While (Self.Aktualis.Kovetkezo <> Mut) And (Self.Aktualis.Kovetkezo <> Nil) Do
        Self.Aktualis:=Self.Aktualis.Kovetkezo;
      //ha megvan, akkor töröli
      If (Self.Aktualis.Kovetkezo = Mut) Then
      Begin
        Result:=True;
        UjMut:=Self.Aktualis.Kovetkezo.Kovetkezo;
        Dispose(Self.Aktualis.Kovetkezo);
        Self.Aktualis.Kovetkezo:=UjMut;
      End;
    End;
    Self.Aktualis:=Self.Elso;
    Self.Valtozas:=True;
  End;
End;

//elmegy a lánc utolsó elemére
Procedure TKapcsBerendLista.Vegere;
Begin
  If (Self.Elso <> Nil) Then
  Begin
    Self.Aktualis:=Self.Elso;
    While (Self.Aktualis.Kovetkezo <> Nil) Do Self.Aktualis:=Self.Aktualis.Kovetkezo;
  End;
End;

//változás beállítása
Procedure TKapcsBerendLista.SetValt(Ertek: Boolean);
Begin
  Self.FValtozas:=Ertek;
End;

//elem felfûzése a láncra
Procedure TKapcsBerendLista.Felfuz(Const Mi,Mihez: PLancElem);
Begin
  //ha van mit felfûzni
  If (Mi <> Nil) And (Mihez <> Nil) Then
  Begin
    Self.Vegere;
    //láncelem létrehozása
    KapcsBerendElem.Init(Self,Mi,Mihez);
    //láncelem felfûzése
    If (Self.Elso = Nil) Then Self.Elso:=KapcsBerendElem
      Else Self.Aktualis.Kovetkezo:=KapcsBerendElem;
    Self.Aktualis:=KapcsBerendElem;
    Self.Valtozas:=True;
  End;
End;

//elem kifûzése a láncból
Procedure TKapcsBerendLista.Kifuz(Const Miket: PLancElem);
Begin
  If (Miket <> Nil) And (Self.Elso <> Nil) Then
  Begin
    Self.Aktualis:=Self.Elso;
    While (Self.Aktualis <> Nil) Do
      //láncelem kifûzése
      If (Self.Aktualis.MihezKapcs = Miket) Then Self.Torles(Self.Aktualis)
      Else Self.Aktualis:=Self.Aktualis.Kovetkezo;
  End;
End;

End.
