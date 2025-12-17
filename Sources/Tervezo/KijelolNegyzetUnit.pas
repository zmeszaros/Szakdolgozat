//A kijelölõ négyzet eljárásai, függvényei
Unit KijelolNegyzetUnit;

Interface

Uses Windows, Graphics, ExtCtrls, Forms, Classes, PenUnit, RajzolasUnit;

Type
  //a kijelölõ négyzet definiciója
  TKijelolNegyzet = Object
  Public
    Procedure Init(Forms: TForm; Images: TImage; KN_BF: TPoint);
    Procedure Set_JA(KN_JA: TPoint);
    Procedure Done;
  Private
    BF           : TPoint;        //bal-felsõ pont
    JA           : TPoint;        //jobb-alsó pont
    Form         : TForm;         //melyik form-on dolgozunk
    Image        : TImage;        //melyik image-en dolgozunk
    RegiPenStyle : TRegiPenStyle; //toll tulajdonságai
  End;

Implementation

//KijelolNegyzet létrehozása
Procedure TKijelolNegyzet.Init;
Begin
  Self.BF:=KN_BF;
  Self.JA:=KN_BF;
  Self.Form:=Forms;
  Self.Image:=Images;
  Self.RegiPenStyle.Ment(Form,Image);
  //a tollat átállítjuk 1 vastagra, feketére, szaggatott vonalra
  Image.Canvas.Pen.Width:=1;
  Image.Canvas.Pen.Color:=clBlack;
  Image.Canvas.Pen.Style:=psDot;
End;

//jobb-alsó pont beállítása
Procedure TKijelolNegyzet.Set_JA;
Begin
  Self.JA:=KN_JA;
End;

//KijelolNegyzet megszüntetése
Procedure TKijelolNegyzet.Done;
Var RegiPenMode : TPenMode;
Begin
  //visszaállítjuk a toll tulajdonságait
  RegiPenMode:=Image.Canvas.Pen.Mode;
  Image.Canvas.Pen.Mode:=pmNotXor;
  NegyzetRajzol(Form,Image,BF,Point(JA.X,BF.Y),JA,Point(BF.X,JA.Y));
  Image.Canvas.Pen.Mode:=RegiPenMode;
  Self.RegiPenStyle.Vissza(Form,Image);
  Self.BF:=Point(0,0);
  Self.JA:=Point(0,0);
  Self.Form:=Nil;
  Self.Image:=Nil;
End;

End.
 