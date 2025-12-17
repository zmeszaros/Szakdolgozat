//Hõmérõket tartalmazó lánc eljárásai, függvényei
Unit HomeroLancUnit;

Interface

Uses Classes, SysUtils, BerendezesekLancUnit;

Const MinHofok =  0;
      MaxHofok = 40;

Type
  //pointerek
  PHomeroElem  = ^THomeroElem;
  PHomeroLanc  = ^THomeroLanc;
  THomeroLista = Class;

  //láncelem
  THomeroElem = Object
    ID            : Integer;      //azonosító
    Min,Max       : Integer;      //mérési határok
    MertErtek     : Integer;      //mért érték
    BeallErtek    : Integer;      //beállított érték
    Naplozas      : Boolean;      //kell-e naplózni
    HomeroMutato  : PLancElem;    //BerendezesLista egy elemére mutat
    Kovetkezo     : PHomeroElem;  //következõ elemre mutat
    Procedure Init(HL: THomeroLista; LancElem: PLancElem);
  End;

  //fejelem
  THomeroLanc = Object
    Elso     : PHomeroElem;       //elsõ elemre mutat
    Aktualis : PHomeroElem;       //aktuális elemre mutat
    Procedure Init(HL: THomeroLista);
  End;

  //hõmérõláncot tartalmazó osztály
  THomeroLista = Class(TPersistent)
  Private
    FValtozas   : Boolean;          //volt-e változás az adatokban
    HomeroElem  : PHomeroElem;      //egy láncelemre mutat
    HomeroLanc  : THomeroLanc;      //láncra mutat
    BerendLista : TBerendezesLista; //berendezések lánca
    Procedure LancFeltolt;
    Procedure SetValt(Ertek: Boolean);
  Public
    Property Elso : PHomeroElem Read HomeroLanc.Elso Write HomeroLanc.Elso;
    Property Aktualis : PHomeroElem Read HomeroLanc.Aktualis Write HomeroLanc.Aktualis;
    Property Valtozas : Boolean Read FValtozas Write SetValt;
    Function Torles(Mut: PHomeroElem) : Boolean;
    Function KeresID(Const Azon: Integer; Var Mutato: PHomeroElem): Boolean;
    Procedure Vegere;
    Procedure Felfuz(Const LancElem: PLancElem);
    Constructor Create(Const BL: TBerendezesLista); Virtual;
    Destructor Destroy; Override;
  End;

Implementation

//láncelem létrehozása
Procedure THomeroElem.Init(HL: THomeroLista; LancElem: PLancElem);
Begin
  With HL Do
  Begin
    New(HomeroElem);
    HomeroElem.ID:=LancElem.ID;
    HomeroElem.Min:=MinHofok;
    HomeroElem.Max:=MaxHofok;
    HomeroElem.MertErtek:=0;
    HomeroElem.Naplozas:=True;
    HomeroElem.BeallErtek:=(MinHofok+MaxHofok) Div 2;
    HomeroElem.HomeroMutato:=LancElem;
    HomeroElem.Kovetkezo:=Nil;
  End;
End;

//fejelem létrehozása
Procedure THomeroLanc.Init(HL: THomeroLista);
Begin
  With HL Do
  Begin
    New(PHomeroLanc);
    HomeroLanc.Elso:=Nil;
    HomeroLanc.Aktualis:=Nil;
  End;
End;

//hõmérõlánc létrehozása
Constructor THomeroLista.Create(Const BL: TBerendezesLista);
Begin
  Inherited Create;
  Self.HomeroElem:=Nil;
  Self.Valtozas:=False;
  Self.HomeroLanc.Init(Self);
  Self.BerendLista:=BL;
  Self.LancFeltolt;
End;

//hõmérõlánc megszüntetése
Destructor THomeroLista.Destroy;
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

//törlés a láncból az elem mutatója alapján
//ha sikerült -> True, különben -> False
Function THomeroLista.Torles(Mut: PHomeroElem): Boolean;
Var UjMut : PHomeroElem;
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
Function THomeroLista.KeresID(Const Azon: Integer; Var Mutato: PHomeroElem): Boolean;
Var RegiAktualis : PHomeroElem;
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
Procedure THomeroLista.SetValt(Ertek: Boolean);
Begin
  Self.FValtozas:=Ertek;
End;

//elmegy a lánc utolsó elemére
Procedure THomeroLista.Vegere;
Begin
  //ha van elem a láncban
  If (Self.Elso <> Nil) And (Self.Aktualis.Kovetkezo <> Nil) Then
  Begin
    Self.Aktualis:=Self.Elso;
    While (Self.Aktualis.Kovetkezo <> Nil) Do Self.Aktualis:=Self.Aktualis.Kovetkezo;
  End;
End;

//elem felfûzése a láncra
Procedure THomeroLista.Felfuz(Const LancElem: PLancElem);
Begin
  //ha van mit felfûzni
  If (LancElem <> Nil) Then
  Begin
    Self.Vegere;
    //láncelem létrehozása
    HomeroElem.Init(Self,LancElem);
    //láncelem felfûzése
    If (Self.Elso = Nil) Then Self.Elso:=HomeroElem
      Else Self.Aktualis.Kovetkezo:=HomeroElem;
    Self.Aktualis:=HomeroElem;
    Self.Valtozas:=True;
  End;
End;

//hõmérõlánc feltöltése a berendezéslánc alapján
Procedure THomeroLista.LancFeltolt;
Var RegiHely : Pointer;
Begin
  //ha létezik a berendezéslánc
  If (BerendLista <> Nil) And (BerendLista.Elso <> Nil) Then
  Begin
    RegiHely:=BerendLista.Aktualis;
    BerendLista.Aktualis:=BerendLista.Elso;
    While (BerendLista.Aktualis <> Nil) Do
    Begin
      //ha a berendezés típusa hõmérõ
      If (BerendLista.Aktualis.BerendezesTip = btHomero) Then
        Self.Felfuz(BerendLista.Aktualis);
      BerendLista.Aktualis:=BerendLista.Aktualis.Kovetkezo;
    End;
    BerendLista.Aktualis:=RegiHely;
  End;
End;

End.
