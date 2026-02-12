unit ufrmLapKunjunganMarketing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmCxBrowse, Menus, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, FMTBcd, Provider, SqlExpr, ImgList,
  ComCtrls, StdCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, AdvEdit,
  AdvEdBtn;

type
  TfrmLapKunjunganMarketing = class(TfrmCxBrowse)
    Label3: TLabel;
    edtKode: TAdvEditBtn;
    edtNama: TAdvEdit;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure edtKodeClickBtn(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLapKunjunganMarketing: TfrmLapKunjunganMarketing;

implementation
   uses ufrmCostCenter,Ulib, MAIN, uModuleConnection, uFrmbantuan;
{$R *.dfm}

procedure TfrmLapKunjunganMarketing.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select * from (SELECT sc_cus_kode Kode,"BSM" Cabang,cus_nama Customer,('
+ ' select'
+ ' sum(fpd_qty*(((100-fpd_discpr)*fpd_harga/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)-'
+ ' ((fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)/100)+fpd_bp_rp)))'
+ ' from tfp_dtl'
+ ' inner join tfp_hdr on fp_nomor =fpd_fp_nomor'
+ ' inner join tsalescustomer on fp_cus_kode=SC_cus_kode'
+ ' inner join tcustomer on sc_cus_kode=cus_kode'
+ ' inner join tbarang on brg_kode=fpd_brg_kode'
+ ' INNER JOIN tprodukmarketing_dtl ON fpd_brg_kode=pmd_brg_kode'
+ ' INNER JOIN tprodukmarketing_hdr ON pmh_nomor=pmd_pmh_nomor'
+ ' INNER JOIN tsalesman ON sls_kode=sc_sls_kode'
+ ' where sls_nama='+Quot(edtNama.Text)
+ ' and fp_tanggal between '+ QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
+ ' AND cus_kode =a.sc_cus_kode'
+ ' GROUP BY cus_kode'
+ ' ) Nilai,'
+ ' (SELECT COUNT(distinct DATE_FORMAT(TANGGAL,"%Y/%m/%d")) FROM tkunjungan'
+ ' INNER JOIN tsalesman ON sls_nama=user'
+ ' WHERE cus_kode=a.sc_cus_kode'
+ ' AND tanggal between '+ QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
+ ' AND sls_nama='+Quot(edtNama.Text)+') Kunjungan'
+ ' FROM tsalescustomer a INNER JOIN tcustomer b ON'
+ ' a.sc_cus_kode=b.cus_kode'
+ ' INNER JOIN tsalesman ON sls_kode=sc_sls_kode'
+ ' AND sls_nama='+Quot(edtNama.Text)
//+ ' UNION ALL'
//+ ' SELECT sc_cus_kode Kode,"KRM" Cabang,cus_nama,('
//+ ' select'
//+ ' sum(fpd_qty*(((100-fpd_discpr)*fpd_harga/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)-'
//+ ' ((fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)/100)+fpd_bp_rp)))'
//+ ' from krm.tfp_dtl'
//+ ' inner join krm.tfp_hdr on fp_nomor =fpd_fp_nomor'
//+ ' inner join krm.tsalescustomer on fp_cus_kode=SC_cus_kode'
//+ ' inner join krm.tcustomer on sc_cus_kode=cus_kode'
//+ ' inner join krm.tbarang on brg_kode=fpd_brg_kode'
//+ ' INNER JOIN krm.tprodukmarketing_dtl ON fpd_brg_kode=pmd_brg_kode'
//+ ' INNER JOIN krm.tprodukmarketing_hdr ON pmh_nomor=pmd_pmh_nomor'
//+ ' INNER JOIN krm.tsalesman ON sls_kode=sc_sls_kode'
//+ ' WHERE sls_nama='+Quot(edtNama.Text)
//+ ' and fp_tanggal between '+ QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
//+ ' AND  cus_kode =a.sc_cus_kode'
//+ ' GROUP BY cus_kode'
//+ ' ) Nilai'
//+ ' ,(SELECT COUNT(distinct DATE_FORMAT(TANGGAL,"%Y/%m/%d")) FROM tkunjungan INNER JOIN krm.tsalesman ON sls_nama=user'
//+ ' WHERE cus_kode=a.sc_cus_kode'
//+ ' AND tanggal between '+ QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
//+ ' AND user='+Quot(edtnama.Text)+') Kunjungan'
//+ ' FROM krm.tsalescustomer a INNER JOIN krm.tcustomer b ON'
//+ ' a.sc_cus_kode=b.cus_kode'
//+ ' INNER JOIN krm.tsalesman  ON sls_kode=sc_sls_kode'
//+ ' AND sls_nama='+Quot(edtNama.Text)
+ ' ) finala order by Kode ';

  Self.SQLDetail :='select Kode,brg_nama Nama,sum(fpd_qty) Qty from ( '
                + ' select fp_cus_kode Kode,fpd_brg_Kode,brg_nama , fpd_qty '
                + ' from tfp_dtl inner join tfp_hdr on fp_nomor =fpd_fp_nomor '
                + ' inner join tbarang on brg_kode=fpd_brg_kode and brg_isproductfocus=1 '
                + ' where fp_tanggal between '+ QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
//                + ' union '
//                + ' select fp_cus_kode Kode,fpd_brg_Kode,brg_nama , fpd_qty '
//                + ' from krm.tfp_dtl inner join krm.tfp_hdr on fp_nomor =fpd_fp_nomor '
//                + ' inner join krm.tbarang on brg_kode=fpd_brg_kode and brg_isproductfocus=1 '
//                + ' where fp_tanggal between '+ QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                + ' ) final group by kode,brg_nama order by Kode';
    Self.MasterKeyField := 'Kode';

   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=200;
    cxGrdMaster.Columns[3].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[3].Summary.FooterFormat:='###,###,###,###';

end;

procedure TfrmLapKunjunganMarketing.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmLapKunjunganMarketing.cxButton1Click(Sender: TObject);
var
  frmCostCenter: TfrmCostCenter;
begin
  inherited;
  If CDSMaster.FieldByname('KODE').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master CostCenter' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmCostCenter  := frmmenu.ShowForm(TfrmCostCenter) as TfrmCostCenter;
      frmCostCenter.ID := CDSMaster.FieldByname('KODE').AsString;
      frmCostCenter.FLAGEDIT := True;
      frmCostCenter.edtKode.Text := CDSMaster.FieldByname('KODE').AsString;
      frmCostCenter.loaddata(CDSMaster.FieldByname('KODE').AsString);
      frmCostCenter.edtKode.Enabled := False;
   end;
   frmCostCenter.Show;
end;

procedure TfrmLapKunjunganMarketing.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmLapKunjunganMarketing.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmCostCenter') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tCostCenter '
        + ' where cc_kode = ' + quot(CDSMaster.FieldByname('KODE').AsString) + ';' ;
        EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);


      CDSMaster.Delete;
   except
     MessageDlg('Gagal Hapus',mtError, [mbOK],0);
     
     Exit;
   end;
    

end;

procedure TfrmLapKunjunganMarketing.edtKodeClickBtn(Sender: TObject);
begin
  inherited;
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

end.
