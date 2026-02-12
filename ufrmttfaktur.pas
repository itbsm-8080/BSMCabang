unit ufrmTTfaktur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  DBClient, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxSpinEdit, cxButtonEdit, cxTextEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, AdvEdBtn, AdvCombo, cxCurrencyEdit,DateUtils,
  cxCalendar, MemDS, DBAccess, MyAccess, cxCheckBox;

type
  TfrmTTFaktur = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtNamacustomer: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clCustomer: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    edtKode: TAdvEditBtn;
    cltanggal: TcxGridDBColumn;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    savedlg: TSaveDialog;
    clNilai: TcxGridDBColumn;
    edtkodecustomer: TAdvEditBtn;
    Label1: TLabel;
    edtNomor: TAdvEdit;
    edtnamasalesman: TAdvEdit;
    cxButton1: TcxButton;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    clcheck: TcxGridDBColumn;
    Button1: TButton;
    clnilai2: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure initgrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton8Click(Sender: TObject);
    procedure edtKodeClickBtn(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure clCustomerPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure cxGrdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bacafile2;
    procedure cxButton7Click(Sender: TObject);
    procedure loaddataALL(anomor:String) ;
    procedure edtkodecustomerClickBtn(Sender: TObject);
    function getmaxid(asalesman: string; aperiode: string): string;
    function cekdata:boolean;
    procedure cxButton1Click(Sender: TObject);
    procedure HapusRecord1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure clcheckPropertiesEditValueChanged(Sender: TObject);

  private
    FFLAGEDIT: Boolean;
    FID: string;
    aHost2,aDatabase2,auser2,apassword2 : string;

    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmTTFaktur: TfrmTTFaktur;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,ufrmCetak,ureport,cxGridExportLink;

{$R *.dfm}

procedure TfrmTTFaktur.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
end;

procedure TfrmTTFaktur.refreshdata;
begin
  FID:='';
//   edtNomor.Text :=getmaxid(edtKode.Text, FormatDateTime('mmyyyy', date)); 
  edtKode.Clear;
  edtkodecustomer.Clear;
  edtNamacustomer.Clear;
  initgrid;

end;
procedure TfrmTTFaktur.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;
end;

procedure TfrmTTFaktur.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
      Release;
  end;



end;

procedure TfrmTTFaktur.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;


procedure TfrmTTFaktur.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmTTFaktur.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmTTFaktur.edtKodeClickBtn(Sender: TObject);
begin
  sqlbantuan := ' SELECT sls_kode Kode,sls_nama Nama from tsalesman ';
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
   begin
  edtKode.Text := varglobal;
  edtnamasalesman.Text := varglobal1;
  end;

end;

procedure TfrmTTFaktur.FormShow(Sender: TObject);
begin
  refreshdata;
//  adatabase2 := getnama('tsettingdb','nama','default2','adatabase');
  bacafile2;
//  with MyConnection1 do
//  begin
//   LoginPrompt := False;
//   Server := aHost2;
//   Database := aDatabase2;
//   Username := auser2;
//   Password := apassword2;
//   Connected := True;
//  end;

end;

function TfrmTTFaktur.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'NomorFaktur', ftString, False,20);

    zAddField(FCDS, 'tanggal', ftDate, False);

    zAddField(FCDS, 'nilai', ftfloat, False);
    zAddField(FCDS, 'check', ftBoolean, False);
        zAddField(FCDS, 'nilai2', ftfloat, False);

    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

procedure TfrmTTFaktur.clCustomerPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  var
    i:integer;
    tsql:TmyQuery;
    ss:string;
begin
     sqlbantuan := 'select Nomor,Tanggal,Nilai from (SELECT Nomor,Tanggal,nil-ifnull(retur,0) Nilai FROM ( '
+ ' SELECT fp_nomor Nomor,fp_tanggal Tanggal,fp_cus_kode,(FP_AMOUNT-fp_dp-fp_bayar) nil,'
+ ' (select sum(retj_amount) from tretj_hdr where retj_fp_nomor =fp_nomor) Retur  FROM tfp_hdr ) a'
+ ' WHERE nil-ifnull(retur,0) > 1000'
+ ' and fp_cus_kode='+QUOTEDSTR(edtKodeCustomer.Text)
+ ' order by Nomor ) final ';

//   sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
  begin
   for i := 0 to cxGrdMain.DataController.RecordCount-1 do
    begin

      If (VarToStr(cxGrdMain.DataController.Values[i, clCustomer.Index]) = VarToStr(varglobal)) and (cxGrdMain.DataController.FocusedRecordIndex <> i)
       then
      begin
          ShowMessage('Customer ada yang sama dengan baris '+ IntToStr(i+1));
          CDS.Cancel;
          exit;
      end;
    end;
   If CDS.State <> dsEdit then
         CDS.Edit;

      CDS.FieldByName('nomorfaktur').AsString := varglobal;
      ss:='select fp_nomor,fp_tanggal,fp_amount from tfp_hdr where fp_nomor='+Quot(varglobal);
      tsql :=xOpenQuery(ss,frmMenu.conn);
      with tsql do
      begin
        try
          if not Eof then
          begin
             CDS.FieldByName('tanggal').AsDateTime := Fields[1].AsDateTime;
             cds.FieldByName('nilai').AsFloat := Fields[2].AsFloat;
          end;

        finally
          Free;
        end;
      end;


  end;

end;

procedure TfrmTTFaktur.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmTTFaktur.cxGrdMainKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
if key = VK_DELETE then
begin
  If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;
end;

procedure TfrmTTFaktur.bacafile2;
var
s:string;
tsql:TmyQuery;

 begin
   s:='select ahost,adatabase,auser,apassword from tsetingdb where nama like '+Quot('default2') +';';
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




procedure TfrmTTFaktur.cxButton7Click(Sender: TObject);
begin
  if SaveDlg.Execute then
    ExportGridToExcel(SaveDlg.FileName, cxGrid,True,True,True);

  cxGrdmain.DataController.CollapseDetails;
end;
procedure TfrmTTFaktur.loaddataALL(anomor:String) ;
begin
  if anomor = '' then
  begin
    flagedit := false;
    Exit ;
  end;

end;
procedure TfrmTTFaktur.edtkodecustomerClickBtn(Sender: TObject);
begin
    sqlbantuan := ' SELECT cus_kode Kode,cus_nama Nama,gc_nama Golongan,cus_piutang Piutang from tcustomer '
                  + ' inner join tgolongancustomer on cus_gc_kode=gc_kode';
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
    if varglobal <> '' then
   begin
  edtkodecustomer.Text := varglobal;
  edtNamacustomer.Text := varglobal1;
  end;

end;

function TfrmTTFaktur.getmaxid(asalesman: string; aperiode: string): string;
var
  s: String;
  tsql:TmyQuery;
begin
  s := 'select max(substr(tt_nomor,length(tt_nomor)-2,length(tt_nomor))) from '+adatabase2+'.ttt_hdr where concat(month(tt_tanggal),year(tt_tanggal))='
    + aperiode + ' and tt_sls_kode=' + QuotedStr(asalesman);
  tsql:= xOpenQuery(s,frmMenu.conn);
  if tsql.Fields[0].AsString <> '' then
  begin
    Result := 'TT'+ asalesman + '.' + aperiode + '-' +
      copy(inttostr(strtoint(tsql.Fields[0].AsString) + 1001), 2, 3)

  end
  else
    Result := 'TT'+ asalesman + '.' + aperiode + '-001';

end;

function TfrmTTFaktur.cekdata:boolean;
begin
result := true;
if edtKodeCustomer.Text='' then
begin
  ShowMessage('Customer harus di isi ');
  result := false;
end;

if edtKode.Text='' then
begin
  ShowMessage('salesman harus di isi ');
  result := false;
end;

end;

procedure TfrmTTFaktur.cxButton1Click(Sender: TObject);
var
  s,anomor:string;
//  asalesman :string;
begin
if cekdata then
begin
  anomor := getmaxid(edtKode.Text, FormatDateTime('mmyyyy', date));
  edtnomor.Text := anomor;

//  asalesman:=edtKode.Text;

   s := 'insert into '+adatabase2+'.ttt_hdr (tt_nomor,tt_cus_kode,tt_sls_kode,tt_tanggal)'
    + ' values (' + QuotedStr(anomor) +','+ QuotedStr(edtKodeCustomer.Text)+
    ',' + QuotedStr(edtkode.Text) + ',' +
    QuotedStr(FormatDateTime('yyyy/mm/dd', date)) + ');' ;
      EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
    CDS.First;
  while not cds.eof do
  begin
    if cds.Fieldbyname('check').asboolean = true then
    begin
    s:='insert ignore into '+adatabase2+'.ttt_dtl (ttd_tt_nomor ,ttd_fp_nomor) values ('
    + quotedstr(anomor) + ','
    + quotedstr(cds.Fieldbyname('nomorfaktur').AsString)
    +');';
       EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
   end;
    CDS.next;

  end;
   
   ShowMessage('Simpan berhasil dengan nomor '+ anomor );
  refreshdata;
end;
end;

procedure TfrmTTFaktur.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmTTFaktur.Button1Click(Sender: TObject);
var
  s:string;
  tsql:TmyQuery;
  i:integer;
begin
  i:=1;
s:= 'select Nomor,Tanggal,Nilai from (SELECT Nomor,Tanggal,nil-ifnull(retur,0) Nilai FROM ( '
+ ' SELECT fp_nomor Nomor,fp_tanggal Tanggal,fp_cus_kode,(FP_AMOUNT-fp_dp-fp_bayar) nil,'
+ ' (select sum(retj_amount) from tretj_hdr where retj_fp_nomor =fp_nomor) Retur  FROM tfp_hdr ) a'
+ ' WHERE nil-ifnull(retur,0) > 1000'
+ ' and fp_cus_kode='+QUOTEDSTR(edtKodeCustomer.Text)
+ ' order by Nomor ) final ';

tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
    CDS.EmptyDataSet;
    while  not Eof do
    begin
      CDS.Append;
      CDS.FieldByName('no').asinteger := i;
      CDS.FieldByName('nomorfaktur').AsString := fieldbyname('nomor').AsString;
      CDS.FieldByName('tanggal').AsDateTime := fieldbyname('Tanggal').AsDateTime;
      CDS.FieldByName('nilai').asfloat := fieldbyname('nilai').asfloat;
      CDS.FieldByName('check').AsBoolean:= False;

      CDS.Post;
      i:=i+1;
      next;
    end;
   end;
  finally
    free;
  end;
end;
end;

procedure TfrmTTFaktur.clcheckPropertiesEditValueChanged(Sender: TObject);
var
  i: Integer;
  lVal: Double;
  atanda : boolean;
begin
   cxGrdMain.DataController.Post;

   i := cxGrdMain.DataController.FocusedRecordIndex;
   atanda := cxGrdMain.DataController.Values[i, clcheck.Index];
   lVal := cxGrdMain.DataController.Values[i, clnilai.Index];

if atanda = true then
begin
  If CDS.State <> dsEdit then CDS.Edit;
  CDS.FieldByName('Nilai2').AsFloat := lVal;
  CDS.Post ;
end
else
begin
  If CDS.State <> dsEdit then CDS.Edit;
  CDS.FieldByName('Nilai2').AsFloat := 0;
  CDS.Post ;
end;
end;
end.
