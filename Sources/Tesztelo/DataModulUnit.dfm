object DM: TDM
  OldCreateOrder = False
  Left = 167
  Top = 192
  Height = 480
  Width = 811
  object EpuletDataSource: TDataSource
    DataSet = EpuletTable
    Left = 41
    Top = 13
  end
  object EpuletTable: TTable
    DatabaseName = 'Epulet'
    ReadOnly = True
    TableType = ttParadox
    Left = 41
    Top = 61
  end
  object ObjektumDataSource: TDataSource
    DataSet = ObjektumTable
    Left = 146
    Top = 13
  end
  object ObjektumTable: TTable
    DatabaseName = 'Epulet'
    TableType = ttParadox
    Left = 146
    Top = 61
  end
  object BerendezesDataSource: TDataSource
    DataSet = BerendezesTable
    Left = 267
    Top = 13
  end
  object KapcsTabla: TTable
    DatabaseName = 'Epulet'
    TableType = ttParadox
    Left = 266
    Top = 299
  end
  object HomeroDataSource: TDataSource
    DataSet = HomeroTabla
    Left = 42
    Top = 131
  end
  object HomeroTabla: TTable
    DatabaseName = 'Epulet'
    TableType = ttParadox
    Left = 42
    Top = 179
  end
  object RiasztoDataSource: TDataSource
    DataSet = RiasztoTabla
    Left = 146
    Top = 131
  end
  object RiasztoTabla: TTable
    DatabaseName = 'Epulet'
    TableType = ttParadox
    Left = 146
    Top = 179
  end
  object TuzDataSource: TDataSource
    DataSet = TuzjelzoTabla
    Left = 266
    Top = 131
  end
  object TuzjelzoTabla: TTable
    DatabaseName = 'Epulet'
    TableType = ttParadox
    Left = 266
    Top = 179
  end
  object FutoDataSource: TDataSource
    DataSet = FutotestTabla
    Left = 42
    Top = 251
  end
  object FutotestTabla: TTable
    DatabaseName = 'Epulet'
    TableType = ttParadox
    Left = 42
    Top = 299
  end
  object EgyebDataSource: TDataSource
    DataSet = EgyebTabla
    Left = 146
    Top = 251
  end
  object EgyebTabla: TTable
    DatabaseName = 'Epulet'
    TableType = ttParadox
    Left = 146
    Top = 299
  end
  object KapcsDataSource: TDataSource
    DataSet = KapcsTabla
    Left = 266
    Top = 251
  end
  object BerendezesTable: TTable
    DatabaseName = 'Epulet'
    TableType = ttParadox
    Left = 266
    Top = 60
  end
end
