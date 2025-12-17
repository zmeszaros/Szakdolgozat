//Végberendezéseket tartalmazó lánc eljárásai, függvényei
Unit VegBerendLancUnit;

Interface

Uses Classes, SysUtils, BerendezesekLancUnit;

Type
  //pointerek
  PVegBerendElem  = ^TVegBerendElem;
  PVegBerendLanc  = ^TVegBerendLanc;
  TVegBerendLista = Class;

  //láncelem
  TVegBerendElem = Object
    ID              : Integer;         //azonosító
    Allapot         : Boolean;         //a berendezés állapota
    Naplozas        : Boolean;         //kell-e naplózni
    Automata        : Boolean;         //automata üzemmód
    Direkt          : Boolean;         //kézi üzemmód
    VegBerendMutato : PLancElem;       //BerendezesLista egy elemére mutat
    Kovetkezo       : PVegBerendElem;  //következõ elemre mutat
    Procedure Init(VBL: TVegBerendLista; LancElem: PLancElem);
  End;

  //fejelem
  TVegBerendLanc = Object
    Elso     : PVegBerendElem;         //elsõ elemre mutat
    Aktualis : PVegBerendElem;         //aktuális elemre mutat
    Procedure Init(VBL: TVegBerendLista);
  End;

  //végberendezésláncot tartalmazó osztály
  TVegBerendLista = Class(TPersistent)
  Private
    FValtozas     : Boolean;           //volt-e változás az adatokban
    VegBerendElem : PVegBerendElem;    //egy láncelemre mutat
    VegBerendLanc : TVegBerendLanc;    //láncra mutat
    BerendLista   : TBerendezesLista;  //berendezések lánca
    Procedure LancFeltolt;
    Procedure SetValt(Ertek: Boolean);
  Public
    Property Elso : PVegBerendElem Read VegBerendLanc.Elso Write VegBerendLanc.Elso;
    Property Aktualis : PVegBerendElem Read VegBerendLanc.Aktualis Write VegBerendLanc.Aktualis;
    Property Valtozas : Boolean Read FValtozas Write SetValt;
    Function Torles(Mut: PVegBerendElem) : Boolean;
    Function KeresID(Const Azon: Integer; Var Mutato: PVegBerendElem): Boolean;
    Procedure Vegere;
    Procedure Felfuz(Const LancElem: PLancElem);
    Constructor Create(Const BL: TBerendezesLista); Virtual;
    Destructor Destroy; Override;
  End;

Implementation

//láncelem létrehozása
Procedure TVegBerendElem.Init(VBL: TVegBerendLista; LancElem: PLancElem);
Begin
  With VBL Do
  Begin
    New(VegBerendElem);
    VegBerendElem.ID:=LancElem.ID;
    VegBerendElem.Allapot:=False;
    VegBerendElem.Automata:=False;
    VegBerendElem.Direkt:=False;
    VegBerendElem.Naplozas:=True;
    VegBerendElem.VegBerendMutato:=LancElem;
    VegBerendElem.Kovetkezo:=Nil;
  End;
End;

//fejelem létrehozása
Procedure TVegBerendLanc.Init(VBL: TVegBerendLista);
Begin
  With VBL Do
  Begin
    New(PVegBerendLanc);
    VegBerendLanc.Elso:=Nil;
    VegBerendLanc.Aktualis:=Nil;
  End;
End;

//végberendezéslánc létrehozása
Constructor TVegBerendLista.Create(Const BL: TBerendezesLista);
Begin
  Inherited Create;
  Self.VegBerendElem:=Nil;
  Self.Valtozas:=False;
  Self.VegBerendLanc.Init(Self);
  Self.BerendLista:=BL;
  Self.LancFeltolt;
End;

//végberendezéslánc megszüntetése
Destructor TVegBerendLista.Destroy;
Begin
  Self.Aktualis:=Self.Elso;
  //a lánc összes elemét felszabadítja
  While (Self.Elso <> Nil) Do
  Begin
    Self.Elso:=Self.Aktualis.Kovetkezo;
    Dispose(Self.Aktualis);
    Self.Aktualis:=Self.Elso;
  End;
  Inherited;
End;

//törlés a láncból az elem mutatója alapján
//ha sikerült -> True, különben -> False
Function TVegBerendLista.Torles(Mut: PVegBerendElem): Boolean;
Var UjMut : PVegBerendElem;
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
  End;
  If Result Then Self.Valtozas:=True;
End;

//keresés a láncban egy azonosító alpján
//ha megvan -> True és visszaadja az elem mutatóját, különben -> False és Nil
Function TVegBerendLista.KeresID(Const Azon: Integer; Var Mutato: PVegBerendElem): Boolean;
Var RegiAktualis : PVegBerendElem;
Begin
  Mutato:=Nil;
  Result:=False;
  //ha van elem a láncban
  If (Self.Elso <> Nil) Then
  Begin
    RegiAktualis:=Self.Aktualis;
    Self.Aktualis:=Self.Elso;
    //addig megy amíg nem láncvége és nincs meg
    While (Self.Aktualis <> Nil) And (Result = False) Do
    Begin
      If (Self.Aktualis.ID = Azon) Then
      Begin
        Result:=True;
        Mutato:=Self.Aktualis;
      End;
      Self.Aktualis:=Self.Aktualis.Kovetkezo;
    End;
    Self.Aktualis:=RegiAktualis;
  End;
End;

//változás beállítása
Procedure TVegBerendLista.SetValt(Ertek: Boolean);
Begin
  Self.FValtozas:=Ertek;
End;

//elmegy a lánc utolsó elemére
Procedure TVegBerendLista.Vegere;
Begin
  //ha van elem a láncban
  If (Self.Elso <> Nil) And (Self.Aktualis.Kovetkezo <> Nil) Then
  Begin
    Self.Aktualis:=Self.Elso;
    While (Self.Aktualis.Kovetkezo <> Nil) Do
      Self.Aktualis:=Self.Aktualis.Kovetkezo;
  End;
End;

//elem felfûzése a láncra
Procedure TVegBerendLista.Felfuz(Const LancElem: PLancElem);
Begin
  //ha van mit felfûzni
  If (LancElem <> Nil) Then
  Begin
    Self.Vegere;
    //láncelem létrehozása
    VegBerendElem.Init(Self,LancElem);
    //láncelem felfûzése
    If (Self.Elso = Nil) Then Self.Elso:=VegBerendElem
      Else Self.Aktualis.Kovetkezo:=VegBerendElem;
    Self.Aktualis:=VegBerendElem;
    Self.Valtozas:=True;
  End;
End;

//végberendezéslánc feltöltése a berendezéslánc alapján
Procedure TVegBerendLista.LancFeltolt;
Var RegiHely : Pointer;
Begin
  //ha létezik a berendezéslánc
  If (BerendLista <> Nil) And (BerendLista.Elso <> Nil) Then
  Begin
    RegiHely:=BerendLista.Aktualis;
    BerendLista.Aktualis:=BerendLista.Elso;
    While (BerendLista.Aktualis <> Nil) Do
    Begin
      //ha a berendezés típusa fûtõtest vagy egyéb berendezés
      Case BerendLista.Aktualis.BerendezesTip Of
        btEgyeb,
        btFutotest : Self.Felfuz(BerendLista.Aktualis);
      End;
      BerendLista.Aktualis:=BerendLista.Aktualis.Kovetkezo;
    End;
    BerendLista.Aktualis:=RegiHely;
  End;
End;

End.
