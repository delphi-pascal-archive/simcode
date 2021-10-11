unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, Buttons;

  {$R data.res}

type
pSomeType = ^SomeType;
SomeType = Integer;
type
  TForm1 = class(TForm)
    blist: TListBox;
    res: TListBox;
    Splitter1: TSplitter;
    image: TImage;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    saved: TSaveDialog;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Panel1: TPanel;
    edit: TEdit;
    N7: TMenuItem;
    timer: TTimer;
    N8: TMenuItem;
    bradio: TRadioGroup;
    go: TBitBtn;
    canc: TBitBtn;
    back: TSpeedButton;
    next: TSpeedButton;
    Label1: TLabel;
    N9: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure blistClick(Sender: TObject);
    procedure resDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure blistDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormShow(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure editChange(Sender: TObject);
    procedure editEnter(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure blistMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure resMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Splitter1Moved(Sender: TObject);
    procedure blistKeyPress(Sender: TObject; var Key: Char);
    procedure timerTimer(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure bradioClick(Sender: TObject);
    procedure cancClick(Sender: TObject);
    procedure backClick(Sender: TObject);
    procedure nextClick(Sender: TObject);
    procedure goClick(Sender: TObject);
    procedure editExit(Sender: TObject);
    procedure N9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1; list: tstringlist; chr: array [1..3] of char; yes: boolean = false; ichr: array [1..3] of integer = (0,0,0); bit: tbitmap;
  l: tlist; newp: string; item: psometype;

implementation

uses Unit2, Unit3;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var i,l: integer; stream: TResourceStream;
begin
if not fileexists(extractfilepath(paramstr(0))+'simcode.txt') then
begin
stream := TResourceStream.Create(HInstance, 'DATAARRAY', RT_RCDATA);
with TFileStream.Create('simcode.txt', fmCreate) do begin
   CopyFrom(stream, stream.Size);
   Free;
end;
end;

     blist.tabwidth:= 35;
     bit:= tbitmap.create;
     bit:= image.picture.bitmap;
     chr[1]:= 'Х'; chr[2]:= 'Н'; chr[3]:= 'П';
     list:= tstringlist.create;
     list.loadfromfile(extractfilepath(paramstr(0))+'simcode.txt');
     for i:= 0 to list.count-1 do blist.items.add( inttostr(succ(i))+'.  |'+copy(list[i],1,pos(#149,list[i])-1));
end;

procedure TForm1.blistClick(Sender: TObject);
var s: string; x,i,ii,i2,b: integer;
sp,p: array[1..160] of char; ch: char;
lt: tstringlist;
begin

     if tag in [1,2] then begin
     if tag = 1 then
     bradio.itemindex:= (PSOMETYPE(L.Items[blist.ItemIndex])^)
     else
     begin
     i:= blist.itemindex;
     bradio.itemindex:= (PSOMETYPE(L.Items[i])^);
     //.if i < res.tag then bradio.itemindex:= (PSOMETYPE(L.Items[i])^) else bradio.itemindex:= (PSOMETYPE(L.Items[succ(i)])^);
     end;

     if blist.itemindex > 0 then back.enabled:= true else back.enabled:= false;
     if blist.itemindex = blist.count-1 then next.enabled:= false else next.enabled:= true;
     if blist.itemindex = blist.count-1 then go.enabled:= true else go.enabled:= false;

     EXIT;
     end;
     yes:= false; for i:= 1 to 3 do ichr[i]:= 0;
     lt:= tstringlist.create;
     res.clear; b:= blist.itemindex;
     s:= copy(list[b],pos(#149,list[b]),length(list[b]));
     x:= 0;
     while (s <> '') do
     begin
     inc(x); delete(s,1,1); p[x]:= s[1]; delete(s,1,1);
     end;


    for ii:= 1 to 3 do
    begin
          ch:= chr[ii];
    for i2:= 1 to list.count do
    begin

     s:= copy(list[i2-1],pos(#149,list[i2-1]),length(list[i2-1]));
     x:= 0;
     while (s <> '') do
     begin
     inc(x); delete(s,1,1); sp[x]:= s[1]; delete(s,1,1);
     end;

          for i:= 1 to list.count do
               if (sp[i] = ch)and(p[i] = ch)and(i-1 <> b)then
               begin
               if lt.indexof(copy(list[i-1],1,pos(#149,list[i-1])-1)) = -1 then
               lt.add( copy(list[i-1],1,pos(#149,list[i-1])-1) );
          end
          end;

          if lt.count <> 0 then
          begin
          case ch of
          'Х': res.items.add(' Лучшая совместимость ');
          'Н': res.items.add(' Средняя совместимость ');
          'П': res.items.add(' Не рекомендуется сочетать с ');
          end;

          //if ii = 3 then yes:= true;
          ichr[ii]:= res.items.count-1;
          for i:= 0 to lt.count-1 do
          res.items.add( inttostr(succ(i))+'. |'+lt[i] ); end;

          lt.clear;
    end;

    lt.free
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     list.savetofile(extractfilepath(paramstr(0))+'simcode.txt');
     list.free; //bit.free;
end;
//------------------------------------------------------------------------------
procedure TForm1.resDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
label 1;
var cc:     TCanvas;   S, Ss: string;
            P: Integer; // Флаг символа-разделителя
            offset: integer; bmprect:trect;
begin
cc:=(Control as TListBox).Canvas;
with RES do begin

If odSelected in State then
begin
     canvas.font.style:= [fsbold,fsitalic]; canvas.brush.color:= clwhite;
end;
canvas.fillrect(RECT);

if (index = ichr[1])or(index = ichr[2])or(index = ichr[3])then
begin

     Canvas.Font.Color:=  clBlue;
     Canvas.Font.Style:= [fsBold,fsItalic];
     Canvas.TextOut(Rect.Left+17,Rect.Top+2,Items[Index]);

     BMPRect := Bounds(Rect.Left + 2, Rect.Top,
    (Rect.Bottom - Rect.Top), Rect.Bottom - Rect.Top);
     cc.BrushCopy(BMPRect, Bit, Bounds(0, 0, Bit.Width, Bit.Height),
     Bit.Canvas.Pixels[0, Bit.Height]);
     Offset := (Rect.Bottom - Rect.Top);
end
else begin
S := Items.Strings[Index];
P := Pos('|', S);

Ss := Copy(S, 1, P - 1);
Canvas.Font.Color:= clBlack;
Canvas.TextOut(Rect.Left + 40, Rect.Top + 2, Ss);

if (ichr[2] = 0) then
if (index < ichr[3]) then begin canvas.font.color:= clgreen; goto 1 end;

if (index < ichr[2]) then canvas.font.color:= clgreen
else
if index < ichr[3] then canvas.font.color:= clhotlight
else canvas.font.color:= clred;
1:
Canvas.Font.Style:= [fsBold,fsItalic];
Canvas.TextOut(60, Rect.Top + 2, Copy(S, P + 1,Length(S)));
end
end;
end;
//------------------------------------------------------------------------------
procedure TForm1.blistDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  S, Ss: string; P: Integer; // Флаг символа-разделителя
begin

If odSelected in State then blist.canvas.brush.color:= clwhite;

BList.Canvas.FillRect(Rect);

S := BList.Items.Strings[Index];
P := Pos('|', S);


Ss := Copy(S, 1, P - 1);
BList.Canvas.Font.Color:= clBlack;
BList.Canvas.TextOut(Rect.Left + 10, Rect.Top + 2, Ss);
BList.Canvas.Font.Color:= clblue;
BList.Canvas.Font.Style:= [fsBold,fsItalic];
BList.Canvas.TextOut(BList.TabWidth, Rect.Top + 2, Copy(S, P + 1,Length(S)));
end;

procedure TForm1.FormShow(Sender: TObject);
begin
     blist.itemindex:= 0;
     blist.selected[0]:= true;
     blistclick(self);
end;

procedure TForm1.N1Click(Sender: TObject);
var i,p: integer; sel: array [0..150] of integer; s: string; o: tstringlist;
begin
     if not saved.execute then exit;
     o:= tstringlist.create;
     for i:= 0 to blist.items.count -1 do if blist.selected[i] then sel[i]:= i else sel[i]:= -1;

     for i:= 0 to blist.items.count -1 do
     if (sel[i] <> -1)  then
     begin
     blist.itemindex:= i; blist.selected[i]:= true; blist.onclick(sender);
     o.add('_________________________________');
     o.add(#149+' '+ansiuppercase(copy(blist.items[i], pos('|',blist.items[i])+1, length(blist.items[i]))));
     o.add('_________________________________'#13#13);
     for p:= 0 to res.items.count -1 do
     begin
     s:= ' '
     + res.items[p]; delete(s,pos('|',s),1);
     if p in [ichr[1],ichr[2],ichr[3]] then
     o.add(#13+ansiuppercase(s)+#149)
     else o.add('                             '+s);
     if p = res.items.count -1 then o.add(#13);
     end
     end;
     o.savetofile(saved.filename);
     o.free
end;

procedure TForm1.N3Click(Sender: TObject);
begin
     blist.selectall
end;

procedure TForm1.N4Click(Sender: TObject);
begin
     if messagedlg('ВЫХОДИМ ?',mtconfirmation,[mbok,mbcancel],0) = mrok then CLOSE
end;

procedure TForm1.N6Click(Sender: TObject);
begin
     Abt:= TABT.Create(Self);
     Abt.ShowModal;
end;

procedure TForm1.editChange(Sender: TObject);
var i,p: integer;
begin
     with blist do begin
     for p:= 0 to count-1 do selected[p]:= false;
     for i:= 0 to count-1 do
     if pos(ansilowercase(edit.text),ansilowercase(items[i]))<>0 then
     begin
          itemindex:= i; selected[i]:= true; blistclick(self); break;
     end
  end
end;

procedure TForm1.editEnter(Sender: TObject);
begin
     ActivateKeyboardLayout($419, 0);
end;

procedure TForm1.N7Click(Sender: TObject);
begin
     edit.setfocus;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
     if activecontrol = res then n3.enabled:= false else n3.enabled:= true
end;

procedure TForm1.blistMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var p,i: integer;
begin
     if button = mbright then
     begin
     i:= blist.itematpos(point(x,y),true);
     for p:= 0 to blist.count-1 do
     blist.selected[p]:= false;
     blist.itemindex:= i;
     blist.selected[i]:= true;
     blist.setfocus
     end;

end;

procedure TForm1.resMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var p,i: integer;
begin
     if button = mbright then
     begin
     i:= res.itematpos(point(x,y),true);
     for p:= 0 to res.count-1 do
     res.selected[p]:= false;
     res.itemindex:= i;
     res.selected[i]:= true;
     res.setfocus
     end;

end;

procedure TForm1.Splitter1Moved(Sender: TObject);
begin
     edit.width:= blist.width

end;

procedure TForm1.blistKeyPress(Sender: TObject; var Key: Char);
begin
     if timer.enabled then begin edit.text:= edit.text+key; timer.enabled:= false; timer.enabled:= true; end else begin edit.text:= key; timer.enabled:= true end;
end;

procedure TForm1.timerTimer(Sender: TObject);
begin
     timer.enabled:= false;
end;

procedure TForm1.N8Click(Sender: TObject);
var i: integer;
begin
     inputquery('Input box','Введите имя категории ',newp);
     if newp <> '' then begin
     tag:= 1; blist.multiselect:= false;
     blist.itemindex:= 0; blist.selected[0]:= true;
     edit.hide;   res.hide;
     bradio.visible:= true;
     canc.visible:= true;
     next.visible:= true;
     back.enabled:= false;
     back.visible:= true;
     go.enabled:= false;
     go.visible:= true;
     l:= TList.Create;

     for i := 0 to blist.count -1 do
     begin
     New(Item); Item^ := 0;
     L.Add(Item);
     end;
   end
end;

procedure TForm1.N9Click(Sender: TObject);
begin
     form3:= tform3.create(self);
     form3.showmodal;
end;

procedure TForm1.bradioClick(Sender: TObject);
begin
     New(Item); Item^ := bradio.itemindex;
     L.Items[blist.ItemIndex]:= item;
end;

procedure TForm1.cancClick(Sender: TObject);
var i: integer;
begin
     tag:= 0;
     blist.multiselect:= true;
     edit.visible   := true;
     res.visible    := true;
     bradio.itemindex:= 0;
     bradio.visible := false;
     canc.visible   := false;
     next.enabled   := true;
     next.visible   := false;
     back.enabled   := true;
     back.visible   := false;
     go.enabled     := true;
     go.visible     := false;

     newp:= '';

     for I := 0 to L.Count-1 do
     Dispose(L.Items[I]);
     L.Free;
end;

procedure TForm1.backClick(Sender: TObject);
begin
     blist.itemindex:= pred(blist.itemindex); blist.selected[blist.itemindex]:= true; blist.setfocus; blistclick(sender)
end;

procedure TForm1.nextClick(Sender: TObject);
begin
     blist.itemindex:= succ(blist.itemindex); blist.selected[blist.itemindex]:= true; blist.setfocus; blistclick(sender)
end;

procedure TForm1.goClick(Sender: TObject);
var i: integer; s: string;
begin
       for i := 0 to list.count-1 do
       begin
            list[i]:= list[i]+#149+bradio.items.strings[(psometype(L.Items[i])^)][2];
            s:= s + #149 + bradio.items.strings[(psometype(L.Items[i])^)][2];
       end;
       s:= newp+s+#149+'0';
       list.add(s);
       newp:= '';
       blist.items.add( inttostr(list.count)+'.  |'+copy(list[list.count-1],1,pos(#149,list[list.count-1])-1));
       cancclick(sender);
       blist.itemindex:= list.count-1; blist.selected[list.count-1]:= true; blist.setfocus; blistclick(sender)
end;

procedure TForm1.editExit(Sender: TObject);
begin
     edit.text:= '';
end;



end.
