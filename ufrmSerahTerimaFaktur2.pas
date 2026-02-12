unit ufrmSerahTerimaFaktur2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox, DBClient, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxSpinEdit, cxCurrencyEdit, AdvEdBtn,DateUtils,
  cxCalendar, cxCheckBox, frxClass, frxDMPExport, MyAccess;

type
  TfrmSerahTerimaFaktur2 = class(TForm)
    PANEL: TAdvPanel;
    Label2: TLabel;
    edtNomor: TAdvEdit;
    Label3: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clInvoice: TcxGridDBColumn;
    clTglInvoice: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lbljudul: TLabel;
    dtTanggal: TDateTimePicker;
    clNilai: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    clStatus: TcxGridDBColumn;
    Label10: TLabel;
    edtmemo: TMemo;
    clPPN: TcxGridDBColumn;
    clCustomer: TcxGridDBColumn;
    Label1: TLabel;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    cxLookupSales: TcxExtLookupComboBox;
    Button1: TButton;
    clJatuhTempo: TcxGridDBColumn;
    clOverdue: TcxGridDBColumn;
    clRangeOverdue: TcxGridDBColumn;
    procedure refreshdata;
   procedure initgrid;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function getmaxkode:string;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure HapusRecord1Click(Sender: TObject);
    procedure dtTanggalChange(Sender: TObject);
    procedure simpandata;
    function cekdata:Boolean;
    procedure loaddataInvoice(akode : string);
    procedure loaddataall(akode : string);
    procedure edtSalesmanExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    FCDSSalesman: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    atanggalold:TDateTime;
    function GetCDSSalesman: TClientDataset;
    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDSSalesman: TClientDataset read GetCDSSalesman write FCDSSalesman;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    procedure doslip(anomor : string );
    procedure doslip2(anomor : string );
    { Public declarations }
  end;

var
  frmSerahTerimaFaktur2: TfrmSerahTerimaFaktur2;

const
   NOMERATOR = 'ST';

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmfp,ufrmCetak;

{$R *.dfm}

procedure TfrmSerahTerimaFaktur2.refreshdata;
begin
  FID := '';

  FLAGEDIT := False;
  dtTanggal.DateTime := Date;
 
  edtnomor.Text := getmaxkode;
  cxLookupSales.EditValue := '';
  edtmemo.Clear;
  dtTanggal.SetFocus;
  initgrid;
end;

procedure TfrmSerahTerimaFaktur2.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;
end;

procedure TfrmSerahTerimaFaktur2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmSerahTerimaFaktur2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Release;
end;

function TfrmSerahTerimaFaktur2.getmaxkode:string;
var
  s: String;
begin
  s := 'select max(right(sth2_nomor,4)) from tserahterimafaktur_hdr2 where sth2_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%');

  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
        result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+1),4)
      else
        result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+fields[0].AsInteger+1),4);
    finally
      free;
    end;
  end;
end;

procedure TfrmSerahTerimaFaktur2.cxButton1Click(Sender: TObject);
begin
  try
    if cekTutupPeriode(dtTanggal.Date) then
      Exit;

    If not cekdata then exit;

    if (FLAGEDIT) and ( not cekedit(frmMenu.KDUSER,self.name)) then
    begin
      MessageDlg('Anda tidak berhak Edit di Modul ini',mtWarning, [mbOK],0);
      Exit;
    End;

    if (not FLAGEDIT) and ( not cekinsert(frmMenu.KDUSER,self.name)) then
    begin
      MessageDlg('Anda tidak berhak Insert di Modul ini',mtWarning, [mbOK],0);;
      Exit;
    End;

    if MessageDlg('Yakin ingin simpan ?',mtCustom,
                            [mbYes,mbNo], 0)= mrNo
    then Exit ;

    simpandata;
    refreshdata;
  except
    ShowMessage('Gagal Simpan');
    Exit;
  end;
end;

procedure TfrmSerahTerimaFaktur2.cxButton8Click(Sender: TObject);
begin
  Release;
end;

procedure TfrmSerahTerimaFaktur2.cxButton2Click(Sender: TObject);
begin
  try
    if cekTutupPeriode(dtTanggal.Date) then  Exit;

    If not cekdata then exit;

    if (FLAGEDIT) and ( not cekedit(frmMenu.KDUSER,self.name)) then
    begin
      MessageDlg('Anda tidak berhak Edit di Modul ini',mtWarning, [mbOK],0);
      Exit;
    End;

    if (not FLAGEDIT) and ( not cekinsert(frmMenu.KDUSER,self.name)) then
    begin
      MessageDlg('Anda tidak berhak Insert di Modul ini',mtWarning, [mbOK],0);
      Exit;
    End;

    if MessageDlg('Yakin ingin simpan ?',mtCustom,
                            [mbYes,mbNo], 0)= mrNo
    then Exit;

    simpandata;
    refreshdata;
  except
    ShowMessage('Gagal Simpan');
    Exit;
  end;

  Release;
end;

procedure TfrmSerahTerimaFaktur2.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxlookupsales.Properties) do
    LoadFromCDS(CDSSalesman, 'Kode','Salesman',['Kode'],Self);

  TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
end;

function TfrmSerahTerimaFaktur2.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Customer', ftString, False,200);
    zAddField(FCDS, 'Faktur', ftString, False,20);
    zAddField(FCDS, 'Tanggal', ftDate, False);
    zAddField(FCDS, 'PPN', ftFloat, False);
    zAddField(FCDS, 'Nilai', ftFloat, False);
    zAddField(FCDS, 'JatuhTempo', ftDate, False);
    zAddField(FCDS, 'Overdue', ftString, False,30);
    zAddField(FCDS, 'RangeOverdue', ftString, False,30);
    zAddField(FCDS, 'check', ftInteger, False);
    FCDS.CreateDataSet;
  end;

  Result := FCDS;
end;

procedure TfrmSerahTerimaFaktur2.FormShow(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmSerahTerimaFaktur2.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;

  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmSerahTerimaFaktur2.HapusRecord1Click(Sender: TObject);
begin
  If CDS.Eof then exit;

  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmSerahTerimaFaktur2.dtTanggalChange(Sender: TObject);
var
  anomorold:string;
  anomornew:string;
begin
  anomorold := edtNomor.Text;
  anomornew := getmaxkode;

  if FLAGEDIT then
  begin
    if Copy(anomornew,1,11) <> Copy(anomorold,1,11)then
    begin
      showmessage('Perubahan tanggal tidak bisa beda bulan dan tahun');
      edtNomor.Text := anomorold;
      dtTanggal.Date :=atanggalold;
    end;
  end;
end;

procedure TfrmSerahTerimaFaktur2.simpandata;
var
  s: String;
  atax, i: integer;
  tt: TStrings;
begin
  if FLAGEDIT then
    s := ' Update tserahterimafaktur_hdr2 set '
       + ' sth2_sls_kode = ' + Quot(cxLookupSales.EditValue) + ','
       + ' sth2_memo = ' + Quot(edtmemo.Text) + ','
       + ' sth2_tanggal = ' + Quotd(dtTanggal.Date)+','
       + ' date_modify  = ' + QuotD(cGetServerTime,True) + ','
       + ' user_modify = ' + Quot(frmMenu.KDUSER)
       + ' where sth2_nomor = ' + quot(FID) + ';'
  else
  begin
    edtNomor.Text := getmaxkode;

    s := ' insert into tserahterimafaktur_hdr2 '
       + ' (sth2_nomor, sth2_tanggal, sth2_sls_kode, sth2_memo, date_create, user_create) '
       + ' values ( '
       + Quot(edtNomor.Text) + ','
       + Quotd(dtTanggal.Date) + ','
       + Quot(cxLookupsales.EditValue)+','
       + Quot(edtmemo.Text)+','
       + QuotD(cGetServerTime,True) + ','
       + Quot(frmMenu.KDUSER)+')';
  end;
  
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  tt := TStringList.Create;
  s := ' delete from tserahterimafaktur_dtl2 '
     + ' where std2_sth2_nomor =' + quot(FID);
  tt.Append(s);
  CDS.First;
  i := 1;

  while not CDS.Eof do
  begin
    if CDS.FieldByName('check').AsInteger = 1 then
    begin
      S := ' insert into tserahterimafaktur_dtl2 (std2_sth2_nomor, std2_fp_nomor) values ( '
         + Quot(edtNomor.Text) +','
         + quot(CDS.FieldByName('faktur').AsString)
         + ');';
         
      tt.Append(s);
    end;
    
    CDS.Next;
    Inc(i);
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

function TfrmSerahTerimaFaktur2.cekdata:Boolean;
var
  i: Integer;
  abayar, atotal: double;
begin
  result := True;
  i := 1;

  If cxLookupSales.EditValue = '' then
  begin
    ShowMessage('Sales belum di pilih');
    result := False;
    Exit;
  end;
end;

procedure TfrmSerahTerimaFaktur2.loaddataInvoice(akode : string);
var
  s: String;
  tsql: TmyQuery;
  i: Integer;
begin
  s := ' SELECT  '
     + '     cus_nama, fp_nomor, fp_tanggal, fp_jthtempo, fp_taxamount, fp_amount, fp_dp, '
     + '     IFNULL((SELECT SUM(retj_amount) FROM tretj_hdr WHERE retj_fp_nomor = fp_nomor), 0) AS retur, '
     + '     IFNULL((SELECT SUM(retj_cn) FROM tretj_hdr WHERE retj_fp_nomor = fp_nomor), 0) AS retur_cn, '
     + '     IFNULL(fp_bayar, 0) AS bayar, '
     + '     (fp_amount - fp_dp - IFNULL(fp_bayar,0) -  '
     + '        IFNULL((SELECT SUM(retj_amount) FROM tretj_hdr WHERE retj_fp_nomor = fp_nomor),0)) AS sisa_piutang, '
     + '     DATEDIFF(CURDATE(), fp_jthtempo) AS overdue, '
     + '     (CASE  '
     + '         WHEN DATEDIFF(CURDATE(), fp_jthtempo) < 0 THEN "Belum" '
     + '         WHEN DATEDIFF(CURDATE(), fp_jthtempo) BETWEEN 0 AND 30 THEN "0 s/d 30" '
     + '         WHEN DATEDIFF(CURDATE(), fp_jthtempo) BETWEEN 31 AND 60 THEN "31 s/d 60" '
     + '         WHEN DATEDIFF(CURDATE(), fp_jthtempo) BETWEEN 61 AND 90 THEN "61 s/d 90" '
     + '         WHEN DATEDIFF(CURDATE(), fp_jthtempo) BETWEEN 91 AND 120 THEN "91 s/d 120" '
     + '         ELSE "x > 120" '
     + '      END) AS range_overdue '
     + ' FROM tfp_hdr '
     + ' INNER JOIN tcustomer ON cus_kode = fp_cus_kode '
     + ' INNER JOIN tdo_hdr ON fp_do_nomor = do_nomor '
     + ' INNER JOIN tso_hdr ON so_nomor = do_so_nomor '
     + ' WHERE so_sls_kode = ' + Quot(akode)
     + ' HAVING sisa_piutang > 1 '
     + ' ORDER BY fp_tanggal, fp_nomor ';

  // s := s + ' having (fp_amount-(retur)-fp_dp)- bayar > 1 ' ;
  // s := s + ' order by fp_tanggal, fp_nomor ';
  //  s:= s + ' HAVING (fp_amount-(retur)-fp_dp)- fp_bayar > 0' ;

  tsql := xOpenQuery(s,frmMenu.conn);
  try
    with tsql do
    begin
      CDS.EmptyDataSet;

      if not eof then
      begin
        i := 1;
        while  not Eof do
        begin
          CDS.Append;
          CDS.FieldByName('Customer').Asstring := fieldbyname('cus_nama').asstring;
          CDS.FieldByName('Faktur').AsString := fieldbyname('fp_nomor').AsString;
          CDS.FieldByName('Tanggal').AsDateTime := fieldbyname('fp_tanggal').AsDateTime;
          CDS.FieldByName('PPN').AsFloat := fieldbyname('fp_taxamount').AsFloat;
          CDS.FieldByName('nilai').AsFloat := fieldbyname('fp_amount').AsFloat;
          CDS.FieldByName('JatuhTempo').AsDateTime := fieldbyname('fp_jthtempo').AsDateTime;
          CDS.FieldByName('Overdue').AsString := fieldbyname('overdue').AsString;
          CDS.FieldByName('RangeOverdue').AsString := fieldbyname('range_overdue').AsString;
          CDS.FieldByName('check').AsInteger := 0;

          CDS.Post;
          i := i + 1;
          next;
        end ;
      end
      else
      begin
        cxLookupSales.SetFocus;
      end;
    end;
  finally
    tsql.Free;
  end;
end;

procedure TfrmSerahTerimaFaktur2.loaddataall(akode : string);
var
  s: String;
  tsql, tsql2: TmyQuery;
  a, i: Integer;
  aketemu: Boolean;
  aqtypo, qtyterima: Integer;
begin
  if akode = '' then
  begin
    flagedit := false;
    Exit;
  end;

  s := ' select '
     + ' sth2_nomor, sth2_tanggal, sth2_sls_kode, sth2_memo'
     + ' from tserahterimafaktur_hdr2 '
     + ' where sth2_nomor = ' + Quot(akode);

  tsql := xOpenQuery(s,frmMenu.conn) ;
  try
    with tsql do
    begin
      if not eof then
      begin
        flagedit := True;
        FID := fieldbyname('sth2_nomor').AsString;

        edtnomor.Text := fieldbyname('sth2_nomor').AsString;
        dttanggal.DateTime := fieldbyname('sth2_tanggal').AsDateTime;
        edtmemo.Text := fieldbyname('sth2_memo').AsString;
        cxLookupSales.EditValue := fieldbyname('sth2_sls_kode').AsString;

        i := 1;
        s := ' SELECT  '
           + '     cus_nama, fp_nomor, fp_tanggal, fp_jthtempo, fp_taxamount, fp_amount, fp_dp, '
           + '     IFNULL((SELECT SUM(retj_amount) FROM tretj_hdr WHERE retj_fp_nomor = fp_nomor), 0) AS retur, '
           + '     IFNULL((SELECT SUM(retj_cn) FROM tretj_hdr WHERE retj_fp_nomor = fp_nomor), 0) AS retur_cn, '
           + '     IFNULL(fp_bayar, 0) AS bayar, std2_sth2_nomor, '
           + '     (fp_amount - fp_dp - IFNULL(fp_bayar,0) -  '
           + '        IFNULL((SELECT SUM(retj_amount) FROM tretj_hdr WHERE retj_fp_nomor = fp_nomor),0)) AS sisa_piutang, '
           + '     DATEDIFF(CURDATE(), fp_jthtempo) AS overdue, '
           + '     (CASE  '
           + '         WHEN DATEDIFF(CURDATE(), fp_jthtempo) < 0 THEN "Belum" '
           + '         WHEN DATEDIFF(CURDATE(), fp_jthtempo) BETWEEN 0 AND 30 THEN "0 s/d 30" '
           + '         WHEN DATEDIFF(CURDATE(), fp_jthtempo) BETWEEN 31 AND 60 THEN "31 s/d 60" '
           + '         WHEN DATEDIFF(CURDATE(), fp_jthtempo) BETWEEN 61 AND 90 THEN "61 s/d 90" '
           + '         WHEN DATEDIFF(CURDATE(), fp_jthtempo) BETWEEN 91 AND 120 THEN "91 s/d 120" '
           + '         ELSE "x > 120" '
           + '      END) AS range_overdue '
           + ' FROM tfp_hdr '
           + ' INNER JOIN tcustomer ON cus_kode = fp_cus_kode '
           + ' INNER JOIN tdo_hdr ON fp_do_nomor = do_nomor '
           + ' INNER JOIN tso_hdr ON so_nomor = do_so_nomor '
           + ' LEFT JOIN tserahterimafaktur_dtl2 on std2_fp_nomor = fp_nomor '
           + ' WHERE so_sls_kode = ' + Quot(cxLookupSales.EditValue)
           + ' HAVING sisa_piutang > 1 '
           + ' ORDER BY fp_tanggal, fp_nomor ';

        // s := s + ' having (fp_amount-(retur)-fp_dp)- bayar > 1 ' ;
        // s := s + ' order by fp_tanggal, fp_nomor';
        tsql2 := xOpenQuery(s, frmMenu.conn);

        cds.EmptyDataSet;
        with tsql2 do
        begin
          try
            while not Eof do
            begin
              CDS.first;
              CDS.Append;
              CDS.FieldByName('Customer').Asstring := fieldbyname('cus_nama').asstring;
              CDS.FieldByName('Faktur').AsString := fieldbyname('fp_nomor').AsString;
              CDS.FieldByName('Tanggal').AsDateTime := fieldbyname('fp_tanggal').AsDateTime;
              CDS.FieldByName('PPN').AsFloat := fieldbyname('fp_taxamount').AsFloat;
              CDS.FieldByName('nilai').AsFloat := fieldbyname('fp_amount').AsFloat;
              CDS.FieldByName('JatuhTempo').AsDateTime := fieldbyname('fp_jthtempo').AsDateTime;
              CDS.FieldByName('Overdue').AsString := fieldbyname('overdue').AsString;
              CDS.FieldByName('RangeOverdue').AsString := fieldbyname('range_overdue').AsString;

              if FieldByName('std2_sth2_nomor').Asstring <> '' then
                CDS.FieldByName('check').AsInteger := 1
              else
                CDS.FieldByName('check').AsInteger := 0;
              CDS.Post;

              Inc(i);
              next;
            end ;
          finally
            tsql2.Free;
          end;
        end;
      end
      else
      begin
        ShowMessage('Nomor  tidak di temukan');
        dttanggal.SetFocus;
      end;
    end;
  finally
    tsql.Free;
  end;
end;

procedure TfrmSerahTerimaFaktur2.doslip(anomor : string );
var
  s: String;
  ftsreport: TTSReport;
begin
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'ST2';

    s:= ' select '
      + ' * '
      + ' from tserahterimafaktur_hdr2 '
      + ' inner join tserahterimafaktur_dtl2 on std2_sth2_nomor=sth2_nomor'
      + ' inner join tfp_hdr on fp_nomor=std2_fp_nomor'
      + ' inner join tdo_hdr on do_nomor=fp_do_nomor'
      + ' inner join tso_hdr on so_nomor=do_so_nomor'
      + ' inner join tcustomer on fp_cus_kode=cus_kode '
      + ' inner join tsalesman on so_sls_kode=sls_kode'
      + ' where '
      + ' sth2_nomor=' + quot(anomor);
      
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure TfrmSerahTerimaFaktur2.doslip2(anomor : string );
var
  aserah, aterima, s: String;
  tsql: TMyQuery;
  i: Integer;
  // ftsreport : TTSReport;
begin
//  ftsreport := TTSReport.Create(nil);
//  try
//  ftsreport.Nama := 'ST2';

  Application.CreateForm(TfrmCetak, frmCetak);

  with frmCetak do
  begin
    memo.Clear;
    memo.Lines.Add('');

    s := ' select '
       + ' * '
       + ' from tserahterimafaktur_hdr2 '
       + ' inner join tserahterimafaktur_dtl2 on std_sth2_nomor=sth2_nomor'
       + ' inner join tfp_hdr on fp_nomor=std_fp_nomor'
       + ' inner join tdo_hdr on do_nomor=fp_do_nomor'
       + ' inner join tso_hdr on so_nomor=do_so_nomor'
       + ' inner join tcustomer on fp_cus_kode=cus_kode '
       + ' inner join tsalesman on so_sls_kode=sls_kode'
       + ' where '
       + ' sth2_nomor=' + quot(anomor)
       + ' order by cus_nama,fp_tanggal ';

    tsql := xOpenQuery(s, frmMenu.conn);
    with tsql do
    begin
      try
        memo.Lines.Add(StrPadRight('Nomor  : ' + Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' S E R A H   T E R I M A   F A K T U R', 40 , ' '));
        memo.Lines.Add(StrPadRight('Tanggal: ' + Fields[1].AsString ,60, ' '));
        memo.Lines.Add(StrPadRight('', 120, '-'));
        memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
                      +StrPadRight('Nomor', 18, ' ')+' '
                      +StrPadRight('Customer', 35, ' ')+' '
                      +StrPadRight('Tanggal', 10, ' ')+' '
                      +StrPadLeft('Nilai', 15, ' ')+'  '
                      +StrPadRight('Salesman', 30, ' ')
                      );
        memo.Lines.Add(StrPadRight('', 120, '-'));

        i := 0;

        aserah := tsql.fieldbyname('sth2_serah').AsString;
        aterima := tsql.fieldbyname('sth2_terima').AsString;
        while not eof do
        begin
          i := i + 1;
          memo.Lines.Add(StrPadRight(inttostr(i),3, ' ')+' '
                        +StrPadRight(fieldbyname('fp_nomor').asstring, 18, ' ')+' '
                        +StrPadRight(fieldbyname('cus_nama').asstring, 35, ' ')+' '
                        +StrPadRight(formatdatetime('dd-mm-yyyy',fieldbyname('fp_tanggal').asdatetime), 10, ' ')+' '
                        +StrPadLeft(formatfloat('###,###,###',fieldbyname('fp_amount').asfloat), 15, ' ')+'  '
                        +StrPadRight(fieldbyname('sls_nama').asstring, 30, ' ')
                        );
          tsql.next;
        end;

        memo.Lines.Add(StrPadRight('', 120, '-'));
        memo.Lines.Add('');
        memo.Lines.Add('Diserahkan                      Diterima');
        memo.Lines.Add('');
        memo.Lines.Add('');
        memo.Lines.Add(StrPadRight(aserah, 30, ' ')+ '  '+StrPadRight(aterima, 30, ' '));
        //                  memo.Lines.Add(' '+strpadcenter(tsql.fieldbyname('sth2_serah').AsString,30,' ')+ '                  ' + strpadcenter(tsql.fieldbyname('sth2_terim').AsString,30,''));
      finally
        tsql.free;
      end;
    end;

    frmCetak.ShowModal;
  end;
end;

procedure TfrmSerahTerimaFaktur2.edtSalesmanExit(Sender: TObject);
var
  s: string;
  i: integer;
  tsql2: TmyQuery;
begin

end;

function TfrmSerahTerimaFaktur2.GetCDSSalesman: TClientDataset;
var
  s: String;
begin
  If not Assigned(FCDSSalesman) then
  begin
    S := ' select sls_nama as salesman, sls_kode Kode'
       + ' from tsalesman';
    FCDSSalesman := TConextMain.cOpenCDS(S,nil);
  end;

  Result := FCDSSalesman;
end;

procedure TfrmSerahTerimaFaktur2.Button1Click(Sender: TObject);
begin
  loaddataInvoice(cxLookupSales.EditValue);
end;

end.
