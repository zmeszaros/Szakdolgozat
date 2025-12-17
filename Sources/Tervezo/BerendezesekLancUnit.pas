//Berendezéseket tartalmazó lánc
Unit BerendezesekLancUnit;

Interface

Uses Classes, SysUtils;

Const sHomero   = 'Hõmérõ';
      sRiaszto  = 'Riasztó';
      sTuzjelzo = 'Tûzjelzõ';
      sFutotest = 'Fûtõtest';
      sEgyeb    = 'Egyéb';

Type
  //berendezés típusa
  TBerendezesTip = (btHomero,btRiaszto,btTuzjelzo,btFutotest,btEgyeb);

  //berendezéseket tartalmazó dinamikus tömb
  TBerendArray = Array Of Array[1..5] Of String;

  //LancElem objektumra mutató pointer
  PLancElem = ^TLancElem;
  //BerendezesLanc objektumra mutató pointer
  PBerendezesLanc = ^TBerendezesLanc;
  //BerendezesLista osztály definiálása
  TBerendezesLista = Class;

  //LancElem-ek pointereit tartalmazó dinamikus tömb
  TMutatoArray = Array Of PLancElem;

  //LancElem objektum ( = BerendezLista láncelemei )
  TLancElem = Object
    ID            : Integer;         //azonosító
    BerendezesTip : TBerendezesTip;  //berendezés típusa
    ObjektumNev   : String;          //melyik objektumhoz tartozik
    EpuletEgyseg  : String;          //melyik épületegységhez tartozik
    BerendezesNev : String;          //berendezés neve
    Kovetkezo     : PLancElem;       //következõ berendezésre mutató pointer
    Procedure Init(BL: TBerendezesLista; BT: TBerendezesTip; Azon: Integer;
              ObjNev,EpEgys,Nev: String);
  End;

  //BerendezLista lánc fejeleme
  TBerendezesLanc = Object
    IDSzam   : Integer;                   //azonosító nyilvántartó
    Elso     : PLancElem;                 //elsõ elemre mutató pointer
    Aktualis : PLancElem;                 //aktuális elemre mutató pointer
    Procedure Init(BL: TBerendezesLista);
    Procedure IDNovel;
    Procedure IDCsokkent;
  End;

  //láncot tartalmazó osztály
  TBerendezesLista = Class(TPersistent)
  Private
    Valt           : Boolean;          //volt-e változtatás
    LancElem       : PLancElem;        //egy berendezésre mutat
    BerendArray    : TBerendArray;     //berendezéseket tartalmazó tömb
    BerendezesLanc : TBerendezesLanc;  //fejelem
    Function GetTombUres : Boolean;    //üres-e a BerendArray tömb
    Procedure SetValt(Ertek: Boolean); //változás beállítása
  Public
    Property IDSzam : Integer Read BerendezesLanc.IDSzam Write BerendezesLanc.IDSzam;
    Property Elso : PLancElem Read BerendezesLanc.Elso Write BerendezesLanc.Elso;
    Property Aktualis : PLancElem Read BerendezesLanc.Aktualis Write BerendezesLanc.Aktualis;
    Property BerendTomb : TBerendArray Read BerendArray Write BerendArray;
    Property Valtozas : Boolean Read Valt Write SetValt;
    Property TombUres : Boolean Read GetTombUres;
    Function Keres(Nev: String) : Boolean;
    Function KeresNev(Nev: String) : Integer;
    Function Torles(Mut: PLancElem) : Boolean;
    Function KeresAndTorol(Const Azon: Integer) : Boolean;
    Function KeresID(Const Azon: Integer; Var Mutato: PLancElem): Boolean;
    Procedure Vegere;
    Procedure TombFeltolt;
    Procedure Felfuz(BT: TBerendezesTip; ObjNev,EpEgys,Nev: String); Overload;
    Procedure Felfuz(BT: TBerendezesTip; ObjNev,EpEgys,Nev: String; Azon: Integer); Overload;
    Constructor Create; Virtual;
    Destructor Destroy; Override;
  End;

Implementation

//BerendezesLista létrehozása
Constructor TBerendezesLista.Create;
Begin
  Inherited Create;
  LancElem:=Nil;
  Valtozas:=False;
  SetLength(BerendArray,0);
  //BerendezesLanc létrehozása
  BerendezesLanc.Init(Self);
End;

//BerendezesLista megszüntetése
Destructor TBerendezesLista.Destroy;
Begin
  //a lánc elemeit sorra megszüntetjük
  Self.Aktualis:=Self.Elso;
  While (Self.Elso <> Nil) Do
  Begin
    Self.Elso:=Self.Aktualis.Kovetkezo;
    Dispose(Self.Aktualis);
    BerendezesLanc.IDCsokkent;
    Self.Aktualis:=Self.Elso;
  End;
  Inherited;
End;

//változás beállítása
Procedure TBerendezesLista.SetValt(Ertek: Boolean);
Begin
  Self.Valt:=Ertek;
End;

//csökkentjük az azonosítók számlálóját
Procedure TBerendezesLanc.IDCsokkent;
Begin
  Dec(Self.IDSzam);
End;

//növeljük az azonosítók számlálóját
Procedure TBerendezesLanc.IDNovel;
Begin
  Inc(Self.IDSzam);
End;

//BerendezesLanc létrehozása
Procedure TBerendezesLanc.Init(BL: TBerendezesLista);
Begin
  With BL Do
  Begin
    New(PBerendezesLanc);
    BerendezesLanc.IDSzam:=0;
    BerendezesLanc.Elso:=Nil;
    BerendezesLanc.Aktualis:=Nil;
  End;
End;

//LancElem létrehozása
Procedure TLancElem.Init(BL: TBerendezesLista; BT: TBerendezesTip; Azon: Integer;
          ObjNev,EpEgys,Nev: String);
Begin
  With BL Do
  Begin
    New(LancElem);
    LancElem.ID:=Azon;
    LancElem.BerendezesTip:=BT;
    LancElem.ObjektumNev:=ObjNev;
    LancElem.EpuletEgyseg:=EpEgys;
    LancElem.BerendezesNev:=Nev;
    LancElem.Kovetkezo:=Nil;
  End;
End;

//üres-e a tömb
Function TBerendezesLista.GetTombUres: Boolean;
Begin
  Result:=High(BerendArray) <= 0;
End;

//a láncban megkeressük a paraméterben szereplõ berendezés nevét
//ha megvan -> True, különben -> False
Function TBerendezesLista.Keres(Nev: String): Boolean;
Var RegiAktualis : PLancElem;
Begin
  Result:=False;
  //ha a lánc nem üres
  If (Self.Elso <> Nil) Then
  Begin
    RegiAktualis:=Self.Aktualis;
    Self.Aktualis:=Self.Elso;
    //amíg nem láncvége és nincs meg
    While ((Self.Aktualis <> Nil) And (Not Result)) Do
    Begin
      Result:=(Self.Aktualis.BerendezesNev = Nev);
      Self.Aktualis:=Self.Aktualis.Kovetkezo;
    End;
    Self.Aktualis:=RegiAktualis;
  End;
End;

//a láncban megkeressük a paraméterben szereplõ berendezés nevét
//ha megvan -> visszaadjuk az azonosítóját, különben -> 0
Function TBerendezesLista.KeresNev(Nev: String): Integer;
Var RegiAktualis : PLancElem;
Begin
  Result:=0;
  //ha a lánc nem üres
  If (Self.Elso <> Nil) Then
  Begin
    RegiAktualis:=Self.Aktualis;
    Self.Aktualis:=Self.Elso;
    //amíg nem láncvége és nincs meg
    While ((Self.Aktualis <> Nil) And (Result = 0)) Do
    Begin
      If (Self.Aktualis.BerendezesNev = Nev) Then Result:=Self.Aktualis.ID;
      Self.Aktualis:=Self.Aktualis.Kovetkezo;
    End;
    Self.Aktualis:=RegiAktualis;
  End;
End;

//a láncban megkeressük a paraméterben szereplõ berendezés azonosítóját
//ha megvan -> visszaadjuk a mutatóját és True-t, különben -> Nil és False
Function TBerendezesLista.KeresID(Const Azon: Integer; Var Mutato: PLancElem): Boolean;
Var RegiAktualis : PLancElem;
Begin
  Mutato:=Nil;
  Result:=False;
  //ha a lánc nem üres
  If (Self.Elso <> Nil) Then
  Begin
    RegiAktualis:=Self.Aktualis;
    Self.Aktualis:=Self.Elso;
    //amíg nem láncvége és nincs meg
    While ((Self.Aktualis <> Nil) And (Not Result)) Do
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

//egy elem törlése a láncból
//ha sikerült -> True, különben -> False
Function TBerendezesLista.Torles(Mut: PLancElem): Boolean;
Var UjMut : PLancElem;
Begin
  Result:=False;
  //ha a lánc nem üres és a paraméter nem Nil
  If (Self.Elso <> Nil) And (Mut <> Nil) Then
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
      //megkeressük az elemet
      While (Self.Aktualis.Kovetkezo <> Mut) And (Self.Aktualis.Kovetkezo <> Nil) Do
        Self.Aktualis:=Self.Aktualis.Kovetkezo;
      //ha megvan
      If (Self.Aktualis.Kovetkezo = Mut) Then
      Begin
        Result:=True;
        UjMut:=Self.Aktualis.Kovetkezo.Kovetkezo;
        Dispose(Self.Aktualis.Kovetkezo);
        Self.Aktualis.Kovetkezo:=UjMut;
      End;
    End;
  End;
  //ha sikerült törölni akkor a Valtozas -> True
  If Result Then Self.Valtozas:=True;
End;

//a láncban megkeressük a paraméterben szereplõ berendezés azonosítóját
//ha sikerült törölni -> True, különben -> False
Function TBerendezesLista.KeresAndTorol(Const Azon: Integer): Boolean;
Var Mut : PLancElem;
Begin
  Result:=False;
  //ha a lánc nem üres és megvan az azonosító
  If (Self.Elso <> Nil) And Self.KeresID(Azon,Mut) Then Result:=Self.Torles(Mut);
End;

//elmegyünk a lánc végére
Procedure TBerendezesLista.Vegere;
Begin
  //ha a lánc nem üres
  If (Self.Elso <> Nil) Then
  Begin
    Self.Aktualis:=Self.Elso;
    While (Self.Aktualis.Kovetkezo <> Nil) Do Self.Aktualis:=Self.Aktualis.Kovetkezo;
  End;
End;

//új elem hozzáfûzése a lánchoz
Procedure TBerendezesLista.Felfuz(BT: TBerendezesTip; ObjNev,EpEgys,Nev: String);
Begin
  //elmegyünk a lánc végére
  Self.Vegere;
  Self.BerendezesLanc.IDNovel;
  //létrehozunk egy új láncelemet
  LancElem.Init(Self,BT,Self.IDSzam,ObjNev,EpEgys,Nev);
  //ha ez az elsõ elem
  If (Self.Elso = Nil) Then Self.Elso:=LancElem
    Else Self.Aktualis.Kovetkezo:=LancElem;
  Self.Aktualis:=LancElem;
  //Valtozas -> True
  Self.Valtozas:=True;
End;

//új elem hozzáfûzése a lánchoz adott azonosítóval
Procedure TBerendezesLista.Felfuz(BT: TBerendezesTip; ObjNev,EpEgys,Nev: String; Azon: Integer);
Begin
  //elmegyünk a lánc végére
  Self.Vegere;
  Self.BerendezesLanc.IDNovel;
  //létrehozunk egy új láncelemet
  LancElem.Init(Self,BT,Azon,ObjNev,EpEgys,Nev);
  //ha ez az elsõ elem
  If (Self.Elso = Nil) Then Self.Elso:=LancElem
    Else Self.Aktualis.Kovetkezo:=LancElem;
  Self.Aktualis:=LancElem;
  //Valtozas -> True
  Self.Valtozas:=True;
End;

//berendezéseket tartalmazó dinamikus tömb feltöltése
Procedure TBerendezesLista.TombFeltolt;
Var I        : Integer;
    RegiHely : Pointer;
Begin
  I:=0;
  //ha a lánc nem üres
  If (Self.Elso <> Nil) Then
  Begin
    RegiHely:=Self.Aktualis;
    //tömb nullázása
    SetLength(BerendArray,0);
    Self.Aktualis:=Self.Elso;
    //végigmegyünk a láncon
    While (Self.Aktualis <> Nil) Do
    Begin
      //tömbméret növelése
      SetLength(Self.BerendArray,I+1);
      //tömbelem feltöltése
      Self.BerendTomb[i,1]:=IntToStr(Self.Aktualis.ID);
      Self.BerendTomb[i,2]:=Self.Aktualis.BerendezesNev;
      Case Self.Aktualis.BerendezesTip Of
        btHomero   : Self.BerendTomb[i,3]:=sHomero;
        btRiaszto  : Self.BerendTomb[i,3]:=sRiaszto;
        btTuzjelzo : Self.BerendTomb[i,3]:=sTuzjelzo;
        btFutotest : Self.BerendTomb[i,3]:=sFutotest;
        btEgyeb    : Self.BerendTomb[i,3]:=sEgyeb;
      End;
      Self.BerendTomb[i,4]:=Self.Aktualis.EpuletEgyseg;
      Self.BerendTomb[i,5]:=Self.Aktualis.ObjektumNev;
      Inc(I);
      Self.Aktualis:=Self.Aktualis.Kovetkezo;
    End;
    Self.Aktualis:=RegiHely;
  End;
End;

End.
