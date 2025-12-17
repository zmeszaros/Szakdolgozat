//A berendezéseket megjelenítõ dilog box
Unit BerendDlgUnit;

Interface

Uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     StdCtrls, Buttons, Grids, FormFestoUnit, BerendezesekLancUnit, DlgUnit,
     HomeroLancUnit, VegBerendLancUnit, KuldThreadUnit;

Type
  TBerendezesDlg = Class(TForm)
    Label1         : TLabel;
    BezarBtn       : TBitBtn;
    BerendezesGrid : TStringGrid;
    Function ShowModal(OLD: TOsszesLista_Dlg) : Integer; Reintroduce; Overload;
    Procedure FormActivate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
    Procedure BezarBtnClick(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure BerendezesGridDblClick(Sender: TObject);
  Private
    HomeroMut     : PHomeroElem;       //hõmérõre mutató pointer
    VegBerendMut  : PVegBerendElem;    //végberendezésre mutató pointer
    OsszLista_Dlg : TOsszesLista_Dlg;  //a listákat tartalmazó típus
    Procedure GridFeltolt;
    Procedure GridEloKeszit;
  End;

Var BerendezesDlg : TBerendezesDlg;

Implementation

Uses VezerloUnit, KodolasUnit;

{$R *.DFM}

//a form megjelenítése
Function TBerendezesDlg.ShowModal(OLD: TOsszesLista_Dlg) : Integer;
Begin
  Self.OsszLista_Dlg:=OLD;
  //táblázat feltöltése
  Self.GridFeltolt;
  Result:=Inherited ShowModal;
End;

//a form aktívvá válik
Procedure TBerendezesDlg.FormActivate(Sender: TObject);
Begin
  RePaint;
End;

//form átfestése
Procedure TBerendezesDlg.FormPaint(Sender: TObject);
Var LabelArray : Array[1..1] Of TLabel;
Begin
  LabelArray[1]:=Label1;
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then
  Begin
    //beállítjuk a feliratok színét
    Label_Allit(BerendezesDlg,LabelArray,True,AblakSzin.HatterSzin);
    //festõ meghívása
    FormFesto(BerendezesDlg);
  End
  Else Label_Allit(BerendezesDlg,LabelArray,False,AblakSzin.BetuSzin);
End;

//kattintás a Kilépés gombra
Procedure TBerendezesDlg.BezarBtnClick(Sender: TObject);
Begin
  ModalResult:=mrCancel;
End;

//táblázat elõkészítése
Procedure TBerendezesDlg.GridEloKeszit;
Begin
  BerendezesGrid.FixedRows:=0;
  BerendezesGrid.RowCount:=1;
  BerendezesGrid.RowCount:=2;
  BerendezesGrid.FixedRows:=1;
  BerendezesGrid.Cols[0].Text:='ID';
  BerendezesGrid.Cols[1].Text:='Berendezés neve';
  BerendezesGrid.Cols[2].Text:='Típusa';
  BerendezesGrid.Cols[3].Text:='Épületegység neve';
  BerendezesGrid.Cols[4].Text:='Objektum neve';
End;

//a form létrehozása
Procedure TBerendezesDlg.FormCreate(Sender: TObject);
Begin
  GridEloKeszit;
End;

//táblázat feltöltése
Procedure TBerendezesDlg.GridFeltolt;
Var I,J : Integer;
Begin
  GridEloKeszit;
  //a berendezések felvétele a táblázatba
  For I:=0 To High(OsszLista_Dlg.BerendezesList.BerendTomb) Do
  Begin
    BerendezesGrid.RowCount:=i+2;
    For J:=1 To High(OsszLista_Dlg.BerendezesList.BerendTomb[i]) Do
      BerendezesGrid.Cells[j-1,i+1]:=OsszLista_Dlg.BerendezesList.BerendTomb[i,j];
  End;
End;

//duplakattintás a táblázaton
Procedure TBerendezesDlg.BerendezesGridDblClick(Sender: TObject);
Var ID     : Integer;
    Szoveg : String;
    Mutato : PLancElem;
    UzTomb : TAdatUzenetTomb;
Begin
  //azonosító lekérdezése
  Try
    ID:=StrToInt(BerendezesGrid.Cells[0,BerendezesGrid.Row]);
  Except
    On EConvertError Do ID:=0;
  End;
  //azonosító keresése
  If OsszLista_Dlg.BerendezesList.KeresID(ID,Mutato) Then
  Begin
    Self.Visible:=False;
    //berendezés típusa
    Case Mutato.BerendezesTip Of
      btHomero   : Begin
                     //adatok módosítása
                     OsszLista_Dlg.HomeroBeallit(Mutato.BerendezesNev);
                     If OsszLista_Dlg.Homero.Valtozas Then
                     Begin
                       If OsszLista_Dlg.Homero.KeresID(Mutato.ID,HomeroMut) Then
                       Begin
                         OsszLista_Dlg.Homero.Aktualis:=HomeroMut;
                         SetLength(UzTomb,4);
                         UzTomb[0]:=OsszLista_Dlg.Homero.Aktualis.ID;
                         UzTomb[1]:=OsszLista_Dlg.Homero.Aktualis.Min;
                         UzTomb[2]:=OsszLista_Dlg.Homero.Aktualis.Max;
                         UzTomb[3]:=OsszLista_Dlg.Homero.Aktualis.BeallErtek;
                         FormVezerlo.TextAttributes.Color:=clBlack;
                         //üzenet küldése a módosításról
                         FormVezerlo.AdatUzenetKuld(False,UzTomb,'('+
                           IntToStr(OsszLista_Dlg.Homero.Aktualis.ID)+') '+
                           OsszLista_Dlg.Homero.Aktualis.HomeroMutato.BerendezesNev+
                           ' - beállítás elküldve.',FormVezerlo.TextAttributes);
                         SetLength(UzTomb,0);
                       End;
                       //táblázat frissítése
                       If FormVezerlo.Attekint Then FormVezerlo.AttekintGridFrissit;
                     End;
                   End;
      btRiaszto  : OsszLista_Dlg.RiasztoBeallit(Mutato.BerendezesNev);
      btTuzjelzo : OsszLista_Dlg.TuzjelzoBeallit(Mutato.BerendezesNev);
      btFutotest : Begin
                     //adatok módosítása
                     OsszLista_Dlg.FutotestBeallit(Mutato.BerendezesNev);
                     If OsszLista_Dlg.VegBerendezes.Valtozas Then
                     Begin
                       If OsszLista_Dlg.VegBerendezes.KeresID(Mutato.ID,VegBerendMut) Then
                       Begin
                         If (Not VegBerendMut.Automata) Then
                         Begin
                           OsszLista_Dlg.VegBerendezes.Aktualis:=VegBerendMut;
                           SetLength(UzTomb,2);
                           UzTomb[0]:=VegBerendMut.ID;
                           UzTomb[1]:=BoolToInt(VegBerendMut.Direkt);
                           If VegBerendMut.Direkt Then
                             Szoveg:=MemoIdo+'('+IntToStr(VegBerendMut.ID)+') '+
                               VegBerendMut.VegBerendMutato.BerendezesNev+
                               ' bekapcsolása...'
                           Else
                             Szoveg:=MemoIdo+'('+IntToStr(VegBerendMut.ID)+') '+
                               VegBerendMut.VegBerendMutato.BerendezesNev+
                               ' Kikapcsolása...';
                           FormVezerlo.TextAttributes.Color:=clYellow;
                           //üzenet küldése a módosításról
                           FormVezerlo.AdatUzenetKuld(False,UzTomb, Szoveg,
                             FormVezerlo.TextAttributes);
                           SetLength(UzTomb,0);
                         End;
                       End;
                       //táblázat frissítése
                       If FormVezerlo.Attekint Then FormVezerlo.AttekintGridFrissit;
                     End;
                   End;
      btEgyeb    : Begin
                     //adatok módosítása
                     OsszLista_Dlg.EgyebBeallit(Mutato.BerendezesNev);
                     If OsszLista_Dlg.VegBerendezes.Valtozas Then
                     Begin
                       If OsszLista_Dlg.VegBerendezes.KeresID(Mutato.ID,VegBerendMut) Then
                       Begin
                         If (Not VegBerendMut.Automata) Then
                         Begin
                           OsszLista_Dlg.VegBerendezes.Aktualis:=VegBerendMut;
                           SetLength(UzTomb,2);
                           UzTomb[0]:=VegBerendMut.ID;
                           UzTomb[1]:=BoolToInt(VegBerendMut.Direkt);
                           If VegBerendMut.Direkt Then
                             Szoveg:=MemoIdo+'('+IntToStr(VegBerendMut.ID)+') '+
                               VegBerendMut.VegBerendMutato.BerendezesNev+
                               ' bekapcsolása...'
                           Else
                             Szoveg:=MemoIdo+'('+IntToStr(VegBerendMut.ID)+') '+
                               VegBerendMut.VegBerendMutato.BerendezesNev+
                               ' Kikapcsolása...';
                           FormVezerlo.TextAttributes.Color:=clYellow;
                           //üzenet küldése a módosításról
                           FormVezerlo.AdatUzenetKuld(False,UzTomb, Szoveg,
                             FormVezerlo.TextAttributes);
                           SetLength(UzTomb,0);
                         End;
                       End;
                       //táblázat frissítése
                       If FormVezerlo.Attekint Then FormVezerlo.AttekintGridFrissit;
                     End;
                   End;
    End;
    Self.Visible:=True;
  End;
End;

End.
