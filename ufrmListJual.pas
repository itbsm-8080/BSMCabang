unit ufrmListJual;

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
  TfrmListJual = class(TForm)
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
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    cxButton3: TcxButton;
    CheckBox4: TCheckBox;
    cxButton1: TcxButton;
    Label3: TLabel;
    edtNama: TAdvEdit;
    edtkode: TAdvEditBtn;
    Label4: TLabel;
    edtNamabarang: TAdvEdit;
    cxButton2: TcxButton;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    cxButton4: TcxButton;
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
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure edtkodeClickBtn(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);

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

  frmListJual: TfrmListJual;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink,uReport,
  uFrmbantuan;
{$R *.dfm}



procedure TfrmListJual.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmListJual.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmListJual.refreshdata;
begin
  startdate.DateTime := Date;
  startdate.setfocus;

end;

procedure TfrmListJual.sbNewClick(Sender: TObject);
begin
   refreshdata;
   startdate.SetFocus;
//   sbdelete.Enabled := False;
end;




procedure TfrmListJual.FormShow(Sender: TObject);
begin
  flagedit := False;
  startdate.DateTime := Date;
  enddate.DateTime := Date;
  refreshdata;
end;





procedure TfrmListJual.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmListJual.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmListJual.loaddata;
var
  skolom,s,smargin,smargin2: string ;
  afilter : string ;
  i,jmlkolom:integer;
begin
  if frmMenu.KDUSER = 'FINANCE' Then
  smargin2 :=  ',0 hpp,0 margin'
  else
  smargin2 := '';

  if frmMenu.KDUSER = 'FINANCE' Then
  smargin :=  ' ,sum((mst_stok_out-'
          + ' (select IFNULL(sum(retjd_qty),0) from tretj_dtl inner join tretj_hdr on retj_nomor=retjd_retj_nomor '
          + ' inner join tfp_hdr on retj_fp_nomor=fp_nomor  '
          + ' where mst_noreferensi=fp_do_nomor and retjd_brg_kode=mst_brg_kode AND retjd_expired=mst_expired_date))'
          + ' *mst_hargabeli) hpp, '
          + ' sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-ifnull(retjd_qty,0)))/100) -'
          + ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*(fpd_qty-ifnull(retjd_qty,0))/100) - '
          + ' sum((mst_stok_out-'
          + ' (select Ifnull(sum(retjd_qty),0) from tretj_dtl inner join tretj_hdr on retj_nomor=retjd_retj_nomor '
          + ' inner join tfp_hdr on retj_fp_nomor=fp_nomor  '
          + ' where mst_noreferensi=fp_do_nomor and retjd_brg_kode=mst_brg_kode AND retjd_expired=mst_expired_date))'
          + ' *mst_hargabeli) Margin '
  else
  smargin := '';


if CheckBox1.Checked then
      { s:= ' SELECT fp_nomor Nomor,date_format(fp_tanggal,"%Y-%m-%d") Tanggal,month(fp_tanggal) Bulan,year(fp_tanggal) Tahun,"" Group_Produk,'
          + ' (SELECT sls_nama FROM tsalesman inner join tsalescustomer ON sls_kode=sc_sls_kode where sc_cus_kode=fp_cus_kode) Marketing,'
          + ' sls_nama Salesman,cus_nama Outlet,cus_gc_kode Golongan,jc_nama JenisCustomer,brg_kode Kode,brg_nama Nama,brg_merk Merk,KTG_NAMA KATEGORI,'
          + ' (SELECT ktg_nama FROM tkategori where ktg_kode=SUBSTRING_INDEX(brg_ktg_kode, ".", 2)) SubDepartemen, '
          + ' (SELECT ktg_nama FROM tkategori where ktg_kode=SUBSTRING_INDEX(brg_ktg_kode, ".", 1)) Departemen , '
          + ' BRG_DIVISI Divisi, fpd_brg_satuan Satuan,if(brg_isproductfocus=1,"Ya","Tidak") isPF,if(fp_isecer=0,"Tidak","Ya") Eceran'
          + ' ,if(fp_iscatalog=1,"Ya","Tidak") isCatalog,fpd_cn ,'
          + ' sum((fpd_qty-ifnull(retjd_qty,0))) Qty,sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-ifnull(retjd_qty,0)))/100*if(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) Nilai,'
          + ' sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-ifnull(retjd_qty,0)))/100) Nilai_Belum_ppn,'
          + ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*(fpd_qty-ifnull(retjd_qty,0))/100) Kontrak'
          + smargin
          + ' ,(fpd_qty*(((100-fpd_discpr)*fpd_harga/100)*fpd_bp_pr/100)) + (fpd_qty*fpd_bp_rp) biaya_promosi,fp_istax Pajak,'
          + ' if ((fpd_harga*(100-fpd_discpr)/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)- (((100-fpd_discpr)*fpd_harga/100)*fpd_bp_pr/100)-fpd_bp_rp <fpd_hrg_min,"Bawah Het",'
          + ' "Diatas HET") StatusHet,(select rayon_nama from trayon where rayon_kode=cus_ray_kode limit 1) Rayon'
          + ' ,cast(0 as signed) kunjunganmarketing,cast(0 as signed) kunjungansales'
          + ' FROM tfp_dtl inner join'
          + ' tfp_hdr on fpd_fp_nomor=fp_nomor'
          + ' inner join tbarang on fpd_brg_kode=brg_kode'
          + ' inner join tcustomer on fp_cus_kode=cus_kode'
          + ' left join tjeniscustomer on jc_kode=cus_jc_kode'
          + ' LEFT JOIN Tretj_hdr on retj_fp_nomor=fp_nomor '
          + ' left join tretj_dtl on retjd_retj_nomor=retj_nomor and retjd_brg_kode=fpd_brg_kode and fpd_expired=retjd_expired'
          + ' left join tdo_hdr on fp_do_nomor=do_nomor '
          + ' left join tso_hdr on do_so_nomor=so_nomor '
          + ' left join tmasterstok on mst_noreferensi=do_nomor and fpd_brg_kode=mst_brg_kode and fpd_expired=mst_expired_date '
          + ' left join tsalesman on sls_kode = so_sls_kode'
          + ' lEFT join tkategori on ktg_kode=brg_ktg_kode '
          + ' where fpd_cn > 0 and fp_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime) }

          s:= ' SELECT fp_nomor Nomor,date_format(fp_tanggal,"%Y-%m-%d") Tanggal,month(fp_tanggal) Bulan,year(fp_tanggal) Tahun,"" Group_Produk,'
          + ' (SELECT sls_nama FROM tsalesman inner join tsalescustomer ON sls_kode=sc_sls_kode where sc_cus_kode=fp_cus_kode) Marketing,'
          + ' sls_nama Salesman,cus_nama Outlet,cus_gc_kode Golongan,jc_nama JenisCustomer,brg_kode Kode,brg_nama Nama,brg_merk Merk,KTG_NAMA KATEGORI,'
          + ' (SELECT ktg_nama FROM tkategori where ktg_kode=SUBSTRING_INDEX(brg_ktg_kode, ".", 2)) SubDepartemen, '
          + ' (SELECT ktg_nama FROM tkategori where ktg_kode=SUBSTRING_INDEX(brg_ktg_kode, ".", 1)) Departemen , '
          + ' BRG_DIVISI Divisi, fpd_brg_satuan Satuan,if(brg_isproductfocus=1,"Ya","Tidak") isPF,if(fp_isecer=0,"Tidak","Ya") Eceran'
          + ' ,if(fp_iscatalog=1,"Ya","Tidak") isCatalog,fpd_cn ,'
          + ' sum((fpd_qty-ifnull(retjd_qty,0))) Qty,sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-ifnull(retjd_qty,0)))/100*if(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) Nilai,'
          + ' sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-ifnull(retjd_qty,0)))/100) Nilai_Belum_ppn,'
          + ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*(fpd_qty-ifnull(retjd_qty,0))/100) Kontrak'
          + smargin
          + ' ,SUM( '
          + ' ( '
          + ' 		fpd_qty * '
          + ' 		(((100 - fpd_discpr) * fpd_harga / 100) * fpd_bp_pr / 100) '
          + ' ) + (fpd_qty * fpd_bp_rp) '
          + ' ) AS biaya_promosi, '
          + ' SUM( '
          + ' ( '
          + ' 		fpd_qty * '
          + ' 		(((100 - fpd_discpr) * fpd_harga / 100) * fpd_bp_pr2 / 100) '
          + ' ) + (fpd_qty * fpd_bp_rp2) '
          + ' ) AS fee_marketing, '
          + ' ( '
          + '    SUM( '
          + '        (100 - fpd_discpr) * '
          + '        (fpd_harga * (fpd_qty - IFNULL(retjd_qty,0))) / 100 '
          + '    ) '
          + '    - '
          + '    SUM( '
          + '        fpd_cn * '
          + '        ((100 - fpd_discpr) * fpd_harga / 100) * '
          + '        (fpd_qty - IFNULL(retjd_qty,0)) / 100 '
          + '    ) '
          + '    - '
          + '    SUM( '
          + '        (fpd_qty * '
          + '            (((100 - fpd_discpr) * fpd_harga / 100) * fpd_bp_pr / 100) '
          + '        ) '
          + '        + (fpd_qty * fpd_bp_rp) '
          + '    ) '
          + '    - '
          + '    SUM( '
          + '        (fpd_qty * '
          + '            (((100 - fpd_discpr) * fpd_harga / 100) * fpd_bp_pr2 / 100) '
          + '        ) '
          + '        + (fpd_qty * fpd_bp_rp2) '
          + '    ) '
          + ' ) AS Nilai_Net, '
          + ' fp_istax Pajak, '
          + ' if ((fpd_harga*(100-fpd_discpr)/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)- (((100-fpd_discpr)*fpd_harga/100)*fpd_bp_pr/100)-fpd_bp_rp <fpd_hrg_min,"Bawah Het",'
          + ' "Diatas HET") StatusHet,(select rayon_nama from trayon where rayon_kode=cus_ray_kode limit 1) Rayon'
          + ' ,cast(0 as signed) kunjunganmarketing,cast(0 as signed) kunjungansales'
          + ' FROM tfp_dtl inner join'
          + ' tfp_hdr on fpd_fp_nomor=fp_nomor'
          + ' inner join tbarang on fpd_brg_kode=brg_kode'
          + ' inner join tcustomer on fp_cus_kode=cus_kode'
          + ' left join tjeniscustomer on jc_kode=cus_jc_kode'
          + ' LEFT JOIN Tretj_hdr on retj_fp_nomor=fp_nomor '
          + ' left join tretj_dtl on retjd_retj_nomor=retj_nomor and retjd_brg_kode=fpd_brg_kode and fpd_expired=retjd_expired'
          + ' left join tdo_hdr on fp_do_nomor=do_nomor '
          + ' left join tso_hdr on do_so_nomor=so_nomor '
          + ' left join tmasterstok on mst_noreferensi=do_nomor and fpd_brg_kode=mst_brg_kode and fpd_expired=mst_expired_date '
          + ' left join tsalesman on sls_kode = so_sls_kode'
          + ' lEFT join tkategori on ktg_kode=brg_ktg_kode '
          + ' where fpd_cn > 0 and fp_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)


else
begin
  if CheckBox3.Checked then
          {  s:= ' SELECT fp_nomor Nomor,date_format(fp_tanggal,"%Y-%m-%d") Tanggal,month(fp_tanggal) Bulan,year(fp_tanggal) Tahun,"" Group_produk,'
          + ' (SELECT sls_nama FROM tsalesman inner join tsalescustomer ON sls_kode=sc_sls_kode where sc_cus_kode=fp_cus_kode) Marketing,'
          + ' sls_nama Salesman,cus_nama Outlet,cus_gc_kode Golongan,jc_nama JenisCustomer,brg_kode Kode,brg_nama Nama,brg_merk Merk,ktg_nama Kategori,'
          + ' (SELECT ktg_nama FROM tkategori where ktg_kode=SUBSTRING_INDEX(brg_ktg_kode, ".", 2)) SubDepartemen, '
          + ' (SELECT ktg_nama FROM tkategori where ktg_kode=SUBSTRING_INDEX(brg_ktg_kode, ".", 1)) Departemen , '
          + ' BRG_DIVISI Divisi, fpd_brg_satuan Satuan,if(brg_isproductfocus=1,"Ya","Tidak") isPF,if(fp_isecer=0,"Tidak","Ya") Eceran,'
          + ' if(fp_iscatalog=1,"Ya","Tidak") isCatalog ,fpd_cn ,'
          + ' sum((fpd_qty-ifnull(retjd_qty,0))) Qty,sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-ifnull(retjd_qty,0)))/100*if(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) Nilai,'
          + ' sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-ifnull(retjd_qty,0)))/100) Nilai_Belum_ppn,'
          + ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*(fpd_qty-ifnull(retjd_qty,0))/100) Kontrak'
          + smargin
          + ' ,(fpd_qty*(((100-fpd_discpr)*fpd_harga/100)*fpd_bp_pr/100)) + (fpd_qty*fpd_bp_rp) biaya_promosi,fp_istax Pajak,'
          + ' if ((fpd_harga*(100-fpd_discpr)/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)- (((100-fpd_discpr)*fpd_harga/100)*fpd_bp_pr/100)-fpd_bp_rp <fpd_hrg_min,"Bawah Het",'
          + ' "Diatas HET") StatusHet ,(select rayon_nama from trayon where rayon_kode=cus_ray_kode limit 1) Rayon'
          + ' ,cast(0 as signed) kunjunganmarketing,cast(0 as signed) kunjungansales'
          + ' FROM tfp_dtl inner join'
          + ' tfp_hdr on fpd_fp_nomor=fp_nomor'
          + ' inner join tbarang on fpd_brg_kode=brg_kode'
          + ' inner join tcustomer on fp_cus_kode=cus_kode'
          + ' inner join tbayarcus_dtl on bycd_fp_nomor=fp_nomor '
          + ' inner join tbayarcus_hdr on bycd_byc_nomor=byc_nomor '
          + ' left join tjeniscustomer on jc_kode=cus_jc_kode'
          + ' LEFT JOIN Tretj_hdr on retj_fp_nomor=fp_nomor '
          + ' left join tretj_dtl on retjd_retj_nomor=retj_nomor and retjd_brg_kode=fpd_brg_kode and fpd_expired=retjd_expired'
          + ' left join tdo_hdr on fp_do_nomor=do_nomor '
          + ' left join tso_hdr on do_so_nomor=so_nomor '
          + ' left join tmasterstok on mst_noreferensi=do_nomor and fpd_brg_kode=mst_brg_kode and fpd_expired=mst_expired_date '
          + ' left join tsalesman on sls_kode = so_sls_kode'
          + ' left join tkategori on ktg_kode= brg_ktg_kode'
          + ' where byc_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
          + ' and fp_cus_kode like '+Quot(edtkode.Text+'%')
          + ' and brg_nama like '+Quot('%'+edtnamabarang.Text+'%')  }

          s:= ' SELECT fp_nomor Nomor,date_format(fp_tanggal,"%Y-%m-%d") Tanggal,month(fp_tanggal) Bulan,year(fp_tanggal) Tahun,"" Group_produk,'
          + ' (SELECT sls_nama FROM tsalesman inner join tsalescustomer ON sls_kode=sc_sls_kode where sc_cus_kode=fp_cus_kode) Marketing,'
          + ' sls_nama Salesman,cus_nama Outlet,cus_gc_kode Golongan,jc_nama JenisCustomer,brg_kode Kode,brg_nama Nama,brg_merk Merk,ktg_nama Kategori,'
          + ' (SELECT ktg_nama FROM tkategori where ktg_kode=SUBSTRING_INDEX(brg_ktg_kode, ".", 2)) SubDepartemen, '
          + ' (SELECT ktg_nama FROM tkategori where ktg_kode=SUBSTRING_INDEX(brg_ktg_kode, ".", 1)) Departemen , '
          + ' BRG_DIVISI Divisi, fpd_brg_satuan Satuan,if(brg_isproductfocus=1,"Ya","Tidak") isPF,if(fp_isecer=0,"Tidak","Ya") Eceran,'
          + ' if(fp_iscatalog=1,"Ya","Tidak") isCatalog ,fpd_cn ,'
          + ' sum((fpd_qty-ifnull(retjd_qty,0))) Qty,sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-ifnull(retjd_qty,0)))/100*if(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) Nilai,'
          + ' sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-ifnull(retjd_qty,0)))/100) Nilai_Belum_ppn,'
          + ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*(fpd_qty-ifnull(retjd_qty,0))/100) Kontrak'
          + smargin
          + ' ,SUM( '
          + ' ( '
          + ' 		fpd_qty * '
          + ' 		(((100 - fpd_discpr) * fpd_harga / 100) * fpd_bp_pr / 100) '
          + ' ) + (fpd_qty * fpd_bp_rp) '
          + ' ) AS biaya_promosi, '
          + ' SUM( '
          + ' ( '
          + ' 		fpd_qty * '
          + ' 		(((100 - fpd_discpr) * fpd_harga / 100) * fpd_bp_pr2 / 100) '
          + ' ) + (fpd_qty * fpd_bp_rp2) '
          + ' ) AS fee_marketing, '
          + ' ( '
          + '    SUM( '
          + '        (100 - fpd_discpr) * '
          + '        (fpd_harga * (fpd_qty - IFNULL(retjd_qty,0))) / 100 '
          + '    ) '
          + '    - '
          + '    SUM( '
          + '        fpd_cn * '
          + '        ((100 - fpd_discpr) * fpd_harga / 100) * '
          + '        (fpd_qty - IFNULL(retjd_qty,0)) / 100 '
          + '    ) '
          + '    - '
          + '    SUM( '
          + '        (fpd_qty * '
          + '            (((100 - fpd_discpr) * fpd_harga / 100) * fpd_bp_pr / 100) '
          + '        ) '
          + '        + (fpd_qty * fpd_bp_rp) '
          + '    ) '
          + '    - '
          + '    SUM( '
          + '        (fpd_qty * '
          + '            (((100 - fpd_discpr) * fpd_harga / 100) * fpd_bp_pr2 / 100) '
          + '        ) '
          + '        + (fpd_qty * fpd_bp_rp2) '
          + '    ) '
          + ' ) AS Nilai_Net, '
          + ' fp_istax Pajak, '
          + ' if ((fpd_harga*(100-fpd_discpr)/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)- (((100-fpd_discpr)*fpd_harga/100)*fpd_bp_pr/100)-fpd_bp_rp <fpd_hrg_min,"Bawah Het",'
          + ' "Diatas HET") StatusHet ,(select rayon_nama from trayon where rayon_kode=cus_ray_kode limit 1) Rayon'
          + ' ,cast(0 as signed) kunjunganmarketing,cast(0 as signed) kunjungansales'
          + ' FROM tfp_dtl inner join'
          + ' tfp_hdr on fpd_fp_nomor=fp_nomor'
          + ' inner join tbarang on fpd_brg_kode=brg_kode'
          + ' inner join tcustomer on fp_cus_kode=cus_kode'
          + ' inner join tbayarcus_dtl on bycd_fp_nomor=fp_nomor '
          + ' inner join tbayarcus_hdr on bycd_byc_nomor=byc_nomor '
          + ' left join tjeniscustomer on jc_kode=cus_jc_kode'
          + ' LEFT JOIN Tretj_hdr on retj_fp_nomor=fp_nomor '
          + ' left join tretj_dtl on retjd_retj_nomor=retj_nomor and retjd_brg_kode=fpd_brg_kode and fpd_expired=retjd_expired'
          + ' left join tdo_hdr on fp_do_nomor=do_nomor '
          + ' left join tso_hdr on do_so_nomor=so_nomor '
          + ' left join tmasterstok on mst_noreferensi=do_nomor and fpd_brg_kode=mst_brg_kode and fpd_expired=mst_expired_date '
          + ' left join tsalesman on sls_kode = so_sls_kode'
          + ' left join tkategori on ktg_kode= brg_ktg_kode'
          + ' where byc_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
          + ' and fp_cus_kode like '+Quot(edtkode.Text+'%')
          + ' and brg_nama like '+Quot('%'+edtnamabarang.Text+'%')

  else
     { s:= ' SELECT fp_nomor Nomor,date_format(fp_tanggal,"%Y-%m-%d") Tanggal,month(fp_tanggal) Bulan,year(fp_tanggal) Tahun,'
          + ' (SELECT pmh_nama FROM tprodukmarketing_hdr  INNER JOIN tprodukmarketing_dtl ON pmd_pmh_nomor=pmh_nomor where pmd_brg_kode=brg_kode limit 1) Group_produk,'
          + ' (SELECT sls_nama FROM tsalesman inner join tsalescustomer ON sls_kode=sc_sls_kode where sc_cus_kode=fp_cus_kode) Marketing,'
          + ' sls_nama Salesman,cus_nama Outlet,cus_gc_kode Golongan,jc_nama JenisCustomer,brg_kode Kode,brg_nama Nama,brg_merk Merk,ktg_nama Kategori,'
          + ' (SELECT ktg_nama FROM tkategori where ktg_kode=SUBSTRING_INDEX(brg_ktg_kode, ".", 2)) SubDepartemen, '
          + ' (SELECT ktg_nama FROM tkategori where ktg_kode=SUBSTRING_INDEX(brg_ktg_kode, ".", 1)) Departemen , '
          + ' BRG_DIVISI Divisi, fpd_brg_satuan Satuan,if(brg_isproductfocus=1,"Ya","Tidak") isPF,if(fp_isecer=0,"Tidak","Ya") Eceran,'
          + ' if(fp_iscatalog=1,"Ya","Tidak") isCatalog ,fpd_cn ,'
          + ' sum((fpd_qty-ifnull(retjd_qty,0))) Qty,sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-ifnull(retjd_qty,0)))/100*if(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) Nilai,'
          + ' sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-ifnull(retjd_qty,0)))/100) Nilai_Belum_ppn,'
          + ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*(fpd_qty-ifnull(retjd_qty,0))/100) Kontrak '
          + smargin
          + ' ,(fpd_qty*(((100-fpd_discpr)*fpd_harga/100)*fpd_bp_pr/100)) + (fpd_qty*fpd_bp_rp) biaya_promosi,fp_istax Pajak,'
          + ' if ((fpd_harga*(100-fpd_discpr)/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)- (((100-fpd_discpr)*fpd_harga/100)*fpd_bp_pr/100)-fpd_bp_rp <fpd_hrg_min,"Bawah Het",'
          + ' "Diatas HET") StatusHet ,(select rayon_nama from trayon where rayon_kode=cus_ray_kode limit 1) Rayon'
          + ' ,cast(0 as signed) kunjunganmarketing,cast(0 as signed) kunjungansales'
          + ' FROM tfp_dtl inner join'
          + ' tfp_hdr on fpd_fp_nomor=fp_nomor'
          + ' inner join tbarang on fpd_brg_kode=brg_kode'
          + ' inner join tcustomer on fp_cus_kode=cus_kode'
          + ' inner join tdo_hdr on fp_do_nomor=do_nomor '
          + ' inner join tso_hdr on do_so_nomor=so_nomor '
          + ' inner join masterstok on mst_noreferensi=do_nomor and fpd_brg_kode=mst_brg_kode and fpd_expired=mst_expired_date '
          + ' left join tjeniscustomer on jc_kode=cus_jc_kode'
//          + ' and mst_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
          + ' LEFT JOIN tretj_hdr on retj_fp_nomor=fp_nomor '
          + ' left join tretj_dtl on retjd_retj_nomor=retj_nomor and retjd_brg_kode=fpd_brg_kode and fpd_expired=retjd_expired'
          + ' left join tsalesman on sls_kode = so_sls_kode'
          + ' left join tkategori on ktg_kode=brg_ktg_kode'
          + ' where fp_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
          + ' and fp_cus_kode like '+Quot(edtkode.Text+'%')
          + ' and brg_nama like '+Quot('%'+edtnamabarang.Text+'%'); }

          s:= ' SELECT fp_nomor Nomor,date_format(fp_tanggal,"%Y-%m-%d") Tanggal,month(fp_tanggal) Bulan,year(fp_tanggal) Tahun,'
          + ' (SELECT pmh_nama FROM tprodukmarketing_hdr  INNER JOIN tprodukmarketing_dtl ON pmd_pmh_nomor=pmh_nomor where pmd_brg_kode=brg_kode limit 1) Group_produk,'
          + ' (SELECT sls_nama FROM tsalesman inner join tsalescustomer ON sls_kode=sc_sls_kode where sc_cus_kode=fp_cus_kode) Marketing,'
          + ' sls_nama Salesman,cus_nama Outlet,cus_gc_kode Golongan,jc_nama JenisCustomer,brg_kode Kode,brg_nama Nama,brg_merk Merk,ktg_nama Kategori,'
          + ' (SELECT ktg_nama FROM tkategori where ktg_kode=SUBSTRING_INDEX(brg_ktg_kode, ".", 2)) SubDepartemen, '
          + ' (SELECT ktg_nama FROM tkategori where ktg_kode=SUBSTRING_INDEX(brg_ktg_kode, ".", 1)) Departemen , '
          + ' BRG_DIVISI Divisi, fpd_brg_satuan Satuan,if(brg_isproductfocus=1,"Ya","Tidak") isPF,if(fp_isecer=0,"Tidak","Ya") Eceran,'
          + ' if(fp_iscatalog=1,"Ya","Tidak") isCatalog ,fpd_cn ,'
          + ' sum((fpd_qty-ifnull(retjd_qty,0))) Qty,sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-ifnull(retjd_qty,0)))/100*if(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) Nilai,'
          + ' sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-ifnull(retjd_qty,0)))/100) Nilai_Belum_ppn,'
          + ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*(fpd_qty-ifnull(retjd_qty,0))/100) Kontrak '
          + smargin
          + ' ,SUM( '
          + ' ( '
          + ' 		fpd_qty * '
          + ' 		(((100 - fpd_discpr) * fpd_harga / 100) * fpd_bp_pr / 100) '
          + ' ) + (fpd_qty * fpd_bp_rp) '
          + ' ) AS biaya_promosi, '
          + ' SUM( '
          + ' ( '
          + ' 		fpd_qty * '
          + ' 		(((100 - fpd_discpr) * fpd_harga / 100) * fpd_bp_pr2 / 100) '
          + ' ) + (fpd_qty * fpd_bp_rp2) '
          + ' ) AS fee_marketing, '
          + ' ( '
          + '    SUM( '
          + '        (100 - fpd_discpr) * '
          + '        (fpd_harga * (fpd_qty - IFNULL(retjd_qty,0))) / 100 '
          + '    ) '
          + '    - '
          + '    SUM( '
          + '        fpd_cn * '
          + '        ((100 - fpd_discpr) * fpd_harga / 100) * '
          + '        (fpd_qty - IFNULL(retjd_qty,0)) / 100 '
          + '    ) '
          + '    - '
          + '    SUM( '
          + '        (fpd_qty * '
          + '            (((100 - fpd_discpr) * fpd_harga / 100) * fpd_bp_pr / 100) '
          + '        ) '
          + '        + (fpd_qty * fpd_bp_rp) '
          + '    ) '
          + '    - '
          + '    SUM( '
          + '        (fpd_qty * '
          + '            (((100 - fpd_discpr) * fpd_harga / 100) * fpd_bp_pr2 / 100) '
          + '        ) '
          + '        + (fpd_qty * fpd_bp_rp2) '
          + '    ) '
          + ' ) AS Nilai_Net, '
          + ' fp_istax Pajak, '
          + ' if ((fpd_harga*(100-fpd_discpr)/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)- (((100-fpd_discpr)*fpd_harga/100)*fpd_bp_pr/100)-fpd_bp_rp <fpd_hrg_min,"Bawah Het",'
          + ' "Diatas HET") StatusHet ,(select rayon_nama from trayon where rayon_kode=cus_ray_kode limit 1) Rayon'
          + ' ,cast(0 as signed) kunjunganmarketing,cast(0 as signed) kunjungansales'
          + ' FROM tfp_dtl inner join'
          + ' tfp_hdr on fpd_fp_nomor=fp_nomor'
          + ' inner join tbarang on fpd_brg_kode=brg_kode'
          + ' inner join tcustomer on fp_cus_kode=cus_kode'
          + ' inner join tdo_hdr on fp_do_nomor=do_nomor '
          + ' inner join tso_hdr on do_so_nomor=so_nomor '
          + ' inner join masterstok on mst_noreferensi=do_nomor and fpd_brg_kode=mst_brg_kode and fpd_expired=mst_expired_date '
          + ' left join tjeniscustomer on jc_kode=cus_jc_kode'
//          + ' and mst_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
          + ' LEFT JOIN tretj_hdr on retj_fp_nomor=fp_nomor '
          + ' left join tretj_dtl on retjd_retj_nomor=retj_nomor and retjd_brg_kode=fpd_brg_kode and fpd_expired=retjd_expired'
          + ' left join tsalesman on sls_kode = so_sls_kode'
          + ' left join tkategori on ktg_kode=brg_ktg_kode'
          + ' where fp_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
          + ' and fp_cus_kode like '+Quot(edtkode.Text+'%')
          + ' and brg_nama like '+Quot('%'+edtnamabarang.Text+'%');
 end;



if CheckBox2.Checked then
 s:= s + ' and brg_isproductfocus=1 ' ;

if CheckBox4.Checked then
 s:= s + ' and fp_cus_kode in (select sc_cus_kode from tsalescustomer) ';

s:= s + ' group by fp_nomor,fp_tanggal ,month(fp_tanggal),year(fp_tanggal) ,cus_nama,brg_kode ,brg_nama ,fpd_brg_satuan';

s:=s
+ ' union '
+ ' SELECT "" Nomor,date_format(tanggal,"%Y-%m-%d") Tanggal,cast(date_format(tanggal,"%m") as signed)  bulan ,'
+ ' cast(date_format(tanggal,"%Y") as signed)  Tahun,"" Group_produk,if(sls_insentif=2,sls_nama,"") marketing,'
+ ' if(sls_insentif=1,sls_nama,"") salesman,'
+ ' cus_nama,"" Golongan,"" Jeniscustomer,0 Kode,"" Nama,"" merk,"" kategori,"" subdepartemen,"" departemen,"" divisi,'
+ ' "" satuan , if(sls_insentif=2,"Ya","Tidak") ISpf,"" eceran,"" iscatalog,0 fpd_cn,'
+ ' 0 qty,0 nilai  ,0 nilaiblmppn,0 kontrak '
+ smargin2
+ ' ,0 biaya_promosi,0 fee_marketing,0 Nilai_Net,0 pajak,"" status_het,"" rayon,'
+ ' cast(if(sls_insentif=2,1,0) as signed) kunjunganmarketing,cast(if(sls_insentif=1,1,0) as signed) kunjungansales'
+ ' FROM zkunjungan x INNER JOIN tsalesman ON USER=sls_nama'
+ ' left JOIN tcustomer y ON x.cus_kode=y.cus_kode '
+ ' where tanggal between ' + QuotD(startdate.DateTime) + ' and date_add(' + QuotD(enddate.DateTime)+' , interval 1 day) ';
  ds3.Close;
        sqlqry1.Connection := frmmenu.conn;
        sqlqry1.SQL.Text := s;
        ds3.open;

//
      if frmMenu.KDUSER = 'FINANCE' THEN
      Begin
        Skolom :='Nomor,Tanggal,Bulan,Tahun,Salesman,Marketing,Outlet,Golongan,JenisCustomer,Kode,Nama,Satuan,Merk,Kategori,Departemen,subDepartemen,Divisi,fpd_cn,Qty,Nilai,Nilai_Belum_ppn,Kontrak,Hpp, '
        + ' Margin,Biaya_promosi,Fee_Marketing,Nilai_Net,'
        + ' Group_Produk,Pajak,StatusHet,IsPf,Eceran,isCatalog,Rayon';
        QueryToDBGrid(cxGrid1DBTableView1, s,skolom ,ds2);
        cxGrid1DBTableView1.Columns[22].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[22].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[23].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[23].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[25].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[25].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[26].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[26].Summary.FooterFormat:='###,###,###,###';

      end
      else
      Begin
        Skolom := 'Nomor,Tanggal,Bulan,Tahun,Salesman,Marketing,Outlet,Golongan,JenisCustomer,Kode,Nama,Satuan,Merk,Kategori,' +
  'Departemen,subDepartemen,Divisi,fpd_cn,Qty,Nilai,Nilai_Belum_ppn,Kontrak,Biaya_promosi,Fee_Marketing,Nilai_Net,' +
  'Group_produk,Pajak,StatusHet,IsPf,Eceran,Iscatalog,Rayon';

        QueryToDBGrid(cxGrid1DBTableView1, s,skolom ,ds2);
      end;




           cxGrid1DBTableView1.Columns[0].MinWidth := 60;
           cxGrid1DBTableView1.Columns[1].MinWidth := 60;
           cxGrid1DBTableView1.Columns[2].MinWidth := 100;
           cxGrid1DBTableView1.Columns[3].MinWidth := 100;
           cxGrid1DBTableView1.Columns[4].MinWidth := 100;
           cxGrid1DBTableView1.Columns[5].MinWidth := 100;
           cxGrid1DBTableView1.Columns[6].MinWidth := 100;
           cxGrid1DBTableView1.Columns[7].MinWidth := 100;

        if frmMenu.KDUSER = 'FINANCE' THEN
           jmlkolom :=cxGrid1DBTableView1.ColumnCount -2
        else
           jmlkolom :=cxGrid1DBTableView1.ColumnCount-2;

        for i:=0 To jmlkolom do
        begin
          if ds3.Fields[i].DataType = ftFloat then
          begin
             ds3.Fields[i].Alignment := taRightJustify;
             TFloatField(ds3.Fields[i]).DisplayFormat := '###,###,###';
          end;

        end;

        cxGrid1DBTableView1.Columns[17].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[17].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[18].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[18].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[19].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[19].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[20].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[20].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[21].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[21].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[22].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[22].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[23].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[23].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[24].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[24].Summary.FooterFormat:='###,###,###,###';

        //  hitung;

          TcxDBPivotHelper(cxPivot).LoadFromCDS(ds3);
           SetPivotColumns(['Bulan']);
           SetPivotRow (['Salesman']);
           SetPivotData(['Nilai']);

end;

procedure TfrmListJual.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmListJual.cxPageControl1Click(Sender: TObject);
begin
IF PageControl1.Pages[2].Visible  then
begin
  PivotChartLink.GridChartView := cxGrdChart;
  PivotChartLink.PivotGrid := cxPivot;
end;
end;

procedure TfrmListJual.TeSpeedButton1Click(Sender: TObject);
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


procedure TfrmListJual.dttanggalChange(Sender: TObject);
begin
  enddate.DateTime := startdate.DateTime;
end;

function TfrmListJual.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmListJual.TeSpeedButton2Click(Sender: TObject);
begin
//  IF PageControl1.Pages[1].Visible  then
//     cxVCLPrinterPivot.Preview
//  else
//  if PageControl1.Pages[2].Visible  then
//    cxVCLPrinterChart.Preview;
end;

procedure TfrmListJual.SetPivotRow(ColumnSets: Array Of String);
begin
  TcxDBPivotHelper(cxPivot).SetRowColumns(ColumnSets);
end;

procedure TfrmListJual.SetPivotColumns(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetColColumns(ColumnSets);
end;

procedure TfrmListJual.SetPivotData(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetDataColumns(ColumnSets);
end;


procedure TfrmListJual.cxButton3Click(Sender: TObject);
var
  s:string;
  ftsreport : TTSReport;
begin
if CheckBox1.Checked then
begin
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'kontrak';

          s:= ' SELECT fp_nomor Nomor,fp_tanggal Tanggal,month(fp_tanggal) Bulan,year(fp_tanggal) Tahun,'
          + ' sls_nama Salesman,cus_nama Outlet,brg_kode Kode,brg_nama Nama,brg_merk Merk,KTG_NAMA KATEGORI,BRG_DIVISI Divisi, fpd_brg_satuan Satuan,fpd_cn ,'
          + ' sum((fpd_qty-ifnull(retjd_qty,0))) Qty,sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-ifnull(retjd_qty,0)))/100*if(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) Nilai,'
          + ' sum(mst_stok_out*mst_hargabeli) hpp, '
          + ' sum((fpd_qty-ifnull(retjd_qty,0))) Qty,sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-retjd_qty))/100*if(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) -'
          + ' sum(mst_stok_out*mst_hargabeli) Margin, '
          + ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*(fpd_qty-retjd_qty)/100) Kontrak FROM tfp_dtl inner join'
          + ' tfp_hdr on fpd_fp_nomor=fp_nomor'
          + ' inner join tbarang on fpd_brg_kode=brg_kode'
          + ' inner join tcustomer on fp_cus_kode=cus_kode'
          + ' LEFT JOIN Tretj_hdr on retj_fp_nomor=fp_nomor '
          + ' left join tretj_dtl on retjd_retj_nomor=retj_nomor '
          + ' left join tdo_hdr on fp_do_nomor=do_nomor '
          + ' left join tso_hdr on do_so_nomor=so_nomor '
          + ' left join tmasterstok on mst_noreferensi=do_nomor and fpd_brg_kode=mst_brg_kode and fpd_expired=mst_expired_date '
          + ' left join tsalesman on sls_kode = so_sls_kode'
          + ' lEFT join tkategori on ktg_kode=brg_ktg_kode '
          + ' where fpd_cn > 0 and fp_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
          + 'group by  cus_nama ,brg_kode '
          + ' having ' + cxGrid1DBTableView1.DataController.Filter.FilterText ;
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;

end;
end;

procedure TfrmListJual.cxButton1Click(Sender: TObject);
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

procedure TfrmListJual.edtkodeClickBtn(Sender: TObject);
var
  s:String;
  tsql:TSQLQuery;
begin
   sqlbantuan:='select cus_kode Kode,cus_nama Customer,cus_alamat Alamat from tcustomer';
   Application.CreateForm(Tfrmbantuan,frmbantuan);
   frmBantuan.SQLMaster := SQLbantuan;
   frmBantuan.ShowModal;


   if varglobal <> '' then
   begin
     edtkode.Text := varglobal;
     edtNama.Text := varglobal1;
   end;


end;


procedure TfrmListJual.cxButton2Click(Sender: TObject);
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
      s:= 'update tfp_dtl INNER JOIN bsm.barangpf ON bpf_brg_kode=fpd_brg_kode '
    + ' INNER JOIN tfp_hdr  ON fp_nomor=fpd_fp_nomor'
    + ' and YEAR(fp_tanggal)=bpf_tahun AND MONTH(fp_tanggal)=bpf_periode'
    + ' set fpd_hrg_min=bpf_het '
    + ' where fp_tanggal between '+QuotD(startdate.date)+ ' and '+ QuotD(enddate.Date);
      EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
    
    finally
    ShowMessage('update het berhasil');
    end;
end;

procedure TfrmListJual.cxButton4Click(Sender: TObject);
var
  s: string ;
  ftsreport : TTSReport;
begin
if edtkode.Text = '' then
begin
  ShowMessage('customer harus di pilih dahulu');
  Exit;
end;

  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'bukusaku';

          s:= ' select ' + quot(edtnama.text)+' as Customer, '
          + Quot(FormatDateTime('dd/mm/yyyy',startdate.DateTime)) + ' as tgl1 , '
          + Quot(FormatDateTime('dd/mm/yyyy',enddate.DateTime)) + ' as tgl2 , '
          + ' brg_kode Kode,brg_nama Nama,SUM(fpd_qty) QtyLalu,  '
          + ' (SELECT SUM(fpd_qty) FROM tfp_dtl INNER JOIN tfp_hdr ON fp_nomor=fpd_fp_nomor WHERE fp_cus_kode=cus_kode AND fpd_brg_kode=brg_kode'
          + ' AND month(fp_tanggal)=MONTH(NOW()) AND YEAR(fp_tanggal)=YEAR(NOW()) ) realisasi,'
          + ' (SELECT SUM(retjd_qty) FROM tretj_dtl INNER JOIN tretj_hdr ON retj_nomor=retjd_retj_nomor WHERE retj_cus_kode=cus_kode AND retjd_brg_kode=brg_kode'
          + ' AND month(fp_tanggal)=MONTH(NOW()) AND YEAR(fp_tanggal)=YEAR(NOW()) ) returberjalan,'
          + ' (SELECT SUM(retjd_qty) FROM tretj_dtl INNER JOIN tretj_hdr ON retj_nomor=retjd_retj_nomor WHERE retjd_brg_kode=brg_kode'
          + ' AND retj_fp_nomor=fp_nomor ) returlalu '
          + '  FROM tfp_dtl INNER JOIN tfp_hdr'
          + ' ON fp_nomor=fpd_fp_nomor'
          + ' INNER JOIN tcustomer ON cus_kode=fp_cus_kode'
          + ' LEFT JOIN tbarang ON brg_kode=fpd_brg_kode'
          + ' WHERE fp_cus_kode='+Quot(edtkode.Text)
          + ' AND fp_tanggal BETWEEN '+QuotD(startdate.Date)+' AND '+ QuotD(enddate.Date)
          + ' GROUP BY brg_kode';
 ;


    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;


end.
