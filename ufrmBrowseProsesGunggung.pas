unit ufrmBrowseProsesGunggung;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels;

type
  TfrmBrowseBarang = class(TfrmCxBrowse)
    cxButton5: TcxButton;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
    procedure cxGrdMasterStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseBarang: TfrmBrowseBarang;

implementation
   uses ufrmbarang,Ulib, MAIN, uModuleConnection,uFrmLihatGambar;
{$R *.dfm}

procedure TfrmBrowseBarang.btnRefreshClick(Sender: TObject);
begin

  Self.SQLMaster := 'select brg_kode Kode ,brg_nama Nama,brg_satuan Satuan,ktg_nama Kategori,'
  + ' gr_nama Tipe,brg_hrgjual HargaJual,'
  + ' (select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_brg_kode=brg_kode) Stok,'
  + ' brg_min_stok Min,brg_disc_sales Disc_Salesman,brg_merk Merk,brg_isproductfocus Product_Focus '
+ ' from tbarang '
+ ' inner join tkategori on ktg_kode=brg_ktg_kode'
+ ' inner join tgroup on gr_kode=brg_gr_kode';


Self.SQLDetail := 'select mst_brg_kode Kode,mst_gdg_kode KD_Gudang,gdg_nama Gudang,mst_expired_date Expired ,sum(mst_stok_in-mst_stok_out) stok from tmasterstok inner join tgudang on gdg_kode=mst_gdg_kode'
            + ' group by  mst_brg_kode,mst_gdg_kode,mst_expired_date ' ;
 Self.MasterKeyField := 'Kode';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=80;
    cxGrdMaster.Columns[1].Width :=200;
        cxGrdMaster.Columns[3].Width :=150;
        cxGrdMaster.Columns[5].Width :=80;
cxGrdMaster.Columns[6].Width :=80;

end;

procedure TfrmBrowseBarang.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseBarang.cxButton2Click(Sender: TObject);
var
  frmBarang: TfrmBarang;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master Barang' then
   begin
      frmBarang  := frmmenu.ShowForm(TfrmBarang) as TfrmBarang;
      frmBarang.edtKode.SetFocus;
      frmBarang.edtKode.Text := IntToStr(frmBarang.getmaxkode);
      frmBarang.cxLookupJenisGroup.EditValue := 1;
   end;
   frmBarang.Show;
end;

procedure TfrmBrowseBarang.cxButton1Click(Sender: TObject);
var
  frmBarang: TfrmBarang;
begin
  inherited;
  If CDSMaster.FieldByname('KODE').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master CostCenter' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmBarang  := frmmenu.ShowForm(TfrmBarang) as TfrmBarang;
      frmBarang.ID := CDSMaster.FieldByname('KODE').AsString;
      frmBarang.FLAGEDIT := True;
      frmBarang.edtKode.Text := CDSMaster.FieldByname('KODE').AsString;
      frmBarang.loaddata(CDSMaster.FieldByname('KODE').AsString);
      frmBarang.edtKode.Enabled := False;
   end;
   frmBarang.Show;
end;

procedure TfrmBrowseBarang.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseBarang.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmBarang') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tbarang '
        + ' where brg_kode = ' + quot(CDSMaster.FieldByname('KODE').AsString) + ';' ;
        EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);


      CDSMaster.Delete;
   except
     MessageDlg('Gagal Hapus',mtError, [mbOK],0);
     
     Exit;
   end;
    

end;

procedure TfrmBrowseBarang.cxButton5Click(Sender: TObject);
var
  KODEBARANG : string;
begin
  inherited;
  Application.CreateForm(TfrmLihatGambar,frmLihatGambar);
  frmLihatGambar.KODEBARANG := CDSMaster.FieldByname('KODE').AsString;
  frmLihatGambar.ShowModal;
end;

procedure TfrmBrowseBarang.cxGrdMasterStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  AColumn : TcxCustomGridTableItem;
  AColumn2 : TcxCustomGridTableItem;

begin
  AColumn := (Sender as TcxGridDBTableView).GetColumnByFieldName('Stok');
  AColumn2 := (Sender as TcxGridDBTableView).GetColumnByFieldName('Min');

  if (AColumn <> nil)  and (ARecord <> nil) and (AItem <> nil) and
     (cVarToFloat(ARecord.Values[AColumn.Index]) <= (cVarToFloat(ARecord.Values[AColumn2.Index]))) then
    AStyle := cxStyle2;
end;

end.
