//Épület szerkezetét tartalmazó láncok
Unit EpuletLancUnit;

Interface

Uses Windows, Classes, SysUtils, Graphics;

Type
  //rajzolás típusa, alakzat típusa
  TDrawingTool = (dtNyil,dtVonal,dtNegyzet,dtEllipszis,dtIv,dtAjto,dtAblak,
                  dtFal,dtKijelol,dtMeretez,dtMozgatas,dtPoligon,dtObjektum);

  //pointerek
  PAjtoAlakzat      = ^TAjtoAlakzat;
  PAblakAlakzat     = ^TAblakAlakzat;
  PVonalAlakzat     = ^TVonalAlakzat;
  PNegyzetAlakzat   = ^TNegyzetAlakzat;
  PEllipszisAlakzat = ^TEllipszisAlakzat;

  PEpuletLanc       = ^TEpuletLanc;
  PEpuletLista      = ^TEpuletLista;
  PEpuletEgyseg     = ^TEpuletEgyseg;
  PAlakzatLanc      = ^TAlakzatLanc;
  PAlakzatElem      = ^TAlakzatElem;

  //EpuletLista osztály definiálása
  TEpuletLista = Class;

  //egy alakzat alaptulajdonságai
  TAlakzatTip = Object
    Szog     : Integer;       //elforgatás szöge
    Tipus    : TDrawingTool;  //alakzat típusa
    PenStyle : TPenStyle;     //toll stílusa
    PenColor : TColor;        //toll színe
    PenMeret : Integer;       //toll vastagsága
  End;

  //vonal alakzat tulajdonságai
  TVonalAlakzat = Object(TAlakzatTip)
    Koord : Array[1..2] Of TPoint; //vonal alakzat koordinátái
  End;

  //négyzet alakzat tulajdonságai
  TNegyzetAlakzat = Object(TAlakzatTip)
    Koord : Array[1..4] Of TPoint; //négyzet alakzat koordinátái
  End;

  //ellipszis alakzat tulajdonságai
  TEllipszisAlakzat = Object(TVonalAlakzat)
    A     : Double; //magasság sugár
    B     : Double; //szélesség sugár
    Kozep : TPoint; //középpont
  End;

  //ajtó alakzat
  TAjtoAlakzat  = TNegyzetAlakzat;
  //ablak alakzat
  TAblakAlakzat = TNegyzetAlakzat;

  //AlakzatLanc egy eleme
  TAlakzatElem = Object
    Tipus     : TDrawingTool;  //alakzat típusa
    AlakMut   : Pointer;       //alakzatra mutató pointer
    Kovetkezo : PAlakzatElem;  //következõ alakzatra mutató pointer
    Constructor Create;
  End;

  //AlakzatLanc fejeleme
  TAlakzatLanc = Object
    Elso     : PAlakzatElem;   //elsõ alakzatra mutató pointer
    Aktualis : PAlakzatElem;   //aktuális alakzatra mutató pointer
    Constructor Create;
    Destructor Destroy;
    Procedure LancVegere;
    Procedure LancraFuz(EpLista: TEpuletLista; Mutato: Pointer; DT: TDrawingTool);
  End;

  //EpuletLanc egy eleme
  TEpuletEgyseg = Object
    EgysegNev         : String;        //melyik épületegységhez tartozik
    AlakzatLancMutato : PAlakzatLanc;  //AlakzatLanc-ra mutató pointer
    Elozo             : PEpuletEgyseg; //elõzõ épületegység-re mutató pointer
    Kovetkezo         : PEpuletEgyseg; //következõ épületegység-re mutató pointer
    Constructor Create;
  End;

  //épület szerkezeti tulajdonságai ( fejelem )
  TEpuletLanc = Object
    Nev         : String;              //épület neve
    EpuletMeret : Integer;             //mérete
    EgysegMeret : Extended;            //méretarány
    Elso        : PEpuletEgyseg;       //elsõ épületegység-re mutató pointer
    Aktualis    : PEpuletEgyseg;       //aktuális épületegység-re mutató pointer
    Procedure Create(EL: TEpuletLista);
  End;

  //épület szerkezeti tulajdonságait tartalmazó osztály
  TEpuletLista = Class(TPersistent)
  Private
    FValtozas  : Boolean;              //volt-e változás
    EpuletLanc : TEpuletLanc;          //EpuletLanc-ra mutató pointer
    Procedure SetNev(Ertek: String);
    Procedure SetValt(Ertek: Boolean);
    Procedure SetEpuletMeret(Ertek: Integer);
    Procedure SetEgysegMeret(Ertek: Extended);
  Public
    Property Elso : PEpuletEgyseg Read EpuletLanc.Elso Write EpuletLanc.Elso;
    Property Aktualis : PEpuletEgyseg Read EpuletLanc.Aktualis Write EpuletLanc.Aktualis;
    Property Valtozas : Boolean Read FValtozas Write SetValt;
    Property Nev : String Read EpuletLanc.Nev Write SetNev;
    Property EpuletMeret : Integer Read EpuletLanc.EpuletMeret Write SetEpuletMeret;
    Property EgysegMeret : Extended Read EpuletLanc.EgysegMeret Write SetEgysegMeret;
    Function EpuletUres : Boolean;
    Function EgysegUres(Const Nev: String) : Boolean;
    Function EgysegKeresNev(Const Nev: String) : Boolean; Overload;
    Function EgysegKeresNev(Const Nev: String; Var AlakLanc: PAlakzatLanc;
             Var EpEgyseg: PEpuletEgyseg) : Boolean; Overload;
    Constructor Create;
    Destructor Destroy; Override;
  End;

//alakzatok deklarálása
Var Ajto         : PAjtoAlakzat;
    Ablak        : PAblakAlakzat;
    Vonal        : PVonalAlakzat;
    Negyzet      : PNegyzetAlakzat;
    Ellipszis    : PEllipszisAlakzat;
    AlakzatLanc  : PAlakzatLanc;
    AlakzatElem  : PAlakzatElem;
    EpuletEgyseg : PEpuletEgyseg;

Implementation

//új AlakzatElem létrehozása
Constructor TAlakzatElem.Create;
Begin
  New(AlakzatElem);
  AlakzatElem.Tipus:=dtNyil;
  AlakzatElem.AlakMut:=Nil;
  AlakzatElem.Kovetkezo:=Nil;
End;

//új AlakzatLanc létrehozása
Constructor TAlakzatLanc.Create;
Begin
  New(AlakzatLanc);
  AlakzatLanc.Elso:=Nil;
  AlakzatLanc.Aktualis:=Nil;
End;

//AlakzatLanc megszüntetése
Destructor TAlakzatLanc.Destroy;
Var Mutato    : Pointer;
    AlakTipus : TDrawingTool;
Begin
  Self.Aktualis:=Self.Elso;
  //a lánc elemeit sorra megszüntetjük
  While (Self.Elso <> Nil) Do
  Begin
    Self.Elso:=Self.Aktualis.Kovetkezo;
    Mutato:=PAlakzatElem(Self.Aktualis)^.AlakMut;
    AlakTipus:=PAlakzatElem(Self.Aktualis)^.Tipus;
    Try
      Case AlakTipus Of
        dtVonal     : Dispose(PVonalAlakzat(Mutato));
        dtNegyzet   : Dispose(PNegyzetAlakzat(Mutato));
        dtEllipszis : Dispose(PEllipszisAlakzat(Mutato));
        dtAjto      : Dispose(PAjtoAlakzat(Mutato));
        dtAblak     : Dispose(PAblakAlakzat(Mutato));
      End;
    Except
      On EInvalidPointer Do ;
    End;
    Self.Aktualis:=Self.Elso;
  End;
  Dispose(AlakzatLanc);
End;

//elmegyünk a lánc végére
Procedure TAlakzatLanc.LancVegere;
Begin
  //ha a lánc létezik és nem üres
  If (Self.Elso <> Nil) Then
  Begin
    Self.Aktualis:=Self.Elso;
    While (Self.Aktualis.Kovetkezo <> Nil) Do Self.Aktualis:=Self.Aktualis.Kovetkezo;
  End;
End;

//új alakzat felfûzése a láncra
Procedure TAlakzatLanc.LancraFuz(EpLista: TEpuletLista; Mutato: Pointer; DT: TDrawingTool);
Begin
  //láncelem létrehozása
  AlakzatElem.Create;
  AlakzatElem.Tipus:=DT;
  AlakzatElem.AlakMut:=Mutato;
  AlakzatElem.Kovetkezo:=Nil;
  //ha elsõ lesz
  If (AlakzatLanc.Elso = Nil) Then
  Begin
    AlakzatLanc.Elso:=AlakzatElem;
    AlakzatLanc.Aktualis:=AlakzatLanc.Elso;
  End
  Else
  Begin
    AlakzatLanc.LancVegere;
    AlakzatLanc.Aktualis.Kovetkezo:=AlakzatElem;
  End;
  AlakzatLanc.Aktualis:=AlakzatElem;
  EpLista.Valtozas:=True;
End;

//EpuletEgyseg létrehozása
Constructor TEpuletEgyseg.Create;
Begin
  New(EpuletEgyseg);
  EpuletEgyseg.EgysegNev:='';
  EpuletEgyseg.AlakzatLancMutato:=Nil;
  EpuletEgyseg.Elozo:=Nil;
  EpuletEgyseg.Kovetkezo:=Nil;
End;

//EpuletLista létrehozása
Constructor TEpuletLista.Create;
Begin
  Inherited Create;
  Self.EpuletLanc.Nev:='';
  Self.Valtozas:=False;
  Self.EpuletLanc.EpuletMeret:=0;
  Self.EpuletLanc.EgysegMeret:=0;
  Self.Elso:=Nil;
  Self.Aktualis:=Nil;
End;

//EpuletLista megszüntetése
Destructor TEpuletLista.Destroy;
Begin
  //ha a lánc létezik és nem üres
  If (Self <> Nil) And (Not Self.EpuletUres) Then
  Begin
    Self.Aktualis:=Self.Elso;
    While (Self.Elso <> Nil) Do
    Begin
      Self.Elso:=Self.Aktualis.Kovetkezo;
      AlakzatLanc:=Self.Aktualis.AlakzatLancMutato;
      //épületláncok megszüntetése
      If (AlakzatLanc <> Nil) Then AlakzatLanc.Destroy;
      Self.Aktualis:=Self.Elso;
    End;
  End;
  Inherited;
End;

//üres-e az EpuletLista
//ha üres -> True, különben -> False
Function TEpuletLista.EpuletUres: Boolean;
Begin
  Result:=PEpuletLanc(@Self.EpuletLanc) = Nil;
End;

//méretarány beállítása
Procedure TEpuletLista.SetEgysegMeret(Ertek: Extended);
Begin
  Self.EpuletLanc.EgysegMeret:=Ertek;
End;

//épületméret beállítása
Procedure TEpuletLista.SetEpuletMeret(Ertek: Integer);
Begin
  Self.EpuletLanc.EpuletMeret:=Ertek;
End;

//épületnév beállítása
Procedure TEpuletLista.SetNev(Ertek: String);
Begin
  Self.EpuletLanc.Nev:=Ertek;
End;

//változott-e az EpuletLista
Procedure TEpuletLista.SetValt(Ertek: Boolean);
Begin
  Self.FValtozas:=Ertek;
End;

//EpuletLanc létrehozása
Procedure TEpuletLanc.Create(EL: TEpuletLista);
Begin
  With EL Do
  Begin
    New(PEpuletLanc);
    EpuletLanc.Nev:='';
    EpuletLanc.EpuletMeret:=0;
    EpuletLanc.EgysegMeret:=0;
    EpuletLanc.Elso:=Nil;
    EpuletLanc.Aktualis:=Nil;
  End;
End;

//a láncban megkeressük a paraméterben szereplõ épületegység nevét
//ha megvan -> True és rá is állunk, különben -> False
Function TEpuletLista.EgysegKeresNev(Const Nev: String) : Boolean;
Var RegiEgyseg : PEpuletEgyseg;
Begin
  Result:=False;
  //ha a lánc létezik és nem üres
  If (Self <> Nil) And (Not Self.EpuletUres) Then
  Begin
    RegiEgyseg:=Self.Aktualis;
    Self.Aktualis:=Self.Elso;
    While (Self.Aktualis <> Nil) And (Not Result) Do
    Begin
      Result:=(Self.Aktualis.EgysegNev = Nev);
      If (Not Result) Then Self.Aktualis:=Self.Aktualis.Kovetkezo;
    End;
    If (Not Result) Then Self.Aktualis:=RegiEgyseg;
  End;
End;

//a láncban megkeressük a paraméterben szereplõ épületegység nevét
//ha megvan -> True és visszaadjuk az AlakzatLanc,EpuletEgyseg címét, különben -> False
Function TEpuletLista.EgysegKeresNev(Const Nev: String; Var AlakLanc: PAlakzatLanc;
         Var EpEgyseg: PEpuletEgyseg) : Boolean;
Var RegiEgyseg : PEpuletEgyseg;
Begin
  AlakLanc:=Nil;
  EpEgyseg:=Nil;
  Result:=False;
  //ha a lánc létezik és nem üres
  If (Self <> Nil) And (Not Self.EpuletUres) Then
  Begin
    RegiEgyseg:=Self.Aktualis;
    Self.Aktualis:=Self.Elso;
    While (Self.Aktualis <> Nil) And (Not Result) Do
    Begin
      If (Self.Aktualis.EgysegNev = Nev) Then
      Begin
        Result:=True;
        AlakLanc:=Self.Aktualis.AlakzatLancMutato;
        EpEgyseg:=Self.Aktualis;
      End;
      If (Not Result) Then Self.Aktualis:=Self.Aktualis.Kovetkezo;
    End;
    If (Not Result) Then Self.Aktualis:=RegiEgyseg;
  End;
End;

//üres-e a paraméterben átadott épületegység
//ha nem üres -> True, külöben False
Function TEpuletLista.EgysegUres(Const Nev: String): Boolean;
Var RegiEpLanc : PEpuletEgyseg;
Begin
  Result:=False;
  //ha a lánc létezik és nem üres
  If (Self <> Nil) And (Self.Elso <> Nil) Then
  Begin
    RegiEpLanc:=Self.Aktualis;
    Self.Aktualis:=Self.Elso;
    While (Self.Aktualis <> Nil) And (Not Result) Do
    Begin
      AlakzatLanc:=Self.Aktualis.AlakzatLancMutato;
      Result:=(AlakzatLanc.Elso <> Nil) And (Nev = Self.Aktualis.EgysegNev);
      Self.Aktualis:=Self.Aktualis.Kovetkezo;
    End;
    Self.Aktualis:=RegiEpLanc;
  End;
End;

End.

