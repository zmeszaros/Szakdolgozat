//Pontokat tartalmazó lánc eljárásai, függvényei
Unit PontLancUnit;

Interface

Uses Windows,Classes;

Type
  //pointerek
  PPontElemTip = ^TPontElemTip;
  PPontLancTip = ^TPontLancTip;

  //osztály definiálása
  TPontLista = Class;

  //láncelem
  TPontElemTip = Object
    Koord     : TPoint;
    Kovetkezo : PPontElemTip;
    Procedure Init(Const PL: TPontLista; Const P: TPoint);
  End;

  //fejelem
  TPontLancTip = Object
    Db       : Integer;
    Elso     : PPontElemTip;
    Aktualis : PPontElemTip;
    Procedure Init(Const PL: TPontLista);
  End;

  //PontLista osztály
  TPontLista = Class(TPersistent)
  Private
    PontElem : PPontElemTip;   //egy pontra mutató pointer
    PontLanc : TPontLancTip;   //fejelem
  Public
    Property Db : Integer Read PontLanc.Db;
    Property Elso : PPontElemTip Read PontLanc.Elso Write PontLanc.Elso;
    Property Aktualis : PPontElemTip Read PontLanc.Aktualis Write PontLanc.Aktualis;
    Constructor Create;
    Destructor Destroy; Override;
    Procedure LancraFuz(Const Pont: TPoint);
  End;

Implementation

//lánc létrehozása
Constructor TPontLista.Create;
Begin
  Inherited Create;
  Self.PontElem:=Nil;
  Self.PontLanc.Init(Self);
End;

//lánc megszüntetése
Destructor TPontLista.Destroy;
Begin
  If (Self <> Nil) Then
  Begin
    Self.PontLanc.Aktualis:=Self.PontLanc.Elso;
    //megszünteti az összes pontot
    While (Self.PontLanc.Elso <> Nil) Do
    Begin
      Self.PontLanc.Elso:=Self.PontLanc.Aktualis.Kovetkezo;
      Dispose(Self.PontLanc.Aktualis);
      Self.PontLanc.Db:=Self.PontLanc.Db-1;
      Self.PontLanc.Aktualis:=Self.PontLanc.Elso;
    End;
    Self.PontElem:=Nil;
  End;
  Inherited;
End;

//láncelem létrehozása
Procedure TPontElemTip.Init(Const PL: TPontLista; Const P: TPoint);
Begin
  With PL Do
  Begin
    New(PontElem);
    PontElem.Koord:=P;
    PontElem.Kovetkezo:=Nil;
  End;
End;

//fejelem inicializálása
Procedure TPontLancTip.Init(Const PL: TPontLista);
Begin
  With PL Do
  Begin
    PontLanc.Db:=0;
    PontLanc.Elso:=Nil;
    PontLanc.Aktualis:=Nil;
  End;
End;

//egy pont felfûzése a láncra
Procedure TPontLista.LancraFuz(Const Pont : TPoint);
Begin
  //láncelem létrehozása
  Self.PontElem.Init(Self,Pont);
  Self.PontLanc.Db:=Self.PontLanc.Db+1;
  //ha ez lesz az elsõ
  If (Self.PontLanc.Elso = Nil) Then
  Begin
    Self.PontLanc.Elso:=Self.PontElem;
    Self.PontLanc.Aktualis:=Self.PontLanc.Elso;
  End
  //különben
  Else Self.PontLanc.Aktualis.Kovetkezo:=Self.PontElem;
  Self.PontLanc.Aktualis:=Self.PontElem;
End;

End.
