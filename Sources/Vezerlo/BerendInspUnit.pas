//A berendezések irányítópaneljének eljárásai, függvényei
Unit BerendInspUnit;

Interface

Uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     Grids, ComCtrls, DlgUnit, ExtCtrls, StdCtrls, BerendezesekLancUnit,
     HomeroLancUnit, Gomb, Buttons, VegBerendLancUnit, KuldThreadUnit, UtilUnit,
     RiasztoLancUnit, TuzjelzoLancUnit, KodolasUnit;

Type
  TBerendInspector = Class(TForm)
    StatusBar1     : TStatusBar;
    PageControl1   : TPageControl;
    BerendTabSheet : TTabSheet;
    TulTabSheet    : TTabSheet;
    BerendGrid     : TStringGrid;
    Panel1         : TPanel;
    Splitter1      : TSplitter;
    TulGrid2       : TStringGrid;
    TulGrid1       : TStringGrid;
    Panel2         : TPanel;
    Panel3         : TPanel;
    Label1         : TLabel;
    Panel4         : TPanel;
    BeallitBtn     : TBitBtn;
    Kapcsolo1      : TKapcsolo;
    Kapcsolo2      : TKapcsolo;
    Bevel1         : TBevel;
    Label2         : TLabel;
    Label3         : TLabel;
    Panel5         : TPanel;
    Label4         : TLabel;
    Panel6         : TPanel;
    Procedure Show(OLD : TOsszesLista_Dlg; UL: TUzenetLista); Reintroduce; Overload;
    Procedure FormCreate(Sender: TObject);
    Procedure FormResize(Sender: TObject);
    Procedure Splitter1Moved(Sender: TObject);
    Procedure TulGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
              Rect: TRect; State: TGridDrawState);
    Procedure TulGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
              Rect: TRect; State: TGridDrawState);
    Procedure BerendGridDblClick(Sender: TObject);
    Procedure PageControl1Change(Sender: TObject);
    Procedure Kapcsolo1On(Sender: TObject);
    Procedure Kapcsolo1Off(Sender: TObject);
    Procedure Kapcsolo2On(Sender: TObject);
    Procedure Kapcsolo2Off(Sender: TObject);
    Procedure BeallitBtnClick(Sender: TObject);
    Procedure FormClose(Sender: TObject; var Action: TCloseAction);
    Procedure Kapcsolo1Click(Sender: TObject);
  Private
    Mutato        : PLancElem;          //általános mutató
    UzLista       : TUzenetLista;       //üzenetek lánca
    HomeroMut     : PHomeroElem;        //hõmérõ elemre mutat
    RiasztoMut    : PRiasztoElem;       //riasztó elemre mutat
    TuzjelzoMut   : PTuzjelzoElem;      //tûzjelzõ elemre mutat
    VegBerendMut  : PVegBerendElem;     //végberendezés elemre mutat
    OsszLista_Dlg : TOsszesLista_Dlg;   //az összes lánc
    Procedure SetUzLista(Ertek: TUzenetLista);
  Public
    Property UzenetLista : TUzenetLista Write SetUzLista;
    Procedure Frissit;
    Procedure Urit;
  End;

Var BerendInspector : TBerendInspector;

Implementation

Uses VezerloUnit;

{$R *.DFM}

//panel megjelenítése
Procedure TBerendInspector.Show(OLD: TOsszesLista_Dlg; UL: TUzenetLista);
Var I : Integer;
Begin
  Urit;
  UzLista:=UL;
  OsszLista_Dlg:=OLD;
  //ha vannak elemek
  If (OsszLista_Dlg <> Nil) And (OsszLista_Dlg.BerendezesList <> Nil) Then
  Begin
    If OsszLista_Dlg.BerendezesList.TombUres Then OsszLista_Dlg.BerendezesList.TombFeltolt;
    //táblázat feltöltése
    For I:=0 To High(OsszLista_Dlg.BerendezesList.BerendTomb) Do
    Begin
      BerendGrid.RowCount:=i+1;
      BerendGrid.Cells[0,i]:=OsszLista_Dlg.BerendezesList.BerendTomb[i,2];
    End;
    Panel2.Visible:=False;
    Panel3.Visible:=False;
  End;
  //megjelenítés
  Inherited Show;
End;

//form létrehozása
Procedure TBerendInspector.FormCreate(Sender: TObject);
Begin
  Self.Left:=5;
  Self.Top:=100;
  //táblázat beállítása
  TulGrid1.Rows[0].Append('Tuljdonság');
  TulGrid2.Rows[0].Append('Érték');
  TulGrid1.Rows[1].Append('ID');
  TulGrid1.Rows[2].Append('Neve');
  TulGrid1.Rows[3].Append('Típusa');
  TulGrid1.Rows[4].Append('Egység neve');
  TulGrid1.Rows[5].Append('Objektum neve');
  TulGrid1.DefaultColWidth:=TulGrid1.Width;
  TulGrid2.DefaultColWidth:=Panel1.Width;
  BerendGrid.DefaultColWidth:=Self.Width;
  PageControl1.ActivePage:=BerendTabSheet;
End;

//a form méretezésének eseménye
Procedure TBerendInspector.FormResize(Sender: TObject);
Begin
  TulGrid2.DefaultColWidth:=Panel1.Width;
  BerendGrid.DefaultColWidth:=Self.Width;
End;

//splitter mozgatása
Procedure TBerendInspector.Splitter1Moved(Sender: TObject);
Begin
  TulGrid1.DefaultColWidth:=TulGrid1.Width;
End;

//rajzolás
Procedure TBerendInspector.TulGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Begin
  TulGrid2.Row:=TulGrid1.Row;
End;

//rajzolás
Procedure TBerendInspector.TulGrid2DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Begin
  TulGrid1.Row:=TulGrid2.Row;
End;

//duppla kattintás eseménye
Procedure TBerendInspector.BerendGridDblClick(Sender: TObject);
Begin
  PageControl1.ActivePage:=TulTabSheet;
  PageControl1Change(Sender);
End;

//fülre kattintás
Procedure TBerendInspector.PageControl1Change(Sender: TObject);
Var ID : Integer;
Begin
  //ha a tulajdonságok fül az aktív
  If (PageControl1.ActivePage = TulTabSheet) Then
  Begin
    Panel2.Visible:=False;
    Panel3.Visible:=False;
    Panel5.Visible:=False;
    TulGrid2.Cols[0].Clear;
    TulGrid2.Rows[0].Append('Érték');
    //ha vannak berendezések
    If (OsszLista_Dlg <> Nil) And (OsszLista_Dlg.BerendezesList <> Nil) Then
    Begin
      //megkeressük a kiválasztott berendezés azonosítóját
      ID:=OsszLista_Dlg.BerendezesList.KeresNev(BerendGrid.Cells[0,BerendGrid.Row]);
      //ha megvan a mutatója is
      If (ID > 0) And OsszLista_Dlg.BerendezesList.KeresID(ID,Mutato) Then
      Begin
        TulGrid2.Rows[1].Append(IntToStr(Mutato.ID));
        TulGrid2.Rows[2].Append(Mutato.BerendezesNev);
        //berendezés típusa
        Case Mutato.BerendezesTip Of
          btHomero   : Begin
                         TulGrid2.Rows[3].Append(sHomero);
                         Panel2.Top:=160;
                         Panel2.Visible:=True;
                         Panel3.Visible:=False;
                         Panel5.Visible:=False;
                         OsszLista_Dlg.Homero.KeresID(ID,HomeroMut);
                         If (HomeroMut <> Nil) Then
                         Begin
                           Panel4.Caption:=IntToStr(HomeroMut.MertErtek)+sCelsius;
                         End;
                       End;
          btRiaszto  : Begin
                         TulGrid2.Rows[3].Append(sRiaszto);
                         Panel5.Top:=160;
                         Panel5.Visible:=True;
                         Panel2.Visible:=False;
                         Panel3.Visible:=False;
                         OsszLista_Dlg.Riaszto.KeresID(ID,RiasztoMut);
                         If (RiasztoMut <> Nil) Then
                         Begin
                           If RiasztoMut.Allapot Then
                           Begin
                             Panel6.Font.Color:=clRed;
                             Panel6.Caption:='Riasztás';
                           End
                           Else Begin
                             Panel6.Font.Color:=clBlack;
                             Panel6.Caption:='Normál';
                           End;
                         End;
                       End;
          btTuzjelzo : Begin
                         TulGrid2.Rows[3].Append(sTuzjelzo);
                         Panel5.Top:=160;
                         Panel5.Visible:=True;
                         Panel2.Visible:=False;
                         Panel3.Visible:=False;
                         OsszLista_Dlg.Tuzjelzo.KeresID(ID,TuzjelzoMut);
                         If (TuzjelzoMut <> Nil) Then
                         Begin
                           If TuzjelzoMut.Allapot Then
                           Begin
                             Panel6.Font.Color:=clRed;
                             Panel6.Caption:='Tûzjelzés';
                           End
                           Else Begin
                             Panel6.Font.Color:=clBlack;
                             Panel6.Caption:='Normál';
                           End;
                         End;
                       End;
          btFutotest : Begin
                         TulGrid2.Rows[3].Append(sFutotest);
                         Panel3.Top:=160;
                         Panel3.Visible:=True;
                         Panel2.Visible:=False;
                         Panel5.Visible:=False;
                         OsszLista_Dlg.VegBerendezes.KeresID(ID,VegBerendMut);
                         If (VegBerendMut <> Nil) Then
                         Begin
                           Kapcsolo1.StateOn:=VegBerendMut.Automata;
                           Kapcsolo2.StateOn:=VegBerendMut.Direkt;
                         End;
                       End;
          btEgyeb    : Begin
                         TulGrid2.Rows[3].Append(sEgyeb);
                         Panel3.Top:=160;
                         Panel3.Visible:=True;
                         Panel2.Visible:=False;
                         Panel5.Visible:=False;
                         OsszLista_Dlg.VegBerendezes.KeresID(ID,VegBerendMut);
                         If (VegBerendMut <> Nil) Then
                         Begin
                           Kapcsolo1.StateOn:=VegBerendMut.Automata;
                           Kapcsolo2.StateOn:=VegBerendMut.Direkt;
                         End;
                       End;
        End;
        TulGrid2.Rows[4].Append(Mutato.EpuletEgyseg);
        TulGrid2.Rows[5].Append(Mutato.ObjektumNev);
      End;
    End;
  End;
End;

//bekapcsolás
Procedure TBerendInspector.Kapcsolo1On(Sender: TObject);
Begin
  Kapcsolo2.Enabled:=False;
  If (VegBerendMut <> Nil) Then VegBerendMut.Automata:=True;
End;

//kikapcsolás
Procedure TBerendInspector.Kapcsolo1Off(Sender: TObject);
Begin
  Kapcsolo2.Enabled:=True;
  If (VegBerendMut <> Nil) Then VegBerendMut.Automata:=False;
End;

//kattintás a kapcsolóra
Procedure TBerendInspector.Kapcsolo1Click(Sender: TObject);
Begin
  With FormVezerlo Do
  Begin
    AttekintGridFrissit;
    If Kapcsolo1.StateOn Then
      MemoIr(True,'Berendezés átkapcsolása automata üzemmódba.',clBlack)
    Else MemoIr(True,'Berendezés átkapcsolása kézi üzemmódba.',clBlack);
  End;
End;

//bekapcsolás
Procedure TBerendInspector.Kapcsolo2On(Sender: TObject);
Var Szoveg : String;
    UzTomb : TAdatUzenetTomb;
Begin
  If (VegBerendMut <> Nil) Then
  Begin
    //berendezés bekapcsolása
    VegBerendMut.Direkt:=True;
    If (UzLista <> Nil) Then
    Begin
      SetLength(UzTomb,2);
      UzTomb[0]:=VegBerendMut.ID;
      UzTomb[1]:=BoolToInt(True);
      Szoveg:=MemoIdo+'('+IntToStr(VegBerendMut.ID)+') '+
              VegBerendMut.VegBerendMutato.BerendezesNev+' bekapcsolása...';
      FormVezerlo.TextAttributes.Color:=clYellow;
      //üzenet elküldése
      FormVezerlo.AdatUzenetKuld(False,UzTomb,Szoveg,FormVezerlo.TextAttributes);
      SetLength(UzTomb,0);
    End;
  End;
End;

//kikapcsolás
Procedure TBerendInspector.Kapcsolo2Off(Sender: TObject);
Var Szoveg : String;
    UzTomb : TAdatUzenetTomb;
Begin
  If (VegBerendMut <> Nil) Then
  Begin
    //berendezés kikapcsolása
    VegBerendMut.Direkt:=False;
    If (UzLista <> Nil) Then
    Begin
      SetLength(UzTomb,2);
      UzTomb[0]:=VegBerendMut.ID;
      UzTomb[1]:=BoolToInt(False);
      Szoveg:=MemoIdo+'('+IntToStr(VegBerendMut.ID)+') '+
        VegBerendMut.VegBerendMutato.BerendezesNev+' kikapcsolása...';
      FormVezerlo.TextAttributes.Color:=clYellow;
      //üzenet elküldése
      FormVezerlo.AdatUzenetKuld(False,UzTomb,Szoveg,FormVezerlo.TextAttributes);
      SetLength(UzTomb,0);
    End;
  End;
End;

//kattintása a beállítás gombon
Procedure TBerendInspector.BeallitBtnClick(Sender: TObject);
Var RegiMut   : PHomeroElem;
    HomeroMut : PHomeroElem;
    UzTomb    : TAdatUzenetTomb;
Begin
  If (Mutato <> Nil) Then
  Begin
    //form megnyitása
    OsszLista_Dlg.HomeroBeallit(Mutato.BerendezesNev);
    //ha történt változtatás
    If OsszLista_Dlg.Homero.Valtozas Then
    Begin
      RegiMut:=OsszLista_Dlg.Homero.Aktualis;
      //az új értékek elküldése
      If OsszLista_Dlg.Homero.KeresID(Mutato.ID,HomeroMut) Then
      Begin
        OsszLista_Dlg.Homero.Aktualis:=HomeroMut;
        SetLength(UzTomb,4);
        UzTomb[0]:=OsszLista_Dlg.Homero.Aktualis.ID;
        UzTomb[1]:=OsszLista_Dlg.Homero.Aktualis.Min;
        UzTomb[2]:=OsszLista_Dlg.Homero.Aktualis.Max;
        UzTomb[3]:=OsszLista_Dlg.Homero.Aktualis.BeallErtek;
        FormVezerlo.TextAttributes.Color:=clBlack;
        //üzenet küldése
        FormVezerlo.AdatUzenetKuld(False,UzTomb,'('+IntToStr(OsszLista_Dlg.Homero.Aktualis.ID)+') '+
          OsszLista_Dlg.Homero.Aktualis.HomeroMutato.BerendezesNev+
          ' - beállítás elküldve.',FormVezerlo.TextAttributes);
        SetLength(UzTomb,0);
      End;
      OsszLista_Dlg.Homero.Aktualis:=RegiMut;
      //táblázat frissítése
      If FormVezerlo.Attekint Then FormVezerlo.AttekintGridFrissit;
    End;
  End;
End;

//form bezárása
Procedure TBerendInspector.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
  Self.Urit;
  FormVezerlo.BerendInsp:=False;
End;

//panel frissítése
Procedure TBerendInspector.Frissit;
Var ID : Integer;
Begin
  //ha vannak berendezések
  If (OsszLista_Dlg <> Nil) And (OsszLista_Dlg.BerendezesList <> Nil) Then
  Begin
    //megkeressük a kiválasztott berendezés azonosítóját
    ID:=OsszLista_Dlg.BerendezesList.KeresNev(BerendGrid.Cells[0,BerendGrid.Row]);
    //ha megvan a mutatója is
    If (ID > 0) And OsszLista_Dlg.BerendezesList.KeresID(ID,Mutato) Then
    Begin
      //berendezés típusa
      Case Mutato.BerendezesTip Of
        btHomero   : If (HomeroMut <> Nil) Then
                      Panel4.Caption:=IntToStr(HomeroMut.MertErtek)+sCelsius;
        btRiaszto  : If (RiasztoMut <> Nil) Then
                     Begin
                       If RiasztoMut.Allapot Then
                       Begin
                         Panel6.Font.Color:=clRed;
                         Panel6.Caption:='Riasztás';
                       End
                       Else Begin
                         Panel6.Font.Color:=clBlack;
                         Panel6.Caption:='Normál';
                       End;
                     End;
        btTuzjelzo : If (TuzjelzoMut <> Nil) Then
                     Begin
                       If TuzjelzoMut.Allapot Then
                       Begin
                         Panel6.Font.Color:=clRed;
                         Panel6.Caption:='Tûzjelzés';
                       End
                       Else Begin
                         Panel6.Font.Color:=clBlack;
                         Panel6.Caption:='Normál';
                       End;
                     End;
        btFutotest : If (VegBerendMut <> Nil) Then
                     Begin
                       Kapcsolo1.StateOn:=VegBerendMut.Automata;
                       Kapcsolo2.StateOn:=VegBerendMut.Direkt;
                     End;
        btEgyeb    : If (VegBerendMut <> Nil) Then
                     Begin
                       Kapcsolo1.StateOn:=VegBerendMut.Automata;
                       Kapcsolo2.StateOn:=VegBerendMut.Direkt;
                     End;
      End;
    End;
  End;
End;

//lista beállítása
Procedure TBerendInspector.SetUzLista(Ertek: TUzenetLista);
Begin
  Self.UzLista:=Ertek;
End;

//táblázat törlése
procedure TBerendInspector.Urit;
begin
  BerendGrid.RowCount:=0;
  BerendGrid.Cols[0].Clear;
end;

End.
