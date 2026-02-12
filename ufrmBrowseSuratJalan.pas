unit ufrmBrowseSuratJalan;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, frxClass,
  frxDMPExport;

type
  TfrmBrowseSuratJalan = class(TfrmCxBrowse)
    PopupMenu1: TPopupMenu;
    UpdateStatusKembali1: TMenuItem;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    cxButton5: TcxButton;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxGrdMasterStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseSuratJalan: TfrmBrowseSuratJalan;

implementation
   uses ufrmsuratjalan,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseSuratJalan.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select sj_nomor Nomor,sj_tanggal Tanggal ,sj_keterangan Keterangan '
                  + ' from tsj_hdr'
                  + ' where sj_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by sj_nomor ,sj_tanggal';

  Self.SQLDetail := 'select sj_nomor Nomor,brg_kode Kode , brg_nama Nama,sjd_satuan Satuan,sjd_qty Jumlah'
                    + ' from tsj_dtl'
                    + ' inner join tsj_hdr on sjd_sj_nomor =sj_nomor'
                    + ' inner join tbarang on sjd_brg_kode=brg_kode'
                    + ' where sj_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by sj_nomor' ;
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;


    cxGrdDetail.Columns[2].Width :=200;


end;

procedure TfrmBrowseSuratJalan.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseSuratJalan.cxButton2Click(Sender: TObject);
var
  frmsuratjalan: Tfrmsuratjalan;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Tanda Terima' then
   begin
      frmsuratjalan  := frmmenu.ShowForm(Tfrmsuratjalan) as Tfrmsuratjalan;
      if frmsuratjalan.FLAGEDIT = False then
      frmsuratjalan.edtNomor.Text := frmsuratjalan.getmaxkode;
   end;
   frmsuratjalan.Show;
end;

procedure TfrmBrowseSuratJalan.cxButton1Click(Sender: TObject);
var
  frmsuratjalan: Tfrmsuratjalan;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Surat Jalan' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmsuratjalan  := frmmenu.ShowForm(Tfrmsuratjalan) as Tfrmsuratjalan;
      frmsuratjalan.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmsuratjalan.FLAGEDIT := True;
      frmsuratjalan.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmsuratjalan.loaddataall(CDSMaster.FieldByname('Nomor').AsString);

   end;
   frmsuratjalan.Show;
end;

procedure TfrmBrowseSuratJalan.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseSuratJalan.cxButton5Click(Sender: TObject);
begin
  inherited;
    frmsuratjalan.doslip(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowseSuratJalan.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmSuratJalan') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;

      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tsj_dtl '
        + ' where sjd_sj_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
        EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

       s:='delete from tsj_hdr '
        + ' where sj_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
        EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);


      CDSMaster.Delete;
   except
     MessageDlg('Gagal Hapus',mtError, [mbOK],0);
     
     Exit;
   end;
    

end;

procedure TfrmBrowseSuratJalan.cxGrdMasterStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  AColumn : TcxCustomGridTableItem;
begin
  AColumn := (Sender as TcxGridDBTableView).GetColumnByFieldName('Kembali');

  if (AColumn <> nil)  and (ARecord <> nil) and (AItem <> nil) and
     (cVarToFloat(ARecord.Values[AColumn.Index]) > 0) then
    AStyle := cxStyle1;
end;

end.
