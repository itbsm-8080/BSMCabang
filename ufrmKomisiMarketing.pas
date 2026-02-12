unit ufrmKomisiMarketing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  DBClient, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxSpinEdit, cxButtonEdit, cxTextEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, AdvEdBtn, cxCurrencyEdit,
  cxRadioGroup, AdvCombo, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, MyAccess;

type
  TfrmKomisiMarketing = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtNama: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxButton1: TcxButton;
    AdvPanel4: TAdvPanel;
    edtKode: TAdvEditBtn;
    Label1: TLabel;
    Label4: TLabel;
    cxButton7: TcxButton;
    SaveDialog1: TSaveDialog;
    AdvPanel5: TAdvPanel;
    Label5: TLabel;
    edtPersentase: TAdvEdit;
    Label6: TLabel;
    edtPengali: TAdvEdit;
    Label7: TLabel;
    edtKomisiValue: TAdvEdit;
    Label8: TLabel;
    edtValue: TAdvEdit;
    Label9: TLabel;
    edtQty: TAdvEdit;
    Label10: TLabel;
    edtTotalKomisi: TAdvEdit;
    cxButton3: TcxButton;
    PopupMenu1: TPopupMenu;
    LihatDetail1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clNama: TcxGridDBColumn;
    clTarget: TcxGridDBColumn;
    clRealisasi: TcxGridDBColumn;
    clcapai: TcxGridDBColumn;
    clHet: TcxGridDBColumn;
    clPenjualan: TcxGridDBColumn;
    clPresentase: TcxGridDBColumn;
    clPengali: TcxGridDBColumn;
    clInsentif: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrdMain2: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    Pencapaian1: TMenuItem;
    cxGrdMain2Column1: TcxGridDBColumn;
    cbbBulan: TAdvComboBox;
    edtTahun: TComboBox;
    cxGrdMain2Column2: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure initgrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton8Click(Sender: TObject);
    function GetCDS: TClientDataSet;
    function GetCDS2: TClientDataSet;
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure cxButton1Click(Sender: TObject);
    procedure edtKodeClickBtn(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxButton7Click(Sender: TObject);
    procedure
        cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems1GetText(
        Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
        AText: string);
    procedure cxButton3Click(Sender: TObject);
    procedure LihatDetail1Click(Sender: TObject);
    procedure Pencapaian1Click(Sender: TObject);
    function getkomisijual(apersen:double) : double;

  private
    FFLAGEDIT: Boolean;
    FID: string;


    { Private declarations }
  protected
    FCDS: TClientDataSet;
    FCDS2: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDS2: TClientDataSet read GetCDS2 write FCDS2;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmKomisiMarketing: TfrmKomisiMarketing;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,cxgridExportlink,uReport;

{$R *.dfm}

procedure TfrmKomisiMarketing.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
     TcxDBGridHelper(cxGrdMain2).LoadFromCDS(CDS2, False, False);
end;

procedure TfrmKomisiMarketing.refreshdata;
begin
  FID:='';
  edtKode.Clear;
  edtNama.Clear;

  initgrid;
end;

procedure TfrmKomisiMarketing.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;

end;

procedure TfrmKomisiMarketing.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
      Release;
  end;


end;

procedure TfrmKomisiMarketing.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmKomisiMarketing.loaddata;
var
  sfilter,s,ss: string;
  tsql,tsql2 : TmyQuery;
  i:Integer;

begin
s:='SELECT Nama,hna,Target,retur,jual-retur Realisasi,(jual-retur)/target*100 Capai,'
+ ' (jual-retur)*hna penjualan,target*hna Target_Penjualan,'
+ ' ((jual-retur)*hna)/(target*hna)*100 presentase,pengali-pengurang Pengali,0 insentif'
+ ' FROM ('
+ ' SELECT nama_grouppf Nama,tm_target target,tm_hna hna,'
+ ' (SELECT ifnull(SUM(fpd_qty),0) FROM tfp_dtl INNER JOIN tbarangpf ON bpf_brg_kode=fpd_brg_kode and bpf_periode='+inttostr(cbbBulan.ItemIndex+1)+ ' and bpf_tahun='+edtTahun.Text
+ ' INNER JOIN tfp_hdr ON fp_nomor=fpd_fp_nomor  AND MONTH(fp_tanggal)='+inttostr(cbbBulan.ItemIndex+1)+' AND YEAR(fp_tanggal)='+ edtTahun.Text
+ ' INNER JOIN tsalescustomer ON sc_cus_kode=fp_cus_kode'
+ ' WHERE sc_sls_kode=x.tm_salesman AND bpf_kode_grouppf=tm_grouppf'
+ ' ) jual,'
+ ' (SELECT ifnull(SUM(fpd_qty*(((100-fpd_discpr)*fpd_harga/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)-'
+ ' ((fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)/100)+fpd_bp_rp))),0) FROM tfp_dtl INNER JOIN tbarangpf ON bpf_brg_kode=fpd_brg_kode and bpf_periode='+inttostr(cbbBulan.ItemIndex+1)+ ' and bpf_tahun='+edtTahun.Text
+ ' INNER JOIN tfp_hdr ON fp_nomor=fpd_fp_nomor  AND MONTH(fp_tanggal)='+IntToStr(cbbBulan.ItemIndex+1)+' AND YEAR(fp_tanggal)='+ edtTahun.Text
+ ' INNER JOIN tsalescustomer ON sc_cus_kode=fp_cus_kode'
+ ' WHERE sc_sls_kode=x.tm_salesman AND bpf_kode_grouppf=tm_grouppf AND'
+ ' (((100-fpd_discpr)*fpd_harga/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)-'
+ '  ((fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)/100)+fpd_bp_rp)) >= fpd_hrg_min'
+ ' ) pengali,'
+ ' (SELECT ifnull(SUM(retjd_qty*(((100-fpd_discpr)*fpd_harga/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)-'
+ ' ((fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)/100)+fpd_bp_rp))),0) FROM tretj_dtl'
+ ' INNER JOIN tretj_hdr ON retjd_retj_nomor=retj_nomor AND MONTH(retj_tanggal)='+inttostr(cbbBulan.ItemIndex+1)+' AND YEAR(retj_tanggal)='+ edtTahun.Text
+ ' INNER JOIN tbarangpf ON bpf_brg_kode=retjd_brg_kode and bpf_periode='+inttostr(cbbBulan.ItemIndex+1)+ ' and bpf_tahun='+edtTahun.Text
+ ' INNER JOIN tfp_hdr ON fp_nomor=retj_fp_nomor'
+ ' INNER JOIN tfp_dtl ON fp_nomor=fpd_fp_nomor  AND fpd_brg_kode=retjd_brg_kode'
+ ' INNER JOIN tsalescustomer ON sc_cus_kode=fp_cus_kode'
+ ' WHERE sc_sls_kode=x.tm_salesman AND bpf_kode_grouppf=tm_grouppf AND'
+ ' (((100-fpd_discpr)*fpd_harga/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)-'
+ '  ((fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)/100)+fpd_bp_rp)) >= fpd_hrg_min'
+ ' ) pengurang,'
+ ' (SELECT ifnull(SUM(retjd_qty),0) FROM tretj_dtl INNER JOIN tbarangpf ON bpf_brg_kode=retjd_brg_kode'
+ ' and bpf_periode='+inttostr(cbbBulan.ItemIndex+1)+ ' and bpf_tahun='+edtTahun.Text
+ ' INNER JOIN tretj_hdr ON retj_nomor=retjd_retj_nomor  AND MONTH(retj_tanggal)='+inttostr(cbbBulan.ItemIndex+1)+' AND YEAR(retj_tanggal)='+ edtTahun.Text
+ ' INNER JOIN tsalescustomer ON sc_cus_kode=retj_cus_kode'
+ ' WHERE sc_sls_kode=x.tm_salesman AND bpf_kode_grouppf=tm_grouppf'
+ ' ) retur'
+ ' FROM ttargetmarketing x INNER JOIN tgrouppf'
+ ' ON tm_grouppf=kode_grouppf'
+ ' WHERE tm_periode='+IntToStr(cbbBulan.ItemIndex+1)+' AND tm_tahun='+edtTahun.Text
+ ' AND tm_salesman='+Quot(edtKode.Text)+') final';
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
   try

    CDS.EmptyDataSet;
    while  not Eof do
    begin
      CDS.Append;
      CDS.FieldByName('nama').AsString  := fieldbyname('nama').AsString;
      CDS.FieldByName('target').Asfloat  := fieldbyname('target').AsFloat;
      CDS.FieldByName('realisasi').AsFloat  := fieldbyname('realisasi').AsFloat;
      CDS.FieldByName('capai').AsFloat  := fieldbyname('capai').AsFloat;
      CDS.FieldByName('penjualan_hna').AsFloat  := fieldbyname('penjualan').AsFloat;
      CDS.FieldByName('target_value').AsFloat  := fieldbyname('target_penjualan').AsFloat;
      CDS.FieldByName('presentase').AsFloat  := fieldbyname('Presentase').AsFloat;
      CDS.FieldByName('pengali').AsFloat := fieldbyname('pengali').AsFloat;
      CDS.FieldByName('insentif').AsFloat := fieldbyname('insentif').AsFloat;
      CDS.Post;
      i:=i+1;
      next;
    end;

   finally
    Free;
   end;

  end;
  sS:=' SELECT Customer,Nama,Nomor,Tanggal,Qty,ifnull(Qty_ret,0) retur,Netjual,(qty-IFNULL(qty_ret,0)) * netjual Total FROM ('
+ ' SELECT cus_nama Customer,brg_nama Nama,fp_nomor Nomor,fp_tanggal Tanggal,fpd_qty Qty,'
+ ' (SELECT SUM(retjd_qty) FROM tretj_dtl inner join tretj_hdr ON retj_nomor=retjd_retj_nomor WHERE retj_fp_nomor=fp_nomor'
+ ' AND retjd_brg_kode=fpd_brg_kode) Qty_ret,'
+ ' ((((100-fpd_discpr)*fpd_harga/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)-'
+ ' ((fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)/100)+fpd_bp_rp)))  Netjual'
+ ' FROM tfp_dtl INNER JOIN tbarangpf ON bpf_brg_kode=fpd_brg_kode AND bpf_periode='+inttostr(cbbbulan.itemindex+1)+ ' and bpf_tahun = '+edttahun.text
+ ' INNER JOIN tbarang ON brg_kode=fpd_brg_kode'
+ ' INNER JOIN tfp_hdr ON fp_nomor=fpd_fp_nomor  AND MONTH(fp_tanggal)='+inttostr(cbbbulan.itemindex+1)+' AND YEAR(fp_tanggal)='+edttahun.text
+ ' INNER JOIN tsalescustomer ON sc_cus_kode=fp_cus_kode'
+ ' INNER JOIN tcustomer ON cus_kode=sc_cus_kode'
+ ' WHERE sc_sls_kode='+quot(edtKode.Text)+' AND'
+ ' (((100-fpd_discpr)*fpd_harga/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)-'
+ ' ((fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)/100)+fpd_bp_rp)) >= fpd_hrg_min) final';

  tsql2 := xOpenQuery(ss,frmMenu.conn);
  with tsql2 do
  begin
   try

    CDS2.EmptyDataSet;
    while  not Eof do
    begin
      CDS2.Append;
      CDS2.FieldByName('customer').AsString  := fieldbyname('customer').AsString;
      CDS2.FieldByName('nama').AsString  := fieldbyname('nama').AsString;
      CDS2.FieldByName('nomor').AsString  := fieldbyname('nomor').AsString;
      CDS2.FieldByName('tanggal').AsDateTime := fieldbyname('tanggal').AsDateTime;
      CDS2.FieldByName('qty').AsFloat := fieldbyname('qty').AsFloat;
      CDS2.FieldByName('retur').AsFloat := fieldbyname('retur').AsFloat;
      CDS2.FieldByName('net').AsFloat := fieldbyname('netjual').AsFloat;
      CDS2.FieldByName('nilai').AsFloat := fieldbyname('netjual').AsFloat*fieldbyname('qty').AsFloat;

      CDS2.Post;
      i:=i+1;
      next;
    end;

   finally
    Free;
   end;
  end;
end;


procedure TfrmKomisiMarketing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmKomisiMarketing.cxButton8Click(Sender: TObject);
begin
Release;
end;

function TfrmKomisiMarketing.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Nama', ftString, False,200);
    zAddField(FCDS, 'Target', ftFloat, False);
    zAddField(FCDS, 'Realisasi', ftFloat, False);
    zAddField(FCDS, 'Capai', ftFloat, False);
    zAddField(FCDS, 'penjualan_hna', ftFloat, False);
    zAddField(FCDS, 'Target_Value', ftFloat, False);
    zAddField(FCDS, 'Presentase', ftFloat, False);
    zAddField(FCDS, 'Pengali', ftFloat, False);
    zAddField(FCDS, 'insentif', ftFloat, False);
//    zAddField(FCDS, 'nilai', ftFloat, False);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;
function TfrmKomisiMarketing.GetCDS2: TClientDataSet;
begin
  If not Assigned(FCDS2) then
  begin
    FCDS2 := TClientDataSet.Create(Self);
    zAddField(FCDS2, 'No', ftInteger, False);
    zAddField(FCDS2, 'customer', ftString, False,200);
    zAddField(FCDS2, 'nama', ftString, False,200);
    zAddField(FCDS2, 'Nomor', ftString, False,100);
    zAddField(FCDS2, 'Tanggal', ftDate, False,100);
    zAddField(FCDS2, 'Qty', ftFloat, False);
    zAddField(FCDS2, 'Retur', ftFloat, False);
    zAddField(FCDS2, 'Net', ftFloat, False);
    zAddField(FCDS2, 'Nilai', ftFloat, False);
    FCDS2.CreateDataSet;
  end;
  Result := FCDS2;
end;


procedure TfrmKomisiMarketing.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmKomisiMarketing.cxButton1Click(Sender: TObject);
var
  apersen : double;
  akomisivalue : Double;
  apengurang : Double;
begin
loaddata;

//-------------
apersen := cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('penjualan_hna'))/ cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('target_value'))*100;
edtPengali.Text :=  FloatToStr(strtofloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('pengali'))-apengurang);
edtPersentase.Text := FloatToStr(getkomisijual(apersen));
akomisivalue := (strtofloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('pengali'))-apengurang)*getkomisijual(apersen)/100;
edtKomisiValue.Text :=FloatToStr(akomisivalue);
edtQty.Text := TcxDBGridHelper(cxGrdMain).GetFooterSummary('insentif');
edtValue.Text :=FloatToStr(akomisivalue);
edtTotalKomisi.Text := FloatToStr(akomisivalue+ cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('insentif')));

end;

procedure TfrmKomisiMarketing.edtKodeClickBtn(Sender: TObject);
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

procedure TfrmKomisiMarketing.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmKomisiMarketing.cxButton7Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid);
     end;

end;

procedure
    TfrmKomisiMarketing.cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems1GetText(
    Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
    AText: string);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('penjualan_hna')) > 0  then
       capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('penjualan_hna'))/ cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('target_value'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

procedure TfrmKomisiMarketing.cxButton3Click(Sender: TObject);
var
  s : string;
  tt:TStrings;
  i:Integer;
  ftsreport : TTSReport;
  apersen : Double;
begin
  apersen := cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('penjualan_hna'))/ cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('target_value'))*100;
    ftsreport := TTSReport.Create(nil);
    tt := TStringList.Create;
   s:= ' delete from tcetakkomisi2 '
      + ' where  ck_periode =' + inttostr(cbbBulan.ItemIndex+1)
      + ' and ck_tahun='+ edtTahun.Text
      + ' and ck_kode = ' + Quot(edtKode.Text);
   tt.Append(s);

    s:= ' INSERT INTO tcetakkomisi2 (ck_kode,ck_salesman, ck_PERIODE, ck_tahun, '
      + ' ck_targetjual, ck_realisasijual, ck_persentasejual, ck_komisijual, '
      + ' ck_komisiqty,ck_pengali,ck_persen)'
      + ' VALUES ('
      + Quot(edtkode.text)+ ','
      + Quot(edtNama.text)+ ','
      + IntToStr(cbbBulan.ItemIndex+1) + ','
      + edttahun.Text + ','
      + FloatToStr(cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('target_value')))+ ','
      + FloatToStr(cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('penjualan_hna')))+ ','
      + floattostr(apersen) + ','
      + StringReplace(edtValue.Text,',','',[rfReplaceAll]) +','
      + StringReplace(edtQty.Text,',','',[rfReplaceAll]) + ','
      + StringReplace(edtPengali.Text,',','',[rfReplaceAll]) + ','
      + StringReplace(edtPersentase.Text,',','',[rfReplaceAll])
      + ');';
      tt.Append(s);

       try
        for i:=0 to tt.Count -1 do
        begin
            EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, tt[i]);
        end;
      finally
        tt.Free;
      end;
      
   try
    ftsreport.Nama := 'cetakkomisi2';

       s:= ' select '
       + ' * '
       + ' from tcetakkomisi2 '
       + ' where '
       + ' ck_periode=' + IntToStr(cbbBulan.ItemIndex+1)
       + ' and ck_tahun = ' + edtTahun.Text
       + ' and ck_kode = ' + quot(edtkode.text);


    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure TfrmKomisiMarketing.LihatDetail1Click(Sender: TObject);
var
  s:string;
begin
PageControl1.TabIndex:=1;
end;

procedure TfrmKomisiMarketing.Pencapaian1Click(Sender: TObject);
begin
PageControl1.TabIndex:=0;
end;

function TfrmKomisiMarketing.getkomisijual(apersen:double) : double;
var
  sfilter,s:string;
  tsql:TmyQuery;
begin

  result := 0;

  s:='select ksj_komisi from tkomisimarketing_jual where ksj_bawah <= '+ FloatToStr(apersen)
  + ' and ksj_atas >= '+ floattostr(apersen);

  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not Eof then
         Result := Fields[0].AsFloat;
    finally
      free;
    end;
  end;

end;



end.
