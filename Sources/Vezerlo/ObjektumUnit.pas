//Objektum lánc eljárásai, függvényei
Unit ObjektumUnit;

Interface

Uses Windows,Classes,Forms,ExtCtrls,Graphics,EpuletLancUnit,PontLancUnit,
     SysUtils,ZoomUnit,RajzolasUnit,BerendezesekLancUnit;

Type
  //pontokat tartalmazó dinamikus tömb
  TPontKoordTomb = Array Of TPoint;
  //objektumok tulajdonságait tartalmazó dinamikus tömb
  TObjektumArray = Array Of Array[1..3] Of String;

  //pointerek
  PObjektum     = ^TObjektum;
  PObjektumTip  = ^TObjektumTip;
  PObjektumLanc = ^TObjektumLanc;

  //objektum osztály
  TObjektum = Class(TPersistent)
  Private
    FNev          : String;          //neve
    Pontok        : TPontLista;      //pontjainak lánca
    PontokMasolat : TPontLista;      //pontok másolatának lánca
    EpuletEgysege : PEpuletEgyseg;   //melyik épületegyséhez tartozik
    Function Van_Pont : Boolean;
    Function Get_Pontok : TPontKoordTomb;
    Function Get_PontokMasolat: TPontKoordTomb;
    Procedure SetNev(Const UjNev: String);
    Procedure SetEpEgys(Const PEpEgys: PEpuletEgyseg);
  Public
    Property Nev : String Read FNev Write SetNev;
    Property EpuletEgyseg : PEpuletEgyseg Read EpuletEgysege Write SetEpEgys;
    Property GetPontok : TPontKoordTomb Read Get_Pontok;
    Property GetPontokMasolat : TPontKoordTomb Read Get_PontokMasolat;
    Property VanPont : Boolean Read Van_Pont;
    Procedure PontFelfuz(Const Mit: TPoint);
    Constructor Create(Const Neve: String; Const EpEgys: PEpuletEgyseg);
    Destructor Destroy; Override;
  End;

  //objektum tulajdonságai
  TObjektumTip = Object
    Nev          : String;
    Rajzolas     : Boolean;
    Pontok       : TPontKoordTomb;
    EpuletEgyseg : PEpuletEgyseg;
  End;

  //láncelem
  TObjektumLanc = Object
    ObjMut    : PObjektumTip;
    Kovetkezo : PObjektumLanc;
  End;

  //objektum láncot tartalmazó osztály ( fejelem is )
  TObjektumLista = Class(TPersistent)
  Private
    FValtozas      : Boolean;         //volt-e változtatás
    FEpLista       : TEpuletLista;    //épület lánc
    FObjektumArray : TObjektumArray;  //dinamikus tömb
    FElso          : PObjektumLanc;   //elsõ elemre mutató pointer
    FAktualis      : PObjektumLanc;   //aktuális elemre mutató pointer
    Function GetTombUres : Boolean;
    Function BerendDb(Const BL: TBerendezesLista) : Integer;
    Procedure SetValt(Ertek: Boolean);
  Public
    Property Elso : PObjektumLanc Read FElso Write FElso;
    Property Aktualis : PObjektumLanc Read FAktualis Write FAktualis;
    Property EpLista : TEpuletLista Read FEpLista Write FEpLista;
    Property ObjTomb : TObjektumArray Read FObjektumArray Write FObjektumArray;
    Property Valtozas : Boolean Read FValtozas Write SetValt;
    Property TombUres : Boolean Read GetTombUres;
    Function Torles(Mut: PObjektumLanc) : Boolean;
    Function Konvertal(Const Mit: PObjektum) : PObjektumTip;
    Function Keres(Const Name: String) : Boolean; Overload;
    Function Keres(Const Name: String; Var Mutato: PObjektumLanc) : Boolean; Overload;
    Function KeresAndRaAll(Const Name: String; Var Mutato: PObjektumLanc) : Boolean;
    Function KeresAndTorol(Const Name: String) : Boolean;
    Function PontokKonvertal(Const Tomb: TPontKoordTomb; Const Ertek: Real) : TPontKoordTomb;
    Procedure Vegere;
    Procedure TombFeltolt(Const BerendLista: TBerendezesLista);
    Procedure Felfuz(Const Mit: PObjektum); Overload;
    Procedure Felfuz(Const Neve: String; Const EpEgys: PEpuletEgyseg;
      Const Meret: Integer; Var Mutato: PObjektumLanc); Overload;
    Procedure KiRajzol(Const Form: TForm; Const Image: TImage; Const Zoom: Real);
    Constructor Create(EL : TEpuletLista);
    Destructor Destroy; Override;
  End;

Implementation

//objektum létrehozása
Constructor TObjektum.Create(Const Neve: String; Const EpEgys: PEpuletEgyseg);
Begin
  Inherited Create;
  Self.Nev:=Neve;
  Self.EpuletEgyseg:=EpEgys;
  Self.Pontok:=TPontLista.Create;
  Self.PontokMasolat:=TPontLista.Create;
End;

//objektum megszüntetése
Destructor TObjektum.Destroy;
Begin
  Self.Nev:='';
  Self.EpuletEgyseg:=Nil;
  Self.Pontok.Destroy;
  Self.PontokMasolat.Destroy;
  Inherited;
End;

//visszaadja egy objektum pontjait
Function TObjektum.Get_Pontok: TPontKoordTomb;
Var I : Integer;
Begin
  I:=0;
  //tömb létrehozása
  SetLength(Result,0);
  Self.Pontok.Aktualis:=Self.Pontok.Elso;
  //végigmegyünk az objektum pontjain
  While (Self.Pontok.Aktualis <> Nil) Do
  Begin
    SetLength(Result,I+1);
    //a pontot felvesszük a tömbbe
    Result[i]:=Self.Pontok.Aktualis.Koord;
    Inc(I);
    Self.Pontok.Aktualis:=Self.Pontok.Aktualis.Kovetkezo;
  End;
End;

//visszaadja egy objektum pontjainak a másolatát
Function TObjektum.Get_PontokMasolat: TPontKoordTomb;
Var I : Integer;
Begin
  I:=0;
  //tömb létrehozása
  SetLength(Result,0);
  Self.PontokMasolat.Aktualis:=Self.PontokMasolat.Elso;
  //végigmegyünk az objektum pontjainak a másolatán
  While (Self.PontokMasolat.Aktualis <> Nil) Do
  Begin
    SetLength(Result,I+1);
    //a pontot felvesszük a tömbbe
    Result[i]:=Self.PontokMasolat.Aktualis.Koord;
    Inc(I);
    Self.PontokMasolat.Aktualis:=Self.PontokMasolat.Aktualis.Kovetkezo;
  End;
End;

//üres-e az objektum
//ha nem üres -> True, különben -> False
Function TObjektum.Van_Pont: Boolean;
Begin
  Result:=(Self.Pontok.Elso <> Nil);
End;

//változás esetén beállítjuk
Procedure TObjektumLista.SetValt(Ertek: Boolean);
Begin
  Self.FValtozas:=Ertek;
End;

//egy pont hozzáadása az objektumhoz
Procedure TObjektum.PontFelfuz(Const Mit: TPoint);
Begin
  Self.PontokMasolat.LancraFuz(Mit);
  //a pontot a nagyítás-kicsinyítés arányában vesszük fel
  Self.Pontok.LancraFuz(KoordZoom(Mit,1/Zoom.Szorzo));
End;

//beállítja, hogy melyik épületegységbe tartozik
Procedure TObjektum.SetEpEgys(Const PEpEgys: PEpuletEgyseg);
Begin
  Self.EpuletEgysege:=PEpEgys;
End;

//beállítja az objektum nevét
Procedure TObjektum.SetNev(Const UjNev: String);
Begin
  Self.FNev:=UjNev;
End;

//ObjektumLista létrehozása
Constructor TObjektumLista.Create(EL : TEpuletLista);
Begin
  Inherited Create;
  Self.Elso:=Nil;
  Self.Aktualis:=Self.Elso;
  Self.Valtozas:=False;
  Self.EpLista:=EL;
  SetLength(Self.FObjektumArray,0);
End;

//visszaadja, hogy üres-e a tömb
//ha üres -> True, különben -> False
Function TObjektumLista.GetTombUres: Boolean;
Begin
  Result:=(High(FObjektumArray) <= 0);
End;

//átkonvertálja Objektum típust ObjektumTip típussá
Function TObjektumLista.Konvertal(Const Mit: PObjektum) : PObjektumTip;
Begin
  New(Result);
  With Result^ Do
  Begin
    Nev:=Mit.Nev;
    Pontok:=Mit.GetPontok;
    EpuletEgyseg:=Mit.EpuletEgyseg;
  End;
End;

//egy objektum keresése a neve alapján
//ha megvan -> True, különben -> False
Function TObjektumLista.Keres(Const Name: String): Boolean;
Var RegiObj : PObjektumLanc;
Begin
  Result:=False;
  //ha a lista nem üres
  If (Name <> '') And (Self.Elso <> Nil) Then
  Begin
    RegiObj:=Self.Aktualis;
    Self.Aktualis:=Self.Elso;
    //végig megyünk a láncon
    While ((Self.Aktualis <> Nil) And (Not Result)) Do
      If (Self.Aktualis.ObjMut.Nev = Name) Then Result:=True
      Else Self.Aktualis:=Self.Aktualis.Kovetkezo;
    Self.Aktualis:=RegiObj;
  End;
End;

//egy objektum keresése a neve alapján
//ha megvan -> True és visszaadja a mutatóját is, különben -> False
Function TObjektumLista.Keres(Const Name: String; Var Mutato: PObjektumLanc): Boolean;
Var RegiObj : PObjektumLanc;
Begin
  Mutato:=Nil;
  Result:=False;
  //ha a lista nem üres
  If (Self.Elso <> Nil) Then
  Begin
    RegiObj:=Self.Aktualis;
    Self.Aktualis:=Self.Elso;
    //végig megyünk a láncon
    While (Self.Aktualis <> Nil) And (Not Result) Do
    Begin
      If (Self.Aktualis.ObjMut.Nev = Name) Then
      Begin
        Result:=True;
        Mutato:=Self.Aktualis;
      End;
      Self.Aktualis:=Self.Aktualis.Kovetkezo;
    End;
    Self.Aktualis:=RegiObj;
  End;
End;

//egy objektum keresése a neve alapján
//ha megvan -> True és visszaadja a mutatóját és rá is áll, különben -> False
Function TObjektumLista.KeresAndRaAll(Const Name: String; Var Mutato: PObjektumLanc): Boolean;
Begin
  Mutato:=Nil;
  Result:=False;
  //ha a lista nem üres
  If (Self.Elso <> Nil) Then
    //ha elsõre megvan
    If (Self.Elso.ObjMut.Nev = Name) Then
    Begin
      Result:=True;
      Mutato:=Self.Elso;
    End
    Else Begin
      Self.Aktualis:=Self.Elso;
      //végig megyünk a láncon
      While ((Self.Aktualis <> Nil) And (Result = False)) Do
        If (Self.Aktualis.ObjMut.Nev = Name) Then
        Begin
          Result:=True;
          Mutato:=Self.Aktualis;
        End Else Self.Aktualis:=Self.Aktualis.Kovetkezo;
    End;
End;

//egy objektum keresése a neve alapján és törlése
//ha megvan -> True és töröljük, különben -> False
Function TObjektumLista.KeresAndTorol(Const Name: String): Boolean;
Var Mut : PObjektumLanc;
Begin
  Result:=False;
  If Self.Keres(Name,Mut) Then Result:=Self.Torles(Mut);
End;

//egy objektum törlése
//ha sikerült -> True, különben -> False
Function TObjektumLista.Torles(Mut: PObjektumLanc) : Boolean;
Var UjMut : PObjektumLanc;
Begin
  Result:=False;
  //ha a lista nem üres
  If (Mut <> Nil) And (Self.Elso <> Nil) Then
  Begin
    //ha az elsõt töröljük
    If (Mut = Self.Elso) Then
    Begin
      Result:=True;
      Self.Aktualis:=Self.Elso.Kovetkezo;
      Dispose(Self.Elso.ObjMut);
      Dispose(Self.Elso);
      Self.Elso:=Self.Aktualis;
    End
    //különben
    Else Begin
      Self.Aktualis:=Self.Elso;
      //megkeressük a mutatót
      While (Self.Aktualis.Kovetkezo <> Mut) And (Self.Aktualis.Kovetkezo <> Nil) Do
        Self.Aktualis:=Self.Aktualis.Kovetkezo;
      //ha megvan -> töröljük
      If (Self.Aktualis.Kovetkezo = Mut) Then
      Begin
        Result:=True;
        UjMut:=Self.Aktualis.Kovetkezo.Kovetkezo;
        Dispose(Self.Aktualis.Kovetkezo.ObjMut);
        Dispose(Self.Aktualis.Kovetkezo);
        Self.Aktualis.Kovetkezo:=UjMut;
      End;
    End;
  End;
  //ha sikerült a törlés
  If Result Then Self.Valtozas:=True;
End;

//elmegy a lánc végére
Procedure TObjektumLista.Vegere;
Begin
  Self.Aktualis:=Self.Elso;
  While (Self.Aktualis.Kovetkezo <> Nil) Do Self.Aktualis:=Self.Aktualis.Kovetkezo;
End;

//új objektum felfûzése a láncra konvertálással
Procedure TObjektumLista.Felfuz(Const Mit: PObjektum);
Var LancElem : PObjektumLanc;
Begin
  //létrehozás
  New(LancElem);
  With LancElem^ Do
  Begin
    ObjMut:=Konvertal(Mit);
    Kovetkezo:=Nil;
  End;
  //ha ez lesz az elsõ
  If (Self.Elso = Nil) Then
  Begin
    Self.Elso:=LancElem;
    Self.Aktualis:=Self.Elso;
  End
  //különben
  Else Begin
    Self.Vegere;
    Self.Aktualis.Kovetkezo:=LancElem;
    Self.Aktualis:=LancElem;
  End;
  Self.Valtozas:=True;
End;

//új objektum felfûzése a láncra
Procedure TObjektumLista.Felfuz(Const Neve: String; Const EpEgys: PEpuletEgyseg;
          Const Meret: Integer; Var Mutato: PObjektumLanc);
Var LancElem : PObjektumLanc;
    Obj      : PObjektumTip;
Begin
  //létrehozás
  New(Obj);
  With Obj^ Do
  Begin
    Nev:=Neve;
    Rajzolas:=False;
    SetLength(Pontok,Meret);
    EpuletEgyseg:=EpEgys;
  End;
  //új elem létrehozása
  New(LancElem);
  With LancElem^ Do
  Begin
    ObjMut:=Obj;
    Kovetkezo:=Nil;
  End;
  Mutato:=LancElem;
  //ha ez lesz az elsõ
  If (Self.Elso = Nil) Then
  Begin
    Self.Elso:=LancElem;
    Self.Aktualis:=Self.Elso;
  End
  //különben
  Else Begin
    Self.Vegere;
    Self.Aktualis.Kovetkezo:=LancElem;
    Self.Aktualis:=LancElem;
  End;
  Self.Valtozas:=True;
End;

//ObjektumLista megszüntetése
Destructor TObjektumLista.Destroy;
Begin
  Self.Aktualis:=Self.Elso;
  //végigmegyünk a láncon
  While (Self.Elso <> Nil) Do
  Begin
    Self.Elso:=Self.Aktualis.Kovetkezo;
    With Self.Aktualis.ObjMut^ Do
    Begin
      Nev:='';
      SetLength(Pontok,0);
      EpuletEgyseg:=Nil;
    End;
    Dispose(Self.Aktualis.ObjMut);
    Self.Aktualis.Kovetkezo:=Nil;
    Dispose(Self.Aktualis);
    Self.Aktualis:=Self.Elso;
  End;
  Inherited;
End;

//objektumok kirajzolása
Procedure TObjektumLista.KiRajzol(Const Form: TForm; Const Image: TImage; Const Zoom: Real);
Var RegiBrushStyle : TBrushStyle;
    RegiBrushColor : TColor;
Begin
  With Form Do
  Begin
    //toll mentése
    RegiBrushColor:=Image.Canvas.Brush.Color;
    RegiBrushStyle:=Image.Canvas.Brush.Style;
    //toll beállítása
    Image.Canvas.Brush.Color:=clRed;
    Image.Canvas.Brush.Style:=bsBDiagonal;
    Self.Aktualis:=Self.Elso;
    //végigmegyünk a láncon
    While (Self.Aktualis <> Nil) Do
    Begin
      If (Self.Aktualis.ObjMut.EpuletEgyseg = EpLista.Aktualis) Then
        //kirajzoljuk a poligont
        If (Zoom <> 1) Then
          Image.Canvas.Polygon(Self.PontokKonvertal(Self.Aktualis.ObjMut.Pontok,Zoom))
        Else Image.Canvas.Polygon(Self.Aktualis.ObjMut.Pontok);
      Self.Aktualis:=Self.Aktualis.Kovetkezo;
    End;
    //toll visszaállítása
    Image.Canvas.Brush.Color:=RegiBrushColor;
    Image.Canvas.Brush.Style:=RegiBrushStyle;
  End;
End;

//visszaadja az új méretaránynak megfelelõ pontokat
Function TObjektumLista.PontokKonvertal(Const Tomb: TPontKoordTomb; Const Ertek: Real): TPontKoordTomb;
Var I         : Integer;
    TombHossz : Integer;
Begin
  TombHossz:=Length(Tomb);
  SetLength(Result,TombHossz);
  //a tömb elemein elvégezzük a konvertálást
  For I:=0 To TombHossz-1 Do Result[I]:=KoordZoom(Tomb[I],Ertek);
End;

//visszaadja, hogy mennyi berendezés van az objektumban
Function TObjektumLista.BerendDb(Const BL: TBerendezesLista): Integer;
Var RBerendLanc : PLancElem;
Begin
  Result:=0;
  RBerendLanc:=BL.Aktualis;
  //ha létezik a lánc
  If (BL <> Nil) Then
  Begin
    BL.Aktualis:=BL.Elso;
    //végigmegyünk a láncon
    While (BL.Aktualis <> Nil) Do
    Begin
      If (Self.Aktualis.ObjMut.Nev = BL.Aktualis.ObjektumNev) Then Inc(Result);
      BL.Aktualis:=BL.Aktualis.Kovetkezo;
    End;
    BL.Aktualis:=RBerendLanc;
  End;
End;

//objektum tömb feltöltése
Procedure TObjektumLista.TombFeltolt(Const BerendLista: TBerendezesLista);
Var I        : Integer;
    RegiHely : PObjektumLanc;
Begin
  I:=0;
  RegiHely:=Self.Aktualis;
  //tömb létrehozása
  SetLength(Self.FObjektumArray,0);
  //ha a lánc nem üres
  If (Self.Elso <> Nil) Then
  Begin
    Self.Aktualis:=Self.Elso;
    //végigmegyünk a láncon
    While (Self.Aktualis <> Nil) Do
    Begin
      SetLength(Self.FObjektumArray,I+1);
      Self.ObjTomb[i,1]:=Self.Aktualis.ObjMut.Nev;
      Self.ObjTomb[i,2]:=Self.Aktualis.ObjMut.EpuletEgyseg.EgysegNev;
      Self.ObjTomb[i,3]:=IntToStr(Self.BerendDb(BerendLista));
      Self.Aktualis:=Self.Aktualis.Kovetkezo;
      Inc(I);
    End;
    Self.Aktualis:=RegiHely;
  End;
End;

End.
