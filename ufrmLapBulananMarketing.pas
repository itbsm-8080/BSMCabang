unit ufrmLapBulananMarketing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, SqlExpr,  cxGraphics,
  cxControls, dxStatusBar, te_controls, Menus, cxLookAndFeelPainters,
  cxButtons, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxClasses, cxGridCustomView, cxGrid ,
  Grids, BaseGrid, AdvGrid, AdvCGrid, ComCtrls, Mask, ImgList, FMTBcd,
  Provider, DB, DBClient, DBGrids, cxLookAndFeels, cxDBData,
  cxGridBandedTableView, cxGridDBTableView,
  cxGridChartView, cxCustomPivotGrid, cxDBPivotGrid, cxPC,
  cxPivotGridChartConnection, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, cxDrawTextUtils,
  dxPSPrVwStd, dxPSPrVwAdv, dxPScxPageControlProducer,
  dxPScxEditorProducers, dxPScxExtEditorProducers, dxPScxCommon, dxPSCore,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxBarPainter, AdvCombo,
  cxCurrencyEdit, cxGridDBBandedTableView, dxPScxGrid6Lnk, MemDS, DBAccess,
  MyAccess;

type
  TfrmLapBulananMarketing = class(TForm)
    tscrlbx1: TTeScrollBox;
    TePanel4: TTePanel;
    ilMenu: TImageList;
    TePanel1: TTePanel;
    ilToolbar: TImageList;
    TePanel2: TTePanel;
    TeLabel1: TTeLabel;
    SaveDialog1: TSaveDialog;
    TePanel3: TTePanel;
    dtstprvdr1: TDataSetProvider;
    sqlqry2: TSQLQuery;
    ds2: TDataSource;
    ds3: TClientDataSet;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxstyl1: TcxStyle;
    cxVCLPrinter: TdxComponentPrinter;
    cxVCLPrinterChart: TdxGridReportLink;
    btnRefresh: TcxButton;
    Label1: TLabel;
    TePanel5: TTePanel;
    cxButton8: TcxButton;
    cxButton7: TcxButton;
    cbbBulan: TAdvComboBox;
    cxGrid1: TcxGrid;
    cxGrid1DBBandedTableView1: TcxGridDBBandedTableView;
    cxGrid1DBBandedTableView1Column1: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column2: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column3: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column4: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column5: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column6: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column7: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column8: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column9: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column10: TcxGridDBBandedColumn;
    cxGrid1Level1: TcxGridLevel;
    Label2: TLabel;
    edtTahun: TComboBox;
    cxGrid1DBBandedTableView1Column11: TcxGridDBBandedColumn;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    cxGrid1DBBandedTableView1Column12: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column13: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column14: TcxGridDBBandedColumn;
    sqlqry1: TMyQuery;
    procedure FormDblClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure sbPrintClick(Sender: TObject);
    procedure btnTampilClick(Sender: TObject);
    procedure cxGrid1DBBandedTableView1Column10CustomDrawCell(Sender:
        TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column10CustomDrawFooterCell(Sender:
        TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column13CustomDrawCell(Sender:
        TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column13CustomDrawFooterCell(Sender:
        TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column8CustomDrawCell(Sender:
        TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column8CustomDrawFooterCell(Sender:
        TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure
        cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems11GetText(
        Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
        AText: string);
    procedure TeSpeedButton1Click(Sender: TObject);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems8GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems9GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);

  private
    flagedit : Boolean;
    fid : integer;
    fnomorjual : string ;
    FPivotChartLink: TcxPivotGridChartConnection;
    xtotal,xhpp : Double;
    iskupon : Integer;
    ntotalpremium , ntotalsolar , ntotalpertamax, ntotalpertamaxplus , ntotalpenjualan : double;
    ntotaljpremium , ntotaljsolar , ntotaljpertamax, ntotaljpertamaxplus  : double;
    ntotalbayar : double;
    xhppPremium,xhppsolar,xhpppertamaxplus,xhpppertamax : double ;
    function GetPivotChartLink: TcxPivotGridChartConnection;
  public

    procedure loaddata;
    procedure refreshdata;
    property PivotChartLink: TcxPivotGridChartConnection read GetPivotChartLink
        write FPivotChartLink;

    { Public declarations }
  end;

var

  frmLapBulananMarketing: TfrmLapBulananMarketing;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink;
{$R *.dfm}



procedure TfrmLapBulananMarketing.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmLapBulananMarketing.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmLapBulananMarketing.refreshdata;
begin
  edttahun.text :=  FormatDateTime('yyyy',Date);
end;

procedure TfrmLapBulananMarketing.sbNewClick(Sender: TObject);
begin
   refreshdata;

end;




procedure TfrmLapBulananMarketing.FormShow(Sender: TObject);
begin
  flagedit := False;
  refreshdata;
end;





procedure TfrmLapBulananMarketing.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmLapBulananMarketing.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmLapBulananMarketing.loaddata;
var
  ssql:string;
  capaibulanini : double;

begin
  ssql := 'SELECT tm_salesman Marketing,sls_nama Grup,SUM(target*hna) Target, SUM((jual-retur)*hna) Realisasi,'
+ ' SUM((jual-retur)*hna)/SUM(target*hna) * 100 persentase'
+ ' FROM ('
+ ' SELECT tm_salesman,nama_grouppf Nama,tm_target target,tm_hna hna, ('
+ ' SELECT IFNULL(SUM(fpd_qty),0)'
+ ' FROM tfp_dtl'
+ ' INNER JOIN tbarangpf ON bpf_brg_kode=fpd_brg_kode and bpf_periode = '+ IntToStr(cbbBulan.itemindex +1)+ ' and bpf_tahun='+edttahun.text
+ ' INNER JOIN tfp_hdr ON fp_nomor=fpd_fp_nomor AND MONTH(fp_tanggal)='+ IntToStr(cbbBulan.itemindex +1)+' AND YEAR(fp_tanggal)='+ edttahun.text
+ ' INNER JOIN tsalescustomer ON sc_cus_kode=fp_cus_kode'
+ ' WHERE sc_sls_kode=x.tm_salesman AND bpf_kode_grouppf=tm_grouppf '
+ ' ) jual, ('
+ ' SELECT IFNULL(SUM(fpd_qty*(((100-fpd_discpr)*fpd_harga/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)- ((fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)/100)+fpd_bp_rp))),0)'
+ ' FROM tfp_dtl'
+ ' INNER JOIN tbarangpf ON bpf_brg_kode=fpd_brg_kode and bpf_periode = '+ IntToStr(cbbBulan.itemindex +1)+ ' and bpf_tahun='+edttahun.text
+ ' INNER JOIN tfp_hdr ON fp_nomor=fpd_fp_nomor AND MONTH(fp_tanggal)='+ IntToStr(cbbBulan.itemindex +1)+' AND YEAR(fp_tanggal)='+ edttahun.text
+ ' INNER JOIN tsalescustomer ON sc_cus_kode=fp_cus_kode'
+ ' WHERE sc_sls_kode=x.tm_salesman AND bpf_kode_grouppf=tm_grouppf AND (((100-fpd_discpr)*fpd_harga/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)- ((fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)/100)+fpd_bp_rp)) >= fpd_hrg_min) pengali, ('
+ ' SELECT IFNULL(SUM(retjd_qty*(((100-fpd_discpr)*fpd_harga/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)- ((fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)/100)+fpd_bp_rp))),0)'
+ ' FROM tretj_dtl'
+ ' INNER JOIN tretj_hdr ON retjd_retj_nomor=retj_nomor AND MONTH(retj_tanggal)='+ IntToStr(cbbBulan.itemindex +1)+' AND YEAR(retj_tanggal)= ' + edttahun.text
+ ' INNER JOIN tbarangpf ON bpf_brg_kode=retjd_brg_kode and bpf_periode = '+ IntToStr(cbbBulan.itemindex +1)+ ' and bpf_tahun='+edttahun.text
+ ' INNER JOIN tfp_hdr ON fp_nomor=retj_fp_nomor'
+ ' INNER JOIN tfp_dtl ON fp_nomor=fpd_fp_nomor AND fpd_brg_kode=retjd_brg_kode'
+ ' INNER JOIN tsalescustomer ON sc_cus_kode=fp_cus_kode'
+ ' WHERE sc_sls_kode=x.tm_salesman AND bpf_kode_grouppf=tm_grouppf AND (((100-fpd_discpr)*fpd_harga/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)- ((fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)/100)+fpd_bp_rp)) >= fpd_hrg_min) pengurang, ('
+ ' SELECT IFNULL(SUM(retjd_qty),0)'
+ ' FROM tretj_dtl'
+ ' INNER JOIN tbarangpf ON bpf_brg_kode=retjd_brg_kode and bpf_periode = '+ IntToStr(cbbBulan.itemindex +1)+ ' and bpf_tahun='+edttahun.text
+ ' INNER JOIN tretj_hdr ON retj_nomor=retjd_retj_nomor AND MONTH(retj_tanggal)='+ IntToStr(cbbBulan.itemindex +1)+' AND YEAR(retj_tanggal)='+  edttahun.text
+ ' INNER JOIN tsalescustomer ON sc_cus_kode=retj_cus_kode'
+ ' WHERE sc_sls_kode=x.tm_salesman AND bpf_kode_grouppf=tm_grouppf) retur'
+ ' FROM ttargetmarketing x'
+ ' INNER JOIN tgrouppf ON tm_grouppf=kode_grouppf'
+ ' WHERE tm_periode='+ IntToStr(cbbBulan.itemindex +1)+' AND tm_tahun='+ edttahun.text+ ' ) FINAL INNER JOIN'
+ ' tsalesman ON sls_kode=tm_salesman'
+ ' GROUP BY tm_salesman';

//ssql:= ' SELECT Marketing,Grup,SUM(Nilai) Realisasi,Target,SUM(nilai)/target*100 persentase'
//+ '  FROM ('
//+ ' SELECT sls_nama Marketing,brg_kode Kode,brg_nama Nama,cus_nama Customer,cus_kode Kode_Cust,"N3" Grup,Nilai,gc_nama Golongan, Bulan,Tahun,'
//+ ' (SELECT SUM(pmh_het_bawah*pmd2_target) FROM tprodukmarketing_hdr'
//+ ' INNER JOIN tprodukmarketing_dtl2 ON pmd2_pmh_nomor=pmh_nomor'
//+ ' WHERE pmh_nomor LIKE "N3%" and pmd2_nama=marketing'
//+ ' ) Target'
//+ ' FROM tsalescustomer'
//+ ' INNER JOIN tcustomer ON cus_kode=sc_cus_kode'
//+ ' INNER JOIN tsalesman ON sls_kode=sc_sls_kode'
//+ ' LEFT JOIN tgolongancustomer ON gc_kode=cus_gc_kode'
//+ ' LEFT JOIN ('
//+ ' SELECT brg_kode,brg_nama,fp_cus_kode, MONTH(fp_tanggal) Bulan, YEAR(fp_tanggal) Tahun, '
//+ ' sum(fpd_qty*(((100-fpd_discpr)*fpd_harga/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)- '
//+ ' ((fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)/100)+fpd_bp_rp))) - '
//+ ' (SELECT ifnull(sum((retjd_harga*retjd_qty)*(100-ifnull(retjd_discpr,0))/100),0) FROM tretj_dtl inner join tretj_hdr on retjd_retj_nomor=retj_nomor where retjd_brg_kode=brg_kode AND retj_fp_nomor=fp_nomor) Nilai'
//+ ' FROM tprodukmarketing_hdr'
//+ ' INNER JOIN tprodukmarketing_dtl ON pmh_nomor=pmd_pmh_nomor AND pmh_nomor LIKE "N3%"'
//+ ' INNER JOIN tbarang ON brg_kode=pmd_brg_kode'
//+ ' INNER JOIN tfp_dtl ON fpd_brg_kode=pmd_brg_kode'
//+ ' INNER JOIN tfp_hdr ON fp_nomor=fpd_fp_nomor'
//+ ' WHERE month(fp_tanggal)='+ IntToStr(cbbBulan.itemindex +1)+' and year(fP_tanggal)='+ edtTahun.Text
//+ ' GROUP BY brg_kode,brg_nama,fp_cus_kode, MONTH(fp_tanggal), YEAR(fp_tanggal)) a ON a.fp_cus_kode=cus_Kode UNION'
//+ ' SELECT sls_nama Marketing,brg_kode Kode,brg_nama Nama,cus_nama Customer,cus_kode Kode_Cust,"MEDIA" Grup,Nilai,gc_nama Golongan, Bulan,Tahun,'
//+ ' (SELECT SUM(pmh_het_bawah*pmd2_target) FROM tprodukmarketing_hdr'
//+ ' INNER JOIN tprodukmarketing_dtl2 ON pmd2_pmh_nomor=pmh_nomor'
//+ ' WHERE pmh_nomor LIKE "MEDIA%" and pmd2_nama=marketing'
//+ ' ) Target'
//+ ' FROM tsalescustomer'
//+ ' INNER JOIN tcustomer ON cus_kode=sc_cus_kode'
//+ ' INNER JOIN tsalesman ON sls_kode=sc_sls_kode'
//+ ' LEFT JOIN tgolongancustomer ON gc_kode=cus_gc_kode'
//+ ' LEFT JOIN ('
//+ ' SELECT brg_kode,brg_nama,fp_cus_kode, MONTH(fp_tanggal) Bulan, YEAR(fp_tanggal) Tahun,'
//+ ' SUM((100-fpd_discpr)*(fpd_harga*fpd_qty)/100) - SUM(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*fpd_qty/100) - SUM(fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)*fpd_qty/100)+ SUM(fpd_bp_rp*fpd_qty) -'
//+ ' (SELECT ifnull(sum((retjd_harga*retjd_qty)*(100-ifnull(retjd_discpr,0))/100),0) FROM tretj_dtl inner join tretj_hdr on retjd_retj_nomor=retj_nomor where retjd_brg_kode=brg_kode AND retj_fp_nomor=fp_nomor) Nilai'
//+ ' FROM tprodukmarketing_hdr'
//+ ' INNER JOIN tprodukmarketing_dtl ON pmh_nomor=pmd_pmh_nomor AND pmh_nomor LIKE "MEDIA%"'
//+ ' INNER JOIN tfp_dtl ON fpd_brg_kode=pmd_brg_kode'
//+ ' INNER JOIN tbarang ON brg_kode=pmd_brg_kode'
//+ ' INNER JOIN tfp_hdr ON fp_nomor=fpd_fp_nomor'
//+ ' WHERE month(fp_tanggal)='+ IntToStr(cbbBulan.itemindex +1)+' and year(fP_tanggal)='+ edtTahun.Text
//+ ' GROUP BY brg_kode,brg_nama,fp_cus_kode, MONTH(fp_tanggal), YEAR(fp_tanggal)) a ON a.fp_cus_kode=cus_Kode) final'
//+ ' GROUP BY Marketing,Grup'
//+ ' ORDER BY grup';
//
        ds3.Close;
        sqlqry1.Connection := frmMenu.conn;
        sqlqry1.SQL.Text := ssql;
        ds3.open;
            ds3.first;
//        capaibulanini := cVarToFloat(TcxDBGridHelper(cxGrid1).GetFooterSummary('riilbulanini'))/ cVarToFloat(TcxDBGridHelper(cxGrid1).GetFooterSummary('targetbulanini'));
//TcxGridDBTableSummaryItem(cxGrid1).Column[0].Caption := '00';

end;

procedure TfrmLapBulananMarketing.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmLapBulananMarketing.cxGrid1DBBandedTableView1Column10CustomDrawCell(
    Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 70 then
      ACanvas.font.Color := clRed
    else if StrToFloatDef(AViewInfo.Text,0) < 100 then
        ACanvas.font.Color := clpurple
    else
      ACanvas.font.Color := clgreen;
        ACanvas.font.Style := [fsbold];

end;

procedure TfrmLapBulananMarketing.cxGrid1DBBandedTableView1Column10CustomDrawFooterCell(
    Sender: TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 70 then
      ACanvas.font.Color := clRed
    else if StrToFloatDef(AViewInfo.Text,0) < 100 then
        ACanvas.font.Color := clpurple
    else
      ACanvas.font.Color := clgreen;
        ACanvas.font.Style := [fsbold];

end;

procedure TfrmLapBulananMarketing.cxGrid1DBBandedTableView1Column13CustomDrawCell(
    Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
if StrToFloatDef(AViewInfo.Text,0) < 20 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];


end;

procedure TfrmLapBulananMarketing.cxGrid1DBBandedTableView1Column13CustomDrawFooterCell(
    Sender: TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
if StrToFloatDef(AViewInfo.Text,0) < 20 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];


end;

procedure TfrmLapBulananMarketing.cxGrid1DBBandedTableView1Column8CustomDrawCell(Sender:
    TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 70 then
      ACanvas.font.Color := clRed
    else if StrToFloatDef(AViewInfo.Text,0) < 100 then
        ACanvas.font.Color := clpurple
    else
      ACanvas.font.Color := clgreen;
        ACanvas.font.Style := [fsbold];

end;

procedure TfrmLapBulananMarketing.cxGrid1DBBandedTableView1Column8CustomDrawFooterCell(
    Sender: TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 70 then
      ACanvas.font.Color := clRed
    else if StrToFloatDef(AViewInfo.Text,0) < 100 then
        ACanvas.font.Color := clpurple
    else
      ACanvas.font.Color := clgreen;
        ACanvas.font.Style := [fsbold];

end;

procedure
    TfrmLapBulananMarketing.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems11GetText(
    Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
    AText: string);
var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('pf')) > 0  then
            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('pf'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('TargetBulanini'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;


procedure TfrmLapBulananMarketing.TeSpeedButton1Click(Sender: TObject);
begin

     if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid1);
     end;

end;


function TfrmLapBulananMarketing.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmLapBulananMarketing.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems8GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Target')) > 0  then
            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('realisasi'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Target'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

procedure TfrmLapBulananMarketing.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems9GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Targetbulanini')) > 0  then
            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilbulanini'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Targetbulanini'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

end.
