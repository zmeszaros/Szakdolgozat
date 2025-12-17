unit GradientLabel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TGradientBevel=(gbNone, gbRaised, gbLowered);

  TGradientLabel = class(TGraphicControl)
  private
    FBack: TBitmap;
    FText: TBitmap;
    FBevel: TGradientBevel;
    FBitmap: TBitmap;
    FShadowOffset: integer;
    FShadowColor: TColor;
    FColorStart: TColor;
    FColorEnd: TColor;
    FAngle: integer;
    procedure GradientHorizontal;
    procedure SetBevel(const Value: TGradientBevel);
    procedure SetBitmap(const Value: TBitmap);
    procedure SetShadowOffset(const Value: integer);
    procedure SetShadowColor(const Value: TColor);
    procedure SetColorEnd(const Value: TColor);
    procedure SetColorStart(const Value: TColor);
    procedure SetAngle(const Value: integer);

  protected
    procedure Paint; override;
    procedure DoTextChange(var msg: TMessage); message CM_TEXTCHANGED;

  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

  published
    property Angle: integer read FAngle write SetAngle;
    property Bevel: TGradientBevel read FBevel write SetBevel;
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property ShadowOffset: integer read FShadowOffset write SetShadowOffset;
    property ShadowColor: TColor read FShadowColor write SetShadowColor;
    property ColorStart: TColor read FColorStart write SetColorStart;
    property ColorEnd: TColor read FColorEnd write SetColorEnd;
{$IFNDEF VER100}
    property Action;
    property Anchors;
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
    property Caption;
    property Font;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GLabel', [TGradientLabel]);
end;

{ TGradientLabel }

constructor TGradientLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width:=200;
  Height:=32;
  FShadowColor:=clGray;
  FColorStart:=clRed;
  FColorEnd:=clYellow;

  FBitmap:=TBitmap.Create;

  FBack:=TBitmap.Create;
  with FBack do begin
    Width:=200;
    Height:=32;
    Transparent:=true;
    TransparentColor:=clWhite;
  end;

  FText:=TBitmap.Create;
  with FText do begin
    Width:=200;
    Height:=32;
    Transparent:=true;
    TransparentColor:=clBlack;
    Canvas.Brush.Color:=clWhite;
    Canvas.Font.Color:=clBlack;
  end;

  Canvas.Brush.Style:=bsClear;
end;

destructor TGradientLabel.Destroy;
begin
  FBitmap.Free;
  FBack.Free;
  FText.Free;
  inherited Destroy;
end;

procedure TGradientLabel.DoTextChange(var msg: TMessage);
begin
  Invalidate;
end;

procedure TGradientLabel.GradientHorizontal;
var
  y, sr, sg, sb, er, eg, eb: integer;
  vr, vg, vb, dr, dg, db: double;
begin
  sr:=GetRValue(FColorStart);
  sg:=GetGValue(FColorStart);
  sb:=GetBValue(FColorStart);
  er:=GetRValue(FColorEnd);
  eg:=GetGValue(FColorEnd);
  eb:=GetBValue(FColorEnd);

  dr:=(er-sr)/(Height+1);
	dg:=(eg-sg)/(Height+1);
  db:=(eb-sb)/(Height+1);

  vr:=sr;
  vg:=sg;
  vb:=sb;

 	with FBack.Canvas do begin
    for y:=0 to Height-1 do begin
      Pen.Color:=RGB(Round(vr), Round(vg), Round(vb));
      MoveTo(0, y);
      LineTo(Width, y);
      vr:=vr+dr;
      vg:=vg+dg;
      vb:=vb+db;
    end;
  end;
end;

procedure TGradientLabel.Paint;
var
  pi180: extended;
  x, y, w, h: integer;
  r: TRect;
	lf: TLogFont;
  old, new: HFont;
begin
  new:=0;
  old:=0;
  FText.Canvas.Font.Assign(Font);
  Canvas.Font.Assign(Font);

  if Caption<>'' then begin
    w:=FText.Canvas.TextWidth(Caption);
    h:=FText.Canvas.TextHeight(Caption);
  end else begin
    w:=2;
    h:=2;
  end;


  r:=ClientRect;
  if FAngle<>0 then begin
    pi180:=Pi/180;
    case FAngle of
      0..90: begin
        x:=0;
        y:=Trunc(w*sin(FAngle*pi180));
      end;
      91..180: begin
       x:=Trunc(w*-cos(FAngle*pi180));
       y:=Trunc(w*sin(FAngle*Pi180)+h*cos((180-FAngle)*Pi180));
      end;
      181..270: begin
       x:=Trunc(w*-cos(FAngle*Pi180)+h*sin((FAngle-180)*Pi180));
       y:=Trunc(h*sin((270-FAngle)*Pi180));
      end;
      else begin
       x:=Trunc(h*sin((360-FAngle)*Pi180));
       y:=0;
      end;
    end;
    r.Top:=r.Top+y;
    r.Left:=r.Left+x;

    x:=Abs(Trunc(w*cos(FAngle*Pi180)))+Abs(Trunc(h*sin(FAngle*Pi180)));
    y:=Abs(Trunc(w*sin(FAngle*Pi180)))+Abs(Trunc(h*cos(FAngle*Pi180)));

    Width:=x;
    Height:=y;
  end else begin
    Width:=w;
    Height:=h;
  end;


  FBack.Width:=Width;
  FBack.Height:=Height;

  FText.Width:=Width;
  FText.Height:=Height;

  if FBitmap.Empty then begin
    GradientHorizontal;
  end else begin
    FBack.Canvas.StretchDraw(Rect(0, 0, Width, Height), FBitmap);
  end;

  SystemParametersInfo(SPI_SETFONTSMOOTHING, integer(false), nil, SPIF_SENDCHANGE);

  PatBlt(FText.Canvas.Handle, 0, 0, Width, Height, WHITENESS);
  if FAngle<>0 then begin
    GetObject(FText.Canvas.Font.Handle, SizeOf(TLogFont), @lf);
    lf.lfEscapement:=FAngle*10;
    new:=CreateFontIndirect(lf);
    old:=SelectObject(FText.Canvas.Handle, new);
  end;
  FText.Canvas.TextOut(r.Left, r.Top, Caption);

  if FAngle<>0 then begin
    SelectObject(FText.Canvas.Handle, old);
    DeleteObject(new);
  end;

  SystemParametersInfo(SPI_SETFONTSMOOTHING, integer(true), nil, SPIF_SENDCHANGE);

  FBack.Canvas.Draw(0, 0, FText);


  if FShadowOffset>0 then begin
    Canvas.Font.Color:=FShadowColor;
    if FAngle<>0 then begin
      GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @lf);
      lf.lfEscapement:=FAngle*10;
      new:=CreateFontIndirect(lf);
      old:=SelectObject(Canvas.Handle, new);
    end;
    Canvas.TextOut(r.Left+FShadowOffset, r.Top+FShadowOffset, Caption);
    if FAngle<>0 then begin
      SelectObject(Canvas.Handle, old);
      DeleteObject(new);
    end;
  end;

  case FBevel of
    gbRaised: begin
      Canvas.Font.Color:=clWhite;
      if FAngle<>0 then begin
        GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @lf);
        lf.lfEscapement:=FAngle*10;
        new:=CreateFontIndirect(lf);
        old:=SelectObject(Canvas.Handle, new);
      end;
      Canvas.TextOut(r.Left-1, r.Top-1, Caption);
      if FAngle<>0 then begin
        SelectObject(Canvas.Handle, old);
        DeleteObject(new);
      end;
      Canvas.Font.Color:=clBlack;
      if FAngle<>0 then begin
        GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @lf);
        lf.lfEscapement:=FAngle*10;
        new:=CreateFontIndirect(lf);
        old:=SelectObject(Canvas.Handle, new);
      end;
      Canvas.TextOut(r.Left+1, r.Top+1, Caption);
      if FAngle<>0 then begin
        SelectObject(Canvas.Handle, old);
        DeleteObject(new);
      end;
    end;
    gbLowered: begin
      Canvas.Font.Color:=clBlack;
      if FAngle<>0 then begin
        GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @lf);
        lf.lfEscapement:=FAngle*10;
        new:=CreateFontIndirect(lf);
        old:=SelectObject(Canvas.Handle, new);
      end;
      Canvas.TextOut(r.Left-1, r.Top-1, Caption);
      if FAngle<>0 then begin
        SelectObject(Canvas.Handle, old);
        DeleteObject(new);
      end;
      Canvas.Font.Color:=clWhite;
      if FAngle<>0 then begin
        GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @lf);
        lf.lfEscapement:=FAngle*10;
        new:=CreateFontIndirect(lf);
        old:=SelectObject(Canvas.Handle, new);
      end;
      Canvas.TextOut(r.Left+1, r.Top+1, Caption);
      if FAngle<>0 then begin
        SelectObject(Canvas.Handle, old);
        DeleteObject(new);
      end;
    end;
  end;

  Canvas.Draw(0, 0, FBack);
end;

procedure TGradientLabel.SetAngle(const Value: integer);
begin
	FAngle:=Value;
  if FAngle<0 then begin
  	FAngle:=Abs(FAngle);
  end;
	if FAngle>=360 then begin
  	FAngle:=FAngle mod 360;
  end;
  Invalidate;
end;

procedure TGradientLabel.SetBevel(const Value: TGradientBevel);
begin
  FBevel := Value;
  Invalidate;
end;

procedure TGradientLabel.SetBitmap(const Value: TBitmap);
begin
  FBitmap.Assign(Value);
  Invalidate;
end;

procedure TGradientLabel.SetColorEnd(const Value: TColor);
begin
  FColorEnd := Value;
  Invalidate;
end;

procedure TGradientLabel.SetColorStart(const Value: TColor);
begin
  FColorStart := Value;
  Invalidate;
end;

procedure TGradientLabel.SetShadowColor(const Value: TColor);
begin
  FShadowColor := Value;
  Invalidate;
end;

procedure TGradientLabel.SetShadowOffset(const Value: integer);
begin
  FShadowOffset := Value;
  Invalidate;
end;

end.
