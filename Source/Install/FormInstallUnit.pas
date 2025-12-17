//Installáló program
Unit FormInstallUnit;

Interface

Uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     GradientLabel, FormFestoUnit, StdCtrls, Buttons, ExtCtrls, ApplicationRun;

Const SETUP_FILE        = 'Setup.exe';
      TERVEZO_SETUPDIR  = 'Setup\Tervezo_Setup';
      TESZTELO_SETUPDIR = 'Setup\Tesztelo_Setup';
      VEZERLO_SETUPDIR  = 'Setup\Vezerlo_Setup';

Type
  TFormInstall = Class(TForm)
    Bevel1           : TBevel;
    lTervezoSetup    : TLabel;
    lVezerloSetup    : TLabel;
    lTeszteloSetup   : TLabel;
    lTelepito        : TGradientLabel;
    btnTervezoSetup  : TSpeedButton;
    btnVezerloSetup  : TSpeedButton;
    btnTeszteloSetup : TSpeedButton;
    ApplicationRun   : TApplicationRun;
    btnKilepes       : TButton;
    Procedure FormActivate(Sender: TObject);
    Procedure FormPaint(Sender: TObject);
    Procedure btnKilepesClick(Sender: TObject);
    Procedure btnTervezoSetupClick(Sender: TObject);
    Procedure btnVezerloSetupClick(Sender: TObject);
    Procedure btnTeszteloSetupClick(Sender: TObject);
    Procedure ApplicationRunFinish(filename: String);
  End;

Var FormInstall : TFormInstall;

Implementation

{$R *.DFM}

//a form aktívvá válik
Procedure TFormInstall.FormActivate(Sender: TObject);
Begin
  RePaint;
End;

//form festése
Procedure TFormInstall.FormPaint(Sender: TObject);
Var LabelArray : Array[1..3] Of TLabel;
    BevelArray : Array[1..1] Of TBevel;
Begin
  BevelArray[1]:=Self.Bevel1;
  LabelArray[1]:=Self.lTervezoSetup;
  LabelArray[2]:=Self.lVezerloSetup;
  LabelArray[3]:=Self.lTeszteloSetup;
  //beállítjuk a feliratok és keretek színét
  Label_Bevel_Allit(FormInstall,LabelArray,BevelArray,True,AblakSzin.HatterSzin,bsLowered);
  //festõ meghívása
  FormFesto(FormInstall);
End;

//kattintás a kilépésre
Procedure TFormInstall.btnKilepesClick(Sender: TObject);
Begin
  Close;
End;

//tervezõprogram telepítése
Procedure TFormInstall.btnTervezoSetupClick(Sender: TObject);
Begin
  //keretprogram elrejtése
  Application.ShowMainForm:=False;
  Hide;
  //telepítõprogram elindítása
  ApplicationRun.Start(TERVEZO_SETUPDIR+'\'+SETUP_FILE);
End;

//vezérlõprogram telepítése
Procedure TFormInstall.btnVezerloSetupClick(Sender: TObject);
Begin
  //keretprogram elrejtése
  Application.ShowMainForm:=False;
  Hide;
  //telepítõprogram elindítása
  ApplicationRun.Start(VEZERLO_SETUPDIR+'\'+SETUP_FILE);
End;

//tesztelõprogram telepítése
Procedure TFormInstall.btnTeszteloSetupClick(Sender: TObject);
Begin
  //keretprogram elrejtése
  Application.ShowMainForm:=False;
  Hide;
  //telepítõprogram elindítása
  ApplicationRun.Start(TESZTELO_SETUPDIR+'\'+SETUP_FILE);
End;

Procedure TFormInstall.ApplicationRunFinish(filename: String);
Begin
  //keretprogram visszaállítása
  Application.ShowMainForm:=True;
  Show;
End;

End.
