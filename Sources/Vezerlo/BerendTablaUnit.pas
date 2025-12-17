//A berendezéseket tartalmazó adatbázisok eljárásai, függvényei
Unit BerendTablaUnit;

Interface

Uses DB, DBTables, Classes, SysUtils, FileTablaUnit, HomeroLancUnit,
     RiasztoLancUnit, TuzjelzoLancUnit, KapcsBerendLancUnit, VegBerendLancUnit,
     BerendezesekLancUnit;

//adatbázisok nevei
Const sEgyebDB    = 'Egyeb';
      sHomeroDB   = 'Homero';
      sRiasztoDB  = 'Riaszto';
      sTuzjelzoDB = 'Tuzjelzo';
      sFutotestDB = 'Futotest';
      sKapcsDB    = 'Kapcsolat';

Function HomeroTablaBeolvas(Const Tabla: TTable; Const EpuletNev: String;
         HL: THomeroLista; BL: TBerendezesLista) : Boolean;
Function RiasztoTablaBeolvas(Const Tabla: TTable; Const EpuletNev: String;
         RL: TRiasztoLista; BL: TBerendezesLista) : Boolean;
Function TuzjelzoTablaBeolvas(Const Tabla: TTable; Const EpuletNev: String;
         TL: TTuzjelzoLista; BL: TBerendezesLista) : Boolean;
Function FutotestTablaBeolvas(Const Tabla: TTable; Const EpuletNev: String;
         FL: TVegBerendLista; BL: TBerendezesLista) : Boolean;
Function EgyebTablaBeolvas(Const Tabla: TTable; Const EpuletNev: String;
         EL: TVegBerendLista; BL: TBerendezesLista) : Boolean;
Function KapcsTablaBeolvas(Const Tabla: TTable; Const EpuletNev: String;
         KBL: TKapcsBerendLista; BL: TBerendezesLista) : Boolean;
Procedure HomeroTablaMentes(HomeroTabla: TTable; Const EpuletNev: String;
          HL: THomeroLista);
Procedure HomeroLancMentes(HL: THomeroLista; Const HomeroTabla: TTable);
Procedure HomeroTablaKeszit(Tabla: TTable; Nev: String; Tipus: TTableType);
Procedure RiasztoTablaMentes(RiasztoTabla: TTable; Const EpuletNev: String;
          RL: TRiasztoLista);
Procedure RiasztoLancMentes(RL: TRiasztoLista; Const RiasztoTabla: TTable);
Procedure RiasztoTablaKeszit(Tabla: TTable; Nev: String; Tipus: TTableType);
Procedure TuzjelzoTablaMentes(TuzjelzoTabla: TTable; Const EpuletNev: String;
          TL: TTuzjelzoLista);
Procedure TuzjelzoLancMentes(TL: TTuzjelzoLista; Const TuzjelzoTabla: TTable);
Procedure TuzjelzoTablaKeszit(Tabla: TTable; Nev: String; Tipus: TTableType);
Procedure FutotestTablaMentes(FutotestTabla: TTable; Const EpuletNev: String;
          VBL: TVegBerendLista);
Procedure FutotestLancMentes(VBL: TVegBerendLista; Const FutotestTabla: TTable);
Procedure FutotestTablaKeszit(Tabla: TTable; Nev: String; Tipus: TTableType);
Procedure EgyebTablaMentes(EgyebTabla: TTable; Const EpuletNev: String;
          VBL: TVegBerendLista);
Procedure EgyebLancMentes(VBL: TVegBerendLista; Const EgyebTabla: TTable);
Procedure EgyebTablaKeszit(Tabla: TTable; Nev: String; Tipus: TTableType);
Procedure KapcsTablaMentes(KapcsTabla: TTable; Const EpuletNev: String;
          KBL: TKapcsBerendLista);
Procedure KapcsLancMentes(KBL: TKapcsBerendLista; Const KapcsTabla: TTable);
Procedure KapcsTablaKeszit(Tabla: TTable; Nev: String; Tipus: TTableType);

Implementation

//hõmérõket tartalmazó adatbázis mentése
Procedure HomeroTablaMentes;
Var TbNames : TStringList;
    DirName : String;
    RegiDir : String;
Begin
  RegiDir:=ExtractFilePath(ParamStr(0));
  DirName:=KonyvtarMegnyit(EpuletNev);
  //alias beállítása
  AliasModosit(DirName);
  TbNames:=TStringList.Create;
  Try
    //létezik-e a tábla
    Session.GetTableNames(sAlias,'',False,False,TbNames);
    //ha létezik
    If (TbNames.IndexOf(sHomeroDB) >= 0) Then
    Begin
      With HomeroTabla Do
      Begin
        Active:=False;
        DatabaseName:=sAlias;
        TableName:=DirName+'\'+sHomeroDB+sKit;
        TableType:=ttParadox;
        Exclusive:=True;
        EmptyTable;
        Exclusive:=False;
      End;
    End
    //különben létrehozzuk
    Else HomeroTablaKeszit(HomeroTabla,DirName+'\'+sHomeroDB+sKit,ttParadox);
    //elmentjük az adatokat
    HomeroLancMentes(HL,HomeroTabla);
  Finally
    FreeAndNil(TbNames);
  End;
  SetCurrentDir(RegiDir);
End;

//a hõmérõket tartalmazó lánc mentése
Procedure HomeroLancMentes;
Var RegiAkt : PHomeroElem;
Begin
  //adatbázis megnyitása
  HomeroTabla.Open;
  If (HL <> Nil) Then
  Begin
    RegiAkt:=HL.Aktualis;
    HL.Aktualis:=HL.Elso;
    //az egyes lácelemek tárolása
    While (HL.Aktualis <> Nil) Do
    Begin
      With HomeroTabla Do
      Begin
        Insert;
        FieldByName('ID').Value:=HL.Aktualis.ID;
        FieldByName('MIN').Value:=HL.Aktualis.Min;
        FieldByName('MAX').Value:=HL.Aktualis.Max;
        FieldByName('BERTEK').Value:=HL.Aktualis.BeallErtek;
        FieldByName('NAPLOZ').Value:=HL.Aktualis.Naplozas;
        Post;
      End;
      HL.Aktualis:=HL.Aktualis.Kovetkezo;
    End;
    HL.Aktualis:=RegiAkt;
    HL.Valtozas:=False;
  End;
  //adatbázis lezárása
  HomeroTabla.Close;
End;

//adatbázis létrehozása
Procedure HomeroTablaKeszit;
Begin
  Tabla.Close;
  Tabla.TableName:=Nev;
  Tabla.TableType:=Tipus;
  //mezõk definiálása
  With Tabla.FieldDefs Do
  Begin
    Clear;
    With AddFieldDef Do
    Begin
      Name:='ID';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='MIN';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='MAX';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='BERTEK';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='NAPLOZ';
      DataType:=ftBoolean;
      Required:=True;
    End;
  End;
  //tábla létrehozása
  Tabla.CreateTable;
End;

//hõmérõk beolvasása a láncba az adatbázisból
//ha sikerült -> True, különben -> False
Function HomeroTablaBeolvas;
Var ID        : Integer;
    BerendMut : PLancElem;
    HomeroMut : PHomeroElem;
    DirName   : String;
    RegiDir   : String;
Begin
  Result:=False;
  RegiDir:=ExtractFilePath(ParamStr(0));
  //ráál a könyvtárra
  DirName:=KonyvtarMegnyit(EpuletNev);
  //alias beállítása
  AliasModosit(DirName);
  Tabla.TableName:=DirName+'\'+sHomeroDB+sKit;
  //ha létezik az adatbázis
  If FileExists(Tabla.TableName) Then
    Try
      Tabla.Open;
      With Tabla Do
      Begin
        First;
        //végigmegy az adatbázison
        While (Not EOF) Do
        Begin
          ID:=FieldByName('ID').AsInteger;
          If BL.KeresID(ID,BerendMut) And HL.KeresID(ID,HomeroMut) Then
          Begin
            HomeroMut.Min:=FieldByName('MIN').AsInteger;
            HomeroMut.Max:=FieldByName('MAX').AsInteger;
            HomeroMut.BeallErtek:=FieldByName('BERTEK').AsInteger;
            HomeroMut.Naplozas:=FieldByName('NAPLOZ').AsBoolean;
            HomeroMut.HomeroMutato:=BerendMut;
          End;
          Next;
        End;
      End;
      HL.Valtozas:=False;
    Finally
      Tabla.Close;
      Result:=True;
    End;
  SetCurrentDir(RegiDir);
End;

//riasztókat tartalmazó adatbázis mentése
Procedure RiasztoTablaMentes;
Var TbNames : TStringList;
    DirName : String;
    RegiDir : String;
Begin
  RegiDir:=ExtractFilePath(ParamStr(0));
  DirName:=KonyvtarMegnyit(EpuletNev);
  //alias beállítása
  AliasModosit(DirName);
  TbNames:=TStringList.Create;
  Try
    //létezik-e a tábla
    Session.GetTableNames(sAlias,'',False,False,TbNames);
    //ha létezik
    If (TbNames.IndexOf(sRiasztoDB) >= 0) Then
    Begin
      With RiasztoTabla Do
      Begin
        Active:=False;
        DatabaseName:=sAlias;
        TableName:=DirName+'\'+sRiasztoDB+sKit;
        TableType:=ttParadox;
        Exclusive:=True;
        EmptyTable;
        Exclusive:=False;
      End;
    End
    //különben létrehozzuk
    Else RiasztoTablaKeszit(RiasztoTabla,DirName+'\'+sRiasztoDB+sKit,ttParadox);
    //elmentjük az adatokat
    RiasztoLancMentes(RL,RiasztoTabla);
  Finally
    FreeAndNil(TbNames);
  End;
  SetCurrentDir(RegiDir);
End;

//a riasztókat tartalmazó lánc mentése
Procedure RiasztoLancMentes;
Var RegiAkt : PRiasztoElem;
Begin
  //adatbázis megnyitása
  RiasztoTabla.Open;
  If (RL <> Nil) Then
  Begin
    RegiAkt:=RL.Aktualis;
    RL.Aktualis:=RL.Elso;
    //az egyes lácelemek tárolása
    While (RL.Aktualis <> Nil) Do
    Begin
      With RiasztoTabla Do
      Begin
        Insert;
        FieldByName('ID').Value:=RL.Aktualis.ID;
        FieldByName('NAPLOZ').Value:=RL.Aktualis.Naplozas;
        Post;
      End;
      RL.Aktualis:=RL.Aktualis.Kovetkezo;
    End;
    RL.Aktualis:=RegiAkt;
    RL.Valtozas:=False;
  End;
  //adatbázis lezárása
  RiasztoTabla.Close;
End;

//adatbázis létrehozása
Procedure RiasztoTablaKeszit;
Begin
  Tabla.Close;
  Tabla.TableName:=Nev;
  Tabla.TableType:=Tipus;
  //mezõk definiálása
  With Tabla.FieldDefs Do
  Begin
    Clear;
    With AddFieldDef Do
    Begin
      Name:='ID';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='NAPLOZ';
      DataType:=ftBoolean;
      Required:=True;
    End;
  End;
  //tábla létrehozása
  Tabla.CreateTable;
End;

//hõmérõk beolvasása a láncba az adatbázisból
//ha sikerült -> True, különben -> False
Function RiasztoTablaBeolvas;
Var ID         : Integer;
    BerendMut  : PLancElem;
    RiasztoMut : PRiasztoElem;
    DirName    : String;
    RegiDir    : String;
Begin
  Result:=False;
  RegiDir:=ExtractFilePath(ParamStr(0));
  //ráál a könyvtárra
  DirName:=KonyvtarMegnyit(EpuletNev);
  //alias beállítása
  AliasModosit(DirName);
  Tabla.TableName:=DirName+'\'+sRiasztoDB+sKit;
  //ha létezik az adatbázis
  If FileExists(Tabla.TableName) Then
    Try
      Tabla.Open;
      With Tabla Do
      Begin
        First;
        //végigmegy az adatbázison
        While (Not EOF) Do
        Begin
          ID:=FieldByName('ID').AsInteger;
          If BL.KeresID(ID,BerendMut) And RL.KeresID(ID,RiasztoMut) Then
          Begin
            RiasztoMut.Naplozas:=FieldByName('NAPLOZ').AsBoolean;
            RiasztoMut.RiasztoMutato:=BerendMut;
          End;
          Next;
        End;
      End;
      RL.Valtozas:=False;
    Finally
      Tabla.Close;
      Result:=True;
    End;
  SetCurrentDir(RegiDir);
End;

//tûzjelzõket tartalmazó adatbázis mentése
Procedure TuzjelzoTablaMentes;
Var TbNames : TStringList;
    DirName : String;
    RegiDir : String;
Begin
  RegiDir:=ExtractFilePath(ParamStr(0));
  DirName:=KonyvtarMegnyit(EpuletNev);
  //alias beállítása
  AliasModosit(DirName);
  TbNames:=TStringList.Create;
  Try
    //létezik-e a tábla
    Session.GetTableNames(sAlias,'',False,False,TbNames);
    //ha létezik
    If (TbNames.IndexOf(sTuzjelzoDB) >= 0) Then
    Begin
      With TuzjelzoTabla Do
      Begin
        Active:=False;
        DatabaseName:=sAlias;
        TableName:=DirName+'\'+sTuzjelzoDB+sKit;
        TableType:=ttParadox;
        Exclusive:=True;
        EmptyTable;
        Exclusive:=False;
      End;
    End
    //különben létrehozzuk
    Else TuzjelzoTablaKeszit(TuzjelzoTabla,DirName+'\'+sTuzjelzoDB+sKit,ttParadox);
    //elmentjük az adatokat
    TuzjelzoLancMentes(TL,TuzjelzoTabla);
  Finally
    FreeAndNil(TbNames);
  End;
  SetCurrentDir(RegiDir);
End;

//a tûzjelzõket tartalmazó lánc mentése
Procedure TuzjelzoLancMentes;
Var RegiAkt : PTuzjelzoElem;
Begin
  //adatbázis megnyitása
  TuzjelzoTabla.Open;
  If (TL <> Nil) Then
  Begin
    RegiAkt:=TL.Aktualis;
    TL.Aktualis:=TL.Elso;
    //az egyes lácelemek tárolása
    While (TL.Aktualis <> Nil) Do
    Begin
      With TuzjelzoTabla Do
      Begin
        Insert;
        FieldByName('ID').Value:=TL.Aktualis.ID;
        FieldByName('NAPLOZ').Value:=TL.Aktualis.Naplozas;
        Post;
      End;
      TL.Aktualis:=TL.Aktualis.Kovetkezo;
    End;
    TL.Aktualis:=RegiAkt;
    TL.Valtozas:=False;
  End;
  //adatbázis lezárása
  TuzjelzoTabla.Close;
End;

//adatbázis létrehozása
Procedure TuzjelzoTablaKeszit;
Begin
  Tabla.Close;
  Tabla.TableName:=Nev;
  Tabla.TableType:=Tipus;
  //mezõk definiálása
  With Tabla.FieldDefs Do
  Begin
    Clear;
    With AddFieldDef Do
    Begin
      Name:='ID';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='NAPLOZ';
      DataType:=ftBoolean;
      Required:=True;
    End;
  End;
  //tábla létrehozása
  Tabla.CreateTable;
End;

//tûzjelzõk beolvasása a láncba az adatbázisból
//ha sikerült -> True, különben -> False
Function TuzjelzoTablaBeolvas;
Var ID          : Integer;
    BerendMut   : PLancElem;
    TuzjelzoMut : PTuzjelzoElem;
    DirName     : String;
    RegiDir     : String;
Begin
  Result:=False;
  RegiDir:=ExtractFilePath(ParamStr(0));
  //ráál a könyvtárra
  DirName:=KonyvtarMegnyit(EpuletNev);
  //alias beállítása
  AliasModosit(DirName);
  Tabla.TableName:=DirName+'\'+sTuzjelzoDB+sKit;
  //ha létezik az adatbázis
  If FileExists(Tabla.TableName) Then
    Try
      Tabla.Open;
      With Tabla Do
      Begin
        First;
        //végigmegy az adatbázison
        While (Not EOF) Do
        Begin
          ID:=FieldByName('ID').AsInteger;
          If BL.KeresID(ID,BerendMut) And TL.KeresID(ID,TuzjelzoMut) Then
          Begin
            TuzjelzoMut.Naplozas:=FieldByName('NAPLOZ').AsBoolean;
            TuzjelzoMut.TuzjelzoMutato:=BerendMut;
          End;
          Next;
        End;
      End;
      TL.Valtozas:=False;
    Finally
      Tabla.Close;
      Result:=True;
    End;
  SetCurrentDir(RegiDir);
End;

//fûtõtesteket tartalmazó adatbázis mentése
Procedure FutotestTablaMentes;
Var TbNames : TStringList;
    DirName : String;
    RegiDir : String;
Begin
  RegiDir:=ExtractFilePath(ParamStr(0));
  DirName:=KonyvtarMegnyit(EpuletNev);
  //alias beállítása
  AliasModosit(DirName);
  TbNames:=TStringList.Create;
  Try
    //létezik-e a tábla
    Session.GetTableNames(sAlias,'',False,False,TbNames);
    //ha létezik
    If (TbNames.IndexOf(sFutotestDB) >= 0) Then
    Begin
      With FutotestTabla Do
      Begin
        Active:=False;
        DatabaseName:=sAlias;
        TableName:=DirName+'\'+sFutotestDB+sKit;
        TableType:=ttParadox;
        Exclusive:=True;
        EmptyTable;
        Exclusive:=False;
      End;
    End
    //különben létrehozzuk
    Else FutotestTablaKeszit(FutotestTabla,DirName+'\'+sFutotestDB+sKit,ttParadox);
    //elmentjük az adatokat
    FutotestLancMentes(VBL,FutotestTabla);
  Finally
    FreeAndNil(TbNames);
  End;
  SetCurrentDir(RegiDir);
End;

//a fûtõtesteket tartalmazó lánc mentése
Procedure FutotestLancMentes;
Var RegiAkt : PVegBerendElem;
Begin
  //adatbázis megnyitása
  FutotestTabla.Open;
  If (VBL <> Nil) Then
  Begin
    RegiAkt:=VBL.Aktualis;
    VBL.Aktualis:=VBL.Elso;
    //az egyes lácelemek tárolása
    While (VBL.Aktualis <> Nil) Do
    Begin
      If (VBL.Aktualis.VegBerendMutato.BerendezesTip = btFutotest) Then
        With FutotestTabla Do
        Begin
          Insert;
          FieldByName('ID').Value:=VBL.Aktualis.ID;
          FieldByName('NAPLOZ').Value:=VBL.Aktualis.Naplozas;
          FieldByName('AUTO').Value:=VBL.Aktualis.Automata;
          FieldByName('DIREKT').Value:=VBL.Aktualis.Direkt;
          Post;
        End;
      VBL.Aktualis:=VBL.Aktualis.Kovetkezo;
    End;
    VBL.Aktualis:=RegiAkt;
    VBL.Valtozas:=False;
  End;
  //adatbázis lezárása
  FutotestTabla.Close;
End;

//adatbázis létrehozása
Procedure FutotestTablaKeszit;
Begin
  Tabla.Close;
  Tabla.TableName:=Nev;
  Tabla.TableType:=Tipus;
  //mezõk definiálása
  With Tabla.FieldDefs Do
  Begin
    Clear;
    With AddFieldDef Do
    Begin
      Name:='ID';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='NAPLOZ';
      DataType:=ftBoolean;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='AUTO';
      DataType:=ftBoolean;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='DIREKT';
      DataType:=ftBoolean;
      Required:=True;
    End;
  End;
  //tábla létrehozása
  Tabla.CreateTable;
End;

//fûtõtestek beolvasása a láncba az adatbázisból
//ha sikerült -> True, különben -> False
Function FutotestTablaBeolvas;
Var ID          : Integer;
    BerendMut   : PLancElem;
    FutotestMut : PVegBerendElem;
    DirName     : String;
    RegiDir     : String;
Begin
  Result:=False;
  RegiDir:=ExtractFilePath(ParamStr(0));
  //ráál a könyvtárra
  DirName:=KonyvtarMegnyit(EpuletNev);
  //alias beállítása
  AliasModosit(DirName);
  Tabla.TableName:=DirName+'\'+sFutotestDB+sKit;
  //ha létezik az adatbázis
  If FileExists(Tabla.TableName) Then
    Try
      Tabla.Open;
      With Tabla Do
      Begin
        First;
        //végigmegy az adatbázison
        While (Not EOF) Do
        Begin
          ID:=FieldByName('ID').AsInteger;
          If BL.KeresID(ID,BerendMut) And FL.KeresID(ID,FutotestMut) Then
          Begin
            FutotestMut.Automata:=FieldByName('AUTO').AsBoolean;
            FutotestMut.Direkt:=FieldByName('DIREKT').AsBoolean;
            FutotestMut.Naplozas:=FieldByName('NAPLOZ').AsBoolean;
            FutotestMut.VegBerendMutato:=BerendMut;
          End;
          Next;
        End;
      End;
      FL.Valtozas:=False;
    Finally
      Tabla.Close;
      Result:=True;
    End;
  SetCurrentDir(RegiDir);
End;

//más berendezéseket tartalmazó adatbázis mentése
Procedure EgyebTablaMentes;
Var TbNames : TStringList;
    DirName : String;
    RegiDir : String;
Begin
  RegiDir:=ExtractFilePath(ParamStr(0));
  DirName:=KonyvtarMegnyit(EpuletNev);
  //alias beállítása
  AliasModosit(DirName);
  TbNames:=TStringList.Create;
  Try
    //létezik-e a tábla
    Session.GetTableNames(sAlias,'',False,False,TbNames);
    //ha létezik
    If (TbNames.IndexOf(sEgyebDB) >= 0) Then
    Begin
      With EgyebTabla Do
      Begin
        Active:=False;
        DatabaseName:=sAlias;
        TableName:=DirName+'\'+sEgyebDB+sKit;
        TableType:=ttParadox;
        Exclusive:=True;
        EmptyTable;
        Exclusive:=False;
      End;
    End
    //különben létrehozzuk
    Else EgyebTablaKeszit(EgyebTabla,DirName+'\'+sEgyebDB+sKit,ttParadox);
    //elmentjük az adatokat
    EgyebLancMentes(VBL,EgyebTabla);
  Finally
    FreeAndNil(TbNames);
  End;
  SetCurrentDir(RegiDir);
End;

//a más berendezéseket tartalmazó lánc mentése
Procedure EgyebLancMentes;
Var RegiAkt : PVegBerendElem;
Begin
  //adatbázis megnyitása
  EgyebTabla.Open;
  If (VBL <> Nil) Then
  Begin
    RegiAkt:=VBL.Aktualis;
    VBL.Aktualis:=VBL.Elso;
    //az egyes lácelemek tárolása
    While (VBL.Aktualis <> Nil) Do
    Begin
      If (VBL.Aktualis.VegBerendMutato.BerendezesTip = btEgyeb) Then
        With EgyebTabla Do
        Begin
          Insert;
          FieldByName('ID').Value:=VBL.Aktualis.ID;
          FieldByName('NAPLOZ').Value:=VBL.Aktualis.Naplozas;
          FieldByName('AUTO').Value:=VBL.Aktualis.Automata;
          FieldByName('DIREKT').Value:=VBL.Aktualis.Direkt;
          Post;
        End;
      VBL.Aktualis:=VBL.Aktualis.Kovetkezo;
    End;
    VBL.Aktualis:=RegiAkt;
    VBL.Valtozas:=False;
  End;
  //adatbázis lezárása
  EgyebTabla.Close;
End;

//adatbázis létrehozása
Procedure EgyebTablaKeszit;
Begin
  FutotestTablaKeszit(Tabla,sEgyebDB,ttParadox);
End;

//más berendezések beolvasása a láncba az adatbázisból
//ha sikerült -> True, különben -> False
Function EgyebTablaBeolvas;
Var ID        : Integer;
    BerendMut : PLancElem;
    EgyebMut  : PVegBerendElem;
    DirName   : String;
    RegiDir   : String;
Begin
  Result:=False;
  RegiDir:=ExtractFilePath(ParamStr(0));
  //ráál a könyvtárra
  DirName:=KonyvtarMegnyit(EpuletNev);
  //alias beállítása
  AliasModosit(DirName);
  Tabla.TableName:=DirName+'\'+sEgyebDB+sKit;
  //ha létezik az adatbázis
  If FileExists(Tabla.TableName) Then
    Try
      Tabla.Open;
      With Tabla Do
      Begin
        First;
        //végigmegy az adatbázison
        While (Not EOF) Do
        Begin
          ID:=FieldByName('ID').AsInteger;
          If BL.KeresID(ID,BerendMut) And EL.KeresID(ID,EgyebMut) Then
          Begin
            EgyebMut.Automata:=FieldByName('AUTO').AsBoolean;
            EgyebMut.Direkt:=FieldByName('DIREKT').AsBoolean;
            EgyebMut.Naplozas:=FieldByName('NAPLOZ').AsBoolean;
            EgyebMut.VegBerendMutato:=BerendMut;
          End;
          Next;
        End;
      End;
      EL.Valtozas:=False;
    Finally
      Tabla.Close;
      Result:=True;
    End;
  SetCurrentDir(RegiDir);
End;

//kapcsolatokat tartalmazó adatbázis mentése
Procedure KapcsTablaMentes;
Var TbNames : TStringList;
    DirName : String;
    RegiDir : String;
Begin
  RegiDir:=ExtractFilePath(ParamStr(0));
  DirName:=KonyvtarMegnyit(EpuletNev);
  //alias beállítása
  AliasModosit(DirName);
  TbNames:=TStringList.Create;
  Try
    //létezik-e a tábla
    Session.GetTableNames(sAlias,'',False,False,TbNames);
    //ha létezik
    If (TbNames.IndexOf(sKapcsDB) >= 0) Then
    Begin
      With KapcsTabla Do
      Begin
        Active:=False;
        DatabaseName:=sAlias;
        TableName:=DirName+'\'+sKapcsDB+sKit;
        TableType:=ttParadox;
        Exclusive:=True;
        EmptyTable;
        Exclusive:=False;
      End;
    End
    //különben létrehozzuk
    Else KapcsTablaKeszit(KapcsTabla,DirName+'\'+sKapcsDB+sKit,ttParadox);
    //elmentjük az adatokat
    KapcsLancMentes(KBL,KapcsTabla);
  Finally
    FreeAndNil(TbNames);
  End;
  SetCurrentDir(RegiDir);
End;

//a kapcsolatokat tartalmazó lánc mentése
Procedure  KapcsLancMentes;
Var RegiAkt : PKapcsBerendElem;
Begin
  //adatbázis megnyitása
  KapcsTabla.Open;
  If (KBL <> Nil) Then
  Begin
    RegiAkt:=KBL.Aktualis;
    KBL.Aktualis:=KBL.Elso;
    //az egyes lácelemek tárolása
    While (KBL.Aktualis <> Nil) Do
    Begin
      With KapcsTabla Do
      Begin
        Insert;
        FieldByName('MI').Value:=KBL.Aktualis.MiKapcs.ID;
        FieldByName('MIHEZ').Value:=KBL.Aktualis.MihezKapcs.ID;
        Post;
      End;
      KBL.Aktualis:=KBL.Aktualis.Kovetkezo;
    End;
    KBL.Aktualis:=RegiAkt;
    KBL.Valtozas:=False;
  End;
  //adatbázis lezárása
  KapcsTabla.Close;
End;

//adatbázis létrehozása
Procedure KapcsTablaKeszit;
Begin
  Tabla.Close;
  Tabla.TableName:=Nev;
  Tabla.TableType:=Tipus;
  //mezõk definiálása
  With Tabla.FieldDefs Do
  Begin
    Clear;
    With AddFieldDef Do
    Begin
      Name:='MI';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='MIHEZ';
      DataType:=ftSmallInt;
      Required:=True;
    End;
  End;
  //tábla létrehozása
  Tabla.CreateTable;
End;

//kapcsolatok beolvasása a láncba az adatbázisból
//ha sikerült -> True, különben -> False
Function KapcsTablaBeolvas;
Var MiID     : Integer;
    MihezID  : Integer;
    MiMut    : PLancElem;
    MihezMut : PLancElem;
    DirName  : String;
    RegiDir  : String;
Begin
  Result:=False;
  RegiDir:=ExtractFilePath(ParamStr(0));
  //ráál a könyvtárra
  DirName:=KonyvtarMegnyit(EpuletNev);
  //alias beállítása
  AliasModosit(DirName);
  Tabla.TableName:=DirName+'\'+sKapcsDB+sKit;
  //ha létezik az adatbázis
  If FileExists(Tabla.TableName) Then
    Try
      Tabla.Open;
      With Tabla Do
      Begin
        First;
        //végigmegy az adatbázison
        While (Not EOF) Do
        Begin
          MiID:=FieldByName('MI').AsInteger;
          MihezID:=FieldByName('MIHEZ').AsInteger;
          If BL.KeresID(MiID,MiMut) And BL.KeresID(MihezID,MihezMut) Then
            KBL.Felfuz(MiMut,MihezMut);
          Next;
        End;
      End;
      KBL.Valtozas:=False;
    Finally
      Tabla.Close;
      Result:=True;
    End;
  SetCurrentDir(RegiDir);
End;

End.
