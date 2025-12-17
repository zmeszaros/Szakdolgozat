//Üzenetek kódolása és dekódolása
Unit KodolasUnit;

Interface

Uses SysUtils;

Type
  //egy üzenetet tartalmazó dinamikus tömb
  TAdatUzenetTomb = Array Of Integer;

  Function Dekodolo(Str: String) : TAdatUzenetTomb;
  Function Kodolo(Tomb: TAdatUzenetTomb) : String;
  Function BoolToStr(Ertek: Boolean) : String;
  Function StrToBool(Ertek: String) : Boolean;
  Function BoolToInt(Ertek: Boolean) : Integer;
  Function IntToBool(Ertek: Integer) : Boolean;

Implementation

//üzenet kódolása
//visszatérési értéke a kódolt üzenet
Function Kodolo(Tomb : TAdatUzenetTomb) : String;
Var I     : Integer;
    Hossz : Integer;
Begin
  Result:='';
  Hossz:=High(Tomb)+1;
  If (Hossz > -1) Then
  Begin
    Result:='#'+IntToStr(Hossz);
    //az értékek átalakítása
    For I:=0 To High(Tomb) Do Result:=Result+'#'+IntToStr(Tomb[I]);
    Result:=Result+'#';
  End;
End;

//üzenet dekódolása
//visszatérési értéke a dekódolt üzenet egy dinamikus tömbben
Function Dekodolo(Str: String) : TAdatUzenetTomb;
Var I,Hossz   : Integer;
    Pos1,Pos2 : Integer;
    Tovabb    : Boolean;
    Uzenet    : String;
Begin
  Tovabb:=False;
  Uzenet:=Str;
  SetLength(Result,0);
  //az üzenetnek #-kal kell kezdõdnie
  Pos1:=System.Pos('#',Str);
  //ha nem #-kal kezdõdik, akkor a felesleget levágja
  If (Pos1 > 1) Then
  Begin
    System.Delete(Str,1,Pos1-1);
    Pos1:=System.Pos('#',Str);
  End;
  //megkeresi a második #-ot
  Pos2:=System.Pos('#',Copy(Str,Pos1+1,Length(Str)-Pos1));
  //ha mind a kettõ megvan
  If (Pos1 > 0) And (Pos2 > 0) Then
  Begin
    Try
      Tovabb:=True;
      //kiszámítja az üzenet hosszát
      Hossz:=StrToInt(Copy(Str,Pos1+1,Pos2-Pos1));
      //beállítja a tömb hosszát
      SetLength(Result,Hossz);
    Except
      On E: EConvertError Do Tovabb:=False;
    End;
  End;
  //ha eddig minden rendben
  If Tovabb Then
  Begin
    //az üzenet elemeinek vegig olvasása
    For I:=0 To High(Result) Do
    Begin
      //megkeresi az üzenetet megelõzõ #-ot
      System.Delete(Str,1,Pos2);
      Pos1:=System.Pos('#',Str);
      If (Pos1 > 1) Then
      Begin
        System.Delete(Str,1,Pos1-1);
        Pos1:=System.Pos('#',Str);
      End;
      //megkeresi az üzenetet követõ #-ot
      Pos2:=System.Pos('#',Copy(Str,Pos1+1,Length(Str)-Pos1));
      //ha mind a kettõ megvan
      If (Pos1 > 0) And (Pos2 > 0) Then
      Begin
        Try
          //az üzenetbõl kinyeri az értéket és berakja a tömb megfelelõ helyére
          Result[I]:=StrToInt(Copy(Str,Pos1+1,Pos2-Pos1));
        Except
          On E: EConvertError Do SetLength(Result,0);
        End;
      End;
    End;
  End;
End;

//logikai értékbõl -> stringet állít elõ
Function BoolToStr(Ertek: Boolean) : String;
Begin
  If Ertek Then Result:='1'
  Else Result:='0';
End;

//stringbõl -> logikai értéket állít elõ
Function StrToBool(Ertek: String) : Boolean;
Begin
  Result:=False;
  If (Ertek <> '') Then Result:=(Ertek[1] = '1');
End;

//logikai értékbõl -> integert állít elõ
Function BoolToInt(Ertek: Boolean) : Integer;
Begin
  If Ertek Then Result:=1
  Else Result:=0;
End;

//integerbõl -> logikai értéket állít elõ
Function IntToBool(Ertek: Integer) : Boolean;
Begin
  Result:=(Ertek = 1);
End;

End.
