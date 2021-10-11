unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm3 = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm3.FormShow(Sender: TObject);
var i: integer; s: string;
begin
     combobox1.items.clear;
     for i:= 0 to form1.blist.count-1 do
     begin
         s:= form1.blist.items[i];
         delete(s,pos('|',s),1);
         combobox1.items.add(s);
     end;
     combobox1.itemindex:= form1.blist.itemindex;
end;

procedure TForm3.Button1Click(Sender: TObject);
var s: string; i: integer;
begin
     with form1 do
     begin
     tag:= 2;
     res.tag:= blist.itemindex;
     blist.multiselect:= false;

     edit.hide;   res.hide;
     bradio.visible:= true;
     canc.visible:= true;
     next.visible:= true;
     back.enabled:= false;
     back.visible:= true;
     go.enabled:= false;
     go.visible:= true;
     l:= TList.Create;

     s:= copy(list[blist.Itemindex],pos(#149,list[blist.Itemindex])+1,length(list[blist.Itemindex]));
     while pos(#149,s) <> 0 do delete(s,pos(#149,s),1);


     for i := 1 to blist.count do
     if s[i]<>'0' then
     begin
     new(item);
     l.add(Item);
     case s[i] of
     'Õ': begin Item^ := 0; end;
     'Í': begin Item^ := 1; end;
     'Ï': begin Item^ := 2; end;
     end;

     end;
     blist.items.delete(combobox1.itemindex);
     for i := 0 to blist.count-1 do blist.items[i]:= '  '+copy(blist.items[i],pos('|',blist.items[i])+1,length(blist.items[i]));
     blist.itemindex:= 0; blist.selected[0]:= true;


     end;
     form3.modalresult:= 1;
end;

procedure TForm3.Button2Click(Sender: TObject);
var i: integer;
begin
     //form1.cancclick(self);
     form3.modalresult:= 1;
end;

end.
