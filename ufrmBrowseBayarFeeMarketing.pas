unit ufrmBrowseBayarFeeMarketing;

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
  dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, FMTBcd, Provider, SqlExpr, ImgList,
  ComCtrls, StdCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels;

type
  TfrmBrowseBayarFeeMarketing = class(TfrmCxBrowse)
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseBayarFeeMarketing: TfrmBrowseBayarFeeMarketing;

implementation
   uses ufrmBayarFeeMarketing, Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseBayarFeeMarketing.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select byf_nomor Nomor, byf_tanggal Tanggal, cus_nama Customer, '
                  + ' (select distinct sla_nama from tbayarfm_dtl '
                  + ' inner join tfp_hdr on byfd_fp_nomor=fp_nomor '
                  + ' inner join tdo_hdr on do_nomor=fp_do_nomor '
                  + ' inner join tso_hdr on do_so_nomor=so_nomor '
                  + ' inner join tsalesmanaktif on sla_sls_kode=so_sls_kode '
                  + ' where byfd_byf_nomor=a.byf_nomor limit 1) Salesman,'
                  + ' byf_nilai Nilai,'
                  + ' (select rek_nama from trekening where rek_kode=a.byf_rek_kode) Rekening, '
                  + ' byf_keterangan Keterangan '
                  + ' from Tbayarfm_hdr a'
                  + ' inner join tcustomer on cus_kode=byf_cus_kode'
                  + ' where byf_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime);



  Self.SQLDetail := 'select byf_nomor Nomor, byfd_fp_nomor Invoice, fp_tanggal Tgl_Invoice, fp_jthtempo JthTempo, byfd_bayar Bayar '
                    + ' from tbayarfm_dtl'
                    + ' inner join tbayarfm_hdr on byfd_byf_nomor = byf_nomor'
                    + ' inner join tfp_hdr on byfd_fp_nomor=fp_nomor'
                    + ' where byf_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by byf_nomor ';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=80;
    cxGrdMaster.Columns[3].Width :=200;
    cxGrdMaster.Columns[4].Width :=200;
    cxGrdMaster.Columns[4].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[4].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[5].Width :=80;
    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;
    cxGrdMaster.Columns[6].Width :=200;

end;

procedure TfrmBrowseBayarFeeMarketing.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseBayarFeeMarketing.cxButton2Click(Sender: TObject);
var
  frmbayarfeemarketing: TfrmBayarFeeMarketing;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Pembayaran Fee Marketing' then
   begin
      frmbayarfeemarketing  := frmmenu.ShowForm(TfrmBayarFeeMarketing) as TfrmBayarFeeMarketing;
      if frmbayarfeemarketing.FLAGEDIT =False then
      frmbayarfeemarketing.edtNomor.Text := frmbayarfeemarketing.getmaxkode;
   end;
   frmbayarfeemarketing.Show;
end;

procedure TfrmBrowseBayarFeeMarketing.cxButton1Click(Sender: TObject);
var
  frmbayarfeemarketing: TfrmBayarFeeMarketing;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Pembayaran Biaya Promosi' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmbayarfeemarketing  := frmmenu.ShowForm(TfrmBayarFeeMarketing) as TfrmBayarFeeMarketing;
      frmbayarfeemarketing.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmbayarfeemarketing.FLAGEDIT := True;
      frmbayarfeemarketing.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmbayarfeemarketing.loaddataall(CDSMaster.FieldByname('Nomor').AsString);

   end;
   frmbayarfeemarketing.Show;
end;

procedure TfrmBrowseBayarFeeMarketing.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseBayarFeeMarketing.cxButton3Click(Sender: TObject);
begin
  inherited;
 frmbayarfeemarketing.doslip(CDSMaster.FieldByname('Nomor').AsString);
end;

end.
