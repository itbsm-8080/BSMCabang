unit ufrmPenugasanDriver;

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
  cxCalendar, MemDS, DBAccess, MyAccess, cxCheckBox, cxContainer, cxLabel;

type
  TfrmPenugasanDriver = class(TForm)
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
    clNomorDO: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    edtKode: TAdvEditBtn;
    cltanggal: TcxGridDBColumn;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    savedlg: TSaveDialog;
    edtkodecustomer: TAdvEditBtn;
    edtnamadriver: TAdvEdit;
    cxButton1: TcxButton;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    clcheck: TcxGridDBColumn;
    Button1: TButton;
    Label1: TLabel;
    startdate: TDateTimePicker;
    Label4: TLabel;
    enddate: TDateTimePicker;
    cxLabel1: TcxLabel;
    Label5: TLabel;
    edtKode2: TAdvEditBtn;
    edtnamadriver2: TAdvEdit;
    clNomorFaktur: TcxGridDBColumn;
    clCustomer: TcxGridDBColumn;
    Button2: TButton;
    Button3: TButton;
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
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure cxGrdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bacafile2;
    procedure cxButton7Click(Sender: TObject);
    procedure edtkodecustomerClickBtn(Sender: TObject);
    function cekdata:boolean;
    procedure cxButton1Click(Sender: TObject);
    procedure HapusRecord1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure clcheckPropertiesEditValueChanged(Sender: TObject);
    procedure edtKode2ClickBtn(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);

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
  frmPenugasanDriver: TfrmPenugasanDriver;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,ufrmCetak,ureport,cxGridExportLink,
  ufrmTTfaktur;

{$R *.dfm}

procedure TfrmPenugasanDriver.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
end;

procedure TfrmPenugasanDriver.refreshdata;
begin
  startdate.Date := Date;
  enddate.Date :=  date;
  edtKode.Clear;
  edtnamadriver.Clear;
  edtKode2.Clear;
  edtnamadriver2.Clear;
  edtkodecustomer.Clear;
  edtNamacustomer.Clear;
  initgrid;
end;
procedure TfrmPenugasanDriver.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;
end;

procedure TfrmPenugasanDriver.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
      Release;
  end;



end;

procedure TfrmPenugasanDriver.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;


procedure TfrmPenugasanDriver.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmPenugasanDriver.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmPenugasanDriver.edtKodeClickBtn(Sender: TObject);
begin
  sqlbantuan := ' SELECT kar_namasingkat Kode, UPPER(kar_nama) Nama FROM tcabang '
       + ' INNER JOIN hrd.tunit ON kode_cabang = cbg_kode '
       + ' INNER JOIN hrd.tkaryawan ON kar_kd_unit = kd_unit '
       + ' WHERE cbg_aktif = 1 and (kar_kd_jabat = 21 OR kar_kd_jabat = 30) AND kar_status_aktif = 1'
       + ' UNION ALL SELECT "SALES", "SALES" UNION ALL SELECT "EKSPEDISI", "EKSPEDISI"';
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
   begin
  edtKode.Text := varglobal;
  edtnamadriver.Text := varglobal1;
  end;

end;

procedure TfrmPenugasanDriver.FormShow(Sender: TObject);
begin
  refreshdata;
//  adatabase2 := getnama('tsettingdb','nama','default2','adatabase');
//  bacafile2;
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

function TfrmPenugasanDriver.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'NomorDO', ftString, False,50);
    zAddField(FCDS, 'NomorFaktur', ftString, False,50);
    zAddField(FCDS, 'Customer', ftString, False,200);
    zAddField(FCDS, 'tanggal', ftDate, False);
    zAddField(FCDS, 'check', ftBoolean, False);

    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

procedure TfrmPenugasanDriver.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmPenugasanDriver.cxGrdMainKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
if key = VK_DELETE then
begin
  If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;
end;

procedure TfrmPenugasanDriver.bacafile2;
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




procedure TfrmPenugasanDriver.cxButton7Click(Sender: TObject);
begin
  if SaveDlg.Execute then
    ExportGridToExcel(SaveDlg.FileName, cxGrid,True,True,True);

  cxGrdmain.DataController.CollapseDetails;
end;

procedure TfrmPenugasanDriver.edtkodecustomerClickBtn(Sender: TObject);
begin
    sqlbantuan := ' select cus_kode Kode, cus_nama as Nama, Cus_alamat Alamat,cus_shipaddress,cus_jc_kode jenis'
        +' from tcustomer';
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

function TfrmPenugasanDriver.cekdata:boolean;
begin
result := true;
//if edtKodeCustomer.Text='' then
//begin
//  ShowMessage('Customer harus di isi ');
//  result := false;
//end;
//
//if edtKode.Text='' then
//begin
//  ShowMessage('salesman harus di isi ');
//  result := false;
//end;

end;

procedure TfrmPenugasanDriver.cxButton1Click(Sender: TObject);
var
  s,anomor:string;
//  asalesman :string;
begin
if cekdata then
begin
    CDS.First;
  while not cds.eof do
  begin
    if cds.Fieldbyname('check').asboolean = true then
    begin
     s:='update Tdo_HDR set '
    + ' do_driver = ' + Quot(edtKode2.Text) + ','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where do_nomor = ' + quotedstr(cds.Fieldbyname('NomorDO').AsString);

       EnsureConnected(frmMenu.conn);
      ExecSQLDirect(frmMenu.conn, s);
   end;
    CDS.next;

  end;
   
   ShowMessage('Simpan berhasil');
  refreshdata;
end;
end;

procedure TfrmPenugasanDriver.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmPenugasanDriver.Button1Click(Sender: TObject);
var
  s, sfilter:string;
  tsql:TmyQuery;
  i:integer;
begin
  i:=1;
  sfilter := '';
  if edtKode.Text <> '' then
    sfilter := sfilter + ' AND do_driver = ' + QUOTEDSTR(edtKode.Text);
  if edtkodecustomer.Text <> '' then
     sfilter := sfilter + ' AND do_cus_kode = ' + QUOTEDSTR(edtkodecustomer.Text);

s:= 'SELECT a.do_nomor Nomor, fp.FP_nomor Faktur, a.do_tanggal Tanggal, Cus_nama Customer, Cus_alamat Alamat, Cus_kode, a.do_driver '
  + ' FROM tdo_hdr a '
  + ' INNER JOIN tcustomer ON a.do_cus_Kode = Cus_kode '
  + ' LEFT JOIN tfp_hdr fp ON a.do_nomor = fp.FP_DO_nomor '
  + ' WHERE NOT EXISTS ( '
  + '      SELECT 1 '
  + '      FROM tpod_hdr b '
  + '      WHERE b.pod_do_nomor = a.do_nomor '
  + '  ) '
  + '  AND NOT EXISTS( '
  + '      SELECT 1 '
  + '      FROM tfp_hdr f '
  + '      INNER JOIN tretj_hdr t ON t.retj_fp_nomor = f.FP_nomor '
  + '      WHERE f.FP_DO_nomor = a.do_nomor '
  + '  ) '
  + ' AND a.do_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
  + sfilter;

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
      CDS.FieldByName('NomorDO').AsString := fieldbyname('Nomor').AsString;
      CDS.FieldByName('NomorFaktur').AsString := fieldbyname('Faktur').AsString;
      CDS.FieldByName('tanggal').AsDateTime := fieldbyname('Tanggal').AsDateTime;
      CDS.FieldByName('Customer').AsString := fieldbyname('Customer').AsString;
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

procedure TfrmPenugasanDriver.clcheckPropertiesEditValueChanged(Sender: TObject);
var
  i: Integer;
  lVal: Double;
  atanda : boolean;
begin
   cxGrdMain.DataController.Post;

   i := cxGrdMain.DataController.FocusedRecordIndex;
   atanda := cxGrdMain.DataController.Values[i, clcheck.Index];
//   lVal := cxGrdMain.DataController.Values[i, clnilai.Index];

//if atanda = true then
//begin
//  If CDS.State <> dsEdit then CDS.Edit;
//  CDS.FieldByName('Nilai2').AsFloat := lVal;
//  CDS.Post ;
//end
//else
//begin
//  If CDS.State <> dsEdit then CDS.Edit;
//  CDS.FieldByName('Nilai2').AsFloat := 0;
//  CDS.Post ;
//end;
end;

procedure TfrmPenugasanDriver.edtKode2ClickBtn(Sender: TObject);
begin
  sqlbantuan := ' SELECT kar_namasingkat Kode, UPPER(kar_nama) Nama FROM tcabang '
       + ' INNER JOIN hrd.tunit ON kode_cabang = cbg_kode '
       + ' INNER JOIN hrd.tkaryawan ON kar_kd_unit = kd_unit '
       + ' WHERE cbg_aktif = 1 and (kar_kd_jabat = 21 OR kar_kd_jabat = 30) AND kar_status_aktif = 1'
       + ' UNION ALL SELECT "SALES", "SALES" UNION ALL SELECT "EKSPEDISI", "EKSPEDISI"';
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
   begin
  edtKode2.Text := varglobal;
  edtnamadriver2.Text := varglobal1;
  end;
end;

procedure TfrmPenugasanDriver.Button2Click(Sender: TObject);
begin
     CDS.Filter := cxGrdMain.DataController.Filter.FilterText;
     CDS.Filtered := True;
     CDS.First;

  while not CDS.Eof do
  begin
      If CDS.State <> dsEdit then CDS.Edit;
    CDS.FieldByName('check').AsBoolean := True;
    CDS.Next;

  end;
  CDS.Filtered := False;
end;

procedure TfrmPenugasanDriver.Button3Click(Sender: TObject);
begin
    CDS.Filter := cxGrdMain.DataController.Filter.FilterText;
    CDS.Filtered := True;
    CDS.First;

  while not CDS.Eof do
    begin
        If CDS.State <> dsEdit then CDS.Edit;
          CDS.FieldByName('check').AsBoolean := False;
          CDS.Next;

    end;
  CDS.Filtered := False;

end;

end.
