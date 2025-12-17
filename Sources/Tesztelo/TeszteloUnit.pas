Unit TeszteloUnit;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ImgList, Grids, ExtCtrls, StdCtrls, CheckLst, Menus,
  Buttons, FileTablaUnit, MegnyitasUnit, FormFestoUnit, InditUnit, Gomb, Spin,
  EpuletLancUnit, Db, DBTables, HomeroLancUnit, KapcsBerendLancUnit, CPortCtl,
  RiasztoLancUnit, TuzjelzoLancUnit, VegBerendLancUnit, ObjektumUnit, UtilUnit,
  BerendezesekLancUnit, BerendTablaUnit, DBGrids, KodolasUnit, CPort,
  KuldThreadUnit, DataModulUnit;

Const SUGOFILE = '.\SÚGÓ.HLP';

Type
  TFormTesztelo = Class(TForm)
    FileNevEdit           : TEdit;
    Label1                : TLabel;
    Label2                : TLabel;
    Label3                : TLabel;
    Label4                : TLabel;
    Label5                : TLabel;
    Label6                : TLabel;
    Label7                : TLabel;
    Label8                : TLabel;
    Label9                : TLabel;
    Label10               : TLabel;
    Label11               : TLabel;
    Label12               : TLabel;
    Label13               : TLabel;
    Label14               : TLabel;
    Label15               : TLabel;
    Label16               : TLabel;
    Label17               : TLabel;
    Label18               : TLabel;
    Label19               : TLabel;
    Label20               : TLabel;
    Label21               : TLabel;
    Label22               : TLabel;
    Label23               : TLabel;
    Label24               : TLabel;
    Label25               : TLabel;
    Label26               : TLabel;
    Bevel1                : TBevel;
    Bevel2                : TBevel;
    Bevel3                : TBevel;
    Bevel4                : TBevel;
    Bevel5                : TBevel;
    Bevel6                : TBevel;
    Bevel7                : TBevel;
    Bevel9                : TBevel;
    Bevel10               : TBevel;
    Bevel12               : TBevel;
    Bevel14               : TBevel;
    Bevel15               : TBevel;
    Panel2                : TPanel;
    Panel3                : TPanel;
    Panel4                : TPanel;
    Panel5                : TPanel;
    Panel6                : TPanel;
    Panel7                : TPanel;
    Panel8                : TPanel;
    Panel10               : TPanel;
    Panel11               : TPanel;
    Panel12               : TPanel;
    Panel14               : TPanel;
    Panel15               : TPanel;
    Panel16               : TPanel;
    Panel18               : TPanel;
    Panel19               : TPanel;
    Panel20               : TPanel;
    Panel22               : TPanel;
    BeallPanel            : TPanel;
    ErtekPanel            : TPanel;
    EgyebAllapotPanel     : TPanel;
    RiasztoAllapotPanel   : TPanel;
    FutotestAllapotPanel  : TPanel;
    TuzjelzoAllapotPanel  : TPanel;
    HomeroTimer           : TTimer;
    StatusBarTimer        : TTimer;
    KapcsolatTimer        : TTimer;
    KilepesTimer          : TTimer;
    HomeroKuldBtn         : TButton;
    BeallitasBtn          : TBitBtn;
    TorlesBtn             : TBitBtn;
    OpenBtn               : TBitBtn;
    CloseBtn              : TBitBtn;
    MentesBtn             : TBitBtn;
    ConnectBtn            : TBitBtn;
    ComPort               : TComPort;
    ListBox1              : TListBox;
    FutotestListBox       : TListBox;
    RiasztoListBox        : TListBox;
    TuzjelzoListBox       : TListBox;
    EgyebListBox          : TListBox;
    HomeroListBox         : TListBox;
    Splitter1             : TSplitter;
    FulBeallitas          : TTabSheet;
    FulAttekint           : TTabSheet;
    FulHomero             : TTabSheet;
    FulRiaszto            : TTabSheet;
    FulTuzjelzo           : TTabSheet;
    FulFutotest           : TTabSheet;
    FulEgyeb              : TTabSheet;
    FulHelp               : TTabSheet;
    FulBuffer             : TTabSheet;
    FulKilep              : TTabSheet;
    GroupBox1             : TGroupBox;
    GroupBox2             : TGroupBox;
    GroupBox3             : TGroupBox;
    GroupBox4             : TGroupBox;
    HomeroBar             : TTrackBar;
    AutomataKapcsolo      : TKapcsolo;
    FutotestKapcsolo      : TKapcsolo;
    RiasztoKapcsolo       : TKapcsolo;
    TuzjelzoKapcsolo      : TKapcsolo;
    EgyebKapcsolo         : TKapcsolo;
    CheckBox1             : TCheckBox;
    AutInditBox           : TCheckBox;
    SzinAtmenetBox        : TCheckBox;
    HomeroVetelCheckBox   : TCheckBox;
    RiasztoVetelCheckBox  : TCheckBox;
    TuzjelzoVetelCheckBox : TCheckBox;
    FutotestVetelCheckBox : TCheckBox;
    EgyebVetelCheckBox    : TCheckBox;
    HomeroKuldCheckBox    : TCheckBox;
    RiasztoKuldCheckBox   : TCheckBox;
    TuzjelzoKuldCheckBox  : TCheckBox;
    FutotestKuldCheckBox  : TCheckBox;
    EgyebKuldCheckBox     : TCheckBox;
    FormaCheckBox         : TCheckBox;
    RichEdit1             : TRichEdit;
    ScrollBox1            : TScrollBox;
    ScrollBox2            : TScrollBox;
    ScrollBox3            : TScrollBox;
    ScrollBox4            : TScrollBox;
    ScrollBox5            : TScrollBox;
    ScrollBox6            : TScrollBox;
    ScrollBox7            : TScrollBox;
    StatusBar1            : TStatusBar;
    ImageList1            : TImageList;
    BerendGrid            : TStringGrid;
    SpinButton1           : TSpinButton;
    RadioGroup1           : TRadioGroup;
    PercBtn               : TRadioButton;
    MsBtn                 : TRadioButton;
    PageControl           : TPageControl;
    ComBox                : TComComboBox;
    StopBitBox            : TComComboBox;
    BaudRateRadio         : TComRadioGroup;
    DataBitRadio          : TComRadioGroup;
    FlowControlRadio      : TComRadioGroup;
    Procedure FormCreate(Sender: TObject);
    Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    Procedure PageControlChange(Sender: TObject);
    Procedure BeallitasBtnClick(Sender: TObject);
    Procedure FileNevEditDblClick(Sender: TObject);
    Procedure TorlesBtnClick(Sender: TObject);
    Procedure FormActivate(Sender: TObject);
    Procedure MentesBtnClick(Sender: TObject);
    Procedure SzinAtmenetBoxClick(Sender: TObject);
    Procedure FileNevEditChange(Sender: TObject);
    Procedure OpenBtnClick(Sender: TObject);
    Procedure BaudRateRadioClick(Sender: TObject);
    Procedure ComBoxChange(Sender: TObject);
    Procedure StopBitBoxChange(Sender: TObject);
    Procedure DataBitRadioClick(Sender: TObject);
    Procedure FlowControlRadioClick(Sender: TObject);
    Procedure AutInditBoxClick(Sender: TObject);
    Procedure ConnectBtnClick(Sender: TObject);
    Procedure ComPortAfterClose(Sender: TObject);
    Procedure ComPortAfterOpen(Sender: TObject);
    Procedure ComPortRxChar(Sender: TObject; Count: Integer);
    Procedure HomeroBarChange(Sender: TObject);
    Procedure HomeroListBoxClick(Sender: TObject);
    Procedure HomeroTimerTimer(Sender: TObject);
    Procedure AutomataKapcsoloOff(Sender: TObject);
    Procedure AutomataKapcsoloOn(Sender: TObject);
    Procedure HomeroKuldBtnClick(Sender: TObject);
    Procedure SpinButton1UpClick(Sender: TObject);
    Procedure SpinButton1DownClick(Sender: TObject);
    Procedure PercBtnClick(Sender: TObject);
    Procedure ComPortBeforeClose(Sender: TObject);
    Procedure RiasztoListBoxClick(Sender: TObject);
    Procedure TuzjelzoListBoxClick(Sender: TObject);
    Procedure FutotestListBoxClick(Sender: TObject);
    Procedure EgyebListBoxClick(Sender: TObject);
    Procedure HomeroVetelCheckBoxClick(Sender: TObject);
    Procedure HomeroKuldCheckBoxClick(Sender: TObject);
    Procedure RiasztoVetelCheckBoxClick(Sender: TObject);
    Procedure RiasztoKuldCheckBoxClick(Sender: TObject);
    Procedure TuzjelzoVetelCheckBoxClick(Sender: TObject);
    Procedure TuzjelzoKuldCheckBoxClick(Sender: TObject);
    Procedure FutotestVetelCheckBoxClick(Sender: TObject);
    Procedure FutotestKuldCheckBoxClick(Sender: TObject);
    Procedure EgyebVetelCheckBoxClick(Sender: TObject);
    Procedure EgyebKuldCheckBoxClick(Sender: TObject);
    Procedure StatusBarTimerTimer(Sender: TObject);
    Procedure RiasztoKapcsoloClick(Sender: TObject);
    Procedure TuzjelzoKapcsoloClick(Sender: TObject);
    Procedure FutotestKapcsoloClick(Sender: TObject);
    Procedure EgyebKapcsoloClick(Sender: TObject);
    Procedure FormaCheckBoxClick(Sender: TObject);
    Procedure KilepesTimerTimer(Sender: TObject);
    Procedure KapcsolatTimerTimer(Sender: TObject);
    Procedure CloseBtnClick(Sender: TObject);
    Procedure FileNevEditEnter(Sender: TObject);
    Procedure FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure PageControlChanging(Sender: TObject; Var AllowChange: Boolean);
    Procedure RichEdit1Enter(Sender: TObject);
  Private
    Indulas          : Boolean;           //igaz, ha a program elindul
    Kapcsolodik      : Boolean;           //kapcsolat létrehozása
    EpuletNev        : String;            //az épület neve
    EpuletDir        : String;            //az épület-adatbázis könyvtára
    EpuletPath       : String;            //az épület-adatbázis elérési útja
    KuldThread       : TKuldThread;       //kommunikációs szál
    PortAllapot      : TPortAllapot;      //szabad-e a vonal
    UzenetLista      : TUzenetLista;      //az elküldendõ üzenetek listája
    AktHomeroMut     : PHomeroElem;       //aktuális hõmérõre elmre mutat
    AktRiasztoMut    : PRiasztoElem;      //aktuális riasztó elmre mutat
    AktTuzjelzoMut   : PTuzjelzoElem;     //aktuális tûzjelzõ elmre mutat
    AktEgyebMut      : PVegBerendElem;    //aktuális más berendezés elmre mutat
    AktFutotestMut   : PVegBerendElem;    //aktuális fûtõtest elmre mutat
    HomeroLista      : THomeroLista;      //hõmérõk listája
    RiasztoLista     : TRiasztoLista;     //riasztók listája
    TuzjelzoLista    : TTuzjelzoLista;    //tûzjelzõk listája
    VegBerendLista   : TVegBerendLista;   //végberendezések listája
    BerendezesLista  : TBerendezesLista;  //összes berendezések listája
    KapcsBerendLista : TKapcsBerendLista; //egy berend-hez kapcsolódó berend-ek
    TeszteloBeallit  : TTeszteloBeallit;  //a beállításokat segítõ típus
    TextAttributes   : TTextAttrib;       //a RichEdit betûszíne és mérete
    RegiActivePage   : TTabSheet;         //az elõzõ Page-t tárolja
    Function MemoIdo : String;
    Function ComboFeltolt(Berend: String): TStrings;
    Procedure MemoIr(Ido: Boolean; Str: String; Szin: TColor);
    Procedure TablakBetolt;
    Procedure ListakBezarasa;
    Procedure IndulasiErtekek;
    Procedure VetelKuldesBeallit;
    Procedure BerendFelToltesek;
    Procedure BerendGridFrissit;
    Procedure BerendGridFeltolt;
    Procedure HelpOpen;
    Procedure Betoltes(FileNev: String);
    Procedure StatusBarKiIr(Str: String);
    Procedure OsszAdatKuld;
    Procedure HomeroKuld(Mutato: PHomeroElem);
    Procedure RiasztoKuld(Mutato: PRiasztoElem);
    Procedure EgyebKuld(Mutato: PVegBerendElem);
    Procedure TuzjelzoKuld(Mutato: PTuzjelzoElem);
    Procedure FutotestKuld(Mutato: PVegBerendElem);
    Procedure EgyebKeresAndKuld(ID: Integer);
    Procedure HomeroKeresAndKuld(ID: Integer);
    Procedure RiasztoKeresAndKuld(ID: Integer);
    Procedure FutotestKeresAndKuld(ID: Integer);
    Procedure TuzjelzoKeresAndKuld(ID: Integer);
    Procedure UzenetKezelo(Dekod: TAdatUzenetTomb);
    Procedure HomeroEsemeny(Dekod: TAdatUzenetTomb);
    Procedure RiasztoEsemeny(Dekod: TAdatUzenetTomb);
    Procedure TuzjelzoEsemeny(Dekod: TAdatUzenetTomb);
    Procedure FutotestEsemeny(Dekod: TAdatUzenetTomb);
    Procedure EgyebEsemeny(Dekod: TAdatUzenetTomb);
    Procedure EgyebFrissit(Mut: PVegBerendElem);
    Procedure HomeroFrissit(Mut: PHomeroElem);
    Procedure RiasztoFrissit(Mut: PRiasztoElem);
    Procedure TuzjelzoFrissit(Mut: PTuzjelzoElem);
    Procedure FutotestFrissit(Mut: PVegBerendElem);
    Procedure RendszerUzenetKuld(Str: String);
    Procedure Ertelmezo(Str: String);
  Public
    Property ListBox : TListBox Read ListBox1 Write ListBox1;
  End;

Var FormTesztelo : TFormTesztelo;

Implementation

{$R *.DFM}

//egy esemény idõpontját adja vissza. Pl.:'[15:20:45] - '
Function TFormTesztelo.MemoIdo: String;
Begin
  Result:='['+TimeToStr(Time)+'] - ';
End;

//esemény kiírása a RichEdit-be
//IDO: igaz, ha kell idõpont. STR: a kiírandó szöveg. SZIN: a szöveg színe
Procedure TFormTesztelo.MemoIr(Ido: Boolean; Str: String; Szin: TColor);
Begin
  RichEdit1.SelAttributes.Color:=Szin;
  If Ido Then RichEdit1.Lines.Add(MemoIdo+Str)
    Else RichEdit1.Lines.Add(Str);
End;

//az egyes berendezésekhez tartozó ComboBox-ok feltöltése
Function TFormTesztelo.ComboFeltolt(Berend: String): TStrings;
Var I : Integer;
Begin
  Result:=TStringList.Create;
  Result.Clear;
  If (Self.BerendezesLista <> Nil) Then
  Begin
    If Self.BerendezesLista.TombUres Then Self.BerendezesLista.TombFeltolt;
    For I:=0 To High(Self.BerendezesLista.BerendTomb) Do
    Begin
      If (Self.BerendezesLista.BerendTomb[I,3] = Berend) Then
        Result.Add(Self.BerendezesLista.BerendTomb[I,2]);
    End;
  End;
End;

//egy üzenet eltüntetése, ha letelt a 30 ms.
Procedure TFormTesztelo.StatusBarTimerTimer(Sender: TObject);
Begin
  StatusBarTimer.Enabled:=False;
  StatusBar1.Panels[0].Text:='';
End;

//egy üzenet kiírása és az idõzítõ elindítása
Procedure TFormTesztelo.StatusBarKiIr(Str: String);
Begin
  StatusBarTimer.Enabled:=False;
  StatusBarTimer.Interval:=30000;
  StatusBar1.Panels[0].Width:=Self.Width;
  StatusBar1.Panels[0].Alignment:=taCenter;
  StatusBar1.Panels[0].Text:=Str;
  StatusBarTimer.Enabled:=True;
End;

//beállítjuk, hogy vétel vagy küldés esetén mit írjunk ki a RichEdit-be.
Procedure TFormTesztelo.VetelKuldesBeallit;
Begin
  With TeszteloBeallit Do
  Begin
    HomeroVetelCheckBox.Checked:=HomeroVetel;
    RiasztoVetelCheckBox.Checked:=RiasztoVetel;
    TuzjelzoVetelCheckBox.Checked:=TuzjelzoVetel;
    FutotestVetelCheckBox.Checked:=FutotestVetel;
    EgyebVetelCheckBox.Checked:=EgyebVetel;
    HomeroKuldCheckBox.Checked:=HomeroKuld;
    RiasztoKuldCheckBox.Checked:=RiasztoKuld;
    TuzjelzoKuldCheckBox.Checked:=TuzjelzoKuld;
    FutotestKuldCheckBox.Checked:=FutotestKuld;
    EgyebKuldCheckBox.Checked:=EgyebKuld;
  End;
End;

//a help megnyitása
Procedure TFormTesztelo.HelpOpen;
Begin
  //súgófájl megnyitása
  Application.HelpFile:=SUGOFILE;
  Application.HelpCommand(HELP_FINDER,0);
End;

//a form létrehozásakor fut le. Kezdõ értékek beállítása
Procedure TFormTesztelo.FormCreate(Sender: TObject);
Begin
  Indulas:=True;
  RichEdit1.Clear;
  RichEdit1.ReadOnly:=True;
  MemoIr(True,'A rendszer elindult',clBlack);
  PageControl.ActivePage:=FulAttekint;
  HomeroTimer.Enabled:=False;
  KilepesTimer.Enabled:=False;
  KapcsolatTimer.Enabled:=False;
  AutomataKapcsolo.StateOn:=False;
  AktEgyebMut:=Nil;
  AktHomeroMut:=Nil;
  AktRiasztoMut:=Nil;
  AktTuzjelzoMut:=Nil;
  AktFutotestMut:=Nil;
  With TextAttributes Do
  Begin
    Color:=clBlack;
    Height:=RichEdit1.Font.Height;
  End;
  BerendGrid.DoubleBuffered:=True;
  ListBox1.Clear;
  Label26.Visible:=False;
  OpenBtn.Enabled:=True;
  CloseBtn.Enabled:=False;
End;

//mikor a vezérlés fókusza a formra kerül
Procedure TFormTesztelo.FormActivate(Sender: TObject);
Var RegiDirName : String;
    RegiKurzor  : TCursor;
Begin
  //ha a program most lett elindítva
  If Self.Indulas Then
  Begin
    Self.Indulas:=False;
    //eltároljuk az aktuális pozíciónkat. Visszaadja az exe útvonalát.
    RegiDirName:=ExtractFilePath(ParamStr(0));
    //az ini-bõl betöltjük a program beállításait
    TeszteloIniBetolt(sTesztelo,Self,SzinAtmenetBox,FormaCheckBox,AutInditBox,
      FileNevEdit,ComPort,EpuletDir,TeszteloBeallit);
    VetelKuldesBeallit;

    //a komm. csatorna beállítása
    BaudRateRadio.ComPort:=Self.ComPort;
    BaudRateRadio.ComProperty:=cpBaudRate;
    ComBox.ComPort:=Self.ComPort;
    ComBox.ComProperty:=cpPort;
    StopBitBox.ComPort:=Self.ComPort;
    StopBitBox.ComProperty:=cpStopBits;
    DataBitRadio.ComPort:=Self.ComPort;
    DataBitRadio.ComProperty:=cpDataBits;
    FlowControlRadio.ComPort:=Self.ComPort;
    FlowControlRadio.ComProperty:=cpFlowControl;

    //ha van alapértelmezett épületünk, akkor betöltjük.
    If (EpuletDir <> '') Then
    Begin
      PageControl.Visible:=False;
      Splitter1.Visible:=False;
      RichEdit1.Visible:=False;
      RegiKurzor:=Screen.Cursor;
      Screen.Cursor:=1;                  //hõmérõ kurzor beállítása
      InditasDlg.Memo1.Clear;
      InditasDlg.Show;                   //a betöltési folyamat-ablak indítása
      Self.Betoltes(Self.EpuletDir);     //a betöltés indítása
      InditasDlg.Close;                  //a betöltési folyamat-ablak bezárása
      Screen.Cursor:=RegiKurzor;         //eredeti kurzor visszaállítása
      RichEdit1.Visible:=True;
      Splitter1.Visible:=True;
      PageControl.Visible:=True;
      //ha az 'automatikus csatlakozás' ki van jelölve, akkor csatlakounk
      If AutInditBox.Checked Then ConnectBtnClick(Sender);
    End;
    //ha változott volna az alapértelmezett 'direktory', akkor visszaállítjuk
    SetCurrentDir(RegiDirName);
  End;
End;

//kilépés esetén a kapcsolat lezárása és a listák felszabadítása
Procedure TFormTesztelo.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
  Try
    StatusBarTimer.Enabled:=False;
    If ComPort.Connected Then ComPort.Close;
    ListakBezarasa;
  Except
    On E: Exception Do Application.MessageBox(PChar(E.Message),'HIBA',MB_OK);
  End;
End;

//listák felszabadítása
Procedure TFormTesztelo.ListakBezarasa;
Begin
  Try
    If (HomeroLista <> Nil) Then FreeAndNil(HomeroLista);
    If (RiasztoLista <> Nil) Then FreeAndNil(RiasztoLista);
    If (TuzjelzoLista <> Nil) Then FreeAndNil(TuzjelzoLista);
    If (VegBerendLista <> Nil) Then FreeAndNil(VegBerendLista);
    If (BerendezesLista <> Nil) Then FreeAndNil(BerendezesLista);
    If (KapcsBerendLista <> Nil) Then FreeAndNil(KapcsBerendLista);
  Except
    On E: Exception Do Application.MessageBox(PChar(E.Message),'HIBA',MB_OK);
  End;
End;

//page váltás elõtt fut le
Procedure TFormTesztelo.PageControlChanging(Sender: TObject; Var AllowChange: Boolean);
Begin
  RegiActivePage:=PageControl.ActivePage;
End;

//a PageControl fülein történõ kattintás eseménykezelõje
Procedure TFormTesztelo.PageControlChange(Sender: TObject);
Begin
  If (PageControl.ActivePage = FulKilep) Then
  Begin
    If ComPort.Connected Then
    Begin
      Label26.Visible:=True;
      KuldThread.Kuldhet:=False;
      KuldThread.Terminate;
      PortAllapot.Szabad:=False;
      ComPort.Events:=[];
      KilepesTimer.Enabled:=True;
    End
    Else Close;
  End;

  If (PageControl.ActivePage = FulHelp) Then
  Begin
    PageControl.ActivePage:=RegiActivePage;
    HelpOpen;
  End;

  If (PageControl.ActivePage = FulBeallitas) Then
  Begin
    ComPort.BeginUpdate;
    MentesBtn.Enabled:=False;
  End;

  If (PageControl.ActivePage = FulHomero) Then
  Begin
    If (HomeroListBox.Items.Count > 0) Then
    Begin
      If (AktHomeroMut = Nil) Then HomeroListBox.ItemIndex:=0;
      HomeroListBoxClick(Sender);
    End;
    Panel2.Enabled:=(BerendezesLista <> Nil) And (ComPort.Connected);
  End;

  If (PageControl.ActivePage = FulRiaszto) Then
  Begin
    If (RiasztoListBox.Items.Count > 0) Then
    Begin
      If (AktRiasztoMut = Nil) Then RiasztoListBox.ItemIndex:=0;
      RiasztoListBoxClick(Sender);
    End;
    Panel12.Enabled:=(BerendezesLista <> Nil) And (ComPort.Connected);
  End;

  If (PageControl.ActivePage = FulTuzjelzo) Then
  Begin
    If (TuzjelzoListBox.Items.Count > 0) Then
    Begin
      If (AktTuzjelzoMut = Nil) Then TuzjelzoListBox.ItemIndex:=0;
      TuzjelzoListBoxClick(Sender);
    End;
    Panel16.Enabled:=(BerendezesLista <> Nil) And (ComPort.Connected);
  End;

  If (PageControl.ActivePage = FulFutotest) Then
  Begin
    If (FutotestListBox.Items.Count > 0) Then
    Begin
      If (AktFutotestMut = Nil) Then FutotestListBox.ItemIndex:=0;
      FutotestListBoxClick(Sender);
    End;
    Panel8.Enabled:=(BerendezesLista <> Nil) And (ComPort.Connected);
  End;

  If (PageControl.ActivePage = FulEgyeb) Then
  Begin
    If (EgyebListBox.Items.Count > 0) Then
    Begin
      If (AktEgyebMut = Nil) Then EgyebListBox.ItemIndex:=0;
      EgyebListBoxClick(Sender);
    End;
    Panel20.Enabled:=(BerendezesLista <> Nil) And (ComPort.Connected);
  End;
End;

//ha a vezérél rákerül 
Procedure TFormTesztelo.FileNevEditEnter(Sender: TObject);
Begin
  StatusBarKiIr('Ez az érték itt nem módosítható! Módosításhoz használja a "Beállítás..." gombot.');
End;

//egy épület megnyitása, ha a 'Megnyitás' gombra klikkeltünk
Procedure TFormTesztelo.BeallitasBtnClick(Sender: TObject);
Var RegiEdit    : String;
    EpuletNev   : String;
    RegiDirName : String;
    RegiKurzor  : TCursor;
Begin
  RegiEdit:=FileNevEdit.Text;
  RegiDirName:=ExtractFilePath(ParamStr(0));
  If (OpenDlg.ShowModal <> idCancel) Then
  Begin
    EpuletNev:=OpenDlg.Get_DirPath+'\';
    FileNevEdit.Text:=EpuletNev;
    If (Application.MessageBox('Kívánja most betölteni az épületet?','Megnyitás',mb_YesNo) = idYes) Then
    Begin
      RegiKurzor:=Screen.Cursor;
      Screen.Cursor:=1;          //hõmérõ kurzor beállítása
      InditasDlg.Memo1.Clear;
      InditasDlg.Show;           //a betöltési folyamat-ablak indítása
      Betoltes(EpuletNev);       //a betöltés indítása
      InditasDlg.Close;          //a betöltési folyamat-ablak bezárása
      MentesBtnClick(Sender);    //a betöltött épületet alapértelmezetté tesszük
      //az ini-bõl betöltjük a program beállításait
      TeszteloIniBetolt(sTesztelo,Self,SzinAtmenetBox,FormaCheckBox,AutInditBox,
        FileNevEdit,ComPort,EpuletDir,TeszteloBeallit);
      Screen.Cursor:=RegiKurzor; //eredeti kurzor visszaállítása
    End;
  End
  Else FileNevEdit.Text:=RegiEdit;
  SetCurrentDir(RegiDirName);
End;

//ha duplán kattintunk az editbox-on
Procedure TFormTesztelo.FileNevEditDblClick(Sender: TObject);
Begin
  BeallitasBtnClick(Sender);
End;

//ha a 'Törlés' gombra kattintunk. Kitörli az editbox-ot
Procedure TFormTesztelo.TorlesBtnClick(Sender: TObject);
Begin
  FileNevEdit.ReadOnly:=False;
  FileNevEdit.Text:='';
  FileNevEdit.ReadOnly:=True;
End;

//a beállítások elmentése
Procedure TFormTesztelo.MentesBtnClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=False;
  Self.EpuletDir:=Self.FileNevEdit.Text;
  AblakSzin.SzinAtmenet:=Self.SzinAtmenetBox.Checked;
  //a beállítások elmentése ini-be
  TeszteloIniMent(sTesztelo,Self.EpuletDir,AblakSzin.SzinAtmenet,
    FormaCheckBox.Checked,AutInditBox.Checked,ComBox.Text,StopBitBox.ItemIndex,
    BaudRateRadio.ItemIndex,DataBitRadio.ItemIndex,FlowControlRadio.ItemIndex,
    TeszteloBeallit);
End;

//színátmenetes ablakok beállításának vátozása
Procedure TFormTesztelo.SzinAtmenetBoxClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;   //változás esetén a 'Mentés' gomb aktiválása
End;

//kódolt vagy kódolatlan forma változása
Procedure TFormTesztelo.FormaCheckBoxClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;   //változás esetén a 'Mentés' gomb aktiválása
End;

//ha változik az épület elérési útja
Procedure TFormTesztelo.FileNevEditChange(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;   //változás esetén a 'Mentés' gomb aktiválása
End;

//ha változik a baud rate értéke
Procedure TFormTesztelo.BaudRateRadioClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;   //változás esetén a 'Mentés' gomb aktiválása
End;

//ha változik a kommunikációs port
Procedure TFormTesztelo.ComBoxChange(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;   //változás esetén a 'Mentés' gomb aktiválása
End;

//ha változik a stop bit értéke
Procedure TFormTesztelo.StopBitBoxChange(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;   //változás esetén a 'Mentés' gomb aktiválása
End;

//ha változik a data bit értéke
Procedure TFormTesztelo.DataBitRadioClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;   //változás esetén a 'Mentés' gomb aktiválása
End;

//ha változik a flow control értéke
Procedure TFormTesztelo.FlowControlRadioClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;   //változás esetén a 'Mentés' gomb aktiválása
End;

//ha változik az automatikus indítás értéke
Procedure TFormTesztelo.AutInditBoxClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;   //változás esetén a 'Mentés' gomb aktiválása
End;

//a berendezés tábla betöltése
Procedure TFormTesztelo.TablakBetolt;
Var Count : Integer;
Begin
  AliasModosit(Self.EpuletPath);
  DM.BerendezesTable.TableName:=Self.EpuletPath+'\'+sBerendezes+sKit;
  //ha létezik fizikailag a tábla
  If FileExists(DM.BerendezesTable.TableName) Then
    Try
      DM.BerendezesTable.Open;
      InditasDlg.Memo1.Lines.Append('Berendezések betöltése...');
      Count:=InditasDlg.Memo1.Lines.Count-1;
      //a BerendezesLista-t feltöltjük a táblából
      BerendezesLista:=BerendezesLancBetolt(DM.BerendezesTable);
      //ha sikerült
      If (BerendezesLista <> Nil) Then
      Begin
        InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'ok';
        //az egyes listák feltöltése a BerendezesLista-ból
        BerendFelToltesek;
        BerendezesLista.Valtozas:=False;
      End
      Else InditasDlg.Memo1.Lines.Strings[Count]:=InditasDlg.Memo1.Lines.Strings[Count]+'HIBA';
      FormTesztelo.Caption:='Tesztelõ - '+EpuletNev;
    Finally
      DM.BerendezesTable.Close;
    End
  Else FormTesztelo.Caption:='Tesztelõ';
End;

//az egyes listák feltöltése a BerendezesLista-ból
Procedure TFormTesztelo.BerendFelToltesek;
Var Count : Integer;
Begin
  //ha léteznek a listák, akkor felszabadítjuk õket és újakat hozunk létre
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

  //a Windows események lekezelésére átadjuk az op.rendszernek a vezérlést
  Application.ProcessMessages;
  //az InditasDlg frissítése
  InditasDlg.Memo1.Lines.Append('Hõmérõk betöltése...');
  Count:=InditasDlg.Memo1.Lines.Count-1;
  //a HomeroLista feltöltése a HomeroTabla-ból
  If HomeroTablaBeolvas(DM.HomeroTabla,EpuletNev,HomeroLista,BerendezesLista) Then
    InditasDlg.Memo1.Lines.Strings[Count]:=
      InditasDlg.Memo1.Lines.Strings[Count]+'ok'
  Else InditasDlg.Memo1.Lines.Strings[Count]:=
    InditasDlg.Memo1.Lines.Strings[Count]+'HIBA';

  //a Windows események lekezelésére átadjuk az op.rendszernek a vezérlést
  Application.ProcessMessages;
  //az InditasDlg frissítése
  InditasDlg.Memo1.Lines.Append('Riasztók betöltése...');
  Count:=InditasDlg.Memo1.Lines.Count-1;
  //a RiasztoLista feltöltése a RiasztoTabla-ból
  If RiasztoTablaBeolvas(DM.RiasztoTabla,EpuletNev,RiasztoLista,BerendezesLista)
  Then InditasDlg.Memo1.Lines.Strings[Count]:=
    InditasDlg.Memo1.Lines.Strings[Count]+'ok'
  Else InditasDlg.Memo1.Lines.Strings[Count]:=
    InditasDlg.Memo1.Lines.Strings[Count]+'HIBA';

  //a Windows események lekezelésére átadjuk az op.rendszernek a vezérlést
  Application.ProcessMessages;
  //az InditasDlg frissítése
  InditasDlg.Memo1.Lines.Append('Tûzjelzõk betöltése...');
  Count:=InditasDlg.Memo1.Lines.Count-1;
  //a TuzjelzoLista feltöltése a TuzjelzoTabla-ból
  If TuzjelzoTablaBeolvas(DM.TuzjelzoTabla,EpuletNev,TuzjelzoLista,BerendezesLista)
  Then InditasDlg.Memo1.Lines.Strings[Count]:=
    InditasDlg.Memo1.Lines.Strings[Count]+'ok'
  Else InditasDlg.Memo1.Lines.Strings[Count]:=
    InditasDlg.Memo1.Lines.Strings[Count]+'HIBA';

  //a Windows események lekezelésére átadjuk az op.rendszernek a vezérlést
  Application.ProcessMessages;
  //az InditasDlg frissítése
  InditasDlg.Memo1.Lines.Append('Fûtõtestek betöltése...');
  Count:=InditasDlg.Memo1.Lines.Count-1;
  //a VegBerendLista feltöltése a FutotestTabla-ból
  If FutotestTablaBeolvas(DM.FutotestTabla,EpuletNev,VegBerendLista,BerendezesLista)
  Then InditasDlg.Memo1.Lines.Strings[Count]:=
    InditasDlg.Memo1.Lines.Strings[Count]+'ok'
  Else InditasDlg.Memo1.Lines.Strings[Count]:=
    InditasDlg.Memo1.Lines.Strings[Count]+'HIBA';

  //a Windows események lekezelésére átadjuk az op.rendszernek a vezérlést
  Application.ProcessMessages;
  //az InditasDlg frissítése
  InditasDlg.Memo1.Lines.Append('Egyéb berendezések betöltése...');
  Count:=InditasDlg.Memo1.Lines.Count-1;
  //a VegBerendLista feltöltése a EgyebTabla-ból
  If EgyebTablaBeolvas(DM.EgyebTabla,EpuletNev,VegBerendLista,BerendezesLista)
  Then InditasDlg.Memo1.Lines.Strings[Count]:=
    InditasDlg.Memo1.Lines.Strings[Count]+'ok'
  Else InditasDlg.Memo1.Lines.Strings[Count]:=
    InditasDlg.Memo1.Lines.Strings[Count]+'HIBA';

  //a Windows események lekezelésére átadjuk az op.rendszernek a vezérlést
  Application.ProcessMessages;
  //az InditasDlg frissítése
  InditasDlg.Memo1.Lines.Append('Kapcsolódások betöltése...');
  Count:=InditasDlg.Memo1.Lines.Count-1;
  //a KapcsBerendLista feltöltése a KapcsTabla-ból
  If KapcsTablaBeolvas(DM.KapcsTabla,EpuletNev,KapcsBerendLista,BerendezesLista)
  Then InditasDlg.Memo1.Lines.Strings[Count]:=
    InditasDlg.Memo1.Lines.Strings[Count]+'ok'
  Else InditasDlg.Memo1.Lines.Strings[Count]:=
    InditasDlg.Memo1.Lines.Strings[Count]+'HIBA';
End;

//épület betöltése
Procedure TFormTesztelo.Betoltes(FileNev: String);
Var DirNev : String;
Begin
  DirNev:=ExtractFilePath(FileNev);
  //az utolsó '\' jelet levágjuk
  System.Delete(DirNev,Length(DirNev),1);
  Self.EpuletPath:=DirNev;
  Self.EpuletNev:=AktDirNev(Self.EpuletPath);
  //a berendezés tábla betöltése
  TablakBetolt;
  //az egyes elemekhez tartozó ListBox-ok feltöltése
  IndulasiErtekek;
  //a BerendGrid frissítése
  BerendGridFrissit;
  OpenBtn.Enabled:=False;
  CloseBtn.Enabled:=True;
End;

//az Áttekintés oldalán lévõ grid feltöltése a kezdeti értékekkel
Procedure TFormTesztelo.BerendGridFeltolt;
Var I : Integer;
Begin
  BerendGrid.RowCount:=2;
  BerendGrid.Rows[1].Clear;
  //fejléc beállítása
  BerendGrid.Cells[0,0]:='Berendezés neve';
  BerendGrid.Cells[1,0]:='Azonosító';
  BerendGrid.Cells[2,0]:='Állapot';
  BerendGrid.Cells[3,0]:='Aktuális érték';
  BerendGrid.Cells[4,0]:='Beállított érték';
  //ha a BerendezesLista nem üres
  If (BerendezesLista <> Nil) And (BerendezesLista.Elso <> Nil) Then
  Begin
    If BerendezesLista.TombUres Then BerendezesLista.TombFeltolt;
    For I:=0 To High(BerendezesLista.BerendTomb) Do
    Begin
      BerendGrid.RowCount:=i+2;
      //a berendezés neve
      BerendGrid.Cells[0,i+1]:=BerendezesLista.BerendTomb[i,2];
      //a berendezés azonosítója
      BerendGrid.Cells[1,i+1]:=BerendezesLista.BerendTomb[i,1];
    End;
  End;
End;

//épület megnyitása
Procedure TFormTesztelo.OpenBtnClick(Sender: TObject);
Var RegiDirName : String;
    RegiKurzor  : TCursor;
Begin
  RegiDirName:=ExtractFilePath(ParamStr(0));
  //ha van betöltendõ épület, akkor betöltjük
  If (OpenDlg.ShowModal <> idCancel) Then
  Begin
    RegiKurzor:=Screen.Cursor;
    Screen.Cursor:=1;          //hõmérõ kurzor beállítása
    InditasDlg.Memo1.Clear;
    InditasDlg.Show;           //a betöltési folyamat-ablak indítása
    Betoltes(OpenDlg.Get_DirPath+'\');
    InditasDlg.Close;          //a betöltési folyamat-ablak bezárása
    MentesBtnClick(Sender);    //a betöltött épületet alapértelmezetté tesszük
    //az ini-bõl betöltjük a program beállításait
    TeszteloIniBetolt(sTesztelo,Self,SzinAtmenetBox,FormaCheckBox,AutInditBox,
      FileNevEdit,ComPort,EpuletDir,TeszteloBeallit);
    Screen.Cursor:=RegiKurzor; //eredeti kurzor visszaállítása
  End;
  SetCurrentDir(RegiDirName);
End;

//a BerendGrid frissítése
Procedure TFormTesztelo.BerendGridFrissit;
Var I,ID         : Integer;
    BerendMut    : PLancElem;
    HomeroMut    : PHomeroElem;
    RiasztoMut   : PRiasztoElem;
    TuzjelzoMut  : PTuzjelzoElem;
    VegBerendMut : PVegBerendElem;
Begin
  //ha a BerendezesLista nem üres
  If (BerendezesLista <> Nil) And (BerendezesLista.Elso <> Nil) Then
  Begin
    For I:=1 To BerendGrid.RowCount-1 Do
    Begin
      //az azonosító alapján megkeressük a berendezés típusát
      ID:=StrToInt(BerendGrid.Cells[1,i]);
      If BerendezesLista.KeresID(ID,BerendMut) Then
      Begin
        Case BerendMut.BerendezesTip Of
                       //ha megvan az azonosítóhoz tartozó hõmérõ
          btHomero   : If HomeroLista.KeresID(ID,HomeroMut) Then
                       Begin
                         BerendGrid.Cells[2,i]:='-';
                         BerendGrid.Cells[3,i]:=IntToStr(HomeroMut.MertErtek)+sCelsius;
                         BerendGrid.Cells[4,i]:=IntToStr(HomeroMut.BeallErtek)+sCelsius;
                       End;
                       //ha megvan az azonosítóhoz tartozó risztó
          btRiaszto  : If RiasztoLista.KeresID(ID,RiasztoMut) Then
                       Begin
                         If RiasztoMut.Allapot Then BerendGrid.Cells[2,i]:='Riasztás'
                           Else BerendGrid.Cells[2,i]:='Normál';
                         BerendGrid.Cells[3,i]:='-';
                         BerendGrid.Cells[4,i]:='-';
                       End;
                       //ha megvan az azonosítóhoz tartozó tûzjelzõ
          btTuzjelzo : If TuzjelzoLista.KeresID(ID,TuzjelzoMut) Then
                       Begin
                         If TuzjelzoMut.Allapot Then BerendGrid.Cells[2,i]:='Tûzjelzés'
                           Else BerendGrid.Cells[2,i]:='Normál';
                         BerendGrid.Cells[3,i]:='-';
                         BerendGrid.Cells[4,i]:='-';
                       End;
                       //ha megvan az azonosítóhoz tartozó végberendezés
          btEgyeb,
          btFutotest : If VegBerendLista.KeresID(ID,VegBerendMut) Then
                       Begin
                         If VegBerendMut.Allapot Then BerendGrid.Cells[2,i]:='Be'
                           Else BerendGrid.Cells[2,i]:='Ki';
                         BerendGrid.Cells[3,i]:='-';
                         BerendGrid.Cells[4,i]:='-';
                       End;
        End;
      End;
    End;
  End;
End;

//a kapcsolódás gomb megnyomása
Procedure TFormTesztelo.ConnectBtnClick(Sender: TObject);
Begin
  //ha van berendezés
  If (BerendezesLista <> Nil) And (BerendezesLista.Elso <> Nil) Then
    If ComPort.Connected Then
    Begin
      KuldThread.Kuldhet:=False;
      KuldThread.Terminate;
      PortAllapot.Szabad:=False;
      ComPort.ClearBuffer(True,True);
      KapcsolatTimer.Enabled:=True;
    End
    Else Begin
      //port beállításainak aktualizálása
      ComPort.EndUpdate;
      ComPort.Open;
    End
  Else StatusBarKiIr('Nincs épület file betöltve! Használja a "Megnyitás" gombot.');
End;

//a kapcsolat bontása elõtti teendõk
Procedure TFormTesztelo.ComPortBeforeClose(Sender: TObject);
Begin
  PortAllapot.Szabad:=False;
  RendszerUzenetKuld(rKapcsVege);
End;

//a kapcsolat bontása utáni teendõk
Procedure TFormTesztelo.ComPortAfterClose(Sender: TObject);
Begin
  ConnectBtn.Font.Color:=clGreen;
  ConnectBtn.Caption:='&Csatlakozás';
  ConnectBtn.Hint:='Kapcsolat megnyitása';
  MemoIr(True,'Az adatcsatorna lezárva a '+ComPort.Port+' porton',clBlack);
  //az UzenetLista felszabadítása
  If (UzenetLista <> Nil) Then FreeAndNil(UzenetLista);
  //az KuldThread szál felszabadítása
  If (KuldThread <> Nil) Then FreeAndNil(KuldThread);
  //az Output buffer kijelzõ törlése
  ListBox1.Clear;
End;

//a kapcsolat megnyitása utáni teendõk
Procedure TFormTesztelo.ComPortAfterOpen(Sender: TObject);
Begin
  Kapcsolodik:=False;
  ConnectBtn.Font.Color:=clMaroon;
  ConnectBtn.Caption:='Ka&pcsolat bontása';
  ConnectBtn.Hint:='Kapcsolat bezárása';
  MemoIr(True,'Az adatcsatorna megnyitva a '+ComPort.Port+' porton',clBlack);
  //a csatorna állapota legyen foglalt
  PortAllapot.Szabad:=False;
  //az UzenetLista létrehozása
  UzenetLista:=TUzenetLista.Create(Self,ListBox1);
  //az KuldThread szál létrehozása
  KuldThread:=TKuldThread.Create(ComPort,@PortAllapot,@UzenetLista,RichEdit1);
End;

//a vonalon bejövõ értékek elemzése
Procedure TFormTesztelo.Ertelmezo(Str: String);
Var Dekod : TAdatUzenetTomb; //a dekódolt üzenet
Begin
  If (Str = rKapcsKer) Then
  Begin
    Kapcsolodik:=True;
    ComPort.WriteStr(rKapcsKesz);
    Exit;
  End;

  //ha kapcsolat vége
  If (Str = rKapcsVege) Then
  Begin
    If HomeroTimer.Enabled Then AutomataKapcsolo.StateOn:=False;
    //letiltjuk a kimenõ üzeneteket
    PortAllapot.Szabad:=False;
    ComPort.ClearBuffer(True,True);
    Exit;
  End;

  //ha a vétel nyugtázása
  If (Str = rNyugta) Then
  Begin
    If Kapcsolodik Then
    Begin
      Kapcsolodik:=False;
      //a csatorna állapota legyen szabad
      PortAllapot.Szabad:=True;
      MemoIr(True,'Kapcsolat létrejött.',clBlack);
      //a berendezések adatainak elküldése
      OsszAdatKuld;
    End
    Else PortAllapot.Szabad:=True;
    Exit;
  End;

  //ha hibásan ment át
  If (Str = rHiba) Then
  Begin
    //az InputBuffer ürítése
    ComPort.ClearBuffer(True,False);
    //ha van az üzenetbõl másolatunk, akkor ismét elküldjük
    If (UzenetLista.Masolat <> Nil) Then
    Begin
      If (UzenetLista.Masolat.Szoveg <> '') Then
        UzenetLista.Masolat.Szoveg:=UzenetLista.Masolat.Szoveg+' (ismételt)';
      UzenetLista.Felfuz(True,UzenetLista.Masolat.Uzenet,
        UzenetLista.Masolat.Szoveg,UzenetLista.Masolat.Attrib);
      //a másolat törlése
      UzenetLista.MasolatTorles;
    End;
    //küldünk egy nyugta üzenetet, hogy jöhet a következõ
    RendszerUzenetKuld(rNyugta);
    PortAllapot.Szabad:=True;
    Exit;
  End;

  //ha nem rendszerüzenetet kaptunk
  SetLength(Dekod,0);
  //az üzenetet dekódoljuk
  Dekod:=Dekodolo(Str);
  //ha értelmes üzenetet kaptunk
  If (High(Dekod) > -1) Then Uzenetkezelo(Dekod)
  Else Begin
    //különben küldünk egy hiba üzenetet
    ComPort.ClearBuffer(True,False);
    MemoIr(False,'HIBA: Adatvételi hiba. Ismételt adatkérés...',clBlack);
    RendszerUzenetKuld(rHiba);
  End;
End;

//egy karakter vétele a porton keresztül
Procedure TFormTesztelo.ComPortRxChar(Sender: TObject; Count: Integer);
Var Str     : String;
    Uzenet  : String;
    I       : Integer;
Begin
  Uzenet:='';
  ComPort.ReadStr(Str,Count);
  If (Str <> '') Then
  Begin
    //végigmegyünk az üzeneten
    For I:=1 To Count Do
    Begin
      //ha esetleg több üzenet érkezett, akkor a határoló jel alapján szétválasztjuk
      If (Str[I] <> sHatJel) Then Uzenet:=Uzenet+Str[I]
      Else Begin
        Ertelmezo(Uzenet);
        Uzenet:='';
      End;
    End;
  End;
End;

//rendszerüzenet küldése
Procedure TFormTesztelo.RendszerUzenetKuld(Str: String);
Begin
  //az üzenetek küldésének felfüggesztése
  KuldThread.Kuldhet:=False;
  KuldThread.Suspend;
  If ComPort.Connected Then
  Begin
    //várunk amíg kiürül az OutputBuffer
    Repeat Until (ComPort.OutputCount = 0);
    //rendszerüzenet elküldése
    ComPort.WriteStr(Str+sHatJel);
    Repeat Until (ComPort.OutputCount = 0);
  End;
  //az üzenetek küldésének folytatása
  KuldThread.Kuldhet:=True;
  KuldThread.Resume; 
End;

//a dekódolt üzenetet feldolgozzuk
Procedure TFormTesztelo.UzenetKezelo(Dekod: TAdatUzenetTomb);
Var LancElem : PlancElem;
Begin
  //rákeresünk az üzenetben lévõ berendezés típusára
  If BerendezesLista.KeresID(Dekod[0],LancElem) Then
  Begin
    Case LancElem.BerendezesTip Of
      btHomero   : HomeroEsemeny(Dekod);
      btRiaszto  : RiasztoEsemeny(Dekod);
      btTuzjelzo : TuzjelzoEsemeny(Dekod);
      btFutotest : FutotestEsemeny(Dekod);
      btEgyeb    : EgyebEsemeny(Dekod);
    End;
  End;
  //vége a feldolgozásnak és küldünk egy nyugta üzenetet, hogy jöhet a következõ
  RendszerUzenetKuld(rNyugta);
End;

//a kapott üzenet hõmérõtõl származik
Procedure TFormTesztelo.HomeroEsemeny(Dekod: TAdatUzenetTomb);
Var HomeroMut : PHomeroElem;
Begin
  If HomeroLista.KeresID(Dekod[0],HomeroMut) Then
  Begin
    //ha kívánjuk, hogy kiírjuk az üzenetet
    If TeszteloBeallit.HomeroVetel Then
    Begin
      MemoIr(False,'('+IntToStr(Dekod[0])+') '+
        HomeroMut.HomeroMutato.BerendezesNev+' beállítása.',clBlack);
    End;
    //hõmérõ frissítése
    If (High(Dekod) > 0) Then
    Begin
      HomeroMut.Min:=Dekod[1];
      HomeroMut.Max:=Dekod[2];
      HomeroMut.BeallErtek:=Dekod[3];
    End;
    //Grid frissítése
    BerendGridFrissit;
    If (HomeroMut = AktHomeroMut) Then HomeroFrissit(HomeroMut);
  End;
End;

//a kapott üzenet más berendezéstõl származik
Procedure TFormTesztelo.EgyebEsemeny(Dekod: TAdatUzenetTomb);
Var Szin     : TColor;
    sErtek   : String;
    EgyebMut : PVegBerendElem;
Begin
  If (VegBerendLista <> Nil) And VegBerendLista.KeresID(Dekod[0],EgyebMut) Then
  Begin
    EgyebMut.Allapot:=IntToBool(Dekod[1]);
    //ha kívánjuk, hogy kiírjuk az üzenetet
    If TeszteloBeallit.EgyebVetel Then
    Begin
      If EgyebMut.Allapot Then
      Begin
        sErtek:='Be';
        Szin:=clGreen;
      End
      Else Begin
        sErtek:='Ki';
        Szin:=clRed;
      End;
      MemoIr(True,'('+IntToStr(Dekod[0])+') '+EgyebMut.VegBerendMutato.BerendezesNev+
        ' állapota: '+sErtek,Szin);
    End;
    //Grid frissítése
    BerendGridFrissit;
    If (EgyebMut = AktEgyebMut) Then EgyebFrissit(EgyebMut);
    //visszaigazolás
    EgyebKuld(EgyebMut);
  End;
End;

//a kapott üzenet fûtõtestõl származik
Procedure TFormTesztelo.FutotestEsemeny(Dekod: TAdatUzenetTomb);
Var Szin        : TColor;
    sErtek      : String;
    FutotestMut : PVegBerendElem;
Begin
  If (VegBerendLista <> Nil) And VegBerendLista.KeresID(Dekod[0],FutotestMut) Then
  Begin
    FutotestMut.Allapot:=IntToBool(Dekod[1]);
    //ha kívánjuk, hogy kiírjuk az üzenetet
    If TeszteloBeallit.FutotestVetel Then
    Begin
      If FutotestMut.Allapot Then
      Begin
        sErtek:='Be';
        Szin:=clGreen;
      End
      Else Begin
        sErtek:='Ki';
        Szin:=clRed;
      End;
      MemoIr(True,'('+IntToStr(Dekod[0])+') '+
        FutotestMut.VegBerendMutato.BerendezesNev+' állapota: '+sErtek,Szin);
    End;
    //Grid frissítése
    BerendGridFrissit;
    If (FutotestMut = AktFutotestMut) Then FutotestFrissit(FutotestMut);
    //visszaigazolás
    FutotestKuld(FutotestMut);
  End;
End;

//a kapott üzenet riasztótól származik
Procedure TFormTesztelo.RiasztoEsemeny(Dekod: TAdatUzenetTomb);
Var Szin       : TColor;
    sErtek     : String;
    RiasztoMut : PRiasztoElem;
Begin
  If RiasztoLista.KeresID(Dekod[0],RiasztoMut) Then
  Begin
    RiasztoMut.Allapot:=IntToBool(Dekod[1]);
    //ha kívánjuk, hogy kiírjuk az üzenetet
    If TeszteloBeallit.RiasztoVetel Then
    Begin
      If RiasztoMut.Allapot Then
      Begin
        sErtek:='Riasztás';
        Szin:=clRed;
      End
      Else Begin
        sErtek:='Normál';
        Szin:=clGreen;
      End;
      MemoIr(True,'('+IntToStr(Dekod[0])+') '+RiasztoMut.RiasztoMutato.BerendezesNev+
        ' állapota: '+sErtek,Szin);
    End;
    //Grid frissítése
    BerendGridFrissit;
    If (RiasztoMut = AktRiasztoMut) Then RiasztoFrissit(RiasztoMut);
    //visszaigazolás
    RiasztoKuld(RiasztoMut);
  End;
End;

//a kapott üzenet tûzjelzõtõl származik
Procedure TFormTesztelo.TuzjelzoEsemeny(Dekod: TAdatUzenetTomb);
Var Szin        : TColor;
    sErtek      : String;
    TuzjelzoMut : PTuzjelzoElem;
Begin
  If TuzjelzoLista.KeresID(Dekod[0],TuzjelzoMut) Then
  Begin
    TuzjelzoMut.Allapot:=IntToBool(Dekod[1]);
    //ha kívánjuk, hogy kiírjuk az üzenetet
    If TeszteloBeallit.TuzjelzoVetel Then
    Begin
      If TuzjelzoMut.Allapot Then
      Begin
        sErtek:='Tûzjelzés';
        Szin:=clRed;
      End
      Else Begin
        sErtek:='Normál';
        Szin:=clGreen;
      End;
      MemoIr(True,'('+IntToStr(Dekod[0])+') '+
        TuzjelzoMut.TuzjelzoMutato.BerendezesNev+' állapota: '+sErtek,Szin);
    End;
    //Grid frissítése
    BerendGridFrissit;
    If (TuzjelzoMut = AktTuzjelzoMut) Then TuzjelzoFrissit(TuzjelzoMut);
    //visszaigazolás
    TuzjelzoKuld(TuzjelzoMut);
  End;
End;

//a hõmérõ mért-értékének változtatása
Procedure TFormTesztelo.HomeroBarChange(Sender: TObject);
Begin
  //csak akkor lehet, ha nincs automatában
  If (Not CheckBox1.Checked) And (Not AutomataKapcsolo.StateOn) Then
  Begin
    HomeroBar.SelEnd:=HomeroBar.Position;
    ErtekPanel.Caption:=IntToStr(HomeroBar.Position)+sCelsius;
    Self.AktHomeroMut.MertErtek:=HomeroBar.Position;
  End;
  If CheckBox1.Checked And (Not AutomataKapcsolo.StateOn) Then
    HomeroBar.Position:=HomeroBar.SelEnd;
End;

//frissíti a 'Hõmérõ' panelt a megadott mutató alapján
Procedure TFormTesztelo.HomeroFrissit(Mut: PHomeroElem);
Var BarAllapot : Boolean;
Begin
  If (Mut <> Nil) Then
  Begin
    BarAllapot:=HomeroBar.Enabled;
    Label3.Caption:=IntToStr(Mut.Min);
    Label4.Caption:=IntToStr(Mut.Max);
    HomeroBar.Enabled:=True;
    HomeroBar.Min:=Mut.Min;
    HomeroBar.Max:=Mut.Max;
    HomeroBar.Position:=Mut.MertErtek;
    HomeroBar.SelEnd:=HomeroBar.Position;
    HomeroBar.SelStart:=HomeroBar.Min;
    BeallPanel.Caption:=IntToStr(Mut.BeallErtek)+sCelsius;
    ErtekPanel.Caption:=IntToStr(HomeroBar.Position)+sCelsius;
    If (Not BarAllapot) Then HomeroBar.Enabled:=False;
  End;
End;

//hõmérõ kiválasztása
Procedure TFormTesztelo.HomeroListBoxClick(Sender: TObject);
Var ID        : Integer;
    HomeroMut : PHomeroElem;
Begin
  //megkeressük az azonosítót
  ID:=BerendezesLista.KeresNev(HomeroListBox.Items[HomeroListBox.ItemIndex]);
  //megkeressük a hõmérõt
  HomeroLista.KeresID(ID,HomeroMut);
  If (HomeroMut <> Nil) Then
  Begin
    Self.AktHomeroMut:=HomeroMut;
    //frissíti a hõmérõ panelt
    HomeroFrissit(AktHomeroMut);
  End;
End;

//frissíti a 'Riasztó' panelt a megadott mutató alapján
Procedure TFormTesztelo.RiasztoFrissit(Mut: PRiasztoElem);
Begin
  If (Mut <> Nil) Then
    If Mut.Allapot Then
    Begin
      RiasztoKapcsolo.StateOn:=True;
      RiasztoAllapotPanel.Caption:='Riasztás';
    End
    Else Begin
      RiasztoKapcsolo.StateOn:=False;
      RiasztoAllapotPanel.Caption:='Normál';
    End;
End;

Procedure TFormTesztelo.RiasztoListBoxClick(Sender: TObject);
Var ID         : Integer;
    RiasztoMut : PRiasztoElem;
Begin
  //megkeressük az azonosítót
  ID:=BerendezesLista.KeresNev(RiasztoListBox.Items[RiasztoListBox.ItemIndex]);
  //megkeressük a riasztót
  RiasztoLista.KeresID(ID,RiasztoMut);
  If (RiasztoMut <> Nil) Then
  Begin
    Self.AktRiasztoMut:=RiasztoMut;
    //frissíti a riasztó panelt
    RiasztoFrissit(AktRiasztoMut);
  End;
End;

//frissíti a 'Tûzjelzõ' panelt a megadott mutató alapján
Procedure TFormTesztelo.TuzjelzoFrissit(Mut: PTuzjelzoElem);
Begin
  If (Mut <> Nil) Then
    If Mut.Allapot Then
    Begin
      TuzjelzoKapcsolo.StateOn:=True;
      TuzjelzoAllapotPanel.Caption:='Tûzjelzés';
    End
    Else Begin
      TuzjelzoKapcsolo.StateOn:=False;
      TuzjelzoAllapotPanel.Caption:='Normál';
    End;
End;

Procedure TFormTesztelo.TuzjelzoListBoxClick(Sender: TObject);
Var ID          : Integer;
    TuzjelzoMut : PTuzjelzoElem;
Begin
  //megkeressük az azonosítót
  ID:=BerendezesLista.KeresNev(TuzjelzoListBox.Items[TuzjelzoListBox.ItemIndex]);
  //megkeressük a tûzjelzõt
  TuzjelzoLista.KeresID(ID,TuzjelzoMut);
  If (TuzjelzoMut <> Nil) Then
  Begin
    Self.AktTuzjelzoMut:=TuzjelzoMut;
    //frissíti a tûzjelzõ panelt
    TuzjelzoFrissit(AktTuzjelzoMut);
  End;
End;

//frissíti a 'Fûtõtest' panelt a megadott mutató alapján
Procedure TFormTesztelo.FutotestFrissit(Mut: PVegBerendElem);
Begin
  If (Mut <> Nil) Then
    If Mut.Allapot Then
    Begin
      FutotestKapcsolo.StateOn:=True;
      FutotestAllapotPanel.Caption:='Bekapcsolva';
    End
    Else Begin
      FutotestKapcsolo.StateOn:=False;
      FutotestAllapotPanel.Caption:='Kikapcsolva';
    End;
End;

Procedure TFormTesztelo.FutotestListBoxClick(Sender: TObject);
Var ID          : Integer;
    FutotestMut : PVegBerendElem;
Begin
  //megkeressük az azonosítót
  ID:=BerendezesLista.KeresNev(FutotestListBox.Items[FutotestListBox.ItemIndex]);
  //megkeressük a fûtõtestet
  VegBerendLista.KeresID(ID,FutotestMut);
  If (FutotestMut <> Nil) Then
  Begin
    Self.AktFutotestMut:=FutotestMut;
    //frissíti a fûtõtestet
    FutotestFrissit(AktFutotestMut);
  End;
End;

//frissíti a 'Más berensezések' panelt a megadott mutató alapján
Procedure TFormTesztelo.EgyebFrissit(Mut: PVegBerendElem);
Begin
  If (Mut <> Nil) Then
    If Mut.Allapot Then
    Begin
      EgyebKapcsolo.StateOn:=True;
      EgyebAllapotPanel.Caption:='Bekapcsolva';
    End
    Else Begin
      EgyebKapcsolo.StateOn:=False;
      EgyebAllapotPanel.Caption:='Kikapcsolva';
    End;
End;

Procedure TFormTesztelo.EgyebListBoxClick(Sender: TObject);
Var ID       : Integer;
    EgyebMut : PVegBerendElem;
Begin
  //megkeressük az azonosítót
  ID:=BerendezesLista.KeresNev(EgyebListBox.Items[EgyebListBox.ItemIndex]);
  //megkeressük a berendezést
  VegBerendLista.KeresID(ID,EgyebMut);
  If (EgyebMut <> Nil) Then
  Begin
    Self.AktEgyebMut:=EgyebMut;
    //frissíti a berensezéseket
    EgyebFrissit(AktEgyebMut);
  End;
End;

//az egyes elemekhez tartozó ListBox-ok feltöltése
Procedure TFormTesztelo.IndulasiErtekek;
Begin
  //az Áttekintés oldalán lévõ grid feltöltése a kezdeti értékekkel
  BerendGridFeltolt;
  //a HomeroListBox feltöltése
  HomeroListBox.Items:=Self.ComboFeltolt(sHomero);
  HomeroListBox.ItemIndex:=0;
  //ha van hõmérõ
  If (HomeroLista <> Nil) And (HomeroLista.Elso <> Nil) Then
  Begin
    //végig megyünk a HomeroLista-n
    HomeroLista.Aktualis:=HomeroLista.Elso;
    While (HomeroLista.Aktualis <> Nil) Do
    Begin
      //beállítjuk az induláshoz a mért értékeket
      HomeroLista.Aktualis.MertErtek:=(HomeroLista.Aktualis.Min+HomeroLista.Aktualis.Max) Div 2;
      HomeroLista.Aktualis:=HomeroLista.Aktualis.Kovetkezo;
    End;
  End;
  //a többi ListBox feltöltése
  RiasztoListBox.Items:=Self.ComboFeltolt(sRiaszto);
  RiasztoListBox.ItemIndex:=0;
  TuzjelzoListBox.Items:=Self.ComboFeltolt(sTuzjelzo);
  TuzjelzoListBox.ItemIndex:=0;
  FutotestListBox.Items:=Self.ComboFeltolt(sFutotest);
  FutotestListBox.ItemIndex:=0;
  EgyebListBox.Items:=Self.ComboFeltolt(sEgyeb);
  EgyebListBox.ItemIndex:=0;
End;

//az összes berendezés adatainak elküldése
Procedure TFormTesztelo.OsszAdatKuld;
Begin
  //ha van berendezésünk
  If (BerendezesLista <> Nil) And (BerendezesLista.Elso <> Nil) Then
  Begin
    //végigmegyünk a láncon
    With BerendezesLista Do
    Begin
      Aktualis:=Elso;
      While (Aktualis <> Nil) Do
      Begin
        //elküldjük az aktuális berendezés adatait                            
        Case Aktualis.BerendezesTip Of
          btHomero   : HomeroKeresAndKuld(Aktualis.ID);
          btRiaszto  : RiasztokeresAndKuld(Aktualis.ID);
          btTuzjelzo : TuzjelzoKeresAndKuld(Aktualis.ID);
          btFutotest : FutotestKeresAndKuld(Aktualis.ID);
          btEgyeb    : EgyebKeresAndKuld(Aktualis.ID);
        End;
        Aktualis:=Aktualis.Kovetkezo;
      End;
    End;
  End;
End;

//ID alapján megkeressük a berendezést és elküldjük az adatait
Procedure TFormTesztelo.HomeroKeresAndKuld(ID: Integer);
Var HomeroMut : PHomeroElem;
Begin
  If (HomeroLista <> Nil) And HomeroLista.KeresID(ID,HomeroMut) Then
    HomeroKuld(HomeroMut);
End;

//egy hõmérõ adatainak elküldése
Procedure TFormTesztelo.HomeroKuld(Mutato: PHomeroElem);
Var Szoveg : String;
    Uzenet : String;
    UzTomb : TAdatUzenetTomb;
Begin
  //ha van mit küldeni és él a kapcsolat
  If (Mutato <> Nil) And (ComPort.Connected) Then
  Begin
    //kódoljuk az üzenetet
    SetLength(UzTomb,2);
    UzTomb[0]:=Mutato.ID;
    UzTomb[1]:=Mutato.MertErtek;
    Uzenet:=Kodolo(UzTomb);
    //ha az eseményt ki kell írni
    If TeszteloBeallit.HomeroKuld Then
    Begin
      If FormaCheckBox.Checked Then
        Szoveg:='Elküldve: Hõmérõ(ID:'+IntToStr(Mutato.ID)+',Érték:'+
              IntToStr(Mutato.MertErtek)+')'
      Else Szoveg:='Elküldve: '+Uzenet;
    End Else Szoveg:='';
    TextAttributes.Color:=clBlue;
    //az üzenet felfûzése az elküldendõk listájára
    UzenetLista.Felfuz(False,Uzenet,Szoveg,TextAttributes);
    SetLength(UzTomb,0);
  End;
End;

//ID alapján megkeressük a berendezést és elküldjük az adatait
Procedure TFormTesztelo.RiasztoKeresAndKuld(ID: Integer);
Var RiasztoMut : PRiasztoElem;
Begin
  If (RiasztoLista <> Nil) And RiasztoLista.KeresID(ID,RiasztoMut) Then
    RiasztoKuld(RiasztoMut);
End;

Procedure TFormTesztelo.RiasztoKuld(Mutato: PRiasztoElem);
Var Szoveg : String;
    Uzenet : String;
    UzTomb : TAdatUzenetTomb;
Begin
  //ha van mit küldeni és él a kapcsolat
  If (Mutato <> Nil) And (ComPort.Connected) Then
  Begin
    //kódoljuk az üzenetet
    SetLength(UzTomb,2);
    UzTomb[0]:=Mutato.ID;
    UzTomb[1]:=BoolToInt(Mutato.Allapot);
    Uzenet:=Kodolo(UzTomb);
    //ha az eseményt ki kell írni
    If TeszteloBeallit.RiasztoKuld Then
    Begin
      If FormaCheckBox.Checked Then
      Begin
        If Mutato.Allapot Then
          Szoveg:='Elküldve: Riasztó(ID:'+IntToStr(Mutato.ID)+',Érték:Be)'
        Else Szoveg:='Elküldve: Riasztó(ID:'+IntToStr(Mutato.ID)+',Érték:Ki)';
      End Else Szoveg:='Elküldve: '+Uzenet
    End Else Szoveg:='';
    TextAttributes.Color:=clBlue;
    //az üzenet felfûzése az elküldendõk listájára
    UzenetLista.Felfuz(True,Uzenet,Szoveg,TextAttributes);
    SetLength(UzTomb,0);
  End;
End;

//ID alapján megkeressük a berendezést és elküldjük az adatait
Procedure TFormTesztelo.TuzjelzoKeresAndKuld(ID: Integer);
Var TuzjelzoMut : PTuzjelzoElem;
Begin
  If (TuzjelzoLista <> Nil) And TuzjelzoLista.KeresID(ID,TuzjelzoMut) Then
    TuzjelzoKuld(TuzjelzoMut);
End;

Procedure TFormTesztelo.TuzjelzoKuld(Mutato: PTuzjelzoElem);
Var Szoveg : String;
    Uzenet : String;
    UzTomb : TAdatUzenetTomb;
Begin
  //ha van mit küldeni és él a kapcsolat
  If (Mutato <> Nil) And (ComPort.Connected) Then
  Begin
    //kódoljuk az üzenetet
    SetLength(UzTomb,2);
    UzTomb[0]:=Mutato.ID;
    UzTomb[1]:=BoolToInt(Mutato.Allapot);
    Uzenet:=Kodolo(UzTomb);
    //ha az eseményt ki kell írni
    If TeszteloBeallit.TuzjelzoKuld Then
    Begin
      If FormaCheckBox.Checked Then
      Begin
        If Mutato.Allapot Then
          Szoveg:='Elküldve: Tûzjelzõ(ID:'+IntToStr(Mutato.ID)+',Érték:Be)'
        Else Szoveg:='Elküldve: Tûzjelzõ(ID:'+IntToStr(Mutato.ID)+',Érték:Ki)';
      End Else Szoveg:='Elküldve: '+Uzenet
    End Else Szoveg:='';
    TextAttributes.Color:=clBlue;
    //az üzenet felfûzése az elküldendõk listájára
    UzenetLista.Felfuz(True,Uzenet,Szoveg,TextAttributes);
    SetLength(UzTomb,0);
  End;
End;

//ID alapján megkeressük a berendezést és elküldjük az adatait
Procedure TFormTesztelo.FutotestKeresAndKuld(ID: Integer);
Var FutotestMut : PVegBerendElem;
Begin
  If (VegBerendLista <> Nil) And VegBerendLista.KeresID(ID,FutotestMut) Then
    FutotestKuld(FutotestMut);
End;

Procedure TFormTesztelo.FutotestKuld(Mutato: PVegBerendElem);
Var Szoveg : String;
    Uzenet : String;
    UzTomb : TAdatUzenetTomb;
Begin
  //ha van mit küldeni és él a kapcsolat
  If (Mutato <> Nil) And (ComPort.Connected) Then
  Begin
    //kódoljuk az üzenetet
    SetLength(UzTomb,2);
    UzTomb[0]:=Mutato.ID;
    UzTomb[1]:=BoolToInt(Mutato.Allapot);
    Uzenet:=Kodolo(UzTomb);
    //ha az eseményt ki kell írni
    If TeszteloBeallit.FutotestKuld Then
    Begin
      If FormaCheckBox.Checked Then
      Begin
        If Mutato.Allapot Then
          Szoveg:='Elküldve: Fûtõtest(ID:'+IntToStr(Mutato.ID)+',Érték:Be)'
        Else Szoveg:='Elküldve: Fûtõtest(ID:'+IntToStr(Mutato.ID)+',Érték:Ki)';
      End Else Szoveg:='Elküldve: '+Uzenet
    End Else Szoveg:='';
    TextAttributes.Color:=clBlue;
    //az üzenet felfûzése az elküldendõk listájára
    UzenetLista.Felfuz(False,Uzenet,Szoveg,TextAttributes);
    SetLength(UzTomb,0);
  End;
End;

//ID alapján megkeressük a berendezést és elküldjük az adatait
Procedure TFormTesztelo.EgyebKeresAndKuld(ID: Integer);
Var EgyebMut : PVegBerendElem;
Begin
  If (VegBerendLista <> Nil) And VegBerendLista.KeresID(ID,EgyebMut) Then
    EgyebKuld(EgyebMut);
End;

Procedure TFormTesztelo.EgyebKuld(Mutato: PVegBerendElem);
Var Szoveg : String;
    Uzenet : String;
    UzTomb : TAdatUzenetTomb;
Begin
  //ha van mit küldeni és él a kapcsolat
  If (Mutato <> Nil) And (ComPort.Connected) Then
  Begin
    //kódoljuk az üzenetet
    SetLength(UzTomb,2);
    UzTomb[0]:=Mutato.ID;
    UzTomb[1]:=BoolToInt(Mutato.Allapot);
    Uzenet:=Kodolo(UzTomb);
    //ha az eseményt ki kell írni
    If TeszteloBeallit.EgyebKuld Then
    Begin
      If FormaCheckBox.Checked Then
      Begin
        If Mutato.Allapot Then
          Szoveg:='Elküldve: Berendezés(ID:'+IntToStr(Mutato.ID)+',Érték:Be)'
        Else Szoveg:='Elküldve: Berendezés(ID:'+IntToStr(Mutato.ID)+',Érték:Ki)';
      End Else Szoveg:='Elküldve: '+Uzenet
    End Else Szoveg:='';
    TextAttributes.Color:=clBlue;
    //az üzenet felfûzése az elküldendõk listájára
    UzenetLista.Felfuz(False,Uzenet,Szoveg,TextAttributes);
    SetLength(UzTomb,0);
  End;
End;

//hõmérõk automatikus irányítása
Procedure TFormTesztelo.HomeroTimerTimer(Sender: TObject);
Var Valtozas      : Boolean;
    RegiHomeroMut : PHomeroElem;
Begin
  //ha van kapcsolat
  If ComPort.Connected Then
  Begin
    HomeroTimer.Enabled:=False;
    //ha az összes hõmérõre alkalmazni szeretnénk
    If CheckBox1.Checked Then
    Begin
      //ha vannak hõmérõk
      If (HomeroLista <> Nil) And (HomeroLista.Elso <> Nil) Then
      Begin
        //végig megyünk a hõmérõkön
        RegiHomeroMut:=Self.AktHomeroMut;
        HomeroLista.Aktualis:=HomeroLista.Elso;
        While (HomeroLista.Aktualis <> Nil) Do
        Begin
          Valtozas:=False;
          //ha a mért érték kissebb, mint a beállított érték
          If (HomeroLista.Aktualis.MertErtek < HomeroLista.Aktualis.Max) And
            (HomeroLista.Aktualis.MertErtek >= HomeroLista.Aktualis.Min) And
            (HomeroLista.Aktualis.MertErtek < HomeroLista.Aktualis.BeallErtek) Then
          Begin
            Valtozas:=True;
            //megnöveljük a mért értéket 1-el
            HomeroLista.Aktualis.MertErtek:=HomeroLista.Aktualis.MertErtek+1;
          End
          //ha a mért érték nagyobb, mint a beállított érték
          Else If (HomeroLista.Aktualis.MertErtek <= HomeroLista.Aktualis.Max) And
            (HomeroLista.Aktualis.MertErtek > HomeroLista.Aktualis.Min) And
            (HomeroLista.Aktualis.MertErtek >= HomeroLista.Aktualis.BeallErtek) Then
            Begin
              Valtozas:=True;
               //csökkentjük a mért értéket 1-el
              HomeroLista.Aktualis.MertErtek:=HomeroLista.Aktualis.MertErtek-1;
            End;
          //ha volt változás, akkor elküldjük az új értéket
          If Valtozas Then
          Begin
            HomeroKuld(HomeroLista.Aktualis);
            //ha az adott hõmérõt nézzük, akkor frissítünk
            If (RegiHomeroMut = HomeroLista.Aktualis) Then HomeroFrissit(RegiHomeroMut);
          End;
          HomeroLista.Aktualis:=HomeroLista.Aktualis.Kovetkezo;
        End;
        Self.AktHomeroMut:=RegiHomeroMut;
      End;
    End
    //ha csak az adott hõmérõre alkalmazzuk
    Else Begin
      Valtozas:=False;
      //ha a mért érték kissebb, mint a beállított érték
      If (AktHomeroMut.MertErtek < AktHomeroMut.Max) And
         (AktHomeroMut.MertErtek >= AktHomeroMut.Min) And
         (AktHomeroMut.MertErtek < AktHomeroMut.BeallErtek) Then
      Begin
        Valtozas:=True;
        //megnöveljük a mért értéket 1-el
        AktHomeroMut.MertErtek:=AktHomeroMut.MertErtek+1;
      End
      //ha a mért érték nagyobb, mint a beállított érték
      Else If (AktHomeroMut.MertErtek <= AktHomeroMut.Max) And
              (AktHomeroMut.MertErtek > AktHomeroMut.Min) And
              (AktHomeroMut.MertErtek >= AktHomeroMut.BeallErtek) Then
        Begin
          Valtozas:=True;
          //csökkentjük a mért értéket 1-el
          AktHomeroMut.MertErtek:=AktHomeroMut.MertErtek-1;
        End;
      //ha volt változás, akkor elküldjük az új értéket
      If Valtozas Then
      Begin
        HomeroKeresAndKuld(AktHomeroMut.ID);
        //frissítjük az adott hõmérõt
        HomeroFrissit(AktHomeroMut);
      End;
    End;
    HomeroTimer.Enabled:=True;
  End;
End;

//az automata kapcsoló kikapcsolása
Procedure TFormTesztelo.AutomataKapcsoloOff(Sender: TObject);
Begin
  HomeroKuldBtn.Enabled:=True;
  HomeroBar.Enabled:=True;
  HomeroTimer.Enabled:=False;
End;

//az automata kapcsoló bekapcsolása
Procedure TFormTesztelo.AutomataKapcsoloOn(Sender: TObject);
Begin
  HomeroKuldBtn.Enabled:=False;
  HomeroBar.Enabled:=False;
  HomeroTimer.Enabled:=True;
End;

//elküldjük az adott hõmérõ adatait
Procedure TFormTesztelo.HomeroKuldBtnClick(Sender: TObject);
Var ID : Integer;
Begin
  //megkeressük az azonosítóját
  ID:=BerendezesLista.KeresNev(HomeroListBox.Items[HomeroListBox.ItemIndex]);
  //elküldjük az adatokat
  HomeroKeresAndKuld(ID);
End;

//növeljük az idõváltozás mértékét
Procedure TFormTesztelo.SpinButton1UpClick(Sender: TObject);
Var Ido : Integer;
Begin
  Ido:=StrToInt(Panel6.Caption);
  //ha másodpercben mérünk
  If MsBtn.Checked Then
  Begin
    If (Ido < 59) Then
    Begin
      Inc(Ido);
      Panel6.Caption:=IntToStr(Ido);
      //a timer beállítása
      HomeroTimer.Interval:=Ido*1000;
    End;
  End
  //ha percben mérünk
  Else Begin
    If (Ido < 15) Then
    Begin
      Inc(Ido);
      Panel6.Caption:=IntToStr(Ido);
      //a timer beállítása
      HomeroTimer.Interval:=Ido*60000;
    End;
  End;
End;

//csökkentjük az idõváltozás mértékét
Procedure TFormTesztelo.SpinButton1DownClick(Sender: TObject);
Var Ido : Integer;
Begin
  Ido:=StrToInt(Panel6.Caption);
  //ha másodpercben mérünk
  If MsBtn.Checked Then
  Begin
    If (Ido > 1) Then
    Begin
      Dec(Ido);
      Panel6.Caption:=IntToStr(Ido);
      //a timer beállítása
      HomeroTimer.Interval:=Ido*1000;
    End;
  End
  //ha percben mérünk
  Else Begin
    If (Ido > 1) Then
    Begin
      Dec(Ido);
      Panel6.Caption:=IntToStr(Ido);
      //a timer beállítása
      HomeroTimer.Interval:=Ido*60000;
    End;
  End;
End;

//percben mérjük a változásokat
Procedure TFormTesztelo.PercBtnClick(Sender: TObject);
Var Ido : Integer;
Begin
  Ido:=StrToInt(Panel6.Caption);
  If (Ido > 15) Then Panel6.Caption:='1';
End;

//naplózás hõmérõ esemény vételekor
Procedure TFormTesztelo.HomeroVetelCheckBoxClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;
  TeszteloBeallit.HomeroVetel:=HomeroVetelCheckBox.Checked;
End;

//naplózás hõmérõ esemény küldésekor
Procedure TFormTesztelo.HomeroKuldCheckBoxClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;
  TeszteloBeallit.HomeroKuld:=HomeroKuldCheckBox.Checked;
End;

//naplózás riasztó esemény vételekor
Procedure TFormTesztelo.RiasztoVetelCheckBoxClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;
  TeszteloBeallit.RiasztoVetel:=RiasztoVetelCheckBox.Checked;
End;

//naplózás riasztó esemény küldésekor
Procedure TFormTesztelo.RiasztoKuldCheckBoxClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;
  TeszteloBeallit.RiasztoKuld:=RiasztoKuldCheckBox.Checked;
End;

//naplózás tûzjelzõ esemény vételekor
Procedure TFormTesztelo.TuzjelzoVetelCheckBoxClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;
  TeszteloBeallit.TuzjelzoVetel:=TuzjelzoVetelCheckBox.Checked;
End;

//naplózás tûzjelzõ esemény küldésekor
Procedure TFormTesztelo.TuzjelzoKuldCheckBoxClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;
  TeszteloBeallit.TuzjelzoKuld:=TuzjelzoKuldCheckBox.Checked;
End;

//naplózás fûtõtest esemény vételekor
Procedure TFormTesztelo.FutotestVetelCheckBoxClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;
  TeszteloBeallit.FutotestVetel:=FutotestVetelCheckBox.Checked;
End;

//naplózás fûtõtest esemény küldésekor
Procedure TFormTesztelo.FutotestKuldCheckBoxClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;
  TeszteloBeallit.FutotestKuld:=FutotestKuldCheckBox.Checked;
End;

//naplózás egyéb esemény vételekor
Procedure TFormTesztelo.EgyebVetelCheckBoxClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;
  TeszteloBeallit.EgyebVetel:=EgyebVetelCheckBox.Checked;
End;

//naplózás egyéb esemény küldésekor
Procedure TFormTesztelo.EgyebKuldCheckBoxClick(Sender: TObject);
Begin
  MentesBtn.Enabled:=True;
  TeszteloBeallit.EgyebKuld:=EgyebKuldCheckBox.Checked;
End;

//aktiváljuk az adott riasztó kapcsolóját
Procedure TFormTesztelo.RiasztoKapcsoloClick(Sender: TObject);
Var ID         : Integer;
    RiasztoMut : PRiasztoElem;
Begin
  //lekérdezzük az azonosítót
  ID:=BerendezesLista.KeresNev(RiasztoListBox.Items[RiasztoListBox.ItemIndex]);
  //megkeressük az azonosító alapján
  If (RiasztoLista <> Nil) And RiasztoLista.KeresID(ID,RiasztoMut) Then
  Begin
    //ha a kapcsoló be van kapcsolva
    If RiasztoKapcsolo.StateOn Then
    Begin
      RiasztoMut.Allapot:=True;
      RiasztoAllapotPanel.Caption:='Riasztás';
    End
    //ha a kapcsoló ki van kapcsolva
    Else Begin
      RiasztoMut.Allapot:=False;
      RiasztoAllapotPanel.Caption:='Normál';
    End;
    //elküldjük az adatokat
    RiasztoKuld(RiasztoMut);
    //frissítjük a képernyõt
    BerendGridFrissit;
  End;
End;

//aktiváljuk az adott tûzjelzõ kapcsolóját
Procedure TFormTesztelo.TuzjelzoKapcsoloClick(Sender: TObject);
Var ID          : Integer;
    TuzjelzoMut : PTuzjelzoElem;
Begin
  //lekérdezzük az azonosítót
  ID:=BerendezesLista.KeresNev(TuzjelzoListBox.Items[TuzjelzoListBox.ItemIndex]);
  //megkeressük az azonosító alapján
  If (TuzjelzoLista <> Nil) And TuzjelzoLista.KeresID(ID,TuzjelzoMut) Then
  Begin
    //ha a kapcsoló be van kapcsolva
    If TuzjelzoKapcsolo.StateOn Then
    Begin
      TuzjelzoMut.Allapot:=True;
      TuzjelzoAllapotPanel.Caption:='Tûzjelzés';
    End
    //ha a kapcsoló ki van kapcsolva
    Else Begin
      TuzjelzoMut.Allapot:=False;
      TuzjelzoAllapotPanel.Caption:='Normál';
    End;
    //elküldjük az adatokat
    TuzjelzoKuld(TuzjelzoMut);
    //frissítjük a képernyõt
    BerendGridFrissit;
  End;
End;

//aktiváljuk az adott fûtõtest kapcsolóját
Procedure TFormTesztelo.FutotestKapcsoloClick(Sender: TObject);
Var ID          : Integer;
    FutotestMut : PVegBerendElem;
Begin
  //lekérdezzük az azonosítót
  ID:=BerendezesLista.KeresNev(FutotestListBox.Items[FutotestListBox.ItemIndex]);
  //megkeressük az azonosító alapján
  If (VegBerendLista <> Nil) And VegBerendLista.KeresID(ID,FutotestMut) Then
  Begin
    //ha a kapcsoló be van kapcsolva
    If FutotestKapcsolo.StateOn Then
    Begin
      FutotestMut.Allapot:=True;
      FutotestAllapotPanel.Caption:='Bekapcsolva';
    End
    //ha a kapcsoló ki van kapcsolva
    Else Begin
      FutotestMut.Allapot:=False;
      FutotestAllapotPanel.Caption:='Kikapcsolva';
    End;
    //elküldjük az adatokat
    FutotestKuld(FutotestMut);
    //frissítjük a képernyõt
    BerendGridFrissit;
  End;
End;

//aktiváljuk az adott egyéb berendezés kapcsolóját
Procedure TFormTesztelo.EgyebKapcsoloClick(Sender: TObject);
Var ID       : Integer;
    EgyebMut : PVegBerendElem;
Begin
  //lekérdezzük az azonosítót
  ID:=BerendezesLista.KeresNev(EgyebListBox.Items[EgyebListBox.ItemIndex]);
  //megkeressük az azonosító alapján
  If (VegBerendLista <> Nil) And VegBerendLista.KeresID(ID,EgyebMut) Then
  Begin
    //ha a kapcsoló be van kapcsolva
    If EgyebKapcsolo.StateOn Then
    Begin
      EgyebMut.Allapot:=True;
      EgyebAllapotPanel.Caption:='Bekapcsolva';
    End
    //ha a kapcsoló ki van kapcsolva
    Else Begin
      EgyebMut.Allapot:=False;
      EgyebAllapotPanel.Caption:='Kikapcsolva';
    End;
    //elküldjük az adatokat
    EgyebKuld(EgyebMut);
    //frissítjük a képernyõt
    BerendGridFrissit;
  End;
End;

//kilépés idõzítõje
Procedure TFormTesztelo.KilepesTimerTimer(Sender: TObject);
Begin
  KilepesTimer.Enabled:=False;
  Close;
End;

//kapcsolat bontásának idõzítõje
Procedure TFormTesztelo.KapcsolatTimerTimer(Sender: TObject);
Begin
  KapcsolatTimer.Enabled:=False;
  If ComPort.Connected Then ComPort.Close;
End;

//épület bezázása
Procedure TFormTesztelo.CloseBtnClick(Sender: TObject);
Var Bezar : Boolean;
Begin
  Bezar:=True;
  //ha van kapcsolat és be is zárjuk
  If ComPort.Connected Then
    If (Application.MessageBox('A kommunikációs port nyitva van!'+#13+
      'Kapcsolat bezárása?','Kapcsolat bezárása',mb_YesNo) = idYes) Then
    Begin
      KuldThread.Kuldhet:=False;
      KuldThread.Terminate;
      PortAllapot.Szabad:=False;
      ComPort.ClearBuffer(True,True);
      KapcsolatTimer.Enabled:=True;
    End
    Else Bezar:=False;
  //listák bezárása
  If Bezar Then
  Begin
    ListakBezarasa;
    //a listboxok tartalmának törlése
    HomeroListBox.Items.Clear;
    RiasztoListBox.Items.Clear;
    TuzjelzoListBox.Items.Clear;
    FutotestListBox.Items.Clear;
    EgyebListBox.Items.Clear;
    //a BerendGrid frissítése
    BerendGridFeltolt;
    OpenBtn.Enabled:=True;
    CloseBtn.Enabled:=False;
    FormTesztelo.Caption:='Tesztelõ';
  End;
End;

//billentyû lenyomásának kiértékelése
Procedure TFormTesztelo.FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
  If (Key = VK_F4) And (Shift = [ssAlt]) Then Key:=0;
  If (Key = VK_F1) Then
  Begin
    HelpOpen;
    Key:=0;
  End;
End;

//belépés a RichEdit1-be
Procedure TFormTesztelo.RichEdit1Enter(Sender: TObject);
Begin
  //fókusz továbbadása
  SendMessage(Handle,WM_NEXTDLGCTL,0,0);
End;

End.
