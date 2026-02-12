unit ufrmBrowseSetingPacking;

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
  TfrmBrowseSetingPacking = class(TfrmCxBrowse)
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
  frmBrowseSetingPacking: TfrmBrowseSetingPacking;

implementation
   uses ufrmSetingPacking, Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseSetingPacking.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := ' select pck_nomor Nomor,pck_brg_kode Kode,pck_nama Nama'
                  + ' from tpacking_hdr ';

  Self.SQLDetail := ' select pckd_pck_nomor Nomor,pckd_brg_kode Kode,brg_nama Nama,pckd_qty Qty'
                  + ' from tpacking_dtl'
                  + ' inner join tbarang on brg_kode=pckd_brg_kode '
                  + ' order by pckd_pck_nomor ';
  Self.MasterKeyField := 'Nomor';

  inherited;
  cxGrdMaster.ApplyBestFit();
  cxGrdMaster.Columns[0].Width := 80;
  cxGrdMaster.Columns[1].Width := 80;
  cxGrdMaster.Columns[2].Width := 200;
end;

procedure TfrmBrowseSetingPacking.FormShow(Sender: TObject);
begin
  ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseSetingPacking.cxButton2Click(Sender: TObject);
var
  frmsetingpacking: Tfrmsetingpacking;
begin
  inherited;
  if ActiveMDIChild.Caption <> 'Pemsetingan Biaya Promosi' then
  begin
    frmsetingpacking := frmmenu.ShowForm(Tfrmsetingpacking) as Tfrmsetingpacking;
    if frmsetingpacking.FLAGEDIT = False then
      frmsetingpacking.edtNomor.Text := frmsetingpacking.getmaxkode;
  end;

  frmsetingpacking.Show;
end;

procedure TfrmBrowseSetingPacking.cxButton1Click(Sender: TObject);
var
  frmsetingpacking: Tfrmsetingpacking;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  
  if ActiveMDIChild.Caption <> 'Pemsetingan Biaya Promosi' then
  begin
    //      ShowForm(TfrmBrowseBarang).Show;
    frmsetingpacking := frmmenu.ShowForm(Tfrmsetingpacking) as Tfrmsetingpacking;
    frmsetingpacking.ID := CDSMaster.FieldByname('Nomor').AsString;
    frmsetingpacking.FLAGEDIT := True;
    frmsetingpacking.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
    frmsetingpacking.loaddataall(CDSMaster.FieldByname('Nomor').AsString);
  end;
  
  frmsetingpacking.Show;
end;

procedure TfrmBrowseSetingPacking.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

end.
