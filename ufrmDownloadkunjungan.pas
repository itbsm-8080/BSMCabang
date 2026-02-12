unit ufrmDownloadKunjungan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids,  AdvGrid, ComCtrls, StdCtrls, AdvEdit, ExtCtrls,
  AdvPanel, AdvCGrid, BaseGrid,SqlExpr, DBAdvGrd, DB, DBClient, Provider,
  FMTBcd, RAWPrinter, StrUtils, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxDBData, cxSpinEdit, cxCalendar, Menus, cxButtons, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxButtonEdit, cxCurrencyEdit,ExcelXP,ComObj,
  AdvCombo,DateUtils, cxPC, DBAccess, MyAccess, MemDS;

type
  TfrmDownloadkunjungan = class(TForm)
    AdvPanel1: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel2: TAdvPanel;
    Label5: TLabel;
    RAWPrinter1: TRAWPrinter;
    AdvPanel4: TAdvPanel;
    cxButton8: TcxButton;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    OpenDialog1: TOpenDialog;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    MainMenu1: TMainMenu;
    startdate: TDateTimePicker;
    Label2: TLabel;
    enddate: TDateTimePicker;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure bacafile2;
    procedure FormShow(Sender: TObject);
    private
    aHost2,aDatabase2,auser2,apassword2 : string;
      { Private declarations }
     protected
  public
    { Public declarations }
  end;

var
  frmDownloadkunjungan: TfrmDownloadkunjungan;

implementation

uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,uFrmbantuan2;

{$R *.dfm}

procedure TfrmDownloadkunjungan.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Release;
end;

procedure TfrmDownloadkunjungan.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     SelectNext(ActiveControl,True,True);
end;



procedure TfrmDownloadkunjungan.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmDownloadkunjungan.cxButton1Click(Sender: TObject);
var
  ssql,s: string;
  tsql : TmyQuery;
  tt :TStrings;
  i:Integer;

begin
s:='select a.* from tkunjungan_dtl a inner join tkunjungan b on a.id_hdr=b.id'
     + ' inner join bsm.tkaryawan on user=kar_nama'
     + ' where tanggal between '+ QuotD(startdate.DateTime)
     + ' and ' + QuotD(enddate.DateTime)
     + ' and kar_cabang=' +Quot(frmMenu.NMCABANG) ;
      MyQuery1.Close;
  MyQuery1.SQL.Text := s;
  MyQuery1.Open;
     tt := TStringList.Create;
     with MyQuery1 do begin
       try
        while  not Eof do
        begin
            s:=' insert ignore into tkunjungan_dtl ('
              + ' id_hdr,kode,nama,stat,note) '
              + ' values ( '
              + Fields[0].Asstring + ','
              + Quot(Fields[1].Asstring) + ','
              + Quot(Fields[2].AsString) + ','
              + Quot(Fields[3].AsString) + ','
              + Quot(Fields[4].AsString)
              + ');';

            tt.Append(s);
          Next;
        end;
        finally
//          Free;
        end;

      end;


  s:='select * from tplankunjungan '
     + ' where plan_tanggal between '+ QuotD(startdate.DateTime)
     + ' and ' + QuotD(enddate.DateTime)
     + ' and plan_cabang=' +Quot(frmMenu.NMCABANG) ;
       MyQuery1.Close;
  MyQuery1.SQL.Text := s;
  MyQuery1.Open;
//     tt := TStringList.Create;
     with MyQuery1 do begin
       try
        while  not Eof do
        begin
            s:=' insert ignore into tplankunjungan  ('
              + ' plan_sls_kode,plan_tanggal,plan_cus_kode,plan_cabang) '
              + ' values ( '
              + quot(Fields[0].Asstring) + ','
              + QuotD(Fields[1].AsDateTime) + ','
              + Quot(Fields[2].AsString) + ','
              + Quot(Fields[3].AsString)
              + ');';

            tt.Append(s);
          Next;
        end;
        finally
//          Free;
        end;

      end;


    s:='select a.id,cus_kode,latitude,longitude,tanggal,'
     + ' user,keperluan,note,isdetail,perusahaan from bsm.tkunjungan a'
     + ' inner join bsm.tkaryawan on user=kar_nama'
     + ' where tanggal between '+ QuotD(startdate.DateTime)
     + ' and ' + QuotD(enddate.DateTime)
     + ' and kar_cabang=' +Quot(frmMenu.NMCABANG) ;
  MyQuery1.Close;
  MyQuery1.SQL.Text := s;
  MyQuery1.Open;

     with MyQuery1 do begin
      try
        while  not Eof do
        begin
            s:=' insert ignore into tkunjungan (id,cus_kode,latitude,longitude,tanggal,'
              + ' user,keperluan,note,isdetail,perusahaan) '
              + ' values ( '
              + IntToStr(Fields[0].AsInteger) + ','
              + Quot(Fields[1].AsString) + ','
              + Quot(Fields[2].AsString) + ','
              + Quot(Fields[3].AsString) + ','
              + QuotD(Fields[4].AsDateTime,True) + ','
              + Quot(Fields[5].AsString) + ','
              + Quot(Fields[6].AsString) + ','
              + Quot(Fields[7].AsString) + ','
              + IntToStr(Fields[8].AsInteger) + ','
              + Quot(Fields[9].AsString) + ');';

            tt.Append(s);
          Next;
        end;
        finally
//          Free;
      end;
         try
        for i:=0 to tt.Count -1 do
        begin
            EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, tt[i]);
         end;
        finally
          tt.Free;
        end;
          

     end;


   showmessage('Proses Selesaai')
end;

procedure TfrmDownloadkunjungan.bacafile2;
var
s:string;
tsql:TmyQuery;

 begin
   s:='select ahost,adatabase,auser,apassword from tsetingdb where nama like '+Quot('default4') +';';
   tsql:=xOpenQuery(s,frmmenu.conn);
  with tsql do
  begin
    try
       aHost2     := fields[0].AsString;
       aDatabase2 := fields[1].AsString;
       auser2     := fields[2].AsString;
       apassword2 := fields[3].AsString;

    finally
      free;
    end;
  end;

 end;





procedure TfrmDownloadkunjungan.FormShow(Sender: TObject);
begin
startdate.datetime := date;
enddate.datetime := date;
  bacafile2;
  with MyConnection1 do
  begin
   LoginPrompt := False;
   Server := aHost2;
   Database := aDatabase2;
   Username := auser2;
   Password := apassword2;
   Connected := True;
  end;

end;

end.
