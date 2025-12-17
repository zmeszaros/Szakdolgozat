Unit VezerloUnit;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ImgList, ExtCtrls, ToolWin, Db, DBTables, StdCtrls, Math,
  Inifiles, FileTablaUnit, UtilUnit, EpuletLancUnit, ObjektumUnit, KodolasUnit,
  BerendezesekLancUnit, RajzolasUnit, ZoomUnit, PontLancUnit, PenUnit, Grids,
  BeallitUnit, FormFestoUnit, BerendDlgUnit, MegnyitasUnit, SyncObjs, DlgUnit,
  RiasztoBeallUnit, HomeroBeallUnit, TuzjelzoBeallUnit, HomeroLancUnit, CPort,
  KapcsBerendLancUnit, InditUnit, RiasztoLancUnit, TuzjelzoLancUnit, Buttons,
  VegberendDlgUnit, VegBerendLancUnit, FutotestDlgUnit, EgyebDlgUnit, FileCtrl,
  BerendTablaUnit, BerendInspUnit, KuldThreadUnit, NyugtaDlgUnit, CPortCtl,
  HangThreadUnit, NaploDlgUnit, DataModulUnit;

Const NAPLOKDIR = 'Naplo';   //naplófájlok könyvtára
      NAPLOKIT  = '.npl';    //naplófájl kiterjesztése
      SUGOFILE  = '.\SÚGÓ.HLP';

Type
  TPictIndexTomb = Array Of Integer;

  TFormVezerlo = Class(TForm)
    StatusBar1           : TStatusBar;
    ToolBar1             : TToolBar;
    ImageList1           : TImageList;
    ToolButton2          : TToolButton;
    N1                   : TMenuItem;
    N3                   : TMenuItem;
    MainMenu1            : TMainMenu;
    MegnyitasMenu        : TMenuItem;
    Kilepes              : TMenuItem;
    Megnyitas            : TMenuItem;
    MentesMenu           : TMenuItem;
    BezarasMenu          : TMenuItem;
    Belltsok1            : TMenuItem;
    BerendezesekMenu     : TMenuItem;
    AltBellitasokMenu    : TMenuItem;
    HomeroMenu           : TMenuItem;
    RiasztoMenu          : TMenuItem;
    TuzjelzoMenu         : TMenuItem;
    FutotestMenu         : TMenuItem;
    EgyebMenu            : TMenuItem;
    ComboBox1            : TComboBox;
    Splitter1            : TSplitter;
    Label1               : TLabel;
    ToolButton1          : TToolButton;
    BerendListaMenu      : TMenuItem;
    N2                   : TMenuItem;
    ComPort              : TComPort;
    ToolButton3          : TToolButton;
    AlaprajzBtn          : TSpeedButton;
    AttekintBtn          : TSpeedButton;
    RichEdit1            : TRichEdit;
    ZoomInButton         : TSpeedButton;
    ZoomOutButton        : TSpeedButton;
    KilepesButton        : TSpeedButton;
    MegnyitasButton      : TSpeedButton;
    MentesButton         : TSpeedButton;
    ToolButton5          : TToolButton;
    N4                   : TMenuItem;
    ConnectMenu          : TMenuItem;
    StatusBarTimer       : TTimer;
    HangTimer            : TTimer;
    DisconnectMenu       : TMenuItem;
    CloseButton          : TSpeedButton;
    NaploMenu            : TMenuItem;
    FoPanel              : TPanel;
    RajzScrollBox        : TScrollBox;
    Image1               : TImage;
    AttekintScrollBox    : TScrollBox;
    AttekintGrid         : TStringGrid;
    StatuszPanel         : TPanel;
    NyugtaPanel          : TPanel;
    LedPanel             : TPanel;
    ComLed1              : TComLed;
    ComLed2              : TComLed;
    ComLed3              : TComLed;
    Label2               : TLabel;
    Bevel1               : TBevel;
    Label3               : TLabel;
    Bevel2               : TBevel;
    Label4               : TLabel;
    Image2               : TImage;
    IdoTimer             : TTimer;
    KilepesTimer         : TTimer;
    KapcsolatTimer       : TTimer;
    Help1                : TMenuItem;
    SugoMenu             : TMenuItem;
    NevjegyMenu          : TMenuItem;
    N5                   : TMenuItem;
    Procedure KilepesClick(Sender: TObject);
    Procedure KilepesButtoClick(Sender: TObject);
    Procedure MegnyitasClick(Sender: TObject);
    Procedure MegnyitasButtoClick(Sender: TObject);
    Procedure ComboBox1Change(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure FormActivate(Sender: TObject);
    Procedure BerendezesekMenuClick(Sender: TObject);
    Procedure AltBellitasokMenuClick(Sender: TObject);
    Procedure HomeroMenuClick(Sender: TObject);
    Procedure RiasztoMenuClick(Sender: TObject);
    Procedure TuzjelzoMenuClick(Sender: TObject);
    Procedure ZoomInButtonClick(Sender: TObject);
    Procedure ZoomOutButtonClick(Sender: TObject);
    Procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
              Shift: TShiftState; X, Y: Integer);
    Procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
              Shift: TShiftState; X, Y: Integer);
    Procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    Procedure FutotestMenuClick(Sender: TObject);
    Procedure EgyebMenuClick(Sender: TObject);
    Procedure MentesButtonClick(Sender: TObject);
    Procedure BerendListaMenuClick(Sender: TObject);
    Procedure ComPortRxChar(Sender: TObject; Count: Integer);
    Procedure ComPortAfterClose(Sender: TObject);
    Procedure ComPortAfterOpen(Sender: TObject);
    Procedure AttekintBtnClick(Sender: TObject);
    Procedure AlaprajzBtnClick(Sender: TObject);
    Procedure AttekintGridDrawCell(Sender: TObject; ACol, ARow: Integer;
              Rect: TRect; State: TGridDrawState);
    Procedure StatusBarTimerTimer(Sender: TObject);
    Procedure HangTimerTimer(Sender: TObject);
    Procedure BezarasMenuClick(Sender: TObject);
    Procedure ConnectMenuClick(Sender: TObject);
    Procedure DisconnectMenuClick(Sender: TObject);
    Procedure CloseButtonClick(Sender: TObject);
    Procedure NaploMenuClick(Sender: TObject);
    Procedure NyugtaPanelMouseDown(Sender: TObject; Button: TMouseButton;
              Shift: TShiftState; X, Y: Integer);
    Procedure NyugtaPanelMouseUp(Sender: TObject; Button: TMouseButton;
              Shift: TShiftState; X, Y: Integer);
    Procedure NyugtaPanelClick(Sender: TObject);
    Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    Procedure MentesMenuClick(Sender: TObject);
    Procedure FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure IdoTimerTimer(Sender: TObject);
    Procedure ComPortBeforeClose(Sender: TObject);
    Procedure KilepesTimerTimer(Sender: TObject);
    Procedure KapcsolatTimerTimer(Sender: TObject);
    Procedure NevjegyMenuClick(Sender: TObject);
    Procedure RichEdit1Enter(Sender: TObject);
    Procedure SugoMenuClick(Sender: TObject);
  Private
    EgysegNev        : String;            //aktuális épületegység neve
    EpuletNev        : String;            //az épület neve
    EpuletDir        : String;            //az épület-adatbázis könyvtára
    EpuletPath       : String;            //az épület-adatbázis elérési útja
    NaploDir         : String;            //naplófájlok könyvtára
    NaploFile        : String;            //naplófáj neve
    NaploDatum       : String;            //naplófáj dátuma
    NaploSzam        : Integer;           //naplófáj sorszáma
    Hang             : Integer;           //figyelmeztetõ hang típusa
    BitmapMeret      : Integer;           //rajzasztal mérete
    AlaprajzMeret    : Integer;           //alaprajz mérete
    EgysegMeret      : Integer;           //egy pixel hány mm
    Indulas          : Boolean;           //igaz, ha a program elindul
    EgerDown         : Boolean;           //le van-e nyomva az egérgomb
    RegiMouseMove    : TPoint;            //egér mozgását követi
    RegiEgerKurzor   : TCursor;           //egér mozgását követi
    PontLista        : TPontLista;        //koord-kat tartalmazó lánc
    HangThread       : THangThread;       //figyelmeztetõ hang vezérlõ szál
    KuldThread       : TKuldThread;       //kommunikációs szál
    PortAllapot      : TPortAllapot;      //szabad-e a vonal
    UzenetLista      : TUzenetLista;      //az elküldendõ üzenetek listája
    HomeroLista      : THomeroLista;      //hõmérõk listája
    EpuletLista      : TEpuletLista;      //az épület szerkezetét tartalmazó lánc
    RiasztoLista     : TRiasztoLista;     //riasztók listája
    TuzjelzoLista    : TTuzjelzoLista;    //tûzjelzõk listája
    ObjektumLista    : TObjektumLista;    //objektumok lánca
    VegBerendLista   : TVegBerendLista;   //végberendezések listája
    BerendezesLista  : TBerendezesLista;  //összes berendezések listája
    KapcsBerendLista : TKapcsBerendLista; //egy berend-hez kapcsolódó berend-ek
    OsszLista_Dlg    : TOsszesLista_Dlg;  //az összes berend.listát tartalmazza
    AllapotIndexTomb : TPictIndexTomb;    //berendezések állapotát rögzíti
    MertErtIndexTomb : TPictIndexTomb;    //hõmérõn mért értékeket rögzíti
    Function ValtozasAll : Boolean;
    Function DatumAtAlakit : String;
    Function GetComKapcsolat : Boolean;
    Function EpuletLancBetoltes : Boolean;
    Function ComboFeltolt(Berend: String) : TStrings;
    Function KonyvtarMegnyit(Const SubDir: String) : String;
    Function LehetRajzolni(ObjElem: PObjektumLanc) : Boolean;
    Function GetAttekintDown : Boolean;
    Function TablakBetolt : Boolean;
    Function BerendFelToltesek : Boolean;
    Procedure KiUrit;
    Procedure HelpOpen;
    Procedure MenuBtnAllit;
    Procedure NaploBeallit;
    Procedure NaploIndMent;
    Procedure NaploIndBetolt;
    Procedure RiasztasHelyreUgras(EpEgys: String);
    Procedure EpuletEgysegValtas;
    Procedure SetBerendInsp(Ertek: Boolean);
    Procedure UzenetKezelo(Dekod: TAdatUzenetTomb);
    Procedure StatusBarKiIr(Str: String);
    Procedure AttekintGridFeltolt;
    Procedure KiUrites;
    Procedure Betoltes(FileNev: String);
    Procedure AsztalUjraRajzol; Overload;
    Procedure AsztalUjraRajzol(Szin: TColor); Overload;
    Procedure RajzasztalLetrehoz(Const Meret: Integer);
    Procedure HomerokBeallKuld;
    Procedure RiasztoKuld(Mutato: PRiasztoElem);
    Procedure TuzjelzoKuld(Mutato: PTuzjelzoElem);
    Procedure HomeroEsemeny(Dekod: TAdatUzenetTomb);
    Procedure RiasztoEsemeny(Dekod: TAdatUzenetTomb);
    Procedure TuzjelzoEsemeny(Dekod: TAdatUzenetTomb);
    Procedure FutotestEsemeny(Dekod: TAdatUzenetTomb);
    Procedure EgyebEsemeny(Dekod: TAdatUzenetTomb);
    Procedure RendszerUzenetKuld(Str: String);
    Procedure DoQueryEndSession(Var Mes: TWMQueryEndSession); Message WM_QUERYENDSESSION;
    Procedure Ertelmezo(Str: String);
    Procedure ObjektumRajzol(ObjElem: PObjektumLanc);
    Procedure ObjRajzolVizsgal;
  Public
    TextAttributes : TTextAttrib;  //szöveg tulajdonságai
    Property VanKapcsolat : Boolean Read GetComKapcsolat;
    Property VanHang : TTimer Read HangTimer Write HangTimer;
    Property BerendInsp : Boolean Write SetBerendInsp;
    Property Attekint : Boolean Read GetAttekintDown;
    Procedure AttekintGridFrissit;
    Procedure MemoIr(Ido: Boolean; Str: String; Szin: TColor);
    Procedure RiasztasokNyugat;
    Procedure AdatUzenetKuld(Prior: Boolean; Tomb: TAdatUzenetTomb;
              Szoveg: String; Atb: TTextAttrib);
  End;

Var FormVezerlo : TFormVezerlo;

Implementation

uses AboutUnit;

{$R *.DFM}

//ha a 'Windows leállítása' üzenetet kapjuk
Procedure TFormVezerlo.DoQueryEndSession(Var Mes: TWMQueryEndSession);
Var Nev   : Array[0..127] Of Char;
    Hossz : Cardinal;
Begin
  Mes.Result:=0;
  Hossz:=128;
  //a számítógépünk neve
  GetComputerName(@Nev,Hossz);
  //megszakítjuk a leállítást
  AbortSystemShutdown(Nev);
  StatusBarKiIr('A számítógépet nem lehet leállítani addig, amíg a program fut!');
End;

//a help megnyitása
Procedure TFormVezerlo.HelpOpen;
Begin
  //súgófájl megnyitása
  Application.HelpFile:=SUGOFILE;
  Application.HelpCommand(HELP_FINDER,0);
End;

//visszaadja, hogy van-e kapcsolat
//ha van kapcsolat -> True, különben -> False;
Function TFormVezerlo.GetComKapcsolat: Boolean;
Begin
  Result:=ComPort.Connected;
End;

//le van-e nyomva az 'áttekintés' gomb
Function TFormVezerlo.GetAttekintDown: Boolean;
Begin
  Result:=AttekintBtn.Down;
End;

//a dátum sztring átalakítása
Function TFormVezerlo.DatumAtAlakit: String;
Var Pos,I : Integer;
Begin
  //dátum lekérdezése
  Result:=Trim(DateToStr(Date));
  //megkeressük az elsõ '.'-ot
  Pos:=System.Pos('.',Result);
  //mivel két '.' van a dátumban
  For I:=0 To 1 Do
  Begin
    //ha megvan a '.' pozíciója
    If (Pos > 0) Then
    Begin
      //kivesszük a '.'-ot
      System.Delete(Result,Pos,1);
      //és lecseréljük '_'-ra
      System.Insert('_',Result,Pos);
      //ha van a sztringben "fehér" karakter, azokat megkeressük és kivesszük
      While (System.Pos(' ',Result) > 0) Do System.Delete(Result,System.Pos(' ',Result),1);
      //újra megkeressük az elsõ '.'-ot
      Pos:=System.Pos('.',Result);
    End;
  End;
  //ha lenne a végén is, akkor azt is töröljük
  If (Pos > 0) Then System.Delete(Result,Pos,1);
End;

//paraméterben átadott könyvtár megnyitása
Function TFormVezerlo.KonyvtarMegnyit(Const SubDir: String) : String;
Var FoDir : String;
    AlDir : String;
Begin
  Result:='';
  If (SubDir <> '') Then
  Begin
    SetCurrentDir(ExtractFilePath(ParamStr(0))+'..');
    FoDir:=GetCurrentDir;
    SetCurrentDir(ExtractFilePath(ParamStr(0)));
    //ha nincs könyvtár, akkor létrehozza
    If (Not DirectoryExists(FoDir+'\'+NAPLOKDIR)) Then
      If (Not CreateDir(FoDir+'\'+NAPLOKDIR)) Then
        Raise Exception.Create('Nem tudom a könyvtárat létrehozni!');
    AlDir:=FoDir+'\'+NAPLOKDIR+'\'+SubDir;
    //ha nincs alkönyvtár, akkor létrehozza
    If (Not DirectoryExists(AlDir)) Then
      If (Not CreateDir(AlDir)) Then
        Raise Exception.Create('Nem tudom a könyvtárat létrehozni!')
      Else Result:=FoDir+'\'+NAPLOKDIR+'\'+SubDir
    Else Result:=FoDir+'\'+NAPLOKDIR+'\'+SubDir;
  End;
End;

//írás a memo mezõbe és a naplóba
Procedure TFormVezerlo.MemoIr(Ido: Boolean; Str: String; Szin: TColor);
Begin
  RichEdit1.ReadOnly:=False;
  //If (RichEdit1.Lines.Count > 1000) Then RichEdit1.Lines.Delete(0);
  RichEdit1.SelAttributes.Color:=Szin;
  If Ido Then RichEdit1.Lines.Add(MemoIdo+Str)
    Else RichEdit1.Lines.Add(Str);
  Application.ProcessMessages;
  //ha változott a dátum
  If (NaploDatum <> DatumAtAlakit) Then
  Begin
    NaploSzam:=0;
    NaploBeallit;
  End;
  If (Not DirectoryExists(NaploDir)) Then NaploDir:=KonyvtarMegnyit(NaploDatum);
  RichEdit1.Lines.SaveToFile(NaploDir+'\'+NaploFile+NAPLOKIT);
  RichEdit1.ReadOnly:=True;
  If (Not NyugtaPanel.Enabled) Then NyugtaPanel.Enabled:=True;
End;

//új naplóbejegyzés készítése
Procedure TFormVezerlo.NaploBeallit;
Begin
  Inc(NaploSzam);
  NaploIndMent;
  NaploDatum:=DatumAtAlakit;
  NaploDir:=KonyvtarMegnyit(NaploDatum);
  NaploFile:=NaploDatum+'#'+IntToStr(NaploSzam);
End;

//naplóindex betöltése ini-bõl
Procedure TFormVezerlo.NaploIndBetolt;
Var Proba     : String;
    FileName  : String;
    EpuletIni : TIniFile;
Begin
  FileName:=EpuletPath+'\'+EpuletNev+'.ini';
  EpuletIni:=TIniFile.Create(FileName);
  Try
    With EpuletIni Do
    Begin
      Proba:=ReadString('Beállítások','NaploIndex','¤');
      If (Proba = '¤') Then WriteInteger('Beállítások','NaploIndex',0);
      NaploSzam:=ReadInteger('Beállítások','NaploIndex',0);
    End;
  Finally
    FreeAndNil(EpuletIni);
  End;
End;

//naplóindex kiírása ini-be
Procedure TFormVezerlo.NaploIndMent;
Var FileName : String;
    FileIni  : TIniFile;
Begin
  FileName:=EpuletPath+'\'+EpuletNev+'.ini';
  FileIni:=TIniFile.Create(FileName);
  Try
    With FileIni Do WriteInteger('Beállítások','NaploIndex',NaploSzam);
  Finally
    FreeAndNil(FileIni);
  End;
End;

//a combo feltöltése a berendezések nevével
Function TFormVezerlo.ComboFeltolt(Berend: String): TStrings;
Var I : Integer;
Begin
  Result:=TStringList.Create;
  Result.Clear;
  //ha nem üres a lista
  If (Self.BerendezesLista <> Nil) Then
  Begin
    Self.BerendezesLista.TombFeltolt;
    //berendezés nevek hozzáadása a listából
    For I:=0 To High(Self.BerendezesLista.BerendTomb) Do
    Begin
      If (Self.BerendezesLista.BerendTomb[I,3] = Berend) Then
        Result.Add(Self.BerendezesLista.BerendTomb[I,2]);
    End;
  End;
End;

//volt-e változás a listákban
Function TFormVezerlo.ValtozasAll: Boolean;
Begin
  Result:=False;
  If HomeroLista.Valtozas Or RiasztoLista.Valtozas Or TuzjelzoLista.Valtozas Or
    VegBerendLista.Valtozas Or KapcsBerendLista.Valtozas Then Result:=True;
End;

//az áttekintõ táblázat feltöltése
Procedure TFormVezerlo.AttekintGridFeltolt;
Var I : Integer;
Begin
  SetLength(AllapotIndexTomb,0);
  AttekintGrid.RowCount:=2;
  AttekintGrid.Rows[1].Clear;
  AttekintGrid.DoubleBuffered:=True;
  AttekintGrid.Cells[0,0]:='Berendezés neve';
  AttekintGrid.Cells[1,0]:='Azonosító';
  AttekintGrid.Cells[2,0]:='Vezérlés';
  AttekintGrid.Cells[3,0]:='Állapot';
  AttekintGrid.Cells[4,0]:='Aktuális érték';
  AttekintGrid.Cells[5,0]:='Beállított érték';
  If (OsszLista_Dlg <> Nil) And (OsszLista_Dlg.BerendezesList <> Nil) Then
  Begin
    If OsszLista_Dlg.BerendezesList.TombUres Then
      OsszLista_Dlg.BerendezesList.TombFeltolt;
    For I:=0 To High(OsszLista_Dlg.BerendezesList.BerendTomb) Do
    Begin
      SetLength(AllapotIndexTomb,I+1);
      SetLength(MertErtIndexTomb,I+1);
      AllapotIndexTomb[I]:=-1;
      MertErtIndexTomb[I]:=-1;
      AttekintGrid.RowCount:=i+2;
      AttekintGrid.Cells[0,i+1]:=OsszLista_Dlg.BerendezesList.BerendTomb[i,2];
      AttekintGrid.Cells[1,i+1]:=OsszLista_Dlg.BerendezesList.BerendTomb[i,1];
    End;
  End;
End;

//az áttekintõ táblázat celláinak beállítása és festése
Procedure TFormVezerlo.AttekintGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var X,Y,D : Integer;
Begin
  If (BerendezesLista <> Nil) And (BerendezesLista.Elso <> Nil) Then
  Begin
    //a 3. oszlop
    If (ACol = 3) And (ARow > 0) Then
    Begin
      If (AllapotIndexTomb[ARow-1] > -1) Then
      Begin
        AttekintGrid.Canvas.Brush.Color:=clBlack;
        AttekintGrid.Canvas.FrameRect(Rect);
        ImageList1.GetBitmap(AllapotIndexTomb[ARow-1],Image2.Picture.Bitmap);
        D:=AttekintGrid.RowHeights[ARow]-Image2.Picture.Bitmap.Height;
        X:=Rect.Right-Image2.Picture.Graphic.Width-2;
        Y:=Rect.Top+(D Div 2);
        AttekintGrid.Canvas.Draw(X, Y, Image2.Picture.Graphic);
      End
      Else Begin
        AttekintGrid.Canvas.Brush.Color:=clBtnFace;
        AttekintGrid.Canvas.FillRect(Rect);
      End;
    End;
    //a 4. és 5. oszlop
    If (ACol = 4) Or (ACol = 5) And (ARow > 0) Then
    Begin
      If (MertErtIndexTomb[ARow-1] > -1) Then
      Begin
        AttekintGrid.Canvas.Brush.Color:=clBlack;
        AttekintGrid.Canvas.FrameRect(Rect);
      End
      Else Begin
        AttekintGrid.Canvas.Brush.Color:=clBtnFace;
        AttekintGrid.Canvas.FillRect(Rect);
      End;
    End;
  End;
End;

//áttekintõ táblázat frissítése
Procedure TFormVezerlo.AttekintGridFrissit;
Var I,ID         : Integer;
    BerendMut    : PLancElem;
    HomeroMut    : PHomeroElem;
    RiasztoMut   : PRiasztoElem;
    TuzjelzoMut  : PTuzjelzoElem;
    VegBerendMut : PVegBerendElem;
Begin
  If (BerendezesLista <> Nil) Then
  Begin
    //végigmegy a berendezéseken
    For I:=1 To AttekintGrid.RowCount-1 Do
    Begin
      ID:=StrToInt(AttekintGrid.Cells[1,i]);
      If BerendezesLista.KeresID(ID,BerendMut) Then
      Begin
        //az egyes berenezések állapotának megfelelõen frissít
        Case BerendMut.BerendezesTip Of
          btHomero   : Begin
                         MertErtIndexTomb[i-1]:=0;
                         HomeroLista.KeresID(ID,HomeroMut);
                         AttekintGrid.Cells[2,i]:='Automata';
                         AttekintGrid.Cells[4,i]:=IntToStr(HomeroMut.MertErtek)+sCelsius;
                         AttekintGrid.Cells[5,i]:=IntToStr(HomeroMut.BeallErtek)+sCelsius;
                       End;
          btRiaszto  : Begin
                         RiasztoLista.KeresID(ID,RiasztoMut);
                         AttekintGrid.Cells[2,i]:='Automata';
                         If RiasztoMut.Allapot Then
                         Begin
                           If ComPort.Connected Then AllapotIndexTomb[i-1]:=1
                             Else AllapotIndexTomb[i-1]:=0;
                           AttekintGrid.Cells[3,i]:='Riasztás';
                         End
                         Else Begin
                           AllapotIndexTomb[i-1]:=0;
                           AttekintGrid.Cells[3,i]:='Normál';
                         End;
                       End;
          btTuzjelzo : Begin
                         TuzjelzoLista.KeresID(ID,TuzjelzoMut);
                         AttekintGrid.Cells[2,i]:='Automata';
                         If TuzjelzoMut.Allapot Then
                         Begin
                           If ComPort.Connected Then AllapotIndexTomb[i-1]:=1
                             Else AllapotIndexTomb[i-1]:=0;
                           AttekintGrid.Cells[3,i]:='Tûzjelzés';
                         End
                         Else Begin
                           AllapotIndexTomb[i-1]:=0;
                           AttekintGrid.Cells[3,i]:='Normál';
                         End;
                       End;
          btEgyeb,
          btFutotest : Begin
                         VegBerendLista.KeresID(ID,VegBerendMut);
                         If VegBerendMut.Automata Then AttekintGrid.Cells[2,i]:='Automata'
                           Else AttekintGrid.Cells[2,i]:='Kézi';
                         If VegBerendMut.Allapot Then
                         Begin
                           If ComPort.Connected Then AllapotIndexTomb[i-1]:=3
                             Else AllapotIndexTomb[i-1]:=0;
                           AttekintGrid.Cells[3,i]:='Be';
                         End
                         Else Begin
                           If ComPort.Connected Then AllapotIndexTomb[i-1]:=1
                             Else AllapotIndexTomb[i-1]:=0;
                           AttekintGrid.Cells[3,i]:='Ki';
                         End;
                       End;
        End;
      End;
    End;
  End;
End;

//rajzlap létrehozása és beállítása
Procedure TFormVezerlo.RajzasztalLetrehoz(Const Meret: Integer);
Begin
  Try
    RajzasztalKeszit(Self,Image1,Meret);
  Finally
    With RajzScrollBox Do
    Begin
      HorzScrollBar.Visible:=True;
      VertScrollBar.Visible:=True;
      HorzScrollBar.Range:=Meret;
      VertScrollBar.Range:=Meret;
      HorzScrollBar.Position:=0;
      VertScrollBar.Position:=0;
    End;
  End;
End;

//épület betöltése
Function TFormVezerlo.EpuletLancBetoltes : Boolean;
Var Elozo       : Pointer;
    AlakLancMut : PAlakzatLanc;
    EpEgysegMut : PEpuletEgyseg;
Begin
  RajzIniBetolt(Self.EpuletPath,Self.EpuletNev,Self.AlaprajzMeret,Self.EgysegMeret);
  //épület tulajdonságainak alapbeállítása
  If EpuletTul.VE Then
  Begin
    EpuletLista:=Nil;
    AlakzatLanc:=Nil;
    EpuletEgyseg:=Nil;
    EpuletTul.VE:=False;
    ComboBox1.Clear;
  End;
  Image1.Picture.Graphic:=Nil;
  Zoom.Szorzo:=1;
  BitmapMeret:=RAJZMERET;
  RajzasztalLetrehoz(BitmapMeret);
  EpuletLista:=TEpuletLista.Create;
  EpuletLista.Nev:=EpuletNev;
  EpuletLista.EpuletMeret:=AlaprajzMeret;
  EpuletLista.EgysegMeret:=EgysegMeret;
  //betöltés adatbázisból
  With DM.EpuletTable Do
  Begin
    First;
    While (Not EOF) Do
    Begin
      EgysegNev:=FieldByName('EgysegNev').AsString;
      If (Not EpuletLista.EgysegKeresNev(EgysegNev,AlakLancMut,EpEgysegMut)) Then
      Begin
        EpuletLista.Aktualis:=EpuletLista.Elso;
        Elozo:=EpuletLista.Aktualis;
        While (EpuletLista.Aktualis <> Nil) Do
        Begin
          Elozo:=EpuletLista.Aktualis;
          EpuletLista.Aktualis:=EpuletLista.Aktualis.Kovetkezo;
        End;
        AlakzatLanc.Create;
        EpuletEgyseg.Create;
        EpuletEgyseg.EgysegNev:=EgysegNev;
        EpuletEgyseg.AlakzatLancMutato:=AlakzatLanc;
        If (EpuletLista.Elso = Nil) Then
        Begin
          EpuletLista.Elso:=EpuletEgyseg;
          EpuletLista.Aktualis:=EpuletEgyseg;
        End
        Else Begin
          EpuletLista.Aktualis:=Elozo;
          EpuletEgyseg.Elozo:=EpuletLista.Aktualis;
          EpuletEgyseg.Elozo.Kovetkezo:=EpuletEgyseg;
        End;
        Self.ComboBox1.Items.Add(EgysegNev);
      End
      Else Begin
        AlakzatLanc:=AlakLancMut;
        AlakzatLanc.Aktualis:=AlakzatLanc.Elso;
        While (AlakzatLanc.Aktualis <> Nil) Do
          AlakzatLanc.Aktualis:=AlakzatLanc.Aktualis.Kovetkezo;
        EpuletEgyseg:=EpEgysegMut;
      End;
      //alakzat létrehozása
      AlakzatLetrehoz(Self,Image1,EpuletLista,FieldByName('Szog').AsInteger,
                      TDrawingTool(FieldByName('Tipus').AsInteger),
                      FieldByName('PenMeret').AsInteger,
                      TPenStyle(FieldByName('PenStyle').AsInteger),
                      FieldByName('PenColor').AsInteger,
                      Point(FieldByName('K1X').AsInteger,
                            FieldByName('K1Y').AsInteger),
                      Point(FieldByName('K2X').AsInteger,
                            FieldByName('K2Y').AsInteger),
                      Point(FieldByName('K3X').AsInteger,
                            FieldByName('K3Y').AsInteger),
                      Point(FieldByName('K4X').AsInteger,
                            FieldByName('K4Y').AsInteger),
                      FieldByName('A').AsFloat,
                      FieldByName('B').AsFloat,1);
      Next;
    End;
    Result:=True;
  End;
  With Self.ComboBox1 Do
    ItemIndex:=Items.IndexOf(EpuletLista.Aktualis.EgysegNev);
  PontLista:=TPontLista.Create;
  AlapPenBeallit(Self,Image1);
  EpuletTul.VE:=True;
  RajzScrollBox.Visible:=True;
  RichEdit1.Visible:=True;
  AsztalFrissit(Self,Image1,Zoom.Szorzo);
End;

//listák törlése, adtbázisok bezárása
Procedure TFormVezerlo.KiUrit;
Begin
  If (EpuletLista <> Nil) Then FreeAndNil(EpuletLista);
  If (ObjektumLista <> Nil) Then FreeAndNil(ObjektumLista);
  If (BerendezesLista <> Nil) Then FreeAndNil(BerendezesLista);
  If DM.EpuletTable.Active Then DM.EpuletTable.Close;
  If DM.ObjektumTable.Active Then DM.ObjektumTable.Close;
  If DM.BerendezesTable.Active Then DM.BerendezesTable.Close;
End;

//az egyes adatbázisok betöltése láncokba
Function TFormVezerlo.TablakBetolt : Boolean;
Var Count       : Integer;
    AlakLancMut : PAlakzatLanc;
    EpEgysegMut : PEpuletEgyseg;
Begin
  Result:=True;
  AliasModosit(Self.EpuletPath);
  DM.EpuletTable.TableName:=Self.EpuletPath+'\'+sAlaprajz+sKit;
  If (DM.EpuletTable.TableType = ttParadox) Then DM.EpuletTable.IndexName:=INDEXNEV;
  If FileExists(DM.EpuletTable.TableName) Then
    Try
      Try
        DM.EpuletTable.Open;
      Except
        On EDBEngineError Do Begin
          Result:=False;
          Exit;
        End;
      End;
      InditasDlg.Memo1.Lines.Append('Épület betöltése...');
      Count:=InditasDlg.Memo1.Lines.Count-1;
      If EpuletLancBetoltes Then
        InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'ok'
      Else Begin
        Result:=False;
        InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'HIBA';
      End;
      EpuletLista.Valtozas:=False;
    Finally
      DM.EpuletTable.Close;
    End
  Else Result:=False;
  DM.ObjektumTable.TableName:=Self.EpuletPath+'\'+sObjektum+sKit;
  If Result And FileExists(DM.ObjektumTable.TableName) Then
    Try
      Try
        DM.ObjektumTable.Open;
      Except
        On EDBEngineError Do Begin
          Result:=False;
          Exit;
        End;
      End;
      InditasDlg.Memo1.Lines.Append('Objektumok betöltése...');
      Count:=InditasDlg.Memo1.Lines.Count-1;
      ObjektumLista:=ObjektumLancBetolt(EpuletLista,DM.ObjektumTable);
      If (ObjektumLista <> Nil) Then
        InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'ok'
      Else Begin
        Result:=False;
        InditasDlg.Memo1.Lines.Strings[Count]:= InditasDlg.Memo1.Lines.Strings[Count]+'HIBA';
      End;
      ObjektumLista.Valtozas:=False;
    Finally
      DM.ObjektumTable.Close;
    End;
  DM.BerendezesTable.TableName:=Self.EpuletPath+'\'+sBerendezes+sKit;
  If Result And FileExists(DM.BerendezesTable.TableName) Then
    Try
      Try
        DM.BerendezesTable.Open;
      Except
        On EDBEngineError Do Begin
          Result:=False;
          Exit;
        End;
      End;
      InditasDlg.Memo1.Lines.Append('Berendezések betöltése...');
      Count:=InditasDlg.Memo1.Lines.Count-1;
      BerendezesLista:=BerendezesLancBetolt(DM.BerendezesTable);
      If (BerendezesLista <> Nil) Then
      Begin
        InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'ok';
        Result:=BerendFelToltesek;
      End
      Else Begin
        Result:=False;
        InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'HIBA';
      End;
      BerendezesLista.Valtozas:=False;
    Finally
      DM.BerendezesTable.Close;
    End;
  //rajz frissítése
  If Result And EpuletLista.EgysegKeresNev(EpuletLista.Aktualis.EgysegNev,AlakLancMut,EpEgysegMut) Then
  Begin
    AlakzatLanc:=AlakLancMut;
    EpuletEgyseg:=EpEgysegMut;
    ComboBox1.ItemIndex:=ComboBox1.Items.IndexOf(EpuletLista.Aktualis.EgysegNev);
    AsztalFrissit(Self,Image1,Zoom.Szorzo);
    FormVezerlo.Caption:='Vezérlõ - '+EpuletNev;
    AlapPenBeallit(Self,Image1);
  End;
End;

//paraméterben megadott épület betöltése
Procedure TFormVezerlo.Betoltes(FileNev: String);
Var DirNev     : String;
    Datum      : String;
    FoDir      : String;
    RegiKurzor : TCursor;
Begin
  RegiKurzor:=Screen.Cursor;
  Screen.Cursor:=1;
  InditasDlg.Memo1.Clear;
  InditasDlg.Show;
  KiUrit;
  If (FileNev <> '') Then
  Begin
    DirNev:=ExtractFilePath(FileNev);
    System.Delete(DirNev,Length(DirNev),1);
    Self.EpuletPath:=DirNev;
    Self.EpuletNev:=AktDirNev(Self.EpuletPath);
  End
  Else Begin
    Self.EpuletNev:=OpenDlg.Get_DirName;
    Self.EpuletPath:=OpenDlg.Get_DirPath;
  End;
  //adatbázisok betöltése
  //ha sikerült -> True, különben -> False
  If (Not TablakBetolt) Then
  Begin
    InditasDlg.Close;
    Screen.Cursor:=RegiKurzor;
    BezarasMenuClick(Self);
    StatusBarKiIr('Az adatbázisok megnyitása nem sikerült!');
    Exit;
  End;
  InditasDlg.Close;
  Screen.Cursor:=RegiKurzor;
  If (Not AlaprajzBtn.Down) Then
  Begin
    AlaprajzBtn.Down:=True;
    AlaprajzBtnClick(Self);
  End;
  AttekintGridFeltolt;
  If BeallitDlg.AutInditBox.Checked Then ConnectMenuClick(Self);
  HangThread:=THangThread.Create;
  NaploIndBetolt;
  Datum:=DatumAtAlakit;
  SetCurrentDir(ExtractFilePath(ParamStr(0))+'..');
  FoDir:=GetCurrentDir;
  SetCurrentDir(ExtractFilePath(ParamStr(0)));
  If DirectoryExists(FoDir+'\'+NAPLOKDIR+'\'+Datum) Then NaploBeallit;
  MemoIr(True,'A rendszer elindult',clBlack);
  MemoIr(True,'A(z) '+EpuletNev+' nevû épület betöltve.',clBlack);
End;

//berendezések betöltése és a láncok létrehozása
Function TFormVezerlo.BerendFelToltesek : Boolean;
Var Count : Integer;
Begin
  Result:=True;
  If (KapcsBerendLista <> Nil) Then FreeAndNil(KapcsBerendLista);
  KapcsBerendLista:=TKapcsBerendLista.Create(BerendezesLista);
  If (HomeroLista <> Nil) Then FreeAndNil(HomeroLista);
  HomeroLista:=THomeroLista.Create(BerendezesLista);
  If (RiasztoLista <> Nil) Then FreeAndNil(RiasztoLista);
  RiasztoLista:=TRiasztoLista.Create(BerendezesLista);
  If (TuzjelzoLista <> Nil) Then FreeAndNil(TuzjelzoLista);
  TuzjelzoLista:=TTuzjelzoLista.Create(BerendezesLista);
  If (VegBerendLista <> Nil) Then FreeAndNil(VegBerendLista);
  VegBerendLista:=TVegBerendLista.Create(BerendezesLista);
  If (OsszLista_Dlg <> Nil) Then FreeAndNil(OsszLista_Dlg);
  OsszLista_Dlg:=TOsszesLista_Dlg.Create(HomeroLista,RiasztoLista,TuzjelzoLista,
    VegBerendLista,BerendezesLista,KapcsBerendLista);
  InditasDlg.Memo1.Lines.Append('Hõmérõk betöltése...');
  Count:=InditasDlg.Memo1.Lines.Count-1;
  If HomeroTablaBeolvas(DM.HomeroTabla,EpuletNev,HomeroLista,BerendezesLista) Then
    InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'ok'
  Else Begin
    InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'HIBA';
    Result:=False;
    Exit;
  End;
  Application.ProcessMessages;
  InditasDlg.Memo1.Lines.Append('Riasztók betöltése...');
  Count:=InditasDlg.Memo1.Lines.Count-1;
  If RiasztoTablaBeolvas(DM.RiasztoTabla,EpuletNev,RiasztoLista,BerendezesLista) Then
    InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'ok'
  Else Begin
    InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'HIBA';
    Result:=False;
    Exit;
  End;
  Application.ProcessMessages;
  InditasDlg.Memo1.Lines.Append('Tûzjelzõk betöltése...');
  Count:=InditasDlg.Memo1.Lines.Count-1;
  If TuzjelzoTablaBeolvas(DM.TuzjelzoTabla,EpuletNev,TuzjelzoLista,BerendezesLista) Then
    InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'ok'
  Else Begin
    InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'HIBA';
    Result:=False;
    Exit;
  End;
  Application.ProcessMessages;
  InditasDlg.Memo1.Lines.Append('Fûtõtestek betöltése...');
  Count:=InditasDlg.Memo1.Lines.Count-1;
  If FutotestTablaBeolvas(DM.FutotestTabla,EpuletNev,VegBerendLista,BerendezesLista) Then
    InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'ok'
  Else Begin
    InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'HIBA';
    Result:=False;
    Exit;
  End;
  Application.ProcessMessages;
  InditasDlg.Memo1.Lines.Append('Egyéb berendezések betöltése...');
  Count:=InditasDlg.Memo1.Lines.Count-1;
  If EgyebTablaBeolvas(DM.EgyebTabla,EpuletNev,VegBerendLista,BerendezesLista) Then
    InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'ok'
  Else Begin
    InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'HIBA';
    Result:=False;
    Exit;
  End;
  Application.ProcessMessages;
  InditasDlg.Memo1.Lines.Append('Kapcsolódások betöltése...');
  Count:=InditasDlg.Memo1.Lines.Count-1;
  If KapcsTablaBeolvas(DM.KapcsTabla,EpuletNev,KapcsBerendLista,BerendezesLista) Then
    InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'ok'
  Else Begin
    InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'HIBA';
    Result:=False;
  End;
End;

//megnyitás gomb esemény
Procedure TFormVezerlo.MegnyitasClick(Sender: TObject);
Var RegiDirName : String;
Begin
  RegiDirName:=ExtractFilePath(ParamStr(0));
  If (OpenDlg.ShowModal <> idCancel) And (OpenDlg.Get_DirName <> '') Then
  Begin
    ComPort.BeginUpdate;
    With BeallitDlg Do
    Begin
      VezerloIniBetolt(sVezerlo,BeallitDlg,SzinAtmenetBox,AutInditBox,FileNevEdit,
        Self.ComPort,Self.Hang,Self.EpuletDir);
      Case Hang Of
        0 : NincsHangBtn.Checked:=True;      //Nincs hang
        1 : EgyHangBtn.Checked:=True;        //Egyszeri hang
        2 : FolyamatosHangBtn.Checked:=True; //Folyamatos hang
        Else EgyHangBtn.Checked:=True;
      End;
    End;
    ComPort.EndUpdate;
    If (Not AlaprajzBtn.Down) Then
    Begin
      AlaprajzBtn.Down:=True;
      AlaprajzBtnClick(Self);
    End;
    Self.Betoltes('');
  End;
  SetCurrentDir(RegiDirName);
  MenuBtnAllit;
End;

Procedure TFormVezerlo.MegnyitasButtoClick(Sender: TObject);
Begin
  MegnyitasClick(Sender);
End;

Procedure TFormVezerlo.CloseButtonClick(Sender: TObject);
Begin
  BezarasMenuClick(Sender);
End;

//láncok kiürítése és törlése
Procedure TFormVezerlo.KiUrites;
Begin
  Try
    If (HangThread <> Nil) Then FreeAndNil(HangThread);
    If (EpuletLista <> Nil) Then FreeAndNil(EpuletLista);
    If (HomeroLista <> Nil) Then FreeAndNil(HomeroLista);
    If (RiasztoLista <> Nil) Then FreeAndNil(RiasztoLista);
    If (TuzjelzoLista <> Nil) Then FreeAndNil(TuzjelzoLista);
    If (OsszLista_Dlg <> Nil) Then FreeAndNil(OsszLista_Dlg);
    If (VegBerendLista <> Nil) Then FreeAndNil(VegBerendLista);
    If (BerendezesLista <> Nil) Then FreeAndNil(BerendezesLista);
    If (KapcsBerendLista <> Nil) Then FreeAndNil(KapcsBerendLista);
  Except
    On E: Exception Do Application.MessageBox(PChar(E.Message),'HIBA',MB_OK);
  End;
End;

Procedure TFormVezerlo.KilepesTimerTimer(Sender: TObject);
Begin
  KilepesTimer.Enabled:=False;
  Close;
End;

Procedure TFormVezerlo.KapcsolatTimerTimer(Sender: TObject);
Begin
  KapcsolatTimer.Enabled:=False;
  If ComPort.Connected Then ComPort.Close;
  If AttekintBtn.Down Then AttekintGridFrissit;
End;

Procedure TFormVezerlo.KilepesClick(Sender: TObject);
Begin
  If ComPort.Connected Then
  Begin
    If (Application.MessageBox('A kapcsolat még aktív - Biztos kilép?','Kilépés',mb_YesNo) = idYes) Then
    Begin
      MemoIr(True,'Kapcsolat lezárása...',clBlack);
      KuldThread.Kuldhet:=False;
      KuldThread.Terminate;
      PortAllapot.Szabad:=False;
      RendszerUzenetKuld(rKapcsVege);
      ComPort.ClearBuffer(True,True);
      ComPort.Events:=[];
      KilepesTimer.Enabled:=True;
    End;
  End
  Else Close;
End;

Procedure TFormVezerlo.KilepesButtoClick(Sender: TObject);
Begin
  KilepesClick(Sender);
End;

Procedure TFormVezerlo.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
  //ha volt változás a listákban
  If ((HomeroLista <> Nil) And HomeroLista.Valtozas) Or
     ((RiasztoLista <> Nil) And RiasztoLista.Valtozas) Or
     ((TuzjelzoLista <> Nil) And TuzjelzoLista.Valtozas) Or
     ((VegberendLista <> Nil) And VegberendLista.Valtozas) Or
     ((KapcsBerendLista <> Nil) And KapcsBerendLista.Valtozas) Then
  Begin
    If (Application.MessageBox('Menti a változásokat?',
        'Mentés',mb_YesNo) = idYes) Then MentesButtonClick(Sender);
  End;
  If IdoTimer.Enabled Then IdoTimer.Enabled:=False;
  MemoIr(True,'Kilépés a programból.',clBlack);
  If ComPort.Connected Then ComPort.Close;
  KiUrites;
End;

Procedure TFormVezerlo.BezarasMenuClick(Sender: TObject);
Begin
  If ComPort.Connected Then
  Begin
    If (Application.MessageBox('A kapcsolat még aktív - Biztos bezárja?',
        'Bezárás',mb_YesNo) = idYes) Then DisconnectMenuClick(Sender)
    Else Exit;
  End;
  KiUrites;
  MemoIr(True,'A(z) '+EpuletNev+' nevû épület bezárva.',clBlack);
  MemoIr(True,'A rendszer leállítva.',clBlack);
  Self.Caption:='Vezérlõ';
  RajzasztalLetrehoz(Min(RajzScrollBox.ClientHeight,RajzScrollBox.ClientWidth));
  AttekintGridFeltolt;
  MenuBtnAllit;
  If BerendListaMenu.Checked Then BerendInspector.Close;
End;

//épületegységek közti váltás
Procedure TFormVezerlo.EpuletEgysegValtas;
Var Nev         : String;
    AlakLancMut : PAlakzatLanc;
    EpEgysegMut : PEpuletEgyseg;
Begin
  Nev:=ComboBox1.Text;
  If EpuletLista.EgysegKeresNev(Nev,AlakLancMut,EpEgysegMut) Then
  Begin
    AlakzatLanc:=AlakLancMut;
    EpuletEgyseg:=EpEgysegMut;
  End;
  AsztalFrissit(Self,Image1,Zoom.Szorzo);
End;

Procedure TFormVezerlo.ComboBox1Change(Sender: TObject);
Begin
  EpuletEgysegValtas;
  ObjRajzolVizsgal;
End;

Procedure TFormVezerlo.FormCreate(Sender: TObject);
Var Kep : TScreen;
Begin
  DoubleBuffered:=True;
  Self.Indulas:=True;
  Image1.Visible:=False;
  Image1.Align:=alClient;
  Kep:=TScreen.Create(Self);
  FoPanel.Height:=Kep.DesktopHeight-170;
  FreeAndNil(Kep);
  LedPanel.DoubleBuffered:=True;
  RajzScrollBox.Visible:=True;
  RajzScrollBox.DoubleBuffered:=True;
  RajzScrollBox.Align:=alClient;
  AttekintScrollBox.Visible:=False;
  AttekintScrollBox.DoubleBuffered:=True;
  AttekintScrollBox.Align:=alClient;
  AttekintGrid.Align:=alClient;
  NaploDir:='';
  NaploFile:='';
  NaploDatum:='';
  NaploSzam:=0;
  RichEdit1.Clear;
  RichEdit1.Lines.Capacity:=10000;
  RichEdit1.ReadOnly:=True;
  With Self.TextAttributes Do
  Begin
    Color:=clBlack;
    Height:=RichEdit1.Font.Height;
  End;
  NyugtaPanel.Enabled:=False;
  KilepesTimer.Enabled:=False;
  KapcsolatTimer.Enabled:=False;
End;

Procedure TFormVezerlo.FormActivate(Sender: TObject);
Var RegiDirName : String;
Begin
  //ha most lett elindítva a program
  If Self.Indulas Then
  Begin
    Self.Indulas:=False;
    IdoTimer.Enabled:=True;
    RegiDirName:=ExtractFilePath(ParamStr(0));
    With BeallitDlg Do
    Begin
      VezerloIniBetolt(sVezerlo,BeallitDlg,SzinAtmenetBox,AutInditBox,FileNevEdit,
        Self.ComPort,Self.Hang,Self.EpuletDir);
      Case Hang Of
        0 : NincsHangBtn.Checked:=True;      //Nincs hang
        1 : EgyHangBtn.Checked:=True;        //Egyszeri hang
        2 : FolyamatosHangBtn.Checked:=True; //Folyamatos hang
      End;
    End;
    If (EpuletDir <> '') Then Self.Betoltes(Self.EpuletDir);
    AttekintGridFeltolt;
    SetCurrentDir(RegiDirName);
    MenuBtnAllit;
  End;
End;

Procedure TFormVezerlo.FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
  If (Key = VK_F4) And (Shift = [ssAlt]) Then Key:=0;
End;

//a menüpontok beállítása
Procedure TFormVezerlo.MenuBtnAllit;
Begin
  If (EpuletLista = Nil) Then ComboBox1.Clear;
  Megnyitas.Enabled:=Self.EpuletLista = Nil;
  MegnyitasButton.Enabled:=Self.EpuletLista = Nil;
  BerendListaMenu.Enabled:=Self.EpuletLista <> Nil;
  ConnectMenu.Enabled:=Self.EpuletLista <> Nil;
  MentesMenu.Enabled:=Self.EpuletLista <> Nil;
  BezarasMenu.Enabled:=Self.EpuletLista <> Nil;
  DisconnectMenu.Enabled:=False;
  ComboBox1.Enabled:=Self.EpuletLista <> Nil;
  CloseButton.Enabled:=Self.EpuletLista <> Nil;
  EgyebMenu.Enabled:=Self.BerendezesLista <> Nil;
  HomeroMenu.Enabled:=Self.BerendezesLista <> Nil;
  RiasztoMenu.Enabled:=Self.BerendezesLista <> Nil;
  MentesButton.Enabled:=Self.BerendezesLista <> Nil;
  TuzjelzoMenu.Enabled:=Self.BerendezesLista <> Nil;
  FutotestMenu.Enabled:=Self.BerendezesLista <> Nil;
  ZoomInButton.Enabled:=Self.BerendezesLista <> Nil;
  ZoomOutButton.Enabled:=Self.BerendezesLista <> Nil;
  BerendezesekMenu.Enabled:=Self.BerendezesLista <> Nil;
End;

Procedure TFormVezerlo.BerendezesekMenuClick(Sender: TObject);
Begin
  If (Self.BerendezesLista <> Nil) Then
  Begin
    BerendezesLista.TombFeltolt;
    With BerendezesDlg Do
    Begin
      Enabled:=True;
      Visible:=False;
      ActiveControl:=BezarBtn;
      ShowModal(OsszLista_Dlg);
      Enabled:=False;
    End;
    If ValtozasAll And AttekintBtn.Down Then AttekintGridFrissit;
  End;
End;

Procedure TFormVezerlo.AltBellitasokMenuClick(Sender: TObject);
Var Valtozas : Boolean;
Begin
  With BeallitDlg Do
  Begin
    Enabled:=True;
    Visible:=False;
    ActiveControl:=OKBtn;
    ComPort.BeginUpdate;
    If (ShowModal(ComPort,Valtozas) <> idCancel) Then
    Begin
      Self.EpuletDir:=FileNevEdit.Text;
      AblakSzin.SzinAtmenet:=SzinAtmenetBox.Checked;
      If EgyHangBtn.Checked Then Hang:=1;
      If FolyamatosHangBtn.Checked Then Hang:=2;
      If NincsHangBtn.Checked Then Hang:=0;
      If Valtozas Then
        VezerloIniMent(sVezerlo,Self.EpuletDir,AblakSzin.SzinAtmenet,
        AutInditBox.Checked,ComBox.Text,StopBitBox.ItemIndex,
        BaudRateRadio.ItemIndex,DataBitRadio.ItemIndex,
        FlowControlRadio.ItemIndex,Hang);
      ComPort.EndUpdate;
    End;
    Enabled:=False;
  End;
End;

Procedure TFormVezerlo.HomeroMenuClick(Sender: TObject);
Begin
  OsszLista_Dlg.HomeroBeallit(Self.ComboFeltolt(sHomero));
  If HomeroLista.Valtozas Then
  Begin
    HomerokBeallKuld;
    If AttekintBtn.Down Then AttekintGridFrissit;
  End;
End;

Procedure TFormVezerlo.RiasztoMenuClick(Sender: TObject);
Begin
  OsszLista_Dlg.RiasztoBeallit(Self.ComboFeltolt(sRiaszto));
  If RiasztoLista.Valtozas And AttekintBtn.Down Then AttekintGridFrissit;
End;

Procedure TFormVezerlo.TuzjelzoMenuClick(Sender: TObject);
Begin
  OsszLista_Dlg.TuzjelzoBeallit(Self.ComboFeltolt(sTuzjelzo));
  If TuzjelzoLista.Valtozas And AttekintBtn.Down Then AttekintGridFrissit;
End;

Procedure TFormVezerlo.FutotestMenuClick(Sender: TObject);
Begin
  OsszLista_Dlg.FutotestBeallit(Self.ComboFeltolt(sFutotest));
  If VegBerendLista.Valtozas And AttekintBtn.Down Then AttekintGridFrissit;
End;

Procedure TFormVezerlo.EgyebMenuClick(Sender: TObject);
Begin
  OsszLista_Dlg.EgyebBeallit(Self.ComboFeltolt(sEgyeb));
  If VegBerendLista.Valtozas And AttekintBtn.Down Then AttekintGridFrissit;
End;

//az alaprajz újrarajzolása
Procedure TFormVezerlo.AsztalUjraRajzol;
Var RegiPenStyle : TRegiPenStyle;
Begin
  RegiPenStyle.Ment(Self,Image1);
  Image1.Picture.Graphic:=Nil;
  RajzasztalLetrehoz(BitmapMeret);
  AlakzatLancAtRajzol(Self,Image1,Zoom.Szorzo);
  RegiPenStyle.Vissza(Self,Image1);
End;

//az alaprajz újrarajzolása a megadott színnel
Procedure TFormVezerlo.AsztalUjraRajzol(Szin: TColor);
Var RegiPenStyle : TRegiPenStyle;
Begin
  RegiPenStyle.Ment(Self,Image1);
  Image1.Picture.Graphic:=Nil;
  RajzasztalLetrehoz(BitmapMeret);
  AlakzatLancAtRajzol(Self,Image1,Szin,Zoom.Szorzo);
  RegiPenStyle.Vissza(Self,Image1);
End;

//nagyítás
Procedure TFormVezerlo.ZoomInButtonClick(Sender: TObject);
Var RegiKurzor : TCursor;
Begin
  RegiKurzor:=Screen.Cursor;
  Screen.Cursor:=1;
  If Zoom.Novel Then
  Begin
    If (Zoom.Szorzo < MAXZOOM) Then ZoomInButton.Enabled:=True
      Else ZoomInButton.Enabled:=False;
    //Egysegmeret:=EredEgysMeret/Zoom.Szorzo;
    BitmapMeret:=Round(Zoom.Szorzo*RajzMeret);
    If (BitmapMeret >= RajzScrollBox.Width) Then RajzScrollBox.HorzScrollBar.Visible:=True
      Else RajzScrollBox.HorzScrollBar.Visible:=False;
    If (BitmapMeret >= RajzScrollBox.Height) Then RajzScrollBox.VertScrollBar.Visible:=True
      Else RajzScrollBox.VertScrollBar.Visible:=False;
    AsztalUjraRajzol;
  End
  Else ZoomInButton.Enabled:=False;
  ZoomOutButton.Enabled:=True;
  Screen.Cursor:=RegiKurzor;
End;

//kicsinyítés
Procedure TFormVezerlo.ZoomOutButtonClick(Sender: TObject);
Var RegiKurzor : TCursor;
Begin
  RegiKurzor:=Screen.Cursor;
  Screen.Cursor:=1;
  If Zoom.Csokkent Then
  Begin
    If (Zoom.Szorzo > (1/MAXZOOM)) Then ZoomOutButton.Enabled:=True
      Else ZoomOutButton.Enabled:=False;
    //Egysegmeret:=(1/Zoom.Szorzo)*EredEgysMeret;
    BitmapMeret:=Round(Zoom.Szorzo*RajzMeret);
    If (BitmapMeret < RajzScrollBox.Width) Then RajzScrollBox.HorzScrollBar.Visible:=False
      Else RajzScrollBox.HorzScrollBar.Visible:=True;
    If (BitmapMeret < RajzScrollBox.Height) Then RajzScrollBox.VertScrollBar.Visible:=False
      Else RajzScrollBox.VertScrollBar.Visible:=True;
    AsztalUjraRajzol;
  End
  Else ZoomOutButton.Enabled:=False;
  ZoomInButton.Enabled:=True;
  Screen.Cursor:=RegiKurzor;
End;

Procedure TFormVezerlo.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Begin
  EgerDown:=True;
  RegiMouseMove:=Point(X,Y);
  RegiEgerKurzor:=Screen.Cursor;
  Screen.Cursor:=crHandPoint;
End;

Procedure TFormVezerlo.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Begin
  EgerDown:=False;
  Screen.Cursor:=RegiEgerKurzor;
End;

Procedure TFormVezerlo.Image1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
Var DX,DY : Integer;
Begin
  //ha az egér bal gombja le van nyomva
  If EgerDown Then
  Begin
    DX:=X-RegiMouseMove.X; //X irányú elmozdulás
    DY:=Y-RegiMouseMove.Y; //Y irányú elmozdulás
    RegiMouseMove:=Point(X,Y);
    If (DX > 2) Then
      RajzScrollBox.HorzScrollBar.Position:=RajzScrollBox.HorzScrollBar.Position-(Abs(DX) Div 2);
    If (DX < -2) Then
      RajzScrollBox.HorzScrollBar.Position:=RajzScrollBox.HorzScrollBar.Position+(Abs(DX) Div 2);
    If (DY > 2) Then
      RajzScrollBox.VertScrollBar.Position:=RajzScrollBox.VertScrollBar.Position-(Abs(DY) Div 2);
    If (DY < -2) Then
      RajzScrollBox.VertScrollBar.Position:=RajzScrollBox.VertScrollBar.Position+(Abs(DY) Div 2);
  End;
End;

Procedure TFormVezerlo.MentesButtonClick(Sender: TObject);
Var RegiKurzor : TCursor;
Begin
  RegiKurzor:=Screen.Cursor;
  Screen.Cursor:=1;
  If (HomeroLista <> Nil) And HomeroLista.Valtozas Then
    HomeroTablaMentes(DM.HomeroTabla,EpuletNev,HomeroLista);
  If (RiasztoLista <> Nil) And RiasztoLista.Valtozas Then
    RiasztoTablaMentes(DM.RiasztoTabla,EpuletNev,RiasztoLista);
  If (TuzjelzoLista <> Nil) And TuzjelzoLista.Valtozas Then
    TuzjelzoTablaMentes(DM.TuzjelzoTabla,EpuletNev,TuzjelzoLista);
  If (VegberendLista <> Nil) And VegberendLista.Valtozas Then
  Begin
    FutotestTablaMentes(DM.FutotestTabla,EpuletNev,VegberendLista);
    EgyebTablaMentes(DM.EgyebTabla,EpuletNev,VegberendLista);
  End;
  If (KapcsBerendLista <> Nil) And KapcsBerendLista.Valtozas Then
    KapcsTablaMentes(DM.KapcsTabla,EpuletNev,KapcsBerendLista);
  Screen.Cursor:=RegiKurzor;
End;

Procedure TFormVezerlo.MentesMenuClick(Sender: TObject);
Begin
  MentesButtonClick(Sender)
End;

Procedure TFormVezerlo.BerendListaMenuClick(Sender: TObject);
Begin
  BerendListaMenu.Checked:=Not BerendListaMenu.Checked;
  If BerendListaMenu.Checked Then
  Begin
    BerendInspector.Visible:=True;
    BerendInspector.FormStyle:=fsStayOnTop;
    BerendInspector.PageControl1.ActivePage:=BerendInspector.BerendTabSheet;
    BerendInspector.Show(OsszLista_Dlg,UzenetLista);
  End
  Else Begin
    BerendInspector.Visible:=False;
    BerendInspector.FormStyle:=fsNormal;
    BerendInspector.Close;
  End;
End;

Procedure TFormVezerlo.ConnectMenuClick(Sender: TObject);
Var Event  : TEvent;
    Answer : String;
    Data   : String;
    Step   : Integer;
    Events : TComEvents;
    ComP   : TComPort;
    Kapcs  : Boolean;
Begin
  Try
    //ha nincs kapcsolat
    If Not ComPort.Connected Then
    Begin
      Event:=TEvent.Create(Nil,True,False,'');
      ComP:=TComPort.Create(Self);
      With ComP Do
      Begin
        Events:=[];
        Port:=ComPort.Port;
        Parity:=ComPort.Parity;
        StopBits:=ComPort.StopBits;
        DataBits:=ComPort.DataBits;
        BaudRate:=ComPort.BaudRate;
        FlowControl.FlowControl:=ComPort.FlowControl.FlowControl;
      End;
      MemoIr(True,'Kapcsolatfelvétel a '+ComP.Port+' porton...',clBlack);
      ComP.Open;
      ComP.WriteStr(rKapcsKer+sHatJel);
      Answer:='';
      Step:=0;
      //megpróbál kapcsolatot teremteni
      Repeat
        Events:=[evRxChar];
        //5 ms-ig vár a válaszra
        ComP.WaitForEvent(Events,Event.Handle,5000);
        If evRxChar In Events Then
        Begin
          ComP.ReadStr(Data,ComP.InputCount);
          Answer:=Answer+Data;
          If (Pos(rKapcsKesz,Answer) > 0) Then Break;
        End;
        Inc(Step);
      Until (Events = []) Or (Step = 5);
      If (Pos(rKapcsKesz,Answer) > 0) Then
      Begin
        Kapcs:=True;
        MemoIr(True,'Kapcsolat létrejött a '+ComP.Port+' porton',clBlack);
      End
      Else Begin
        Kapcs:=False;
        MemoIr(True,'Kapcsolat nem jött létre a '+ComP.Port+' porton',clBlack);
      End;
      Event.Free;
      If ComP.Connected Then ComP.Close;
      FreeAndNil(Comp);
      //ha létrejött a kapcsolat
      If Kapcs Then
      Begin
        ComPort.Open;
        HomerokBeallKuld;
        RendszerUzenetKuld(rNyugta);
      End;
    End;
  Except
    On E: Exception Do MemoIr(False,'HIBA: '+E.Message,clBlack);
  End;
End;

Procedure TFormVezerlo.DisconnectMenuClick(Sender: TObject);
Begin
  Try
    //ha él a kapcsolat
    If ComPort.Connected Then
    Begin
      MemoIr(True,'Kapcsolat lezárása...',clBlack);
      KuldThread.Kuldhet:=False;
      KuldThread.Terminate;
      PortAllapot.Szabad:=False;
      RendszerUzenetKuld(rKapcsVege);
      ComPort.ClearBuffer(True,True);
      KapcsolatTimer.Enabled:=True;
    End;
  Except
    On E: Exception Do MemoIr(False,'HIBA: '+E.Message,clBlack);
  End;
End;

Procedure TFormVezerlo.ComPortAfterClose(Sender: TObject);
Begin
  PortAllapot.Szabad:=False;
  If (UzenetLista <> Nil) Then FreeAndNil(UzenetLista);
  If (KuldThread <> Nil) Then FreeAndNil(KuldThread);
  ConnectMenu.Enabled:=True;
  DisconnectMenu.Enabled:=False;
  MemoIr(True,'Kapcsolat lezárva a '+ComPort.Port+' porton',clBlack);
  BerendInspector.UzenetLista:=Nil;
End;

Procedure TFormVezerlo.ComPortAfterOpen(Sender: TObject);
Begin
  PortAllapot.Szabad:=True;
  UzenetLista:=TUzenetLista.Create;
  KuldThread:=TKuldThread.Create(ComPort,@PortAllapot,@UzenetLista,RichEdit1);
  ConnectMenu.Enabled:=False;
  DisconnectMenu.Enabled:=True;
  BerendInspector.UzenetLista:=Self.UzenetLista;
End;

procedure TFormVezerlo.ComPortBeforeClose(Sender: TObject);
begin
  ComPort.ClearBuffer(True,True);
end;

//üzenetfeldolgozó
Procedure TFormVezerlo.Ertelmezo(Str: String);
Var Dekod : TAdatUzenetTomb;
Begin
  //kapcsolat vége
  If (Str = rKapcsVege) Then
  Begin
    PortAllapot.Szabad:=False;
    ComPort.ClearBuffer(True,True);
    MemoIr(True,'Kapcsolat megszakadt.',clBlack);
    Exit;
  End;

  //üzenet vételének szignálása
  If (Str = rNyugta) Then
  Begin
    PortAllapot.Szabad:=True;
    Exit;
  End;

  //hiba a vétel során
  If (Str = rHiba) Then
  Begin
    ComPort.ClearBuffer(True,False);
    //ha van másolat az üzenetbõl, akkor újra elküldi
    If (UzenetLista.Masolat <> Nil) Then
    Begin
      If (UzenetLista.Masolat.Szoveg <> '') Then
        UzenetLista.Masolat.Szoveg:=UzenetLista.Masolat.Szoveg+' (ismételt)';
      UzenetLista.Felfuz(True,UzenetLista.Masolat.Uzenet,
        UzenetLista.Masolat.Szoveg,UzenetLista.Masolat.Attrib);
      UzenetLista.MasolatTorles;
    End;
    RendszerUzenetKuld(rNyugta);
    PortAllapot.Szabad:=True;
    Exit;
  End;

  //egyéb üzenet feldolgozása
  SetLength(Dekod,0);
  Dekod:=Dekodolo(Str);
  If (High(Dekod) > -1) Then UzenetKezelo(Dekod)
  Else Begin
    ComPort.ClearBuffer(True,False);
    MemoIr(False,'HIBA: Adatvételi hiba. Ismételt adatkérés...',clBlack);
    RendszerUzenetKuld(rHiba);
  End;
End;

Procedure TFormVezerlo.ComPortRxChar(Sender: TObject; Count: Integer);
Var Str    : String;
    Uzenet : String;
    I      : Integer;
Begin
  Uzenet:='';
  ComPort.ReadStr(Str,Count);
  If (Str <> '') Then
  Begin
    For I:=1 To Count Do
    Begin
      If (Str[I] <> sHatJel) Then Uzenet:=Uzenet+Str[I]
      Else Begin
        Ertelmezo(Uzenet);
        Uzenet:='';
      End;
    End;
  End;
End;

//vezérlõ üzenet küldése
Procedure TFormVezerlo.RendszerUzenetKuld(Str: String);
Begin
  KuldThread.Kuldhet:=False;
  Repeat Until (ComPort.OutputCount = 0);
  KuldThread.Suspend;
  If ComPort.Connected Then ComPort.WriteStr(Str+sHatJel);
  KuldThread.Kuldhet:=True;
  KuldThread.Resume;
End;

//adat üzenet küldése
Procedure TFormVezerlo.AdatUzenetKuld(Prior: Boolean; Tomb: TAdatUzenetTomb;
          Szoveg: String; Atb: TTextAttrib);
Begin
  If (UzenetLista <> Nil) Then UzenetLista.Felfuz(Prior,Kodolo(Tomb),Szoveg,Atb);
End;

//hõmérõk adatainak elküldése
Procedure TFormVezerlo.HomerokBeallKuld;
Var RegiMut : PHomeroElem;
    UzTomb  : TAdatUzenetTomb;
Begin
  If ComPort.Connected And (HomeroLista <> Nil) And
     (HomeroLista.Elso <> Nil) Then
  Begin
    RegiMut:=HomeroLista.Aktualis;
    HomeroLista.Aktualis:=HomeroLista.Elso;
    While (HomeroLista.Aktualis <> Nil) Do
    Begin
      SetLength(UzTomb,4);
      UzTomb[0]:=HomeroLista.Aktualis.ID;
      UzTomb[1]:=HomeroLista.Aktualis.Min;
      UzTomb[2]:=HomeroLista.Aktualis.Max;
      UzTomb[3]:=HomeroLista.Aktualis.BeallErtek;
      TextAttributes.Color:=clBlack;
      AdatUzenetKuld(False,UzTomb,'('+IntToStr(HomeroLista.Aktualis.ID)+') '+
        HomeroLista.Aktualis.HomeroMutato.BerendezesNev+
        ' - beállítások elküldve.',TextAttributes);
      SetLength(UzTomb,0);
      HomeroLista.Aktualis:=HomeroLista.Aktualis.Kovetkezo;
    End;
    HomeroLista.Aktualis:=RegiMut;
  End;
End;

//egy riasztó állapotának elküldése
Procedure TFormVezerlo.RiasztoKuld(Mutato: PRiasztoElem);
Var Szoveg : String;
    Uzenet : String;
    UzTomb : TAdatUzenetTomb;
Begin
  If (Mutato <> Nil) Then
  Begin
    SetLength(UzTomb,2);
    UzTomb[0]:=Mutato.ID;
    UzTomb[1]:=BoolToInt(Mutato.Allapot);
    Uzenet:=Kodolo(UzTomb);
    Szoveg:='('+IntToStr(Mutato.ID)+') '+Mutato.RiasztoMutato.BerendezesNev+':';
    If Mutato.Allapot Then Szoveg:=Szoveg+' Bekapcsolása...'
      Else Szoveg:=Szoveg+' Kikapcsolása...';
    TextAttributes.Color:=clYellow;
    UzenetLista.Felfuz(True,Uzenet,Szoveg,TextAttributes);
    SetLength(UzTomb,0);
  End;
End;

//egy tûzjelzõ állapotának elküldése
Procedure TFormVezerlo.TuzjelzoKuld(Mutato: PTuzjelzoElem);
Var Szoveg : String;
    Uzenet : String;
    UzTomb : TAdatUzenetTomb;
Begin
  If (Mutato <> Nil) Then
  Begin
    SetLength(UzTomb,2);
    UzTomb[0]:=Mutato.ID;
    UzTomb[1]:=BoolToInt(Mutato.Allapot);
    Uzenet:=Kodolo(UzTomb);
    Szoveg:='('+IntToStr(Mutato.ID)+') '+Mutato.TuzjelzoMutato.BerendezesNev+':';
    If Mutato.Allapot Then Szoveg:=Szoveg+' Bekapcsolása...'
      Else Szoveg:=Szoveg+' Kikapcsolása...';
    TextAttributes.Color:=clYellow;
    UzenetLista.Felfuz(True,Uzenet,Szoveg,TextAttributes);
    SetLength(UzTomb,0);
  End;
End;

//bejövõ esemény szelktálása
Procedure TFormVezerlo.UzenetKezelo(Dekod: TAdatUzenetTomb);
Var LancElem : PlancElem;
Begin
  If BerendezesLista.KeresID(Dekod[0],LancElem) Then
  Begin
    Case LancElem.BerendezesTip Of
      btHomero   : HomeroEsemeny(Dekod);
      btRiaszto  : RiasztoEsemeny(Dekod);
      btTuzjelzo : TuzjelzoEsemeny(Dekod);
      btFutotest : FutotestEsemeny(Dekod);
      btEgyeb    : EgyebEsemeny(Dekod);
    End;
    If BerendListaMenu.Checked Then BerendInspector.Frissit;
  End;
  RendszerUzenetKuld(rNyugta);
End;

//hõmérõ esemény feldolgozása
Procedure TFormVezerlo.HomeroEsemeny(Dekod: TAdatUzenetTomb);
Var I         : Integer;
    Szin      : TColor;
    Szoveg    : String;
    Kapcsol   : Boolean;
    HomeroMut : PHomeroElem;
    MiKapcs   : TMutatoArray;
    VegElem   : PVegBerendElem;
    UzTomb    : TAdatUzenetTomb;
Begin
  If HomeroLista.KeresID(Dekod[0],HomeroMut) Then
  Begin
    SetLength(MiKapcs,0);
    HomeroMut.MertErtek:=Dekod[1];
    If HomeroMut.Naplozas Then
    Begin
      MemoIr(True,'('+IntToStr(Dekod[0])+') '+HomeroMut.HomeroMutato.BerendezesNev+
        ' értéke: '+IntToStr(Dekod[1]),clBlue);
    End;
    //a hozzá tartozó berendezések betöltése
    MiKapcs:=KapcsBerendLista.MiKapcs(HomeroMut.HomeroMutato);
    If (High(MiKapcs) >= 0) Then
    Begin
      If (HomeroMut.MertErtek < HomeroMut.BeallErtek) Then Kapcsol:=True
        Else Kapcsol:=False;
      For I:=0 To High(MiKapcs) Do
      Begin
        If VegBerendLista.KeresID(MiKapcs[I].ID,VegElem) And
          (VegElem.Allapot <> Kapcsol) And (VegElem.Automata) Then
        Begin
          Szoveg:=MemoIdo;
          If VegElem.Allapot Then
          Begin
            Szin:=clYellow;
            Szoveg:=Szoveg+'('+IntToStr(VegElem.ID)+') '+
              MiKapcs[I].BerendezesNev+' bekapcsolása...';
          End
          Else Begin
            Szin:=clYellow;
            Szoveg:=Szoveg+'('+IntToStr(VegElem.ID)+') '+
              MiKapcs[I].BerendezesNev+' kikapcsolása...';
          End;
          SetLength(UzTomb,2);
          UzTomb[0]:=MiKapcs[I].ID;
          UzTomb[1]:=BoolToInt(Kapcsol);
          TextAttributes.Color:=Szin;
          AdatUzenetKuld(False,UzTomb,Szoveg,TextAttributes);
          SetLength(UzTomb,0);
        End;
      End;
    End;
    SetLength(MiKapcs,0);
    If AttekintBtn.Down Then AttekintGridFrissit;
  End;
End;

//Egyéb berendezés esemény feldolgozása
Procedure TFormVezerlo.EgyebEsemeny(Dekod: TAdatUzenetTomb);
Var Szin     : TColor;
    sErtek   : String;
    EgyebMut : PVegBerendElem;
Begin
  If VegBerendLista.KeresID(Dekod[0],EgyebMut) Then
  Begin
    EgyebMut.Allapot:=IntToBool(Dekod[1]);
    If EgyebMut.Naplozas Then
    Begin
      If EgyebMut.Allapot Then
      Begin
        sErtek:='Be';
        Szin:=clGreen;
      End
      Else Begin
        Szin:=clRed;
        sErtek:='Ki';
      End;
      MemoIr(True,'('+IntToStr(Dekod[0])+') '+EgyebMut.VegBerendMutato.BerendezesNev+
        ' állapota: '+sErtek,Szin);
    End;
  End;
  If AttekintBtn.Down Then AttekintGridFrissit;
End;

//fûtõtest esemény feldolgozása
Procedure TFormVezerlo.FutotestEsemeny(Dekod: TAdatUzenetTomb);
Var Szin        : TColor;
    sErtek      : String;
    FutotestMut : PVegBerendElem;
Begin
  If VegBerendLista.KeresID(Dekod[0],FutotestMut) Then
  Begin
    FutotestMut.Allapot:=IntToBool(Dekod[1]);
    If FutotestMut.Naplozas Then
    Begin
      If FutotestMut.Allapot Then
      Begin
        sErtek:='Bekapcsolva';
        Szin:=clGreen;
      End
      Else Begin
        Szin:=clRed;
        sErtek:='Kikapcsolva';
      End;
      MemoIr(True,'('+IntToStr(Dekod[0])+') '+
        FutotestMut.VegBerendMutato.BerendezesNev+' állapota: '+sErtek,Szin);
    End;
  End;
  If AttekintBtn.Down Then AttekintGridFrissit;
End;

//riasztó esemény feldolgozása
Procedure TFormVezerlo.RiasztoEsemeny(Dekod: TAdatUzenetTomb);
Var I          : Integer;
    Kapcsol    : Boolean;
    Szin       : TColor;
    sErtek     : String;
    RAllapot   : Boolean;
    Kirajzol   : Boolean;
    ObjElem    : PObjektumLanc;
    RiasztoMut : PRiasztoElem;
    MiKapcs    : TMutatoArray;
    VegElem    : PVegBerendElem;
    UzTomb     : TAdatUzenetTomb;
Begin
  If RiasztoLista.KeresID(Dekod[0],RiasztoMut) Then
  Begin
    Kirajzol:=False;
    RAllapot:=RiasztoMut.Allapot;
    RiasztoMut.Allapot:=IntToBool(Dekod[1]);
    If RiasztoMut.Naplozas Then
    Begin
      //objektum átrajzolása a megfelelõ eseményhez
      If RiasztoMut.Allapot Then
      Begin
        Szin:=clRed;
        sErtek:='Riasztás';
        RiasztoMut.Allapot:=False;
        RiasztasHelyreUgras(RiasztoMut.RiasztoMutato.EpuletEgyseg);
        ObjektumLista.Keres(RiasztoMut.RiasztoMutato.ObjektumNev,ObjElem);
        Kirajzol:=LehetRajzolni(ObjElem);
        RiasztoMut.Allapot:=True;
        If (Not HangTimer.Enabled) Then HangTimer.Enabled:=True;
        If (Not NyugtaDlg.Active) Then NyugtaDlg.Show;
      End
      Else Begin
        Szin:=clGreen;
        sErtek:='Normál';
        If RAllapot Then
        Begin
          ObjektumLista.Keres(RiasztoMut.RiasztoMutato.ObjektumNev,ObjElem);
          Kirajzol:=LehetRajzolni(ObjElem);
        End;
      End;
      MemoIr(True,'('+IntToStr(Dekod[0])+') '+RiasztoMut.RiasztoMutato.BerendezesNev+
        ' állapota: '+sErtek,Szin);
      If Kirajzol Then ObjektumRajzol(ObjElem);
    End;
    //a hozzá tartozó berendezések betöltése
    MiKapcs:=KapcsBerendLista.MiKapcs(RiasztoMut.RiasztoMutato);
    If (High(MiKapcs) >= 0) Then
    Begin
      If RiasztoMut.Allapot Then Kapcsol:=True
        Else Kapcsol:=False;
      For I:=0 To High(MiKapcs) Do
      Begin
        VegBerendLista.KeresID(MiKapcs[I].ID,VegElem);
        If (VegElem.Allapot <> Kapcsol) Then
        Begin
          VegElem.Allapot:=Kapcsol;
          SetLength(UzTomb,2);
          UzTomb[0]:=MiKapcs[I].ID;
          UzTomb[1]:=BoolToInt(Kapcsol);
          AdatUzenetKuld(False,UzTomb,'',TextAttributes);
          SetLength(UzTomb,0);
        End;
      End;
    End;
    SetLength(MiKapcs,0);
    If AttekintBtn.Down Then AttekintGridFrissit;
  End;
End;

//hõmérõ esemény feldolgozása
Procedure TFormVezerlo.TuzjelzoEsemeny(Dekod: TAdatUzenetTomb);
Var I           : Integer;
    Kapcsol     : Boolean;
    Szin        : TColor;
    sErtek      : String;
    RAllapot    : Boolean;
    Kirajzol    : Boolean;
    ObjElem     : PObjektumLanc;
    TuzjelzoMut : PTuzjelzoElem;
    MiKapcs     : TMutatoArray;
    VegElem     : PVegBerendElem;
    UzTomb      : TAdatUzenetTomb;
Begin
  If TuzjelzoLista.KeresID(Dekod[0],TuzjelzoMut) Then
  Begin
    Kirajzol:=False;
    RAllapot:=TuzjelzoMut.Allapot;
    TuzjelzoMut.Allapot:=IntToBool(Dekod[1]);
    If TuzjelzoMut.Naplozas Then
    Begin
      //objektum átrajzolása a megfelelõ eseményhez
      If TuzjelzoMut.Allapot Then
      Begin
        Szin:=clRed;
        sErtek:='Tûzjelzés';
        TuzjelzoMut.Allapot:=False;
        RiasztasHelyreUgras(TuzjelzoMut.TuzjelzoMutato.EpuletEgyseg);
        ObjektumLista.Keres(TuzjelzoMut.TuzjelzoMutato.ObjektumNev,ObjElem);
        Kirajzol:=LehetRajzolni(ObjElem);
        TuzjelzoMut.Allapot:=True;
        If (Not NyugtaDlg.Active) Then NyugtaDlg.Show;
        If (Not HangTimer.Enabled) Then HangTimer.Enabled:=True;
      End
      Else Begin
        Szin:=clGreen;
        sErtek:='Normál';
        If RAllapot Then
        Begin
          ObjektumLista.Keres(TuzjelzoMut.TuzjelzoMutato.ObjektumNev,ObjElem);
          Kirajzol:=LehetRajzolni(ObjElem);
        End;
      End;
      MemoIr(True,'('+IntToStr(Dekod[0])+') '+
        TuzjelzoMut.TuzjelzoMutato.BerendezesNev+' állapota: '+sErtek,Szin);
      If Kirajzol Then ObjektumRajzol(ObjElem);
    End;
    //a hozzá tartozó berendezések betöltése
    MiKapcs:=KapcsBerendLista.MiKapcs(TuzjelzoMut.TuzjelzoMutato);
    If (High(MiKapcs) >= 0) Then
    Begin
      For I:=0 To High(MiKapcs) Do
      Begin
        If TuzjelzoMut.Allapot Then Kapcsol:=True
          Else Kapcsol:=False;
        VegBerendLista.KeresID(MiKapcs[I].ID,VegElem);
        If (VegElem.Allapot <> Kapcsol) Then
        Begin
          VegElem.Allapot:=Kapcsol;
          SetLength(UzTomb,2);
          UzTomb[0]:=MiKapcs[I].ID;
          UzTomb[1]:=BoolToInt(Kapcsol);
          AdatUzenetKuld(False,UzTomb,'',TextAttributes);
          SetLength(UzTomb,0);
        End;
      End;
    End;
    SetLength(MiKapcs,0);
    If AttekintBtn.Down Then AttekintGridFrissit;
  End;
End;

//ha riasztás van, akkor a rajzon megmutatja
Procedure TFormVezerlo.RiasztasHelyreUgras(EpEgys: String);
Var Index : Integer;
Begin
  With Self.ComboBox1 Do
  Begin
    Index:=Items.IndexOf(EpEgys);
    //a megfelelõ épületegység kirajzolása
    If (Index <> ItemIndex) Then
    Begin
      ItemIndex:=Index;
      EpuletEgysegValtas;
      ObjRajzolVizsgal;
    End;
  End;
  If (Not AlaprajzBtn.Down) Then
  Begin
    AlaprajzBtn.Down:=True;
    AlaprajzBtnClick(Self);
  End;
End;

Procedure TFormVezerlo.AttekintBtnClick(Sender: TObject);
Begin
  RajzScrollBox.Visible:=False;
  AttekintScrollBox.Align:=alClient;
  AttekintScrollBox.Visible:=True;
  AttekintGridFrissit;
  AttekintGrid.Visible:=True; 
End;

Procedure TFormVezerlo.AlaprajzBtnClick(Sender: TObject);
Begin
  AttekintScrollBox.Visible:=False;
  RajzScrollBox.Align:=alClient;
  RajzScrollBox.Visible:=True;
End;

Procedure TFormVezerlo.StatusBarTimerTimer(Sender: TObject);
Begin
  StatusBarTimer.Enabled:=False;
  StatusBar1.Panels[1].Text:='';
End;

//írás a státuszbárra
Procedure TFormVezerlo.StatusBarKiIr(Str: String);
Begin
  StatusBarTimer.Enabled:=False;
  StatusBarTimer.Interval:=30000;
  StatusBar1.Panels[1].Alignment:=taCenter;
  StatusBar1.Panels[1].Text:=Str;
  StatusBarTimer.Enabled:=True;
End;                 

Procedure TFormVezerlo.SetBerendInsp(Ertek: Boolean);
Begin
  BerendListaMenu.Checked:=Ertek;
End;

//a megadott objektum kirajzolása
Procedure TFormVezerlo.ObjektumRajzol(ObjElem: PObjektumLanc);
Var RegiBrushStyle : TBrushStyle;
    RegiBrushColor : TColor;
Begin
  If (ObjElem <> Nil) Then
  Begin
    RegiBrushColor:=Image1.Canvas.Brush.Color;
    RegiBrushStyle:=Image1.Canvas.Brush.Style;
    Image1.Canvas.Pen.Mode:=pmNotXor;
    Image1.Canvas.Brush.Color:=clRed;
    Image1.Canvas.Brush.Style:=bsBDiagonal;
    If (ObjElem.ObjMut.EpuletEgyseg = EpuletLista.Aktualis) Then
      If (Zoom.Szorzo <> 1) Then
        Image1.Canvas.Polygon(ObjektumLista.PontokKonvertal(ObjElem.ObjMut.Pontok,Zoom.Szorzo))
      Else Image1.Canvas.Polygon(ObjElem.ObjMut.Pontok);
    Image1.Canvas.Brush.Color:=RegiBrushColor;
    Image1.Canvas.Brush.Style:=RegiBrushStyle;
  End;
End;

//objektum állapotának lekérdezése és annak megfelelõen a kirajzolása
Procedure TFormVezerlo.ObjRajzolVizsgal;
Var RegiRiasztoElem  : PRiasztoElem;
    RegiTuzjelzoElem : PTuzjelzoElem;
    ObjElem          : PObjektumLanc;
    RegiObjElem      : PObjektumLanc;
    Valtozas         : Boolean;
Begin
  Valtozas:=False;
  //riasztók vizsgálata
  If (RiasztoLista <> Nil) And (RiasztoLista.Elso <> Nil) Then
  Begin
    RegiRiasztoElem:=RiasztoLista.Aktualis;
    RiasztoLista.Aktualis:=RiasztoLista.Elso;
    While (RiasztoLista.Aktualis <> Nil) Do
    Begin
      If (RiasztoLista.Aktualis.RiasztoMutato.EpuletEgyseg = EpuletLista.Aktualis.EgysegNev) Then
      Begin
        If RiasztoLista.Aktualis.Allapot Then
        Begin
          If ObjektumLista.Keres(RiasztoLista.Aktualis.RiasztoMutato.ObjektumNev,ObjElem) Then
          Begin
            If (Not ObjElem.ObjMut.Rajzolas) Then
            Begin
              Valtozas:=True;
              ObjektumRajzol(ObjElem);
              ObjElem.ObjMut.Rajzolas:=True;
            End;
          End;
        End;
      End;
      RiasztoLista.Aktualis:=RiasztoLista.Aktualis.Kovetkezo;
    End;
    RiasztoLista.Aktualis:=RegiRiasztoElem;
  End;
  //tûzjelzõk vizsgálata
  If (TuzjelzoLista <> Nil) And (TuzjelzoLista.Elso <> Nil) Then
  Begin
    RegiTuzjelzoElem:=TuzjelzoLista.Aktualis;
    TuzjelzoLista.Aktualis:=TuzjelzoLista.Elso;
    While (TuzjelzoLista.Aktualis <> Nil) Do
    Begin
      If (TuzjelzoLista.Aktualis.TuzjelzoMutato.EpuletEgyseg = EpuletLista.Aktualis.EgysegNev) Then
      Begin
        If TuzjelzoLista.Aktualis.Allapot Then
        Begin
          If ObjektumLista.Keres(TuzjelzoLista.Aktualis.TuzjelzoMutato.ObjektumNev,ObjElem) Then
          Begin
            If (Not ObjElem.ObjMut.Rajzolas) Then
            Begin
              Valtozas:=True;
              ObjektumRajzol(ObjElem);
              ObjElem.ObjMut.Rajzolas:=True;
            End;
          End;
        End;
      End;
      TuzjelzoLista.Aktualis:=TuzjelzoLista.Aktualis.Kovetkezo;
    End;
    TuzjelzoLista.Aktualis:=RegiTuzjelzoElem;
  End;
  //ha az állapotukban volt változás
  If Valtozas And (ObjektumLista <> Nil) And (ObjektumLista.Elso <> Nil) Then
  Begin
    RegiObjElem:=ObjektumLista.Aktualis;
    ObjektumLista.Aktualis:=ObjektumLista.Elso;
    While (ObjektumLista.Aktualis <> Nil) Do
    Begin
      ObjektumLista.Aktualis.ObjMut.Rajzolas:=False;
      ObjektumLista.Aktualis:=ObjektumLista.Aktualis.Kovetkezo;
    End;
    ObjektumLista.Aktualis:=RegiObjElem;
  End;
End;

//eldönti, hogy egy objektumot újra kell-e rajzolni
Function TFormVezerlo.LehetRajzolni(ObjElem: PObjektumLanc): Boolean;
Var RegiRiasztoElem  : PRiasztoElem;
    RegiTuzjelzoElem : PTuzjelzoElem;
Begin
  Result:=True;
  If (RiasztoLista <> Nil) And (RiasztoLista.Elso <> Nil) Then
  Begin
    RegiRiasztoElem:=RiasztoLista.Aktualis;
    RiasztoLista.Aktualis:=RiasztoLista.Elso;
    While (RiasztoLista.Aktualis <> Nil) Do
    Begin
      If (RiasztoLista.Aktualis.RiasztoMutato.ObjektumNev = ObjElem.ObjMut.Nev) Then
      Begin
        If RiasztoLista.Aktualis.Allapot Then Result:=False;
      End;
      RiasztoLista.Aktualis:=RiasztoLista.Aktualis.Kovetkezo;
    End;
    RiasztoLista.Aktualis:=RegiRiasztoElem;
  End;
  If Result And (TuzjelzoLista <> Nil) And (TuzjelzoLista.Elso <> Nil) Then
  Begin
    RegiTuzjelzoElem:=TuzjelzoLista.Aktualis;
    TuzjelzoLista.Aktualis:=TuzjelzoLista.Elso;
    While (TuzjelzoLista.Aktualis <> Nil) Do
    Begin
      If (TuzjelzoLista.Aktualis.TuzjelzoMutato.ObjektumNev = ObjElem.ObjMut.Nev) Then
      Begin
        If TuzjelzoLista.Aktualis.Allapot Then Result:=False;
      End;
      TuzjelzoLista.Aktualis:=TuzjelzoLista.Aktualis.Kovetkezo;
    End;
    TuzjelzoLista.Aktualis:=RegiTuzjelzoElem;
  End;
End;

//egy objektumon belüli riasztás(ok) nyugtázása
Procedure TFormVezerlo.RiasztasokNyugat;
Var RegiRiasztoElem  : PRiasztoElem;
    RegiTuzjelzoElem : PTuzjelzoElem;
Begin
  If (RiasztoLista <> Nil) And (RiasztoLista.Elso <> Nil) Then
  Begin
    RegiRiasztoElem:=RiasztoLista.Aktualis;
    RiasztoLista.Aktualis:=RiasztoLista.Elso;
    While (RiasztoLista.Aktualis <> Nil) Do
    Begin
      If RiasztoLista.Aktualis.Allapot Then
      Begin
        RiasztoLista.Aktualis.Allapot:=False;
        RiasztoKuld(RiasztoLista.Aktualis);
        RiasztoLista.Aktualis.Allapot:=True;
      End;
      RiasztoLista.Aktualis:=RiasztoLista.Aktualis.Kovetkezo;
    End;
    RiasztoLista.Aktualis:=RegiRiasztoElem;
  End;
  If (TuzjelzoLista <> Nil) And (TuzjelzoLista.Elso <> Nil) Then
  Begin
    RegiTuzjelzoElem:=TuzjelzoLista.Aktualis;
    TuzjelzoLista.Aktualis:=TuzjelzoLista.Elso;
    While (TuzjelzoLista.Aktualis <> Nil) Do
    Begin
      If TuzjelzoLista.Aktualis.Allapot Then
      Begin
        TuzjelzoLista.Aktualis.Allapot:=False;
        TuzjelzoKuld(TuzjelzoLista.Aktualis);
        TuzjelzoLista.Aktualis.Allapot:=True;
      End;
      TuzjelzoLista.Aktualis:=TuzjelzoLista.Aktualis.Kovetkezo;
    End;
    TuzjelzoLista.Aktualis:=RegiTuzjelzoElem;
  End;
End;

//riasztási hang vezérlése
Procedure TFormVezerlo.HangTimerTimer(Sender: TObject);
Begin       
  Case Hang Of
    0 : HangTimer.Enabled:=False;                         //Nincs hang
    1 : Begin                                             //Egyszeri hang
          If HangThread.Suspended Then HangThread.Resume;
          HangTimer.Enabled:=False;
        End;
    2 : If HangThread.Suspended Then HangThread.Resume;   //Folyamatos hang
  End;
End;

procedure TFormVezerlo.NaploMenuClick(Sender: TObject);
begin
  NaploDlg.ShowModal;
end;

Procedure TFormVezerlo.NyugtaPanelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Begin
  NyugtaPanel.Font.Color:=clYellow;
End;

Procedure TFormVezerlo.NyugtaPanelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Begin
  NyugtaPanel.Font.Color:=clBlack;
End;

Procedure TFormVezerlo.NyugtaPanelClick(Sender: TObject);
Begin
  NaploBeallit;
  RichEdit1.Clear;
  NyugtaPanel.Enabled:=False;
End;

Procedure TFormVezerlo.IdoTimerTimer(Sender: TObject);
Begin
  StatusBar1.Panels[0].Text:='';
  StatusBar1.Panels[0].Text:=TimeToStr(Time);
End;

Procedure TFormVezerlo.SugoMenuClick(Sender: TObject);
Begin
  HelpOpen;
End;

Procedure TFormVezerlo.NevjegyMenuClick(Sender: TObject);
Begin
  //aboutbox létrehozása
  If (Not Assigned (AboutBox)) Then AboutBox:=TAboutBox.Create(Application);
  //aboutbox megnyitása
  AboutBox.ShowModal;
End;

//belépés a RichEdit1-be
Procedure TFormVezerlo.RichEdit1Enter(Sender: TObject);
Begin
  //fókusz továbbadása
  SendMessage(Handle,WM_NEXTDLGCTL,0,0);
End;

End.
