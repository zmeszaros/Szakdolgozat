//Napló nyomtatási képe
Unit FrmNyomtatUnit;

Interface

Uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     Qrctrls, QuickRpt, ExtCtrls;

Type
  TfrmNyomtat = Class(TForm)
    QRBand1    : TQRBand;
    QRBand2    : TQRBand;
    QRBand3    : TQRBand;
    qFejlec    : TQRLabel;
    qNaplonev  : TQRLabel;
    qNyomtat   : TQuickRep;
    QRSysData1 : TQRSysData;
    QRSysData2 : TQRSysData;
    qRich      : TQRRichText;
  End;

Var frmNyomtat : TfrmNyomtat;

Implementation

{$R *.DFM}

End.
