unit ufrmListJualMarketing;

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
  dxPSEdgePatterns,  cxDrawTextUtils,
  dxPSPrVwStd, dxPSPrVwAdv, dxPScxPageControlProducer,
  dxPScxEditorProducers, dxPScxExtEditorProducers, dxPScxCommon, dxPSCore,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxBarPainter, dxPScxGrid6Lnk,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue,
  AdvCombo, MemDS, DBAccess, MyAccess;


type
  TfrmListJualMarketing = class(TForm)
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
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    cxChart: TcxGrid;
    cxGrdChart: TcxGridChartView;
    lvlChart: TcxGridLevel;
    cxPivot: TcxDBPivotGrid;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrdDetail: TcxGridDBTableView;
    cxGrid11Level1: TcxGridLevel;
    cxVCLPrinter: TdxComponentPrinter;
    cxVCLPrinterChart: TdxGridReportLink;
    btnRefresh: TcxButton;
    Label1: TLabel;
    startdate: TDateTimePicker;
    Label2: TLabel;
    enddate: TDateTimePicker;
    TePanel5: TTePanel;
    cxButton8: TcxButton;
    cxButton7: TcxButton;
    cxButton3: TcxButton;
    cxButton1: TcxButton;
    cbbBulan: TAdvComboBox;
    Label3: TLabel;
    edtTahun: TComboBox;
    Label4: TLabel;
    edtFilter: TEdit;
    sqlqry1: TMyQuery;
    procedure FormDblClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure sbPrintClick(Sender: TObject);
    procedure btnTampilClick(Sender: TObject);
    procedure cxPageControl1Click(Sender: TObject);
    procedure TeSpeedButton1Click(Sender: TObject);
    procedure dttanggalChange(Sender: TObject);
    procedure TeSpeedButton2Click(Sender: TObject);
    procedure SetPivotColumns(ColumnSets: Array Of String);
    procedure SetPivotData(ColumnSets: Array Of String);
    procedure SetPivotRow(ColumnSets: Array Of String);
    procedure cxButton1Click(Sender: TObject);

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

  frmListJualMarketing: TfrmListJualMarketing;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink,uReport;
{$R *.dfm}



procedure TfrmListJualMarketing.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmListJualMarketing.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmListJualMarketing.refreshdata;
begin
startdate.DateTime := date;
enddate.DateTime := date;
startdate.SetFocus;
//  edttahun.text :=  FormatDateTime('yyyy',Date);
//  edtTahun.setfocus;

end;

procedure TfrmListJualMarketing.sbNewClick(Sender: TObject);
begin
   refreshdata;
   startdate.SetFocus;
//   sbdelete.Enabled := False;
end;




procedure TfrmListJualMarketing.FormShow(Sender: TObject);
begin
  flagedit := False;
  refreshdata;
end;





procedure TfrmListJualMarketing.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmListJualMarketing.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmListJualMarketing.loaddata;
var
  skolom,s,smargin: string ;
  afilter : string ;
  i,jmlkolom:integer;
begin
  afilter :='';
  if edtFilter.Text <> '' then
    afilter :=  ' and brg_nama like '+Quot('%'+edtFilter.Text+ '%');
//      s:='SELECT sls_nama Marketing,brg_kode Kode,brg_nama Nama,cus_nama Customer,cus_kode Kode_Cust,'
//+ ' (select bpf_dept from tbarangpf where bpf_brg_kode=brg_kode) Grup,Nilai,gc_nama Golongan,'
//+ ' Bulan,Tahun,NilaiByHNA '
//+ ' FROM tsalescustomer'
//+ ' INNER JOIN tcustomer ON cus_kode=sc_cus_kode'
//+ ' INNER JOIN tsalesman ON sls_kode=sc_sls_kode'
//+ ' inner JOIN'
//+ ' (SELECT brg_kode,brg_nama,fp_cus_kode,MONTH(fp_tanggal) Bulan,Year(fp_tanggal) Tahun,'
//+ ' sum((100-fpd_discpr)*(fpd_harga*fpd_qty)/100) -'
//+ ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*fpd_qty/100) -'
//+ ' sum(fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)*fpd_qty/100)+sum(fpd_bp_rp*fpd_qty) Nilai'
//+ ' FROM tbarangpf'
//+ ' INNER JOIN tbarang ON brg_kode=bpf_brg_kode AND bpf_periode='+FormatDateTime('mm',startdate.DateTime)
//+ ' and bpf_tahun = ' + FormatDateTime('yyyy',startdate.DateTime)
//+ ' INNER  JOIN tfp_dtl ON fpd_brg_kode=bpf_brg_kode'
//+ ' inner JOIN tfp_hdr ON fp_nomor=fpd_fp_nomor'
//+ ' WHERE fp_tanggal between  '+quotd(startdate.DateTime)+'  AND  ' + QuotD(enddate.DateTime)
//+ afilter
//+ ' GROUP by brg_kode,brg_nama,fp_cus_kode , MONTH(fp_tanggal),Year(fp_tanggal)) a'
//+ ' ON a.fp_cus_kode=cus_Kode'
//+ ' Left JOIN tgolongancustomer ON gc_kode=cus_gc_kode ';

s:= 'SELECT Marketing,Kode,Nama,Customer,Grup,GroupPF,Golongan,Bulan,Tahun,HET,HNA,hrg_min,QTY-IFNULL(RETUR,0) QTY,'
+ ' (HNA*(QTY-IFNULL(RETUR,0))) nilaiByhna,(NET*(QTY-IFNULL(RETUR,0))) NilaiNet,'
+ ' IF(NET>=HRG_MIN,NET*(QTY-IFNULL(RETUR,0)),0) NILAIDIATASHET FROM ('
+ ' SELECT sls_nama Marketing ,brg_kode Kode,brg_nama Nama,cus_nama Customer,gc_nama Golongan,MONTH(fp_tanggal) Bulan,Year(fp_tanggal) Tahun,'
+ ' bpf_grup GroupPF,bpf_dept Grup,fpd_qty Qty,bpf_het HET,fpd_hrg_min hrg_min,bpf_hna HNA,'
+ ' (SELECT ifnull(sum(retjd_qty),0) FROM tretj_dtl'
+ ' INNER JOIN tretj_hdr ON retjd_retj_nomor=retj_nomor '
+ ' INNER JOIN tbarangpf ON bpf_brg_kode=retjd_brg_kode and bpf_periode = '+ formatdatetime('mm',startdate.DateTime) + ' and bpf_tahun='+formatdatetime('yyyy',startdate.DateTime)
+ ' where retj_tanggal between  '+quotd(startdate.DateTime)+'  AND  ' + QuotD(enddate.DateTime)
+ ' AND retjd_brg_kode=brg_kode and retj_fp_nomor=fp_nomor'
+ ' ) retur, '
+ ' (((100-fpd_discpr)*fpd_harga/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)- ((fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)/100)+fpd_bp_rp)) Net'
+ ' FROM tfp_dtl'
+ ' INNER JOIN tbarangpf ON bpf_brg_kode=fpd_brg_kode and bpf_periode = '+ formatdatetime('mm',startdate.DateTime) + ' and bpf_tahun='+formatdatetime('yyyy',startdate.DateTime)
+ ' INNER JOIN tfp_hdr ON fp_nomor=fpd_fp_nomor '
+ ' INNER JOIN tsalescustomer ON sc_cus_kode=fp_cus_kode'
+ ' INNER JOIN tbarang ON brg_kode=bpf_brg_kode and bpf_periode = '+ formatdatetime('mm',startdate.DateTime) + ' and bpf_tahun='+formatdatetime('yyyy',startdate.DateTime)
+ ' INNER JOIN tcustomer ON cus_kode=sc_cus_kode'
+ ' INNER JOIN tsalesman ON sls_kode=sc_sls_kode'
+ ' LEFT JOIN tgolongancustomer ON gc_kode=cus_gc_kode'
+ ' where fp_tanggal between  '+quotd(startdate.DateTime)+'  AND  ' + QuotD(enddate.DateTime)
+  afilter
+ ' ) FINAL ';

        ds3.Close;
        sqlqry1.Connection := frmmenu.conn;
        sqlqry1.SQL.Text := s;
        ds3.open;

//
        Skolom :='Marketing,Kode,Nama,Customer,Grup,GroupPF,Golongan,Bulan,Tahun,QTY,HET,HNA,hrg_min,nilaiByhna,NilaiNet,NILAIDIATASHET';
        QueryToDBGrid(cxGrid1DBTableView1, s,skolom ,ds2);
        cxGrid1DBTableView1.Columns[14].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[14].Summary.FooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[15].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[15].Summary.FooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[13].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[13].Summary.FooterFormat:='###,###,###,###';




           cxGrid1DBTableView1.Columns[0].MinWidth := 60;
           cxGrid1DBTableView1.Columns[1].MinWidth := 60;
           cxGrid1DBTableView1.Columns[2].MinWidth := 100;
           cxGrid1DBTableView1.Columns[3].MinWidth := 100;
           cxGrid1DBTableView1.Columns[4].MinWidth := 100;
           cxGrid1DBTableView1.Columns[5].MinWidth := 100;
           cxGrid1DBTableView1.Columns[6].MinWidth := 100;
           jmlkolom :=cxGrid1DBTableView1.ColumnCount-1;

        for i:=0 To jmlkolom do
        begin
          if ds3.Fields[i].DataType = ftFloat then
          begin
             ds3.Fields[i].Alignment := taRightJustify;
             TFloatField(ds3.Fields[i]).DisplayFormat := '###,###,###';
          end;

        end;



        //  hitung;

          TcxDBPivotHelper(cxPivot).LoadFromCDS(ds3);
           SetPivotColumns(['Grup']);
           SetPivotRow (['Marketing']);
           SetPivotData(['nilaiByhna']);

end;

procedure TfrmListJualMarketing.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmListJualMarketing.cxPageControl1Click(Sender: TObject);
begin
IF PageControl1.Pages[2].Visible  then
begin
  PivotChartLink.GridChartView := cxGrdChart;
  PivotChartLink.PivotGrid := cxPivot;
end;
end;

procedure TfrmListJualMarketing.TeSpeedButton1Click(Sender: TObject);
begin

  IF PageControl1.Pages[1].Visible  then
     TcxDBPivotHelper(cxPivot).ExportToXLS
  else
  begin
     if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid1);
     end;
 end;


end;


procedure TfrmListJualMarketing.dttanggalChange(Sender: TObject);
begin
  enddate.DateTime := startdate.DateTime;
end;

function TfrmListJualMarketing.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmListJualMarketing.TeSpeedButton2Click(Sender: TObject);
begin
//  IF PageControl1.Pages[1].Visible  then
//     cxVCLPrinterPivot.Preview
//  else
//  if PageControl1.Pages[2].Visible  then
//    cxVCLPrinterChart.Preview;
end;

procedure TfrmListJualMarketing.SetPivotRow(ColumnSets: Array Of String);
begin
  TcxDBPivotHelper(cxPivot).SetRowColumns(ColumnSets);
end;

procedure TfrmListJualMarketing.SetPivotColumns(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetColColumns(ColumnSets);
end;

procedure TfrmListJualMarketing.SetPivotData(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetDataColumns(ColumnSets);
end;


procedure TfrmListJualMarketing.cxButton1Click(Sender: TObject);
begin
  With cxPivot.GetFieldByName('Grup') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Nilai')
    else
      SortBySummaryInfo.Field := nil;
  end;
    With cxPivot.GetFieldByName('Marketing') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Nilai')
    else
      SortBySummaryInfo.Field := nil;
  end;
    With cxPivot.GetFieldByName('Customer') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Nilai')
    else
      SortBySummaryInfo.Field := nil;
  end;
     With cxPivot.GetFieldByName('Grup') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Nilai')
    else
      SortBySummaryInfo.Field := nil;
  end;
  With cxPivot.GetFieldByName('Nama') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Nilai')
    else
      SortBySummaryInfo.Field := nil;
  end;
end;

end.
