//Kijelölt alakzatokat nyilvántartó lánc eljárásai, függvényei
Unit KijelolLancUnit;

Interface

Uses SysUtils, Classes, EpuletLancUnit;

Type
  //pointerek
  PKijelolElem = ^TKijelolElem;
  PKijelolLanc = ^TKijelolLanc;

  //TKijelolLista osztály definiálása
  TKijelolLista = Class;

  //KijelolLanc lánceleme
  TKijelolElem = Object
    Azon           : Integer;       //alakzat azonosító
    AlakzatElemMut : Pointer;       //alakzatra mutató pointer
    Kovetkezo      : PKijelolElem;  //következõ elemre mutató pointer
    Procedure Init(KL : TKijelolLista; DB : Integer);
  End;

  //KijelolLanc fejeleme
  TKijelolLanc = Object
    Db       : Integer;       //mennyi alakzat van a láncban
    Elso     : PKijelolElem;  //a lánc elsõ elemére mutat
    Aktualis : PKijelolElem;  //a lánc aktuális elemére mutat
    Procedure Init(KL : TKijelolLista);
  End;

  //a kijelölt alakzatokat tartalmazó osztály
  TKijelolLista = Class(TPersistent)
    Public
      Masolat     : Boolean;       //van-e másolat
      KijelolLanc : TKijelolLanc;  //fejelem
      Property Elso : PKijelolElem Read KijelolLanc.Elso Write KijelolLanc.Elso;
      Property Aktualis : PKijelolElem Read KijelolLanc.Aktualis Write KijelolLanc.Aktualis;
      Function Ures : Boolean;
      Function AzonKeres(Azon: Integer) : Pointer;
      Procedure Felfuz(Mit: Pointer);
      Procedure MasolatMegszuntet;
      Procedure MasolatKeszit;
      Constructor Create; Virtual;
      Destructor Destroy; Override;
    Private
      KijelolElem  : PKijelolElem;
      MasolatLista : TKijelolLista;
      Function Letrehoz(DT: TDrawingTool; Mutato: Pointer) : Pointer;
  End;

Implementation

//KijelolLista létrehozása
Constructor TKijelolLista.Create;
Begin
  Inherited Create;
  Masolat:=False;
  KijelolElem:=Nil;
  MasolatLista:=Nil;
  //fejelem létrehozása
  KijelolLanc.Init(Self);
End;

//KijelolLista megszüntetése
Destructor TKijelolLista.Destroy;
Begin
  //ha a lánc létezik
  If (Self <> Nil) Then
  Begin
    //másolat megszüntetése
    Self.MasolatMegszuntet;
    //a lánc elemeit sorra megszüntetjük
    Self.KijelolLanc.Aktualis:=Self.KijelolLanc.Elso;
    While (Self.KijelolLanc.Elso <> Nil) Do
    Begin
      Self.KijelolLanc.Elso:=Self.KijelolLanc.Aktualis.Kovetkezo;
      Dispose(Self.KijelolLanc.Aktualis);
      KijelolLanc.Db:=KijelolLanc.Db-1;
      Self.KijelolLanc.Aktualis:=Self.KijelolLanc.Elso;
    End;
    Inherited;
  End;
End;

//láncelem létrehozása
Procedure TKijelolElem.Init(KL : TKijelolLista; DB : Integer);
Begin
  With KL Do
  Begin
    New(KijelolElem);
    KijelolElem.Azon:=DB;
    KijelolElem.AlakzatElemMut:=Nil;
    KijelolElem.Kovetkezo:=Nil;
  End;
End;

//fejelem létrehozása
Procedure TKijelolLanc.Init(KL : TKijelolLista);
Begin
  With KL Do
  Begin
    New(PKijelolLanc);
    KijelolLanc.Db:=0;
    KijelolLanc.Elso:=Nil;
    KijelolLanc.Aktualis:=Nil;
  End;
End;

//üres-e a lánc
//ha üres -> True, különben -> False
Function TKijelolLista.Ures: Boolean;
Begin
  Result:=(KijelolLanc.Elso = Nil);
End;

//elem felfûzése a láncra
Procedure TKijelolLista.Felfuz(Mit : Pointer);
Begin
  //ha a lánc létezik és van mit felfûzni
  If (Self <> Nil) And (Mit <> Nil) Then
  Begin
    KijelolLanc.Db:=KijelolLanc.Db+1;
    KijelolElem.Init(Self,KijelolLanc.Db);
    KijelolElem.AlakzatElemMut:=Mit;
    KijelolElem.Kovetkezo:=Nil;
    If (Self.KijelolLanc.Elso = Nil) Then Self.KijelolLanc.Elso:=KijelolElem
      Else Self.KijelolLanc.Aktualis.Kovetkezo:=KijelolElem;
    Self.KijelolLanc.Aktualis:=KijelolElem;
  End;
End;

//másolat létrehozása
//visszaadja a létrehozott alakzat mutatóját
Function TKijelolLista.Letrehoz(DT : TDrawingTool; Mutato : Pointer) : Pointer;
Begin
  Case DT Of
    dtVonal     : Begin
                    New(Vonal);
                    Vonal.Szog:=PVonalAlakzat(Mutato)^.Szog;
                    Vonal.Tipus:=PVonalAlakzat(Mutato)^.Tipus;
                    Vonal.PenMeret:=PVonalAlakzat(Mutato)^.PenMeret;
                    Vonal.PenStyle:=PVonalAlakzat(Mutato)^.PenStyle;
                    Vonal.PenColor:=PVonalAlakzat(Mutato)^.PenColor;
                    Vonal.Koord[1]:=PVonalAlakzat(Mutato)^.Koord[1];
                    Vonal.Koord[2]:=PVonalAlakzat(Mutato)^.Koord[2];
                    Result:=Vonal;
                  End;
    dtNegyzet   : Begin
                    New(Negyzet);
                    Negyzet.Szog:=PNegyzetAlakzat(Mutato)^.Szog;
                    Negyzet.Tipus:=PNegyzetAlakzat(Mutato)^.Tipus;
                    Negyzet.PenMeret:=PNegyzetAlakzat(Mutato)^.PenMeret;
                    Negyzet.PenStyle:=PNegyzetAlakzat(Mutato)^.PenStyle;
                    Negyzet.PenColor:=PNegyzetAlakzat(Mutato)^.PenColor;
                    Negyzet.Koord[1]:=PNegyzetAlakzat(Mutato)^.Koord[1];
                    Negyzet.Koord[2]:=PNegyzetAlakzat(Mutato)^.Koord[2];
                    Negyzet.Koord[3]:=PNegyzetAlakzat(Mutato)^.Koord[3];
                    Negyzet.Koord[4]:=PNegyzetAlakzat(Mutato)^.Koord[4];
                    Result:=Negyzet;
                  End;
    dtEllipszis : Begin
                    New(Ellipszis);
                    Ellipszis.Szog:=PEllipszisAlakzat(Mutato)^.Szog;
                    Ellipszis.Tipus:=PEllipszisAlakzat(Mutato)^.Tipus;
                    Ellipszis.PenMeret:=PEllipszisAlakzat(Mutato)^.PenMeret;
                    Ellipszis.PenStyle:=PEllipszisAlakzat(Mutato)^.PenStyle;
                    Ellipszis.PenColor:=PEllipszisAlakzat(Mutato)^.PenColor;
                    Ellipszis.A:=PEllipszisAlakzat(Mutato)^.A;
                    Ellipszis.B:=PEllipszisAlakzat(Mutato)^.B;
                    Ellipszis.Kozep.X:=PEllipszisAlakzat(Mutato)^.Kozep.X;
                    Ellipszis.Kozep.Y:=PEllipszisAlakzat(Mutato)^.Kozep.Y;
                    Result:=Ellipszis;
                  End;
    dtAjto      : Begin
                    New(Ajto);
                    Ajto.Szog:=PAjtoAlakzat(Mutato)^.Szog;
                    Ajto.Tipus:=PAjtoAlakzat(Mutato)^.Tipus;
                    Ajto.PenMeret:=PAjtoAlakzat(Mutato)^.PenMeret;
                    Ajto.PenStyle:=PAjtoAlakzat(Mutato)^.PenStyle;
                    Ajto.PenColor:=PAjtoAlakzat(Mutato)^.PenColor;
                    Ajto.Koord[1]:=PAjtoAlakzat(Mutato)^.Koord[1];
                    Ajto.Koord[2]:=PAjtoAlakzat(Mutato)^.Koord[2];
                    Ajto.Koord[3]:=PAjtoAlakzat(Mutato)^.Koord[3];
                    Ajto.Koord[4]:=PAjtoAlakzat(Mutato)^.Koord[4];
                    Result:=Ajto;
                  End;
    dtAblak     : Begin
                    New(Ablak);
                    Ablak.Szog:=PAblakAlakzat(Mutato)^.Szog;
                    Ablak.Tipus:=PAblakAlakzat(Mutato)^.Tipus;
                    Ablak.PenMeret:=PAblakAlakzat(Mutato)^.PenMeret;
                    Ablak.PenStyle:=PAblakAlakzat(Mutato)^.PenStyle;
                    Ablak.PenColor:=PAblakAlakzat(Mutato)^.PenColor;
                    Ablak.Koord[1]:=PAblakAlakzat(Mutato)^.Koord[1];
                    Ablak.Koord[2]:=PAblakAlakzat(Mutato)^.Koord[2];
                    Ablak.Koord[3]:=PAblakAlakzat(Mutato)^.Koord[3];
                    Ablak.Koord[4]:=PAblakAlakzat(Mutato)^.Koord[4];
                    Result:=Ablak;
                  End;
    Else Result:=Nil;
  End;
End;

//megkeresünk egy kijelölt elemet a másolatok közt
Function TKijelolLista.AzonKeres(Azon: Integer) : Pointer;
Var Mut         : Pointer; //alakzatra mutató pointer
    Megvan      : Boolean; //sikeres keresés
    MasolatAzon : Integer; //alakzat azonosítója
Begin
  Megvan:=False;
  Result:=Nil;
  //ha a láncok léteznek
  If (Self <> Nil) And (Self.MasolatLista <> Nil) And (Self.MasolatLista <> Nil) Then
  Begin
    //végigmegyünk a láncon, amíg meg nem találjuk
    Self.MasolatLista.KijelolLanc.Aktualis:=Self.MasolatLista.KijelolLanc.Elso;
    While ((Self.MasolatLista.KijelolLanc.Aktualis <> Nil) And (Not Megvan)) Do
    Begin
      Mut:=Self.MasolatLista.KijelolLanc.Aktualis^.AlakzatElemMut;
      MasolatAzon:=Self.MasolatLista.KijelolLanc.Aktualis.Azon;
      //ha megvan amit kerestünk
      If (Azon = MasolatAzon) Then
      Begin
        //kilépési feltétel igaz
        Megvan:=True;
        //a keresett elem címe
        Result:=Mut;
      End;
      Self.MasolatLista.KijelolLanc.Aktualis:=Self.MasolatLista.KijelolLanc.Aktualis.Kovetkezo;
    End;
  End;
End;

//KijelolLista láncról másolatot készít
Procedure TKijelolLista.MasolatKeszit;
Var Mutato     : Pointer;
    AlakMutato : Pointer;
    AlakTipus  : TDrawingTool;
Begin
  //ha a lánc létezik
  If (Self <> Nil) Then
  Begin
    Self.Masolat:=True;
    //ha létezik másolat, akkor megszüntetjük
    If (Self.MasolatLista <> Nil) Then Self.MasolatMegszuntet;
    Self.MasolatLista:=TKijelolLista.Create;
    //végig megyünk a láncon
    Self.KijelolLanc.Aktualis:=Self.KijelolLanc.Elso;
    While (Self.KijelolLanc.Aktualis <> Nil) Do
    Begin
      Mutato:=PAlakzatElem(Self.KijelolLanc.Aktualis.AlakzatElemMut)^.AlakMut;
      AlakTipus:=PAlakzatElem(Self.KijelolLanc.Aktualis.AlakzatElemMut)^.Tipus;
      AlakMutato:=Letrehoz(AlakTipus,Mutato);
      //felfûzzük a másolatot
      Self.MasolatLista.Felfuz(AlakMutato);
      Self.KijelolLanc.Aktualis:=Self.KijelolLanc.Aktualis.Kovetkezo;
    End;
  End;
End;

//a másolat megszüntetése
Procedure TKijelolLista.MasolatMegszuntet;
Var Mutato    : Pointer;
    AlakTipus : TDrawingTool;
Begin
  //ha a láncok léteznek
  If (Self <> Nil) And (Self.MasolatLista <> Nil) Then
  Begin
    Self.Masolat:=False;
    //a lánc elemeit sorra megszüntetjük
    Self.MasolatLista.KijelolLanc.Aktualis:=Self.MasolatLista.KijelolLanc.Elso;
    While (Self.MasolatLista.KijelolLanc.Elso <> Nil) Do
    Begin
      Self.MasolatLista.KijelolLanc.Elso:=Self.MasolatLista.KijelolLanc.Aktualis.Kovetkezo;
      Mutato:=PAlakzatElem(Self.MasolatLista.KijelolLanc.Aktualis.AlakzatElemMut)^.AlakMut;
      AlakTipus:=PAlakzatElem(Self.MasolatLista.KijelolLanc.Aktualis.AlakzatElemMut)^.Tipus;
      Try
        Case AlakTipus Of
          dtVonal     : Dispose(PVonalAlakzat(Mutato));
          dtNegyzet   : Dispose(PNegyzetAlakzat(Mutato));
          dtEllipszis : Dispose(PEllipszisAlakzat(Mutato));
          dtAjto      : Dispose(PAjtoAlakzat(Mutato));
          dtAblak     : Dispose(PAblakAlakzat(Mutato));
        End;
        Dispose(Self.MasolatLista.KijelolLanc.Aktualis);
        Self.MasolatLista.KijelolLanc.Db:=Self.MasolatLista.KijelolLanc.Db-1;
      Except
        On EInvalidPointer Do ;
      End;
      Self.MasolatLista.KijelolLanc.Aktualis:=Self.MasolatLista.KijelolLanc.Elso;
    End;
    FreeAndNil(Self.MasolatLista);
  End;
End;

End.
