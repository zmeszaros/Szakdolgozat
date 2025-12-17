//Riasztókat tartalmazó lánc eljárásai, függvényei
Unit RiasztoLancUnit;

Interface

Uses Classes, SysUtils, BerendezesekLancUnit;

Type
  //pointerek
  PRiasztoElem  = ^TRiasztoElem;
  PRiasztoLanc  = ^TRiasztoLanc;
  TRiasztoLista = Class;

  //láncelem
  TRiasztoElem = Object
    ID            : Integer;        //azonosító
    Allapot       : Boolean;        //a berendezés állapota
    Naplozas      : Boolean;        //kell-e naplózni
    RiasztoMutato : PLancElem;      //BerendezesLista egy elemére mutat
    Kovetkezo     : PRiasztoElem;   //következõ elemre mutat
    Procedure Init(RL: TRiasztoLista; LancElem: PLancElem);
  End;

  //fejelem
  TRiasztoLanc = Object
    Elso     : PRiasztoElem;        //elsõ elemre mutat
    Aktualis : PRiasztoElem;        //aktuális elemre mutat
    Procedure Init(RL: TRiasztoLista);
  End;

  //riasztóláncot tartalmazó osztály
  TRiasztoLista = Class(TPersistent)
  Private
    FValtozas   : Boolean;          //volt-e változás az adatokban
    RiasztoElem : PRiasztoElem;     //egy láncelemre mutat
    RiasztoLanc : TRiasztoLanc;     //láncra mutat
    BerendLista : TBerendezesLista; //berendezések lánca
    Procedure LancFeltolt;
    Procedure SetValt(Ertek: Boolean);
  Public
    Property Elso : PRiasztoElem Read RiasztoLanc.Elso Write RiasztoLanc.Elso;
    Property Aktualis : PRiasztoElem Read RiasztoLanc.Aktualis Write RiasztoLanc.Aktualis;
    Property Valtozas : Boolean Read FValtozas Write SetValt;
    Function Torles(Mut: PRiasztoElem) : Boolean;
    Function KeresID(Const Azon: Integer; Var Mutato: PRiasztoElem): Boolean;
    Procedure Vegere;
    Procedure Felfuz(Const LancElem: PLancElem);
    Constructor Create(Const BL: TBerendezesLista); Virtual;
    Destructor Destroy; Override;
  End;

Implementation

//láncelem létrehozása
Procedure TRiasztoElem.Init(RL: TRiasztoLista; LancElem: PLancElem);
Begin
  With RL Do
  Begin
    New(RiasztoElem);
    RiasztoElem.ID:=LancElem.ID;
    RiasztoElem.Allapot:=False;
    RiasztoElem.Naplozas:=True;
    RiasztoElem.RiasztoMutato:=LancElem;
    RiasztoElem.Kovetkezo:=Nil;
  End;
End;

//fejelem létrehozása
Procedure TRiasztoLanc.Init(RL: TRiasztoLista);
Begin
  With RL Do
  Begin
    New(PRiasztoLanc);
    RiasztoLanc.Elso:=Nil;
    RiasztoLanc.Aktualis:=Nil;
  End;
End;

//riasztólánc létrehozása
Constructor TRiasztoLista.Create(Const BL: TBerendezesLista);
Begin
  Inherited Create;
  Self.RiasztoElem:=Nil;
  Self.Valtozas:=False;
  Self.RiasztoLanc.Init(Self);
  Self.BerendLista:=BL;
  Self.LancFeltolt;
End;

//riasztólánc megszüntetése
Destructor TRiasztoLista.Destroy;
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
Function TRiasztoLista.Torles(Mut: PRiasztoElem): Boolean;
Var UjMut : PRiasztoElem;
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
Function TRiasztoLista.KeresID(Const Azon: Integer; Var Mutato: PRiasztoElem): Boolean;
Var RegiAktualis : PRiasztoElem;
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
Procedure TRiasztoLista.SetValt(Ertek: Boolean);
Begin
  Self.FValtozas:=Ertek;
End;

//elmegy a lánc utolsó elemére
Procedure TRiasztoLista.Vegere;
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
Procedure TRiasztoLista.Felfuz(Const LancElem: PLancElem);
Begin
  //ha van mit felfûzni
  If (LancElem <> Nil) Then
  Begin
    Self.Vegere;
    //láncelem létrehozása
    RiasztoElem.Init(Self,LancElem);
    //láncelem felfûzése
    If (Self.Elso = Nil) Then Self.Elso:=RiasztoElem
      Else Self.Aktualis.Kovetkezo:=RiasztoElem;
    Self.Aktualis:=RiasztoElem;
    Self.Valtozas:=True;
  End;
End;

//riasztólánc feltöltése a berendezéslánc alapján
Procedure TRiasztoLista.LancFeltolt;
Var RegiHely : Pointer;
Begin
  //ha létezik a berendezéslánc
  If (BerendLista <> Nil) And (BerendLista.Elso <> Nil) Then
  Begin
    RegiHely:=BerendLista.Aktualis;
    BerendLista.Aktualis:=BerendLista.Elso;
    While (BerendLista.Aktualis <> Nil) Do
    Begin
      //ha a berendezés típusa riasztó
      If (BerendLista.Aktualis.BerendezesTip = btRiaszto) Then
        Self.Felfuz(BerendLista.Aktualis);
      BerendLista.Aktualis:=BerendLista.Aktualis.Kovetkezo;
    End;
    BerendLista.Aktualis:=RegiHely;
  End;
End;

End.
