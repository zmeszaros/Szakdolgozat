//Tûzjelzõket tartalmazó lánc eljárásai, függvényei
Unit TuzjelzoLancUnit;

Interface

Uses Classes, SysUtils, BerendezesekLancUnit;

Type
  //pointerek
  PTuzjelzoElem  = ^TTuzjelzoElem;
  PTuzjelzoLanc  = ^TTuzjelzoLanc;
  TTuzjelzoLista = Class;

  //láncelem
  TTuzjelzoElem = Object
    ID             : Integer;        //azonosító
    Allapot        : Boolean;        //a berendezés állapota
    Naplozas       : Boolean;        //kell-e naplózni
    TuzjelzoMutato : PLancElem;      //BerendezesLista egy elemére mutat
    Kovetkezo      : PTuzjelzoElem;  //következõ elemre mutat
    Procedure Init(TL: TTuzjelzoLista; LancElem: PLancElem);
  End;

  //fejelem
  TTuzjelzoLanc = Object
    Elso     : PTuzjelzoElem;        //elsõ elemre mutat
    Aktualis : PTuzjelzoElem;        //aktuális elemre mutat
    Procedure Init(TL: TTuzjelzoLista);
  End;

  //tûzjelzõáncot tartalmazó osztály
  TTuzjelzoLista = Class(TPersistent)
  Private
    FValtozas    : Boolean;          //volt-e változás az adatokban
    TuzjelzoElem : PTuzjelzoElem;    //egy láncelemre mutat
    TuzjelzoLanc : TTuzjelzoLanc;    //láncra mutat
    BerendLista  : TBerendezesLista; //berendezések lánca
    Procedure LancFeltolt;
    Procedure SetValt(Ertek: Boolean);
  Public
    Property Elso : PTuzjelzoElem Read TuzjelzoLanc.Elso Write TuzjelzoLanc.Elso;
    Property Aktualis : PTuzjelzoElem Read TuzjelzoLanc.Aktualis Write TuzjelzoLanc.Aktualis;
    Property Valtozas : Boolean Read FValtozas Write SetValt;
    Function Torles(Mut: PTuzjelzoElem) : Boolean;
    Function KeresID(Const Azon: Integer; Var Mutato: PTuzjelzoElem): Boolean;
    Procedure Vegere;
    Procedure Felfuz(Const LancElem: PLancElem);
    Constructor Create(Const BL: TBerendezesLista); Virtual;
    Destructor Destroy; Override;
  End;

Implementation

//láncelem létrehozása
Procedure TTuzjelzoElem.Init(TL: TTuzjelzoLista; LancElem: PLancElem);
Begin
  With TL Do
  Begin
    New(TuzjelzoElem);
    TuzjelzoElem.ID:=LancElem.ID;
    TuzjelzoElem.Allapot:=False;
    TuzjelzoElem.Naplozas:=True;
    TuzjelzoElem.TuzjelzoMutato:=LancElem;
    TuzjelzoElem.Kovetkezo:=Nil;
  End;
End;

//fejelem létrehozása
Procedure TTuzjelzoLanc.Init(TL: TTuzjelzoLista);
Begin
  With TL Do
  Begin
    New(PTuzjelzoLanc);
    TuzjelzoLanc.Elso:=Nil;
    TuzjelzoLanc.Aktualis:=Nil;
  End;
End;

//tûzjelzõlánc létrehozása
Constructor TTuzjelzoLista.Create(Const BL: TBerendezesLista);
Begin
  Inherited Create;
  Self.TuzjelzoElem:=Nil;
  Self.Valtozas:=False;
  Self.TuzjelzoLanc.Init(Self);
  Self.BerendLista:=BL;
  Self.LancFeltolt;
End;

//tûzjelzõlánc megszüntetése
Destructor TTuzjelzoLista.Destroy;
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
Function TTuzjelzoLista.Torles(Mut: PTuzjelzoElem): Boolean;
Var UjMut : PTuzjelzoElem;
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
Function TTuzjelzoLista.KeresID(Const Azon: Integer; Var Mutato: PTuzjelzoElem): Boolean;
Var RegiAktualis : PTuzjelzoElem;
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
Procedure TTuzjelzoLista.SetValt(Ertek: Boolean);
Begin
  Self.FValtozas:=Ertek;
End;

//elmegy a lánc utolsó elemére
Procedure TTuzjelzoLista.Vegere;
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
Procedure TTuzjelzoLista.Felfuz(Const LancElem: PLancElem);
Begin
  //ha van mit felfûzni
  If (LancElem <> Nil) Then
  Begin
    Self.Vegere;
    //láncelem létrehozása
    TuzjelzoElem.Init(Self,LancElem);
    //láncelem felfûzése
    If (Self.Elso = Nil) Then Self.Elso:=TuzjelzoElem
      Else Self.Aktualis.Kovetkezo:=TuzjelzoElem;
    Self.Aktualis:=TuzjelzoElem;
    Self.Valtozas:=True;
  End;
End;

//tûzjelzõlánc feltöltése a berendezéslánc alapján
Procedure TTuzjelzoLista.LancFeltolt;
Var RegiHely : Pointer;
Begin
  //ha létezik a berendezéslánc
  If (BerendLista <> Nil) And (BerendLista.Elso <> Nil) Then
  Begin
    RegiHely:=BerendLista.Aktualis;
    BerendLista.Aktualis:=BerendLista.Elso;
    While (BerendLista.Aktualis <> Nil) Do
    Begin
      //ha a berendezés típusa tûzjelzõ
      If (BerendLista.Aktualis.BerendezesTip = btTuzjelzo) Then
        Self.Felfuz(BerendLista.Aktualis);
      BerendLista.Aktualis:=BerendLista.Aktualis.Kovetkezo;
    End;
    BerendLista.Aktualis:=RegiHely;
  End;
End;

End.
