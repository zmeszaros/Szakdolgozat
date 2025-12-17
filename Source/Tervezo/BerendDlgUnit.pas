//Berendezések dialog box
Unit BerendDlgUnit;

Interface

Uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     StdCtrls, Buttons, Grids, FormFestoUnit, BerendezesekLancUnit;

Type
  TBerendezesDlg = Class(TForm)
    Label1         : TLabel;
    TorlesBtn      : TBitBtn;
    BezarBtn       : TBitBtn;
    BerendezesGrid : TStringGrid;
    Function ShowModal(Const BList: TBerendezesLista) : Integer; Reintroduce; Overload;
    Procedure FormActivate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
    Procedure BezarBtnClick(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure TorlesBtnClick(Sender: TObject);
  Private
    BerendLista : TBerendezesLista;  //berendezések listája
    Procedure GridFeltolt;
    Procedure GridEloKeszit;
  End;

Var BerendezesDlg : TBerendezesDlg;

Implementation

{$R *.DFM}

//form megjelenítése
Function TBerendezesDlg.ShowModal(Const BList: TBerendezesLista) : Integer;
Begin
  //a berendezések lista átadása
  Self.BerendLista:=BList;
  //táblázat kitöltése
  Self.GridFeltolt;
  //õs fv meghívása
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
    //festõ meghívása
    FormFesto(BerendezesDlg);
    //beállítjuk a feliratok színét
    Label_Allit(BerendezesDlg,LabelArray,True,AblakSzin.HatterSzin);
  End
  Else Label_Allit(BerendezesDlg,LabelArray,False,AblakSzin.BetuSzin);
End;

//bezárás és kilépés
Procedure TBerendezesDlg.BezarBtnClick(Sender: TObject);
Begin
  ModalResult:=mrCancel;
End;

//táblázat fejlécének és méretének beállítása
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

//form létrehozása
Procedure TBerendezesDlg.FormCreate(Sender: TObject);
Begin
  //táblázat beállítása
  GridEloKeszit;
End;

//törlés esetén
Procedure TBerendezesDlg.TorlesBtnClick(Sender: TObject);
Var ID : Integer;
Begin
  Try
    //kinyerjük a berendezés azonosítóját
    ID:=StrToInt(BerendezesGrid.Cells[0,BerendezesGrid.Row]);
  Except
    On EConvertError Do ID:=0;
  End;
  //rákeresünk és töröljük
  If BerendLista.KeresAndTorol(ID) Then
  Begin
    //aktualizáljuk a berendezéseket tartalmazó tömböt
    BerendLista.TombFeltolt;
    //táblázat kitöltése
    GridFeltolt;
  End;
  ModalResult:=mrNone;
End;

//táblázat kitöltése
Procedure TBerendezesDlg.GridFeltolt;
Var I,J : Integer;
Begin
  //táblázat beállítása
  GridEloKeszit;
  //végigmegyünk a berendezéseken
  For I:=0 To High(BerendLista.BerendTomb) Do
  Begin
    BerendezesGrid.RowCount:=i+2;
    //feltöltjük a cellákat
    For J:=1 To High(BerendLista.BerendTomb[i]) Do
      BerendezesGrid.Cells[j-1,i+1]:=BerendLista.BerendTomb[i,j];
  End;
End;

End.
