//Objektumok listája dialog box
Unit ObjListaUnit;

Interface

Uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, FormFestoUnit, ObjektumUnit, BerendezesekLancUnit;

Type
  TObjListaDlg = Class(TForm)
    Label1       : TLabel;
    TorlesBtn    : TBitBtn;
    BezarBtn     : TBitBtn;
    ObjektumGrid : TStringGrid;
    Function ShowModal(Const OList: TObjektumLista;
      Const BList: TBerendezesLista) : Integer; Reintroduce; Overload;
    Procedure FormActivate(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
    Procedure BezarBtnClick(Sender: TObject);
    Procedure TorlesBtnClick(Sender: TObject);
  Private
    ObjLista    : TObjektumLista;     //objektumok listája
    BerendLista : TBerendezesLista;   //berendezések listája
    Procedure GridFeltolt;
    Procedure GridEloKeszit;
    Procedure BerendLancFrissit(Torolt: String);
  End;

Var ObjListaDlg : TObjListaDlg;

Implementation

{$R *.DFM}

//a form aktívvá válik
Procedure TObjListaDlg.FormActivate(Sender: TObject);
Begin
  RePaint;
End;

//form létrehozása
Procedure TObjListaDlg.FormCreate(Sender: TObject);
Begin
  GridEloKeszit;
End;

//form átfestése
Procedure TObjListaDlg.FormPaint(Sender: TObject);
Var LabelArray : Array[1..1] Of TLabel;
Begin
  LabelArray[1]:=Label1;
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then
  Begin
    //festõ meghívása
    FormFesto(ObjListaDlg);
    //beállítjuk a feliratok színét
    Label_Allit(ObjListaDlg,LabelArray,True,AblakSzin.HatterSzin);
  End
  Else Label_Allit(ObjListaDlg,LabelArray,False,AblakSzin.BetuSzin);
End;

//törlés gomb eseménykezelõje
Procedure TObjListaDlg.TorlesBtnClick(Sender: TObject);
Var TorlendoElem : String;
Begin
  TorlendoElem:=ObjektumGrid.Cells[0,ObjektumGrid.Row];
  //ha megtaláltuk és sikerült törölni
  If ObjLista.KeresAndTorol(TorlendoElem) Then
  Begin
    //tömb újra elkészítése
    ObjLista.TombFeltolt(Self.BerendLista);
    //táblázat kitöltése
    GridFeltolt;
    //törlés utáni aktualizálás
    BerendLancFrissit(TorlendoElem);
  End;
  ModalResult:=mrNone;
End;

//objektum törlése utáni aktualizálás
Procedure TObjListaDlg.BerendLancFrissit(Torolt: String);
Var RegiHely : PLancElem;
Begin
  //ha a BerendLista lánc létezik és nem üres
  If (BerendLista <> Nil) And (BerendLista.Elso <> Nil) Then
  Begin
    RegiHely:=BerendLista.Aktualis;
    BerendLista.Aktualis:=BerendLista.Elso;
    //végigmegyünk az BerendLista láncon
    While (BerendLista.Aktualis <> Nil) Do
    Begin
      If (BerendLista.Aktualis.ObjektumNev = Torolt) Then
        BerendLista.Aktualis.ObjektumNev:='Egyikhez sem';
      BerendLista.Aktualis:=BerendLista.Aktualis.Kovetkezo;
    End;
    BerendLista.Aktualis:=RegiHely;
  End;
End;

//bezárás gomb eseménykezelõje
Procedure TObjListaDlg.BezarBtnClick(Sender: TObject);
Begin
  ModalResult:=mrCancel;
End;

//táblázat elõkészítése
Procedure TObjListaDlg.GridEloKeszit;
Begin
  ObjektumGrid.FixedRows:=0;
  ObjektumGrid.RowCount:=1;
  ObjektumGrid.RowCount:=2;
  ObjektumGrid.FixedRows:=1;
  ObjektumGrid.Cols[0].Text:='Objektum neve';
  ObjektumGrid.Cols[1].Text:='Épületegység neve';
  ObjektumGrid.Cols[2].Text:='Berendezések száma';
End;

//form megjelenítése
Function TObjListaDlg.ShowModal(Const OList: TObjektumLista;
         Const BList: TBerendezesLista): Integer;
Begin
  Self.ObjLista:=OList;
  Self.BerendLista:=BList;
  Self.GridFeltolt;
  Result:=Inherited ShowModal;
End;

//táblázat feltöltése
Procedure TObjListaDlg.GridFeltolt;
Var I,J : Integer;
Begin
  //táblázat elõkészítése
  GridEloKeszit;
  //végigmegyünk az objektumok tömbjén
  For I:=0 To High(ObjLista.ObjTomb) Do
  Begin
    ObjektumGrid.RowCount:=i+2;
    //kitöltjük a cellákat
    For J:=1 To High(ObjLista.ObjTomb[i]) Do
      ObjektumGrid.Cells[j-1,i+1]:=ObjLista.ObjTomb[i,j];
  End;
End;

End.
