Unit ObjektumokDlgUnit;

Interface

Uses Classes, Forms, Controls, StdCtrls, Buttons, ExtCtrls, Graphics,
     FormFestoUnit, ObjektumUnit, EpuletLancUnit, ZoomUnit;

Type
  TObjektumokDlg = Class(TForm)
    TorlesBtn: TBitBtn;
    BezarBtn   : TBitBtn;
    ObjListBox : TListBox;
    Function ShowModal(Const ObjList: TObjektumLista;
      Const EpEgys: PEpuletEgyseg) : Integer; Reintroduce; Overload;
    Procedure FormActivate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
    Procedure BezarBtnClick(Sender: TObject);
    Procedure TorlesBtnClick(Sender: TObject);
  Private
    ObjLista : TObjektumLista;
    EpEgyseg : PEpuletEgyseg;
    Function SelText(List: TListBox) : String;
  End;

Var ObjektumokDlg : TObjektumokDlg;

Implementation

Uses TervezoUnit;

{$R *.DFM}

//form megjelenítése
Function TObjektumokDlg.ShowModal(Const ObjList : TObjektumLista;
          Const EpEgys: PEpuletEgyseg) : Integer;
Begin
  Self.EpEgyseg:=EpEgys;
  Self.ObjLista:=ObjList;
  Result:=Inherited ShowModal;
End;

//a form aktívvá válik
Procedure TObjektumokDlg.FormActivate(Sender: TObject);
Begin
  RePaint;
End;

//form átfestése
Procedure TObjektumokDlg.FormPaint(Sender: TObject);
Begin
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then FormFesto(ObjektumokDlg);
End;

//form bezárása
Procedure TObjektumokDlg.BezarBtnClick(Sender: TObject);
Begin
  ModalResult:=mrCancel;
End;

//objektum törlése a listából
Procedure TObjektumokDlg.TorlesBtnClick(Sender: TObject);
Var Nev        : String;   //melyiket töröljük
    UjraRajzol : Boolean;  //kell-e frissíteni a rajzot
Begin
  UjraRajzol:=False;
  Nev:=SelText(ObjListBox);
  If (Nev <> '') Then
  Begin
    //ha sikerült törölni, akkor újra is kell rajzolni
    UjraRajzol:=ObjLista.KeresAndTorol(Nev);
    //újra feltöltjük a ListBox-ot
    ObjListBox.Items.Clear;
    With ObjLista Do
    Begin
      Aktualis:=Elso;
      While (Aktualis <> Nil) Do
      Begin
        If (Aktualis.ObjMut.EpuletEgyseg = EpEgyseg) Then Self.ObjListBox.Items.Add(Aktualis.ObjMut.Nev);
        Aktualis:=Aktualis.Kovetkezo;
      End;
    End;
    Self.ObjListBox.ItemIndex:=0;
  End;
  ModalResult:=mrNone;
  //ha frissíteni kell a rajzot
  If UjraRajzol Then FormTervezo.AsztalUjraRajzol(clSilver);
  //kirajzoljuk az objektumokat is
  If (ObjLista.Elso <> Nil) Then ObjLista.KiRajzol(FormTervezo,FormTervezo.Image1,Zoom.Szorzo);
End;

//visszaadja a ListBox aktuális elemét
Function TObjektumokDlg.SelText(List: TListBox): String;
Var nItem : Integer;
Begin
  nItem:=List.ItemIndex;
  //ha nem üres a lista
  If (nItem >= 0) Then Result:=List.Items[nItem]
  Else Result:='';
End;

End.
