unit ufrmBrowseSetingJadwalSales;

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
  TfrmBrowseSetingJadwalSales = class(TfrmCxBrowse)
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseSetingJadwalSales: TfrmBrowseSetingJadwalSales;

implementation
   uses ufrmSetingJadwalsales,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseSetingJadwalSales.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'SELECT jd_sls_kode,sls_nama salesman,jd_cus_kode,cus_nama customer,jd_namajadwal Nama'
              + ' FROM tjadwalsales INNER JOIN tsalesman ON sls_kode=jd_sls_kode'
              + ' INNER JOIN tcustomer ON cus_kode=jd_cus_kode';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=200;
end;

procedure TfrmBrowseSetingJadwalSales.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseSetingJadwalSales.cxButton2Click(Sender: TObject);
var
  frmSetingjadwalsales: TfrmSetingjadwalsales;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master Cost Center' then
   begin
      frmSetingjadwalsales  := frmmenu.ShowForm(TfrmSetingjadwalsales) as TfrmSetingjadwalsales;
      frmSetingjadwalsales.edtKode.SetFocus;
   end;
   frmSetingjadwalsales.Show;
end;

procedure TfrmBrowseSetingJadwalSales.cxButton1Click(Sender: TObject);
var
  frmSetingjadwalsales: TfrmSetingjadwalsales;
begin
  inherited;
  If CDSMaster.FieldByname('nama').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Seting Jadwal Sales' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmSetingjadwalsales  := frmmenu.ShowForm(TfrmSetingjadwalsales) as TfrmSetingjadwalsales;

      frmSetingjadwalsales.FLAGEDIT := True;

   end;
   frmSetingjadwalsales.Show;
end;

procedure TfrmBrowseSetingJadwalSales.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseSetingJadwalSales.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmSetingjadwalsales') then
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

end.
