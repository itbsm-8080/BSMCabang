unit ufrmLapBulanan5;

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
  cxCurrencyEdit, cxGridDBBandedTableView, dxPScxGrid6Lnk,DateUtils,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue,
  DBAccess, MyAccess, MemDS;

type
  TfrmLapBulanan5 = class(TForm)
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
    Label2: TLabel;
    edtTahun: TComboBox;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    cxStyleRepository3: TcxStyleRepository;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    sqlqry1: TMyQuery;
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
    cxGrid1DBBandedTableView1Column11: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column12: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column13: TcxGridDBBandedColumn;
    growth: TcxGridDBBandedColumn;
    growth2: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column16: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column14: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column15: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column17: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column18: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column19: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column20: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column21: TcxGridDBBandedColumn;
    clAll: TcxGridDBBandedColumn;
    clAllratio: TcxGridDBBandedColumn;
    newcustomer: TcxGridDBBandedColumn;
    cxRSKLINIK: TcxGridDBBandedColumn;
    cxGrid1Level1: TcxGridLevel;
    chkSales: TCheckBox;
    cxGrid1DBBandedTableView1Column22: TcxGridDBBandedColumn;

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
    procedure growthCustomDrawCell(Sender:
        TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure growthCustomDrawFooterCell(Sender:
        TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column8CustomDrawCell(Sender:
        TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column8CustomDrawFooterCell(Sender:
        TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure
        cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems12GetText(
        Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
        AText: string);
    procedure
        cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems14GetText(
        Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
        AText: string);
    procedure TeSpeedButton1Click(Sender: TObject);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems8GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems9GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure growth2CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
        TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure growth2CustomDrawFooterCell(Sender: TcxGridTableView; ACanvas:
        TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems16GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrid1DBBandedTableView1Column19CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column19CustomDrawFooterCell(
      Sender: TcxGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column21CustomDrawCell(Sender:
        TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column21CustomDrawFooterCell(Sender:
        TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems19GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure
        cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems21GetText(
        Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
        AText: string);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems23GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems1GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrid1DBBandedTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems6GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems7GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems11GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems13GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems15GetText(
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

    procedure loaddata
    ;
    procedure refreshdata;
    property PivotChartLink: TcxPivotGridChartConnection read GetPivotChartLink
        write FPivotChartLink;

    { Public declarations }
  end;

var

  frmLapBulanan5: TfrmLapBulanan5;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink;
{$R *.dfm}

procedure TfrmLapBulanan5.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmLapBulanan5.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmLapBulanan5.refreshdata;
begin
  edttahun.text :=  FormatDateTime('yyyy',Date);
end;

procedure TfrmLapBulanan5.sbNewClick(Sender: TObject);
begin
   refreshdata;

end;

procedure TfrmLapBulanan5.FormShow(Sender: TObject);
begin
  flagedit := False;
  refreshdata;
end;

procedure TfrmLapBulanan5.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;

procedure TfrmLapBulanan5.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmLapBulanan5.loaddata;
var
  s,ssql,p,wheresls,wheresls2:string;
  capaibulanini : double;
  totaltarget : double;
  tsql : TmyQuery;
  akhir,akhir2 : TDateTime;
  cAwal, cAkhir: string;
  totalTargetBulanini, totalTargetSdBulanini, totalRiilBulanini, totalRiilSdBulanini,
  totalRiilBulaniniLalu, totalRiilSdBulaniniLalu, totalTargetTahunan, riilValue, targetValue: Double;
  riilSdValue, targetSdValue, totalTargetSd, riilLaluValue, riilBulaniniValue, totalRiilBulaniniValue: Double;
  riilSdLaluValue, riilSdBulaniniValue, totalRiilSdBulaniniValue, targetTahunanValue: Double;
begin
  if (StrToInt(edtTahun.Text) <= 2025) then
    p  := 'penjualan'
  else p := 'penjualanN3bySalesman';

  if chkSales.Checked then
  begin
    wheresls :=  'AND p.salesman NOT IN ( SELECT sls_kode FROM tsalesman WHERE sls_nama LIKE "%WAHID%" AND sls_kode IS NOT NULL) ';
    wheresls2 :=  'AND tso_hdr.so_sls_kode NOT IN ( SELECT sls_kode FROM tsalesman WHERE sls_nama LIKE "%WAHID%" AND sls_kode IS NOT NULL) '
  end
  else
  begin
    wheresls := ' ';
    wheresls2 := ' ';
  end;

  totalTargetBulanini := 0;
  totalTargetSdBulanini := 0;
  totalRiilBulanini := 0;
  totalRiilSdBulanini := 0;
  totalRiilBulaniniLalu := 0;
  totalRiilSdBulaniniLalu := 0;
  totalTargetTahunan := 0;

  if  cbbBulan.itemindex <> 0 then
  begin
    akhir := EndOfTheMonth(StrToDate(IntToStr(cbbBulan.itemindex )+'/01/'+edttahun.Text));
    akhir2 := EndOfTheMonth(StrToDate(IntToStr(cbbBulan.itemindex+1 )+'/01/'+edttahun.Text));
  end
  else
  begin
    akhir := EndOfTheMonth(StrToDate('12/01/'+inttostr(StrToInt(edtTahun.text)-1)));
    akhir2 := EndOfTheMonth(StrToDate(IntToStr(cbbBulan.itemindex+1 )+'/01/'+edttahun.Text));
  end;

  s := 'SET @bulan1=' +inttostr(cbbBulan.itemindex+1);
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  s := 'SET @tahun1=' + edtTahun.Text;
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  //=== MASTER
  ssql := 'SELECT DISTINCT '
      + ' ktg_kode,'
      + ' ktg_nama departemen,'
      + ' CAST(0 AS DECIMAL(15,2)) targetbulanini,'
      + ' CAST(0 AS DECIMAL(15,2)) targetsdbulanini,'
      + ' CAST(0 AS DECIMAL(5,2)) pfratio,'
      + ' CAST(0 AS DECIMAL(5,2)) growth,'
      + ' CAST(0 AS DECIMAL(5,2)) growth2,'
      + ' CAST(0 AS DECIMAL) riilbulaninilalu,'
      + ' CAST(0 AS DECIMAL) riilsdbulaniniLalu,'
      + ' CAST(0 AS DECIMAL) targettahunan,'
      + ' CAST(0 AS DECIMAL(5,2)) ratio,'
      + ' CAST(0 AS DECIMAL(15,2)) riilbulanini,'
      + ' CAST(0 AS DECIMAL(15,2)) riilsdbulanini,'
      + ' CAST(0 AS DECIMAL(15,2)) pf,'
      + ' CAST(0 AS DECIMAL(15,2)) persenbulanini,'
      + ' CAST(0 AS DECIMAL(15,2)) persensdbulanini '
      + 'FROM tkategori '
      + 'INNER JOIN tdepartementarget '
      + ' ON ktg_kode = dt_ktg_kode '
      + ' WHERE dt_tahun='+ edttahun.text+ ' and dt_periode = ' + IntToStr(cbbBulan.itemindex+1)
      + ' UNION ALL '
      + ' SELECT '
      + ' "9.8" AS ktg_kode, '
      + ' "TOTAL" AS departemen, '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(5,2)), '
      + ' CAST(0 AS DECIMAL(5,2)), '
      + ' CAST(0 AS DECIMAL(5,2)), '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(5,2)), '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(15,2)) '
      + ' UNION ALL '
      + ' SELECT '
      + ' "9.9" AS ktg_kode, '
      + ' "OTHER" AS departemen, '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(5,2)), '
      + ' CAST(0 AS DECIMAL(5,2)), '
      + ' CAST(0 AS DECIMAL(5,2)), '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(5,2)), '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(15,2)), '
      + ' CAST(0 AS DECIMAL(15,2))';
  ds3.Close;
  sqlqry1.Connection := frmMenu.conn;
  sqlqry1.SQL.Text := ssql;
  ds3.open;

  //==== TARGET

  ssql := ' SELECT ktg_kode, ktg_nama departemen, dt_targetsales target '
         + 'FROM tdepartementarget '
         + 'inner join tkategori on ktg_kode=dt_ktg_kode '
         + 'WHERE dt_periode = ' + IntToStr(cbbBulan.itemindex+1) + ' AND dt_tahun = ' + edttahun.text
         + ' ORDER BY ktg_kode';
  tsql := xOpenQuery(ssql, frmMenu.conn);

  with tsql do
  begin
    try
      while not eof do
      begin
           ds3.IndexFieldNames := 'departemen';
           if ds3.findkey([FieldByName('departemen').AsString]) then
           begin
             If ds3.State <> dsEdit then ds3.Edit;
              ds3.FieldByName('targetBulanini').AsFloat := FieldByName('target').AsFloat/1000;
           end;

           totalTargetBulanini := totalTargetBulanini + (FieldByName('target').AsFloat/1000);
        Next;
      end;

      if ds3.findkey(['TOTAL']) then
      begin
        If ds3.State <> dsEdit then ds3.Edit;
        ds3.FieldByName('targetBulanini').AsFloat := totalTargetBulanini;
      end;
    finally
      Free;
    end;
  end;

  //==== TARGET KAT. OTHER
  cAwal  := FormatDateTime('yyyy-mm-dd',
           EncodeDate(StrToInt(edttahun.Text)-1,
                      cbbBulan.ItemIndex + 1,
                      1));

  cAkhir := FormatDateTime('yyyy-mm-dd',
             IncMonth(EncodeDate(StrToInt(edttahun.Text)-1,
                                 cbbBulan.ItemIndex + 1,
                                 1), 1) - 1);
  s:= 'set @tg1 ='+quot(cAwal)+';';
  s:= s +'set @tg2 ='+quot(cAkhir)+';';
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  ssql := 'SELECT ' +
          '    "OTHER" departemen, ' +
          '    SUM(p.riil - COALESCE(r.total_retur, 0)) AS target ' +
          'FROM ( ' +
          '    SELECT ' +
          '        b.ktg_nama AS departemen, ' +
          '        b.ktg_kode AS dept_kode, ' +
          '        SUM( ' +
          '            IF(YEAR(p.tanggal) > 2021, p.dpp, p.total) ' +
          '            - p.biaya_promosi ' +
          '            - p.fee_marketing ' +
          '            - p.kontrak ' +
          '        ) AS riil ' +
          '    FROM penjualannonn3bydepartemen p ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = p.salesman AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '     AND st_tahun = ' + edttahun.text + ') ' +
          '    INNER JOIN tkategori b ON b.ktg_kode = p.departemen ' +
          '    WHERE p.tanggal BETWEEN '+quot(cAwal)+' AND '+quot(cAkhir) + ' '
          + wheresls +
          '    GROUP BY b.ktg_nama, b.ktg_kode ' +
          ') p ' +
          'LEFT JOIN ( ' +
          '    SELECT ' +
          '        SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) AS dept_kode, ' +
          '        SUM( ' +
          '            (td.retjd_harga * td.retjd_qty) ' +
          '        ) AS total_retur ' +
          '    FROM tretj_hdr th ' +
          '    INNER JOIN tretj_dtl td ON td.retjd_retj_nomor = th.retj_nomor ' +
          '    INNER JOIN tbarang tb ON tb.brg_kode = td.retjd_brg_kode ' +
          '    INNER JOIN tfp_hdr ON th.retj_fp_nomor = fp_nomor ' +
          '    INNER JOIN tdo_hdr ON do_nomor = fp_do_nomor ' +
          '    INNER JOIN tso_hdr ON so_nomor = do_so_nomor ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = tso_hdr.so_sls_kode AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '    AND st_tahun = ' + edtTahun.Text + ') ' +
          '    WHERE (tb.brg_ktg_kode NOT LIKE "4%" OR tb.brg_ktg_kode IS NULL ) ' +
          '      AND MONTH(th.retj_tanggal) = ' + IntToStr(cbbBulan.itemindex +1) +
          '      AND YEAR(th.retj_tanggal) = ' + inttostr(strtoint(edtTahun.Text)-1) + ' '
          + wheresls2 +
          '    GROUP BY SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) ' +
          ') r ' +
          'ON r.dept_kode = p.dept_kode';

  tsql := xOpenQuery(ssql, frmMenu.conn);
  with tsql do
  begin
    try
      while not eof do
      begin
           ds3.IndexFieldNames := 'departemen';
           if ds3.findkey([FieldByName('departemen').AsString]) then
           begin
             If ds3.State <> dsEdit then ds3.Edit;
              ds3.FieldByName('targetBulanini').AsFloat := FieldByName('target').AsFloat/1000;
           end;
        Next;
      end;
    finally
      Free;
    end;
  end;

  //==== TARGET SD BULAN INI
  ssql := 'SELECT '
      + ' ktg_nama departemen,'
      + ' SUM(dt_targetsales) targetsdbulanini '
      + 'FROM tdepartementarget '
      + 'INNER JOIN tkategori '
      + ' ON ktg_kode = dt_ktg_kode '
      + 'WHERE dt_periode <= ' + IntToStr(cbbBulan.itemindex+1)
      + ' AND dt_tahun = ' + edttahun.text
      + ' GROUP BY ktg_nama';

  totalTargetSdBulanini := 0;

  tsql := xOpenQuery(ssql,frmMenu.conn);
  with tsql do
  begin
    try
      while not eof do
      begin
           ds3.IndexFieldNames := 'departemen';
           if ds3.findkey([FieldByName('departemen').AsString]) then
           begin
             If ds3.State <> dsEdit then ds3.Edit;
              ds3.FieldByName('targetsdbulanini').AsFloat := FieldByName('targetsdbulanini').AsFloat/1000;
           end;

           totalTargetSdBulanini := totalTargetSdBulanini + (FieldByName('targetsdbulanini').AsFloat/1000);
        Next;
      end;

      if ds3.findkey(['TOTAL']) then
      begin
        If ds3.State <> dsEdit then ds3.Edit;
        ds3.FieldByName('targetsdbulanini').AsFloat := totalTargetSdBulanini;
      end;
    finally
      Free;
    end;
  end;

  //==== TARGET SD BULAN INI KAT. OTHER
  cAwal  := FormatDateTime('yyyy-mm-dd',
            EncodeDate(StrToInt(edttahun.Text)-1,
                      1,
                      1));

  cAkhir := FormatDateTime('yyyy-mm-dd',
            IncMonth(EncodeDate(StrToInt(edttahun.Text)-1,
                               cbbBulan.ItemIndex + 1,
                               1), 1) - 1);

  s:= 'set @tg1 ='+quot(cAwal)+';';
  s:= s +'set @tg2 ='+quot(cAkhir)+';';
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  ssql := 'SELECT ' +
          '    "OTHER" departemen, ' +
          '    SUM(p.riil - COALESCE(r.total_retur, 0)) AS targetsdbulanini ' +
          'FROM ( ' +
          '    SELECT ' +
          '        b.ktg_nama AS departemen, ' +
          '        b.ktg_kode AS dept_kode, ' +
          '        SUM( ' +
          '            IF(YEAR(p.tanggal) > 2021, p.dpp, p.total) ' +
          '            - p.biaya_promosi ' +
          '            - p.fee_marketing ' +
          '            - p.kontrak ' +
          '        ) AS riil ' +
          '    FROM penjualannonn3bydepartemen p ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = p.salesman AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '     AND st_tahun = ' + edtTahun.Text + ') ' +
          '    INNER JOIN tkategori b ON b.ktg_kode = p.departemen ' +
          '    WHERE p.tanggal BETWEEN '+quot(cAwal)+' AND '+quot(cAkhir) + ' '
          + wheresls +
          '    GROUP BY b.ktg_nama, b.ktg_kode ' +
          ') p ' +
          'LEFT JOIN ( ' +
          '    SELECT ' +
          '        SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) AS dept_kode, ' +
          '        SUM( ' +
          '            (td.retjd_harga * td.retjd_qty) ' +
          '        ) AS total_retur ' +
          '    FROM tretj_hdr th ' +
          '    INNER JOIN tretj_dtl td ON td.retjd_retj_nomor = th.retj_nomor ' +
          '    INNER JOIN tbarang tb ON tb.brg_kode = td.retjd_brg_kode ' +
          '    INNER JOIN tfp_hdr ON th.retj_fp_nomor = fp_nomor ' +
          '    INNER JOIN tdo_hdr ON do_nomor = fp_do_nomor ' +
          '    INNER JOIN tso_hdr ON so_nomor = do_so_nomor ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = tso_hdr.so_sls_kode AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '    AND st_tahun = ' + edtTahun.Text + ') ' +
          '    WHERE (tb.brg_ktg_kode NOT LIKE "4%" OR tb.brg_ktg_kode IS NULL ) ' +
          '      AND MONTH(th.retj_tanggal) <= ' + IntToStr(cbbBulan.itemindex +1) +
          '      AND YEAR(th.retj_tanggal) = ' + inttostr(strtoint(edtTahun.Text)-1) + ' '
          + wheresls2 +
          '    GROUP BY SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) ' +
          ') r ' +
          'ON r.dept_kode = p.dept_kode';

  tsql := xOpenQuery(ssql,frmMenu.conn);
  with tsql do
  begin
    try
      while not eof do
      begin
           ds3.IndexFieldNames := 'departemen';
           if ds3.findkey([FieldByName('departemen').AsString]) then
           begin
             If ds3.State <> dsEdit then ds3.Edit;
              ds3.FieldByName('targetsdbulanini').AsFloat := FieldByName('targetsdbulanini').AsFloat/1000;
           end;
        Next;
      end;
    finally
      Free;
    end;
  end;

  //==== RILL CAPAIAN
  cAwal  := FormatDateTime('yyyy-mm-dd',
             EncodeDate(StrToInt(edttahun.Text),
                        cbbBulan.ItemIndex + 1,
                        1));

  cAkhir := FormatDateTime('yyyy-mm-dd',
             IncMonth(EncodeDate(StrToInt(edttahun.Text),
                                 cbbBulan.ItemIndex + 1,
                                 1), 1) - 1);

  s:= 'set @tg1 ='+quot(cAwal)+';';
  s:= s +'set @tg2 ='+quot(cAkhir)+';';
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  ssql := 'SELECT ' +
          '    p.departemen, ' +
          '    p.riil - COALESCE(r.total_retur, 0) AS Riilbulanini ' +
          'FROM ( ' +
          '    SELECT ' +
          '        b.ktg_nama AS departemen, ' +
          '        b.ktg_kode AS dept_kode, ' +
          '        SUM( ' +
          '            IF(YEAR(p.tanggal) > 2021, p.dpp, p.total) ' +
          '            - p.biaya_promosi ' +
          '            - p.fee_marketing ' +
          '            - p.kontrak ' +
          '        ) AS riil ' +
          '    FROM penjualanN3bydepartemen p ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = p.salesman AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '     AND st_tahun = ' + edtTahun.Text + ') ' +
          '    INNER JOIN tkategori b ON b.ktg_kode = p.departemen ' +
          '    WHERE p.tanggal BETWEEN '+quot(cAwal)+' AND '+quot(cAkhir) + ' '
          + wheresls +
          '    GROUP BY b.ktg_nama, b.ktg_kode ' +
          ') p ' +
          'LEFT JOIN ( ' +
          '    SELECT ' +
          '        SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) AS dept_kode, ' +
          '        SUM( ' +
          '            (td.retjd_harga * td.retjd_qty) ' +
          '        ) AS total_retur ' +
          '    FROM tretj_hdr th ' +
          '    INNER JOIN tretj_dtl td ON td.retjd_retj_nomor = th.retj_nomor ' +
          '    INNER JOIN tbarang tb ON tb.brg_kode = td.retjd_brg_kode ' +
          '    INNER JOIN tfp_hdr ON th.retj_fp_nomor = fp_nomor ' +
          '    INNER JOIN tdo_hdr ON do_nomor = fp_do_nomor ' +
          '    INNER JOIN tso_hdr ON so_nomor = do_so_nomor ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = tso_hdr.so_sls_kode AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '    AND st_tahun = ' + edtTahun.Text + ') ' +
          '    WHERE tb.brg_ktg_kode LIKE ''4%'' ' +
          '      AND MONTH(th.retj_tanggal) = ' + IntToStr(cbbBulan.itemindex + 1) +
          '      AND YEAR(th.retj_tanggal) = ' + edtTahun.Text + ' '
          + wheresls2 +
          '    GROUP BY SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) ' +
          ') r ' +
          'ON r.dept_kode = p.dept_kode';

    totalRiilBulanini := 0;

    tsql := xOpenQuery(ssql,frmMenu.conn);
    with tsql do
    begin
      try
        while not eof do
        begin
             ds3.IndexFieldNames := 'departemen';

             if ds3.findkey([FieldByName('departemen').AsString]) then
             begin
               If ds3.State <> dsEdit then ds3.Edit;

                ds3.FieldByName('riilbulanini').AsFloat := FieldByName('riilbulanini').AsFloat/1000;
                if FieldByName('riilbulanini').AsFloat > 0 then
                ds3.FieldByName('persenbulanini').AsFloat :=ds3.FieldByName('riilbulanini').AsFloat/ds3.FieldByName('targetbulanini').AsFloat*100;

             end;

             riilValue := FieldByName('riilbulanini').AsFloat/1000;
             targetValue := ds3.FieldByName('targetbulanini').AsFloat;
             totalRiilBulanini := totalRiilBulanini + riilValue;
          Next;
        end;

         if ds3.findkey(['TOTAL']) then
        begin
          If ds3.State <> dsEdit then ds3.Edit;
          ds3.FieldByName('riilbulanini').AsFloat := totalRiilBulanini;

          totalTarget := ds3.FieldByName('targetbulanini').AsFloat;
          if (totalRiilBulanini > 0) and (totalTarget > 0) then
            ds3.FieldByName('persenbulanini').AsFloat := (totalRiilBulanini / totalTarget) * 100
          else
            ds3.FieldByName('persenbulanini').AsFloat := 0;
        end;
//        Sleep(1);  // 10ms cukup
//        Application.ProcessMessages; // biar UI tetap responsif
      finally
        Free;
      end;
    end;


  //==== RILL CAPAIAN KAT. OTHER
  cAwal  := FormatDateTime('yyyy-mm-dd',
             EncodeDate(StrToInt(edttahun.Text),
                        cbbBulan.ItemIndex + 1,
                        1));

  cAkhir := FormatDateTime('yyyy-mm-dd',
             IncMonth(EncodeDate(StrToInt(edttahun.Text),
                                 cbbBulan.ItemIndex + 1,
                                 1), 1) - 1);

  s:= 'set @tg1 ='+quot(cAwal)+';';
  s:= s +'set @tg2 ='+quot(cAkhir)+';';
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  ssql := 'SELECT ' +
          '    "OTHER" departemen, ' +
          '    SUM(p.riil - COALESCE(r.total_retur, 0)) AS Riilbulanini ' +
          'FROM ( ' +
          '    SELECT ' +
          '        b.ktg_nama AS departemen, ' +
          '        b.ktg_kode AS dept_kode, ' +
          '        SUM( ' +
          '            IF(YEAR(p.tanggal) > 2021, p.dpp, p.total) ' +
          '            - p.biaya_promosi ' +
          '            - p.fee_marketing ' +
          '            - p.kontrak ' +
          '        ) AS riil ' +
          '    FROM penjualannonn3bydepartemen p ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = p.salesman AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '     AND st_tahun = ' + edtTahun.Text + ') ' +
          '    INNER JOIN tkategori b ON b.ktg_kode = p.departemen ' +
          '    WHERE p.tanggal BETWEEN '+quot(cAwal)+' AND '+quot(cAkhir) + ' '
          + wheresls +
          '    GROUP BY b.ktg_nama, b.ktg_kode ' +
          ') p ' +
          'LEFT JOIN ( ' +
          '    SELECT ' +
          '        SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) AS dept_kode, ' +
          '        SUM( ' +
          '            (td.retjd_harga * td.retjd_qty) ' +
          '        ) AS total_retur ' +
          '    FROM tretj_hdr th ' +
          '    INNER JOIN tretj_dtl td ON td.retjd_retj_nomor = th.retj_nomor ' +
          '    INNER JOIN tbarang tb ON tb.brg_kode = td.retjd_brg_kode ' +
          '    INNER JOIN tfp_hdr ON th.retj_fp_nomor = fp_nomor ' +
          '    INNER JOIN tdo_hdr ON do_nomor = fp_do_nomor ' +
          '    INNER JOIN tso_hdr ON so_nomor = do_so_nomor ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = tso_hdr.so_sls_kode AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '    AND st_tahun = ' + edtTahun.Text + ') ' +
          '    WHERE (tb.brg_ktg_kode NOT LIKE "4%" OR tb.brg_ktg_kode IS NULL ) ' +
          '      AND MONTH(th.retj_tanggal) = ' + IntToStr(cbbBulan.itemindex + 1) +
          '      AND YEAR(th.retj_tanggal) = ' + edtTahun.Text + ' '
          + wheresls2 +
          '    GROUP BY SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) ' +
          ') r ' +
          'ON r.dept_kode = p.dept_kode';

    tsql := xOpenQuery(ssql,frmMenu.conn);
    with tsql do
    begin
      try
        while not eof do
        begin
             ds3.IndexFieldNames := 'departemen';

             if ds3.findkey([FieldByName('departemen').AsString]) then
             begin
               If ds3.State <> dsEdit then ds3.Edit;

                ds3.FieldByName('riilbulanini').AsFloat := FieldByName('riilbulanini').AsFloat/1000;
                if FieldByName('riilbulanini').AsFloat > 0 then
                ds3.FieldByName('persenbulanini').AsFloat :=ds3.FieldByName('riilbulanini').AsFloat/ds3.FieldByName('targetbulanini').AsFloat*100;

             end;
          Next;
        end;
//        Sleep(1);  // 10ms cukup
//        Application.ProcessMessages; // biar UI tetap responsif
      finally
        Free;
      end;
    end;

  // RILL CAPAIAN sd BULAN INI
  cAwal  := FormatDateTime('yyyy-mm-dd',
            EncodeDate(StrToInt(edttahun.Text),
                      1,
                      1));

  cAkhir := FormatDateTime('yyyy-mm-dd',
            IncMonth(EncodeDate(StrToInt(edttahun.Text),
                               cbbBulan.ItemIndex + 1,
                               1), 1) - 1);

  s:= 'set @tg1 ='+quot(cAwal)+';';
  s:= s +'set @tg2 ='+quot(cAkhir)+';';
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  ssql := 'SELECT ' +
          '    p.departemen, ' +
          '    p.riil - COALESCE(r.total_retur, 0) AS riilsdbulanini ' +
          'FROM ( ' +
          '    SELECT ' +
          '        b.ktg_nama AS departemen, ' +
          '        b.ktg_kode AS dept_kode, ' +
          '        SUM( ' +
          '            IF(YEAR(p.tanggal) > 2021, p.dpp, p.total) ' +
          '            - p.biaya_promosi ' +
          '            - p.fee_marketing ' +
          '            - p.kontrak ' +
          '        ) AS riil ' +
          '    FROM penjualanN3bydepartemen p ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = p.salesman AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '     AND st_tahun = ' + edtTahun.Text + ') ' +
          '    INNER JOIN tkategori b ON b.ktg_kode = p.departemen ' +
          '    WHERE p.tanggal BETWEEN '+quot(cAwal)+' AND '+quot(cAkhir) + ' '
          + wheresls +
          '    GROUP BY b.ktg_nama, b.ktg_kode ' +
          ') p ' +
          'LEFT JOIN ( ' +
          '    SELECT ' +
          '        SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) AS dept_kode, ' +
          '        SUM( ' +
          '            (td.retjd_harga * td.retjd_qty) ' +
          '        ) AS total_retur ' +
          '    FROM tretj_hdr th ' +
          '    INNER JOIN tretj_dtl td ON td.retjd_retj_nomor = th.retj_nomor ' +
          '    INNER JOIN tbarang tb ON tb.brg_kode = td.retjd_brg_kode ' +
          '    INNER JOIN tfp_hdr ON th.retj_fp_nomor = fp_nomor ' +
          '    INNER JOIN tdo_hdr ON do_nomor = fp_do_nomor ' +
          '    INNER JOIN tso_hdr ON so_nomor = do_so_nomor ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = tso_hdr.so_sls_kode AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '    AND st_tahun = ' + edtTahun.Text + ') ' +
          '    WHERE tb.brg_ktg_kode LIKE ''4%'' ' +
          '      AND MONTH(th.retj_tanggal) <= ' + IntToStr(cbbBulan.itemindex + 1) +
          '      AND YEAR(th.retj_tanggal) = ' + edtTahun.Text + ' '
          + wheresls2 +
          '    GROUP BY SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) ' +
          ') r ' +
          'ON r.dept_kode = p.dept_kode';

    totalRiilSdBulanini := 0;

    tsql := xOpenQuery(ssql,frmMenu.conn);
    with tsql do
    begin
      try
        while not eof do
        begin
             ds3.IndexFieldNames := 'departemen';
             if ds3.findkey([FieldByName('departemen').AsString]) then
             begin
               If ds3.State <> dsEdit then ds3.Edit;

                ds3.FieldByName('riilsdbulanini').AsFloat := FieldByName('riilsdbulanini').AsFloat/1000;
                if ds3.FieldByName('targetsdbulanini').AsFloat > 0 then
                ds3.FieldByName('persensdbulanini').AsFloat :=ds3.FieldByName('riilsdbulanini').AsFloat/(ds3.FieldByName('targetsdbulanini').AsFloat)*100;
                ds3.Post;
             end;

             riilSdValue := FieldByName('riilsdbulanini').AsFloat/1000;
             targetSdValue := ds3.FieldByName('targetsdbulanini').AsFloat;
             totalRiilSdBulanini := totalRiilSdBulanini + riilSdValue;
          Next;
        end;

        if ds3.findkey(['TOTAL']) then
        begin
          If ds3.State <> dsEdit then ds3.Edit;
          ds3.FieldByName('riilsdbulanini').AsFloat := totalRiilSdBulanini;

          totalTargetSd := ds3.FieldByName('targetsdbulanini').AsFloat;
          if (totalRiilSdBulanini > 0) and (totalTargetSd > 0) then
            ds3.FieldByName('persensdbulanini').AsFloat := (totalRiilSdBulanini / totalTargetSd) * 100
          else
            ds3.FieldByName('persensdbulanini').AsFloat := 0;
        end;
//        Sleep(1);  // 10ms cukup
//      Application.ProcessMessages; // biar UI tetap responsif
      finally
        Free;
      end;
    end;

  // RILL CAPAIAN sd BULAN INI KAT. OTHER
  cAwal  := FormatDateTime('yyyy-mm-dd',
            EncodeDate(StrToInt(edttahun.Text),
                      1,
                      1));

  cAkhir := FormatDateTime('yyyy-mm-dd',
            IncMonth(EncodeDate(StrToInt(edttahun.Text),
                               cbbBulan.ItemIndex + 1,
                               1), 1) - 1);

  s:= 'set @tg1 ='+quot(cAwal)+';';
  s:= s +'set @tg2 ='+quot(cAkhir)+';';
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  ssql := 'SELECT ' +
          '    "OTHER" departemen, ' +
          '    SUM(p.riil - COALESCE(r.total_retur, 0)) AS riilsdbulanini ' +
          'FROM ( ' +
          '    SELECT ' +
          '        b.ktg_nama AS departemen, ' +
          '        b.ktg_kode AS dept_kode, ' +
          '        SUM( ' +
          '            IF(YEAR(p.tanggal) > 2021, p.dpp, p.total) ' +
          '            - p.biaya_promosi ' +
          '            - p.fee_marketing ' +
          '            - p.kontrak ' +
          '        ) AS riil ' +
          '    FROM penjualannonn3bydepartemen p ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = p.salesman AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '     AND st_tahun = ' + edtTahun.Text + ') ' +
          '    INNER JOIN tkategori b ON b.ktg_kode = p.departemen ' +
          '    WHERE p.tanggal BETWEEN '+quot(cAwal)+' AND '+quot(cAkhir) + ' '
          + wheresls +
          '    GROUP BY b.ktg_nama, b.ktg_kode ' +
          ') p ' +
          'LEFT JOIN ( ' +
          '    SELECT ' +
          '        SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) AS dept_kode, ' +
          '        SUM( ' +
          '            (td.retjd_harga * td.retjd_qty) ' +
          '        ) AS total_retur ' +
          '    FROM tretj_hdr th ' +
          '    INNER JOIN tretj_dtl td ON td.retjd_retj_nomor = th.retj_nomor ' +
          '    INNER JOIN tbarang tb ON tb.brg_kode = td.retjd_brg_kode ' +
          '    INNER JOIN tfp_hdr ON th.retj_fp_nomor = fp_nomor ' +
          '    INNER JOIN tdo_hdr ON do_nomor = fp_do_nomor ' +
          '    INNER JOIN tso_hdr ON so_nomor = do_so_nomor ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = tso_hdr.so_sls_kode AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '    AND st_tahun = ' + edtTahun.Text + ') ' +
          '    WHERE (tb.brg_ktg_kode NOT LIKE "4%" OR tb.brg_ktg_kode IS NULL ) ' +
          '      AND MONTH(th.retj_tanggal) <= ' + IntToStr(cbbBulan.itemindex + 1) +
          '      AND YEAR(th.retj_tanggal) = ' + edtTahun.Text + ' '
          + wheresls2 +
          '    GROUP BY SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) ' +
          ') r ' +
          'ON r.dept_kode = p.dept_kode';

    tsql := xOpenQuery(ssql,frmMenu.conn);
    with tsql do
    begin
      try
        while not eof do
        begin
             ds3.IndexFieldNames := 'departemen';
             if ds3.findkey([FieldByName('departemen').AsString]) then
             begin
               If ds3.State <> dsEdit then ds3.Edit;

                ds3.FieldByName('riilsdbulanini').AsFloat := FieldByName('riilsdbulanini').AsFloat/1000;
                if ds3.FieldByName('targetsdbulanini').AsFloat > 0 then
                ds3.FieldByName('persensdbulanini').AsFloat :=ds3.FieldByName('riilsdbulanini').AsFloat/(ds3.FieldByName('targetsdbulanini').AsFloat)*100;
                ds3.Post;
             end;
          Next;
        end;
//        Sleep(1);  // 10ms cukup
//      Application.ProcessMessages; // biar UI tetap responsif
      finally
        Free;
      end;
    end;

  // RIIL BULAN INI TAHUN LALU
  cAwal  := FormatDateTime('yyyy-mm-dd',
            EncodeDate(StrToInt(edttahun.Text)-1,
                      cbbBulan.ItemIndex + 1,
                      1));

  cAkhir := FormatDateTime('yyyy-mm-dd',
           IncMonth(EncodeDate(StrToInt(edttahun.Text)-1,
                               cbbBulan.ItemIndex + 1,
                               1), 1) - 1);

  s:= 'set @tg1 ='+quot(cAwal)+';';
  s:= s +'set @tg2 ='+quot(cAkhir)+';';
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  ssql := 'SELECT ' +
          '    p.departemen, ' +
          '    p.riil - COALESCE(r.total_retur, 0) AS riilbulaninilalu ' +
          'FROM ( ' +
          '    SELECT ' +
          '        b.ktg_nama AS departemen, ' +
          '        b.ktg_kode AS dept_kode, ' +
          '        SUM( ' +
          '            IF(YEAR(p.tanggal) > 2021, p.dpp, p.total) ' +
          '            - p.biaya_promosi ' +
          '            - p.fee_marketing ' +
          '            - p.kontrak ' +
          '        ) AS riil ' +
          '    FROM penjualanN3bydepartemen p ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = p.salesman AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '     AND st_tahun = ' + edttahun.text + ') ' +
          '    INNER JOIN tkategori b ON b.ktg_kode = p.departemen ' +
          '    WHERE p.tanggal BETWEEN '+quot(cAwal)+' AND '+quot(cAkhir) + ' '
          + wheresls +
          '    GROUP BY b.ktg_nama, b.ktg_kode ' +
          ') p ' +
          'LEFT JOIN ( ' +
          '    SELECT ' +
          '        SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) AS dept_kode, ' +
          '        SUM( ' +
          '            (td.retjd_harga * td.retjd_qty) ' +
          '        ) AS total_retur ' +
          '    FROM tretj_hdr th ' +
          '    INNER JOIN tretj_dtl td ON td.retjd_retj_nomor = th.retj_nomor ' +
          '    INNER JOIN tbarang tb ON tb.brg_kode = td.retjd_brg_kode ' +
          '    INNER JOIN tfp_hdr ON th.retj_fp_nomor = fp_nomor ' +
          '    INNER JOIN tdo_hdr ON do_nomor = fp_do_nomor ' +
          '    INNER JOIN tso_hdr ON so_nomor = do_so_nomor ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = tso_hdr.so_sls_kode AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '    AND st_tahun = ' + edttahun.text + ') ' +
          '    WHERE tb.brg_ktg_kode LIKE ''4%'' ' +
          '      AND MONTH(th.retj_tanggal) = ' + IntToStr(cbbBulan.itemindex +1) +
          '      AND YEAR(th.retj_tanggal) = ' + inttostr(strtoint(edtTahun.Text)-1) + ' '
          + wheresls2 +
          '    GROUP BY SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) ' +
          ') r ' +
          'ON r.dept_kode = p.dept_kode';

   totalRiilBulaniniLalu := 0;

  tsql := xOpenQuery(ssql, frmMenu.conn);
  with tsql do
  begin
    try
      while not eof do
      begin

           ds3.IndexFieldNames := 'departemen';
           if ds3.findkey([FieldByName('departemen').AsString]) then
           begin
             If ds3.State <> dsEdit then ds3.Edit;
              ds3.FieldByName('riilbulaninilalu').AsFloat := FieldByName('Riilbulaninilalu').AsFloat/1000;
            if ds3.FieldByName('riilbulaninilalu').AsFloat > 0 then
              ds3.FieldByName('growth').AsFloat :=ds3.FieldByName('riilbulanini').AsFloat/(FieldByName('Riilbulaninilalu').AsFloat/1000)*100;
           end;

           riilLaluValue := FieldByName('riilbulaninilalu').AsFloat/1000;
           riilBulaniniValue := ds3.FieldByName('riilbulanini').AsFloat;

           totalRiilBulaniniLalu := totalRiilBulaniniLalu + riilLaluValue;
        Next;
      end;

      if ds3.findkey(['TOTAL']) then
      begin
        If ds3.State <> dsEdit then ds3.Edit;
        ds3.FieldByName('riilbulaninilalu').AsFloat := totalRiilBulaniniLalu;

        totalRiilBulaniniValue := ds3.FieldByName('riilbulanini').AsFloat;
        if (totalRiilBulaniniLalu > 0) and (totalRiilBulaniniValue > 0) then
          ds3.FieldByName('growth').AsFloat := (totalRiilBulaniniValue / totalRiilBulaniniLalu) * 100
        else
          ds3.FieldByName('growth').AsFloat := 0;
      end;
//        Sleep(1);  // 10ms cukup
//      Application.ProcessMessages; // biar UI tetap responsif
    finally
      Free;
    end;
  end;

  // RIIL TAHUN LALU KAT. OTHER
  cAwal  := FormatDateTime('yyyy-mm-dd',
            EncodeDate(StrToInt(edttahun.Text)-1,
                      cbbBulan.ItemIndex + 1,
                      1));

  cAkhir := FormatDateTime('yyyy-mm-dd',
           IncMonth(EncodeDate(StrToInt(edttahun.Text)-1,
                               cbbBulan.ItemIndex + 1,
                               1), 1) - 1);

  s:= 'set @tg1 ='+quot(cAwal)+';';
  s:= s +'set @tg2 ='+quot(cAkhir)+';';
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  ssql := 'SELECT ' +
          '    "OTHER" departemen, ' +
          '    SUM(p.riil - COALESCE(r.total_retur, 0)) AS riilbulaninilalu ' +
          'FROM ( ' +
          '    SELECT ' +
          '        b.ktg_nama AS departemen, ' +
          '        b.ktg_kode AS dept_kode, ' +
          '        SUM( ' +
          '            IF(YEAR(p.tanggal) > 2021, p.dpp, p.total) ' +
          '            - p.biaya_promosi ' +
          '            - p.fee_marketing ' +
          '            - p.kontrak ' +
          '        ) AS riil ' +
          '    FROM penjualannonn3bydepartemen p ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = p.salesman AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '     AND st_tahun = ' + edttahun.text + ') ' +
          '    INNER JOIN tkategori b ON b.ktg_kode = p.departemen ' +
          '    WHERE p.tanggal BETWEEN '+quot(cAwal)+' AND '+quot(cAkhir) + ' '
          + wheresls +
          '    GROUP BY b.ktg_nama, b.ktg_kode ' +
          ') p ' +
          'LEFT JOIN ( ' +
          '    SELECT ' +
          '        SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) AS dept_kode, ' +
          '        SUM( ' +
          '            (td.retjd_harga * td.retjd_qty) ' +
          '        ) AS total_retur ' +
          '    FROM tretj_hdr th ' +
          '    INNER JOIN tretj_dtl td ON td.retjd_retj_nomor = th.retj_nomor ' +
          '    INNER JOIN tbarang tb ON tb.brg_kode = td.retjd_brg_kode ' +
          '    INNER JOIN tfp_hdr ON th.retj_fp_nomor = fp_nomor ' +
          '    INNER JOIN tdo_hdr ON do_nomor = fp_do_nomor ' +
          '    INNER JOIN tso_hdr ON so_nomor = do_so_nomor ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = tso_hdr.so_sls_kode AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '    AND st_tahun = ' + edttahun.text + ') ' +
          '    WHERE (tb.brg_ktg_kode NOT LIKE "4%" OR tb.brg_ktg_kode IS NULL ) ' +
          '      AND MONTH(th.retj_tanggal) = ' + IntToStr(cbbBulan.itemindex +1) +
          '      AND YEAR(th.retj_tanggal) = ' + inttostr(strtoint(edtTahun.Text)-1) + ' '
          + wheresls2 +
          '    GROUP BY SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) ' +
          ') r ' +
          'ON r.dept_kode = p.dept_kode';

  tsql := xOpenQuery(ssql, frmMenu.conn);
  with tsql do
  begin
    try
      while not eof do
      begin

           ds3.IndexFieldNames := 'departemen';
           if ds3.findkey([FieldByName('departemen').AsString]) then
           begin
             If ds3.State <> dsEdit then ds3.Edit;
              ds3.FieldByName('riilbulaninilalu').AsFloat := FieldByName('Riilbulaninilalu').AsFloat/1000;
            if ds3.FieldByName('riilbulaninilalu').AsFloat > 0 then
              ds3.FieldByName('growth').AsFloat :=ds3.FieldByName('riilbulanini').AsFloat/(FieldByName('Riilbulaninilalu').AsFloat/1000)*100;


           end;
        Next;
      end;
//        Sleep(1);  // 10ms cukup
//      Application.ProcessMessages; // biar UI tetap responsif
    finally
      Free;
    end;
  end;

  // RIIL sd BULAN INI  TAHUN LALU
  cAwal  := FormatDateTime('yyyy-mm-dd',
            EncodeDate(StrToInt(edttahun.Text)-1,
                      1,
                      1));

  cAkhir := FormatDateTime('yyyy-mm-dd',
            IncMonth(EncodeDate(StrToInt(edttahun.Text)-1,
                               cbbBulan.ItemIndex + 1,
                               1), 1) - 1);

  s:= 'set @tg1 ='+quot(cAwal)+';';
  s:= s +'set @tg2 ='+quot(cAkhir)+';';
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  ssql := 'SELECT ' +
          '    p.departemen, ' +
          '    p.riil - COALESCE(r.total_retur, 0) AS riilsdbulaninilalu ' +
          'FROM ( ' +
          '    SELECT ' +
          '        b.ktg_nama AS departemen, ' +
          '        b.ktg_kode AS dept_kode, ' +
          '        SUM( ' +
          '            IF(YEAR(p.tanggal) > 2021, p.dpp, p.total) ' +
          '            - p.biaya_promosi ' +
          '            - p.fee_marketing ' +
          '            - p.kontrak ' +
          '        ) AS riil ' +
          '    FROM penjualanN3bydepartemen p ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = p.salesman AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '     AND st_tahun = ' + edttahun.text + ') ' +
          '    INNER JOIN tkategori b ON b.ktg_kode = p.departemen ' +
          '    WHERE p.tanggal BETWEEN '+quot(cAwal)+' AND '+quot(cAkhir) + ' '
          + wheresls +
          '    GROUP BY b.ktg_nama, b.ktg_kode ' +
          ') p ' +
          'LEFT JOIN ( ' +
          '    SELECT ' +
          '        SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) AS dept_kode, ' +
          '        SUM( ' +
          '            (td.retjd_harga * td.retjd_qty) ' +
          '        ) AS total_retur ' +
          '    FROM tretj_hdr th ' +
          '    INNER JOIN tretj_dtl td ON td.retjd_retj_nomor = th.retj_nomor ' +
          '    INNER JOIN tbarang tb ON tb.brg_kode = td.retjd_brg_kode ' +
          '    INNER JOIN tfp_hdr ON th.retj_fp_nomor = fp_nomor ' +
          '    INNER JOIN tdo_hdr ON do_nomor = fp_do_nomor ' +
          '    INNER JOIN tso_hdr ON so_nomor = do_so_nomor ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = tso_hdr.so_sls_kode AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '    AND st_tahun = ' + edttahun.text + ') ' +
          '    WHERE tb.brg_ktg_kode LIKE ''4%'' ' +
          '      AND MONTH(th.retj_tanggal) <= ' + IntToStr(cbbBulan.itemindex +1) +
          '      AND YEAR(th.retj_tanggal) = ' + inttostr(strtoint(edtTahun.Text)-1) + ' '
          + wheresls2 +
          '    GROUP BY SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) ' +
          ') r ' +
          'ON r.dept_kode = p.dept_kode';

  totalRiilSdBulaniniLalu := 0;

  tsql := xOpenQuery(ssql,frmMenu.conn);
  with tsql do
  begin
    try
      while not eof do
      begin
           ds3.IndexFieldNames := 'departemen';
           if ds3.findkey([FieldByName('departemen').AsString]) then

           begin
             If ds3.State <> dsEdit then ds3.Edit;
              ds3.FieldByName('riilsdbulaninilalu').AsFloat := FieldByName('Riilsdbulaninilalu').AsFloat/1000;
              if ds3.FieldByName('riilsdbulaninilalu').AsFloat > 0 then
              ds3.FieldByName('growth2').AsFloat :=ds3.FieldByName('riilsdbulanini').AsFloat/(FieldByName('Riilsdbulaninilalu').AsFloat/1000)*100;
              ds3.Post;
           end;

           riilSdLaluValue := FieldByName('riilsdbulaninilalu').AsFloat/1000;
           riilSdBulaniniValue := ds3.FieldByName('riilsdbulanini').AsFloat;
           totalRiilSdBulaniniLalu := totalRiilSdBulaniniLalu + riilSdLaluValue;
        Next;
      end;

      if ds3.findkey(['TOTAL']) then
      begin
        If ds3.State <> dsEdit then ds3.Edit;
        ds3.FieldByName('riilsdbulaninilalu').AsFloat := totalRiilSdBulaniniLalu;

        totalRiilSdBulaniniValue := ds3.FieldByName('riilsdbulanini').AsFloat;
        if (totalRiilSdBulaniniLalu > 0) and (totalRiilSdBulaniniValue > 0) then
          ds3.FieldByName('growth2').AsFloat := (totalRiilSdBulaniniValue / totalRiilSdBulaniniLalu) * 100
        else
          ds3.FieldByName('growth2').AsFloat := 0;
      end;
  //        Sleep(1);  // 10ms cukup
  //      Application.ProcessMessages; // biar UI tetap responsif
    finally
      Free;
    end;
  end;

  // RIIL sd BULAN INI  TAHUN LALU KAT. OTHER
  cAwal  := FormatDateTime('yyyy-mm-dd',
            EncodeDate(StrToInt(edttahun.Text)-1,
                      1,
                      1));

  cAkhir := FormatDateTime('yyyy-mm-dd',
            IncMonth(EncodeDate(StrToInt(edttahun.Text)-1,
                               cbbBulan.ItemIndex + 1,
                               1), 1) - 1);

  s:= 'set @tg1 ='+quot(cAwal)+';';
  s:= s +'set @tg2 ='+quot(cAkhir)+';';
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  ssql := 'SELECT ' +
          '    "OTHER" departemen, ' +
          '    SUM(p.riil - COALESCE(r.total_retur, 0)) AS riilsdbulaninilalu ' +
          'FROM ( ' +
          '    SELECT ' +
          '        b.ktg_nama AS departemen, ' +
          '        b.ktg_kode AS dept_kode, ' +
          '        SUM( ' +
          '            IF(YEAR(p.tanggal) > 2021, p.dpp, p.total) ' +
          '            - p.biaya_promosi ' +
          '            - p.fee_marketing ' +
          '            - p.kontrak ' +
          '        ) AS riil ' +
          '    FROM penjualannonn3bydepartemen p ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = p.salesman AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '     AND st_tahun = ' + edttahun.text + ') ' +
          '    INNER JOIN tkategori b ON b.ktg_kode = p.departemen ' +
          '    WHERE p.tanggal BETWEEN '+quot(cAwal)+' AND '+quot(cAkhir) + ' '
          + wheresls +
          '    GROUP BY b.ktg_nama, b.ktg_kode ' +
          ') p ' +
          'LEFT JOIN ( ' +
          '    SELECT ' +
          '        SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) AS dept_kode, ' +
          '        SUM( ' +
          '            (td.retjd_harga * td.retjd_qty) ' +
          '        ) AS total_retur ' +
          '    FROM tretj_hdr th ' +
          '    INNER JOIN tretj_dtl td ON td.retjd_retj_nomor = th.retj_nomor ' +
          '    INNER JOIN tbarang tb ON tb.brg_kode = td.retjd_brg_kode ' +
          '    INNER JOIN tfp_hdr ON th.retj_fp_nomor = fp_nomor ' +
          '    INNER JOIN tdo_hdr ON do_nomor = fp_do_nomor ' +
          '    INNER JOIN tso_hdr ON so_nomor = do_so_nomor ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = tso_hdr.so_sls_kode AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '    AND st_tahun = ' + edttahun.text + ') ' +
          '    WHERE (tb.brg_ktg_kode NOT LIKE "4%" OR tb.brg_ktg_kode IS NULL )' +
          '      AND MONTH(th.retj_tanggal) <= ' + IntToStr(cbbBulan.itemindex +1) +
          '      AND YEAR(th.retj_tanggal) = ' + inttostr(strtoint(edtTahun.Text)-1) + ' '
          + wheresls2 +
          '    GROUP BY SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) ' +
          ') r ' +
          'ON r.dept_kode = p.dept_kode';

  tsql := xOpenQuery(ssql,frmMenu.conn);
  with tsql do
  begin
    try
      while not eof do
      begin
           ds3.IndexFieldNames := 'departemen';
           if ds3.findkey([FieldByName('departemen').AsString]) then

           begin
             If ds3.State <> dsEdit then ds3.Edit;
              ds3.FieldByName('riilsdbulaninilalu').AsFloat := FieldByName('Riilsdbulaninilalu').AsFloat/1000;
              if ds3.FieldByName('riilsdbulaninilalu').AsFloat > 0 then
              ds3.FieldByName('growth2').AsFloat :=ds3.FieldByName('riilsdbulanini').AsFloat/(FieldByName('Riilsdbulaninilalu').AsFloat/1000)*100;
              ds3.Post;
           end;
        Next;
      end;
  //        Sleep(1);  // 10ms cukup
  //      Application.ProcessMessages; // biar UI tetap responsif
    finally
      Free;
    end;
  end;

  //==== TAERGET TAHUNAN
  ssql := 'SELECT ktg_nama departemen, sum(dt_targetsales) targettahunan  ' +
          'FROM tdepartementarget  ' +
          'inner join tkategori on ktg_kode = dt_ktg_kode ' +
          'WHERE dt_tahun = ' + edttahun.text + ' ' +
          'group by ktg_nama';

  totalTargetTahunan := 0;

  tsql := xOpenQuery(ssql,frmMenu.conn);
  with tsql do
  begin
    try
      while not eof do
      begin
           ds3.IndexFieldNames := 'departemen';

           if ds3.findkey([FieldByName('departemen').AsString]) then
           begin
             If ds3.State <> dsEdit then ds3.Edit;
              ds3.FieldByName('targettahunan').AsFloat := FieldByName('targettahunan').AsFloat/1000;
              if FieldByName('targettahunan').AsFloat > 0 then
              ds3.FieldByName('ratio').AsFloat := ds3.FieldByName('riilsdbulanini').AsFloat/(FieldByName('targettahunan').AsFloat/1000)*100;
              ds3.post;

              targetTahunanValue := FieldByName('targettahunan').AsFloat/1000;
              riilSdBulaniniValue := ds3.FieldByName('riilsdbulanini').AsFloat;
              totalTargetTahunan := totalTargetTahunan + targetTahunanValue;
           end;
        Next;
      end;

      if ds3.findkey(['TOTAL']) then
      begin
        If ds3.State <> dsEdit then ds3.Edit;
        ds3.FieldByName('targettahunan').AsFloat := totalTargetTahunan;

        totalRiilSdBulaniniValue := ds3.FieldByName('riilsdbulanini').AsFloat;
        if (totalTargetTahunan > 0) and (totalRiilSdBulaniniValue > 0) then
          ds3.FieldByName('ratio').AsFloat := (totalRiilSdBulaniniValue / totalTargetTahunan) * 100
        else
          ds3.FieldByName('ratio').AsFloat := 0;
      end;
    finally
      Free;
    end;
  end;

  //==== TAERGET TAHUNAN KAT. OTHER
  cAwal := FormatDateTime(
    'yyyy-mm-dd',
    EncodeDate(StrToInt(edttahun.Text) - 1, 1, 1)
  );

  cAkhir := FormatDateTime(
    'yyyy-mm-dd',
    IncYear(EncodeDate(StrToInt(edttahun.Text) - 1, 1, 1), 1) - 1
  );

  s:= 'set @tg1 ='+quot(cAwal)+';';
  s:= s +'set @tg2 ='+quot(cAkhir)+';';
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  ssql := 'SELECT ' +
          '    "OTHER" departemen, ' +
          '    SUM(p.riil - COALESCE(r.total_retur, 0)) AS targettahunan ' +
          'FROM ( ' +
          '    SELECT ' +
          '        b.ktg_nama AS departemen, ' +
          '        b.ktg_kode AS dept_kode, ' +
          '        SUM( ' +
          '            IF(YEAR(p.tanggal) > 2021, p.dpp, p.total) ' +
          '            - p.biaya_promosi ' +
          '            - p.fee_marketing ' +
          '            - p.kontrak ' +
          '        ) AS riil ' +
          '    FROM penjualannonn3bydepartemen p ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = p.salesman AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '     AND st_tahun = ' + edttahun.text + ') ' +
          '    INNER JOIN tkategori b ON b.ktg_kode = p.departemen ' +
          '    WHERE p.tanggal BETWEEN '+quot(cAwal)+' AND '+quot(cAkhir) + ' '
          + wheresls +
          '    GROUP BY b.ktg_nama, b.ktg_kode ' +
          ') p ' +
          'LEFT JOIN ( ' +
          '    SELECT ' +
          '        SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) AS dept_kode, ' +
          '        SUM( ' +
          '            (td.retjd_harga * td.retjd_qty) ' +
          '        ) AS total_retur ' +
          '    FROM tretj_hdr th ' +
          '    INNER JOIN tretj_dtl td ON td.retjd_retj_nomor = th.retj_nomor ' +
          '    INNER JOIN tbarang tb ON tb.brg_kode = td.retjd_brg_kode ' +
          '    INNER JOIN tfp_hdr ON th.retj_fp_nomor = fp_nomor ' +
          '    INNER JOIN tdo_hdr ON do_nomor = fp_do_nomor ' +
          '    INNER JOIN tso_hdr ON so_nomor = do_so_nomor ' +
          '    INNER JOIN tsalesmantarget st ON (st.st_sls_Kode = tso_hdr.so_sls_kode AND st_periode = ' + IntToStr(cbbBulan.itemindex + 1) +
          '    AND st_tahun = ' + edttahun.text + ') ' +
          '    WHERE (tb.brg_ktg_kode NOT LIKE "4%" OR tb.brg_ktg_kode IS NULL ) ' +
          '    AND th.retj_tanggal BETWEEN '+quot(cAwal)+' AND '+quot(cAkhir) + ' '
          + wheresls2 +
          '    GROUP BY SUBSTRING_INDEX(tb.brg_ktg_kode, ''.'', 2) ' +
          ') r ' +
          'ON r.dept_kode = p.dept_kode';

  tsql := xOpenQuery(ssql,frmMenu.conn);
  with tsql do
  begin
    try
      while not eof do
      begin
           ds3.IndexFieldNames := 'departemen';
           if ds3.findkey([FieldByName('departemen').AsString]) then

           begin
             If ds3.State <> dsEdit then ds3.Edit;
              ds3.FieldByName('targettahunan').AsFloat := FieldByName('targettahunan').AsFloat/1000;
              if FieldByName('targettahunan').AsFloat > 0 then
              ds3.FieldByName('ratio').AsFloat := ds3.FieldByName('riilsdbulanini').AsFloat/(FieldByName('targettahunan').AsFloat/1000)*100;
              ds3.post;
           end;
        Next;
      end;
    finally
      Free;
    end;
  end;

  //==== PF
  ssql := 'SELECT '
      + ' ktg_nama AS departemen,'
      + ' SUM('
      + '     (100 - fpd_discpr)'
      + '     * (fpd_harga * fpd_qty) / 100'
      + '     * IF('
      + '         fp_istax = 1,'
      + '         IF(fp_tanggal < "2022-04-01", 1.1, 1.11),'
      + '         1'
      + '     )'
      + ' )'
      + ' - SUM('
      + '     fpd_cn'
      + '     * ((100 - fpd_discpr) * fpd_harga / 100)'
      + '     * fpd_qty / 100'
      + ' )'
      + ' - SUM('
      + '     fpd_bp_pr'
      + '     * ((100 - fpd_discpr) * fpd_harga / 100)'
      + '     * fpd_qty / 100'
      + ' )'
      + ' + SUM(fpd_bp_rp * fpd_qty)'
      + ' - ('
      + '     SELECT '
      + '         IFNULL('
      + '             SUM('
      + '                 (retjd_harga * retjd_qty)'
      + '                 * (100 - IFNULL(retjd_discpr, 0)) / 100'
      + '             ),'
      + '             0'
      + '         )'
      + '         * IF('
      + '             fp_istax = 1,'
      + '             IF(fp_tanggal < "2022-04-01", 1.1, 1.11),'
      + '             1'
      + '         )'
      + '     FROM tretj_dtl'
      + '     INNER JOIN tretj_hdr ON retjd_retj_nomor = retj_nomor'
      + '     INNER JOIN tfp_hdr ON retj_fp_nomor = fp_nomor'
      + '     INNER JOIN tbarang ON (retjd_brg_kode = brg_kode AND brg_ktg_kode LIKE ''4%'')'
      + '     WHERE SUBSTRING_INDEX(brg_ktg_kode, ''.'', 2) = ktg_kode'
      + '       AND MONTH(retj_tanggal) = ' + inttostr(cbbBulan.ItemIndex+1)
      + '       AND YEAR(retj_tanggal) = ' + edttahun.text
      + '       AND brg_isproductfocus = 1'
      + ' ) AS pf '
      + 'FROM tfp_dtl'
      + ' INNER JOIN tfp_hdr ON fp_nomor = fpd_fp_nomor'
      + ' INNER JOIN tbarang ON (brg_kode = fpd_brg_kode AND brg_ktg_kode LIKE ''4%'')'
      + ' AND MONTH(fp_tanggal) = ' + inttostr(cbbBulan.ItemIndex+1)
      + '   AND YEAR(fp_tanggal) = ' + edttahun.text
      + '   AND brg_isproductfocus = 1'
      + ' INNER JOIN tkategori ON ktg_kode = SUBSTRING_INDEX(brg_ktg_kode, ''.'', 2)'
      + ' GROUP BY ktg_kode';

  tsql := xOpenQuery(ssql,frmMenu.conn);

  with tsql do
  begin
    try
      while not eof do
      begin
           ds3.IndexFieldNames := 'departemen';

           if ds3.findkey([FieldByName('departemen').AsString]) then
           begin
             If ds3.State <> dsEdit then ds3.Edit;
              ds3.FieldByName('pf').AsFloat := FieldByName('pf').AsFloat/1000;
              if ds3.FieldByName('targetbulanini').AsFloat > 0 then
              ds3.FieldByName('pfratio').AsFloat := (FieldByName('pf').AsFloat/1000)/(ds3.FieldByName('targetbulanini').AsFloat)*100;
              ds3.post;
           end;
        Next;
      end;
    finally
       Sleep(1);
        Application.ProcessMessages; // biar UI tetap responsif
      Free;
    end;
  end;

//   piutang

// s:= 'create or replace temporary table kartupiutangnew as select * from kartu_piutang;';
//EnsureConnected(frmMenu.conn);
//ExecSQLDirect(frmMenu.conn, s);
//
//ssql := 'SELECT sls_nama salesman,SUM(debet-kredit) - '
//+ ' ('
//+ ' SELECT IFNULL(SUM(jt_nilai),0) FROM tjatuhtempofp'
//+ ' INNER JOIN tfp_hdr ON fp_nomor=jt_fp_nomor'
//+ ' INNER JOIN tdo_hdr ON do_nomor=fp_do_nomor'
//+ ' INNER JOIN tso_hdr ON so_nomor=do_so_nomor'
//+ ' WHERE fp_amount > fp_bayar'
//+ ' AND jt_tanggaljt > '+ QuotD(akhir2)
//+ ' AND so_sls_kode=a.salesman'
//+ ' and fp_jthtempo<='+ QuotD(akhir2)+')'
//+ ' target_piutang,'
//+ ' (SELECT SUM(kredit-debet) FROM kartu_piutang'
//+ ' WHERE nomor LIKE "%CR%" AND MONTH(tanggal) = '+inttostr(cbbBulan.ItemIndex+1)+' AND YEAR(tanggal)='+edttahun.Text
//+ ' AND ( jthtempo > '+ QuotD(akhir2)+' or noreferensi LIKE '+quot('%.'+FormatDateTime('yymm',akhir2)+'.%')+')'
//+ ' AND salesman=a.salesman) tunai,'
//+ ' (SELECT SUM(kredit-debet) FROM kartu_piutang'
//+ ' INNER JOIN tfp_hdr ON fp_nomor=noreferensi'
//+ ' WHERE (nomor LIKE "%CR%" or nomor LIKE "%RETJ%") AND MONTH(tanggal) = '+inttostr(cbbBulan.ItemIndex+1)+' AND YEAR(tanggal)='+edttahun.Text
//+ ' AND (jthtempo <= '+quotd(akhir2)+' AND fp_tanggal <= '+quotd(akhir)+')'
//+ ' AND salesman=a.salesman) realisasi,0 Persentase'
//+ ' FROM kartu_piutang a INNER JOIN tsalesman ON sls_kode=salesman AND sls_insentif=1'
//+ ' WHERE tanggal <= '+quotd(akhir)+' AND jthtempo < '+quotd(akhir2)
//+ ' GROUP BY sls_nama';
//
//
//        tsql :=xOpenQuery(ssql,frmMenu.conn);
//        with tsql do
//        begin
//          try
//            while not Eof do
//            begin
//             showmessage(FieldByName('salesman').AsString);
//             ds3.IndexFieldNames := 'salesman';
//             if ds3.findkey([FieldByName('salesman').AsString]) then
//
//             begin
//               If ds3.State <> dsEdit then ds3.Edit;
//                ds3.FieldByName('targetpiutang').AsFloat := FieldByName('target_piutang').AsFloat/1000;
//                ds3.FieldByName('realisasipiutang').AsFloat := FieldByName('realisasi').AsFloat/1000;
//                if ds3.FieldByName('targetpiutang').AsFloat > 0 then
//                ds3.FieldByName('ratiopiutang').AsFloat := ds3.FieldByName('realisasipiutang').AsFloat/ds3.FieldByName('targetpiutang').AsFloat *100
//                else
//                ds3.FieldByName('ratiopiutang').AsFloat := 0;
//
//                ds3.FieldByName('realisasiall').AsFloat := (FieldByName('realisasi').AsFloat+FieldByName('tunai').AsFloat)/1000;
//                if ds3.FieldByName('targetpiutang').AsFloat > 0 then
//                ds3.FieldByName('allratio').AsFloat := ds3.FieldByName('realisasiall').AsFloat/ds3.FieldByName('targetpiutang').AsFloat *100
//                else
//                ds3.FieldByName('allratio').AsFloat := 0;
//                ds3.Post;
//             end;
//
//             totaltarget := totaltarget +(FieldByName('target').AsFloat/1000);
//             Next;
//             end;
//           finally
//            free;
//          end;
//        end;
//
//        s:='SELECT sls_nama salesman,COUNT(*) newcustomer FROM (SELECT DISTINCT sls_nama,fp_cus_kode ,cus_nama FROM tfp_hdr'
//          + ' INNER JOIN tdo_hdr ON do_nomor=fp_do_nomor'
//          + ' INNER JOIN tso_hdr ON so_nomor=do_so_nomor '
//          + ' INNER JOIN tsalesman ON sls_kode=so_sls_kode'
//          + ' INNER JOIN tcustomer ON cus_kode=fp_cus_kode'
//          + ' WHERE MONTH(fp_tanggal)='+IntToStr(cbbBulan.itemindex +1)+' AND YEAR(fp_tanggal)='+edttahun.Text
//          + ' and fp_cus_kode NOT IN (SELECT DISTINCT (fp_cus_kode) FROM tfp_hdr '
//          + ' WHERE fp_tanggal <='+quotd(akhir)+')) final group by sls_nama';
//        tsql :=xOpenQuery(s,frmMenu.conn);
//        with tsql do
//        begin
//          try
//            while not Eof do
//            begin
//             ds3.IndexFieldNames := 'salesman';
//             if ds3.findkey([FieldByName('salesman').AsString]) then
//             begin
//               If ds3.State <> dsEdit then ds3.Edit;
//                ds3.FieldByName('newcustomer').AsFloat := Fields[1].AsFloat;
//                ds3.Post;
//             end;
//
//             totaltarget := totaltarget +(FieldByName('target').AsFloat/1000);
//             Next;
//             end;
//           finally
//            free;
//          end;
//        end;
//
//     s:='SELECT sls_nama salesman,COUNT(*) rsklinik FROM (SELECT DISTINCT sls_nama,fp_cus_kode ,cus_nama FROM tfp_hdr'
//          + ' INNER JOIN tdo_hdr ON do_nomor=fp_do_nomor'
//          + ' INNER JOIN tso_hdr ON so_nomor=do_so_nomor '
//          + ' INNER JOIN tsalesman ON sls_kode=so_sls_kode'
//          + ' INNER JOIN tcustomer ON cus_kode=fp_cus_kode'
//          + ' WHERE MONTH(fp_tanggal)='+IntToStr(cbbBulan.itemindex +1)+' AND YEAR(fp_tanggal)='+edttahun.Text
//          + ' and cus_gc_kode  IN ("RS","KL","PS")) final group by sls_nama';
//        tsql :=xOpenQuery(s,frmMenu.conn);
//        with tsql do
//        begin
//          try
//            while not Eof do
//            begin
//             ds3.IndexFieldNames := 'salesman';
//             if ds3.findkey([FieldByName('salesman').AsString]) then
//
//             begin
//               If ds3.State <> dsEdit then ds3.Edit;
//                ds3.FieldByName('rsklinik').AsFloat := Fields[1].AsFloat;
//                ds3.Post;
//             end;
//
//             totaltarget := totaltarget +(FieldByName('target').AsFloat/1000);
//             Next;
//             end;
//           finally
//            free;
//          end;
//        end;

end;

procedure TfrmLapBulanan5.btnTampilClick(Sender: TObject);
begin
  loaddata
end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1Column10CustomDrawCell(
    Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
      if StrToFloatDef(StringReplace(AViewInfo.Text, ',', '', [rfReplaceAll]),0) < 70 then
      ACanvas.Font.Color := clRed
    else if StrToFloatDef(StringReplace(AViewInfo.Text, ',', '', [rfReplaceAll]),0) < 100 then
        ACanvas.Font.Color := clpurple
    else
      ACanvas.Font.Color := clGreen;
       ACanvas.Font.Style := [fsbold];


end;

procedure
    TfrmLapBulanan5.cxGrid1DBBandedTableView1Column10CustomDrawFooterCell(
    Sender: TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 70 then
      ACanvas.font.Color := clRed
    else if StrToFloatDef(AViewInfo.Text,0) < 100 then
        ACanvas.font.Color := clpurple
    else
      ACanvas.font.Color := clgreen;
      ACanvas.Font.Style := [fsbold];
end;

procedure TfrmLapBulanan5.growthCustomDrawCell(
    Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
//  if StrToFloatDef(AViewInfo.Text,0) < 100 then
//  begin
//      ACanvas.Font.Color := clRed;
//
//  end
//    else
//      ACanvas.Font.Color := clGreen;
//        ACanvas.Font.Style := [fsbold];

  if StrToFloatDef(StringReplace(AViewInfo.Text, ',', '', [rfReplaceAll]),0) < 100 then
      ACanvas.Font.Color := clRed
    else
      ACanvas.Font.Color := clGreen;
       ACanvas.Font.Style := [fsbold];
end;

procedure
    TfrmLapBulanan5.growthCustomDrawFooterCell(
    Sender: TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 100 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];
end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1Column8CustomDrawCell(
    Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
//  ShowMessage(AViewInfo.Text);
    if StrToFloatDef(StringReplace(AViewInfo.Text, ',', '', [rfReplaceAll]),0) < 70 then
      ACanvas.Font.Color := clRed
    else if StrToFloatDef(StringReplace(AViewInfo.Text, ',', '', [rfReplaceAll]),0) < 100 then
        ACanvas.Font.Color := clpurple
    else
      ACanvas.Font.Color := clGreen;
       ACanvas.Font.Style := [fsbold];
end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1Column8CustomDrawFooterCell(
    Sender: TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin

  if StrToFloatDef(StringReplace(AViewInfo.Text, ',', '', [rfReplaceAll]),0) < 70 then
      ACanvas.Font.Color := clRed
    else if StrToFloatDef(StringReplace(AViewInfo.Text, ',', '', [rfReplaceAll]),0) < 100 then
        ACanvas.Font.Color := clpurple
    else
      ACanvas.Font.Color := clGreen;
       ACanvas.Font.Style := [fsbold];
end;

procedure
    TfrmLapBulanan5.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems12GetText(
    Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
    AText: string);
var
  capaibulanini, totalRiil, totalTarget: Double;
  I: Integer;
  departemen: String;
  riilValue, targetValue: Variant;
begin
  capaibulanini := 0;
  totalRiil := 0;
  totalTarget := 0;

  try
    // Hitung manual TANPA row TOTAL
    for I := 0 to cxGrid1DBBandedTableView1.DataController.RecordCount - 1 do
    begin
      // Cek nama departemen
      departemen:= VarToStr(
        cxGrid1DBBandedTableView1.DataController.Values[
          I,
          cxGrid1DBBandedTableView1Column1.Index  // Kolom departemen
        ]
      );

      // Skip TOTAL dan OTHER
      if (departemen <> 'TOTAL') then
      begin
        // Akumulasi riilbulanini
        riilValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column7.Index
          );
        totalRiil := totalRiil + cVarToFloat (riilValue, 0);

        // Akumulasi riilbulaninilalu
        targetValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column13.Index
          );
        totalTarget := totalTarget + cVarToFloat (targetValue, 0);
      end;
    end;

    // Hitung persentase
    if totalTarget > 0 then
      capaibulanini := (totalRiil / totalTarget) * 100;

    AText := FormatFloat('###.##', capaibulanini);

  except
    on E: Exception do
      AText := '0';
  end;

//  capaibulanini := 0;
//  try
//    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilbulaninilalu')) > 0  then
//            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilbulanini'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilbulaninilalu'))*100;
//    AText := FormatFloat('###.##',capaibulanini);
//
//
//  except
//  end;
end;

procedure
    TfrmLapBulanan5.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems14GetText(
    Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
    AText: string);
var
  capaibulanini, totalRiil, totalTarget: Double;
  I: Integer;
  departemen: String;
  riilValue, targetValue: Variant;
begin
  capaibulanini := 0;
  totalRiil := 0;
  totalTarget := 0;

  try
    // Hitung manual TANPA row TOTAL dan OTHER
    for I := 0 to cxGrid1DBBandedTableView1.DataController.RecordCount - 1 do
    begin
      // Cek nama departemen
      departemen:= VarToStr(
        cxGrid1DBBandedTableView1.DataController.Values[
          I,
          cxGrid1DBBandedTableView1Column1.Index  // Kolom departemen
        ]
      );

      // Skip TOTAL
      if (departemen <> 'TOTAL') then
      begin
        // Akumulasi riilsdbulanini
        riilValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column9.Index
          );
        totalRiil := totalRiil + cVarToFloat (riilValue, 0);

        // Akumulasi riilsdbulaninilalu
        targetValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column16.Index
          );
        totalTarget := totalTarget + cVarToFloat (targetValue, 0);
      end;
    end;

    // Hitung persentase
    if totalTarget > 0 then
      capaibulanini := (totalRiil / totalTarget) * 100;

    AText := FormatFloat('###.##', capaibulanini);

  except
    on E: Exception do
      AText := '0';
  end;

//  capaibulanini := 0;
//  try
//    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilsdbulaninilalu')) > 0  then
//            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilsdbulanini'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilsdbulaninilalu'))*100;
//    AText := FormatFloat('###.##',capaibulanini);
//  except
//  end;
end;

procedure TfrmLapBulanan5.TeSpeedButton1Click(Sender: TObject);
begin

     if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid1);
     end;

end;


function TfrmLapBulanan5.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems8GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
var
  capaibulanini, totalRiil, totalTarget: Double;
  I: Integer;
  departemen: String;
  riilValue, targetValue: Variant;
begin
  capaibulanini := 0;
  totalRiil := 0;
  totalTarget := 0;

  try
    // Hitung manual TANPA row TOTAL dan OTHER
    for I := 0 to cxGrid1DBBandedTableView1.DataController.RecordCount - 1 do
    begin
      // Cek nama departemen
      departemen:= VarToStr(
        cxGrid1DBBandedTableView1.DataController.Values[
          I,
          cxGrid1DBBandedTableView1Column1.Index  // Kolom departemen
        ]
      );

      // Skip TOTAL
      if (departemen <> 'TOTAL') then
      begin
        // Akumulasi riilsdbulanini
        riilValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column9.Index
          );
        totalRiil := totalRiil + cVarToFloat (riilValue, 0);

        // Akumulasi Targetsdbulanini
        targetValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column3.Index
          );
        totalTarget := totalTarget + cVarToFloat (targetValue, 0);
      end;
    end;

    // Hitung persentase
    if totalTarget > 0 then
      capaibulanini := (totalRiil / totalTarget) * 100;

    AText := FormatFloat('#,##0.00;(#,##0.00)', capaibulanini);

  except
    on E: Exception do
      AText := '0';
  end;
//  capaibulanini := 0;
//  try
//    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Targetsdbulanini')) > 0  then
//            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilsdbulanini'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Targetsdbulanini'))*100;
//    AText := FormatFloat('###.##',capaibulanini);
//  except
//  end;
end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems9GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
var
  capaibulanini, totalRiil, totalTarget: Double;
  I: Integer;
  departemen: String;
  riilValue, targetValue: Variant;
begin
  capaibulanini := 0;
  totalRiil := 0;
  totalTarget := 0;

  try
    // Hitung manual TANPA row TOTAL dan OTHER
    for I := 0 to cxGrid1DBBandedTableView1.DataController.RecordCount - 1 do
    begin
      // Cek nama departemen
      departemen:= VarToStr(
        cxGrid1DBBandedTableView1.DataController.Values[
          I, 
          cxGrid1DBBandedTableView1Column1.Index  // Kolom departemen
        ]
      );
      
      // Skip TOTAL dan OTHER
      if (departemen <> 'TOTAL') then
      begin
        // Akumulasi riilbulanini
        riilValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column7.Index
          );
        totalRiil := totalRiil + cVarToFloat (riilValue, 0);

        // Akumulasi targetbulanini
        targetValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column2.Index
          );
        totalTarget := totalTarget + cVarToFloat (targetValue, 0);
      end;
    end;

    // Hitung persentase
    if totalTarget > 0 then
      capaibulanini := (totalRiil / totalTarget) * 100;

    AText := FormatFloat('#,##0.00;(#,##0.00)', capaibulanini);

  except
    on E: Exception do
      AText := '0';
  end;
//  capaibulanini := 0;
//  try
//    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Targetbulanini')) > 0  then
//            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilbulanini'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Targetbulanini'))*100;
//    AText := FormatFloat('###.##',capaibulanini);
//  except
//  end;
end;

procedure TfrmLapBulanan5.growth2CustomDrawCell(Sender: TcxCustomGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone:
    Boolean);
begin
//
//  if StrToFloatDef(AViewInfo.Text,0) < 100 then
//  begin
//      ACanvas.Font.Color := clRed;
//
//  end
//    else
//      ACanvas.Font.Color := clGreen;
//        ACanvas.Font.Style := [fsbold];

  if StrToFloatDef(StringReplace(AViewInfo.Text, ',', '', [rfReplaceAll]),0) < 100 then
      ACanvas.Font.Color := clRed
    else
      ACanvas.Font.Color := clGreen;
       ACanvas.Font.Style := [fsbold];
end;

procedure TfrmLapBulanan5.growth2CustomDrawFooterCell(Sender: TcxGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo; var ADone:
    Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 100 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];
end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems16GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
 var
  capaibulanini, totalRiil, totalTarget: Double;
  I: Integer;
  departemen: String;
  riilValue, targetValue: Variant;
begin
  capaibulanini := 0;
  totalRiil := 0;
  totalTarget := 0;

  try
    // Hitung manual TANPA row TOTAL dan OTHER
    for I := 0 to cxGrid1DBBandedTableView1.DataController.RecordCount - 1 do
    begin
      // Cek nama departemen
      departemen:= VarToStr(
        cxGrid1DBBandedTableView1.DataController.Values[
          I,
          cxGrid1DBBandedTableView1Column1.Index  // Kolom departemen
        ]
      );

      // Skip TOTAL
      if (departemen <> 'TOTAL') then
      begin
        // Akumulasi riilsdbulanini
        riilValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column9.Index
          );
        totalRiil := totalRiil + cVarToFloat (riilValue, 0);

        // Akumulasi Targettahunan
        targetValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column14.Index
          );
        totalTarget := totalTarget + cVarToFloat (targetValue, 0);
      end;
    end;

    // Hitung persentase
    if totalTarget > 0 then
      capaibulanini := (totalRiil / totalTarget) * 100;

    AText := FormatFloat('###.##', capaibulanini);

  except
    on E: Exception do
      AText := '0';
  end;

//  capaibulanini := 0;
//  try
//    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Targettahunan')) > 0  then
//        capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilsdbulanini'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('targettahunan'))*100;
//    AText := FormatFloat('###.##',capaibulanini);
//  except
//  end;
end;


procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1Column19CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  if StrToFloatDef(AViewInfo.Text,0) < 70 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];

end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1Column19CustomDrawFooterCell(
  Sender: TcxGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin

  if StrToFloatDef(AViewInfo.Text,0) < 70 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];

end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1Column21CustomDrawCell(
    Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 30 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];


end;

procedure
    TfrmLapBulanan5.cxGrid1DBBandedTableView1Column21CustomDrawFooterCell(
    Sender: TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 30 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];


end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems19GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('realisasipiutang')) > 0  then
            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('realisasipiutang'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('targetpiutang'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

procedure
    TfrmLapBulanan5.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems21GetText(
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

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems23GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('realisasiall')) > 0  then
            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('realisasiall'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('targetpiutang'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems1GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
var
  capaibulanini, totalRiil, totalTarget: Double;
  I: Integer;
  departemen: String;
  riilValue, targetValue: Variant;
begin
  capaibulanini := 0;
  totalRiil := 0;
  totalTarget := 0;

  try
    for I := 0 to cxGrid1DBBandedTableView1.DataController.RecordCount - 1 do
    begin
      departemen:= VarToStr(
        cxGrid1DBBandedTableView1.DataController.Values[
          I, 
          cxGrid1DBBandedTableView1Column1.Index
        ]
      );

      // Skip TOTAL
      if (departemen <> 'TOTAL') then
      begin
        // Akumulasi targetbulanini
        riilValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column2.Index
          );
        totalRiil := totalRiil + cVarToFloat (riilValue, 0);
      end;
    end;

    // Hitung persentase
//    if totalRiil > 0 then
//      capaibulanini := (totalRiil / totalTarget) * 100;

    AText := FormatFloat('#,##0;(#,##0)', totalRiil);

  except
    on E: Exception do
      AText := '0';
  end;
end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  IsTotalRow: Boolean;
  Nilai: Double;
  departemen: String;
begin
  IsTotalRow := False;
  if (AViewInfo.GridRecord <> nil) then
  begin
    departemen := VarToStr(
      AViewInfo.GridRecord.Values[cxGrid1DBBandedTableView1Column1.Index]
    );
    IsTotalRow := (departemen = 'TOTAL');
  end;

  if IsTotalRow then
  begin
    ACanvas.Brush.Color := clMoneyGreen;
//    ACanvas.FillRect(AViewInfo.Bounds);
//    ACanvas.Font.Color := clBlack;
    ACanvas.Font.Style := [fsBold];
  end;

  ADone := False;
end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
var
  capaibulanini, totalRiil, totalTarget: Double;
  I: Integer;
  departemen: String;
  riilValue, targetValue: Variant;
begin
  capaibulanini := 0;
  totalRiil := 0;
  totalTarget := 0;

  try
    for I := 0 to cxGrid1DBBandedTableView1.DataController.RecordCount - 1 do
    begin
      departemen:= VarToStr(
        cxGrid1DBBandedTableView1.DataController.Values[
          I, 
          cxGrid1DBBandedTableView1Column1.Index
        ]
      );

      // Skip TOTAL
      if (departemen <> 'TOTAL') then
      begin
        // Akumulasi Targetsdbulanini
        riilValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column3.Index
          );
        totalRiil := totalRiil + cVarToFloat (riilValue, 0);
      end;
    end;

    // Hitung persentase
//    if totalRiil > 0 then
//      capaibulanini := (totalRiil / totalTarget) * 100;

    AText := FormatFloat('#,##0;(#,##0)', totalRiil);

  except
    on E: Exception do
      AText := '0';
  end;
end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems6GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
var
  capaibulanini, totalRiil, totalTarget: Double;
  I: Integer;
  departemen: String;
  riilValue, targetValue: Variant;
begin
  capaibulanini := 0;
  totalRiil := 0;
  totalTarget := 0;

  try
    for I := 0 to cxGrid1DBBandedTableView1.DataController.RecordCount - 1 do
    begin
      departemen:= VarToStr(
        cxGrid1DBBandedTableView1.DataController.Values[
          I, 
          cxGrid1DBBandedTableView1Column1.Index
        ]
      );

      // Skip TOTAL
      if (departemen <> 'TOTAL') then
      begin
        // Akumulasi riilbulanini
        riilValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column7.Index
          );
        totalRiil := totalRiil + cVarToFloat (riilValue, 0);
      end;
    end;

    // Hitung persentase
//    if totalRiil > 0 then
//      capaibulanini := (totalRiil / totalTarget) * 100;

    AText := FormatFloat('#,##0;(#,##0)', totalRiil);

  except
    on E: Exception do
      AText := '0';
  end;
end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems7GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
var
  capaibulanini, totalRiil, totalTarget: Double;
  I: Integer;
  departemen: String;
  riilValue, targetValue: Variant;
begin
  capaibulanini := 0;
  totalRiil := 0;
  totalTarget := 0;

  try
    for I := 0 to cxGrid1DBBandedTableView1.DataController.RecordCount - 1 do
    begin
      departemen:= VarToStr(
        cxGrid1DBBandedTableView1.DataController.Values[
          I,
          cxGrid1DBBandedTableView1Column1.Index
        ]
      );

      // Skip TOTAL
      if (departemen <> 'TOTAL') then
      begin
        // Akumulasi riilsdbulanini
        riilValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column9.Index
          );
        totalRiil := totalRiil + cVarToFloat (riilValue, 0);
      end;
    end;

    // Hitung persentase
//    if totalRiil > 0 then
//      capaibulanini := (totalRiil / totalTarget) * 100;

    AText := FormatFloat('#,##0;(#,##0)', totalRiil);

  except
    on E: Exception do
      AText := '0';
  end;
end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems11GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
var
  capaibulanini, totalRiil, totalTarget: Double;
  I: Integer;
  departemen: String;
  riilValue, targetValue: Variant;
begin
  capaibulanini := 0;
  totalRiil := 0;
  totalTarget := 0;

  try
    for I := 0 to cxGrid1DBBandedTableView1.DataController.RecordCount - 1 do
    begin
      departemen:= VarToStr(
        cxGrid1DBBandedTableView1.DataController.Values[
          I,
          cxGrid1DBBandedTableView1Column1.Index
        ]
      );

      // Skip TOTAL
      if (departemen <> 'TOTAL') then
      begin
        // Akumulasi riilbulaninilalu
        riilValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column13.Index
          );
        totalRiil := totalRiil + cVarToFloat (riilValue, 0);
      end;
    end;

    // Hitung persentase
//    if totalRiil > 0 then
//      capaibulanini := (totalRiil / totalTarget) * 100;

    AText := FormatFloat('#,##0;(#,##0)', totalRiil);

  except
    on E: Exception do
      AText := '0';
  end;
end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems13GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
var
  capaibulanini, totalRiil, totalTarget: Double;
  I: Integer;
  departemen: String;
  riilValue, targetValue: Variant;
begin
  capaibulanini := 0;
  totalRiil := 0;
  totalTarget := 0;

  try
    for I := 0 to cxGrid1DBBandedTableView1.DataController.RecordCount - 1 do
    begin
      departemen:= VarToStr(
        cxGrid1DBBandedTableView1.DataController.Values[
          I,
          cxGrid1DBBandedTableView1Column1.Index
        ]
      );

      // Skip TOTAL
      if (departemen <> 'TOTAL') then
      begin
        // Akumulasi riilsdbulaniniLalu
        riilValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column16.Index
          );
        totalRiil := totalRiil + cVarToFloat (riilValue, 0);
      end;
    end;

    // Hitung persentase
//    if totalRiil > 0 then
//      capaibulanini := (totalRiil / totalTarget) * 100;

    AText := FormatFloat('#,##0;(#,##0)', totalRiil);

  except
    on E: Exception do
      AText := '0';
  end;
end;

procedure TfrmLapBulanan5.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems15GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
var
  capaibulanini, totalRiil, totalTarget: Double;
  I: Integer;
  departemen: String;
  riilValue, targetValue: Variant;
begin
  capaibulanini := 0;
  totalRiil := 0;
  totalTarget := 0;

  try
    for I := 0 to cxGrid1DBBandedTableView1.DataController.RecordCount - 1 do
    begin
      departemen:= VarToStr(
        cxGrid1DBBandedTableView1.DataController.Values[
          I,
          cxGrid1DBBandedTableView1Column1.Index
        ]
      );

      // Skip TOTAL
      if (departemen <> 'TOTAL') then
      begin
        // Akumulasi targettahunan
        riilValue :=
          cxGrid1DBBandedTableView1.DataController.GetValue(
            I,
            cxGrid1DBBandedTableView1Column14.Index
          );
        totalRiil := totalRiil + cVarToFloat (riilValue, 0);
      end;
    end;

    // Hitung persentase
//    if totalRiil > 0 then
//      capaibulanini := (totalRiil / totalTarget) * 100;

    AText := FormatFloat('#,##0;(#,##0)', totalRiil);

  except
    on E: Exception do
      AText := '0';
  end;
end;

end.
