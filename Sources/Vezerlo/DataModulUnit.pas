//Adatmodul unit
Unit DataModulUnit;

Interface

Uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     Db, DBTables;

Type
  TDM = Class(TDataModule)
    KapcsTabla           : TTable;
    EgyebTabla           : TTable;
    EpuletTable          : TTable;
    HomeroTabla          : TTable;
    RiasztoTabla         : TTable;
    TuzjelzoTabla        : TTable;
    ObjektumTable        : TTable;
    FutotestTabla        : TTable;
    BerendezesTable      : TTable;
    TuzDataSource        : TDataSource;
    FutoDataSource       : TDataSource;
    EgyebDataSource      : TDataSource;
    KapcsDataSource      : TDataSource;
    EpuletDataSource     : TDataSource;
    HomeroDataSource     : TDataSource;
    RiasztoDataSource    : TDataSource;
    ObjektumDataSource   : TDataSource;
    BerendezesDataSource : TDataSource;
  End;

Var DM : TDM;

Implementation

{$R *.DFM}

End.
