//Adatbázisokkal kapcsolatok eljárások, függvények
Unit FileTablaUnit;

Interface

Uses DB,DBTables,Graphics,Dialogs,Classes,Controls,Messages,IniFiles,SysUtils,
     FileCtrl,Forms,StdCtrls,ObjektumUnit,BerendezesekLancUnit,RajzolasUnit,
     EpuletLancUnit,FormFestoUnit,CPort,Windows;

Const sKit        = '.DB';
      sAlias      = 'Epulet';
      sTervezo    = 'Tervezo';
      sVezerlo    = 'Vezerlo';
      sTesztelo   = 'Tesztelo';
      sAlaprajz   = 'Alaprajz';
      sObjektum   = 'Objektum';
      sBerendezes = 'Berendezes';
      ALAPRAJZDIR = 'Alaprajzok';
      INDEXNEV    = 'AlakSorrendIndx';

//a tesztelõ program beállításához kell
Type TTeszteloBeallit = Object
       HomeroVetel   : Boolean;
       HomeroKuld    : Boolean;
       RiasztoVetel  : Boolean;
       RiasztoKuld   : Boolean;
       TuzjelzoVetel : Boolean;
       TuzjelzoKuld  : Boolean;
       FutotestVetel : Boolean;
       FutotestKuld  : Boolean;
       EgyebVetel    : Boolean;
       EgyebKuld     : Boolean;
     End;

Function Kerdes(Szoveg: String) : Boolean;
Function AktDirNev(Const Dir: String) : String;
Function KonyvtarMegnyit(Const SubDir: String) : String;
Procedure AliasModosit(Const Dir: String);
Procedure RajzIniBetolt(Const Path,EpuletNev: String; Var AlapMeret,EgysMeret: Integer);
Procedure TervezoIniMent(Const FNev: String; Const SzinAtmenet: Boolean;
          Const AblakMeret: Integer);
Procedure VezerloIniBetolt(FNev: String; Form: TForm; SzinBox,InditBox: TCheckBox;
          InputEdit: TEdit; CPort: TComPort; Var Hang: Integer; Var Epulet: String);
Procedure VezerloIniMent(FNev,Epulet: String; SzinAtmenet,AutIndit: Boolean;
          Com: String; Stop,Baud,Data,Flow,Hang: Integer);
Procedure TeszteloIniBetolt(FNev: String; Form: TForm; SzinBox,FormaBox,
          InditBox: TCheckBox; InputEdit: TEdit; CPort: TComPort;
          Var Epulet: String; Var Beallitas: TTeszteloBeallit);
Procedure TeszteloIniMent(FNev,Epulet: String; SzinAtmenet,Forma,
          AutIndit: Boolean; Com: String; Stop,Baud,Data,Flow: Integer;
          Beallitas: TTeszteloBeallit);
Procedure EpuletTablaMentes(Const EpLista: TEpuletLista; EpuletNev: String;
          EpuletTabla: TTable; Const AlapMeret,EgysMeret: Integer);
Procedure EpuletLancMentes(Const EpLista: TEpuletLista; Const EpuletTabla: TTable);
Procedure EpuletTablaKeszit(Tabla: TTable; Nev: String; Tipus: TTableType);
Procedure ObjektumTablaMentes(Const EpLista: TEpuletLista; EpuletNev: String;
          Const ObjLista: TObjektumLista; ObjektumTabla: TTable);
Procedure ObjektumLancMentes(Const EpLista: TEpuletLista;
          Const ObjektumTabla: TTable; Const ObjLista: TObjektumLista);
Procedure ObjektumTablaKeszit(Tabla: TTable; Nev: String; Tipus: TTableType);
Procedure BerendezesTablaMentes(Const EpLista: TEpuletLista;
          Const ObjLista: TObjektumLista; EpuletNev: String;
          Const BerendLista: TBerendezesLista; BerendezesTabla: TTable);
Procedure BerendezesLancMentes(Const EpLista: TEpuletLista;
          Const ObjLista: TObjektumLista; Const BerendezesTabla: TTable;
          Const BerendLista: TBerendezesLista);
Procedure BerendezesTablaKeszit(Tabla: TTable; Nev: String; Tipus: TTableType);

Implementation

//a tervezõ program beállításainak betöltése
Procedure RajzIniBetolt;
Var Proba     : String;
    FileName  : String;
    EpuletIni : TIniFile;
Begin
  FileName:=Path+'\'+EpuletNev+'.ini';
  EpuletIni:=TIniFile.Create(FileName);
  Try
    With EpuletIni Do
    Begin
      Proba:=ReadString('Beállítások','EpuletMeret','¤');
      If (Proba = '¤') Then WriteInteger('Beállítások','EpuletMeret',24);
      AlapMeret:=ReadInteger('Beállítások','EpuletMeret',24);
      Proba:=ReadString('Beállítások','EgysegMeret','¤');
      If (Proba = '¤') Then WriteInteger('Beállítások','EgysegMeret',20);
      EgysMeret:=ReadInteger('Beállítások','EgysegMeret',20);
    End;
  Finally
    FreeAndNil(EpuletIni);
  End;
End;

//a tervezõ program beállításainak mentése
Procedure TervezoIniMent(Const FNev: String; Const SzinAtmenet: Boolean; Const AblakMeret: Integer);
Var FileName : String;
    FileIni  : TIniFile;
Begin
  FileName:=ExtractFilePath(ParamStr(0))+FNev+'.ini';
  FileIni:=TIniFile.Create(FileName);
  Try
    With FileIni Do
    Begin
      WriteBool('Beállítások','SzinAtmenet',SzinAtmenet);
      WriteInteger('Beállítások','AblakMeret',AblakMeret);
    End;
  Finally
    FreeAndNil(FileIni);
  End;
End;

//a vezérlõ program beállításainak betöltése
Procedure VezerloIniBetolt;
Var Proba    : String;
    FileName : String;
    Index    : Integer;
    FileIni  : TIniFile;
Begin
  FileName:=ExtractFilePath(ParamStr(0))+FNev+'.ini';
  FileIni:=TIniFile.Create(FileName);
  Try
    With FileIni Do
    Begin
      With Form Do
      Begin
        Proba:=ReadString('Beállítások','Epulet','¤');
        If (Proba = '¤') Then WriteString('Beállítások','Epulet','');
        Epulet:=ReadString('Beállítások','Epulet','');
        InputEdit.Text:=Epulet;
        Proba:=ReadString('Beállítások','Hang','¤');
        If (Proba = '¤') Then WriteInteger('Beállítások','Hang',1);
        Hang:=ReadInteger('Beállítások','Hang',1);
        Proba:=ReadString('Beállítások','SzinAtmenet','¤');
        If (Proba = '¤') Then WriteBool('Beállítások','SzinAtmenet',True);
        SzinBox.Checked:=ReadBool('Beállítások','SzinAtmenet',True);
        AblakSzin.SzinAtmenet:=SzinBox.Checked;
        Proba:=ReadString('Kapcsolat','Automatikus','¤');
        If (Proba = '¤') Then WriteBool('Kapcsolat','Automatikus',False);
        InditBox.Checked:=ReadBool('Kapcsolat','Automatikus',False);
        Proba:=ReadString('Kapcsolat','ComPort','¤');
        If (Proba = '¤') Then WriteString('Kapcsolat','ComPort','COM1');
        CPort.Port:=ReadString('Kapcsolat','ComPort','COM1');
        Proba:=ReadString('Kapcsolat','StopBit','¤');
        If (Proba = '¤') Then WriteInteger('Kapcsolat','StopBit',0);
        Index:=ReadInteger('Kapcsolat','StopBit',0);
        CPort.StopBits:=TStopBits(Index);
        Proba:=ReadString('Kapcsolat','BaudRate','¤');
        If (Proba = '¤') Then WriteInteger('Kapcsolat','BaudRate',7);
        Index:=ReadInteger('Kapcsolat','BaudRate',7);
        CPort.BaudRate:=TBaudRate(Index);
        Proba:=ReadString('Kapcsolat','DataBit','¤');
        If (Proba = '¤') Then WriteInteger('Kapcsolat','DataBit',3);
        Index:=ReadInteger('Kapcsolat','DataBit',3);
        CPort.DataBits:=TDataBits(Index);
        Proba:=ReadString('Kapcsolat','FlowControl','¤');
        If (Proba = '¤') Then WriteInteger('Kapcsolat','FlowControl',2);
        Index:=ReadInteger('Kapcsolat','FlowControl',2);
        CPort.FlowControl.FlowControl:=TFlowControl(Index);
      End;
    End;
  Finally
    FreeAndNil(FileIni);
  End;
End;

//a vezérlõ program beállításainak mentése
Procedure VezerloIniMent(FNev,Epulet: String; SzinAtmenet,AutIndit: Boolean;
          Com: String; Stop,Baud,Data,Flow,Hang: Integer);
Var FileName : String;
    FileIni  : TIniFile;
Begin
  FileName:=ExtractFilePath(ParamStr(0))+FNev+'.ini';
  FileIni:=TIniFile.Create(FileName);
  Try
    With FileIni Do
    Begin
      WriteBool('Beállítások','SzinAtmenet',SzinAtmenet);
      WriteString('Beállítások','Epulet',Epulet);
      WriteInteger('Beállítások','Hang',Hang);
      WriteString('Kapcsolat','ComPort',Com);
      WriteBool('Kapcsolat','Automatikus',AutIndit);
      WriteInteger('Kapcsolat','StopBit',Stop);
      WriteInteger('Kapcsolat','BaudRate',Baud);
      WriteInteger('Kapcsolat','DataBit',Data);
      WriteInteger('Kapcsolat','FlowControl',Flow);
    End;
  Finally
    FreeAndNil(FileIni);
  End;
End;

//a tesztelõ program beállításainak betöltése
Procedure TeszteloIniBetolt;
Var Proba    : String;
    FileName : String;
    Index    : Integer;
    FileIni  : TIniFile;
Begin
  FileName:=ExtractFilePath(ParamStr(0))+FNev+'.ini';
  FileIni:=TIniFile.Create(FileName);
  Try
    With FileIni Do
    Begin
      With Form Do
      Begin
        Proba:=ReadString('Beállítások','Epulet','¤');
        If (Proba = '¤') Then WriteString('Beállítások','Epulet','');
        Epulet:=ReadString('Beállítások','Epulet','');
        InputEdit.Text:=Epulet;
        Proba:=ReadString('Beállítások','SzinAtmenet','¤');
        If (Proba = '¤') Then WriteBool('Beállítások','SzinAtmenet',True);
        SzinBox.Checked:=ReadBool('Beállítások','SzinAtmenet',True);
        AblakSzin.SzinAtmenet:=SzinBox.Checked;
        Proba:=ReadString('Beállítások','Forma','¤');
        If (Proba = '¤') Then WriteBool('Beállítások','Forma',True);
        FormaBox.Checked:=ReadBool('Beállítások','Forma',True);
        Proba:=ReadString('Kapcsolat','Automatikus','¤');
        If (Proba = '¤') Then WriteBool('Kapcsolat','Automatikus',False);
        InditBox.Checked:=ReadBool('Kapcsolat','Automatikus',False);
        Proba:=ReadString('Kapcsolat','ComPort','¤');
        If (Proba = '¤') Then WriteString('Kapcsolat','ComPort','COM1');
        CPort.Port:=ReadString('Kapcsolat','ComPort','COM1');
        Proba:=ReadString('Kapcsolat','StopBit','¤');
        If (Proba = '¤') Then WriteInteger('Kapcsolat','StopBit',0);
        Index:=ReadInteger('Kapcsolat','StopBit',0);
        CPort.StopBits:=TStopBits(Index);
        Proba:=ReadString('Kapcsolat','BaudRate','¤');
        If (Proba = '¤') Then WriteInteger('Kapcsolat','BaudRate',7);
        Index:=ReadInteger('Kapcsolat','BaudRate',7);
        CPort.BaudRate:=TBaudRate(Index);
        Proba:=ReadString('Kapcsolat','DataBit','¤');
        If (Proba = '¤') Then WriteInteger('Kapcsolat','DataBit',3);
        Index:=ReadInteger('Kapcsolat','DataBit',3);
        CPort.DataBits:=TDataBits(Index);
        Proba:=ReadString('Kapcsolat','FlowControl','¤');
        If (Proba = '¤') Then WriteInteger('Kapcsolat','FlowControl',2);
        Index:=ReadInteger('Kapcsolat','FlowControl',2);
        CPort.FlowControl.FlowControl:=TFlowControl(Index);
      End;
      Proba:=ReadString('Naplozas','HomeroVetel','¤');
      If (Proba = '¤') Then WriteBool('Naplozas','HomeroVetel',True);
      Beallitas.HomeroVetel:=ReadBool('Naplozas','HomeroVetel',True);
      Proba:=ReadString('Naplozas','HomeroKuld','¤');
      If (Proba = '¤') Then WriteBool('Naplozas','HomeroKuld',True);
      Beallitas.HomeroKuld:=ReadBool('Naplozas','HomeroKuld',True);
      Proba:=ReadString('Naplozas','RiasztoVetel','¤');
      If (Proba = '¤') Then WriteBool('Naplozas','RiasztoVetel',True);
      Beallitas.RiasztoVetel:=ReadBool('Naplozas','RiasztoVetel',True);
      Proba:=ReadString('Naplozas','RiasztoKuld','¤');
      If (Proba = '¤') Then WriteBool('Naplozas','RiasztoKuld',True);
      Beallitas.RiasztoKuld:=ReadBool('Naplozas','RiasztoKuld',True);
      Proba:=ReadString('Naplozas','TuzjelzoVetel','¤');
      If (Proba = '¤') Then WriteBool('Naplozas','TuzjelzoVetel',True);
      Beallitas.TuzjelzoVetel:=ReadBool('Naplozas','TuzjelzoVetel',True);
      Proba:=ReadString('Naplozas','TuzjelzoKuld','¤');
      If (Proba = '¤') Then WriteBool('Naplozas','TuzjelzoKuld',True);
      Beallitas.TuzjelzoKuld:=ReadBool('Naplozas','TuzjelzoKuld',True);
      Proba:=ReadString('Naplozas','FutotestVetel','¤');
      If (Proba = '¤') Then WriteBool('Naplozas','FutotestVetel',True);
      Beallitas.FutotestVetel:=ReadBool('Naplozas','FutotestVetel',True);
      Proba:=ReadString('Naplozas','FutotestKuld','¤');
      If (Proba = '¤') Then WriteBool('Naplozas','FutotestKuld',True);
      Beallitas.FutotestKuld:=ReadBool('Naplozas','FutotestKuld',True);
      Proba:=ReadString('Naplozas','EgyebVetel','¤');
      If (Proba = '¤') Then WriteBool('Naplozas','EgyebVetel',True);
      Beallitas.EgyebVetel:=ReadBool('Naplozas','EgyebVetel',True);
      Proba:=ReadString('Naplozas','EgyebKuld','¤');
      If (Proba = '¤') Then WriteBool('Naplozas','EgyebKuld',True);
      Beallitas.EgyebKuld:=ReadBool('Naplozas','EgyebKuld',True);
    End;
  Finally
    FreeAndNil(FileIni);
  End;
End;

//a tesztelõ program beállításainak mentése
Procedure TeszteloIniMent(FNev,Epulet: String; SzinAtmenet,Forma,
          AutIndit: Boolean; Com: String; Stop,Baud,Data,Flow: Integer;
          Beallitas: TTeszteloBeallit);
Var FileName : String;
    FileIni  : TIniFile;
Begin
  FileName:=ExtractFilePath(ParamStr(0))+FNev+'.ini';
  FileIni:=TIniFile.Create(FileName);
  Try
    With FileIni Do
    Begin
      WriteBool('Beállítások','SzinAtmenet',SzinAtmenet);
      WriteBool('Beállítások','Forma',Forma);
      WriteString('Beállítások','Epulet',Epulet);
      WriteString('Kapcsolat','ComPort',Com);
      WriteBool('Kapcsolat','Automatikus',AutIndit);
      WriteInteger('Kapcsolat','StopBit',Stop);
      WriteInteger('Kapcsolat','BaudRate',Baud);
      WriteInteger('Kapcsolat','DataBit',Data);
      WriteInteger('Kapcsolat','FlowControl',Flow);
      WriteBool('Naplozas','HomeroVetel',Beallitas.HomeroVetel);
      WriteBool('Naplozas','HomeroKuld',Beallitas.HomeroKuld);
      WriteBool('Naplozas','RiasztoVetel',Beallitas.RiasztoVetel);
      WriteBool('Naplozas','RiasztoKuld',Beallitas.RiasztoKuld);
      WriteBool('Naplozas','TuzjelzoVetel',Beallitas.TuzjelzoVetel);
      WriteBool('Naplozas','TuzjelzoKuld',Beallitas.TuzjelzoKuld);
      WriteBool('Naplozas','FutotestVetel',Beallitas.FutotestVetel);
      WriteBool('Naplozas','FutotestKuld',Beallitas.FutotestKuld);
      WriteBool('Naplozas','EgyebVetel',Beallitas.EgyebVetel);
      WriteBool('Naplozas','EgyebKuld',Beallitas.EgyebKuld);
    End;
  Finally
    FreeAndNil(FileIni);
  End;
End;

//az épületet tartalmazó könyvtár megnyitása
//ha siker -> visszaadja az elérési útvonalát, különben -> ''
Function KonyvtarMegnyit;
Begin
  Result:='';
  //ha a paraméter jó
  If (SubDir <> '') Then
  Begin
    SetCurrentDir(ExtractFilePath(ParamStr(0))+'..');
    //ha nem létezik az 'Alaprajz' könyvtár -> létrehozzuk
    If (Not DirectoryExists(GetCurrentDir+'\'+ALAPRAJZDIR)) Then
      //ha nem sikerült létrehozni -> hibaüzenet
      If (Not CreateDir(GetCurrentDir+'\'+ALAPRAJZDIR)) Then
        Raise Exception.Create('Nem tudom a könyvtárat létrehozni!');
    Result:=GetCurrentDir+'\'+ALAPRAJZDIR+'\'+SubDir;
    //ha nem létezik az épületet tartalmazó könyvtár -> létrehozzuk
    If (Not DirectoryExists(Result)) Then
      //ha nem sikerült létrehozni -> hibaüzenet
      If (Not CreateDir(Result)) Then
        Raise Exception.Create('Nem tudom a könyvtárat létrehozni!');
    SetCurrentDir(Result);
  End;
End;

//visszaadja a paraméterben átadott útvonalból az aktuális könyvtárat
Function AktDirNev(Const Dir: String): String;
Var S : String;
    I : Integer;
Begin
  Result:='';
  S:=Dir;
  I:=Length(S);
  //megkeresi az utolsó '\' jelet
  While (I > 1) And (S[I] <> '\') Do Dec(I);
  //ha megvan
  If (S[I] = '\') Then
  Begin
    //töröljük a sztringet elejétõl a '\' jelig
    System.Delete(S,1,I);
    Result:=S;
  End;
End;

//az alias nevet átállítjuk a paraméterben átadott könyvtárra
Procedure AliasModosit;
Var AParams : TStringList;
Begin
  //ha jó a paraméter
  If (Dir <> '') Then
  Begin
    AParams:=TStringList.Create;
    Try
      AParams.Clear;
      AParams.Add('PATH='+Dir);
      Session.ModifyAlias(sAlias,AParams);
      Session.SaveConfigFile;
    Finally
      FreeAndNil(AParams);
    End;
  End;
End;

//felteszi a Szoveg kérdést
//ha 'Igen' lett lenyomva -> True, különben -> False
Function Kerdes(Szoveg: String) : Boolean;
Var PSzov : PChar;
Begin
  PSzov:='';
  StrPCopy(PSzov,Szoveg);
  If (Application.MessageBox(PSzov,'Kérdés',MB_YesNo) = IDYES) Then Result:=True
    Else Result:=False;
End;

//EpuletTabla mentése
Procedure EpuletTablaMentes;
Var TbNames     : TStringList;
    EpuletIni   : TIniFile;
    DirName     : String;
    RegiDir     : String;
Begin
  RegiDir:=ExtractFilePath(ParamStr(0));
  //megnyitjuk az EpuletNev nevû könyvtárat
  DirName:=KonyvtarMegnyit(EpuletNev);
  //ráállítjuk az alias-t
  AliasModosit(DirName);
  TbNames:=TStringList.Create;
  Try
    //lekérdezzük, hogy létezik-e az adatbázis
    Session.GetTableNames(sAlias,'',False,False,TbNames);
    //ha létezik, akkor kiürítjük
    If (TbNames.IndexOf(EpuletNev) >= 0) Then
    Begin
      With EpuletTabla Do
      Begin
        Active:=False;
        DatabaseName:=sAlias;
        TableName:=DirName+'\'+sAlaprajz+sKit;
        TableType:=ttParadox;
        Exclusive:=True;
        EmptyTable;
        Exclusive:=False;
      End;
    End
    //ha nem létezik -> létrehozzuk
    Else Begin
      //Ini fájl létrehozása és mentése
      EpuletIni:=TIniFile.Create(DirName+'\'+EpuletNev+'.ini');
      Try
        EpuletIni.WriteInteger('Beállítások','EpuletMeret',AlapMeret);
        EpuletIni.WriteInteger('Beállítások','EgysegMeret',EgysMeret);
      Finally
        FreeAndNil(EpuletIni);
      End;
      //tábla készítése
      EpuletTablaKeszit(EpuletTabla,DirName+'\'+sAlaprajz+sKit,ttParadox);
    End;
    //épület lánc mentése a táblába
    EpuletLancMentes(EpLista,EpuletTabla);
  Finally
    FreeAndNil(TbNames);
  End;
  SetCurrentDir(RegiDir);
End;

//ObjektumTabla mentése
Procedure ObjektumTablaMentes;
Var TbNames     : TStringList;
    DirName     : String;
    RegiDir     : String;
Begin
  RegiDir:=ExtractFilePath(ParamStr(0));
  //megnyitjuk az EpuletNev nevû könyvtárat
  DirName:=KonyvtarMegnyit(EpuletNev);
  //ráállítjuk az alias-t
  AliasModosit(DirName);
  TbNames:=TStringList.Create;
  Try
    //lekérdezzük, hogy létezik-e az adatbázis
    Session.GetTableNames (sAlias,'',False,False,TbNames);
    //ha létezik, akkor kiürítjük
    If (TbNames.IndexOf(EpuletNev) >= 0) Then
    Begin
      With ObjektumTabla Do
      Begin
        Active:=False;
        DatabaseName:=sAlias;
        TableName:=DirName+'\'+sObjektum+sKit;
        TableType:=ttParadox;
        Exclusive:=True;
        EmptyTable;
        Exclusive:=False;
      End;
    End
    //ha nem létezik -> létrehozzuk
    Else ObjektumTablaKeszit(ObjektumTabla,DirName+'\'+sObjektum+sKit,ttParadox);
    //objektum lánc mentése a táblába
    ObjektumLancMentes(EpLista,ObjektumTabla,ObjLista);
  Finally
    FreeAndNil(TbNames);
  End;
  SetCurrentDir(RegiDir);
End;

//BerendezesTabla mentése
Procedure BerendezesTablaMentes;
Var TbNames     : TStringList;
    DirName     : String;
    RegiDir     : String;
Begin
  RegiDir:=ExtractFilePath(ParamStr(0));
  //megnyitjuk az EpuletNev nevû könyvtárat
  DirName:=KonyvtarMegnyit(EpuletNev);
  //ráállítjuk az alias-t
  AliasModosit(DirName);
  TbNames:=TStringList.Create;
  Try
    //lekérdezzük, hogy létezik-e az adatbázis
    Session.GetTableNames (sAlias,'',False,False,TbNames);
    //ha létezik, akkor kiürítjük
    If (TbNames.IndexOf(EpuletNev) >= 0) Then
    Begin
      With BerendezesTabla Do
      Begin
        Active:=False;
        DatabaseName:=sAlias;
        TableName:=DirName+'\'+sBerendezes+sKit;
        TableType:=ttParadox;
        Exclusive:=True;
        EmptyTable;
        Exclusive:=False;
      End;
    End
    //ha nem létezik -> létrehozzuk
    Else BerendezesTablaKeszit(BerendezesTabla,DirName+'\'+sBerendezes+sKit,ttParadox);
    //berendezés lánc mentése a táblába
    BerendezesLancMentes(EpLista,ObjLista,BerendezesTabla,BerendLista);
  Finally
    FreeAndNil(TbNames);
  End;
  SetCurrentDir(RegiDir);
End;

//épület lánc mentése a táblába
Procedure EpuletLancMentes;
Var Index      : Integer;
    AlakMut    : Pointer;
    RegiEpLanc : PEpuletEgyseg;
Begin
  //ha a EpLista lánc létezik és nem üres
  If (EpLista <> Nil) And (EpLista.Elso <> Nil) Then
  Begin
    //tábla megnyitása
    EpuletTabla.Open;
    Index:=0;
    RegiEpLanc:=EpLista.Aktualis;
    EpLista.Aktualis:=EpLista.Elso;
    //végigmegyünk az EpLista láncon ( az épületegységeken )
    While (EpLista.Aktualis <> Nil) Do
    Begin
      AlakzatLanc:=EpLista.Aktualis.AlakzatLancMutato;
      AlakzatLanc.Aktualis:=AlakzatLanc.Elso;
      //végigmegyünk az AlakzatLanc láncon ( az alakzatokon )
      While (AlakzatLanc.Aktualis <> Nil) Do
      Begin
        AlakMut:=AlakzatLanc.Aktualis.AlakMut;
        EpuletTul.DT:=AlakzatLanc.Aktualis.Tipus;
        With EpuletTabla Do
        Begin
          //új rekord beszúrása a táblába
          Insert;
          If (EpuletTabla.TableType = ttParadox) Then
          Begin
            Inc(Index);
            FieldByName('SorIndex').Value:=Index;
          End;
          FieldByName('EgysegNev').Value:=EpLista.Aktualis.EgysegNev;
          //az alakzat típusa szerint mentjük
          Case EpuletTul.DT Of
            dtAjto      : Begin
                            FieldByName('AlakSorrend').Value:=1;
                            FieldByName('Tipus').Value:=TDrawingTool(PAjtoAlakzat(AlakMut)^.Tipus);
                            FieldByName('Szog').Value:=PAjtoAlakzat(AlakMut)^.Szog;
                            Case PAjtoAlakzat(AlakMut)^.PenStyle Of
                              psSolid : FieldByName('PenStyle').Value:=TPenStyle(psSolid);
                              psDot   : FieldByName('PenStyle').Value:=TPenStyle(psDot);
                            End;
                            FieldByName('PenColor').Value:=PAjtoAlakzat(AlakMut)^.PenColor;
                            FieldByName('PenMeret').Value:=PAjtoAlakzat(AlakMut)^.PenMeret;
                            FieldByName('K1X').Value:=PAjtoAlakzat(AlakMut)^.Koord[1].X;
                            FieldByName('K1Y').Value:=PAjtoAlakzat(AlakMut)^.Koord[1].Y;
                            FieldByName('K2X').Value:=PAjtoAlakzat(AlakMut)^.Koord[2].X;
                            FieldByName('K2Y').Value:=PAjtoAlakzat(AlakMut)^.Koord[2].Y;
                            FieldByName('K3X').Value:=PAjtoAlakzat(AlakMut)^.Koord[3].X;
                            FieldByName('K3Y').Value:=PAjtoAlakzat(AlakMut)^.Koord[3].Y;
                            FieldByName('K4X').Value:=PAjtoAlakzat(AlakMut)^.Koord[4].X;
                            FieldByName('K4Y').Value:=PAjtoAlakzat(AlakMut)^.Koord[4].Y;
                          End;
            dtAblak     : Begin
                            FieldByName('AlakSorrend').Value:=1;
                            FieldByName('Tipus').Value:=TDrawingTool(PAblakAlakzat(AlakMut)^.Tipus);
                            FieldByName('Szog').Value:=PAblakAlakzat(AlakMut)^.Szog;
                            Case PAblakAlakzat(AlakMut)^.PenStyle Of
                              psSolid : FieldByName('PenStyle').Value:=TPenStyle(psSolid);
                              psDot   : FieldByName('PenStyle').Value:=TPenStyle(psDot);
                            End;
                            FieldByName('PenColor').Value:=PAblakAlakzat(AlakMut)^.PenColor;
                            FieldByName('PenMeret').Value:=PAblakAlakzat(AlakMut)^.PenMeret;
                            FieldByName('K1X').Value:=PAblakAlakzat(AlakMut)^.Koord[1].X;
                            FieldByName('K1Y').Value:=PAblakAlakzat(AlakMut)^.Koord[1].Y;
                            FieldByName('K2X').Value:=PAblakAlakzat(AlakMut)^.Koord[2].X;
                            FieldByName('K2Y').Value:=PAblakAlakzat(AlakMut)^.Koord[2].Y;
                            FieldByName('K3X').Value:=PAblakAlakzat(AlakMut)^.Koord[3].X;
                            FieldByName('K3Y').Value:=PAblakAlakzat(AlakMut)^.Koord[3].Y;
                            FieldByName('K4X').Value:=PAblakAlakzat(AlakMut)^.Koord[4].X;
                            FieldByName('K4Y').Value:=PAblakAlakzat(AlakMut)^.Koord[4].Y;
                          End;
            dtVonal     : Begin
                            FieldByName('AlakSorrend').Value:=0;
                            FieldByName('Tipus').Value:=TDrawingTool(PVonalAlakzat(AlakMut)^.Tipus);
                            FieldByName('Szog').Value:=PVonalAlakzat(AlakMut)^.Szog;
                            Case PVonalAlakzat(AlakMut)^.PenStyle Of
                              psSolid : FieldByName('PenStyle').Value:=TPenStyle(psSolid);
                              psDot   : FieldByName('PenStyle').Value:=TPenStyle(psDot);
                            End;
                            FieldByName('PenColor').Value:=PVonalAlakzat(AlakMut)^.PenColor;
                            FieldByName('PenMeret').Value:=PVonalAlakzat(AlakMut)^.PenMeret;
                            FieldByName('K1X').Value:=PVonalAlakzat(AlakMut)^.Koord[1].X;
                            FieldByName('K1Y').Value:=PVonalAlakzat(AlakMut)^.Koord[1].Y;
                            FieldByName('K2X').Value:=PVonalAlakzat(AlakMut)^.Koord[2].X;
                            FieldByName('K2Y').Value:=PVonalAlakzat(AlakMut)^.Koord[2].Y;
                          End;
            dtNegyzet   : Begin
                            FieldByName('AlakSorrend').Value:=0;
                            FieldByName('Tipus').Value:=TDrawingTool(PNegyzetAlakzat(AlakMut)^.Tipus);
                            FieldByName('Szog').Value:=PNegyzetAlakzat(AlakMut)^.Szog;
                            Case PNegyzetAlakzat(AlakMut)^.PenStyle Of
                              psSolid : FieldByName('PenStyle').Value:=TPenStyle(psSolid);
                              psDot   : FieldByName('PenStyle').Value:=TPenStyle(psDot);
                            End;
                            FieldByName('PenColor').Value:=PNegyzetAlakzat(AlakMut)^.PenColor;
                            FieldByName('PenMeret').Value:=PNegyzetAlakzat(AlakMut)^.PenMeret;
                            FieldByName('K1X').Value:=PNegyzetAlakzat(AlakMut)^.Koord[1].X;
                            FieldByName('K1Y').Value:=PNegyzetAlakzat(AlakMut)^.Koord[1].Y;
                            FieldByName('K2X').Value:=PNegyzetAlakzat(AlakMut)^.Koord[2].X;
                            FieldByName('K2Y').Value:=PNegyzetAlakzat(AlakMut)^.Koord[2].Y;
                            FieldByName('K3X').Value:=PNegyzetAlakzat(AlakMut)^.Koord[3].X;
                            FieldByName('K3Y').Value:=PNegyzetAlakzat(AlakMut)^.Koord[3].Y;
                            FieldByName('K4X').Value:=PNegyzetAlakzat(AlakMut)^.Koord[4].X;
                            FieldByName('K4Y').Value:=PNegyzetAlakzat(AlakMut)^.Koord[4].Y;
                          End;
            dtEllipszis : Begin
                            FieldByName('AlakSorrend').Value:=0;
                            FieldByName('Tipus').Value:=TDrawingTool(PEllipszisAlakzat(AlakMut)^.Tipus);
                            FieldByName('Szog').Value:=PEllipszisAlakzat(AlakMut)^.Szog;
                            Case PEllipszisAlakzat(AlakMut)^.PenStyle Of
                              psSolid : FieldByName('PenStyle').Value:=TPenStyle(psSolid);
                              psDot   : FieldByName('PenStyle').Value:=TPenStyle(psDot);
                            End;
                            FieldByName('PenColor').Value:=PEllipszisAlakzat(AlakMut)^.PenColor;
                            FieldByName('PenMeret').Value:=PEllipszisAlakzat(AlakMut)^.PenMeret;
                            FieldByName('K1X').Value:=PEllipszisAlakzat(AlakMut)^.Koord[1].X;
                            FieldByName('K1Y').Value:=PEllipszisAlakzat(AlakMut)^.Koord[1].Y;
                            FieldByName('K2X').Value:=PEllipszisAlakzat(AlakMut)^.Koord[2].X;
                            FieldByName('K2Y').Value:=PEllipszisAlakzat(AlakMut)^.Koord[2].Y;
                            FieldByName('K3X').Value:=PEllipszisAlakzat(AlakMut)^.Kozep.X;
                            FieldByName('K3Y').Value:=PEllipszisAlakzat(AlakMut)^.Kozep.Y;
                            FieldByName('A').Value:=PEllipszisAlakzat(AlakMut)^.A;
                            FieldByName('B').Value:=PEllipszisAlakzat(AlakMut)^.B;
                   End;
          End;
          //elmentjük az új rekordot
          Post;
        End;
        //vesszük a következõ alakzatot
        AlakzatLanc.Aktualis:=AlakzatLanc.Aktualis.Kovetkezo;
      End;
      //vesszük a következõ épületegységet
      EpLista.Aktualis:=EpLista.Aktualis.Kovetkezo;
    End;
    EpLista.Aktualis:=RegiEpLanc;
    EpLista.Valtozas:=False;
    //bezárjuk az adatbázist
    EpuletTabla.Close;
  End;
End;

Procedure ObjektumLancMentes;
Var I         : Integer;
    TombHossz : Integer;
    Mentes    : Boolean;
    Vizsgal   : Boolean;
    Nev       : String;
    Szoveg    : String;
    PontTomb  : TPontKoordTomb;
Begin
  Nev:='';
  Szoveg:='';
  Mentes:=False;
  //ha a ObjLista lánc létezik és nem üres
  If (ObjLista <> Nil) And (ObjLista.Elso <> Nil) Then
  Begin
    //tábla megnyitása
    ObjektumTabla.Open;
    SetLength(PontTomb,0);
    ObjLista.Aktualis:=ObjLista.Elso;
    //végigmegyünk az ObjLista láncon
    While (ObjLista.Aktualis <> Nil) Do
    Begin
      //azonos nevûek kizárása
      If (Nev <> ObjLista.Aktualis.ObjMut.EpuletEgyseg.EgysegNev) Then
      Begin
        Vizsgal:=EpLista.EgysegUres(ObjLista.Aktualis.ObjMut.EpuletEgyseg.EgysegNev);
        //ha nem üres az épületegység
        If Vizsgal Then
        Begin
          //lehet menteni
          Mentes:=True;
          Nev:=ObjLista.Aktualis.ObjMut.EpuletEgyseg.EgysegNev;
        End
        //ha üres, vagyis nincs rajza
        Else Begin
          Szoveg:='A(z) '+ObjLista.Aktualis.ObjMut.Nev+' nevû objektum a(z) '+
            ObjLista.Aktualis.ObjMut.EpuletEgyseg.EgysegNev+
            ' nevû épületegységben van,'+#13+
            'amelynek nincs alaprajza! Menti a(z) '+ObjLista.Aktualis.ObjMut.Nev+
            ' objektumot?';
          If Kerdes(Szoveg)Then Mentes:=True
            Else Mentes:=False;
          Nev:=ObjLista.Aktualis.ObjMut.EpuletEgyseg.EgysegNev;
        End;
      End;
      //ha lehet menteni
      If Mentes Then
      Begin
        PontTomb:=ObjLista.Aktualis.ObjMut.Pontok;
        TombHossz:=Length(PontTomb)-1;
        //lementjük az objektumot
        With ObjektumTabla Do
        Begin
          //koordináták eltárolása
          For I:=0 To TombHossz Do
          Begin
            Insert;
            FieldByName('EgysegNev').Value:=ObjLista.Aktualis.ObjMut.EpuletEgyseg.EgysegNev;
            FieldByName('ObjNev').Value:=ObjLista.Aktualis.ObjMut.Nev;
            FieldByName('id').Value:=I;
            FieldByName('Meret').Value:=TombHossz+1;
            FieldByName('X').Value:=PontTomb[i].X;
            FieldByName('Y').Value:=PontTomb[i].Y;
          End;
          Post;
        End;
      End;
      ObjLista.Aktualis:=ObjLista.Aktualis.Kovetkezo;
    End;
    //bezárjuk az adatbázist
    ObjektumTabla.Close;
    ObjLista.Valtozas:=False;
  End;
End;

Procedure BerendezesLancMentes;
Var Mentes    : Boolean;
    Vizsgal   : Boolean;
    Nev       : String;
    Szoveg    : String;
Begin
  Nev:='';
  Szoveg:='';
  Mentes:=False;
  //ha a BerendLista lánc létezik és nem üres
  If (BerendLista <> Nil) And (BerendLista.Elso <> Nil) Then
  Begin
    //tábla megnyitása
    BerendezesTabla.Open;
    BerendLista.Aktualis:=BerendLista.Elso;
    //végigmegyünk az BerendLista láncon
    While (BerendLista.Aktualis <> Nil) Do
    Begin
      //azonos nevûek kizárása
      If (Nev <> BerendLista.Aktualis.EpuletEgyseg) Then
      Begin
        Vizsgal:=EpLista.EgysegUres(BerendLista.Aktualis.EpuletEgyseg);
        //ha nem üres az épületegység
        If Vizsgal Then
        Begin
          //lehet menteni
          Mentes:=True;
          Nev:=BerendLista.Aktualis.EpuletEgyseg;
        End
        //ha üres, vagyis nincs rajza
        Else Begin
          Szoveg:='A(z) '+BerendLista.Aktualis.BerendezesNev+
            ' nevû berendezés a(z) '+BerendLista.Aktualis.EpuletEgyseg+
            ' nevû épületegységben van,'+#13+
            'amelynek nincs alaprajza! Menti a(z) '+
            BerendLista.Aktualis.BerendezesNev+' berendezést?';
          If Kerdes(Szoveg) Then Mentes:=True
            Else Mentes:=False;
          Nev:=BerendLista.Aktualis.EpuletEgyseg;
        End;
      End;
      //ha lehet menteni
      If Mentes Then
      Begin
        //lementjük a berendezést
        With BerendezesTabla Do
        Begin
          Insert;
          FieldByName('Tipus').Value:=TBerendezesTip(BerendLista.Aktualis.BerendezesTip);
          FieldByName('EgysegNev').Value:=BerendLista.Aktualis.EpuletEgyseg;
          FieldByName('BerendNev').Value:=BerendLista.Aktualis.BerendezesNev;
          FieldByName('id').Value:=BerendLista.Aktualis.ID;
          If ObjLista.Keres(BerendLista.Aktualis.ObjektumNev) Then
            FieldByName('ObjNev').Value:=BerendLista.Aktualis.ObjektumNev
          Else FieldByName('ObjNev').Value:='Egyikhez sem';
          Post;
        End;
      End;
      BerendLista.Aktualis:=BerendLista.Aktualis.Kovetkezo;
    End;
    //bezárjuk az adatbázist
    BerendezesTabla.Close;
    BerendLista.Valtozas:=False;
  End;
End;

//EpuletTabla létrehozása
Procedure EpuletTablaKeszit;
Begin
  Tabla.Close;
  Tabla.TableName:=Nev;
  Tabla.TableType:=Tipus;
  With Tabla.FieldDefs Do
  Begin
    Clear;
    If (Tabla.TableType = ttParadox) Then
      With AddFieldDef Do
      Begin
        Name:='SorIndex';
        DataType:=ftSmallInt;
        Required:=True;
      End;
    With AddFieldDef Do
    Begin
      Name:='AlakSorrend';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='EgysegNev';
      DataType:=ftString;
      Size:=25;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='Tipus';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='Szog';
      DataType:=ftSmallInt;
      Required:=False;
    End;
    With AddFieldDef Do
    Begin
      Name:='PenStyle';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='PenColor';
      DataType:=ftInteger;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='PenMeret';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='K1X';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='K1Y';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='K2X';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='K2Y';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='K3X';
      DataType:=ftSmallInt;
      Required:=False;
    End;
    With AddFieldDef Do
    Begin
      Name:='K3Y';
      DataType:=ftSmallInt;
      Required:=False;
    End;
    With AddFieldDef Do
    Begin
      Name:='K4X';
      DataType:=ftSmallInt;
      Required:=False;
    End;
    With AddFieldDef Do
    Begin
      Name:='K4Y';
      DataType:=ftSmallInt;
      Required:=False;
    End;
    With AddFieldDef Do
    Begin
      Name:='A';
      DataType:=ftFloat;
      Required:=False;
    End;
    With AddFieldDef Do
    Begin
      Name:='B';
      DataType:=ftFloat;
      Required:=False;
    End;
  End;
  With Tabla.IndexDefs Do
  Begin
    Clear;
    If (Tabla.TableType = ttParadox) Then
      With AddIndexDef Do
      Begin
        Name:='';
        Fields:='SorIndex';
        Options:=[ixPrimary];
      End;
    With AddIndexDef Do
    Begin
      Name:=INDEXNEV;
      Fields:='AlakSorrend';
      Options:=[ixCaseInsensitive];
   End;
  End;
  Tabla.CreateTable;
End;

//ObjektumTabla létrehozása
Procedure ObjektumTablaKeszit;
Begin
  Tabla.Close;
  Tabla.TableName:=Nev;
  Tabla.TableType:=Tipus;
  With Tabla.FieldDefs Do
  Begin
    Clear;
    With AddFieldDef Do
    Begin
      Name:='EgysegNev';
      DataType:=ftString;
      Size:=25;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='ObjNev';
      DataType:=ftString;
      Size:=25;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='id';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='Meret';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='X';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='Y';
      DataType:=ftSmallInt;
      Required:=True;
    End;
  End;
  Tabla.CreateTable;
End;

//BerendezesTabla létrehozása
Procedure BerendezesTablaKeszit;
Begin
  Tabla.Close;
  Tabla.TableName:=Nev;
  Tabla.TableType:=Tipus;
  With Tabla.FieldDefs Do
  Begin
    Clear;
    With AddFieldDef Do
    Begin
      Name:='Tipus';
      DataType:=ftSmallInt;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='EgysegNev';
      DataType:=ftString;
      Size:=25;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='ObjNev';
      DataType:=ftString;
      Size:=25;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='BerendNev';
      DataType:=ftString;
      Size:=25;
      Required:=True;
    End;
    With AddFieldDef Do
    Begin
      Name:='id';
      DataType:=ftSmallInt;
      Required:=True;
    End;
  End;
  Tabla.CreateTable;
End;

End.
