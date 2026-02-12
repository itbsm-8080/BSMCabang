unit ufrmCetakKunjungan;

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
  cxCalendar, MemDS, DBAccess, MyAccess;

type
  TfrmCetakKunjungan = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtNama: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clCustomer: TcxGridDBColumn;
    clNamaCustomer: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    edtKode: TAdvEditBtn;
    cltanggal: TcxGridDBColumn;
    Label1: TLabel;
    cljam: TcxGridDBColumn;
    btnRefresh: TcxButton;
    startdate: TDateTimePicker;
    Label4: TLabel;
    enddate: TDateTimePicker;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    clhari: TcxGridDBColumn;
    cxButton3: TcxButton;
    clKoordinat: TcxGridDBColumn;
    cxButton7: TcxButton;
    savedlg: TSaveDialog;
    clJarak: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure initgrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata;
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
    procedure btnRefreshClick(Sender: TObject);
    procedure bacafile2;
    procedure cxButton3Click(Sender: TObject);
    procedure doslip;
    procedure insertketampungan;
    procedure cxButton7Click(Sender: TObject);

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
  frmCetakKunjungan: TfrmCetakKunjungan;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,ufrmCetak,ureport,cxGridExportLink;

{$R *.dfm}

procedure TfrmCetakKunjungan.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
end;

procedure TfrmCetakKunjungan.refreshdata;
begin
  FID:='';
  startdate.Date := Date;
  enddate.Date :=  date;

  edtKode.Clear;
  edtNama.Clear;
  initgrid;

end;
procedure TfrmCetakKunjungan.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;
end;

procedure TfrmCetakKunjungan.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
      Release;
  end;



end;

procedure TfrmCetakKunjungan.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;


procedure TfrmCetakKunjungan.loaddata;
var
  ssql,s: string;
  tsql2,tsql : TmyQuery;
  i:Integer;
  abulan,atahun : Integer;
begin

s:='SELECT distinct user,x.cus_kode,a.Cus_nama ,tanggal,kar_cabang, DATE_FORMAT(tanggal,"%H:%i:%s") jam,'
+ ' if(dayname(Tanggal)="Monday","Senin",if(dayname(Tanggal)="Tuesday","Selasa",if(dayname(Tanggal)="Wednesday","Rabu",'
+ ' if(dayname(Tanggal)="Thursday","Kamis",if(dayname(Tanggal)="Friday","Jumat",if(dayname(Tanggal)="Saturday","Sabtu","Minggu")))))) Hari,'
+ ' if (latitude <> "","Ada","Kosong") Koordinat,Jarak'
+ ' FROM tkunjungan x INNER JOIN tkaryawan ON kar_nama=user'
+ ' INNER JOIN '+frmMenu.aDatabase+'.tcustomer a ON a.cus_kode=x.cus_kode '
+ ' WHERE tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
+ ' and user  like ' + QuotedStr(edtnama.Text)
+ ' order by tanggal ';
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
      CDS.FieldByName('kode').AsString := fieldbyname('cus_kode').AsString;
      CDS.FieldByName('nama').AsString  := fieldbyname('cus_nama').AsString;
      CDS.FieldByName('tanggal').AsDateTime  := fieldbyname('tanggal').Asdatetime;
      CDS.FieldByName('jam').asstring  := fieldbyname('jam').AsString;
      CDS.FieldByName('hari').asstring  := fieldbyname('hari').AsString;
      CDS.FieldByName('koordinat').asstring  := fieldbyname('koordinat').AsString;
      CDS.FieldByName('jarak').asfloat  := fieldbyname('jarak').asfloat/1000;

      CDS.Post;
      i:=i+1;
      next;
    end;
   end;



end;

end;


procedure TfrmCetakKunjungan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmCetakKunjungan.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmCetakKunjungan.edtKodeClickBtn(Sender: TObject);
begin
  sqlbantuan := ' SELECT sls_kode Kode,sls_nama Nama from tsalesman ';
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
   begin
  edtKode.Text := varglobal;
  edtNama.Text := varglobal1;
  end;

end;

procedure TfrmCetakKunjungan.FormShow(Sender: TObject);
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

function TfrmCetakKunjungan.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Kode', ftString, False,20);
    zAddField(FCDS, 'Nama', ftstring, False,100);
    zAddField(FCDS, 'tanggal', ftDate, False);
    zAddField(FCDS, 'jam', ftString, False,20);
    zAddField(FCDS, 'hari', ftString, False,20);
    zAddField(FCDS, 'koordinat', ftString, False,20);
    zAddField(FCDS, 'jarak', ftfloat, False);

    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

procedure TfrmCetakKunjungan.clCustomerPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  var
    i:integer;
begin
     sqlbantuan := ' SELECT cus_kode Kode,cus_nama Nama,gc_nama Golongan,cus_piutang Piutang from tcustomer '
                  + ' inner join tgolongancustomer on cus_gc_kode=gc_kode';
  sqlfilter := 'Kode,Nama';
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

      CDS.FieldByName('kode').AsString := varglobal;
      CDS.FieldByName('nama').AsString := varglobal1;

  end;

end;

procedure TfrmCetakKunjungan.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmCetakKunjungan.cxGrdMainKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
if key = VK_DELETE then
begin
  If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;
end;

procedure TfrmCetakKunjungan.btnRefreshClick(Sender: TObject);
begin
loaddata();
end;

procedure TfrmCetakKunjungan.bacafile2;
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




procedure TfrmCetakKunjungan.cxButton3Click(Sender: TObject);
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan;
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'CetakKunjungan';
   s:='select '+ QuotedStr(edtNama.Text) +' salesman ,'
   + QuotedStr(FormatDateTime('dd/mm/yyyy',startdate.Date)) + ' tgl1 ,'
   + QuotedStr(FormatDateTime('dd/mm/yyyy',enddate.Date)) + ' tgl2 ,'
   + QuotedStr(frmMenu.NMCABANG) +' CABANG ,'

   + 'a.* from tampung2 a order by tanggal';

    ftsreport.AddSQL(s);

    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure tfrmCetakKunjungan.doslip;
var
  s: string ;
  tsqlheader,tsql2,tsql : TmyQuery;
  abaris,i,a:Integer;
  arekening,anamabarang,TERBILANG : String;
  anilaipiutang:double;
  afreight,adiscfaktur,adp,atotal,anilai,appn : Double;
  apj,apjno : string;

begin

 Application.CreateForm(TfrmCetak,frmCetak);
 abaris := 12;
 with frmCetak do
 begin
    memo.Clear;
      memo.Lines.Add('');

       s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp,perush_npwp,perush_pak,perush_pj,perush_pj_no '
      + ' from tperusahaan ';

  tsqlheader := xOpenQuery(s, frmMenu.conn);
  with tsqlheader do
  begin
    try
      memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' K U N J U N G A N  S A L E S M A N  ', 40 , ' '));
      memo.Lines.Add(StrPadRight(Fields[1].AsString ,60, ' '));

    finally

    end;
  end;

  with CDS do
  begin
  try

     if not Eof then
    begin
      memo.lines.add('Salesman : ' + edtNama.Text);
      memo.Lines.Add('Periode  : ' + FormatDateTime('yyyy/mm/dd',startdate.DateTime)+ ' s/d ' + FormatDateTime('yyyy/mm/dd',enddate.DateTime));
      memo.lines.add('');
      memo.Lines.Add(StrPadRight('', 120, '-'));
      memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
                          +StrPadRight('Kode', 8, ' ')+' '
                          +StrPadRight('Nama', 44, ' ')+' '
                          +StrPadRight('Tanggal', 20, ' ')+' '
                          +StrPadRight('Jam', 10, ' ')+' '
                          +StrPadRight('Hari', 20, ' ')+' '
                          );
       memo.Lines.Add(StrPadRight('', 120, '-'));
    end;
    cds.first;
     while not eof do
     begin

       i:=i+1;
       memo.Lines.Add(StrPadRight(IntToStr(i), 3, ' ')+' '
                          +StrPadRight(fieldbyname('kode').AsString, 8, ' ')+' '
                          +StrPadRight(fieldbyname('nama').AsString, 44, ' ')+' '
                          +StrPadRight(FormatDateTime('dd/mm/yyyy', fieldbyname('tanggal').Asdatetime), 20, ' ')+' '
                          +StrPadRight(fieldbyname('jam').AsString, 10, ' ')+' '
                          +StrPadRight(fieldbyname('hari').AsString, 20, ' ')+' '
                          );
       Next;
       if (i mod abaris =0) and (not eof) then
       begin
         memo.Lines.Add(StrPadRight('', 120, '-'));
            for a:=1 to 10 do
            begin
              memo.Lines.Add('');
            end;
            with tsqlheader do
            begin
              try
                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' K U N J U N G A N  S A L E S M A N  ', 40 , ' '));
                memo.Lines.Add(StrPadRight(Fields[1].AsString ,60, ' '));

              finally

              end;
            end;

      memo.lines.add('Salesman : ' + edtNama.Text);
      memo.Lines.Add('Periode  : ' + FormatDateTime('yyyy/mm/dd',startdate.DateTime)+ ' s/d ' + FormatDateTime('yyyy/mm/dd',enddate.DateTime));
      memo.lines.add('');
      memo.Lines.Add(StrPadRight('', 120, '-'));
      memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
                          +StrPadRight('Kode', 8, ' ')+' '
                          +StrPadRight('Nama', 44, ' ')+' '
                          +StrPadRight('Tanggal', 20, ' ')+' '
                          +StrPadRight('Jam', 10, ' ')+' '
                          +StrPadRight('Hari', 20, ' ')+' '
                          );
               memo.Lines.Add(StrPadRight('', 120, '-'));


       end;

     end;
    if  i mod abaris <> 0 then
    begin
      for a:=1 to (abaris - (i mod abaris)) do
      begin
        memo.Lines.Add('');
      end;
    end;
    memo.Lines.Add(StrPadRight('', 120, '-'));
         memo.Lines.Add(      StrPadRight('', 20, ' ')+' '
                          +StrPadRight('DiBuat oleh,', 32, ' ')+' '
                          +StrPadRight('Mengetehui,  ', 32, ' ')
                          +StrPadRight('Atasan,  ', 30, ' ')

                          );
//


    memo.Lines.Add('');
    memo.Lines.Add('');
    memo.Lines.Add(  StrPadRight('', 21, ' ')
                          +StrPadRight('(               )', 32, ' ')+' '
                          +StrPadRight('(               )', 32, ' ')+' '
                          +StrPadRight('(               )', 30, ' ')
                          );




    memo.Lines.Add('');
    memo.Lines.Add('');




  finally
    tsqlheader.free;
     free;
  end
  end;
  end;
    frmCetak.ShowModal;
END;

procedure TfrmCetakKunjungan.insertketampungan;
var
  s:string;
  tsql : TmyQuery;
  a,i,x:integer;
  tt : TStrings;
begin
  s:='delete from tampung2 ';
    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
  
  tt:=TStringList.Create;
    cds.First;
    with CDS do
    begin
      try
       while not Eof do
       begin
         x:=x+1;
          s :=   'insert  into tampung2 '
                  + '('
                  + ')values ('
                  + Quot(fieldbyname('kode').Asstring)+','
                  + Quot(fieldbyname('nama').Asstring)+','
                  + Quotd(fieldbyname('tanggal').AsDateTime) +','
                  + Quot(fieldbyname('jam').Asstring)+','
                  + Quot(fieldbyname('hari').Asstring)  +','
                  + quot(fieldbyname('koordinat').Asstring)+','
                  + floattostr(fieldbyname('jarak').asfloat)

                  + ');';
          tt.Append(s);
        Next
       end;
       finally

      end;
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

procedure TfrmCetakKunjungan.cxButton7Click(Sender: TObject);
begin
  if SaveDlg.Execute then
    ExportGridToExcel(SaveDlg.FileName, cxGrid,True,True,True);

  cxGrdmain.DataController.CollapseDetails;
end;

end.
