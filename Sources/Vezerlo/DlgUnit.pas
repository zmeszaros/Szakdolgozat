//Az berendezések láncait tartalmazó típus
Unit DlgUnit;

Interface

Uses Windows,Classes, Forms, BerendezesekLancUnit, HomeroBeallUnit, RiasztoBeallUnit,
     TuzjelzoBeallUnit, HomeroLancUnit, KapcsBerendLancUnit, RiasztoLancUnit,
     TuzjelzoLancUnit, FutotestDlgUnit, EgyebDlgUnit, VegBerendLancUnit;

Type
  //a lácokat tartalmazó típus
  TOsszesLista_Dlg = Class(TPersistent)
  Private
    HomeroList      : THomeroLista;      //hõmérõket tartalmazó lánc
    RiasztoList     : TRiasztoLista;     //riasztókat tartalmazó lánc
    TuzjelzoList    : TTuzjelzoLista;    //tûzjelzõket tartalmazó lánc
    VegBerendList   : TVegBerendLista;   //végberendezéseket tartalmazó lánc
    BerendList      : TBerendezesLista;  //összes berendezéseket tartalmazó lánc
    KapcsBerendList : TKapcsBerendLista; //kapcsolatokat tartalmazó lánc
  Public
    Property Homero : THomeroLista Read HomeroList;
    Property Riaszto : TRiasztoLista Read RiasztoList;
    Property Tuzjelzo : TTuzjelzoLista Read TuzjelzoList;
    Property VegBerendezes : TVegBerendLista Read VegBerendList;
    Property BerendezesList : TBerendezesLista Read BerendList;
    Property KapcsBerendezesList : TKapcsBerendLista Read KapcsBerendList;
    Procedure EgyebBeallit(Nev: String); Overload;
    Procedure EgyebBeallit(ItemList: TStrings); Overload;
    Procedure HomeroBeallit(Nev: String); Overload;
    Procedure HomeroBeallit(ItemList: TStrings); Overload;
    Procedure RiasztoBeallit(Nev: String); Overload;
    Procedure RiasztoBeallit(ItemList: TStrings); Overload;
    Procedure TuzjelzoBeallit(Nev: String); Overload;
    Procedure TuzjelzoBeallit(ItemList: TStrings); Overload;
    Procedure FutotestBeallit(Nev: String); Overload;
    Procedure FutotestBeallit(ItemList: TStrings); Overload;
    Constructor Create(HL: THomeroLista; RL : TRiasztoLista; TL: TTuzjelzoLista;
      VBL: TVegBerendLista; BL: TBerendezesLista; KBL: TKapcsBerendLista);
    Destructor Destroy; Override;
  End;

Implementation

//a típus létrehozása
Constructor TOsszesLista_Dlg.Create(HL: THomeroLista; RL: TRiasztoLista;
  TL: TTuzjelzoLista; VBL: TVegBerendLista; BL: TBerendezesLista;
  KBL: TKapcsBerendLista);
Begin
  Inherited Create;
  Self.HomeroList:=HL;
  Self.RiasztoList:=RL;
  Self.TuzjelzoList:=TL;
  Self.VegBerendList:=VBL;
  Self.BerendList:=BL;
  Self.KapcsBerendList:=KBL;
End;

//a típus megszüntetése
Destructor TOsszesLista_Dlg.Destroy;
Begin
  Self.HomeroList:=Nil;
  Self.RiasztoList:=Nil;
  Self.TuzjelzoList:=Nil;
  Self.VegBerendList:=Nil;
  Self.BerendList:=Nil;
  Self.KapcsBerendList:=Nil;
  Inherited;
End;

//egyéb berendezés beállító formjának meghívása a neve alapján
Procedure TOsszesLista_Dlg.EgyebBeallit(Nev: String);
Begin
  With EgyebDlg Do
  Begin
    Enabled:=True;
    Visible:=False;
    ActiveControl:=OKBtn;
    //lista feltöltése
    ComboBox1.Items.Clear;
    ComboBox1.Items.Add(Nev);
    ComboBox1.ItemIndex:=0;
    ComboBox1.Enabled:=False;
    BerendezesList:=Self.BerendList;
    VegBerendezesList:=Self.VegBerendList;
    KapcsBerendezesList:=Self.KapcsBerendList;
    //form megnyitása
    ShowModal;
    Enabled:=False;
  End;
End;

//egy fûtõtest berendezés beállító formjának meghívása a neve alapján
Procedure TOsszesLista_Dlg.FutotestBeallit(Nev: String);
Begin
  With FutotestDlg Do
  Begin
    Enabled:=True;
    Visible:=False;
    ActiveControl:=OKBtn;
    //lista feltöltése
    ComboBox1.Items.Clear;
    ComboBox1.Items.Add(Nev);
    ComboBox1.ItemIndex:=0;
    ComboBox1.Enabled:=False;
    BerendezesList:=Self.BerendList;
    VegBerendezesList:=Self.VegBerendList;
    KapcsBerendezesList:=Self.KapcsBerendList;
    //form megnyitása
    ShowModal;
    Enabled:=False;
  End;
End;

//egy hõmérõ berendezés beállító formjának meghívása a neve alapján
Procedure TOsszesLista_Dlg.HomeroBeallit(Nev: String);
Begin
  With HomeroBeallDlg Do
  Begin
    Enabled:=True;
    Visible:=False;
    ActiveControl:=OKBtn;
    //lista feltöltése
    ComboBox1.Items.Clear;
    ComboBox1.Items.Add(Nev);
    ComboBox1.ItemIndex:=0;
    ComboBox1.Enabled:=False;
    Homero:=Self.HomeroList;
    BerendezesList:=Self.BerendList;
    KapcsBerendezesList:=Self.KapcsBerendList;
    //form megnyitása
    ShowModal;
    Enabled:=False;
  End;
End;

//egy riasztó berendezés beállító formjának meghívása a neve alapján
Procedure TOsszesLista_Dlg.RiasztoBeallit(Nev: String);
Begin
  With RiasztoBeallDlg Do
  Begin
    Enabled:=True;
    Visible:=False;
    ActiveControl:=OKBtn;
    //lista feltöltése
    ComboBox1.Items.Clear;
    ComboBox1.Items.Add(Nev);
    ComboBox1.ItemIndex:=0;
    ComboBox1.Enabled:=False;
    Riaszto:=Self.RiasztoList;
    BerendezesList:=Self.BerendList;
    KapcsBerendezesList:=Self.KapcsBerendList;
    //form megnyitása
    ShowModal;
    Enabled:=False;
  End;
End;

//egy tûzjelzõ berendezés beállító formjának meghívása a neve alapján
Procedure TOsszesLista_Dlg.TuzjelzoBeallit(Nev: String);
Begin
  With TuzjelzoBeallDlg Do
  Begin
    Enabled:=True;
    Visible:=False;
    ActiveControl:=OKBtn;
    //lista feltöltése
    ComboBox1.Items.Clear;
    ComboBox1.Items.Add(Nev);
    ComboBox1.ItemIndex:=0;
    ComboBox1.Enabled:=False;
    TuzjelzoBeallDlg.Tuzjelzo:=Self.TuzjelzoList;
    TuzjelzoBeallDlg.BerendezesList:=Self.BerendList;
    TuzjelzoBeallDlg.KapcsBerendezesList:=Self.KapcsBerendList;
    //form megnyitása
    ShowModal;
    Enabled:=False;
  End;
End;

//egyéb berendezések beállító formjának meghívása a nevek alapján
Procedure TOsszesLista_Dlg.EgyebBeallit(ItemList: TStrings);
Begin
  With EgyebDlg Do
  Begin
    Enabled:=True;
    Visible:=False;
    ActiveControl:=OKBtn;
    //lista feltöltése
    ComboBox1.Items.Clear;
    ComboBox1.Items:=ItemList;
    ComboBox1.ItemIndex:=0;
    ComboBox1.Enabled:=True;
    BerendezesList:=Self.BerendezesList;
    VegBerendezesList:=Self.VegBerendezes;
    KapcsBerendezesList:=Self.KapcsBerendezesList;
    //form megnyitása
    ShowModal;
    Enabled:=False;
  End;
End;

//fûtõtestek beállító formjának meghívása a nevek alapján
Procedure TOsszesLista_Dlg.FutotestBeallit(ItemList: TStrings);
Begin
  With FutotestDlg Do
  Begin
    Enabled:=True;
    Visible:=False;
    ActiveControl:=OKBtn;
    //lista feltöltése
    ComboBox1.Items.Clear;
    ComboBox1.Items:=ItemList;
    ComboBox1.ItemIndex:=0;
    ComboBox1.Enabled:=True;
    BerendezesList:=Self.BerendezesList;
    VegBerendezesList:=Self.VegBerendezes;
    KapcsBerendezesList:=Self.KapcsBerendezesList;
    //form megnyitása
    ShowModal;
    Enabled:=False;
  End;
End;

//hõmérõ berendezések beállító formjának meghívása a nevek alapján
Procedure TOsszesLista_Dlg.HomeroBeallit(ItemList: TStrings);
Begin
  With HomeroBeallDlg Do
  Begin
    Enabled:=True;
    Visible:=False;
    ActiveControl:=OKBtn;
    //lista feltöltése
    ComboBox1.Items.Clear;
    ComboBox1.Items:=ItemList;
    ComboBox1.ItemIndex:=0;
    ComboBox1.Enabled:=True;
    Homero:=Self.Homero;
    BerendezesList:=Self.BerendezesList;
    KapcsBerendezesList:=Self.KapcsBerendList;
    //form megnyitása
    ShowModal;
    Enabled:=False;
  End;
End;

//riasztó berendezések beállító formjának meghívása a nevek alapján
Procedure TOsszesLista_Dlg.RiasztoBeallit(ItemList: TStrings);
Begin
  With RiasztoBeallDlg Do
  Begin
    Enabled:=True;
    Visible:=False;
    ActiveControl:=OKBtn;
    //lista feltöltése
    ComboBox1.Items.Clear;
    ComboBox1.Items:=ItemList;
    ComboBox1.ItemIndex:=0;
    ComboBox1.Enabled:=True;
    Riaszto:=Self.Riaszto;
    BerendezesList:=Self.BerendezesList;
    KapcsBerendezesList:=Self.KapcsBerendList;
    //form megnyitása
    ShowModal;
    Enabled:=False;
  End;
End;

//tûzjelzõ berendezések beállító formjának meghívása a nevek alapján
Procedure TOsszesLista_Dlg.TuzjelzoBeallit(ItemList: TStrings);
Begin
  With TuzjelzoBeallDlg Do
  Begin
    Enabled:=True;
    Visible:=False;
    ActiveControl:=OKBtn;
    //lista feltöltése
    ComboBox1.Items.Clear;
    ComboBox1.Items:=ItemList;
    ComboBox1.ItemIndex:=0;
    ComboBox1.Enabled:=True;
    Tuzjelzo:=Self.Tuzjelzo;
    BerendezesList:=Self.BerendezesList;
    KapcsBerendezesList:=Self.KapcsBerendList;
    //form megnyitása
    ShowModal;
    Enabled:=False;
  End;
End;

End.
