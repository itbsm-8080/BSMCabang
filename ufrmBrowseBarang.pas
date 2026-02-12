unit ufrmBrowseBarang;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, AdvEdit, MyAccess;

type
  TfrmBrowseBarang = class(TfrmCxBrowse)
    cxButton5: TcxButton;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    cxButton9: TcxButton;
    OpenDialog1: TOpenDialog;
    edtNama: TAdvEdit;
    Label3: TLabel;
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
    procedure cxButton9Click(Sender: TObject);
    procedure bacafile2;

  private
    connpusat : TMyConnection;
    ahost2,auser2,apassword2,adatabase2 : string;
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

  Self.SQLMaster := 'select *,stok_baik/Avgs_Sales_per_Bulan TOR from (select brg_kode Kode ,brg_nama Nama,brg_satuan Satuan,ktg_nama Kategori,'
  + ' gr_nama Tipe,brg_hrgjual HargaJual,'
  + ' (select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_brg_kode=brg_kode) Stok,'
  + ' brg_min_stok Min,brg_disc_sales Disc_Salesman,brg_merk Merk,brg_isproductfocus Product_Focus, '
  + ' (select mst_tanggal from tmasterstok where mst_brg_kode=brg_kode and mst_noreferensi like "%DO%" ORDER BY mst_tanggal desc limit 1 ) Last_Sale ,'
  + ' (select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_brg_kode=brg_kode and mst_gdg_kode="WH-01") Stok_Baik,'
  + ' (SELECT ifnull(SUM(fpd_qty),0)/3 FROM tfp_dtl inner join tfp_hdr on fp_nomor=fpd_fp_nomor   '
  + ' WHERE fpd_brg_kode=brg_kode AND fp_tanggal >= DATE_ADD(now() , INTERVAL -90 DAY)) Avgs_Sales_per_Bulan '
+ ' from tbarang '
+ ' inner join tkategori on ktg_kode=brg_ktg_kode'
+ ' inner join tgroup on gr_kode=brg_gr_kode'
+ ' where brg_nama like '+Quot('%'+edtNama.Text+'%')
+ ' ) final ';


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
//  btnRefreshClick(Self);
  bacafile2;
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


procedure TfrmBrowseBarang.cxButton9Click(Sender: TObject);
var
  ss,s:String;
  i:integer;
  tsql:TmyQuery;
  tt:TStrings;
begin
  inherited;

  connpusat := xCreateConnection(ctMySQL,aHost2,aDatabase2,auser2,apassword2);
  s:='SELECT brg_kode,brg_nama,brg_satuan,brg_ktg_kode,brg_gr_kode,brg_gdg_default,brg_isstok,brg_isexpired,brg_isaktif,brg_isproductfocus,date_create'
      + ' FROM bsm.tbarang WHERE date_create > '+quotd(startdate.Date);
  tsql :=  xOpenQuery(s,connpusat);
  tt := TStringList.Create;
  with tsql do
  begin
    try
      while not eof do
      begin
        ss:='INSERT ignore INTO tbarang (brg_kode,brg_nama,brg_satuan,brg_ktg_kode,brg_gr_kode,'
        + ' brg_gdg_default,brg_isstok,brg_isexpired,brg_isaktif,brg_isproductfocus,date_create)'
        + ' values ('
        + Quot(fieldbyname('brg_kode').AsString)+','
        + Quot(fieldbyname('brg_nama').AsString)+','
        + Quot(fieldbyname('brg_satuan').AsString)+','
        + Quot(fieldbyname('brg_ktg_kode').AsString)+','
        + Quot(fieldbyname('brg_gr_kode').AsString)+','
        + Quot(fieldbyname('brg_gdg_default').AsString)+','
        + inttostr(fieldbyname('brg_isstok').AsInteger)+','
        + inttostr(fieldbyname('brg_isexpired').AsInteger)+','
        + inttostr(fieldbyname('brg_isaktif').AsInteger)+','
        + inttostr(fieldbyname('brg_isproductfocus').AsInteger)+','
        + Quotd(fieldbyname('date_create').Asdatetime)+');';

        tt.append(ss);
        next;
      end;
    finally
      free;
    end;
  end;

  try
        for i:=0 to tt.Count -1 do
        begin
            EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, tt[i]);
        end;
      finally
        tt.Free;
      end;
      
end;


procedure TfrmBrowseBarang.bacafile2;
var
s:string;
tsql:TmyQuery;

 begin
   s:='select ahost,adatabase,auser,apassword from tsetingdb where nama like '+Quot('default1') +';';
   tsql:=xOpenQuery(s,frmmenu.conn);
//   ltemp := TStringList.Create;
//   ltemp.loadfromfile(ExtractFileDir(application.ExeName) + '\' + 'default3.cfg');
  with tsql do
  begin
    try
       aHost2     := fields[0].AsString;
       aDatabase2 := fields[1].AsString;
       auser2     := fields[2].AsString;
       apassword2 := fields[3].AsString;

    finally
      free;
    end;
  end;

 end;



end.
