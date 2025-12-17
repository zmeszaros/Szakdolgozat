Unit TervezoUnit;

Interface

Uses        
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, ToolWin, Menus, ImgList, StdCtrls, Buttons, Spin, Math,
  FileCtrl, Db, DBTables, UtilUnit, KeretUnit, KijelolNegyzetUnit,
  TavolsagUnit, KijelolLancUnit, PontLancUnit, FileTablaUnit, FormFestoUnit,
  ObjektumUnit, ObjNevFormUnit, ObjektumokDlgUnit, BerendezesekLancUnit,
  UjBerendezesUnit, EpuletLancUnit, ZoomUnit, RajzolasUnit, PenUnit,
  ObjListaUnit, MonitorUnit, MegnyitasUnit, MeretFormUnit, AboutUnit, UjUnit,
  AjtoUnit, ForgatUnit, BeallitUnit, BerendDlgUnit, UjEpEgysegDlgUnit;

Type
  //a kijelölõ keret méretei
  TAranyok = Record
    KeretHosszX : Integer;   //keret szélessége
    KeretHosszY : Integer;   //keret magassága
    AranyX      : Extended;  //az eredeti- és az új méret aránya (szélesség)
    AranyY      : Extended;  //az eredeti- és az új méret aránya (magasság)
  End;

  //rajzolással kapcsolatos eszközök adatai
  TVezerloAllapot = Class(TPersistent)
  Private
    DT         : TDrawingTool;  //rajzolási mûvelet típusa
    SzinIndex  : Integer;
    VonalIndex : Integer;
    PenTipus   : TPenStyle;
    PenMeret   : Integer;
    Vonalzo    : Boolean;
    Kurzor     : TCursor;
  Public
    Procedure BeAllit(Const Szin,Vonal,Pen: Integer; Const PenTip: TPenStyle;
      Const D: TDrawingTool; Const Kurz: TCursor; Const Vonalz,Ertek: Boolean);
    Procedure VisszaAllit(Const Ertek: Boolean);
    Constructor Create(Const Szin,Vonal,Pen: Integer; Const PenTip: TPenStyle;
      Const D: TDrawingTool; Const RegiVonalzo: Boolean;
      Const RegiKurzor: TCursor);
  End;

  {**************************************************************************}

  TFormTervezo = Class(TForm)
    MainMenu1             : TMainMenu;
    MenuFile              : TMenuItem;
    MenuUjEpulet          : TMenuItem;
    MenuUjEpuletEgyseg    : TMenuItem;
    MenuUj                : TMenuItem;
    SubMenuUjEpulet       : TMenuItem;
    SubMenuUjEpuletEgyseg : TMenuItem;
    MenuKilepes           : TMenuItem;
    Megnyitas             : TMenuItem;
    Mentes                : TMenuItem;
    MentesMaskent         : TMenuItem;
    Berendezesek          : TMenuItem;
    Monitor               : TMenuItem;
    Objektumok            : TMenuItem;
    BezarMenu             : TMenuItem;
    N1                    : TMenuItem;
    Beallitasok           : TMenuItem;
    Sugo                  : TMenuItem;
    N2                    : TMenuItem;
    Nevjegy               : TMenuItem;
    About1                : TMenuItem;
    PopupMenuUjEpulet     : TPopupMenu;
    StatusBar1            : TStatusBar;
    ToolBar1              : TToolBar;
    BtnKilepes            : TToolButton;
    ToolButton9           : TToolButton;
    MegnyitasButton       : TToolButton;
    MentesButton          : TToolButton;
    ToolButton1           : TToolButton;
    ToolButton8           : TToolButton;
    ToolButton12          : TToolButton;
    ScrollBox1            : TScrollBox;
    Panel1                : TPanel;
    Image1                : TImage;
    ImageList1            : TImageList;
    Label1                : TLabel;
    Bevel2                : TBevel;
    Bevel3                : TBevel;
    PenMeretAllit         : TSpinEdit;
    SaveTervrajz          : TSaveDialog;
    ComboBox1             : TComboBox;
    ComboBox2             : TComboBox;
    ComboBox3             : TComboBox;
    ZoomText              : TStaticText;
    EpuletTable           : TTable;
    ObjektumTable         : TTable;
    BerendezesTable       : TTable;
    TabSheet1             : TTabSheet;
    TabSheet2             : TTabSheet;
    TabSheet3             : TTabSheet;
    EpuletDataSource      : TDataSource;
    ObjektumDataSource    : TDataSource;
    BerendezesDataSource  : TDataSource;
    PageControl1          : TPageControl;
    FrissitButton         : TSpeedButton;
    ZoomOutButton         : TSpeedButton;
    ZoomInButton          : TSpeedButton;
    NyilButton            : TSpeedButton;
    KijelolButton         : TSpeedButton;
    PoligonButton         : TSpeedButton;
    VonalButton           : TSpeedButton;
    NegyzetButton         : TSpeedButton;
    KorButton             : TSpeedButton;
    AjtoButton            : TSpeedButton;
    AblakButton           : TSpeedButton;
    MozgatasButton        : TSpeedButton;
    TorlesButton          : TSpeedButton;
    ForgatasButton        : TSpeedButton;
    MeretezesButton       : TSpeedButton;
    ObjButton             : TSpeedButton;
    ObjListBtn            : TSpeedButton;
    ObjNyilBtn            : TSpeedButton;
    HomeroBtn             : TSpeedButton;
    RiasztoBtn            : TSpeedButton;
    TuzjelzoBtn           : TSpeedButton;
    FutotestBtn           : TSpeedButton;
    EgyebBtn              : TSpeedButton;
    ListaBtn              : TSpeedButton;
    Procedure MenuKilepesClick(Sender: TObject);
    Procedure FormActivate(Sender: TObject);
    Procedure MenuUjEpuletClick(Sender: TObject);
    Procedure MenuUjEpuletEgysegClick(Sender: TObject);
    Procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    Procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    Procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    Procedure VonalButtonClick(Sender: TObject);
    Procedure NegyzetButtonClick(Sender: TObject);
    Procedure NyilButtonClick(Sender: TObject);
    Procedure KorButtonClick(Sender: TObject);
    Procedure PenMeretAllitChange(Sender: TObject);
    Procedure ComboBox1Change(Sender: TObject);
    Procedure KijelolButtonClick(Sender: TObject);
    Procedure FrissitButtonClick(Sender: TObject);
    Procedure AjtoButtonClick(Sender: TObject);
    Procedure AblakButtonClick(Sender: TObject);
    Procedure TorlesButtonClick(Sender: TObject);
    Procedure MozgatasButtonClick(Sender: TObject);
    Procedure ForgatasButtonClick(Sender: TObject);
    Procedure MeretezesButtonClick(Sender: TObject);
    Procedure MentesButtonClick(Sender: TObject);
    Procedure BeallitasokClick(Sender: TObject);
    Procedure MegnyitasClick(Sender: TObject);
    Procedure MegnyitasButtonClick(Sender: TObject);
    Procedure MentesClick(Sender: TObject);
    Procedure MentesMaskentClick(Sender: TObject);
    Procedure PoligonButtonClick(Sender: TObject);
    Procedure ComboBox2DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    Procedure ComboBox2Change(Sender: TObject);
    Procedure ComboBox3DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    Procedure ComboBox3Change(Sender: TObject);
    Procedure SubMenuUjEpuletClick(Sender: TObject);
    Procedure SubMenuUjEpuletEgysegClick(Sender: TObject);
    Procedure NevjegyClick(Sender: TObject);
    Procedure SugoClick(Sender: TObject);
    Procedure ZoomInButtonClick(Sender: TObject);
    Procedure ZoomOutButtonClick(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure FormCanResize(Sender: TObject; Var NewWidth,
      NewHeight: Integer; Var Resize: Boolean);
    Procedure ObjButtonClick(Sender: TObject);
    Procedure ObjListBtnClick(Sender: TObject);
    Procedure PageControl1Change(Sender: TObject);
    Procedure HomeroBtnClick(Sender: TObject);
    Procedure RiasztoBtnClick(Sender: TObject);
    Procedure TuzjelzoBtnClick(Sender: TObject);
    Procedure FutotestBtnClick(Sender: TObject);
    Procedure EgyebBtnClick(Sender: TObject);
    Procedure PageControl1Changing(Sender: TObject; Var AllowChange: Boolean);
    Procedure FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure ListaBtnClick(Sender: TObject);
    Procedure BerendezesekClick(Sender: TObject);
    Procedure MonitorClick(Sender: TObject);
    Procedure ObjektumokClick(Sender: TObject);
    Procedure BezarMenuClick(Sender: TObject);
  Private
    Keret           : TKeret;
    Aranyok         : TAranyok;         //keret adatai és a arányai
    KoordTav        : TTavolsag;        //két pont közötti távolság
    EgerPos         : TEgerPos;         //egér koordinátái
    VonalzoPos      : TEgerPos;         //vonalzó koordinátái
    RegiPenStyle    : TRegiPenStyle;    //a pen adatainak tárolása
    KijelolNegyzet  : TKijelolNegyzet;  //kijelölõ négyzet
    AblakMeret      : Integer;          //ablak mélysége
    AlaprajzMeret   : Integer;          //alaprajz mérete
    EgysegMeret     : Extended;         //egy pixel hány mm
    EredEgysMeret   : Integer;          //egy pixel hány mm
    BitmapMeret     : Integer;          //rajzasztal mérete
    Param           : Boolean;          //indítási paraméter
    Inditas         : Boolean;          //program inditasa
    Drawing         : Boolean;          //rajzolunk?
    Meretezes       : Boolean;          //méretezünk?
    VanObjektum     : Boolean;
    VonalzoRajzol   : Boolean;          //vonalzó rajzolása?
    VanVonalzo      : Boolean;          //látszik a vonalzó?
    KellVonalzo     : Boolean;          //kell-e vonalzó?
    VanKeret        : Boolean;          //van kijelölõ keretünk?
    EgerDown        : Boolean;          //az egérgomb lenyomva?
    RegiEgerKurzor  : TCursor;          //egér mozgását követi
    EgysegNev       : String;           //aktuális épületegység neve
    EpuletNev       : String;           //épület neve
    EpuletPath      : String;           //épület elérési útja
    Origin, MovePt  : TPoint;           //kezdeti és az elmozdulás koord.
    RegiMouseMove   : TPoint;
    ImageMeret      : TRect;            //image mérete
    ScrollBoxMeret  : TRect;            //scrollbox mérete
    PontLista       : TPontLista;       //koord-kat tartalmazó lánc
    EpuletLista     : TEpuletLista;     //az épület szerkezetét tartalmazó lánc
    Objektum        : TObjektum;        //egy objektum adatai
    ObjektumLista   : TObjektumLista;   //objektumok lánca
    BerendezesLista : TBerendezesLista; //berendezések lánca
    KijelolLista    : TKijelolLista;    //kijelölt rajzelemek lánca
    VezerloAllapot  : TVezerloAllapot;
    PointArray      : Array[1..4] Of TPoint;
    Function EpuletLancBetoltes : Boolean;
    Function AjtoKeszit(Var AjtoK1,AjtoK2: TPoint) : Boolean;
    Function AblakKeszit(Const Kezdo,Vegzo: TPoint; Var K1,K2,K3,K4: TPoint) : Boolean;
    Function KijelolKeres(BF,JA: TPoint) : Boolean;
    Function AlakzatLancbolKifuz(Const Mutato: Pointer) : Boolean;
    Function AlakzatKeresMutato(Const Mutato: Pointer; Var Elozo: PAlakzatElem) : Boolean;
    Function UjEpuletLetrehoz : Boolean;
    Procedure LancokUrit;
    Procedure Mentesek;
    Procedure Letrehoz(K1,K2,K3,K4: TPoint);
    Procedure KeretUjraSzamolo;
    Procedure RajzolasiModValtas;
    Procedure SetAlapPenBeallit;
    Procedure AlakzatGombok(Const Ertek: Boolean);
    Procedure AlakzatModositoGombok(Const E1,E2,E3,E4: Boolean);
    Procedure KezdLathatoAllit(Const Ertek: Boolean);
    Procedure MeretezNegyzetVizsg(Const Pont: TPoint);
    Procedure MeretezNegyzetKapcs(Const Szin: TColor; Const PenMod: TPenMode);
    Procedure RajzasztalLetrehoz(Const Meret: Integer);
    Procedure KijelolLancVissza;
    Procedure KijelolLancMegszuntet;
    Procedure KijelolLancMozgat;
    Procedure KijelolLancMeretez;
    Procedure KijelolLancForgat(Const Irany,Szog,Sarok: Integer);
    Procedure KijelolLancAtRajzol(Const Szin: TColor);
    Procedure DrawLineCursors (Const X,Y:  INTEGER);
    Procedure CursorDrawingAreaBeallit;
    Procedure CursorDrawingAreaEltavolit;
    Procedure MyIdleHandler(Sender: TObject; Var Done: Boolean);
    Procedure ObjektumKeszit(Const Pont: TPoint);
    Procedure PageControlVizsgal;
    Procedure PageControlGombValt(Ertek1,Ertek2,Ertek3: Boolean);
    Procedure UjBerendFormNyitas(BerendTip: TBerendezesTip);
  Public
    Function ShowModal(Const Parameter: Boolean) : Integer; Reintroduce; Overload;
    Procedure Set_AblakMeret(Const AM: Integer);
    Procedure AsztalUjraRajzol; Overload;
    Procedure AsztalUjraRajzol(Szin: TColor); Overload;
  End;

Var FormTervezo: TFormTervezo;

Implementation

{$R *.DFM}

//a típus létrehozása a kapott paraméterekkel
Constructor TVezerloAllapot.Create(Const Szin,Vonal,Pen: Integer;
  Const PenTip: TPenStyle; Const D: TDrawingTool;
  Const RegiVonalzo: Boolean; Const RegiKurzor: TCursor);
Begin
  Inherited Create;
  Self.DT:=D;
  Self.SzinIndex:=Szin;
  Self.VonalIndex:=Vonal;
  Self.PenTipus:=PenTip;
  Self.PenMeret:=Pen;
  Self.Vonalzo:=RegiVonalzo;
  Self.Kurzor:=RegiKurzor;
End;

//beállítjuk a formot a kapott paraméterek alapján
Procedure TVezerloAllapot.BeAllit(Const Szin,Vonal,Pen: Integer;
  Const PenTip: TPenStyle; Const D: TDrawingTool;
  Const Kurz: TCursor; Const Vonalz,Ertek: Boolean);
Begin
  With FormTervezo Do
  Begin
    ComboBox2.ItemIndex:=Szin;     //a színválasztó ComboBox beáll.
    ComboBox3.ItemIndex:=Vonal;    //a vonaltípus ComboBox beáll.
    PenMeretAllit.Value:=Pen;      //a pen vastagsága
    ComboBox2.Enabled:=Ertek;
    ComboBox3.Enabled:=Ertek;
    PenMeretAllit.Enabled:=Ertek;
    KellVonalzo:=Vonalz;           //kell vonalzó?
    Image1.Cursor:=Kurz;           //kurzor beáll.
  End;
  //a pen beállítása
  SetPenStyle(FormTervezo,FormTervezo.Image1,PenTipus,
    FormTervezo.ComboBox2.Canvas.Brush.Color,Pen);
  //mûvelet beállítása
  EpuletTul.DT:=D;
End;

//a régi beállítások visszatöltése
Procedure TVezerloAllapot.VisszaAllit(Const Ertek: Boolean);
Begin
  Self.BeAllit(SzinIndex,VonalIndex,PenMeret,PenTipus,DT,Kurzor,Vonalzo,Ertek);
End;

//a form megjelenítése
Function TFormTervezo.ShowModal(Const Parameter: Boolean) : Integer;
Begin
  //indítási paraméter beáll.
  Param:=Parameter;
  Result:=Inherited ShowModal;
End;

//ablakméret beállítása
Procedure TFormTervezo.Set_AblakMeret(Const AM: Integer);
Begin
  Self.AblakMeret:=AM;
End;

//az egér mozgási területének beállítása
Procedure TFormTervezo.CursorDrawingAreaBeallit;
Var CursorClipArea : TRect;
Begin
  With CursorClipArea Do
  Begin
    TopLeft.X:=Image1.ClientOrigin.X;
    TopLeft.Y:=Image1.ClientOrigin.Y;
    BottomRight.X:=TopLeft.X+Image1.ClientWidth;
    BottomRight.Y:=TopLeft.Y+Image1.ClientHeight;
  End;
  Windows.ClipCursor(@CursorClipArea)
End;

//az egér mozgási terület beállításának törlése
Procedure TFormTervezo.CursorDrawingAreaEltavolit;
Begin
  Windows.ClipCursor(Nil)
End;

//eseménykezelõ
Procedure TFormTervezo.MyIdleHandler(Sender: TObject; Var Done: Boolean);
Var P               : TPoint;  //egér pozíciója
    ComboBoxDropped : Boolean; //van-e lenyitott ComboBox
Begin
  //egér pozíció lekérdezése
  Windows.GetCursorPos(P);
  ComboBoxDropped:=False;
  //van-e lenyitott ComboBox
  If (ComboBox1.DroppedDown Or ComboBox2.DroppedDown Or ComboBox3.DroppedDown)
    Then ComboBoxDropped:=True;
  //ha az egér a rajzasztal felett van
  If BenneVan(ScrollBoxMeret.TopLeft,ScrollBoxMeret.BottomRight,P) And
     BenneVan(ImageMeret.TopLeft,ImageMeret.BottomRight,P) Then
  Begin
    //ha nincs vonalzó, de kell
    If (Not VanVonalzo) And KellVonalzo And (Not ComboBoxDropped) Then
    Begin
      VonalzoRajzol:=True;
      VanVonalzo:=True;
      //vonalzó rajzolása
      DrawLineCursors(VonalzoPos.X,VonalzoPos.Y);
    End;
  End
  //ha az egér nem a rajzasztal felett van
  Else Begin
    //ha van rajzolva vonalzó, akkor eltüntetjük
    If VonalzoRajzol Then
    Begin
      VanVonalzo:=False;
      //vonalzó rajzolása
      DrawLineCursors(VonalzoPos.X,VonalzoPos.Y);
      VonalzoRajzol:=False;
    End;
  End;
End;

//vonalzó rajzolása
Procedure TFormTervezo.DrawLineCursors(Const X,Y: Integer);
Var RegiPenStyle : TRegiPenStyle; //pen adatok
    RegiPenMode  : TPenMode;      //pen rajzolási módja
Begin
  //elmentjük a pen adatait
  RegiPenStyle.Ment(Self,Image1);
  //horizontális és vertikális vonalzó rajzolása
  With Image1.Canvas Do
  Begin
    RegiPenMode:=Pen.Mode;
    Pen.Mode:=pmNotXor;
    Pen.Color:=clFuchsia;
    Pen.Style:=psSolid;
    Pen.Width:=1;
    MoveTo(X,0);
    LineTo(X,Y-10);
    MoveTo(X,Y+10);
    LineTo(X,Image1.ClientWidth);
    MoveTo(0,Y);
    LineTo(X-10,Y);
    MoveTo(X+10,Y);
    LineTo(Image1.ClientHeight,Y);
    Pen.Mode:=RegiPenMode;
    MoveTo(X,Y);
  End;
  //visszaállítjuk az eredeti pen adatait
  RegiPenStyle.Vissza(Self,Image1);
End;

//keresünk alakzatot a kijelölt területen
Function TFormTervezo.KijelolKeres(BF,JA: TPoint) : Boolean;
Var RegiAlakAkt   : PAlakzatElem;
    AlakzatMutato : Pointer;
    Talalat       : Boolean;
    MinX,MaxX     : Integer;
    MinY,MaxY     : Integer;
    RPS           : TRegiPenStyle;
    RPM           : TPenMode;
    Szorzo        : Extended;      //rajzolási arány

  //benne van-e a keretben
  Procedure KoordVizsgal(Pont: TPoint);
  Begin
    If Not((Pont.X >= BF.X) And (Pont.X <= JA.X)) Then Talalat:=False;
    If Not((Pont.Y >= BF.Y) And (Pont.Y <= JA.Y)) Then Talalat:=False;
  End;

  //egy pont vizsgálata
  Procedure MinMax(Pont: TPoint);
  Begin
    MinX:=Min(MinX,Pont.X);
    MinY:=Min(MinY,Pont.Y);
    MaxX:=Max(MaxX,Pont.X);
    MaxY:=Max(MaxY,Pont.Y);
  End;

  //az alakzat koord-inak a vizsgálata
  Procedure MinMaxKeres;
  Begin
    Case AlakzatLanc.Aktualis.Tipus Of
      dtVonal     : Begin
                      MinMax(PVonalAlakzat(AlakzatMutato)^.Koord[1]);
                      MinMax(PVonalAlakzat(AlakzatMutato)^.Koord[2]);
                    End;
      dtNegyzet   : Begin
                      MinMax(PNegyzetAlakzat(AlakzatMutato)^.Koord[1]);
                      MinMax(PNegyzetAlakzat(AlakzatMutato)^.Koord[2]);
                      MinMax(PNegyzetAlakzat(AlakzatMutato)^.Koord[3]);
                      MinMax(PNegyzetAlakzat(AlakzatMutato)^.Koord[4]);
                    End;
      dtEllipszis : Begin
                      MinMax(PEllipszisAlakzat(AlakzatMutato)^.Koord[1]);
                      MinMax(PEllipszisAlakzat(AlakzatMutato)^.Koord[2]);
                    End;
      dtAjto      : Begin
                      MinMax(PAjtoAlakzat(AlakzatMutato)^.Koord[1]);
                      MinMax(PAjtoAlakzat(AlakzatMutato)^.Koord[2]);
                      MinMax(PAjtoAlakzat(AlakzatMutato)^.Koord[3]);
                      If (PAjtoAlakzat(AlakzatMutato)^.Koord[4].X > 0) And
                         (PAjtoAlakzat(AlakzatMutato)^.Koord[4].Y > 0) Then
                         MinMax(PAjtoAlakzat(AlakzatMutato)^.Koord[4]);
                    End;
      dtAblak     : Begin
                      MinMax(PAblakAlakzat(AlakzatMutato)^.Koord[1]);
                      MinMax(PAblakAlakzat(AlakzatMutato)^.Koord[2]);
                      MinMax(PAblakAlakzat(AlakzatMutato)^.Koord[3]);
                      MinMax(PAblakAlakzat(AlakzatMutato)^.Koord[4]);
                    End;
    End;
  End;

Begin
  //a keresési feltételek beállítása
  MinX:=BitmapMeret;
  MinY:=BitmapMeret;
  MaxX:=0;
  MaxY:=0;
  //méretarányhoz igazízás
  Szorzo:=1/Zoom.Szorzo;
  BF:=KoordZoom(BF,Szorzo);  //keret bal-felsõ sarka
  JA:=KoordZoom(JA,Szorzo);  //keret jobb-alsó sarka
  RPS.Ment(Self,Image1);
  RPM:=Image1.Canvas.Pen.Mode;
  Result:=False;
  RegiAlakAkt:=AlakzatLanc.Aktualis;
  //sorra vesszük az alakzatokat
  AlakzatLanc.Aktualis:=AlakzatLanc.Elso;
  While (AlakzatLanc.Aktualis <> Nil) Do
  Begin
    Talalat:=True;
    AlakzatMutato:=AlakzatLanc.Aktualis.AlakMut;
    //megvizsgáljuk a koordinátáit, hogy benne van-e a keretben
    Case AlakzatLanc.Aktualis.Tipus Of
      dtVonal     : Begin
                      KoordVizsgal(PVonalAlakzat(AlakzatMutato)^.Koord[1]);
                      KoordVizsgal(PVonalAlakzat(AlakzatMutato)^.Koord[2]);
                    End;
      dtNegyzet   : Begin
                      KoordVizsgal(PNegyzetAlakzat(AlakzatMutato)^.Koord[1]);
                      KoordVizsgal(PNegyzetAlakzat(AlakzatMutato)^.Koord[2]);
                      KoordVizsgal(PNegyzetAlakzat(AlakzatMutato)^.Koord[3]);
                      KoordVizsgal(PNegyzetAlakzat(AlakzatMutato)^.Koord[4]);
                    End;
      dtEllipszis : Begin
                      KoordVizsgal(PEllipszisAlakzat(AlakzatMutato)^.Koord[1]);
                      KoordVizsgal(PEllipszisAlakzat(AlakzatMutato)^.Koord[2]);
                    End;
      dtAjto      : Begin
                      KoordVizsgal(PAjtoAlakzat(AlakzatMutato)^.Koord[1]);
                      KoordVizsgal(PAjtoAlakzat(AlakzatMutato)^.Koord[2]);
                      KoordVizsgal(PAjtoAlakzat(AlakzatMutato)^.Koord[3]);
                      If (PAjtoAlakzat(AlakzatMutato)^.Koord[4].X > 0) And
                         (PAjtoAlakzat(AlakzatMutato)^.Koord[4].Y > 0) Then
                         KoordVizsgal(PAjtoAlakzat(AlakzatMutato)^.Koord[4]);
                    End;
      dtAblak     : Begin
                      KoordVizsgal(PAblakAlakzat(AlakzatMutato)^.Koord[1]);
                      KoordVizsgal(PAblakAlakzat(AlakzatMutato)^.Koord[2]);
                      KoordVizsgal(PAblakAlakzat(AlakzatMutato)^.Koord[3]);
                      KoordVizsgal(PAblakAlakzat(AlakzatMutato)^.Koord[4]);
                    End;
    End;
    //ha az alakzat benne van
    If Talalat Then
    Begin
      Result:=True;
      //felfûzzük a láncra
      KijelolLista.Felfuz(AlakzatLanc.Aktualis);
      //átfestjük az alakzatot
      AlakzatLancAtRajzol(Self,Image1,clFuchsia,AlakzatLanc.Aktualis,Zoom.Szorzo);
      //újraszámoljuk a keret sarkait
      MinMaxKeres;
    End;
    AlakzatLanc.Aktualis:=AlakzatLanc.Aktualis.Kovetkezo;
  End;
  AlakzatLanc.Aktualis:=RegiAlakAkt;
  //a kijelölt alakzat(ok) köré keretet rajzolunk
  If (KijelolLista.Elso <> Nil) Then
  Begin
    If (Zoom.Szorzo <> 1) Then
    Begin
      MinX:=Round(MinX*Zoom.Szorzo);
      MinY:=Round(MinY*Zoom.Szorzo);
      MaxX:=Round(MaxX*Zoom.Szorzo);
      MaxY:=Round(MaxY*Zoom.Szorzo);
    End;
    Keret:=TKeret.Init(Self,Image1,MinX,MinY,MaxX,MaxY);
    Keret.PenStyleMent(RPS,RPM);
    Keret.KeretKapcs(clFuchsia,BE);
    Keret.KeretMent;
  End;
End;

//a kijelölt láncot megszüntetjük
Procedure TFormTervezo.KijelolLancMegszuntet;
Begin
  //ha nem üres
  If (KijelolLista <> Nil) And (Not KijelolLista.Ures) Then
  Begin
    AlakzatLancAtRajzol(Self,Image1,Zoom.Szorzo);
    VanKeret:=False;
    Keret.KeretRajzoloKikapcs;
    //ha van a láncból másolat
    If KijelolLista.Masolat Then
    Begin
      KijelolLista.MasolatMegszuntet;
    End;
    FreeAndNil(KijelolLista);
    //üres lánc létrehozása
    KijelolLista:=TKijelolLista.Create;
    //gombok frissítése
    AlakzatModositoGombok(False,False,False,False);
  End;
End;

//a kijelölt-lánc átfestése a kapott színre
Procedure TFormTervezo.KijelolLancAtRajzol(Const Szin: TColor);
Var Mutato  : Pointer;
    RegiPen : TRegiPenStyle;
    RegiDT  : TDrawingTool;
Begin
  RegiDT:=EpuletTul.DT;
  RegiPen.Ment(Self,Image1);
  KijelolLista.Aktualis:=KijelolLista.Elso;
  While (KijelolLista.Aktualis <> Nil) Do
  Begin
    Mutato:=PAlakzatLanc(KijelolLista.Aktualis.AlakzatElemMut);
    AlakzatLancAtRajzol(Self,Image1,Szin,Mutato,Zoom.Szorzo);
    KijelolLista.Aktualis:=KijelolLista.Aktualis.Kovetkezo;
  End;
  RegiPen.Vissza(Self,Image1);
  EpuletTul.DT:=RegiDT;
End;

//kijelölt alakzatok mozgatása
Procedure TFormTervezo.KijelolLancMozgat;
Var Mutato    : Pointer;
    AlakTipus : TDrawingTool;
Begin
  //végigmegyünk a kijelölt alakzatokon
  KijelolLista.Aktualis:=KijelolLista.Elso;
  While (KijelolLista.Aktualis <> Nil) Do
  Begin
    Mutato:=PAlakzatElem(KijelolLista.Aktualis.AlakzatElemMut)^.AlakMut;
    AlakTipus:=PAlakzatElem(KijelolLista.Aktualis.AlakzatElemMut)^.Tipus;
    //növeljük (csökkentjük) az alakzatok koord-áit az elmozdulás mértékével
    Case AlakTipus Of
      dtVonal     : Begin
                      Inc(PVonalAlakzat(Mutato)^.Koord[1].X,Keret.GetKeret_MVekt_X);
                      Inc(PVonalAlakzat(Mutato)^.Koord[1].Y,Keret.GetKeret_MVekt_Y);
                      Inc(PVonalAlakzat(Mutato)^.Koord[2].X,Keret.GetKeret_MVekt_X);
                      Inc(PVonalAlakzat(Mutato)^.Koord[2].Y,Keret.GetKeret_MVekt_Y);
                    End;
      dtNegyzet   : Begin
                      Inc(PNegyzetAlakzat(Mutato)^.Koord[1].X,Keret.GetKeret_MVekt_X);
                      Inc(PNegyzetAlakzat(Mutato)^.Koord[1].Y,Keret.GetKeret_MVekt_Y);
                      Inc(PNegyzetAlakzat(Mutato)^.Koord[2].X,Keret.GetKeret_MVekt_X);
                      Inc(PNegyzetAlakzat(Mutato)^.Koord[2].Y,Keret.GetKeret_MVekt_Y);
                      Inc(PNegyzetAlakzat(Mutato)^.Koord[3].X,Keret.GetKeret_MVekt_X);
                      Inc(PNegyzetAlakzat(Mutato)^.Koord[3].Y,Keret.GetKeret_MVekt_Y);
                      Inc(PNegyzetAlakzat(Mutato)^.Koord[4].X,Keret.GetKeret_MVekt_X);
                      Inc(PNegyzetAlakzat(Mutato)^.Koord[4].Y,Keret.GetKeret_MVekt_Y);
                    End;
      dtEllipszis : Begin
                      PEllipszisAlakzat(Mutato)^.Kozep.X:=
                        PEllipszisAlakzat(Mutato)^.Kozep.X+Keret.GetKeret_MVekt_X;
                      PEllipszisAlakzat(Mutato)^.Kozep.Y:=
                        PEllipszisAlakzat(Mutato)^.Kozep.Y+Keret.GetKeret_MVekt_Y;
                    End;
      dtAjto      : Begin
                      Inc(PAjtoAlakzat(Mutato)^.Koord[1].X,Keret.GetKeret_MVekt_X);
                      Inc(PAjtoAlakzat(Mutato)^.Koord[1].Y,Keret.GetKeret_MVekt_Y);
                      Inc(PAjtoAlakzat(Mutato)^.Koord[2].X,Keret.GetKeret_MVekt_X);
                      Inc(PAjtoAlakzat(Mutato)^.Koord[2].Y,Keret.GetKeret_MVekt_Y);
                      Inc(PAjtoAlakzat(Mutato)^.Koord[3].X,Keret.GetKeret_MVekt_X);
                      Inc(PAjtoAlakzat(Mutato)^.Koord[3].Y,Keret.GetKeret_MVekt_Y);
                      If (PAjtoAlakzat(Mutato)^.Koord[4].X > 0) And
                         (PAjtoAlakzat(Mutato)^.Koord[4].Y > 0) Then
                      Begin
                        Inc(PAjtoAlakzat(Mutato)^.Koord[4].X,Keret.GetKeret_MVekt_X);
                        Inc(PAjtoAlakzat(Mutato)^.Koord[4].Y,Keret.GetKeret_MVekt_Y);
                      End;
                    End;
      dtAblak     : Begin
                      Inc(PAblakAlakzat(Mutato)^.Koord[1].X,Keret.GetKeret_MVekt_X);
                      Inc(PAblakAlakzat(Mutato)^.Koord[1].Y,Keret.GetKeret_MVekt_Y);
                      Inc(PAblakAlakzat(Mutato)^.Koord[2].X,Keret.GetKeret_MVekt_X);
                      Inc(PAblakAlakzat(Mutato)^.Koord[2].Y,Keret.GetKeret_MVekt_Y);
                      Inc(PAblakAlakzat(Mutato)^.Koord[3].X,Keret.GetKeret_MVekt_X);
                      Inc(PAblakAlakzat(Mutato)^.Koord[3].Y,Keret.GetKeret_MVekt_Y);
                      Inc(PAblakAlakzat(Mutato)^.Koord[4].X,Keret.GetKeret_MVekt_X);
                      Inc(PAblakAlakzat(Mutato)^.Koord[4].Y,Keret.GetKeret_MVekt_Y);
                    End;
    End;
    KijelolLista.Aktualis:=KijelolLista.Aktualis.Kovetkezo;
  End;
End;

//kijelölt alakzatok forgatása
Procedure TFormTervezo.KijelolLancForgat(Const Irany,Szog,Sarok: Integer);
Var Mutato    : Pointer;
    AlakTipus : TDrawingTool;
    SarokXY   : TSarokKoord;
Begin
  //a sarok koordinátái, amelyik körül forgatunk
  SarokXY:=Keret.UjSarok(Sarok);
  //végigmegyünk a kijelölt alakzatokon
  KijelolLista.Aktualis:=KijelolLista.Elso;
  While (KijelolLista.Aktualis <> Nil) Do
  Begin
    Mutato:=PAlakzatElem(KijelolLista.Aktualis.AlakzatElemMut)^.AlakMut;
    AlakTipus:=PAlakzatElem(KijelolLista.Aktualis.AlakzatElemMut)^.Tipus;
    //elforgatjuk az alakzatot a kijelölt sarok körül
    Case AlakTipus Of
      dtVonal     : Begin
                      PVonalAlakzat(Mutato)^.Koord[1]:=
                        UjKoord(SarokXY,Irany,Szog,RelHely(PVonalAlakzat(Mutato)^.Koord[1].X,SarokXY.Koord1),
                                RelHely(PVonalAlakzat(Mutato)^.Koord[1].Y,SarokXY.Koord2));
                      PVonalAlakzat(Mutato)^.Koord[2]:=
                        UjKoord(SarokXY,Irany,Szog,RelHely(PVonalAlakzat(Mutato)^.Koord[2].X,SarokXY.Koord1),
                                RelHely(PVonalAlakzat(Mutato)^.Koord[2].Y,SarokXY.Koord2));
                    End;
      dtNegyzet   : Begin
                      PNegyzetAlakzat(Mutato)^.Koord[1]:=
                        UjKoord(SarokXY,Irany,Szog,RelHely(PNegyzetAlakzat(Mutato)^.Koord[1].X,SarokXY.Koord1),
                                RelHely(PNegyzetAlakzat(Mutato)^.Koord[1].Y,SarokXY.Koord2));
                      PNegyzetAlakzat(Mutato)^.Koord[2]:=
                        UjKoord(SarokXY,Irany,Szog,RelHely(PNegyzetAlakzat(Mutato)^.Koord[2].X,SarokXY.Koord1),
                                RelHely(PNegyzetAlakzat(Mutato)^.Koord[2].Y,SarokXY.Koord2));
                      PNegyzetAlakzat(Mutato)^.Koord[3]:=
                        UjKoord(SarokXY,Irany,Szog,RelHely(PNegyzetAlakzat(Mutato)^.Koord[3].X,SarokXY.Koord1),
                                RelHely(PNegyzetAlakzat(Mutato)^.Koord[3].Y,SarokXY.Koord2));
                      PNegyzetAlakzat(Mutato)^.Koord[4]:=
                        UjKoord(SarokXY,Irany,Szog,RelHely(PNegyzetAlakzat(Mutato)^.Koord[4].X,SarokXY.Koord1),
                                RelHely(PNegyzetAlakzat(Mutato)^.Koord[4].Y,SarokXY.Koord2));
                      Inc(PNegyzetAlakzat(Mutato)^.Szog,((-1)*Irany*Szog) Mod 360);
                    End;
      dtEllipszis : Begin
                      PEllipszisAlakzat(Mutato)^.Kozep:=
                        UjKoord(SarokXY,Irany,Szog,RelHely(PEllipszisAlakzat(Mutato)^.Kozep.X,SarokXY.Koord1),
                                RelHely(PEllipszisAlakzat(Mutato)^.Kozep.Y,SarokXY.Koord2));
                      Inc(PEllipszisAlakzat(Mutato)^.Szog,((-1)*Irany*Szog) Mod 360);
                    End;
      dtAjto      : Begin
                      PAjtoAlakzat(Mutato)^.Koord[1]:=
                        UjKoord(SarokXY,Irany,Szog,RelHely(PAjtoAlakzat(Mutato)^.Koord[1].X,SarokXY.Koord1),
                                RelHely(PAjtoAlakzat(Mutato)^.Koord[1].Y,SarokXY.Koord2));
                      PAjtoAlakzat(Mutato)^.Koord[2]:=
                        UjKoord(SarokXY,Irany,Szog,RelHely(PAjtoAlakzat(Mutato)^.Koord[2].X,SarokXY.Koord1),
                                RelHely(PAjtoAlakzat(Mutato)^.Koord[2].Y,SarokXY.Koord2));
                      PAjtoAlakzat(Mutato)^.Koord[3]:=
                        UjKoord(SarokXY,Irany,Szog,RelHely(PAjtoAlakzat(Mutato)^.Koord[3].X,SarokXY.Koord1),
                                RelHely(PAjtoAlakzat(Mutato)^.Koord[3].Y,SarokXY.Koord2));
                      If (PAjtoAlakzat(Mutato)^.Koord[4].X > 0) And
                         (PAjtoAlakzat(Mutato)^.Koord[4].Y > 0) Then
                        PAjtoAlakzat(Mutato)^.Koord[4]:=
                        UjKoord(SarokXY,Irany,Szog,RelHely(PAjtoAlakzat(Mutato)^.Koord[4].X,SarokXY.Koord1),
                                RelHely(PAjtoAlakzat(Mutato)^.Koord[4].Y,SarokXY.Koord2));
                      Inc(PAjtoAlakzat(Mutato)^.Szog,((-1)*Irany*Szog) Mod 360);
                    End;
      dtAblak   : Begin
                      PAblakAlakzat(Mutato)^.Koord[1]:=
                        UjKoord(SarokXY,Irany,Szog,RelHely(PAblakAlakzat(Mutato)^.Koord[1].X,SarokXY.Koord1),
                                RelHely(PAblakAlakzat(Mutato)^.Koord[1].Y,SarokXY.Koord2));
                      PAblakAlakzat(Mutato)^.Koord[2]:=
                        UjKoord(SarokXY,Irany,Szog,RelHely(PAblakAlakzat(Mutato)^.Koord[2].X,SarokXY.Koord1),
                                RelHely(PAblakAlakzat(Mutato)^.Koord[2].Y,SarokXY.Koord2));
                      PAblakAlakzat(Mutato)^.Koord[3]:=
                        UjKoord(SarokXY,Irany,Szog,RelHely(PAblakAlakzat(Mutato)^.Koord[3].X,SarokXY.Koord1),
                                RelHely(PAblakAlakzat(Mutato)^.Koord[3].Y,SarokXY.Koord2));
                      PAblakAlakzat(Mutato)^.Koord[4]:=
                        UjKoord(SarokXY,Irany,Szog,RelHely(PAblakAlakzat(Mutato)^.Koord[4].X,SarokXY.Koord1),
                                RelHely(PAblakAlakzat(Mutato)^.Koord[4].Y,SarokXY.Koord2));
                      Inc(PAblakAlakzat(Mutato)^.Szog,((-1)*Irany*Szog) Mod 360);
                    End;
    End;
    KijelolLista.Aktualis:=KijelolLista.Aktualis.Kovetkezo;
  End;
End;

//kijelölt alakzatok méretezése
Procedure TFormTervezo.KijelolLancMeretez;
Var Mutato        : Pointer;
    MasolatMutato : Pointer;
    AlakTipus     : TDrawingTool;
    Kezdo,Vegzo   : TPoint;
    Azon          : Integer;

  //méretezés a pont X koord-jára
  Function UjKoord_X(PontX: Integer) : Integer;
  Begin
    Result:=Round((Aranyok.AranyX*(PontX-Keret.GetKeret_BF_X))+Keret.GetKeret_BF_X);
  End;

  //méretezés a pont Y koord-jára
  Function UjKoord_Y(PontY: Integer) : Integer;
  Begin
    Result:=Round((Aranyok.AranyY*(PontY-Keret.GetKeret_BF_Y))+Keret.GetKeret_BF_Y);
  End;

  //méretezés a pont X,Y koord-jára
  Function UjKoord(Pont: TPoint) : TPoint;
  Begin
    Result:=Point(UjKoord_X(Pont.X),UjKoord_Y(Pont.Y));
  End;

Begin
  //végigmegyünk a kijelölt alakzatokon
  KijelolLista.Aktualis:=KijelolLista.Elso;
  While (KijelolLista.Aktualis <> Nil) Do
  Begin
    Mutato:=PAlakzatElem(KijelolLista.Aktualis.AlakzatElemMut)^.AlakMut;
    //meghatározzuk az alakzat típusát
    AlakTipus:=PAlakzatElem(KijelolLista.Aktualis.AlakzatElemMut)^.Tipus;
    //meghatározzuk az alakzat azonosítóját
    Azon:=KijelolLista.Aktualis.Azon;
    //megkeressük a lánc másolatában
    MasolatMutato:=KijelolLista.AzonKeres(Azon);
    //ha megvan
    If (MasolatMutato <> Nil) Then
      //meghatározzuk az alakzat új koordinátáit
      Case AlakTipus Of
        dtVonal     : Begin
                        PVonalAlakzat(Mutato)^.Koord[1]:=UjKoord(PVonalAlakzat(MasolatMutato)^.Koord[1]);
                        PVonalAlakzat(Mutato)^.Koord[2]:=UjKoord(PVonalAlakzat(MasolatMutato)^.Koord[2]);
                      End;
        dtNegyzet   : Begin
                        PNegyzetAlakzat(Mutato)^.Koord[1]:=UjKoord(PNegyzetAlakzat(MasolatMutato)^.Koord[1]);
                        PNegyzetAlakzat(Mutato)^.Koord[2]:=UjKoord(PNegyzetAlakzat(MasolatMutato)^.Koord[2]);
                        PNegyzetAlakzat(Mutato)^.Koord[3]:=UjKoord(PNegyzetAlakzat(MasolatMutato)^.Koord[3]);
                        PNegyzetAlakzat(Mutato)^.Koord[4]:=UjKoord(PNegyzetAlakzat(MasolatMutato)^.Koord[4]);
                      End;
        dtEllipszis : Begin
                        PEllipszisAlakzat(Mutato)^.A:=Aranyok.AranyX*PEllipszisAlakzat(MasolatMutato)^.A;
                        PEllipszisAlakzat(Mutato)^.B:=Aranyok.AranyY*PEllipszisAlakzat(MasolatMutato)^.B;
                        PEllipszisAlakzat(Mutato)^.Kozep:=UjKoord(PEllipszisAlakzat(MasolatMutato)^.Kozep);
                      End;
        dtAjto      : Begin
                        PAjtoAlakzat(Mutato)^.Koord[1]:=UjKoord(PAjtoAlakzat(MasolatMutato)^.Koord[1]);
                        PAjtoAlakzat(Mutato)^.Koord[2]:=UjKoord(PAjtoAlakzat(MasolatMutato)^.Koord[2]);
                        PAjtoAlakzat(Mutato)^.Koord[3]:=UjKoord(PAjtoAlakzat(MasolatMutato)^.Koord[3]);
                        If (PAjtoAlakzat(MasolatMutato)^.Koord[4].X > 0) And
                           (PAjtoAlakzat(MasolatMutato)^.Koord[4].Y > 0) Then
                          PAjtoAlakzat(Mutato)^.Koord[4]:=UjKoord(PAjtoAlakzat(MasolatMutato)^.Koord[4]);
                      End;
        dtAblak    :  Begin
                        Kezdo:=Point(Round((PAblakAlakzat(MasolatMutato)^.Koord[1].X+
                                            PAblakAlakzat(MasolatMutato)^.Koord[4].X)/2),
                                     Round((PAblakAlakzat(MasolatMutato)^.Koord[1].Y+
                                            PAblakAlakzat(MasolatMutato)^.Koord[4].Y)/2));
                         Vegzo:=Point(Round((PAblakAlakzat(MasolatMutato)^.Koord[2].X+
                                            PAblakAlakzat(MasolatMutato)^.Koord[3].X)/2),
                                     Round((PAblakAlakzat(MasolatMutato)^.Koord[2].Y+
                                            PAblakAlakzat(MasolatMutato)^.Koord[3].Y)/2));
                        Kezdo:=UjKoord(Kezdo);
                        Vegzo:=UjKoord(Vegzo);
                        AblakKeszit(Kezdo,Vegzo,
                                    PAblakAlakzat(Mutato)^.Koord[1],
                                    PAblakAlakzat(Mutato)^.Koord[2],
                                    PAblakAlakzat(Mutato)^.Koord[3],
                                    PAblakAlakzat(Mutato)^.Koord[4]);
                      End;
      End;
      KijelolLista.Aktualis:=KijelolLista.Aktualis.Kovetkezo;
    End;
End;

//a mûvelet elõtti állapot visszaállítása
Procedure TFormTervezo.KijelolLancVissza;
Var Mutato        : Pointer;
    MasolatMutato : Pointer;
    AlakTipus     : TDrawingTool;
    Kezdo,Vegzo   : TPoint;
    Azon          : Integer;
Begin
  //végigmegyünk a kijelölt alakzatokon
  KijelolLista.Aktualis:=KijelolLista.Elso;
  While (KijelolLista.Aktualis <> Nil) Do
  Begin
    Mutato:=PAlakzatElem(KijelolLista.Aktualis.AlakzatElemMut)^.AlakMut;
    //meghatározzuk az alakzat típusát
    AlakTipus:=PAlakzatElem(KijelolLista.Aktualis.AlakzatElemMut)^.Tipus;
    //meghatározzuk az alakzat azonosítóját
    Azon:=KijelolLista.Aktualis.Azon;
    //megkeressük a lánc másolatában
    MasolatMutato:=KijelolLista.AzonKeres(Azon);
    //ha megvan
    If (MasolatMutato <> Nil) Then
      //visszaállítjuk az eredeti koordinátákat
      Case AlakTipus Of
        dtVonal     : Begin
                        PVonalAlakzat(Mutato)^.Koord[1]:=PVonalAlakzat(MasolatMutato)^.Koord[1];
                        PVonalAlakzat(Mutato)^.Koord[2]:=PVonalAlakzat(MasolatMutato)^.Koord[2];
                      End;
        dtNegyzet   : Begin
                        PNegyzetAlakzat(Mutato)^.Koord[1]:=PNegyzetAlakzat(MasolatMutato)^.Koord[1];
                        PNegyzetAlakzat(Mutato)^.Koord[2]:=PNegyzetAlakzat(MasolatMutato)^.Koord[2];
                        PNegyzetAlakzat(Mutato)^.Koord[3]:=PNegyzetAlakzat(MasolatMutato)^.Koord[3];
                        PNegyzetAlakzat(Mutato)^.Koord[4]:=PNegyzetAlakzat(MasolatMutato)^.Koord[4];
                      End;
        dtEllipszis : Begin
                        PEllipszisAlakzat(Mutato)^.A:=PEllipszisAlakzat(MasolatMutato)^.A;
                        PEllipszisAlakzat(Mutato)^.B:=PEllipszisAlakzat(MasolatMutato)^.B;
                        PEllipszisAlakzat(Mutato)^.Kozep:=PEllipszisAlakzat(MasolatMutato)^.Kozep;
                      End;
        dtAjto      : Begin
                        PAjtoAlakzat(Mutato)^.Koord[1]:=PAjtoAlakzat(MasolatMutato)^.Koord[1];
                        PAjtoAlakzat(Mutato)^.Koord[2]:=PAjtoAlakzat(MasolatMutato)^.Koord[2];
                        PAjtoAlakzat(Mutato)^.Koord[3]:=PAjtoAlakzat(MasolatMutato)^.Koord[3];
                        If (PAjtoAlakzat(MasolatMutato)^.Koord[4].X > 0) And
                           (PAjtoAlakzat(MasolatMutato)^.Koord[4].Y > 0) Then
                          PAjtoAlakzat(Mutato)^.Koord[4]:=PAjtoAlakzat(MasolatMutato)^.Koord[4];
                      End;
        dtAblak    :  Begin
                        Kezdo:=Point(Round((PAblakAlakzat(MasolatMutato)^.Koord[1].X+
                                            PAblakAlakzat(MasolatMutato)^.Koord[4].X)/2),
                                     Round((PAblakAlakzat(MasolatMutato)^.Koord[1].Y+
                                            PAblakAlakzat(MasolatMutato)^.Koord[4].Y)/2));
                        Vegzo:=Point(Round((PAblakAlakzat(MasolatMutato)^.Koord[2].X+
                                            PAblakAlakzat(MasolatMutato)^.Koord[3].X)/2),
                                     Round((PAblakAlakzat(MasolatMutato)^.Koord[2].Y+
                                            PAblakAlakzat(MasolatMutato)^.Koord[3].Y)/2));
                        AblakKeszit(Kezdo,Vegzo,
                                    PAblakAlakzat(Mutato)^.Koord[1],
                                    PAblakAlakzat(Mutato)^.Koord[2],
                                    PAblakAlakzat(Mutato)^.Koord[3],
                                    PAblakAlakzat(Mutato)^.Koord[4]);
                      End;
      End;
      KijelolLista.Aktualis:=KijelolLista.Aktualis.Kovetkezo;
    End;
End;

//keret koordinátáinak újraszámolása
Procedure TFormTervezo.KeretUjraSzamolo;
Var Mutato : Pointer;

  //minimum, maximum meghatározása egy pontban
  Procedure MinMax(Pont: TPoint);
  Begin
    If (Pont.X >= Keret.GetKeret_JA_X) Then Keret.SetKeret_JA_X(Pont.X);
    If (Pont.X <= Keret.GetKeret_BF_X) Then Keret.SetKeret_BF_X(Pont.X);
    If (Pont.Y >= Keret.GetKeret_JA_Y) Then Keret.SetKeret_JA_Y(Pont.Y);
    If (Pont.Y <= Keret.GetKeret_BF_Y) Then Keret.SetKeret_BF_Y(Pont.Y);
  End;

  //minimum, maximum meghatározása egy alakzatban
  Procedure MinMaxKeres;
  Begin
    Case PAlakzatElem(KijelolLista.Aktualis.AlakzatElemMut)^.Tipus Of
      dtVonal     : Begin
                      MinMax(PVonalAlakzat(Mutato)^.Koord[1]);
                      MinMax(PVonalAlakzat(Mutato)^.Koord[2]);
                    End;
      dtNegyzet   : Begin
                      MinMax(PNegyzetAlakzat(Mutato)^.Koord[1]);
                      MinMax(PNegyzetAlakzat(Mutato)^.Koord[2]);
                      MinMax(PNegyzetAlakzat(Mutato)^.Koord[3]);
                      MinMax(PNegyzetAlakzat(Mutato)^.Koord[4]);
                    End;
      dtEllipszis : Begin
                      MinMax(PEllipszisAlakzat(Mutato)^.Koord[1]);
                      MinMax(PEllipszisAlakzat(Mutato)^.Koord[2]);
                    End;
      dtAjto      : Begin
                      MinMax(PAjtoAlakzat(Mutato)^.Koord[1]);
                      MinMax(PAjtoAlakzat(Mutato)^.Koord[2]);
                      MinMax(PAjtoAlakzat(Mutato)^.Koord[3]);
                      If (PAjtoAlakzat(Mutato)^.Koord[4].X > 0) And
                         (PAjtoAlakzat(Mutato)^.Koord[4].Y > 0) Then
                         MinMax(PAjtoAlakzat(Mutato)^.Koord[4]);
                    End;
      dtAblak     : Begin
                      MinMax(PAblakAlakzat(Mutato)^.Koord[1]);
                      MinMax(PAblakAlakzat(Mutato)^.Koord[2]);
                      MinMax(PAblakAlakzat(Mutato)^.Koord[3]);
                      MinMax(PAblakAlakzat(Mutato)^.Koord[4]);
                    End;
    End;
  End;

Begin
  //ha van nem üres láncunk
  If (KijelolLista <> Nil) And (KijelolLista.Elso <> Nil) Then
  Begin
    //beállítjuk a keret méretét
    Keret.SetKeret_Ossz(RAJZMERET,RAJZMERET,0,0);
    //végigmegyünk a kijelölt alakzatokon és megkeressük a keret min, max-át
    KijelolLista.Aktualis:=KijelolLista.Elso;
    While (KijelolLista.Aktualis <> Nil) Do
    Begin
      Mutato:=PAlakzatElem(KijelolLista.Aktualis.AlakzatElemMut)^.AlakMut;
      MinMaxKeres;
      KijelolLista.Aktualis:=KijelolLista.Aktualis.Kovetkezo;
    End;
  End;
End;

//keresi a láncban a megadott alakzatot
//ha megvan -> visszaadja az elõtte lévõ elem mutatóját 
Function TFormTervezo.AlakzatKeresMutato(Const Mutato: Pointer;
  Var Elozo: PAlakzatElem) : Boolean;
Begin
  Result:=False;
  //ha van nem üres láncunk
  If (AlakzatLanc <> Nil) And (AlakzatLanc.Elso <> Nil) Then
  Begin
    AlakzatLanc.Aktualis:=AlakzatLanc.Elso;
    Elozo:=AlakzatLanc.Elso;
    //végigmegyünk a láncon
    While (AlakzatLanc.Aktualis <> Nil) And (Not Result) Do
    Begin
      Result:=(AlakzatLanc.Aktualis.AlakMut = Mutato);
      //ha nincs meg
      If (Not Result) Then
      Begin
        Elozo:=AlakzatLanc.Aktualis;
        AlakzatLanc.Aktualis:=AlakzatLanc.Aktualis.Kovetkezo;
      End;
    End;
  End;
End;

//alakzat kifûzése a láncból
//ha sikerült -> True, különben -> False
Function TFormTervezo.AlakzatLancbolKifuz(Const Mutato: Pointer) : Boolean;
Var Elozo : PAlakzatElem;
    Siker : Boolean;
Begin
  Siker:=False;
  //megkeressük az alakzatot
  If AlakzatKeresMutato(Mutato,Elozo) Then
  Begin
    Dispose(Mutato);
    //lánc karbantartása
    If (AlakzatLanc.Elso = AlakzatLanc.Aktualis) Then
      AlakzatLanc.Elso:=AlakzatLanc.Aktualis.Kovetkezo
    Else Elozo.Kovetkezo:=AlakzatLanc.Aktualis.Kovetkezo;
    Dispose(AlakzatLanc.Aktualis);
    AlakzatLanc.Aktualis:=AlakzatLanc.Elso;
    Siker:=True;
    EpuletLista.Valtozas:=True;
  End;
  Result:=Siker;
End;

//a toll alapbeállítása
Procedure TFormTervezo.SetAlapPenBeallit;
Begin
  AlapPenBeallit(Self,Image1);
  ComboBox2.ItemIndex:=0;
  ComboBox3.ItemIndex:=0;
End;

//a mûveletek gombok letiltása, engedélyezése
Procedure TFormTervezo.AlakzatModositoGombok(Const E1,E2,E3,E4: Boolean);
Begin
  TorlesButton.Enabled:=E1;
  MozgatasButton.Enabled:=E2;
  ForgatasButton.Enabled:=E3;
  MeretezesButton.Enabled:=E4;
End;

//az alakzatok gombok letiltása, engedélyezése
Procedure TFormTervezo.AlakzatGombok(Const Ertek: Boolean);
Begin
  NyilButton.Enabled:=Ertek;
  VonalButton.Enabled:=Ertek;
  KijelolButton.Enabled:=Ertek;
  PoligonButton.Enabled:=Ertek;
  NegyzetButton.Enabled:=Ertek;
  KorButton.Enabled:=Ertek;
  AjtoButton.Enabled:=Ertek;
  AblakButton.Enabled:=Ertek;
End;

//rajzasztal elkészítése
Procedure TFormTervezo.RajzasztalLetrehoz(Const Meret: Integer);
Begin
  Try
    //rajzasztal létrehozása
    RajzasztalKeszit(Self,Image1,Meret);
  Finally
    With ScrollBox1 Do
    Begin
      Visible:=True;
      HorzScrollBar.Visible:=True;
      VertScrollBar.Visible:=True;
      HorzScrollBar.Range:=Meret;
      VertScrollBar.Range:=Meret;
      HorzScrollBar.Position:=0;
      VertScrollBar.Position:=0;
    End;
  End;
End;

//új épület és épületegység létrehozása
//ha sikerült -> True, különben -> False
Function TFormTervezo.UjEpuletLetrehoz : Boolean;

  //új épület létrehozása
  //ha sikerült -> True, különben -> False
  Function Uj : Boolean;
  Begin
    With MeretForm Do
    Begin
      EpuletNevEdit.Text:='';
      EgysegNevEdit.Text:='';
      ActiveControl:=EpuletNevEdit;
      //dialógus ablak meghívása
      If (ShowModal(EpuletLista) <> idCancel) Then
      Begin
        Result:=True;
        EpuletTul.VE:=True;
        //alapbeállítások
        Image1.Picture.Graphic:=Nil;
        EgysegNev:=EgysegNevEdit.Text;
        AlaprajzMeret:=AlapMeret;
        EgysegMeret:=EgysMeret;
        EredEgysMeret:=EgysMeret;
        BitmapMeret:=Rajzmeret;
        //rajzasztal létrehozása
        RajzasztalLetrehoz(BitmapMeret);
        Self.ComboBox1.Items.Add(EgysegNev);
        Self.ComboBox1.ItemIndex:=Self.ComboBox1.Items.IndexOf(EgysegNev);
        //láncok létrehozása és beállítása
        AlakzatLanc.Create;
        EpuletEgyseg.Create;
        EpuletTul.VE:=True;
        EpuletNev:=EpuletNevEdit.Text;
        EpuletLista:=TEpuletLista.Create;
        EpuletLista.Nev:=EpuletNev;
        EpuletLista.EpuletMeret:=AlaprajzMeret;
        EpuletLista.EgysegMeret:=EgysegMeret;
        EpuletLista.Elso:=EpuletEgyseg;
        EpuletLista.Aktualis:=EpuletLista.Elso;
        FormTervezo.Caption:='Tervezõ - '+EpuletNev;
        PontLista:=TPontLista.Create;
        EpuletEgyseg.EgysegNev:=EgysegNev;
        EpuletEgyseg.AlakzatLancMutato:=AlakzatLanc;
        EpuletLista.Aktualis:=EpuletEgyseg;
        KoordTav.Init(Self,StatusBar1,EgysegMeret);
        KijelolLista:=TKijelolLista.Create;
        //képernyõ beállításai
        SetAlapPenBeallit;
        PageControl1.ActivePage:=TabSheet1;
        PageControl1.ActivePage.Highlighted:=True;
        AlakzatModositoGombok(False,False,False,False);
        VanVonalzo:=False;
        VanKeret:=False;
        KezdLathatoAllit(True);
        NyilButton.Down:=True;
        NyilButtonClick(Self);
        Zoom.Szorzo:=1;
        ZoomText.Caption:=FloatToStr(Zoom.Szorzo)+'x';
      End
      Else Result:=False;
    End;
  End;

Begin
  Result:=False;
  //van már épület
  If EpuletTul.VE Then
  Begin
    //KellVonalzo:=False;
    If (Application.MessageBox('Biztos, hogy új épületet kezd?','',MB_YesNo) = IDYES) Then
    Begin
      //bezárjuk az aktuális épületet
      BezarMenuClick(Self);
      //új épület létrehozása
      Result:=Uj;
    End;
  End Else Result:=Uj;
End;

//láncok megszüntetése, az adatbázisok bezárása
Procedure TFormTervezo.LancokUrit;
Begin
  If (EpuletLista <> Nil) Then FreeAndNil(EpuletLista);
  If (ObjektumLista <> Nil) Then FreeAndNil(ObjektumLista);
  If (BerendezesLista <> Nil) Then FreeAndNil(BerendezesLista);
  If (VezerloAllapot <> Nil) Then FreeAndNil(VezerloAllapot);
  If EpuletTable.Active Then EpuletTable.Close;
  If ObjektumTable.Active Then ObjektumTable.Close;
  If BerendezesTable.Active Then BerendezesTable.Close;
End;

//az épület elmentése elõtti ellenõrzések
Procedure TFormTervezo.Mentesek;
Var Mentes     : Boolean;
    TobbKerdes : Boolean;

  //kérdés a felhasználó felé
  //ha igennel válaszol -> True, különben -> False
  Function Kerdes : Boolean;
  Begin
    Result:=(Application.MessageBox('Menti a változásokat?','Mentés',MB_YesNo) = IDYES);
  End;

Begin
  Mentes:=False;
  TobbKerdes:=True;
  KellVonalzo:=False;
  //ha volt változás
  If (EpuletLista <> Nil) And EpuletLista.Valtozas Then
  Begin
    Mentes:=Kerdes;
    TobbKerdes:=False;
  End;
  //ha volt változás
  If (ObjektumLista <> Nil) And ObjektumLista.Valtozas And TobbKerdes Then
  Begin
    Mentes:=Kerdes;
    TobbKerdes:=False;
  End;
  //ha volt változás
  If (BerendezesLista <> Nil) And BerendezesLista.Valtozas And TobbKerdes
    Then Mentes:=Kerdes;
  //ha lehet menteni -> mentünk
  If Mentes Then MentesButtonClick(Self);
  //ini mentése
  TervezoIniMent(sTervezo,AblakSzin.SzinAtmenet,Self.AblakMeret);
End;

//kilépés menü eseménykezelõje
Procedure TFormTervezo.MenuKilepesClick(Sender: TObject);
Begin
  //épület mentése
  Mentesek;
  //láncok megszüntetése, az adatbázisok bezárása
  LancokUrit;
  //alkalmazás bezárása
  Close;
End;

//komponensek elérhetõségének beállítása
Procedure TFormTervezo.KezdLathatoAllit(Const Ertek: Boolean);
Begin
  Panel1.Visible:=Ertek;
  MentesButton.Enabled:=Ertek;
  Label1.Enabled:=Ertek;
  ComboBox1.Enabled:=Ertek;
  ComboBox2.Enabled:=Ertek;
  ComboBox3.Enabled:=Ertek;
  ToolButton1.Enabled:=Ertek;
  ToolButton8.Enabled:=Ertek;
  PenMeretAllit.Enabled:=Ertek;
  Mentes.Enabled:=Ertek;
  MentesMaskent.Enabled:=Ertek;
  BezarMenu.Enabled:=Ertek;
  MenuUjEpuletEgyseg.Enabled:=Ertek;
  SubMenuUjEpuletEgyseg.Enabled:=Ertek;
End;

//a form aktiválása
Procedure TFormTervezo.FormActivate(Sender: TObject);
Begin
  //ha most indul a program
  If Inditas Then
  Begin
    Inditas:=False;
    //komponensek beállítása
    KezdLathatoAllit(False);
    //ha új épületet készítünk, különben megnyitás
    If Param Then SubMenuUjEpuletClick(Sender)
      Else MegnyitasClick(Sender);
  End;
End;

//új épület készítése
Procedure TFormTervezo.SubMenuUjEpuletClick(Sender: TObject);
Var RegiKellVonalzo : Boolean;
    Siker           : Boolean;
Begin
  //vonalzó állapota
  RegiKellVonalzo:=False;
  If KellVonalzo Then
  Begin
    KellVonalzo:=False;
    RegiKellVonalzo:=True;
  End;
  //új épület készítése
  Siker:=UjEpuletLetrehoz;
  //vonalzó visszaállítása, ha kell
  If (Not Siker) And RegiKellVonalzo Then
  Begin
    KellVonalzo:=True;
    VanVonalzo:=False;
  End;
End;

//új épületegység készítése, hozzáadása
Procedure TFormTervezo.SubMenuUjEpuletEgysegClick(Sender: TObject);
Var RegiKellVonalzo : Boolean;
    Elozo           : Pointer;
Begin
  //vonalzó állapota
  RegiKellVonalzo:=False;
  If KellVonalzo Then
  Begin
    KellVonalzo:=False;
    RegiKellVonalzo:=True;
  End;
  //új épületegység készítése
  If (UjEpEgysegDlg.ShowModal(EpuletLista) <> idCancel) Then
  Begin
    Elozo:=Nil;
    EpuletLista.Aktualis:=EpuletLista.Elso;
    //elmegy a végére
    While (EpuletLista.Aktualis <> Nil) Do
    Begin
      Elozo:=EpuletLista.Aktualis;
      EpuletLista.Aktualis:=EpuletLista.Aktualis.Kovetkezo;
    End;
    //új épületegység létrehozása
    AlakzatLanc.Create;
    EpuletEgyseg.Create;
    EpuletEgyseg.EgysegNev:=UjEpEgysegDlg.EgysegNevEdit.Text;
    EpuletEgyseg.AlakzatLancMutato:=AlakzatLanc;
    EpuletLista.Aktualis:=Elozo;
    EpuletEgyseg.Elozo:=EpuletLista.Aktualis;
    EpuletEgyseg.Elozo.Kovetkezo:=EpuletEgyseg;
    //hozzáadjuk az épületegységek listájához
    With Self.ComboBox1 Do
    Begin
      Items.Add(EpuletEgyseg.EgysegNev);
      ItemIndex:=Items.IndexOf(EpuletEgyseg.EgysegNev);
    End;
    ComboBox1Change(Sender);
  End;
  //vonalzó visszaállítása, ha kell
  If RegiKellVonalzo Then
  Begin
    KellVonalzo:=True;
    VanVonalzo:=False;
  End;
End;

//új épület-menü eseménykezelõje
Procedure TFormTervezo.MenuUjEpuletClick(Sender: TObject);
Begin
  SubMenuUjEpuletClick(Sender);
End;

//új épületegység-menü eseménykezelõje
Procedure TFormTervezo.MenuUjEpuletEgysegClick(Sender: TObject);
Begin
  SubMenuUjEpuletEgysegClick(Sender);
End;

//bezier fv rajzolása
Procedure Rajzol;
Begin
  FormTervezo.Image1.Canvas.Pen.Mode:=pmNotXor;
  FormTervezo.Image1.Canvas.PolyBezier(FormTervezo.PointArray);
End;

//egéresemény (mozgás) a rajzon
Procedure TFormTervezo.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
Var DX,DY      : Integer;
    Meretezhet : Boolean;
Begin
  //ha az egér balgombja le van nyomva
  If EgerDown Then
  Begin
    //elmozdulás
    DX:=X-RegiMouseMove.X;
    DY:=Y-RegiMouseMove.Y;
    RegiMouseMove:=Point(X,Y);
    //ha az elmozdulások nagyobbak, mint kettõ
    //a rajzot elmozdítjuk
    If (DX > 2) Then
      ScrollBox1.HorzScrollBar.Position:=ScrollBox1.HorzScrollBar.Position-(Abs(DX) Div 2);
    If (DX < -2) Then
      ScrollBox1.HorzScrollBar.Position:=ScrollBox1.HorzScrollBar.Position+(Abs(DX) Div 2);
    If (DY > 2) Then
      ScrollBox1.VertScrollBar.Position:=ScrollBox1.VertScrollBar.Position-(Abs(DY) Div 2);
    If (DY < -2) Then
      ScrollBox1.VertScrollBar.Position:=ScrollBox1.VertScrollBar.Position+(Abs(DY) Div 2);
  End;
  //ha van vonalzónk
  If (VonalzoRajzol And VanVonalzo) Then
  Begin
    DrawLineCursors(VonalzoPos.X,VonalzoPos.Y);
    DrawLineCursors(X,Y);
  End;
  //egér helyzete a scrollbox szerint
  EgerPos.X:=X-ScrollBox1.HorzScrollBar.Position;
  EgerPos.Y:=Y-ScrollBox1.VertScrollBar.Position;
  StatusBar1.Panels[0].Text:=' X='+IntToStr(Round(X*EgysegMeret) Div 10)+'.'+IntToStr(Round(X*EgysegMeret) Mod 10) +' cm';
  StatusBar1.Panels[1].Text:=' Y='+IntToStr(Round(Y*EgysegMeret) Div 10)+'.'+IntToStr(Round(Y*EgysegMeret) Mod 10) +' cm';
  //ha van kijelölt alakzatunk
  If (MozgatasButton.Enabled And MozgatasButton.Down) Then
    If (Not VanKeret) Then
    Begin
      VanKeret:=True;
      Keret.KeretRajzoloBekapcs(X,Y);
    End
    Else Keret.KeretRajzoloFrissit(X,Y);
  If (EpuletTul.DT = dtMeretez) And (Not Meretezes) Then Drawing:=False;
  //ha rajzolási módban vagyunk
  If Drawing Then
  Begin
    If (Not VanKeret) And Meretezes Then
      Else DrawShape(Self,Image1,EpuletTul.DT,Origin,MovePt,pmNotXor);
    MovePt:=Point(X,Y);
    If (Not VanKeret) And Meretezes Then
      Else DrawShape(Self,Image1,EpuletTul.DT,Origin,MovePt,pmNotXor);
    KoordTav.Set_Pont2(MovePt);
    //alakzat típusa
    Case EpuletTul.DT Of
      dtAjto,
      dtAblak,
      dtVonal,
      dtPoligon : Begin
                    KoordTav.TavSzamit(dtVonal);
                    StatusBar1.Panels[2].Text:='Méret: ';
                  End;
      dtNegyzet : Begin
                    KoordTav.TavSzamit(dtNegyzet);
                    StatusBar1.Panels[2].Text:='Méret: ';
                  End;
      dtEllipszis : Begin
                    KoordTav.TavSzamit(dtEllipszis);
                    StatusBar1.Panels[2].Text:='Átmérõ: ';
                  End;
      dtMeretez : Begin
                    Meretezhet:=False;
                    Keret.SetKeret_JA(MovePt);
                    //x,y irányban is van mérete
                    If (Aranyok.KeretHosszX <> 0) And (Aranyok.KeretHosszY <> 0) Then
                    Begin
                      Meretezhet:=True;
                      Aranyok.AranyX:=(MovePt.X-Origin.X)/Aranyok.KeretHosszX;
                      Aranyok.AranyY:=(MovePt.Y-Origin.Y)/Aranyok.KeretHosszY;
                    End;
                    //csak x irányban van mérete
                    If (Aranyok.KeretHosszX <> 0) And (Aranyok.KeretHosszY = 0) Then
                    Begin
                      Meretezhet:=True;
                      Aranyok.AranyX:=(MovePt.X-Origin.X)/Aranyok.KeretHosszX;
                      Aranyok.AranyY:=1;
                    End;
                    //csak y irányban van mérete
                    If (Aranyok.KeretHosszX = 0) And (Aranyok.KeretHosszY <> 0) Then
                    Begin
                      Meretezhet:=True;
                      Aranyok.AranyX:=1;
                      Aranyok.AranyY:=(MovePt.Y-Origin.Y)/Aranyok.KeretHosszY;
                    End;
                    //ha lehet méretezni
                    If Meretezhet Then
                    Begin
                      Image1.Canvas.Pen.Mode:=pmCopy;
                      KijelolLancAtRajzol(clNone);
                      KijelolLancMeretez;
                      KijelolLancAtRajzol(clFuchsia);
                    End;
                    KoordTav.TavSzamit(dtNegyzet);
                    StatusBar1.Panels[2].Text:='Méret: ';
                    EpuletTul.DT:=dtMeretez;
                  End;
    End;
    StatusBar1.Panels[2].Text:=StatusBar1.Panels[2].Text+KoordTav.Get_STavolsag;
    //rajzasztal görgetése
    If (EgerPos.X < 10) Then
    Begin
      ScrollBox1.HorzScrollBar.Position:=ScrollBox1.HorzScrollBar.Position-
        ScrollBox1.HorzScrollBar.Increment;
    End;
    If (EgerPos.X >= ScrollBox1.ClientWidth) Then
    Begin
      ScrollBox1.HorzScrollBar.Position:=ScrollBox1.HorzScrollBar.Position+
        ScrollBox1.HorzScrollBar.Increment;
    End;
    If (EgerPos.Y < 10) Then
    Begin
      ScrollBox1.VertScrollBar.Position:=ScrollBox1.VertScrollBar.Position-
        ScrollBox1.VertScrollBar.Increment;
    End;
    If (EgerPos.Y >= ScrollBox1.ClientHeight) Then
    Begin
      ScrollBox1.VertScrollBar.Position:=ScrollBox1.VertScrollBar.Position+
        ScrollBox1.VertScrollBar.Increment;
    End;
  End
  Else Begin
    Case EpuletTul.DT Of
      dtMeretez : MeretezNegyzetVizsg(Point(X,Y));
    End;
  End;
  VonalzoPos.X:=X;
  VonalzoPos.Y:=Y;
End;

//alakzatok létrehozása a méretaránynak megfelelõen
Procedure TFormTervezo.Letrehoz(K1,K2,K3,K4: TPoint);
Var Szorzo : Extended;
Begin
  Szorzo:=(1/Zoom.Szorzo);
  Case EpuletTul.DT Of
    dtVonal     : Begin
                    New(Vonal);
                    Vonal.Szog:=0;
                    Vonal.Tipus:=EpuletTul.DT;
                    Vonal.PenMeret:=EpuletTul.PM;
                    Vonal.PenStyle:=EpuletTul.PS;
                    Vonal.PenColor:=EpuletTul.PC;
                    Vonal.Koord[1]:=KoordZoom(K1,Szorzo);
                    Vonal.Koord[2]:=KoordZoom(K2,Szorzo);
                    //felfûzés a láncra
                    AlakzatLanc.LancraFuz(EpuletLista,Vonal,EpuletTul.DT);
                  End;
    dtNegyzet   : Begin
                    New(Negyzet);
                    Negyzet.Szog:=0;
                    Negyzet.Tipus:=EpuletTul.DT;
                    Negyzet.PenMeret:=EpuletTul.PM;
                    Negyzet.PenStyle:=EpuletTul.PS;
                    Negyzet.PenColor:=EpuletTul.PC;
                    Negyzet.Koord[1]:=KoordZoom(K1,Szorzo);
                    Negyzet.Koord[2]:=KoordZoom(K2,Szorzo);
                    Negyzet.Koord[3]:=KoordZoom(K3,Szorzo);
                    Negyzet.Koord[4]:=KoordZoom(K4,Szorzo);
                    //felfûzés a láncra
                    AlakzatLanc.LancraFuz(EpuletLista,Negyzet,EpuletTul.DT);
                  End;
    dtEllipszis : Begin
                    New(Ellipszis);
                    Ellipszis.Szog:=0;
                    Ellipszis.Tipus:=EpuletTul.DT;
                    Ellipszis.PenMeret:=EpuletTul.PM;
                    Ellipszis.PenStyle:=EpuletTul.PS;
                    Ellipszis.PenColor:=EpuletTul.PC;
                    Ellipszis.A:=Szorzo*(Abs(K2.X-K1.X)/2);
                    Ellipszis.B:=Szorzo*(Abs(K2.Y-K1.Y)/2);
                    Ellipszis.Kozep.X:=Round(Szorzo*((K1.X+K2.X)/2));
                    Ellipszis.Kozep.Y:=Round(Szorzo*((K1.Y+K2.Y)/2));
                    EllipszisRajzol(Self,Image1,Ellipszis.A,Ellipszis.B,
                                    Ellipszis.Kozep,
                                    Ellipszis.Szog,False,
                                    Ellipszis.Koord[1],Ellipszis.Koord[2]);
                    //felfûzés a láncra
                    AlakzatLanc.LancraFuz(EpuletLista,Ellipszis,EpuletTul.DT);
                  End;
    dtAjto      : Begin
                    New(Ajto);
                    Ajto.Szog:=0;
                    Ajto.Tipus:=EpuletTul.DT;
                    Ajto.PenMeret:=EpuletTul.PM;
                    Ajto.PenStyle:=EpuletTul.PS;
                    Ajto.PenColor:=EpuletTul.PC;
                    Ajto.Koord[1]:=KoordZoom(K1,Szorzo);
                    Ajto.Koord[2]:=KoordZoom(K2,Szorzo);
                    Ajto.Koord[3]:=KoordZoom(K3,Szorzo);
                    //ha simpla szárnyú, különben dupla szárnyú az ajtó
                    If (K4.X = Low(Smallint)+1) Or (K4.Y = Low(Smallint)+1) Then
                      Ajto.Koord[4]:=K4
                    Else Ajto.Koord[4]:=KoordZoom(K4,Szorzo);
                    //felfûzés a láncra
                    AlakzatLanc.LancraFuz(EpuletLista,Ajto,EpuletTul.DT);
                  End;
    dtAblak     : Begin
                    New(Ablak);
                    Ablak.Szog:=0;
                    Ablak.Tipus:=EpuletTul.DT;
                    Ablak.PenMeret:=EpuletTul.PM;
                    Ablak.PenStyle:=EpuletTul.PS;
                    Ablak.PenColor:=EpuletTul.PC;
                    Ablak.Koord[1]:=KoordZoom(K1,Szorzo);
                    Ablak.Koord[2]:=KoordZoom(K2,Szorzo);
                    Ablak.Koord[3]:=KoordZoom(K3,Szorzo);
                    Ablak.Koord[4]:=KoordZoom(K4,Szorzo);
                    //felfûzés a láncra
                    AlakzatLanc.LancraFuz(EpuletLista,Ablak,EpuletTul.DT);
                    AblakRajzol(Self,Image1,PAblakalakzat(Ablak)^,clAqua,Zoom.Szorzo);
                  End;
  End;
End;

//egéresemény (gomb lenyomása) a rajzon
Procedure TFormTervezo.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
Var Done      : Boolean;
    LancZaras : Boolean;

  //poligon elmentése a láncba
  Procedure PontokLetrehoz(Tip: TDrawingTool; Zarja: Boolean);
  Var Kezdo : TPoint;
  Begin
    EpuletTul.DT:=dtVonal;
    PontLista.Aktualis:=PontLista.Elso;
    If (PontLista.Aktualis <> Nil) Then Kezdo:=PontLista.Elso.Koord;
    PontLista.Aktualis:=PontLista.Aktualis.Kovetkezo;
    //végigmegyünk a pontokon és egyenesekként mentjük el
    While (PontLista.Aktualis <> Nil) Do
    Begin
      Letrehoz(Kezdo,PontLista.Aktualis.Koord,Point(0,0),Point(0,0));
      Kezdo:=PontLista.Aktualis.Koord;
      PontLista.Aktualis:=PontLista.Aktualis.Kovetkezo;
    End;
    //ha zárni kell az alakzatot
    If (Tip = dtPoligon) And (PontLista.Db > 2) And Zarja Then
      Letrehoz(Kezdo,PontLista.Elso.Koord,Point(0,0),Point(0,0));
    EpuletTul.DT:=Tip;
  End;

Begin
  Case EpuletTul.DT Of
    dtVonal,dtNegyzet,dtEllipszis,dtMeretez,dtObjektum,
    dtKijelol,dtAjto,dtAblak,dtMozgatas,dtPoligon : Drawing:=True;
  Else Drawing:=False;
  End;
  //ha az alaprajzot akarjuk mozgatni
  If (EpuletTul.DT = dtNyil) Then
  Begin
    EgerDown:=True;
    RegiMouseMove:=Point(X,Y);
    RegiEgerKurzor:=Screen.Cursor;
    Screen.Cursor:=crHandPoint;
  End;
  //ha rajzolás következik
  If Drawing Then
  Begin
    //távolság inicializálása
    KoordTav.Init(Self,StatusBar1,EgysegMeret);
    //kezdõ, végzõ koordináták beállítása
    Origin:=Point(X,Y);
    MovePt:=Origin;
    KoordTav.Set_Pont1(Origin);
    KoordTav.Set_Pont2(MovePt);
    //mûvelet típusa
    Case EpuletTul.DT Of
      dtVonal,
      dtNegyzet,
      dtEllipszis : CursorDrawingAreaBeallit;
      dtKijelol   : Begin
                      If VanKeret Then Keret.KeretKapcs(clFuchsia,KI);
                      KijelolLancMegszuntet;
                      EpuletTul.DT:=dtKijelol;
                      KijelolNegyzet.Init(Self,Image1,Point(X,Y));
                    End;
      dtAjto,
      dtAblak     : Begin
                      CursorDrawingAreaBeallit;
                      Image1.Canvas.Pen.Width:=1;
                      Image1.Canvas.Pen.Style:=psDot;
                    End;
      dtMeretez   : Begin
                      If (Button = mbLeft) And ((Image1.Cursor = crSizeNWSE) Or (Image1.Cursor = crSizeNESW)) Then
                      Begin
                        Drawing:=True;
                        Meretezes:=True;
                        MeretezNegyzetKapcs(clFuchsia,KI);
                        Keret.KoordCsere;
                        Origin:=Keret.GetKeret_BF;
                        MovePt:=Keret.GetKeret_JA;
                        Aranyok.KeretHosszX:=(MovePt.X-Origin.X);
                        Aranyok.KeretHosszY:=(MovePt.Y-Origin.Y);
                        KoordTav.Set_Pont1_X(Keret.GetKeret_BF_X);
                        KoordTav.Set_Pont1_Y(Keret.GetKeret_BF_Y);
                        Keret.KeretKapcs(clFuchsia,KI);
                        VanKeret:=False;
                        KijelolLista.MasolatKeszit;
                      End;
                    End;
      dtPoligon   : Case Button Of
                      mbLeft  : Begin
                                  Panel1.Enabled:=False;
                                  ToolBar1.Enabled:=False;
                                  PontLista.LancraFuz(Point(X,Y));
                                End;
                      mbRight : Begin
                                  If (PontLista.Elso <> Nil) Then
                                  Begin
                                    DrawShape(Self,Image1,EpuletTul.DT,
                                      PontLista.Aktualis.Koord,Point(X,Y),KI);
                                    KellVonalzo:=False;
                                    DrawLineCursors(VonalzoPos.X,VonalzoPos.Y);
                                    If (PontLista.Db > 2) And
                                       (Application.MessageBox('Zárja az alakzatot?','',MB_YesNo) = IDYES) Then
                                    Begin
                                      DrawShape(Self,Image1,EpuletTul.DT,
                                        PontLista.Aktualis.Koord,PontLista.Elso.Koord,BE);
                                      LancZaras:=True;
                                    End
                                    Else LancZaras:=False;
                                    DrawLineCursors(VonalzoPos.X,VonalzoPos.Y);
                                    KellVonalzo:=True;
                                    PontokLetrehoz(dtPoligon,LancZaras);
                                    If (PontLista <> Nil) Then FreeAndNil(PontLista);
                                    PontLista:=TPontLista.Create;
                                  End;
                                  Drawing:=False;
                                  Panel1.Enabled:=True;
                                  ToolBar1.Enabled:=True;
                                End;
                    End;
      dtObjektum : Begin
                     If (Not VanObjektum) Then
                     Begin
                       VanObjektum:=True;
                       Objektum:=TObjektum.Create('',EpuletLista.Aktualis);
                     End;
                     Case Button Of
                       mbLeft  : Objektum.PontFelfuz(Point(X,Y));
                       mbRight : Begin
                                   VanVonalzo:=False;
                                   MyIdleHandler(Sender,Done);
                                   ObjektumKeszit(Point(X,Y));
                                 End;  
                     End;
                   End;
    End;
  End;
End;

//egéresemény (gomb felengedése) a rajzon
Procedure TFormTervezo.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X,Y: Integer);
Var BalFelso    : TPoint;  //balfelsõ koordináta
    JobbAlso    : TPoint;  //jobbalsó koordináta
    AjtoK1      : TPoint;  //ajtó koordináta
    AjtoK2      : TPoint;  //ajtó koordináta
    AblK1,AblK2 : TPoint;  //ablak sarokpontjainak koordinátái
    AblK3,AblK4 : TPoint;  //ablak sarokpontjainak koordinátái
    RegiPen     : TRegiPenStyle;

  //balfelsõ-jobbalsó koordináták meghatározása
  Procedure KoordRendezes;
  Begin
    Case EpuletTul.DT Of
      dtAjto,
      dtAblak,
      dtNegyzet,
      dtKijelol,
      dtEllipszis : Begin
                      If ((Origin.X - X) <= 0) Then BalFelso.X:=Origin.X
                        Else BalFelso.X:=X;
                      If ((Origin.Y - Y) <= 0) Then BalFelso.Y:=Origin.Y
                        Else BalFelso.Y:=Y;
                      If ((Origin.X - X) <= 0) Then JobbAlso.X:=X
                        Else JobbAlso.X:=Origin.X;
                      If ((Origin.Y - Y) <= 0) Then JobbAlso.Y:=Y
                        Else JobbAlso.Y:=Origin.Y;
                    End;
    End;
  End;

  //megnézi, hogy a két paraméter (pont), a rajzasztalon van-e
  //ha nem lóg le a rajzaztalról -> True, különben -> False
  Function RajzonVan(BF,JA : TPoint) : Boolean;
  Begin
    Result:=(BF.X >= 0) And (BF.Y >= 0) And (JA.X >= 0) And (JA.Y >= 0);
  End;

Begin
  //alaprajz mozgatásának befejezése
  If (EpuletTul.DT = dtNyil) Then
  Begin
    EgerDown:=False;
    Screen.Cursor:=RegiEgerKurzor;
  End;
  //ha rajzolási mûvelet volt
  If Drawing Then
  Begin
    KoordTav.Set_Pont2(Point(X,Y));
    //vonalzó frissítése
    If (Not VanKeret) And Meretezes Then
    Else Begin
      If KellVonalzo Then
      Begin
        VanVonalzo:=False;
        DrawLineCursors(VonalzoPos.X,VonalzoPos.Y);
      End;
      DrawShape(Self,Image1,EpuletTul.DT,Origin,Point(X,Y),BE);
    End;
    CursorDrawingAreaEltavolit;
    //pontok elmentése a láncba
    Case EpuletTul.DT Of
      dtVonal     : If (X >= 0) And (Y >= 0) Then Letrehoz(Origin,Point(X,Y),Point(0,0),Point(0,0))
                    Else Begin
                      DrawShape(Self,Image1,EpuletTul.DT,Origin,Point(X,Y),pmNotXor);
                      DrawLineCursors(VonalzoPos.X,VonalzoPos.Y);
                    End;
      dtNegyzet   : Begin
                      KoordRendezes;
                      Origin:=BalFelso;
                      If RajzonVan(BalFelso,JobbAlso) Then
                        Letrehoz(Origin,JobbAlso,Point(JobbAlso.X,Origin.Y),Point(Origin.X,JobbAlso.Y))
                      Else Begin
                        DrawShape(Self,Image1,EpuletTul.DT,BalFelso,JobbAlso,pmNotXor);
                        DrawLineCursors(VonalzoPos.X,VonalzoPos.Y);
                      End;
                    End;
      dtEllipszis : Begin
                      KoordRendezes;
                      Origin:=BalFelso;
                      If RajzonVan(BalFelso,JobbAlso) Then
                        Letrehoz(Origin,JobbAlso,Point(JobbAlso.X,Origin.Y),Point(Origin.X,JobbAlso.Y))
                      Else Begin
                        DrawShape(Self,Image1,EpuletTul.DT,BalFelso,JobbAlso,pmNotXor);
                        DrawLineCursors(VonalzoPos.X,VonalzoPos.Y);
                      End;
                    End;
      dtKijelol   : Begin
                      KijelolNegyzet.Set_JA(Point(X,Y));
                      KijelolNegyzet.Done;
                      KoordRendezes;
                      If KijelolKeres(BalFelso,JobbAlso) Then
                      Begin
                        VanKeret:=True;
                        AlakzatModositoGombok(True,True,True,True);
                      End;
                      EpuletTul.DT:=dtKijelol;
                    End;
      dtAjto      : Begin
                      If (X >= 0) And (Y >= 0) Then
                      Begin
                        MovePt:=Point(X,Y);
                        DrawLineCursors(VonalzoPos.X,VonalzoPos.Y);
                        If AjtoKeszit(AjtoK1,AjtoK2) Then Letrehoz(Origin,MovePt,AjtoK1,AjtoK2);
                      End
                      Else DrawShape(Self,Image1,EpuletTul.DT,Origin,Point(X,Y),pmNotXor);
                      RegiPenStyle.Vissza(Self,Image1);
                      DrawLineCursors(VonalzoPos.X,VonalzoPos.Y);
                    End;
      dtAblak     : Begin
                      If (X >= 0) And (Y >= 0) Then
                      Begin
                        MovePt:=Point(X,Y);
                        If AblakKeszit(Origin,MovePt,AblK1,AblK2,AblK3,AblK4) Then
                          Letrehoz(AblK1,AblK2,AblK3,AblK4)
                        Else DrawShape(Self,Image1,EpuletTul.DT,Origin,MovePt,KI);
                      End
                      Else Begin
                        DrawShape(Self,Image1,EpuletTul.DT,Origin,Point(X,Y),pmNotXor);
                        DrawLineCursors(VonalzoPos.X,VonalzoPos.Y);
                      End;
                      RegiPenStyle.Vissza(Self,Image1);
                    End;
      dtMozgatas  : Begin
                      Case Button Of
                        mbLeft  : Begin
                                    If Keret.KeretEllonoriz(Point(0,0),
                                         Point(BitmapMeret,BitmapMeret)) Then
                                    Begin
                                      Keret.KeretKapcs(clFuchsia,KI);
                                      KijelolLancAtRajzol(clNone);
                                      KijelolLancMozgat;
                                      Keret.SetKeret_RegiBF(Keret.GetKeret_BF_X,Keret.GetKeret_BF_Y);
                                      Keret.SetKeret_RegiJA(Keret.GetKeret_JA_X,Keret.GetKeret_JA_Y);
                                      KijelolLancAtRajzol(clFuchsia);
                                      Keret.KeretKapcs(clFuchsia,KI);
                                      Keret.KeretMent;
                                      EpuletLista.Valtozas:=True;
                                    End;
                                  End;
                        mbRight : Begin
                                    RegiPen.Ment(Self,Image1);
                                    AlakzatGombok(True);
                                    AlakzatModositoGombok(True,True,True,True);
                                    MozgatasButton.Down:=False;
                                    KijelolButton.Down:=True;
                                    Keret.KeretKapcs(clFuchsia,KI);
                                    KijelolLancAtRajzol(clFuchsia);
                                    Keret.RegiKeretKapcs(clFuchsia,BE);
                                    EpuletTul.DT:=dtKijelol;
                                    Keret.KeretVissza;
                                    Image1.Cursor:=crCross;
                                    RegiPen.Vissza(Self,Image1);
                                  End;
                      End;
                    End;
      dtMeretez   : Begin
                      Case Button Of
                        mbLeft  : Begin
                                    If Meretezes Then
                                    Begin
                                      VanKeret:=True;
                                      Meretezes:=False;
                                      KeretUjraSzamolo;
                                      Keret.KoordRendez(RAJZMERET);
                                      If (Not Keret.KeretEllonoriz(Point(0,0),
                                         Point(BitmapMeret,BitmapMeret))) Then
                                      Begin
                                        KijelolLancAtRajzol(clNone);
                                        KijelolLancVissza;
                                        KijelolLancAtRajzol(clFuchsia);
                                        KeretUjraSzamolo;
                                        Keret.KoordRendez(RAJZMERET);
                                      End;
                                      MeretezNegyzetKapcs(clFuchsia,BE);
                                      KijelolLista.MasolatMegszuntet;
                                    End;
                                    MeretezNegyzetVizsg(Point(X,Y));
                                    EpuletTul.DT:=dtMeretez;
                                    EpuletLista.Valtozas:=True;
                                  End;
                        mbRight : Begin
                                    Meretezes:=False;
                                    MeretezNegyzetKapcs(clFuchsia,KI);
                                    AlakzatGombok(True);
                                    AlakzatModositoGombok(True,True,True,True);
                                    MeretezesButton.Down:=False;
                                    KijelolButton.Down:=True;
                                    EpuletTul.DT:=dtKijelol;
                                    KellVonalzo:=True;
                                    Image1.Cursor:=crCross;
                                  End;
                      End;
                    End;
    End;
    If ((EpuletTul.DT = dtPoligon) Or (EpuletTul.DT = dtObjektum)) And (Drawing = True) Then Drawing:=True
      Else Drawing:=False;
  End;
End;

//ajtó elkészítése és rajzolása
//ha sikerült -> True, különben -> False
Function TFormTervezo.AjtoKeszit(Var AjtoK1,AjtoK2: TPoint) : Boolean;
Var VPont      : TPoint;
    FelezoPont : TPoint;
    RegiPen    : TRegiPenStyle;

  //az ajtószárny kiszámítása és megrajzolása
  Function Szamit(K1,K2: TPoint; JB: Byte; Var AjtoK: TPoint) : Boolean;
  Var Iv1,Iv2  : TPoint;
      PontTomb : Array[1..4] Of TPoint;
  Begin
    VPont.X:=(K1.X-K2.X);
    VPont.Y:=(K1.Y-K2.Y);
    //jobbos vagy balos az ajtó
    Case JB Of
      0 : Begin
            VPont.Y:=(-1)*VPont.Y;
            AjtoIvSzamol(K2,K1,JB,Iv1,Iv2);
          End;
      1 : Begin
            VPont.X:=(-1)*VPont.X;
            AjtoIvSzamol(K1,K2,JB,Iv1,Iv2);
          End;
    End;
    AjtoK.X:=(K2.X+VPont.Y);
    AjtoK.Y:=(K2.Y+VPont.X);
    PontTomb[1]:=K1;
    PontTomb[2]:=Point(K2.X+Iv1.X,K2.Y-Iv1.Y);
    PontTomb[3]:=Point(K2.X+Iv2.X,K2.Y-Iv2.Y);
    PontTomb[4]:=AjtoK;
    //Lelóg-e a rajzasztalról a pont
    Result:=(AjtoK.X >= 0) And (AjtoK.Y >= 0);
    If Result Then
    Begin
      //az ajtó és az ív megrajzolása
      DrawShape(FormTervezo,Image1,EpuletTul.DT,K2,AjtoK,BE);
      Image1.Canvas.PolyBezier(PontTomb);
    End;
  End;

Begin
  Result:=False;
  AjtoK1:=Point(0,0);
  AjtoK2:=Point(0,0);
  //ha van mit rajzolni
  If (KoordTav.Get_Tavolsag >= 2) Then
    With AjtoBeallDlg Do
    Begin
      Visible:=False;
      ActiveControl:=JobbosButton;
      //az ajtó-típus dialog meghívása
      If (ShowModal <> idCancel) Then
      Begin
        SetPenStyle(FormTervezo,Image1,psSolid,EpuletTul.PC,1);
        //ha jobbos az ajtó
        If JobbosButton.Checked Then
        Begin
          Result:=Szamit(Origin,MovePt,0,AjtoK1);
          AjtoK2.X:=Low(Smallint)+1;
        End;
        //ha balos az ajtó
        If BalosButton.Checked Then
        Begin
          Result:=Szamit(MovePt,Origin,1,AjtoK1);
          AjtoK2.Y:=Low(Smallint)+1;
        End;
        //ha kétszárnyú az ajtó
        If KetszarnyuButton.Checked Then
        Begin
          FelezoPont.X:=Round((Origin.X+MovePt.X)/2);
          FelezoPont.Y:=Round((Origin.Y+MovePt.Y)/2);
          Result:=Szamit(FelezoPont,MovePt,0,AjtoK1);
          If Result Then Result:=Szamit(FelezoPont,Origin,1,AjtoK2);
        End;
        EpuletTul.DT:=dtVonal;
      End;
    End;
  RegiPen.Ment(Self,Image1);
  SetPenStyle(Self,Image1,psSolid,clNone,1);
  DrawShape(Self,Image1,EpuletTul.DT,Origin,MovePt,BE);
  RegiPen.Vissza(Self,Image1);
  EpuletTul.DT:=dtAjto;
End;

//ablak elkészítése és rajzolása
//ha sikerült -> True, különben -> False
Function TFormTervezo.AblakKeszit(Const Kezdo,Vegzo: TPoint; Var K1,K2,K3,K4: TPoint) : Boolean;
Var AranySzam : Extended;
    Vektor    : TPoint;
Begin
  Result:=True;
  If (KoordTav.Get_Tavolsag <> 0) Then
  Begin
    //az ablak szélességének meghatározása
    AranySzam:=((AblakMeret/EgysegMeret)/KoordTav.Get_Tavolsag)/2;
    Vektor:=Point(Round(AranySzam*(-1)*(Kezdo.Y-Vegzo.Y)),
                  Round(AranySzam*(Kezdo.X-Vegzo.X)));
    K1:=Point(Kezdo.X+Vektor.X,Kezdo.Y+Vektor.Y);
    K2:=Point(Vegzo.X+Vektor.X,Vegzo.Y+Vektor.Y);
    K3:=Point(Vegzo.X+((-1)*Vektor.X),Vegzo.Y+((-1)*Vektor.Y));
    K4:=Point(Kezdo.X+((-1)*Vektor.X),Kezdo.Y+((-1)*Vektor.Y));
  End
  Else Result:=False;
End;

//rajzasztal újra rajzolása az eredeti színekkel
Procedure TFormTervezo.AsztalUjraRajzol;
Var RegiDrawingTool : TDrawingTool;
    RegiPenStyle    : TRegiPenStyle;
Begin
  RegiDrawingTool:=EpuletTul.DT;
  RegiPenStyle.Ment(Self,Image1);
  //rajz törlése és egy üres létrehozása
  Image1.Picture.Graphic:=Nil;
  RajzasztalLetrehoz(BitmapMeret);
  //az alaprajz kirajzolása
  If (AlakzatLanc <> Nil) Then AlakzatLancAtRajzol(Self,Image1,Zoom.Szorzo);
  EpuletTul.DT:=RegiDrawingTool;
  RegiPenStyle.Vissza(Self,Image1);
End;

//rajzasztal újra rajzolása a megadott színnel
Procedure TFormTervezo.AsztalUjraRajzol(Szin: TColor);
Var RegiDrawingTool : TDrawingTool;
    RegiPenStyle    : TRegiPenStyle;
Begin
  RegiDrawingTool:=EpuletTul.DT;
  RegiPenStyle.Ment(Self,Image1);
  //rajz törlése és egy üres létrehozása
  Image1.Picture.Graphic:=Nil;
  RajzasztalLetrehoz(BitmapMeret);
  //az alaprajz kirajzolása
  If (AlakzatLanc <> Nil) Then AlakzatLancAtRajzol(Self,Image1,Szin,Zoom.Szorzo);
  EpuletTul.DT:=RegiDrawingTool;
  RegiPenStyle.Vissza(Self,Image1);
End;

//rajzolási mód váltása
Procedure TFormTervezo.RajzolasiModValtas;
Begin
  If VanKeret Then Keret.KeretKapcs(clFuchsia,KI);
  If (EpuletTul.DT = dtKijelol) Then RegiPenStyle.Vissza(Self,Image1);
  If (EpuletTul.DT = dtPoligon) Then
  Begin
    ComboBox3.Enabled:=True;
    PenMeretAllit.Enabled:=True;
  End;
  KijelolLancMegszuntet;
End;

//a nyíl gombra klikkeltünk
Procedure TFormTervezo.NyilButtonClick(Sender: TObject);
Begin
  KellVonalzo:=False;
  RajzolasiModValtas;
  Image1.Cursor:=crDefault;
  EpuletTul.DT:=dtNyil;
  KoordTav.Init(Self,StatusBar1,EgysegMeret);
End;

//a vonal gombra klikkeltünk
Procedure TFormTervezo.VonalButtonClick(Sender: TObject);
Begin
  KellVonalzo:=True;
  RajzolasiModValtas;
  Image1.Cursor:=crCross;
  EpuletTul.DT:=dtVonal;
  KoordTav.Init(Self,StatusBar1,EgysegMeret);
End;

//a poligon gombra klikkeltünk
Procedure TFormTervezo.PoligonButtonClick(Sender: TObject);
Begin
  KellVonalzo:=True;
  RajzolasiModValtas;
  Image1.Cursor:=crCross;
  EpuletTul.DT:=dtPoligon;
  ComboBox3.Enabled:=False;
  PenMeretAllit.Enabled:=False;
  KoordTav.Init(Self,StatusBar1,EgysegMeret);
End;

//a téglalap gombra klikkeltünk
Procedure TFormTervezo.NegyzetButtonClick(Sender: TObject);
Begin
  KellVonalzo:=True;
  RajzolasiModValtas;
  Image1.Cursor:=crCross;
  EpuletTul.DT:=dtNegyzet;
  KoordTav.Init(Self,StatusBar1,EgysegMeret);
End;

//a kijelölés gombra klikkeltünk
Procedure TFormTervezo.KijelolButtonClick(Sender: TObject);
Begin
  KellVonalzo:=True;
  If (EpuletTul.DT = dtKijelol) Then RegiPenStyle.Vissza(Self,Image1);
  RegiPenStyle.Ment(Self,Image1);
  If VanKeret Then Keret.KeretKapcs(clFuchsia,KI);
  KijelolLancMegszuntet;
  If VanKeret Then
  Begin
    VanKeret:=False;
    Keret.KeretRajzoloKiKapcs;
  End;
  Image1.Cursor:=crCross;
  EpuletTul.DT:=dtKijelol;
  KoordTav.Init(Self,StatusBar1,EgysegMeret);
End;

//az ellipszis gombra klikkeltünk
Procedure TFormTervezo.KorButtonClick(Sender: TObject);
Begin
  KellVonalzo:=True;
  RajzolasiModValtas;
  Image1.Cursor:=crCross;
  EpuletTul.DT:=dtEllipszis;
  KoordTav.Init(Self,StatusBar1,EgysegMeret);
End;

//az ajtó gombra klikkeltünk
Procedure TFormTervezo.AjtoButtonClick(Sender: TObject);
Begin
  KellVonalzo:=True;
  RajzolasiModValtas;
  Image1.Cursor:=crCross;
  EpuletTul.DT:=dtAjto;
  KoordTav.Init(Self,StatusBar1,EgysegMeret);
  RegiPenStyle.Ment(Self,Image1);
End;

//az ablak gombra klikkeltünk
Procedure TFormTervezo.AblakButtonClick(Sender: TObject);
Begin
  KellVonalzo:=True;
  RajzolasiModValtas;
  Image1.Cursor:=crCross;
  EpuletTul.DT:=dtAblak;
  KoordTav.Init(Self,StatusBar1,EgysegMeret);
  RegiPenStyle.Ment(Self,Image1);
End;

//a törlés gombra klikkeltünk
Procedure TFormTervezo.TorlesButtonClick(Sender: TObject);
Var Siker   : Boolean;
    RegiPen : TRegiPenStyle;
Begin
  RegiPen.Ment(Self,Image1);
  Siker:=True;
  //keret eltüntetése
  Keret.KeretKapcs(clFuchsia,KI);
  //alakzatok eltüntetése
  KijelolLancAtRajzol(clNone);
  //a kijelölt alakzatok törlése
  KijelolLista.Aktualis:=KijelolLista.Elso;
  While (KijelolLista.Aktualis <> Nil) Do
  Begin
    If AlakzatLancbolKifuz(PAlakzatElem(KijelolLista.Aktualis.AlakzatElemMut)^.AlakMut) Then
    Begin
      KijelolLista.Elso:=KijelolLista.Aktualis.Kovetkezo;
      Dispose(KijelolLista.Aktualis);
    End
    Else Siker:=False;
    KijelolLista.Aktualis:=KijelolLista.Elso;
  End;
  AlakzatGombok(True);
  KijelolButton.Down:=True;
  FreeAndNil(KijelolLista);
  KijelolLista:=TKijelolLista.Create;
  //ha sikerült
  If Siker Then
  Begin
    VanKeret:=False;
    AlakzatModositoGombok(False,False,False,False);
  End
  Else If KijelolKeres(Keret.GetKeret_BF,Keret.GetKeret_JA) Then
    Begin
      VanKeret:=True;
      AlakzatModositoGombok(True,True,True,True);
    End;
  RegiPen.Vissza(Self,Image1);
  EpuletTul.DT:=dtKijelol;
End;

//a mozgatás gombra klikkeltünk
Procedure TFormTervezo.MozgatasButtonClick(Sender: TObject);
Begin
  Image1.Cursor:=crSizeAll;
  VanKeret:=False;
  KellVonalzo:=True;
  EpuletTul.DT:=dtMozgatas;
  AlakzatGombok(False);
  AlakzatModositoGombok(False,True,False,False);
  //keret elmentése
  Keret.KeretMent;
  Keret.KeretKapcs(clFuchsia,KI);
  KijelolLancAtRajzol(clFuchsia);
End;

//a forgatás gombra klikkeltünk
Procedure TFormTervezo.ForgatasButtonClick(Sender: TObject);
Var Irany,Fok,Sarok : Integer;
Begin
  Fok:=0;
  Irany:=0;
  KellVonalzo:=False;
  //a kijelölt alakzatokból egy másolat készítése
  KijelolLista.MasolatKeszit;
  With DlgForgatas Do
  Begin
    Sarok:=0;
    OraPlusButton.Checked:=True;
    KPButton.Checked:=True;
    ActiveControl:=FokEdit;
    //a forgatás dialogbox megjelenítése
    If (ShowModal <> idCancel) Then
    Begin
      Fok:=FokEdit.Value;
      Irany:=1;
      //melyik pont körül forgatunk
      If BFButton.Checked Then Sarok:=1;
      If JFButton.Checked Then Sarok:=2;
      If JAButton.Checked Then Sarok:=3;
      If BAButton.Checked Then Sarok:=4;
      If KPButton.Checked Then Sarok:=5;
      If OraPlusButton.Checked Then Irany:=(-1);
    End;
  End;
  //ha sikerült a forgatás
  If (DlgForgatas.ModalResult = mrOK) And Keret.KeretForgat(Irany,Fok,Sarok) Then
  Begin
    Keret.KeretKapcs(clFuchsia,KI);
    KijelolLancAtRajzol(clNone);
    KijelolLancForgat(Irany,Fok,Sarok);
    KeretUjraSzamolo;
    KijelolLancAtRajzol(clFuchsia);
    KeretUjraSzamolo;
    Keret.KeretKapcs(clFuchsia,BE);
    Keret.KeretMent;
    EpuletLista.Valtozas:=True;
  End;
  KijelolLista.MasolatMegszuntet;
  KellVonalzo:=True;
  ForgatasButton.Down:=False;
  KijelolButton.Down:=True;
  EpuletTul.DT:=dtKijelol;
End;

//méretezés esetén, az egér és a sarokpontok vizsgálata
Procedure TFormTervezo.MeretezNegyzetVizsg(Const Pont: TPoint);
Begin
  Image1.Cursor:=crDefault;
  //bal-felsõ
  If BenneVan(Point(Keret.GetKeret_BF_X-SAROKMERET,Keret.GetKeret_BF_Y-SAROKMERET),Keret.GetKeret_BF,Pont) Then
  Begin
    Image1.Cursor:=crSizeNWSE;
    Keret.SetKeret_KisNPos(1);
  End;
  //jobb-alsó
  If BenneVan(Keret.GetKeret_JA,Point(Keret.GetKeret_JA_X+SAROKMERET,Keret.GetKeret_JA_Y+SAROKMERET),Pont) Then
  Begin
    Image1.Cursor:=crSizeNWSE;
    Keret.SetKeret_KisNPos(2);
  End;
  //jobb-felsõ
  If BenneVan(Point(Keret.GetKeret_JA_X,Keret.GetKeret_BF_Y-SAROKMERET),Point(Keret.GetKeret_JA_X+SAROKMERET,Keret.GetKeret_BF_Y),Pont) Then
  Begin
    Image1.Cursor:=crSizeNESW;
    Keret.SetKeret_KisNPos(3);
  End;
  //bal-alsó
  If BenneVan(Point(Keret.GetKeret_BF_X-SAROKMERET,Keret.GetKeret_JA_Y),Point(Keret.GetKeret_BF_X,Keret.GetKeret_JA_Y+SAROKMERET),Pont) Then
  Begin
    Image1.Cursor:=crSizeNESW;
    Keret.SetKeret_KisNPos(4);
  End;
End;

//méretezés esetén, a saroknégyzetek kirajzolása
Procedure TFormTervezo.MeretezNegyzetKapcs(Const Szin: TColor; Const PenMod: TPenMode);
Var RegiMode : TPenMode;
    RegiSzin : TColor;
    I        : Byte;
    NBF,NJF,
    NJA,NBA  : TPoint;
    RegiPen  : TRegiPenStyle;
Begin
  With Image1.Canvas Do
  Begin
    //régi beállítások mentése
    RegiMode:=Pen.Mode;
    RegiSzin:=Brush.Color;
    RegiPen.Ment(Self,Image1);
    //új beállítások
    Pen.Mode:=PenMod;
    Pen.Color:=Szin;
    Pen.Width:=1;
    If (PenMod <> pmNotXor) Then Brush.Color:=Szin
      Else Brush.Color:=clNone;
    //rajzolás a sarkokra
    With Keret Do
    Begin
      For I:=1 To 4 Do
      Begin
        Case I Of
          1 : Begin
                NBF:=Point(GetKeret_BF_X-SAROKMERET,GetKeret_BF_Y-SAROKMERET);
                NJA:=Point(GetKeret_BF_X,GetKeret_BF_Y);
              End;
          2 : Begin
                NBF:=Point(GetKeret_JA_X,GetKeret_JA_Y);
                NJA:=Point(GetKeret_JA_X+SAROKMERET,GetKeret_JA_Y+SAROKMERET);
              End;
          3 : Begin
                NBF:=Point(GetKeret_JA_X,GetKeret_BF_Y);
                NJA:=Point(GetKeret_JA_X+SAROKMERET,GetKeret_BF_Y-SAROKMERET);
              End;
          4 : Begin
                NBF:=Point(GetKeret_BF_X,GetKeret_JA_Y);
                NJA:=Point(GetKeret_BF_X-SAROKMERET,GetKeret_JA_Y+SAROKMERET);
              End;
        End;
        NJF:=Point(NJA.X,NBF.Y);
        NBA:=Point(NBF.X,NJA.Y);
        NegyzetRajzol(Self,Image1,NBF,NJF,NJA,NBA);
        FillRect(Rect(NBF.X,NBF.Y,NJA.X,NJA.Y));
      End;
      Brush.Color:=RegiSzin;
      Pen.Mode:=RegiMode;
      NegyzetRajzol(Self,Image1,GetKeret_BF,Point(GetKeret_JA_X,GetKeret_BF_Y),GetKeret_JA,Point(GetKeret_BF_X,GetKeret_JA_Y));
      RegiPen.Vissza(Self,Image1);
    End;
  End;
End;

//a méretezés gombra klikkeltünk
Procedure TFormTervezo.MeretezesButtonClick(Sender: TObject);
Begin
  KellVonalzo:=False;
  EpuletTul.DT:=dtMeretez;
  AlakzatGombok(False);
  AlakzatModositoGombok(False,False,False,True);
  //saroknégyzetek kirajzolása
  MeretezNegyzetKapcs(clFuchsia,BE);
End;

//vonalvastagság változtatása
Procedure TFormTervezo.PenMeretAllitChange(Sender: TObject);
Begin
  SetPenStyle(FormTervezo,Image1,EpuletTul.PS,EpuletTul.PC,PenMeretAllit.Value);
  RegiPenStyle.Ment(Self,Image1);
End;

//épületegység választása
Procedure TFormTervezo.ComboBox1Change(Sender: TObject);
Var Nev         : String;
    RegiVonalzo : Boolean;
    AlakLancMut : PAlakzatLanc;
    EpEgysegMut : PEpuletEgyseg;
Begin
  //vonalzó elmentése és kikapcsolása
  RegiVonalzo:=False;
  If KellVonalzo Then
  Begin
    KellVonalzo:=False;
    RegiVonalzo:=True;
  End;
  Nev:=ComboBox1.Text;
  //rákeresünk az épületegységre
  //ha megvan, akkor betöltjük
  If EpuletLista.EgysegKeresNev(Nev,AlakLancMut,EpEgysegMut) Then
  Begin
    KijelolLancMegszuntet;
    AlakzatLanc:=AlakLancMut;
    EpuletEgyseg:=EpEgysegMut;
    PageControlVizsgal;
    If (PageControl1.ActivePage = TabSheet1) Then SetAlapPenBeallit;
    If MozgatasButton.Down Or MeretezesButton.Down Then
    Begin
      RegiVonalzo:=False;
      AlakzatGombok(True);
      AlakzatModositoGombok(False,False,False,False);
      NyilButton.Down:=True;
      NyilButtonClick(Sender);
    End;
  End;
  //vonalzó visszaállítása
  If RegiVonalzo Then
  Begin
    KellVonalzo:=True;
    VanVonalzo:=False;
  End;
End;

//a frissítés gombra klikkeltünk
Procedure TFormTervezo.FrissitButtonClick(Sender: TObject);
Var RegiCursor : TCursor;
Begin
  //az aktuális épületegység újrarajzolása
  RegiCursor:=Image1.Cursor;
  KijelolLancMegszuntet;
  PageControlVizsgal;
  If MozgatasButton.Down Or MeretezesButton.Down Then
  Begin
    AlakzatGombok(True);
    AlakzatModositoGombok(False,False,False,False);
    NyilButton.Down:=True;
    NyilButtonClick(Sender);
    ComboBox2Change(Sender);
    ComboBox3Change(Sender);
    PenMeretAllitChange(Sender);
  End
  Else Image1.Cursor:=RegiCursor;
End;

//épület betöltése
//ha sikerült -> True, különben -> False
Function TFormTervezo.EpuletLancBetoltes : Boolean;
Var Elozo       : Pointer;
    AlakLancMut : PAlakzatLanc;
    EpEgysegMut : PEpuletEgyseg;
Begin
  Result:=False;
  //adatok beolvasása ini-bõl
  RajzIniBetolt(Self.EpuletPath,Self.EpuletNev,Self.AlaprajzMeret,Self.EredEgysMeret);
  //alapértékek beállítása
  Self.EgysegMeret:=Self.EredEgysMeret;
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
  ZoomText.Caption:=FloatToStr(Zoom.Szorzo)+'x';
  BitmapMeret:=RAJZMERET;
  RajzasztalLetrehoz(BitmapMeret);
  EpuletLista:=TEpuletLista.Create;
  EpuletLista.Nev:=EpuletNev;
  EpuletLista.EpuletMeret:=AlaprajzMeret;
  EpuletLista.EgysegMeret:=EgysegMeret;
  //beolvasás adatbázisból
  With EpuletTable Do
  Begin
    First;
    While (Not EOF) Do
    Begin
      Result:=True;
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
        While (AlakzatLanc.Aktualis <> Nil) Do AlakzatLanc.Aktualis:=AlakzatLanc.Aktualis.Kovetkezo;
        EpuletEgyseg:=EpEgysegMut;
      End;
      //alakzat elmentése láncba
      AlakzatLetrehoz(Self,Image1,EpuletLista,FieldByName('Szog').AsInteger,
                      TDrawingTool(FieldByName('Tipus').AsInteger),
                      FieldByName('PenMeret').AsInteger,
                      TPenStyle(FieldByName('PenStyle').AsInteger),
                      FieldByName('PenColor').AsInteger,
                      Point(FieldByName('K1X').AsInteger,FieldByName('K1Y').AsInteger),
                      Point(FieldByName('K2X').AsInteger,FieldByName('K2Y').AsInteger),
                      Point(FieldByName('K3X').AsInteger,FieldByName('K3Y').AsInteger),
                      Point(FieldByName('K4X').AsInteger,FieldByName('K4Y').AsInteger),
                      FieldByName('A').AsFloat,
                      FieldByName('B').AsFloat,1);
      Next;
    End;
  End;

  //ha sikerült a beolvasás
  If Result Then
  Begin
    ComboBox1.ItemIndex:=ComboBox1.Items.IndexOf(EpuletLista.Aktualis.EgysegNev);
    KoordTav.Init(Self,StatusBar1,EgysegMeret);
    PontLista:=TPontLista.Create;
    KijelolLista:=TKijelolLista.Create;
    SetAlapPenBeallit;
    AlakzatModositoGombok(False,False,False,False);
    EpuletTul.VE:=True;
    VanVonalzo:=False;
    VanKeret:=False;
    KezdLathatoAllit(True);
  End;
End;

//a mentés gombra klikkeltünk
Procedure TFormTervezo.MentesButtonClick(Sender: TObject);
Var RegiKurzor      : TCursor;
    RegiKellVonalzo : Boolean;
    DirName : String;
Begin
  //vonalzó elmentése és kikapcsolása
  RegiKellVonalzo:=False;
  If KellVonalzo Then
  Begin
    KellVonalzo:=False;
    RegiKellVonalzo:=True;
  End;
  RegiKurzor:=Screen.Cursor;
  Screen.Cursor:=1;
  If VanVonalzo Then KellVonalzo:=False;
  //láncok mentése adatbázisba
  DirName:=GetCurrentDir;
  If (EpuletLista <> Nil) Then
    EpuletTablaMentes(EpuletLista,EpuletNev,EpuletTable,AlaprajzMeret,EredEgysMeret);
  DirName:=GetCurrentDir;
  If (ObjektumLista <> Nil) Then
    ObjektumTablaMentes(EpuletLista,EpuletNev,ObjektumLista,ObjektumTable);
  If (BerendezesLista <> Nil) Then
    BerendezesTablaMentes(EpuletLista,ObjektumLista,EpuletNev,BerendezesLista,BerendezesTable);
  If VanVonalzo Then KellVonalzo:=True;
  Screen.Cursor:=RegiKurzor;
  //vonalzó visszakapcsolása, ha kell
  If RegiKellVonalzo Then KellVonalzo:=True;
End;

//a beállítás menüre klikkeltünk
Procedure TFormTervezo.BeallitasokClick(Sender: TObject);
Var RegiKellVonalzo : Boolean;
Begin
  //vonalzó elmentése és kikapcsolása
  RegiKellVonalzo:=False;
  If KellVonalzo Then
  Begin
    KellVonalzo:=False;
    RegiKellVonalzo:=True;
  End;
  //beállítások dialogbox meghívása
  With DlgBeallit Do
  Begin
    Visible:=False;
    ActiveControl:=OKBtn;
    If (ShowModal <> idCancel) Then
    Begin
      Self.AblakMeret:=DlgBeallit.AblakEdit.Value;
      AblakSzin.SzinAtmenet:=DlgBeallit.SzinAtmenetBox.Checked;
    End;
  End;
  //vonalzó visszakapcsolása, ha kell
  If RegiKellVonalzo Then KellVonalzo:=True;
End;

//az objektumok menüre klikkeltünk
Procedure TFormTervezo.ObjektumokClick(Sender: TObject);
Var RegiCursor  : TCursor;
    RegiKellVon : Boolean;
Begin
  //ha van már objektumunk
  If (ObjektumLista <> Nil) Then
  Begin
    RegiKellVon:=KellVonalzo;
    KellVonalzo:=False;
    //dinamikus tömb feltöltése
    ObjektumLista.TombFeltolt(Self.BerendezesLista);
    With ObjListaDlg Do
    Begin
      Enabled:=True;
      Visible:=False;
      ActiveControl:=BezarBtn;
      RegiCursor:=Self.Image1.Cursor;
      //a dialogbox meghívása
      ObjListaDlg.ShowModal(Self.ObjektumLista,Self.BerendezesLista);
      Self.Image1.Cursor:=RegiCursor;
      Enabled:=False;
    End;
    KellVonalzo:=RegiKellVon;
  End;
End;

//a berendezések menüre klikkeltünk
Procedure TFormTervezo.BerendezesekClick(Sender: TObject);
Begin
  If (BerendezesLista <> Nil) Then Self.ListaBtnClick(Sender);
End;

//a monitor menüre klikkeltünk
Procedure TFormTervezo.MonitorClick(Sender: TObject);
Var RegiVonalzo : Boolean;
Begin
  //vonalzó elmentése és kikapcsolása
  RegiVonalzo:=False;
  If KellVonalzo Then
  Begin
    KellVonalzo:=False;
    RegiVonalzo:=True;
  End;
  //dialogbox meghívása
  If (EpuletLista <> Nil) Then
    MonitorDlg.ShowModal(EpuletNev,EpuletLista,ObjektumLista,BerendezesLista);
  //vonalzó visszakapcsolása
  If RegiVonalzo Then
  Begin
    KellVonalzo:=True;
    VanVonalzo:=False;
  End;
End;

//a megnyitás menüre klikkeltünk
Procedure TFormTervezo.MegnyitasClick(Sender: TObject);
Var RegiDirName : String;
    RegiVonalzo : Boolean;
    Siker       : Boolean;
    AlakLancMut : PAlakzatLanc;
    EpEgysegMut : PEpuletEgyseg;
    RegiKurzor  : TCursor;
Begin
  Siker:=False;
  //vonalzó elmentése és kikapcsolása
  RegiVonalzo:=False;
  If KellVonalzo Then
  Begin
    KellVonalzo:=False;
    RegiVonalzo:=True;
  End;
  RegiDirName:=ExtractFilePath(ParamStr(0));
  //a megnyitás dialobox meghívása
  If (OpenDlg.ShowModal <> idCancel) Then
  Begin
    BezarMenuClick(Sender);
    RegiKurzor:=Screen.Cursor;
    Screen.Cursor:=1;
    Self.EpuletNev:=OpenDlg.Get_DirName;
    Self.EpuletPath:=OpenDlg.Get_DirPath;
    //beállítjuk az alias-t
    AliasModosit(Self.EpuletPath);
    EpuletTable.TableName:=Self.EpuletPath+'\'+sAlaprajz+sKit;
    EpuletTable.IndexName:=INDEXNEV;
    //ha létezik az adatbázis
    If FileExists(EpuletTable.TableName) Then
      Try
        EpuletTable.Open;
        //betöltjük az adatbázist
        Siker:=EpuletLancBetoltes;
        EpuletLista.Valtozas:=False;
      Finally
        EpuletTable.Close;
      End;
    ObjektumTable.TableName:=Self.EpuletPath+'\'+sObjektum+sKit;
    //ha létezik az adatbázis
    If Siker And FileExists(ObjektumTable.TableName) Then
      Try
        ObjektumTable.Open;
        //betöltjük az adatbázist
        ObjektumLista:=ObjektumLancBetolt(EpuletLista,ObjektumTable);
        ObjektumLista.Valtozas:=False;
      Finally
        ObjektumTable.Close;
      End;
    BerendezesTable.TableName:=Self.EpuletPath+'\'+sBerendezes+sKit;
    //ha létezik az adatbázis
    If Siker And FileExists(BerendezesTable.TableName) Then
      Try
        BerendezesTable.Open;
        //betöltjük az adatbázist
        BerendezesLista:=BerendezesLancBetolt(BerendezesTable);
        BerendezesLista.Valtozas:=False;
      Finally
        BerendezesTable.Close;
      End;
    //ha sikerült
    If Siker Then
    Begin
      //frissítjük a rajzasztalt
      If EpuletLista.EgysegKeresNev(EpuletLista.Aktualis.EgysegNev,AlakLancMut,EpEgysegMut) Then
      Begin
        AlakzatLanc:=AlakLancMut;
        EpuletEgyseg:=EpEgysegMut;
        PageControlVizsgal;
        ComboBox1.ItemIndex:=ComboBox1.Items.IndexOf(EpuletLista.Aktualis.EgysegNev);
      End;
      //alapértékek beállítása
      NyilButton.Down:=True;
      NyilButtonClick(Self);
      SetAlapPenBeallit;
      FormTervezo.Caption:='Tervezõ - '+EpuletNev;
      PageControl1.ActivePage:=TabSheet1;
      PageControlGombValt(PageControl1.ActivePage=TabSheet1,
        PageControl1.ActivePage=TabSheet2,PageControl1.ActivePage=TabSheet3);
    End
    Else Begin
      NyilButton.Down:=True;
      NyilButtonClick(Self);
    End;
    Screen.Cursor:=RegiKurzor;
  End;
  SetCurrentDir(RegiDirName);
  //vonalzó visszakapcsolása
  If (Not Siker) And RegiVonalzo Then
  Begin
    KellVonalzo:=True;
    VanVonalzo:=False;
  End;
End;

  //vonalzó visszakapcsolása
Procedure TFormTervezo.MegnyitasButtonClick(Sender: TObject);
Begin
  MegnyitasClick(Sender);
End;

//a mentés menüre klikkeltünk
Procedure TFormTervezo.MentesClick(Sender: TObject);
Begin
  MentesButtonClick(Sender);
End;

//a mentés másként menüre klikkeltünk
Procedure TFormTervezo.MentesMaskentClick(Sender: TObject);
Var Kit         : String;
    DirName     : String;
    RegiDirName : String;
Begin
  RegiDirName:=ExtractFilePath(ParamStr(0));
  SetCurrentDir(RegiDirName+'..');
  DirName:=GetCurrentDir+'\'+ALAPRAJZDIR;
  SetCurrentDir(RegiDirName);
  SaveTervrajz.Title:='Mentés másként';
  SaveTervrajz.InitialDir:=DirName;
  SaveTervrajz.FileName:=EpuletNev;
  SaveTervrajz.Options:=SaveTervrajz.Options+[ofOverwritePrompt];
  //dialogbox meghívása
  If SaveTervrajz.Execute Then
  Begin
    EpuletNev:=ExtractFileName(SaveTervrajz.FileName);
    Kit:=ExtractFileExt(SaveTervrajz.FileName);
    System.Delete(EpuletNev,Length(EpuletNev)-Length(Kit)+1,Length(Kit));
    EpuletLista.Nev:=EpuletNev;
    //mentés
    MentesButtonClick(Sender);
    FormTervezo.Caption:='Tervezõ - '+EpuletNev;
  End;
  SaveTervrajz.Options:=SaveTervrajz.Options-[ofOverwritePrompt];
End;

//a bezárás menüre klikkeltünk
Procedure TFormTervezo.BezarMenuClick(Sender: TObject);
Begin
  Mentesek;
  LancokUrit;
  ComboBox1.Clear;
  EpuletTul.VE:=False;
  Image1.Picture:=Nil;
  Image1.Visible:=False;
  ScrollBox1.HorzScrollBar.Visible:=False;
  ScrollBox1.VertScrollBar.Visible:=False;
  KezdLathatoAllit(False);
End;

//színválasztó combobox feltöltése             
Procedure TFormTervezo.ComboBox2DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
Var TextRect  : TRect;
    ColorRect : TRect;
Begin
  ComboBox2.Canvas.FillRect(Rect);
  TextRect:=Rect;
  TextRect.Left:=20;
  DrawText(ComboBox2.Canvas.Handle,PChar(ComboBox2.Items.Strings[Index]),-1,
    TextRect,DT_LEFT Or DT_SINGLELINE Or DT_VCENTER);
  Case Index Of
    0 : ComboBox2.Canvas.Brush.Color:=clBlack;
    1 : ComboBox2.Canvas.Brush.Color:=clGreen;
    2 : ComboBox2.Canvas.Brush.Color:=clBlue;
    3 : ComboBox2.Canvas.Brush.Color:=clRed;
    4 : ComboBox2.Canvas.Brush.Color:=clYellow;
    5 : ComboBox2.Canvas.Brush.Color:=clLime;
    6 : ComboBox2.Canvas.Brush.Color:=clWhite;
  End;
  ColorRect.Top:=Rect.Top+1;
  ColorRect.Left:=Rect.Left+2;
  ColorRect.Right:=18;
  ColorRect.Bottom:=Rect.Bottom-1;
  ComboBox2.Canvas.Rectangle(ColorRect);
End;

//színválasztó combobox módosítása             
Procedure TFormTervezo.ComboBox2Change(Sender: TObject);
Begin
  SetPenStyle(Self,Image1,EpuletTul.PS,ComboBox2.Canvas.Brush.Color,EpuletTul.PM);
  RegiPenStyle.Ment(Self,Image1);
End;

//vonal típus combobox feltöltése
Procedure TFormTervezo.ComboBox3DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
Begin
  ComboBox3.Canvas.FillRect(Rect);
  Case Index Of
    0 : ComboBox3.Canvas.Pen.Style:=psSolid;
    1 : ComboBox3.Canvas.Pen.Style:=psDot;
  End;
  ComboBox3.Canvas.MoveTo(Rect.Left+5,Abs((Rect.Top+Rect.Bottom) Div 2));
  ComboBox3.Canvas.LineTo(Rect.Right-5,Abs((Rect.Top+Rect.Bottom) Div 2));
End;

//vonal típus combobox módosítása
Procedure TFormTervezo.ComboBox3Change(Sender: TObject);
Begin
  SetPenStyle(Self,Image1,ComboBox3.Canvas.Pen.Style,EpuletTul.PC,EpuletTul.PM);
End;

//a névjegy menüre klikkeltünk
Procedure TFormTervezo.NevjegyClick(Sender: TObject);
Var RegiKellVonalzo : Boolean;
Begin
  //vonalzó elmentése és kikapcsolása
  RegiKellVonalzo:=False;
  If KellVonalzo Then
  Begin
    KellVonalzo:=False;
    RegiKellVonalzo:=True;
  End;
  //aboutbox létrehozása
  If (Not Assigned (AboutBox)) Then AboutBox:=TAboutBox.Create(Application);
  AboutBox.ShowModal;
  //vonalzó visszakapcsolása
  If RegiKellVonalzo Then KellVonalzo:=True;
End;

//a súgó menüre klikkeltünk
Procedure TFormTervezo.SugoClick(Sender: TObject);
Var RegiKellVonalzo : Boolean;
Begin
  //vonalzó elmentése és kikapcsolása
  RegiKellVonalzo:=False;
  If KellVonalzo Then
  Begin
    KellVonalzo:=False;
    RegiKellVonalzo:=True;
  End;
  //súgófájl megnyitása
  Application.HelpFile:='.\SÚGÓ.HLP';
  Application.HelpCommand(HELP_FINDER,0);
  //vonalzó visszakapcsolása
  If RegiKellVonalzo Then KellVonalzo:=True;
End;

//nagyítás
Procedure TFormTervezo.ZoomInButtonClick(Sender: TObject);
Var RegiKurzor      : TCursor;
    RegiKellVonalzo : Boolean;
Begin
  //vonalzó elmentése és kikapcsolása
  RegiKellVonalzo:=False;
  If KellVonalzo Then
  Begin
    KellVonalzo:=False;
    RegiKellVonalzo:=True;
  End;
  RegiKurzor:=Screen.Cursor;
  Screen.Cursor:=1;
  //ha lehet még nagyítani
  If Zoom.Novel Then
  Begin
    If (Zoom.Szorzo < MAXZOOM) Then ZoomInButton.Enabled:=True
      Else ZoomInButton.Enabled:=False;
    Egysegmeret:=EredEgysMeret/Zoom.Szorzo;
    ZoomText.Caption:=FloatToStr(Zoom.Szorzo)+'x';
    //megnöveljük a rajzasztal méretét
    BitmapMeret:=Round(Zoom.Szorzo*RajzMeret);
    If (BitmapMeret >= ScrollBox1.Width) Then ScrollBox1.HorzScrollBar.Visible:=True
      Else ScrollBox1.HorzScrollBar.Visible:=False;
    If (BitmapMeret >= ScrollBox1.Height) Then ScrollBox1.VertScrollBar.Visible:=True
      Else ScrollBox1.VertScrollBar.Visible:=False;
    //rajzasztal újrarajzolása
    PageControlVizsgal;
  End
  Else ZoomInButton.Enabled:=False;
  ZoomOutButton.Enabled:=True;
  If VanVonalzo Then KellVonalzo:=True;
  Screen.Cursor:=RegiKurzor;
  //vonalzó visszaállítása
  If RegiKellVonalzo Then KellVonalzo:=True;
  //a kijelölés gomb beállítása
  If (Zoom.Szorzo = 1) Then KijelolButton.Enabled:=True
  Else Begin
    If KijelolButton.Down Then
    Begin
      NyilButton.Down:=True;
      NyilButtonClick(Sender);
    End;
    KijelolButton.Enabled:=False;
  End;
End;

//kicsinyítés
Procedure TFormTervezo.ZoomOutButtonClick(Sender: TObject);
Var RegiKurzor      : TCursor;
    RegiKellVonalzo : Boolean;
Begin
  //vonalzó elmentése és kikapcsolása
  RegiKellVonalzo:=False;
  If KellVonalzo Then
  Begin
    KellVonalzo:=False;
    RegiKellVonalzo:=True;
  End;
  RegiKurzor:=Screen.Cursor;
  Screen.Cursor:=1;
  //ha lehet még kicsinyíteni
  If Zoom.Csokkent Then
  Begin
    If (Zoom.Szorzo > (1/MAXZOOM)) Then ZoomOutButton.Enabled:=True
      Else ZoomOutButton.Enabled:=False;
    Egysegmeret:=(1/Zoom.Szorzo)*EredEgysMeret;
    ZoomText.Caption:=FloatToStr(Zoom.Szorzo)+'x';
    //csökkentjük a rajzasztal méretét
    BitmapMeret:=Round(Zoom.Szorzo*RajzMeret);
    If (BitmapMeret < ScrollBox1.Width) Then ScrollBox1.HorzScrollBar.Visible:=False
      Else ScrollBox1.HorzScrollBar.Visible:=True;
    If (BitmapMeret < ScrollBox1.Height) Then ScrollBox1.VertScrollBar.Visible:=False
      Else ScrollBox1.VertScrollBar.Visible:=True;
    //rajzasztal újrarajzolása
    PageControlVizsgal;
  End
  Else ZoomOutButton.Enabled:=False;
  ZoomInButton.Enabled:=True;
  If VanVonalzo Then KellVonalzo:=True;
  Screen.Cursor:=RegiKurzor;
  //vonalzó visszaállítása
  If RegiKellVonalzo Then KellVonalzo:=True;
  //a kijelölés gomb beállítása
  If (Zoom.Szorzo = 1) Then KijelolButton.Enabled:=True
  Else Begin
    If KijelolButton.Down Then
    Begin
      NyilButton.Down:=True;
      NyilButtonClick(Sender);
    End;
    KijelolButton.Enabled:=False;
  End;
End;

//form létrehozása
Procedure TFormTervezo.FormCreate(Sender: TObject);
Var HM : HMenu;
Begin
  Inditas:=True;
  DoubleBuffered:=True;
  HM:=GetSystemMenu(Handle,False);
  If (HM <> 0) Then EnableMenuItem(HM,SC_CLOSE,MF_DISABLED+MF_GRAYED);
  Image1.Visible:=False;
  Application.OnIdle:=MyIdleHandler;
  ControlStyle:=ControlStyle+[csOpaque];
  VonalzoRajzol:=False;
  VanVonalzo:=False;
  VonalzoPos.X:=0;
  VonalzoPos.Y:=0;
End;

//form méretezése
Procedure TFormTervezo.FormCanResize(Sender: TObject; Var NewWidth,
  NewHeight: Integer; Var Resize: Boolean);
Begin
  If Resize Then
  Begin
    With ScrollBoxMeret Do
    Begin
      TopLeft.X:=ScrollBox1.ClientOrigin.X;
      TopLeft.Y:=ScrollBox1.ClientOrigin.Y;
      BottomRight.X:=TopLeft.X+ScrollBox1.ClientWidth;
      BottomRight.Y:=TopLeft.Y+ScrollBox1.ClientHeight;
    End;
    With ImageMeret Do
    Begin
      TopLeft.X:=Image1.ClientOrigin.X;
      TopLeft.Y:=Image1.ClientOrigin.Y;
      BottomRight.X:=TopLeft.X+Image1.ClientWidth;
      BottomRight.Y:=TopLeft.Y+Image1.ClientHeight;
    End;
  End
End;

//objektum gombra klikkeltünk
Procedure TFormTervezo.ObjButtonClick(Sender: TObject);
Begin
  VanVonalzo:=False;
  KellVonalzo:=True;
  Image1.Cursor:=crCross;
  EpuletTul.DT:=dtObjektum;
End;

//új objektum felvitele és rajzolása
Procedure TFormTervezo.ObjektumKeszit(Const Pont: TPoint);
Var PontTomb  : TPontKoordTomb;
    TombHossz : Integer;
    Siker     : Boolean;

  //a poligon törlése
  Procedure PolygonTorol(Tomb: TPontKoordTomb);
  Var RPM : TPenMode;
  Begin
    With Image1.Canvas Do
    Begin
      RPM:=Pen.Mode;
      Pen.Mode:=KI;
      Polygon(Tomb);
      Pen.Mode:=RPM;
    End;
  End;

Begin
  Siker:=False;
  SetLength(PontTomb,0);
  PontTomb:=Objektum.GetPontokMasolat;
  TombHossz:=Length(PontTomb)-1;
  //hány pontunk van
  Case TombHossz Of
    -1 : ;
     0 : DrawShape(Self,Image1,EpuletTul.DT,PontTomb[0],Pont,KI);
     1 : Begin
           DrawShape(Self,Image1,EpuletTul.DT,PontTomb[0],PontTomb[1],KI);
           DrawShape(Self,Image1,EpuletTul.DT,PontTomb[1],Pont,KI);
         End;
     Else Begin
       Siker:=True;
       DrawShape(Self,Image1,EpuletTul.DT,PontTomb[TombHossz],Pont,KI);
       DrawShape(Self,Image1,EpuletTul.DT,PontTomb[TombHossz],PontTomb[0],BE);
     End;
  End;
  //ha megfelelõ
  If Siker Then
  Begin
    KellVonalzo:=False;
    With ObjNevForm Do
    Begin
      Visible:=False;
      NevEdit.Text:='';
      ActiveControl:=NevEdit;
      Set_ObjLista(ObjektumLista);
      //név bekérése
      If (ShowModal <> idCancel) Then
      Begin
        //objektum tárolása
        Objektum.Nev:=NevEdit.Text;
        ObjektumLista.Felfuz(@Objektum);
        PolygonTorol(PontTomb);
        ObjektumLista.KiRajzol(FormTervezo,Image1,Zoom.Szorzo);
      End
      Else PolygonTorol(PontTomb);
    End;
    FreeAndNil(Objektum);
  End;
  Drawing:=False;
  NyilButtonClick(Self);
  ObjNyilBtn.Down:=True;
  VanObjektum:=False;
  VonalzoRajzol:=False;
End;

Procedure TFormTervezo.ObjListBtnClick(Sender: TObject);
Var RegiCursor      : TCursor;
    RegiKellVonalzo : Boolean;
Begin
  //vonalzó elmentése és kikapcsolása
  RegiKellVonalzo:=False;
  If KellVonalzo Then
  Begin
    KellVonalzo:=False;
    RegiKellVonalzo:=True;
  End;
  //lista törlése
  ObjektumokDlg.ObjListBox.Items.Clear;
  //lista feltöltése
  With ObjektumLista Do
  Begin
    Aktualis:=Elso;
    While (Aktualis <> Nil) Do
    Begin
      If (Aktualis.ObjMut.EpuletEgyseg = EpuletLista.Aktualis) Then
        ObjektumokDlg.ObjListBox.Items.Add(Aktualis.ObjMut.Nev);
      Aktualis:=Aktualis.Kovetkezo;
    End;
  End;
  RegiCursor:=Image1.Cursor;
  ObjektumokDlg.ObjListBox.ItemIndex:=0;
  ObjektumokDlg.ShowModal(ObjektumLista,EpuletLista.Aktualis);
  Image1.Cursor:=RegiCursor;
  //vonalzó visszaállítása
  If RegiKellVonalzo Then KellVonalzo:=True;
End;

//melyik gomb legyen kiemelve
Procedure TFormTervezo.PageControlGombValt(Ertek1,Ertek2,Ertek3: Boolean);
Begin
  TabSheet1.Highlighted:=Ertek1;
  TabSheet2.Highlighted:=Ertek2;
  TabSheet3.Highlighted:=Ertek3;
End;

//PageControl váltás
Procedure TFormTervezo.PageControl1Change(Sender: TObject);
Begin
  With PageControl1 Do
  Begin
    PageControlGombValt(ActivePage=TabSheet1,ActivePage=TabSheet2,ActivePage=TabSheet3);
    //rajzolás gomb lett aktív
    If (ActivePage = TabSheet1) Then
    Begin
      //rajzasztal újrarajzolása
      FrissitButtonClick(Sender);
      If (VezerloAllapot <> Nil) Then
      Begin
        VezerloAllapot.VisszaAllit(True);
        FreeAndNil(VezerloAllapot);
      End;
    End;
    //rajzolás gomb lett aktív
    If (ActivePage = TabSheet2) Then
    Begin
      NyilButtonClick(Self);
      ObjNyilBtn.Down:=True;
      VanObjektum:=False;
      PageControlVizsgal;
      If (ObjektumLista = Nil) Then ObjektumLista:=TObjektumLista.Create(EpuletLista);
      Image1.Cursor:=crDefault;
    End;
    //rajzolás gomb lett aktív
    If (ActivePage = TabSheet3) Then
    Begin
      If (BerendezesLista = Nil) Then BerendezesLista:=TBerendezesLista.Create;
      NyilButtonClick(Self);
      Image1.Cursor:=crDefault;
    End;
  End;
End;

//melyik PageControl az aktív
Procedure TFormTervezo.PageControlVizsgal;
Begin
  If (PageControl1.ActivePage = TabSheet1) Then AsztalUjraRajzol;
  If (PageControl1.ActivePage = TabSheet2) Then
  Begin
    AsztalUjraRajzol(clSilver);
    VezerloAllapot.BeAllit(3,0,1,psSolid,EpuletTul.DT,Image1.Cursor,False,False);
    If (ObjektumLista <> Nil) Then ObjektumLista.KiRajzol(Self,Image1,Zoom.Szorzo);
  End;
  If (PageControl1.ActivePage = TabSheet3) Then AsztalUjraRajzol;
End;

//PageControl váltás, de még a PageControl1 az aktív
Procedure TFormTervezo.PageControl1Changing(Sender: TObject;
          Var AllowChange: Boolean);
Begin
  If ((Sender As TPageControl).ActivePage = TabSheet1) Then
  Begin
    If (VezerloAllapot <> Nil) Then FreeAndNil(VezerloAllapot);
    VezerloAllapot:=TVezerloAllapot.Create(ComboBox2.ItemIndex,
      ComboBox3.ItemIndex,PenMeretAllit.Value,Image1.Canvas.Pen.Style,EpuletTul.DT,KellVonalzo,Image1.Cursor);
  End;
End;

//új berendezés felvétele
Procedure TFormTervezo.UjBerendFormNyitas;
Var Fej : String;
Begin
  With UjBerendDlg Do
  Begin
    Fej:='Új berendezés';
    Case BerendTip Of
      btHomero   : UjBerendDlg.Caption:=Fej+' ('+sHomero+')';
      btRiaszto  : UjBerendDlg.Caption:=Fej+' ('+sRiaszto+')';
      btTuzjelzo : UjBerendDlg.Caption:=Fej+' ('+sTuzjelzo+')';
      btFutotest : UjBerendDlg.Caption:=Fej+' ('+sFutotest+')';
      btEgyeb    : UjBerendDlg.Caption:=Fej+' ('+sEgyeb+')';
    End;
    Visible:=False;
    BerendezesEdit.Text:='';
    Set_Lista(BerendezesLista);
    ActiveControl:=BerendezesEdit;
    //lista ürítése
    ObjektumComboBox.Items.Clear;
    ObjektumComboBox.Items.Add('Egyikhez sem');
    //objektumok felvétele a listába
    If (ObjektumLista <> Nil) Then
      With ObjektumLista Do
      Begin
        Aktualis:=Elso;
        While (Aktualis <> Nil) Do
        Begin
          If (Aktualis.ObjMut.EpuletEgyseg = EpuletLista.Aktualis) Then
            ObjektumComboBox.Items.Add(Aktualis.ObjMut.Nev);
          Aktualis:=Aktualis.Kovetkezo;
        End;
      End;
    //új berendezés form meghívása
    If (ShowModal <> idCancel) Then
      BerendezesLista.Felfuz(BerendTip,ObjektumComboBox.Text,EpuletEgyseg.EgysegNev,BerendezesEdit.Text);
  End;
End;

//új hõmérõ felvitele
Procedure TFormTervezo.HomeroBtnClick(Sender: TObject);
Begin
  UjBerendFormNyitas(btHomero);
End;

//új riasztó felvitele
Procedure TFormTervezo.RiasztoBtnClick(Sender: TObject);
Begin
  UjBerendFormNyitas(btRiaszto);
End;

//új tûzjelzõ felvitele
Procedure TFormTervezo.TuzjelzoBtnClick(Sender: TObject);
Begin
  UjBerendFormNyitas(btTuzjelzo);
End;

//új fûtõtest felvitele
Procedure TFormTervezo.FutotestBtnClick(Sender: TObject);
Begin
  UjBerendFormNyitas(btFutotest);
End;

//új más berendezések felvitele
Procedure TFormTervezo.EgyebBtnClick(Sender: TObject);
Begin
  UjBerendFormNyitas(btEgyeb);
End;

//lenyomott billentyû feldolgozása
Procedure TFormTervezo.FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
  //Alt-F4 letiltása 
  If (Key = VK_F4) And (ssAlt In Shift) Then Key:=0;
End;

//berendezések kilistázása
Procedure TFormTervezo.ListaBtnClick(Sender: TObject);
Var RegiCursor      : TCursor;
    RegiKellVonalzo : Boolean;
Begin
  //vonalzó elmentése és kikapcsolása
  RegiKellVonalzo:=False;
  If KellVonalzo Then
  Begin
    KellVonalzo:=False;
    RegiKellVonalzo:=True;
  End;
  //berendezés tömb újrafeltöltése
  BerendezesLista.TombFeltolt;
  With BerendezesDlg Do
  Begin
    Enabled:=True;
    Visible:=False;
    ActiveControl:=BezarBtn;
    RegiCursor:=Self.Image1.Cursor;
    //lista megjelenítése
    BerendezesDlg.ShowModal(Self.BerendezesLista);
    Self.Image1.Cursor:=RegiCursor;
    Enabled:=False;
  End;
  //vonalzó visszaállítása
  If RegiKellVonalzo Then KellVonalzo:=True;
End;

End.
