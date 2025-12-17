//Monitor dialog box
Unit MonitorUnit;

Interface

Uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     StdCtrls, Buttons, ComCtrls, FormFestoUnit, EpuletLancUnit,
     ObjektumUnit, BerendezesekLancUnit;

Type
  TMonitorDlg = Class(TForm)
    TV      : TTreeView;
    BitBtn1 : TBitBtn;
    Label1  : TLabel;
    Function ShowModal(Const EpName: String; Const EpList: TEpuletLista;
      Const ObjList: TObjektumLista; Const BList: TBerendezesLista) : Integer; Reintroduce; Overload;
    Procedure FormPaint(Sender: TObject);
    Procedure FormActivate(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
  Private
    EpNev       : String;            //épület neve
    EpLista     : TEpuletLista;      //épület lánc
    ObjLista    : TObjektumLista;    //objektumok lánc
    BerendLista : TBerendezesLista;  //berendezések lánc
  End;

Var MonitorDlg : TMonitorDlg;

Implementation

{$R *.DFM}

//form átfestése
Procedure TMonitorDlg.FormPaint(Sender: TObject);
Var LabelArray : Array[1..1] Of TLabel;
Begin
  LabelArray[1]:=Label1;
  //ha kell a színátmenet
  If AblakSzin.SzinAtmenet Then
  Begin
    //beállítjuk a feliratok színét
    Label_Allit(MonitorDlg,LabelArray,True,AblakSzin.HatterSzin);
    //festõ meghívása
    FormFesto(MonitorDlg);
  End
  Else Label_Allit(MonitorDlg,LabelArray,False,AblakSzin.BetuSzin);
End;

//a form aktívvá válik
Procedure TMonitorDlg.FormActivate(Sender: TObject);
Var EpuletNode,
    EpEgysegNode,
    ObjNode,
    BerendNode   : TTreeNode;
    REpEgyseg    : PEpuletEgyseg;
    RObjLanc     : PObjektumLanc;
    RBerendLanc  : PLancElem;
    EgysNev      : String;
    ObjNev       : String;
    BerendTip    : String;
Begin
  RePaint;
  RObjLanc:=Nil;
  RBerendLanc:=Nil;
  REpEgyseg:=Self.EpLista.Aktualis;
  If (Self.ObjLista <> Nil) Then RObjLanc:=Self.ObjLista.Aktualis;
  If (Self.BerendLista <> Nil) Then RBerendLanc:=Self.BerendLista.Aktualis;
  Self.Label1.Caption:='A(z) '+EpNev+' épület felépítése';
  Self.TV.Font.Color:=clMaroon;
  Self.TV.Visible:=False;
  //fastruktúra felépítése
  With Self.TV.Items Do
  Begin
    Clear;
    EpuletNode:=Nil;
    EpLista.Aktualis:=EpLista.Elso;
    If (EpLista.Aktualis <> Nil) Then EpuletNode:=Add(Nil,EpNev+' épület');
    //végigmegyünk az épület láncon
    While (EpLista.Aktualis <> Nil) Do
    Begin
      EgysNev:=EpLista.Aktualis.EgysegNev;
      EpEgysegNode:=AddChild(EpuletNode,EgysNev+' épületegység');
      If (Self.ObjLista <> Nil) Then
      Begin
        ObjLista.Aktualis:=ObjLista.Elso;
        //végigmegyünk az objektumok láncán
        While (ObjLista.Aktualis <> Nil) Do
        Begin
          If (ObjLista.Aktualis.ObjMut.EpuletEgyseg.EgysegNev = EgysNev) Then
          Begin
            ObjNev:=ObjLista.Aktualis.ObjMut.Nev;
            ObjNode:=AddChild(EpEgysegNode,ObjNev+' objektum');
            If (Self.BerendLista <> Nil) Then
            Begin
              BerendLista.Aktualis:=BerendLista.Elso;
              //végigmegyünk a berendezések láncán
              While (BerendLista.Aktualis <> Nil) Do
              Begin
                If (BerendLista.Aktualis.ObjektumNev = ObjNev) Then
                Begin
                  BerendNode:=AddChild(ObjNode,BerendLista.Aktualis.BerendezesNev+' nevû berendezés');
                  AddChild(BerendNode,'Azonosító : '+IntToStr(BerendLista.Aktualis.ID));
                  Case BerendLista.Aktualis.BerendezesTip Of
                    btHomero   : BerendTip:=sHomero;
                    btRiaszto  : BerendTip:=sRiaszto;
                    btTuzjelzo : BerendTip:=sTuzjelzo;
                    btFutotest : BerendTip:=sFutotest;
                    btEgyeb    : BerendTip:=sEgyeb;
                    Else BerendTip:='Ismeretlen';
                  End;
                  AddChild(BerendNode,'Típusa : '+BerendTip);
                End;
                BerendLista.Aktualis:=BerendLista.Aktualis.Kovetkezo;
              End;
            End;
          End;
          ObjLista.Aktualis:=ObjLista.Aktualis.Kovetkezo;
        End;
      End;
      EpLista.Aktualis:=EpLista.Aktualis.Kovetkezo;
    End;
  End;
  Self.TV.Visible:=True;
  //visszaállítjuk a mutatókat
  Self.EpLista.Aktualis:=REpEgyseg;
  If (Self.ObjLista <> Nil) Then Self.ObjLista.Aktualis:=RObjLanc;
  If (Self.BerendLista <> Nil) Then Self.BerendLista.Aktualis:=RBerendLanc;
End;

//form létrehozása
Procedure TMonitorDlg.FormCreate(Sender: TObject);
Begin
  TV.Items.Clear;
End;

//form megjelenítése
Function TMonitorDlg.ShowModal(Const EpName: String; Const EpList: TEpuletLista;
         Const ObjList: TObjektumLista; Const BList: TBerendezesLista): Integer;
Begin
  Self.EpNev:=EpName;
  Self.EpLista:=EpList;
  Self.ObjLista:=ObjList;
  Self.BerendLista:=BList;
  Result:=Inherited ShowModal;
End;

End.
