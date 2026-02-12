unit ufrmFakturPajak3;

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
  cxCalendar, cxCheckBox, cxButtonEdit, frxClass, frxExportPDF,comobj,ExcelXP,
  MyAccess;

type
  TfrmFakturPajak3 = class(TForm)
    PANEL: TAdvPanel;
    Label3: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    AdvPanel4: TAdvPanel;
    lbljudul: TLabel;
    dtTanggal: TDateTimePicker;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    dttanggal2: TDateTimePicker;
    cxButton3: TcxButton;
    btnRefresh: TcxButton;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clKeteranganTambahan: TcxGridDBColumn;
    cldokumen: TcxGridDBColumn;
    clTglInvoice: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    cxButton4: TcxButton;
    chkManual: TCheckBox;
    PopupMenu1: TPopupMenu;
    clkodetransaksi: TcxGridDBColumn;
    clJenisfaktur: TcxGridDBColumn;
    clreferensi: TcxGridDBColumn;
    clcapfasilitas: TcxGridDBColumn;
    clidtkupenjual: TcxGridDBColumn;
    clNpwpPembeli: TcxGridDBColumn;
    clJenisIdPembeli: TcxGridDBColumn;
    clNegarapembeli: TcxGridDBColumn;
    clnodokpembeli: TcxGridDBColumn;
    clnamapembeli: TcxGridDBColumn;
    clAlamatPembeli: TcxGridDBColumn;
    clEmailPembeli: TcxGridDBColumn;
    clidtkupembeli: TcxGridDBColumn;
    HapusBaris1: TMenuItem;
    clperiodeDokPendukung: TcxGridDBColumn;
    procedure refreshdata;
   procedure initgrid;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function getmaxkode(aispajak:Integer=1):string;
    procedure cxButton8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure btnRefreshClick(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure CheckAllStatus1Click(Sender: TObject);
    procedure UncheckAllStatus1Click(Sender: TObject);
    procedure HapusBaris1Click(Sender: TObject);
  private
    FCDSSKU : TClientDataset;
    FNPWP :STRING;
    FFLAGEDIT: Boolean;
    FID: string;
    apajak :Integer ;





    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;


    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmFakturPajak3: TfrmFakturPajak3;
const
   NOMERATOR = 'FP';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmcetak;

{$R *.dfm}

procedure TfrmFakturPajak3.refreshdata;
begin
  FID:='';
  FLAGEDIT := False;
  dtTanggal.DateTime := Date;

end;
procedure TfrmFakturPajak3.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.Post;

end;
procedure TfrmFakturPajak3.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmFakturPajak3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmFakturPajak3.getmaxkode(aispajak:integer=1):string;
var
  s:string;
begin
  if aispajak=1 then
  begin
  s:='select max(right(fp_nomor,4)) from tfp_hdr '
  + ' where fp_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
  + ' and fp_istax=1 ';
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
  end
  else
  begin
  s:='select max(right(fp_nomor,3)) from tfp_hdr '
  + ' where fp_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
  + ' and fp_istax=0 ';

  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(15000+1),4)
      else
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(15000+fields[0].AsInteger+1),4);

    finally
      free;
    end;
  end;
  end;
end;

procedure TfrmFakturPajak3.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmFakturPajak3.FormCreate(Sender: TObject);
begin

     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);

end;

function TfrmFakturPajak3.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'Baris', ftInteger, False);
    zAddField(FCDS, 'Tanggal', ftDate, False);
    zAddField(FCDS, 'JenisFaktur', ftString, False,20);
    zAddField(FCDS, 'KodeTransaksi', ftString, False,2);
    zAddField(FCDS, 'KeteranganTambahan', ftString, False,30);
    zAddField(FCDS, 'DokumenPendukung', ftString, False,30);
    zAddField(FCDS, 'PeriodeDokPendukung', ftString, False,30);
    zAddField(FCDS, 'Referensi', ftString, False,20);
    zAddField(FCDS, 'CapFasilitas', ftString, False,30);
    zAddField(FCDS, 'idtkupenjual', ftString, False,22);
    zAddField(FCDS, 'npwppembeli', ftString, False,16);
    zAddField(FCDS, 'jenisidpembeli', ftString, False,15);
    zAddField(FCDS, 'NegaraPembeli', ftString, False,10);
    zAddField(FCDS, 'nomordokumenpembeli', ftString, False,30);
    zAddField(FCDS, 'namapembeli', ftString, False,100);
    zAddField(FCDS, 'alamatpembeli', ftString, False,200);
    zAddField(FCDS, 'emailpembeli', ftString, False,200);
    zAddField(FCDS, 'idtkupembeli', ftString, False,22);



    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;


procedure TfrmFakturPajak3.FormShow(Sender: TObject);
var
  s:String;
  tsqlheader:TmyQuery;
begin
refreshdata;

dttanggal2.DateTime :=Date;
 s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp,perush_npwp,perush_pak,perush_pj,perush_pj_no '
      + ' from tperusahaan ';

  tsqlheader := xOpenQuery(s, frmMenu.conn);
  with tsqlheader do
  begin
    try
       FNPWP:=stringreplace(StringReplace(tsqlheader.fields[4].AsString,'.','',[rfReplaceAll]),'-','',[rfReplaceAll]);
    finally
        free
    end;
  end;

end;

procedure TfrmFakturPajak3.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmFakturPajak3.btnRefreshClick(Sender: TObject);
var
  s:string;
  tsql:TmyQuery;
  i:Integer;
begin
  if chkManual.Checked then

  s := ' SELECT 0,fp_tanggal,"Normal","04", '
    + '" " KeteranganTambahan," " DokumenPendukung," " PeriodeDokPendukung,fp_nomor," " CapFasilitas,CONCAT("0",'+fnpwp+',"000000"),cus_npwp,"TIN","IDN","-",cus_namanpwp,cus_alamatnpwp,"-",concat(cus_npwp,"000000")'
    + ' FROM tfp_hdr_bayangan INNER JOIN tcustomer ON cus_kode=fp_cus_kode '
    + ' and fp_tanggal between '+ quotd(dttanggal.datetime) + ' and ' + quotd(dttanggal2.datetime)

  else

  s := ' SELECT 0,fp_tanggal,"Normal","04", '
    + '" " KeteranganTambahan," " DokumenPendukung," " PeriodeDokPendukung,fp_nomor," " CapFasilitas,CONCAT("0",'+fnpwp+',"000000"),cus_npwp,"TIN","IDN","-",cus_namanpwp,cus_alamatnpwp,"-",concat(cus_npwp,"000000")'
    + ' FROM tfp_hdr INNER JOIN tcustomer ON cus_kode=fp_cus_kode '
    + ' and fp_tanggal between '+ quotd(dttanggal.datetime) + ' and ' + quotd(dttanggal2.datetime)
    + ' AND cus_npwp <> "" ';
        tsql := xOpenQuery(s,frmMenu.conn) ;
      try

       with  tsql do
       begin
             CDS.EmptyDataSet;

            i:=1;

            while  not Eof do
             begin
                   CDS.Append;
                   CDS.FieldByName('baris').AsString  := inttostr(i);
                   CDS.FieldByName('tanggal').AsDateTime  := fieldbyname('fp_tanggal').AsDateTime;
                   CDS.FieldByName('JenisFaktur').AsString  := fields[2].asstring;
                   CDS.FieldByName('KodeTransaksi').AsString  :=fields[3].asstring;
                   CDS.FieldByName('KeteranganTambahan').AsString  :=fields[4].asstring;
                   CDS.FieldByName('DokumenPendukung').AsString  :=fields[5].asstring;
                   CDS.FieldByName('PeriodeDokPendukung').AsString  :=fields[6].asstring;
                   CDS.FieldByName('Referensi').AsString  :=fields[7].asstring;
                   CDS.FieldByName('CapFasilitas').AsString  :=fields[8].asstring;
                   CDS.FieldByName('idtkupenjual').AsString  :=fields[9].asstring;
                   CDS.FieldByName('npwppembeli').AsString  :=stringreplace(StringReplace(fields[10].asstring,'.','',[rfReplaceAll]),'-','',[rfReplaceAll]);
                   CDS.FieldByName('jenisidpembeli').AsString  :=fields[11].asstring;
                   CDS.FieldByName('NegaraPembeli').AsString  :=fields[12].asstring;
                   CDS.FieldByName('nomordokumenpembeli').AsString  :=fields[13].asstring;
                   CDS.FieldByName('namapembeli').AsString  :=fields[14].asstring;
                   CDS.FieldByName('alamatpembeli').AsString  :=fields[15].asstring;
                   CDS.FieldByName('emailpembeli').AsString  :=fields[16].asstring;
                   CDS.FieldByName('idtkupembeli').AsString  :=stringreplace(StringReplace(fields[17].asstring,'.','',[rfReplaceAll]),'-','',[rfReplaceAll]);

                   CDS.Post;
                   i:=i+1;
                   next;
            end ;
      end;
   finally
     tsql.Free;
   end;

end;

procedure TfrmFakturPajak3.cxButton4Click(Sender: TObject);
var
  anegri:string;
  Save_Cursor:TCursor;
  XLApp: Variant;
  Sheet: Variant;
  Sheet2: Variant;

  i,acol, iCol,jRow : Integer;
  iCol2,jRow2 :integer;
  v   : Variant;
  ss,S:string;
  tsql:TmyQuery;
begin

  cds.first;

  acol:=0;
   Save_Cursor := Screen.Cursor;
   Screen.Cursor := crHourglass;
   try
      XLApp := CreateOLEObject('Excel.Application');
      XLApp.Visible := True;
      XLApp.Workbooks.Add[XLWBatWorksheet];
      XLApp.sheets.add;
      XLApp.Workbooks[1].Worksheets[1].Name := 'Faktur' ;
      Sheet := XLApp.Workbooks[1].Worksheets['Faktur'];
      XLApp.Workbooks[1].Worksheets[2].Name := 'DetailFaktur' ;
      Sheet2 := XLApp.Workbooks[1].Worksheets['DetailFaktur'];

//      XLApp.Workbooks[1].Worksheets[2].Name := 'Detail Faktur' ;
//      Sheet2 := XLApp.Workbooks[1].Worksheets['Detail Faktur'];
      jRow := 1;
//         Sheet.Cells[1,1] := Self.Caption;
         Sheet.Cells[1,2] := 'Npwp Penjual     :'   ;
         Sheet.Cells[1,3] :=  ''''+FNPWP;
         for i:=0 to cds.FieldList.Count-1 do
         begin
            Sheet.Cells[3,i+1] := cds.FieldList.Fields[i].FieldName;
         end;
        sheet2.cells[1,1] := 'Baris';
        sheet2.cells[1,2] := 'Barang/Jasa';
        sheet2.cells[1,3] := 'Kode Barang Jasa';
        sheet2.cells[1,4] := 'Nama Barang/Jasa';
        sheet2.cells[1,5] := 'Nama Satuan Ukur';
        sheet2.cells[1,6] := 'Harga Satuan';
        sheet2.cells[1,7] := 'Jumlah Barang Jasa';
        sheet2.cells[1,8] := 'Total Diskon';
        sheet2.cells[1,9] := 'DPP';
        sheet2.cells[1,10] := 'DPP Nilai Lain';
        sheet2.cells[1,11] := 'Tarif PPN';
        sheet2.cells[1,12] := 'PPN';
        sheet2.cells[1,13] := 'Tarif PPnBM';
        sheet2.cells[1,14] := 'PPnBM';
      cds.Filter := cxGrdMain.DataController.Filter.FilterText;
      cds.Filtered := True;

      cds.First;
      jRow:=3;
      jrow2:=2;
      Inc(jRow);
      while not cds.EOF do
      begin

         for iCol := 1 to cds.FieldCount do
         begin
//            showmessage(cds.Fields[0].AsString);
            v := ''''+cds.Fields[iCol-1].Text;
            Sheet.Cells[jRow, iCol] := v;
            if icol=1 then
              sheet.cells[jrow, icol] := ''''+inttostr(jrow-3);
         end;
          if chkManual.Checked then
            ss:= 'SELECT 0,"A","000000",brg_nama,kode ,fpd_harga,fpd_qty,fpd_discpr*fpd_harga*fpd_qty/100 totaldisc ,'
                + ' fpd_harga*fpd_qty - (fpd_discpr*fpd_harga*fpd_qty/100) DPP,11/12*(fpd_harga*fpd_qty - (fpd_discpr*fpd_harga*fpd_qty/100)) dppnilailain,'
                + ' 12,12*11/12*(fpd_harga*fpd_qty - (fpd_discpr*fpd_harga*fpd_qty/100))/100 PPN,0,0'
                + ' FROM tfp_dtl_bayangan'
                + ' INNER JOIN tbarang ON fpd_brg_kode=brg_kode'
                + ' left JOIN tsatuanpajak ON nama=fpd_brg_satuan'
                + ' WHERE fpd_fp_nomor='+Quot(CDS.fieldbyname('referensi').AsString)
          else
          ss:= 'SELECT 0,"A","000000",brg_nama,kode ,fpd_harga, '
                + ' (fpd_qty -(select ifnull(SUM(retjd_qty),0) FROM tretj_dtl INNER JOIN tretj_hdr ON retj_nomor=retjd_retj_nomor WHERE retj_fp_nomor=fpd_fp_nomor AND retjd_brg_kode=fpd_brg_kode)) fpd_qty,'
                + ' fpd_discpr*fpd_harga*fpd_qty/100 totaldisc ,'
                + ' fpd_harga*fpd_qty - (fpd_discpr*fpd_harga*fpd_qty/100) DPP,'
                + ' 11/12*(fpd_harga*fpd_qty - (fpd_discpr*fpd_harga*fpd_qty/100)) dppnilailain,'
                + ' 12,12*11/12*(fpd_harga*fpd_qty - (fpd_discpr*fpd_harga*fpd_qty/100))/100 PPN,0,0'
                + ' FROM tfp_dtl'
                + ' INNER JOIN tbarang ON fpd_brg_kode=brg_kode'
                + ' left JOIN tsatuanpajak ON nama=fpd_brg_satuan'
                + ' WHERE fpd_fp_nomor='+Quot(CDS.fieldbyname('referensi').AsString)
                + ' having fpd_qty > 0';
            tsql := xOpenQuery(ss,frmMenu.conn);
            with tsql do
            begin
              try
                while not eof do
                begin

                  Sheet2.Cells[jrow2, 1] := inttostr(jrow-3);
                  Sheet2.Cells[jrow2, 2] := fields[1].AsString;
                  Sheet2.Cells[jrow2, 3] := ''''+fields[2].AsString;
                  Sheet2.Cells[jrow2, 4] := fields[3].AsString;
                  Sheet2.Cells[jrow2, 5] := fields[4].AsString;
                  Sheet2.Cells[jrow2, 6] := formatfloat('##########.##',fields[5].Asfloat);
                  Sheet2.Cells[jrow2, 7] := fields[6].AsString;
                  Sheet2.Cells[jrow2, 8] := fields[7].Asstring;
                  Sheet2.Cells[jrow2, 9] := formatfloat('############.##',(strtofloat(formatfloat('##########.##',fields[5].Asfloat))*fields[6].Asfloat)-fields[7].Asfloat) ;
                  Sheet2.Cells[jrow2, 10] := formatfloat('############.##',11/12*((strtofloat(formatfloat('##########.##',fields[5].Asfloat))*fields[6].Asfloat)-fields[7].Asfloat));// fields[9].AsString;
                  Sheet2.Cells[jrow2, 11] := fields[10].AsString;
                  Sheet2.Cells[jrow2, 12] := formatfloat('############.##',12/100*(11/12*((strtofloat(formatfloat('##########.##',fields[5].Asfloat))*fields[6].Asfloat)-fields[7].Asfloat)));// fields[9].AsString;
                  Sheet2.Cells[jrow2, 13] := fields[12].AsString;
                  Sheet2.Cells[jrow2, 14] := fields[13].AsString;

                  inc(jrow2);
                 
                  next;
                end;
              finally
                free;
              end;
            end;

         Inc(jRow);
         cds.Next;
      end;
      sheet.cells[jrow, 1] :='END';
      sheet2.cells[jrow2, 1] :='END';
      if acol =0 then
         acol :=i;
            Sheet.Range[Sheet.cells[3,1],Sheet.cells[jrow-1,acol]].Borders.Weight := 2;
       for i := 1 to acol do
         XLApp.Workbooks[1].WorkSheets['Faktur'].Columns[i].EntireColumn.Autofit;
   finally
      Screen.Cursor := Save_Cursor;
   end;

end;

procedure TfrmFakturPajak3.CheckAllStatus1Click(Sender: TObject);
begin
   cds.first;
  while not CDS.Eof do
  begin
    If CDS.State <> dsEdit then CDS.Edit;
      CDS.FieldByName('status').AsFloat := 1;
      CDS.post;
    CDS.Next;

  end;

end;

procedure TfrmFakturPajak3.UncheckAllStatus1Click(Sender: TObject);
begin
   cds.first;
  while not CDS.Eof do
  begin
    If CDS.State <> dsEdit then CDS.Edit;
      CDS.FieldByName('status').AsFloat := 0;
      CDS.post;
    CDS.Next;

  end;

end;

procedure TfrmFakturPajak3.HapusBaris1Click(Sender: TObject);
begin
cds.Delete;
end;

end.
