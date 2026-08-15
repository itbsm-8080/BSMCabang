unit ufrmLapDORealisasi;

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, SqlExpr,  cxGraphics,
  cxControls, dxStatusBar, Menus, cxLookAndFeelPainters,
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
  te_controls, AdvEdBtn, AdvEdit, DBAccess, MyAccess, MemDS;


type
  TfrmLapDORealisasi = class(TForm)
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
    cxButton1: TcxButton;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    sqlqry1: TMyQuery;
    cxButton5: TcxButton;
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
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);

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

  frmLapDORealisasi: TfrmLapDORealisasi;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink,uReport,uFrmPreviewImage,
  uFrmbantuan;
{$R *.dfm}



procedure TfrmLapDORealisasi.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmLapDORealisasi.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmLapDORealisasi.refreshdata;
begin
  startdate.DateTime := Date;
  startdate.setfocus;

end;

procedure TfrmLapDORealisasi.sbNewClick(Sender: TObject);
begin
   refreshdata;
   startdate.SetFocus;
//   sbdelete.Enabled := False;
end;




procedure TfrmLapDORealisasi.FormShow(Sender: TObject);
begin
  flagedit := False;
  startdate.DateTime := Date;
  enddate.DateTime := Date;
  refreshdata;
end;





procedure TfrmLapDORealisasi.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmLapDORealisasi.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmLapDORealisasi.loaddata;
var
  skolom,s,smargin,smargin2: string ;
  afilter : string ;
  i,jmlkolom:integer;
begin

s := 'SELECT do_nomor Nomor, do_tanggal Tanggal, MONTH(do_tanggal) Bulan, YEAR(do_tanggal) Tahun, Cus_nama Customer, CASE '
     + '         WHEN pod_foto IS NOT NULL AND pod_foto <> "" THEN "Terkirim" '
     + '         ELSE "Belum Terkirim" '
     + '     END AS Status, '
     + '     pod_tanggal POD_Tanggal, pod_foto Foto, 1 AS Tampung '
     + ' FROM tdo_hdr '
     + ' LEFT JOIN tpod_hdr ON do_nomor = pod_do_nomor '
     + ' INNER JOIN tcustomer ON Cus_kode = do_cus_Kode '
     + ' WHERE do_tanggal BETWEEN ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime);

    ds3.Close;
    sqlqry1.Connection := frmmenu.conn;
    sqlqry1.SQL.Text := s;
    ds3.open;


    Skolom := 'Nomor,Tanggal, Bulan, Tahun, Customer,Status,POD_Tanggal, Foto, Tampung';
    QueryToDBGrid(cxGrid1DBTableView1, s,skolom ,ds2);

   cxGrid1DBTableView1.Columns[0].MinWidth := 60;
   cxGrid1DBTableView1.Columns[1].MinWidth := 60;
   cxGrid1DBTableView1.Columns[2].MinWidth := 100;
   cxGrid1DBTableView1.Columns[3].MinWidth := 100;
   cxGrid1DBTableView1.Columns[4].MinWidth := 200;
   cxGrid1DBTableView1.Columns[5].MinWidth := 130;
   cxGrid1DBTableView1.Columns[6].MinWidth := 100;
   cxGrid1DBTableView1.Columns[7].MinWidth := 100;

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
           SetPivotColumns(['Bulan']);
           SetPivotRow (['Status']);
           SetPivotData(['Tampung']);

end;

procedure TfrmLapDORealisasi.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmLapDORealisasi.cxPageControl1Click(Sender: TObject);
begin
IF PageControl1.Pages[2].Visible  then
begin
  PivotChartLink.GridChartView := cxGrdChart;
  PivotChartLink.PivotGrid := cxPivot;
end;
end;

procedure TfrmLapDORealisasi.TeSpeedButton1Click(Sender: TObject);
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


procedure TfrmLapDORealisasi.dttanggalChange(Sender: TObject);
begin
  enddate.DateTime := startdate.DateTime;
end;

function TfrmLapDORealisasi.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmLapDORealisasi.TeSpeedButton2Click(Sender: TObject);
begin
//  IF PageControl1.Pages[1].Visible  then
//     cxVCLPrinterPivot.Preview
//  else
//  if PageControl1.Pages[2].Visible  then
//    cxVCLPrinterChart.Preview;
end;

procedure TfrmLapDORealisasi.SetPivotRow(ColumnSets: Array Of String);
begin
  TcxDBPivotHelper(cxPivot).SetRowColumns(ColumnSets);
end;

procedure TfrmLapDORealisasi.SetPivotColumns(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetColColumns(ColumnSets);
end;

procedure TfrmLapDORealisasi.SetPivotData(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetDataColumns(ColumnSets);
end;


procedure TfrmLapDORealisasi.cxButton3Click(Sender: TObject);
var
  s:string;
  ftsreport : TTSReport;
begin
//if CheckBox1.Checked then
//begin
//  ftsreport := TTSReport.Create(nil);
//  try
//    ftsreport.Nama := 'kontrak';
//
//          s:= ' SELECT fp_nomor Nomor,fp_tanggal Tanggal,month(fp_tanggal) Bulan,year(fp_tanggal) Tahun,'
//          + ' sls_nama Salesman,cus_nama Outlet,brg_kode Kode,brg_nama Nama,brg_merk Merk,KTG_NAMA KATEGORI,BRG_DIVISI Divisi, fpd_brg_satuan Satuan,fpd_cn ,'
//          + ' sum((fpd_qty-ifnull(retjd_qty,0))) Qty,sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-ifnull(retjd_qty,0)))/100*if(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) Nilai,'
//          + ' sum(mst_stok_out*mst_hargabeli) hpp, '
//          + ' sum((fpd_qty-ifnull(retjd_qty,0))) Qty,sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-retjd_qty))/100*if(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) -'
//          + ' sum(mst_stok_out*mst_hargabeli) Margin, '
//          + ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*(fpd_qty-retjd_qty)/100) Kontrak FROM tfp_dtl inner join'
//          + ' tfp_hdr on fpd_fp_nomor=fp_nomor'
//          + ' inner join tbarang on fpd_brg_kode=brg_kode'
//          + ' inner join tcustomer on fp_cus_kode=cus_kode'
//          + ' LEFT JOIN Tretj_hdr on retj_fp_nomor=fp_nomor '
//          + ' left join tretj_dtl on retjd_retj_nomor=retj_nomor '
//          + ' left join tdo_hdr on fp_do_nomor=do_nomor '
//          + ' left join tso_hdr on do_so_nomor=so_nomor '
//          + ' left join tmasterstok on mst_noreferensi=do_nomor and fpd_brg_kode=mst_brg_kode and fpd_expired=mst_expired_date '
//          + ' left join tsalesman on sls_kode = so_sls_kode'
//          + ' lEFT join tkategori on ktg_kode=brg_ktg_kode '
//          + ' where fpd_cn > 0 and fp_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
//          + 'group by  cus_nama ,brg_kode '
//          + ' having ' + cxGrid1DBTableView1.DataController.Filter.FilterText ;
//    ftsreport.AddSQL(s);
//    ftsreport.ShowReport;
//  finally
//     ftsreport.Free;
//  end;
//
//end;
end;

procedure TfrmLapDORealisasi.cxButton1Click(Sender: TObject);
begin
  With cxPivot.GetFieldByName('Outlet') do
  begin
    if SortBySummaryInfo.Field = nil then
     begin
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Nilai');
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Nilai_Belum_ppn');
    end
    else
      SortBySummaryInfo.Field := nil;
  end;
    With cxPivot.GetFieldByName('Salesman') do
  begin
    if SortBySummaryInfo.Field = nil then
      begin
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Nilai');
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Nilai_Belum_ppn');
    end
    else
      SortBySummaryInfo.Field := nil;
  end;
    With cxPivot.GetFieldByName('Marketing') do
  begin
    if SortBySummaryInfo.Field = nil then
      begin
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Nilai');
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Nilai_Belum_ppn');
    end
    else
      SortBySummaryInfo.Field := nil;
  end;
     With cxPivot.GetFieldByName('Group_Produk') do
  begin
    if SortBySummaryInfo.Field = nil then
        begin
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Nilai');
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Nilai_Belum_ppn');
    end
    else
      SortBySummaryInfo.Field := nil;
  end;
  With cxPivot.GetFieldByName('Nama') do
  begin
    if SortBySummaryInfo.Field = nil then
     begin
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Nilai');
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Nilai_Belum_ppn');
    end
    else
      SortBySummaryInfo.Field := nil;
  end;
end;


procedure TfrmLapDORealisasi.cxButton2Click(Sender: TObject);
var
  ss,s:string;
   tt : TStrings;
   i:integer;
begin
//  ss:='select * from tbarangpf where bpf_periode > =' +FormatDateTime('mm',startdate.Date)
//  + ' and bpf_periode <= ' + FormatDateTime('mm',enddate.Date)
//  + ' and bpf_tahun >='+FormatDateTime('yyyy',startdate.DateTime)
//  + ' and bpf_tahun <='+ FormatDateTime('yyyy',enddate.Date);
//  MyQuery1.Close;
//  MyQuery1.SQL.Text := ss;
//  MyQuery1.Open;
//  MyQuery1.First;
//   tt:=TStringList.Create;
//   with MyQuery1 do
//   begin
//     while not eof do
//     begin
//       s:='insert into tbarangpf (bpf_periode,bpf_tahun,bpf_brg_kode,bpf_nama,bpf_grup,bpf_het,'
//       + ' bpf_dept,bpf_hna,bpf_kode_grouppf) '
//       + ' values ('
//       + fieldbyname('bpf_periode').AsString  + ','
//       + fieldbyname('bpf_tahun').AsString  + ','
//       + quot(fieldbyname('bpf_brg_kode').AsString)  + ','
//       + quot(fieldbyname('bpf_nama').AsString)  + ','
//       + quot(fieldbyname('bpf_grup').AsString)  + ','
//       + floattostr(fieldbyname('bpf_het').AsFloat)+','
//       + quot(fieldbyname('bpf_dept').AsString)  + ','
//       + floattostr(fieldbyname('bpf_hna').AsFloat)+','
//       + quot(fieldbyname('bpf_kode_grouppf').AsString)  + ');';
//       tt.Append(s);
//       Next;
//     end;
//   end;
//  try
//    for i:=0 to tt.Count -1 do
//    begin
//        xExecQuery(tt[i],frmMenu.conn);
//    end;
//  finally
//    tt.Free;
//  end;
//    xCommit(frmmenu.conn);


  try
      s:= 'update tfp_dtl INNER JOIN bsm.tbarangpf ON bpf_brg_kode=fpd_brg_kode and bpf_periode='+FormatDateTime('mm',startdate.date)
      + ' and bpf_tahun='+ Quot(FormatDateTime('yyyy',startdate.DateTime))
    + ' INNER JOIN tfp_hdr  ON fp_nomor=fpd_fp_nomor'
    + ' and YEAR(fp_tanggal)='+Quot(FormatDateTime('yyyy',startdate.DateTime))+' AND MONTH(fp_tanggal)='+FormatDateTime('mm',startdate.date)
    + ' set fpd_hrg_min=bpf_het '
    + ' where fp_tanggal between '+QuotD(startdate.date)+ ' and '+ QuotD(enddate.Date);
      EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

    finally
    ShowMessage('update het berhasil');
    end;
end;


procedure TfrmLapDORealisasi.cxButton5Click(Sender: TObject);
var
  fotoField: TField;
  fotoValue: string;
begin
  inherited;
 if cxGrid1DBTableView1.Controller.FocusedRecordIndex < 0 then Exit;

  if not ds3.Active then Exit;

  fotoField := ds3.FindField('Foto');
  if fotoField = nil then Exit;

  if fotoField.IsNull or (fotoField.AsString = '') then Exit;

  fotoValue := fotoField.AsString;

  Application.CreateForm(TfrmPrevImg, frmprevimg);
  try
    frmprevimg.foto := fotoValue;
    frmprevimg.ShowModal;
  finally
    frmprevimg.Release;
  end;
end;

end.
