//új objektum nevének felvitele Dialog box
Unit ObjNevFormUnit;

Interface

Uses Classes, Controls, Forms, StdCtrls, Buttons, FormFestoUnit, ObjektumUnit;

Type
  TObjNevForm = Class(TForm)
    OKBtn     : TBitBtn;
    CancelBtn : TBitBtn;
    NevEdit   : TEdit;
    Label1    : TLabel;
    Procedure Set_ObjLista(Const ObjList: TObjektumLista);
    Procedure FormActivate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
    Procedure NevEditKeyPress(Sender: TObject; Var Key: Char);
    Procedure OKBtnClick(Sender: TObject);
  Private
    ObjLista : TObjektumLista;  //objektumok lánca
  End;

Var ObjNevForm : TObjNevForm;

Implementation

{$R *.DFM}

//ObjektumLista beállítása
Procedure TObjNevForm.Set_ObjLista(Const ObjList: TObjektumLista);
Begin
  Self.ObjLista:=ObjList;
End;

//a form aktívvá válik
Procedure TObjNevForm.FormActivate(Sender: TObject);
Begin
  RePaint;
End;

//form átfestése
Procedure TObjNevForm.FormPaint(Sender: TObject);
Var LabelArray : Array[1..1] Of TLabel;
Begin
  LabelArray[1]:=Label1;
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then
  Begin
    //beállítjuk a feliratok színét
    Label_Allit(ObjNevForm,LabelArray,True,AblakSzin.HatterSzin);
    //festõ meghívása
    FormFesto(ObjNevForm);
  End
  Else Label_Allit(ObjNevForm,LabelArray,False,AblakSzin.BetuSzin);
End;

//az edit-ben a billentyûesemények lekezelése
Procedure TObjNevForm.NevEditKeyPress(Sender: TObject; var Key: Char);
Var Hossz : Integer;
Begin
  Hossz:=Length(NevEdit.Text);
  //ha ENTER és van szöveg
  If ((Key = #13) And (Hossz > 0)) Then OKBtn.ModalResult:=mrOK;
  //ha ENTER és nincs szöveg
  If ((Key = #13) And (Hossz < 1)) Then ActiveControl:=NevEdit;
  //ha ESC
  If (Key = #27) Then CancelBtn.ModalResult:=mrCancel;
End;

//a rendben gomb eseménykezelõje
Procedure TObjNevForm.OKBtnClick(Sender: TObject);
Begin
  //ha már van ilyen nevû objektum
  If Self.ObjLista.Keres(NevEdit.Text) Then
  Begin
    NevEdit.Text:='';
    ModalResult:=mrNone;
    ActiveControl:=NevEdit;
  End;
End;

End.
