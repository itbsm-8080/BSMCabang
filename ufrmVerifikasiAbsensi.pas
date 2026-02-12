unit ufrmVerifikasiAbsensi;

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
  cxCalendar, MemDS, DBAccess, MyAccess, cxDropDownEdit, cxRichEdit,
  DBGrids;

type
  TfrmVerifikasiAbsensi = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel4: TAdvPanel;
    Label1: TLabel;
    btnRefresh: TcxButton;
    startdate: TDateTimePicker;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    cxButton7: TcxButton;
    savedlg: TSaveDialog;
    cxButton1: TcxButton;
    MyQuery2: TMyQuery;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clCustomer: TcxGridDBColumn;
    clNamaCustomer: TcxGridDBColumn;
    cltanggal: TcxGridDBColumn;
    cljam: TcxGridDBColumn;
    clhari: TcxGridDBColumn;
    clKeterangan: TcxGridDBColumn;
    clAlasan: TcxGridDBColumn;
    clApprove: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    DBGrid1: TDBGrid;
    MyQuery3: TMyQuery;
    DataSource1: TDataSource;
    clpotong: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure initgrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata;
    function cekdata:Boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton8Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure cxGrdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnRefreshClick(Sender: TObject);
    procedure bacafile2;
    procedure cxButton7Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
   function getstatus(anik:string ;atanggal:TDateTime):string;
   function getketerangan(anik:string;atanggal:TDateTime):string;
   function getisapprove(anik:string;atanggal:TDateTime):string;
   function getpotong(anik:string;atanggal:TDateTime):string;

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
  frmVerifikasiAbsensi: TfrmVerifikasiAbsensi;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,ufrmCetak,ureport,cxGridExportLink;

{$R *.dfm}

procedure TfrmVerifikasiAbsensi.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
end;

procedure TfrmVerifikasiAbsensi.refreshdata;
begin
  FID:='';
  startdate.Date := Date;

  initgrid;

end;
procedure TfrmVerifikasiAbsensi.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;
end;

procedure TfrmVerifikasiAbsensi.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
      Release;
  end;



end;

procedure TfrmVerifikasiAbsensi.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;


procedure TfrmVerifikasiAbsensi.loaddata;
var
  ssql,s: string;
  tsql2,tsql : TmyQuery;
  i:Integer;
  abulan,atahun : Integer;
begin
 MyQuery3.Close;
 MyQuery3.SQL.Text := 'call lapverifikasi('+quot(frmmenu.KDCABANG)+','+QuotD(startdate.DateTime)+')';
 MyQuery3.Open;


s:='SELECT *,if(jam>="08:01:00","Terlambat","") keterangan FROM ( '
+ ' SELECT DISTINCT c.kar_nik,kar_nama,tanggal,DATE_FORMAT(tanggal,"%H:%i:%s") Jam,'
+ ' ROW_NUMBER() OVER (PARTITION BY c.kar_nik ORDER BY a.tanggal asc) AS row_num'
+ ' FROM tkaryawan c'
+ ' INNER JOIN tunit b ON c.kar_kd_unit=b.kd_unit AND kar_status_aktif=1 and kar_pengecualian=0'
+ ' LEFT join tabsensitampung a  ON a.kar_nik=c.kar_nik and DATE_FORMAT(tanggal,"%Y/%m/%d")='+QuotD(startdate.DateTime)
+ ' WHERE b.kode_cabang='+Quot(frmMenu.KDCABANG)+' ) final'
+ ' where row_num=1';
MyQuery1.Close;
MyQuery1.SQL.Text := s;
MyQuery1.Open;
with MyQuery1 do
begin

    if not Eof then
    begin
    CDS.EmptyDataSet;
    while  not Eof do
    begin
      CDS.Append;
      CDS.FieldByName('kode').AsString := fieldbyname('kar_nik').AsString;
      CDS.FieldByName('nama').AsString  := fieldbyname('kar_nama').AsString;
      CDS.FieldByName('tanggal').AsDateTime  := startdate.DateTime;
      CDS.FieldByName('jam').asstring  := fieldbyname('jam').AsString;

      If fieldbyname('jam').AsString = '' then
         CDS.FieldByName('keterangan').asstring  := 'Tidak Masuk'

      else
         CDS.FieldByName('keterangan').asstring  := fieldbyname('keterangan').AsString;
      if CDS.FieldByName('keterangan').asstring = '' then
         CDS.FieldByName('status').asstring  := 'OK'
      else
      begin
         CDS.FieldByName('status').asstring  := getstatus(fieldbyname('kar_nik').AsString, startdate.DateTime);
         CDS.FieldByName('Alasan').asstring  := getketerangan(fieldbyname('kar_nik').AsString, startdate.DateTime);

      end;

         CDS.FieldByName('approved').asstring  := getisapprove(fieldbyname('kar_nik').AsString, startdate.DateTime);
         CDS.FieldByName('potong').asstring    := getpotong(fieldbyname('kar_nik').AsString, startdate.DateTime);

      CDS.Post;
      i:=i+1;
      next;
    end;
   end;



end;

end;

function TfrmVerifikasiabsensi.cekdata:Boolean;
begin
  result:= True;
   cds.first;
   While not CDS.Eof do
   begin
     if cds.FieldByName('status').AsString = '' then
     begin
       ShowMessage('ada status yang belum di pilih');
       Result:=False;
       Exit;
     end;
     CDS.Next;
   end ;
end;
procedure TfrmVerifikasiAbsensi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmVerifikasiAbsensi.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmVerifikasiAbsensi.FormShow(Sender: TObject);
begin
refreshdata;
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

function TfrmVerifikasiAbsensi.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Kode', ftString, False,20);
    zAddField(FCDS, 'Nama', ftstring, False,100);
    zAddField(FCDS, 'tanggal', ftDate, False);
    zAddField(FCDS, 'jam', ftString, False,20);
    zAddField(FCDS, 'status', ftString, False,20);
    zAddField(FCDS, 'keterangan', ftString, False,20);
    zAddField(FCDS, 'potong', ftString, False,20);
    zAddField(FCDS, 'alasan', ftString, False,100);
    zAddField(FCDS, 'approved', ftString, False,10);

    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

procedure TfrmVerifikasiAbsensi.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmVerifikasiAbsensi.cxGrdMainKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
if key = VK_DELETE then
begin
  If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;
end;

procedure TfrmVerifikasiAbsensi.btnRefreshClick(Sender: TObject);
begin
loaddata();
end;

procedure TfrmVerifikasiAbsensi.bacafile2;
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
       aDatabase2 := 'hrd';
       auser2     := fields[2].AsString;
       apassword2 := fields[3].AsString;

    finally
      free;
    end;
  end;

 end;




procedure TfrmVerifikasiAbsensi.cxButton7Click(Sender: TObject);
begin
  if SaveDlg.Execute then
    ExportGridToExcel(SaveDlg.FileName, cxGrid,True,True,True);

  cxGrdmain.DataController.CollapseDetails;
end;

procedure TfrmVerifikasiAbsensi.cxButton1Click(Sender: TObject);
var
  s:String;
  tt:TStrings;
  i:integer;
begin
  if not cekdata  then
   Exit;
   
  tt := TStringList.Create;
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   s:= ' delete from tabsensifix  '
      + ' where  abs_tanggal =' + quotd(cds.fieldbyname('tanggal').asdatetime)
      + ' and abs_nik='+Quot(cds.fieldbyname('kode').AsString)+';';
   tt.Append(s);
    if CDS.FieldByName('jam').AsString = '' then
    begin
      S:='insert into tabsensifix(abs_nik,abs_nama,abs_tanggal,abs_keterangan,abs_status,abs_alasan,abs_isapprove,abs_potong) values ('
      + Quot(CDS.FieldByName('kode').AsString) +','
      + Quot(CDS.FieldByName('nama').AsString) +','
      + QuotD(CDS.FieldByName('tanggal').AsDateTime)+','
      + Quot(CDS.FieldByName('keterangan').AsString) + ','
      + Quot(CDS.FieldByName('status').AsString)+','
      + Quot(CDS.FieldByName('alasan').AsString)+','
      + Quot(CDS.FieldByName('approved').AsString)+','
      + Quot(CDS.FieldByName('potong').AsString)
      + ');';
      tt.Append(s);
    end
    else
    begin
    S:='insert into tabsensifix(abs_nik,abs_nama,abs_tanggal,abs_jammasuk,abs_keterangan,abs_potong,abs_status,abs_alasan,abs_isapprove) values ('
      + Quot(CDS.FieldByName('kode').AsString) +','
      + Quot(CDS.FieldByName('nama').AsString) +','
      + QuotD(CDS.FieldByName('tanggal').AsDateTime)+','
      + QuotD(CDS.FieldByName('jam').AsDateTime,true)+','
      + Quot(CDS.FieldByName('keterangan').AsString) + ','
      + Quot(CDS.FieldByName('potong').AsString) + ','
      + Quot(CDS.FieldByName('status').AsString) +','
      + Quot(CDS.FieldByName('alasan').AsString) + ','
      + Quot(CDS.FieldByName('approved').AsString)
      + ');';
      tt.Append(s);
    end;
    CDS.Next;
    Inc(i);
  end;
//      tt.SaveToFile('ss.txt');
     try
        for i:=0 to tt.Count -1 do
        begin
            MyConnection1.ExecSQL(tt[i],[]);
        end;
      finally
        tt.Free;
      end;
      ShowMessage('Proses Simpan Berhasil');
end;

function TfrmVerifikasiAbsensi.getstatus(anik:string;atanggal:TDateTime):string;
var
s:string;
begin
   result:='';
   s:='select abs_status from tabsensifix where abs_nik='+quot(anik)
   + ' and abs_tanggal='+quotd(atanggal);
   MyQuery2.Close;
   MyQuery2.SQL.Text := s;
   MyQuery2.Open;
   MyQuery2.First;
   if not MyQuery2.Eof then
   begin
     Result := MyQuery2.Fields[0].AsString;
   end;
end;

function TfrmVerifikasiAbsensi.getketerangan(anik:string;atanggal:TDateTime):string;
var
s:string;
begin
   result:='';
   s:='select abs_alasan from tabsensifix where abs_nik='+quot(anik)
   + ' and abs_tanggal='+quotd(atanggal);
   MyQuery2.Close;
   MyQuery2.SQL.Text := s;
   MyQuery2.Open;
   MyQuery2.First;
   if not MyQuery2.Eof then
   begin
     Result := MyQuery2.Fields[0].AsString;
   end;
end;
function TfrmVerifikasiAbsensi.getisapprove(anik:string;atanggal:TDateTime):string;
var
s:string;
begin
   result:='';
   s:='select abs_isapprove from tabsensifix where abs_nik='+quot(anik)
   + ' and abs_tanggal='+quotd(atanggal);
   MyQuery2.Close;
   MyQuery2.SQL.Text := s;
   MyQuery2.Open;
   MyQuery2.First;
   if not MyQuery2.Eof then
   begin
     Result := MyQuery2.Fields[0].AsString;
   end;
end;

function TfrmVerifikasiAbsensi.getpotong(anik:string;atanggal:TDateTime):string;
var
s:string;
begin
   result:='';
   s:='select abs_potong from tabsensifix where abs_nik='+quot(anik)
   + ' and abs_tanggal='+quotd(atanggal);
   MyQuery2.Close;
   MyQuery2.SQL.Text := s;
   MyQuery2.Open;
   MyQuery2.First;
   if not MyQuery2.Eof then
   begin
     Result := MyQuery2.Fields[0].AsString;
   end;
end;

end.

