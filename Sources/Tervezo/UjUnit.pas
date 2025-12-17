//Új Dialog box
Unit UjUnit;

Interface

Uses Classes, Forms, Controls, StdCtrls, ExtCtrls, Buttons, FormFestoUnit;

Type
  TDlgUj = Class(TForm)
    Bevel1       : TBevel;
    Label1       : TLabel;
    Label2       : TLabel;
    BtnKilepes   : TBitBtn;
    BtnMegnyitas : TBitBtn;
    BtnUj        : TBitBtn;
    Procedure BtnUjClick(Sender: TObject);
    Procedure BtnKilepesClick(Sender: TObject);
    Procedure BtnMegnyitasClick(Sender: TObject);
    Procedure FormActivate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
  Private
    Procedure Indit(Param: Boolean);
  End;

Var DlgUj : TDlgUj;

Implementation

Uses TervezoUnit;

{$R *.DFM}

//a fõform indítási paramétere
Procedure TDlgUj.Indit(Param: Boolean);
Begin
  Self.Visible:=False;
  Self.Enabled:=False;
  //meghívjuk a fõformot az indítási paraméterrel
  FormTervezo.ShowModal(Param);
  Close;
End;

//új épület létrehozása
Procedure TDlgUj.BtnUjClick(Sender: TObject);
Begin
  Indit(True);
End;

//kilépés a programból
Procedure TDlgUj.BtnKilepesClick(Sender: TObject);
Begin
  Close;
End;

//épület megnyitása
Procedure TDlgUj.BtnMegnyitasClick(Sender: TObject);
Begin
  Indit(False);
End;

//form újra rajzolása
Procedure TDlgUj.FormActivate(Sender: TObject);
Begin
  RePaint;
End;

//újra rajzolás eseménye
Procedure TDlgUj.FormPaint(Sender: TObject);
Var LabelArray : Array[1..2] Of TLabel;
    BevelArray : Array[1..1] Of TBevel;
Begin
  LabelArray[1]:=Self.Label1;
  LabelArray[2]:=Self.Label2;
  BevelArray[1]:=Self.Bevel1;
  //ha az ablak színátmenetes
  If AblakSzin.SzinAtmenet Then
  Begin
    //beállítjuk a feliratok és keretek színét
    Label_Bevel_Allit(DlgUj,LabelArray,BevelArray,True,AblakSzin.HatterSzin,bsLowered);
    //festõ meghívása
    FormFesto(DlgUj);
  End
  Else Label_Bevel_Allit(DlgUj,LabelArray,BevelArray,False,AblakSzin.BetuSzin,bsRaised);
End;

End.
