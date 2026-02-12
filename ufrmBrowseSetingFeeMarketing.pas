unit ufrmBrowseSetingFeeMarketing;

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
  TfrmBrowseSetingFeeMarketing = class(TfrmCxBrowse)
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseSetingFeeMarketing: TfrmBrowseSetingFeeMarketing;

implementation
   uses ufrmsetingfeemarketing,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseSetingFeeMarketing.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select fmh_nomor Nomor,fmh_cus_kode Kode ,cus_nama Customer '
                  + 'from tfeemarketing_hdr inner join tcustomer on cus_kode=fmh_cus_kode '
                  + 'order by fmh_nomor ';

  Self.SQLDetail := 'select fmd_fmh_nomor Nomor,fmd_brg_kode Kode,brg_nama Nama,ktg_nama Kategori,fmd_persen Persen,fmd_rupiah Rupiah'
                    + ' from tfeemarketing_dtl'
                    + ' inner join tbarang on brg_kode=fmd_brg_kode '
                    + ' inner join tkategori on ktg_kode=brg_ktg_kode '
                    + ' order by fmd_fmh_nomor ';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=80;
    cxGrdMaster.Columns[1].Width :=80;
    cxGrdMaster.Columns[2].Width :=200;


end;

procedure TfrmBrowseSetingFeeMarketing.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseSetingFeeMarketing.cxButton2Click(Sender: TObject);
var
  frmsetingfeemarketing: Tfrmsetingfeemarketing;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Setting Fee Marketing' then
   begin
      frmsetingfeemarketing  := frmmenu.ShowForm(Tfrmsetingfeemarketing) as Tfrmsetingfeemarketing;
      if frmsetingfeemarketing.FLAGEDIT = False then
      frmsetingfeemarketing.edtNomor.Text := frmsetingfeemarketing.getmaxkode;
   end;
   frmsetingfeemarketing.Show;
end;

procedure TfrmBrowseSetingFeeMarketing.cxButton1Click(Sender: TObject);
var
  frmsetingfeemarketing: Tfrmsetingfeemarketing;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Setting Fee Marketing' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmsetingfeemarketing  := frmmenu.ShowForm(Tfrmsetingfeemarketing) as Tfrmsetingfeemarketing;
      frmsetingfeemarketing.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmsetingfeemarketing.FLAGEDIT := True;
      frmsetingfeemarketing.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmsetingfeemarketing.loaddataall(CDSMaster.FieldByname('Nomor').AsString);

   end;
   frmsetingfeemarketing.Show;
end;

procedure TfrmBrowseSetingFeeMarketing.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

end.
