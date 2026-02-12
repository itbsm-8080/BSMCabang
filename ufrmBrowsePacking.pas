unit ufrmBrowseKoreksiStok;

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
  TfrmBrowseKoreksiStok = class(TfrmCxBrowse)
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseKoreksiStok: TfrmBrowseKoreksiStok;

implementation
   uses ufrmKoreksiStok,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseKoreksiStok.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select korh_nomor Nomor,korh_Tanggal Tanggal ,b.gdg_nama Gudang,'
                  + ' korh_notes Keterangan,korh_total Total'
                  + ' from tkor_hdr  a '
                  + ' inner join  tgudang b on b.gdg_kode=a.korh_gdg_kode '
                  + ' where korh_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by korh_nomor ,korh_tanggal ,korh_notes ';

  Self.SQLDetail := 'select korh_nomor Nomor,kord_brg_kode Kode , brg_nama Nama,kord_expired Expired,'
                    + ' kord_satuan Satuan,kord_qty QtyKorksi,'
                    + ' kord_nilai Nilai'
                    + ' from tkor_dtl'
                    + ' inner join tkor_hdr on korh_nomor=kord_korh_nomor'
                    + ' inner join tbarang on kord_brg_kode=brg_kode'
                    + ' where korh_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by korh_nomor ,kord_nourut';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=200;
    cxGrdMaster.Columns[4].Width :=80;


    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

    cxGrdMaster.Columns[4].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[4].Summary.FooterFormat:='###,###,###,###';
    if frmmenu.KDUSER <> 'FINANCE' then
    cxGrdMaster.Columns[4].Visible := False;

end;

procedure TfrmBrowseKoreksiStok.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;


procedure TfrmBrowseKoreksiStok.cxButton2Click(Sender: TObject);
var
  frmKoreksiStok: TfrmKoreksiStok;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Koreksi Stok' then
   begin
      frmkoreksiStok  := frmmenu.ShowForm(TfrmKoreksiStok) as TfrmKoreksiStok;
      frmKoreksiStok.edtNomor.Text := frmKoreksiStok.getmaxkode;
   end;
   frmKoreksiStok.Show;
end;

procedure TfrmBrowseKoreksiStok.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseKoreksiStok.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmKoreksiStok.doslip(CDSMaster.FieldByname('Nomor').AsString);
end;

end.
