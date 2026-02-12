unit ufrmLapYTD;

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
  cxCurrencyEdit, cxGridDBBandedTableView, cxTextEdit, dxPScxGrid6Lnk,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue;

type
  TfrmLapYTD = class(TForm)
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
    sqlqry1: TSQLQuery;
    ds2: TDataSource;
    ds3: TClientDataSet;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxstyl1: TcxStyle;
    cxVCLPrinter: TdxComponentPrinter;
    cxVCLPrinterChart: TdxGridReportLink;
    btnRefresh: TcxButton;
    TePanel5: TTePanel;
    cxButton8: TcxButton;
    cxButton7: TcxButton;
    cxGrid1: TcxGrid;
    cxGrid1DBBandedTableView1: TcxGridDBBandedTableView;
    cxGrid1DBBandedTableView1Column1: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column2: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column3: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column4: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column5: TcxGridDBBandedColumn;
    cxGrid1Level1: TcxGridLevel;
    Label2: TLabel;
    edtTahun: TComboBox;
    Label1: TLabel;
    cbbBulan: TAdvComboBox;
    cxGrid1DBBandedTableView1Column6: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column7: TcxGridDBBandedColumn;
    procedure FormDblClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure sbPrintClick(Sender: TObject);
    procedure btnTampilClick(Sender: TObject);
    procedure
        cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems2GetText(
        Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
        AText: string);
    procedure
        cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems4GetText(
        Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
        AText: string);
    procedure TeSpeedButton1Click(Sender: TObject);

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

  frmLapYTD: TfrmLapYTD;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink;
{$R *.dfm}



procedure TfrmLapYTD.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmLapYTD.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmLapYTD.refreshdata;
begin
  edttahun.text :=  FormatDateTime('yyyy',Date);
end;

procedure TfrmLapYTD.sbNewClick(Sender: TObject);
begin
   refreshdata;

end;




procedure TfrmLapYTD.FormShow(Sender: TObject);
begin
  flagedit := False;
  refreshdata;
end;
procedure TfrmLapYTD.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmLapYTD.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmLapYTD.loaddata;
var
  ssql:string;
  capaibulanini : double;
begin
ssql:= ' SELECT tm_tahun TAHUN,upper(monthname(str_to_date(tm_periode,''%m''))) BULAN,tm_target TARGET, nilai REALISASI, '
      +' if(tm_target>0 and ifnull(nilai,0)>0,ifnull(nilai,0)/tm_Target,null)*100 "%ACH", '
      +' (SELECT SUM(ifnull(spk_jumlah,0)*ifnull(spk_harga,0)) FROM tspk WHERE YEAR(spk_tanggal)='+inttostr(strtoint(cbTahun.Items[cbTahun.itemindex])-1)+' AND MONTH(spk_tanggal)=tm_periode) LAST_YEAR, '
      + ' ((nilai/(SELECT SUM(ifnull(spk_jumlah,0)*ifnull(spk_harga,0)) FROM tspk WHERE YEAR(spk_tanggal)='+inttostr(strtoint(cbTahun.Items[cbTahun.itemindex])-1)+' AND MONTH(spk_tanggal)=tm_periode))-1)*100 "%GROWTH" '
      +' FROM ttargetmarketing left JOIN '
      +' (SELECT * FROM ( '
      +' SELECT YEAR(spk_tanggal) Tahun,month(spk_tanggal) Bulan,SUM(ifnull(spk_jumlah,0)*ifnull(spk_harga,0)) Nilai '
      +' FROM tspk where YEAR(spk_tanggal)= '+cbTahun.Items[cbTahun.itemindex]
      +' GROUP BY month(spk_tanggal) ) final) a '
      +' ON bulan =tm_periode AND tahun=tm_tahun '
      +' where tm_tahun='+cbTahun.Items[cbTahun.itemindex]';

        ds3.Close;
        sqlqry1.SQLConnection := frmMenu.conn;
        sqlqry1.SQL.Text := ssql;
        ds3.open;

end;

procedure TfrmLapYTD.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure
    TfrmLapYTD.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems2GetText(
    Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
    AText: string);
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

procedure
    TfrmLapYTD.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems4GetText(
    Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
    AText: string);
var
    growth :double;
begin
  growth := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('lastyear')) > 0  then
            growth :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('realisasi'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('lastyear'))*100;
    AText := FormatFloat('###.##',growth);
  except
  end;
end;


procedure TfrmLapYTD.TeSpeedButton1Click(Sender: TObject);
begin

     if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid1);
     end;

end;


function TfrmLapYTD.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

end.
