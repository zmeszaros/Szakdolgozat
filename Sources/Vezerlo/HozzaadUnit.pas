//Berendezések mozgatása két lista között
Unit HozzaadUnit;

Interface

Uses Windows, Messages, SysUtils, Graphics, Classes, StdCtrls, Controls,
     Forms, Dialogs, Buttons, FormFestoUnit, BerendezesekLancUnit;

Type
  PCelElem  = ^TCelElem;
  PCelLanc  = ^TCelLanc;
  TCelLista = Class;

  //a Cél lánc eleme
  TCelElem = Object
    Mutato    : PLancElem;
    Kovetkezo : PCelElem;
    Procedure Init(CL: TCelLista; LancElem: PLancElem);
  End;

  //a Cél lánc fejeleme
  TCelLanc = Object
    Elso     : PCelElem;
    Aktualis : PCelElem;
    Procedure Init(CL: TCelLista);
  End;

  //a Cél láncot tartalmazó típus
  TCelLista = Class(TPersistent)
  Private
    CelElem     : PCelElem;           //elemre mutató pointer
    CelLanc     : TCelLanc;           //láncra mutató pointer
    BerendLista : TBerendezesLista;   //berendezések láncára mutató pointer
    Procedure Vegere;
  Public
    Property Elso : PCelElem Read CelLanc.Elso Write CelLanc.Elso;
    Property Aktualis : PCelElem Read CelLanc.Aktualis Write CelLanc.Aktualis;
    Function TombFeltolt : TMutatoArray;
    Function Torles(Mut: PCelElem) : Boolean;
    Function KeresAndTorol(Const Azon: Integer) : Boolean;
    Function KeresID(Const Azon: Integer; Var Mut: PCelElem): Boolean;
    Procedure Felfuz(Const LancElem: PLancElem);
    Constructor Create(Const BL: TBerendezesLista); Virtual;
    Destructor Destroy; Override;
  End;

  THozzaadListDlg = Class(TForm)
    OKBtn      : TButton;
    CancelBtn  : TButton;
    SrcList    : TListBox;
    DstList    : TListBox;
    Label1     : TLabel;
    Label2     : TLabel;
    IncludeBtn : TSpeedButton;
    IncAllBtn  : TSpeedButton;
    ExcludeBtn : TSpeedButton;
    ExAllBtn   : TSpeedButton;
    Function ShowModal(Const BList: TBerendezesLista;
             Const LBox : TStrings) : Integer; Reintroduce; Overload;
    Procedure IncludeBtnClick(Sender: TObject);
    Procedure ExcludeBtnClick(Sender: TObject);
    Procedure IncAllBtnClick(Sender: TObject);
    Procedure ExcAllBtnClick(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
    Procedure FormActivate(Sender: TObject);
    Procedure OKBtnClick(Sender: TObject);
    Procedure CancelBtnClick(Sender: TObject);
  Private
    Valt        : Boolean;              //volt-e változás
    FLista      : TStrings;
    ListBox     : TStrings;
    CelLista    : TCelLista;            //Cél lista
    MutatoArray : TMutatoArray;         //pointereket tartalmazó tömb
    BerendList  : TBerendezesLista;     //berendezéseket tartalmazó típus
    AzonTomb    : Array Of Array[1..2] Of String;
    Function KeresNev(Szoveg: String) : Integer;
    Function GetFirstSelection(List: TCustomListBox): Integer;
    Procedure MoveSelected(List: TCustomListBox; Items: TStrings);
    Procedure SetItem(List: TListBox; Index: Integer);
    Procedure SetButtons;
  Public
    Property Lista : TStrings Read FLista;
    Property Valtozas : Boolean Read Valt;
    Property MutatoTomb : TMutatoArray Read MutatoArray Write MutatoArray;
  End;

Var HozzaadListDlg : THozzaadListDlg;

Implementation

{$R *.DFM}

//láncelem létrehozása
Procedure TCelElem.Init(CL: TCelLista; LancElem: PLancElem);
Begin
  With CL Do
  Begin
    New(CelElem);
    CelElem.Mutato:=LancElem;
    CelElem.Kovetkezo:=Nil;
  End;
End;

//fejelem létrehozása
Procedure TCelLanc.Init(CL: TCelLista);
Begin
  With CL Do
  Begin
    New(PCelLanc);
    CelLanc.Elso:=Nil;
    CelLanc.Aktualis:=Nil;
  End;
End;

//Cél típus létrehozása
Constructor TCelLista.Create(Const BL: TBerendezesLista);
Begin
  Inherited Create;
  Self.CelElem:=Nil;
  Self.CelLanc.Init(Self);
  Self.BerendLista:=BL;
End;

//Cél típus felszabadítása
Destructor TCelLista.Destroy;
Begin
  Self.Aktualis:=Self.Elso;
  //végigmegy a láncon
  While (Self.Elso <> Nil) Do
  Begin
    Self.Elso:=Self.Aktualis.Kovetkezo;
    //aktuális elem felszabadítása
    Dispose(Self.Aktualis);
    Self.Aktualis:=Self.Elso;
  End;
  Inherited;
End;

//mutatók tömbjének feltöltése
Function TCelLista.TombFeltolt : TMutatoArray;
Var I : Integer;
Begin
  I:=0;
  SetLength(Result,I);
  //ha nem üres a lánc
  If (Self.Elso <> Nil) Then
  Begin
    Self.Aktualis:=Self.Elso;
  //végigmegy a láncon
    While (Self.Aktualis <> Nil) Do
    Begin
      Inc(I);
      //tömb méretének beállítása
      SetLength(Result,I);
      //mutató felvétele a tömbbe
      Result[I-1]:=Self.Aktualis.Mutato;
      Self.Aktualis:=Self.Aktualis.Kovetkezo;
    End;
  End;
End;

//törlés a láncból
//ha sikerült törölni -> True, különben -> False
Function TCelLista.Torles(Mut: PCelElem): Boolean;
Var UjMut : PCelElem;
Begin
  Result:=False;
  //ha van mit törölni
  If (Mut <> Nil) Then
  Begin
    //ha az elsõ elem
    If (Mut = Self.Elso) Then
    Begin
      Result:=True;
      Self.Aktualis:=Self.Elso.Kovetkezo;
      Dispose(Self.Elso);
      Self.Elso:=Self.Aktualis;
    End
    //különben
    Else Begin
      Self.Aktualis:=Self.Elso;
      While (Self.Aktualis.Kovetkezo <> Mut) And (Self.Aktualis.Kovetkezo <> Nil) Do
        Self.Aktualis:=Self.Aktualis.Kovetkezo;
      If (Self.Aktualis.Kovetkezo = Mut) Then
      Begin
        Result:=True;
        UjMut:=Self.Aktualis.Kovetkezo.Kovetkezo;
        Dispose(Self.Aktualis.Kovetkezo);
        Self.Aktualis.Kovetkezo:=UjMut;
      End;
    End;
  End;
End;

//azonosító keresése
//ha megvan -> True, különben -> False
Function TCelLista.KeresID(Const Azon: Integer; Var Mut: PCelElem): Boolean;
Var RegiAktualis : PCelElem;
Begin
  Mut:=Nil;
  Result:=False;
  If (Self.Elso <> Nil) Then
  Begin
    RegiAktualis:=Self.Aktualis;
    Self.Aktualis:=Self.Elso;
    While (Self.Aktualis <> Nil) And (Result = False) Do
    Begin
      If (Self.Aktualis.Mutato.ID = Azon) Then
      Begin
        Result:=True;
        Mut:=Self.Aktualis;
      End;
      Self.Aktualis:=Self.Aktualis.Kovetkezo;
    End;
    Self.Aktualis:=RegiAktualis;
  End;
End;

//azonosító keresése és törlése
//ha sikerült -> True, különben -> False
Function TCelLista.KeresAndTorol(Const Azon: Integer): Boolean;
Var Mut : PCelElem;
Begin
  Result:=False;
  If Self.KeresID(Azon,Mut) Then Result:=Self.Torles(Mut);
End;

//ugrás a lánc végére
Procedure TCelLista.Vegere;
Begin
  If (Self.Elso <> Nil) And (Self.Aktualis.Kovetkezo <> Nil) Then
  Begin
    Self.Aktualis:=Self.Elso;
    While (Self.Aktualis.Kovetkezo <> Nil) Do Self.Aktualis:=Self.Aktualis.Kovetkezo;
  End;
End;

//elem felfûzése a láncra
Procedure TCelLista.Felfuz(Const LancElem: PLancElem);
Begin
  Self.Vegere;
  CelElem.Init(Self,LancElem);
  If (Self.Elso = Nil) Then Self.Elso:=CelElem
    Else Self.Aktualis.Kovetkezo:=CelElem;
  Self.Aktualis:=CelElem;
End;

//form megjelenítése
Function THozzaadListDlg.ShowModal(Const BList: TBerendezesLista;
         Const LBox : TStrings): Integer;
Begin
  Self.BerendList:=BList;
  Self.ListBox:=TStringList.Create;
  Self.ListBox:=LBox;
  SetLength(Self.AzonTomb,0);
  SetLength(Self.MutatoArray,0);
  Result:=Inherited ShowModal;
End;

//berendezés keresése név alapján
//ha megvan -> azonosító, különben -> 0
Function THozzaadListDlg.KeresNev(Szoveg: String): Integer;
Var I : Integer;
Begin
  Result:=0;
  For I:=0 To High(AzonTomb) Do
    If (Szoveg = AzonTomb[I,2]) Then
    Begin
      Result:=StrToInt(AzonTomb[I,1]);
      Exit;
    End;
End;

//berendezés hozzáadása a listához
Procedure THozzaadListDlg.IncludeBtnClick(Sender: TObject);
Var Index    : Integer;
    BerendID : Integer;
    Mutato   : PLancElem;
Begin
  Index:=GetFirstSelection(SrcList);
  If (Index <> LB_ERR) Then
  Begin
    Self.Valt:=True;
    BerendID:=KeresNev(SrcList.Items[Index]);
    If BerendList.KeresID(BerendID,Mutato) Then CelLista.Felfuz(Mutato);
  End;
  MoveSelected(SrcList,DstList.Items);
  SetItem(SrcList,Index);
End;

//berendezés elvétele a listából
Procedure THozzaadListDlg.ExcludeBtnClick(Sender: TObject);
Var Index    : Integer;
    BerendID : Integer;
Begin
  Index:=GetFirstSelection(DstList);
  If (Index <> LB_ERR) Then
  Begin
    Self.Valt:=True;
    BerendID:=KeresNev(DstList.Items[Index]);
    CelLista.KeresAndTorol(BerendID);
  End;
  MoveSelected(DstList,SrcList.Items);
  SetItem(DstList,Index);
End;

//összes berendezés hozzáadása a listához
Procedure THozzaadListDlg.IncAllBtnClick(Sender: TObject);
Var I        : Integer;
    BerendID : Integer;
    Mutato   : PLancElem;
Begin
  For I:=0 To SrcList.Items.Count-1 Do
  Begin
    Self.Valt:=True;
    BerendID:=KeresNev(SrcList.Items[I]);
    If BerendList.KeresID(BerendID,Mutato) Then CelLista.Felfuz(Mutato);
    DstList.Items.AddObject(SrcList.Items[I],SrcList.Items.Objects[I]);
  End;
  SrcList.Items.Clear;
  SetItem(SrcList,0);
End;

//összes berendezés elvétele a listából
Procedure THozzaadListDlg.ExcAllBtnClick(Sender: TObject);
Var I        : Integer;
    BerendID : Integer;
Begin
  For I:=0 To DstList.Items.Count-1 Do
  Begin
    Self.Valt:=True;
    BerendID:=KeresNev(DstList.Items[I]);
    CelLista.KeresAndTorol(BerendID);
    SrcList.Items.AddObject(DstList.Items[I],DstList.Items.Objects[I]);
  End;
  DstList.Items.Clear;
  SetItem(DstList,0);
End;

//kiválasztott elem mozgatása a listák között
Procedure THozzaadListDlg.MoveSelected(List: TCustomListBox; Items: TStrings);
Var I : Integer;
Begin
  For I:=List.Items.Count-1 DownTo 0 Do
    If List.Selected[I] Then
    Begin
      Items.AddObject(List.Items[I],List.Items.Objects[I]);
      List.Items.Delete(I);
    End;
End;

//gombok beállítása
Procedure THozzaadListDlg.SetButtons;
Var SrcEmpty,DstEmpty : Boolean;
Begin
  SrcEmpty:=SrcList.Items.Count=0;
  DstEmpty:=DstList.Items.Count=0;
  IncludeBtn.Enabled:=Not SrcEmpty;
  IncAllBtn.Enabled:=Not SrcEmpty;
  ExcludeBtn.Enabled:=Not DstEmpty;
  ExAllBtn.Enabled:=Not DstEmpty;
End;

//a kiválasztott elem index-e
Function THozzaadListDlg.GetFirstSelection(List: TCustomListBox): Integer;
Begin
  For Result:=0 To List.Items.Count-1 Do
    If List.Selected[Result] Then Exit;
  Result:=LB_ERR;
End;

//elem beállítása
Procedure THozzaadListDlg.SetItem(List: TListBox; Index: Integer);
Var MaxIndex : Integer;
Begin
  With List Do
  Begin
    SetFocus;
    MaxIndex:=List.Items.Count-1;
    If (Index = LB_ERR) Then Index:=0
      Else If (Index > MaxIndex) Then Index:=MaxIndex;
    Selected[Index]:=True;
  End;
  SetButtons;
End;

//form létrehozása
Procedure THozzaadListDlg.FormCreate(Sender: TObject);
Begin
  RePaint;
End;

//form festése
Procedure THozzaadListDlg.FormPaint(Sender: TObject);
Var LabelArray : Array[1..2] Of TLabel;
Begin
  LabelArray[1]:=Self.Label1;
  LabelArray[2]:=Self.Label2;
  If AblakSzin.SzinAtmenet Then
  Begin
    Label_Allit(HozzaadListDlg,LabelArray,True,AblakSzin.HatterSzin);
    FormFesto(HozzaadListDlg);
  End
  Else Label_Allit(HozzaadListDlg,LabelArray,False,AblakSzin.BetuSzin);
End;

//ha aktíváljuk a formot
Procedure THozzaadListDlg.FormActivate(Sender: TObject);
Var I        : Integer;
    Index    : Integer;
    sID      : String;
    sItem    : String;
    RegiHely : Pointer;
    BerendID : Integer;
    Mutato   : PLancElem;
Begin
  I:=0;
  Self.Valt:=False;
  SrcList.Clear;
  DstList.Clear;
  SetLength(Self.AzonTomb,I);
  If (CelLista <> Nil) Then FreeAndNil(CelLista);
  CelLista:=TCelLista.Create(Self.BerendList);
  //berendezéseket tartalmazó lista feltöltése
  If (BerendList <> Nil) Then
  Begin
    RegiHely:=BerendList.Aktualis;
    BerendList.Aktualis:=BerendList.Elso;
    While (BerendList.Aktualis <> Nil) Do
    Begin
      Case BerendList.Aktualis.BerendezesTip Of
        btEgyeb,
        btFutotest : Begin
                       Inc(I);
                       sID:=IntToStr(BerendList.Aktualis.ID);
                       sItem:=sID+' - '+BerendList.Aktualis.BerendezesNev;
                       SetLength(Self.AzonTomb,I);
                       Self.AzonTomb[I-1,1]:=sID;
                       Self.AzonTomb[I-1,2]:=sItem;
                       Index:=Self.ListBox.IndexOf(sItem);
                       If (Index > LB_ERR) Then
                       Begin
                         BerendID:=KeresNev(ListBox[Index]);
                         If BerendList.KeresID(BerendID,Mutato) Then
                           CelLista.Felfuz(Mutato);
                         DstList.Items.Add(sItem);
                       End
                       Else SrcList.Items.Add(sItem);
                     End;
      End;
      BerendList.Aktualis:=BerendList.Aktualis.Kovetkezo;
    End;
    BerendList.Aktualis:=RegiHely;
  End;
  Self.SetButtons;
End;

//Rendben gomb
Procedure THozzaadListDlg.OKBtnClick(Sender: TObject);
Begin
  Self.FLista:=TStringList.Create;
  Self.FLista.Clear;
  Self.FLista:=DstList.Items;
  MutatoTomb:=CelLista.TombFeltolt;
  CancelBtnClick(Sender);
End;

//Mégsem gomb
Procedure THozzaadListDlg.CancelBtnClick(Sender: TObject);
Begin
  //tömb ürítése
  SetLength(Self.AzonTomb,0);
  //lista felszabadítása
  If (CelLista <> Nil) Then FreeAndNil(CelLista);
End;

End.
