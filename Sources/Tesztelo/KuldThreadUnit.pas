//Kommunikációhoz szükséges eljárások, függvények
Unit KuldThreadUnit;

Interface

Uses Classes, ExtCtrls, SysUtils, StdCtrls, SyncObjs, ComCtrls, Graphics,
     Forms, CPort;

//üzenetek típusa
Const rKapcsVege = #1;      //kapcsolat vége
      rNyugta    = #2;      //üzenetet megkaptam
      rHiba      = #3;      //hiba az átvilelben
      rKapcsKer  = #13;     //kapcsolat létrehozása
      rKapcsKesz = 'OK';    //kapcsolat létrejött
      sHatJel    = '|';     //üzeneteket elválasztó jel

Type
  //szöveg jellemzõi
  TTextAttrib = Object
    Color  : TColor;   //szín
    Height : Integer;  //méret
  End;

  //pointerek
  PUzenetElem  = ^TUzenetElem;
  PUzenetLanc  = ^TUzenetLanc;
  PUzenetLista = ^TUzenetLista;
  TUzenetLista = Class;

  //láncelem
  TUzenetElem = Object
    Prior     : Boolean;       //üzenet prioritása
    Uzenet    : String;        //üzenet
    Szoveg    : String;        //üzenethez kapcsolódó kiírandó szöveg
    Kovetkezo : PUzenetElem;   //következõ elemre mutat
    Attrib    : TTextAttrib;   //szöveg jellemzõje
    Procedure Init(UL: TUzenetLista; P: Boolean; Uz: String); Overload;
    Procedure Init(UL: TUzenetLista; P: Boolean; Uz,Szov: String; Atb: TTextAttrib); Overload;
  End;

  //fejelem
  TUzenetLanc = Object
    Elso     : PUzenetElem;   //elsõ elemre mutat
    Aktualis : PUzenetElem;   //aktuális elemre mutat
    Procedure Init(UL: TUzenetLista);
  End;

  //üzenetláncot tartalmazó típus
  TUzenetLista = Class(TPersistent)
  Private
    Form       : TForm;        //fõform
    ListBox    : TListBox;     //fõformon található listbox
    FMasolat   : PUzenetElem;  //egy üzenet másolata
    UzenetElem : PUzenetElem;  //egy láncelemre mutat
    UzenetLanc : TUzenetLanc;  //üzenetláncra mutat
    Procedure Fuz(UzElem: PUzenetElem);
  Public
    Property Masolat : PUzenetElem Read FMasolat;
    Property Elso : PUzenetElem Read UzenetLanc.Elso Write UzenetLanc.Elso;
    Property Aktualis : PUzenetElem Read UzenetLanc.Aktualis Write UzenetLanc.Aktualis;
    Function Torles : Boolean;
    Function MasolatTorles : Boolean;
    Function MasolAndTorles : Boolean;
    Function Ures : Boolean;
    Procedure Vegere;
    Procedure Felfuz(P: Boolean; Str: String); Overload;
    Procedure Felfuz(P: Boolean; Str,Szov: String; Atb: TTextAttrib); Overload;
    Constructor Create; Overload;
    Constructor Create(F: TForm; LB: TListBox); Overload;
    Destructor Destroy; Override;
  End;

  //kommunikációs csatorna állapota
  PPortAllapot =^TPortAllapot;
  TPortAllapot = Object
    Szabad : Boolean;     //lehet-e küldeni adatot
  End;

  //az üzenetek küldéséért felelõs szál
  TKuldThread = Class(TThread)
  Private
    FMemo          : TRichEdit;     //fõformon található richedit
    FUzenet        : String;        //üzenet
    FSzoveg        : String;        //kiírandó szöveg
    FAttrib        : TTextAttrib;   //szöveg jellemzõje
    FKuldhet       : Boolean;       //lehet-e küldeni
    FComPort       : TComPort;      //comport komponens
    FUzenetHossz   : Integer;       //mennyi értékbõl áll az üzenet
    FUzenetLista   : PUzenetLista;  //üzenetláncra mutat
    FPortAllapot   : PPortAllapot;  //kommunikációs csatorna állapota
    Procedure Kiir;
    Procedure UzenetKuld;
  Protected
    Procedure Execute; Override;
  Public
    Property Kuldhet : Boolean Read FKuldhet Write FKuldhet;
    Constructor Create(CP: TComPort; PA: PPortAllapot; UL: PUzenetLista; Mem: TRichEdit);
    Destructor Destroy; Override;
  End;

  Function MemoIdo : String;

Implementation

//visszaadja a lekérdezés idõpontját stringben
Function MemoIdo : String;
Begin
  Result:='['+TimeToStr(Time)+'] - ';
End;

//láncelem létrehozása
Procedure TUzenetElem.Init(UL: TUzenetLista; P: Boolean; Uz: String);
Begin
  With UL Do
  Begin
    New(UzenetElem);
    UzenetElem.Prior:=P;
    UzenetElem.Uzenet:=Uz;
    UzenetElem.Szoveg:='';
    UzenetElem.Attrib.Color:=clNone;
    UzenetElem.Kovetkezo:=Nil;
  End;
End;

//láncelem létrehozása
Procedure TUzenetElem.Init(UL: TUzenetLista; P: Boolean; Uz,Szov: String; Atb: TTextAttrib);
Begin
  With UL Do
  Begin
    New(UzenetElem);
    UzenetElem.Prior:=P;
    UzenetElem.Attrib:=Atb;
    UzenetElem.Uzenet:=Uz;
    UzenetElem.Szoveg:=Szov;
    UzenetElem.Kovetkezo:=Nil;
  End;
End;

//fejelem létrehozása
Procedure TUzenetLanc.Init(UL: TUzenetLista);
Begin
  With UL Do
  Begin
    New(PUzenetLanc);
    UzenetLanc.Elso:=Nil;
    UzenetLanc.Aktualis:=Nil;
  End;
End;

//üzenetláncot tartalmazó típus létrehozása
Constructor TUzenetLista.Create;
Begin
  Inherited Create;
  Self.Form:=Nil;
  Self.ListBox:=Nil;
  Self.FMasolat:=Nil;
  Self.UzenetElem:=Nil;
  Self.UzenetLanc.Init(Self);
End;

//üzenetláncot tartalmazó típus létrehozása
Constructor TUzenetLista.Create(F: TForm; LB: TListBox);
Begin
  Inherited Create;
  Self.Form:=F;
  Self.ListBox:=LB;
  Self.FMasolat:=Nil;
  Self.UzenetElem:=Nil;
  Self.UzenetLanc.Init(Self);
End;

//üzenetláncot tartalmazó típus megszûntetése
Destructor TUzenetLista.Destroy;
Begin
  //az összes láncelem felszabadítása
  Self.Aktualis:=Self.Elso;
  While (Self.Elso <> Nil) Do
  Begin
    Self.Elso:=Self.Aktualis.Kovetkezo;
    Dispose(Self.Aktualis);
    Self.Aktualis:=Self.Elso;
  End;
  Inherited Destroy;
End;

//egy elem(üzenet) felfûzése a láncra
Procedure TUzenetLista.Fuz(UzElem: PUzenetElem);
Begin
  //ha az üzenet prioritása magas
  If UzElem.Prior Then
  Begin
    //ha a lánc nem üres
    If (Self.Elso <> Nil) And (Self.Aktualis.Kovetkezo <> Nil) Then
    Begin
      Self.Aktualis:=Self.Elso;
      //megkeresi az utolsó magas prioritású elemet
      While (Self.Aktualis.Kovetkezo <> Nil) And (Self.Aktualis.Kovetkezo.Prior) Do
        Self.Aktualis:=Self.Aktualis.Kovetkezo;
    End;
    //ha üres a lánc
    If (Self.Elso = Nil) Then Self.Elso:=UzElem
    Else Begin
      UzElem.Kovetkezo:=Aktualis.Kovetkezo;
      Aktualis.Kovetkezo:=UzElem;
    End;
  End
  Else Begin
    //elmegy a lánc végére
    Self.Vegere;
    If (Self.Elso = Nil) Then Self.Elso:=UzElem
      Else Self.Aktualis.Kovetkezo:=UzElem;
  End;
  Self.Aktualis:=UzElem;
  //ha az üzenet tartalmát ki kell írni, vagyis ha a ListBox nem Nil
  If (Self.Form <> Nil) And (Self.ListBox <> Nil) Then
  Begin
    With Form Do ListBox.Items.Add(Self.Aktualis.Uzenet);
  End;
End;

//egy elem(üzenet) felfûzése a láncra
Procedure TUzenetLista.Felfuz(P: Boolean; Str: String);
Begin
  If (Str <> '') Then
  Begin
    //elem létrehozása
    Self.UzenetElem.Init(Self,P,Str);
    //elem befûzése
    Self.Fuz(UzenetElem);
  End;
End;

//egy elem(üzenet) felfûzése a láncra
Procedure TUzenetLista.Felfuz(P: Boolean; Str,Szov: String; Atb: TTextAttrib);
Begin
  If (Str <> '') Then
  Begin
    Self.UzenetElem.Init(Self,P,Str,Szov,Atb);
    Self.Fuz(UzenetElem);
  End;
End;

//az elsõ láncelem törlése
//ha sikerült -> True, különben -> False
Function TUzenetLista.Torles : Boolean;
Var UjMut : PUzenetElem;
Begin
  Result:=False;
  //ha a lánc nem üres
  If (Elso <> Nil) Then
  Begin
    If (Self.Form <> Nil) And (Self.ListBox <> Nil) Then
    Begin
      With Form Do ListBox.Items.Delete(0);
    End;
    UjMut:=Elso.Kovetkezo;
    Dispose(Elso);
    Elso:=UjMut;
    Aktualis:=Elso;
    Result:=True;
  End;
End;

//üzenet másolatának létrehozása és az üzenet törlése
//ha sikerült -> True, különben -> False
Function TUzenetLista.MasolAndTorles : Boolean;
Var RegiUzenetElem : PUzenetElem;
Begin
  If (Self.Elso <> Nil) Then
  Begin
    //régi másolat törlése
    MasolatTorles;
    RegiUzenetElem:=Self.UzenetElem;
    //másolat létrehozása
    UzenetElem.Init(Self,Elso.Prior,Elso.Uzenet,Elso.Szoveg,Elso.Attrib);
    Self.FMasolat:=UzenetElem;
    Self.UzenetElem:=RegiUzenetElem;
  End;
  //üzenetelem törlése
  Result:=Self.Torles;
End;

//régi másolat törlése
//ha sikerült -> True, különben -> False
Function TUzenetLista.MasolatTorles : Boolean;
Begin
  Result:=False;
  If (FMasolat <> Nil) Then
  Begin
    Dispose(FMasolat);
    FMasolat:=Nil;
    Result:=True;
  End;
End;

//üres-e a lánc
//ha üres -> True, különben -> False
Function TUzenetLista.Ures : Boolean;
Begin
  Result:=(Self.Elso = Nil);
End;

//elmegy a lánc végére
Procedure TUzenetLista.Vegere;
Begin
  If (Self.Elso <> Nil) And (Self.Aktualis.Kovetkezo <> Nil) Then
  Begin
    Self.Aktualis:=Self.Elso;
    While (Self.Aktualis.Kovetkezo <> Nil) Do
      Self.Aktualis:=Self.Aktualis.Kovetkezo;
  End;
End;

//szál létrehozása
Constructor TKuldThread.Create(CP: TComPort; PA: PPortAllapot; UL: PUzenetLista; Mem: TRichEdit);
Begin
  //szál létrehozása, a futásának felfüggesztésével 
  Inherited Create(True);
  Self.FMemo:=Mem;
  Self.FUzenet:='';
  Self.FSzoveg:='';
  Self.FKuldhet:=True;
  Self.FComPort:=CP;
  Self.FPortAllapot:=PA;
  Self.FUzenetLista:=UL;
  With Self.FAttrib Do
  Begin
    Color:=clBlack;
    Height:=Mem.Font.Height;
  End;
  //szál elindítása
  Resume;
End;

//szál megszûntetése
Destructor TKuldThread.Destroy;
Begin
  Self.Terminate;
  Inherited Destroy;
End;

//a szálból származó üzenetek kiírása
Procedure TKuldThread.Kiir;
Begin
  With FMemo.SelAttributes Do
  Begin
    Color:=FAttrib.Color;
    Height:=FAttrib.Height;
  End;
  FMemo.Lines.Add(FSzoveg);
  Application.ProcessMessages;
End;

//üzenet küldése
Procedure TKuldThread.UzenetKuld;
Begin
  FUzenetHossz:=0;
  Repeat Until (FComPort.OutputCount = 0);
  FUzenetHossz:=FComPort.WriteStr(FUzenet+sHatJel);
End;

//a szál fõrutinja
Procedure TKuldThread.Execute;
Var Kiserlet : Byte;
    Siker    : Boolean;
Begin
  Kiserlet:=0;
  //addig, amíg nem terminál
  Repeat
    If (Not FUzenetLista.Ures) And (FPortAllapot.Szabad) And
       (FComPort.Connected) And FKuldhet Then
    Begin
      Siker:=False;
      FPortAllapot.Szabad:=False;
      FUzenet:=FUzenetLista.Elso.Uzenet;
      //az üzenet elküldésére háromszori lehetõség van
      If (Not Siker) And (Kiserlet < 3) Then
      Begin
        Inc(Kiserlet);
        //üzenet küldése
        Synchronize(UzenetKuld);
        If (FUzenetHossz = Length(FUzenet)+1) Then
        Begin
          Siker:=True;
          FSzoveg:=FUzenetLista.Elso.Szoveg;
          If (FSzoveg <> '') Then
          Begin
            FAttrib.Color:=FUzenetLista.Elso.Attrib.Color;
            //szöveg kiírása
            Synchronize(Kiir);
          End;
        End
        Else Begin
          FSzoveg:='HIBA: Adatátviteli hiba. Kísérlet: '+IntToStr(Kiserlet);
          FAttrib.Color:=clBlack;
          //szöveg kiírása
          Synchronize(Kiir);
        End;
      End;
      //ha sikerült az üzenetet elküldeni
      If Siker Then
      Begin
        Kiserlet:=0;
        FUzenetLista.MasolAndTorles;
      End;
      //ha harmadjára sem sikerült az üzenet elküldeni
      If (Not Siker) And (Kiserlet > 2) Then
      Begin
        Kiserlet:=0;
        FSzoveg:='HIBA: Az adatátvitel nem sikerült. Adatvesztés lehetséges.';
        FAttrib.Color:=clBlack;
        //szöveg kiírása
        Synchronize(Kiir);
        FUzenetLista.Torles;
      End;
    End;
  Until Terminated;
End;

End.
