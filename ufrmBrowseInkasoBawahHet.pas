unit ufrmBrowseInkasoBawahHet;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, AdvCombo;

type
  TfrmBrowseInkasoBawahHet = class(TfrmCxBrowse)
    Label3: TLabel;
    cbbbulan: TAdvComboBox;
    Label4: TLabel;
    edtTahun: TComboBox;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseInkasoBawahHet: TfrmBrowseInkasoBawahHet;

implementation
   uses ufrmPenerimaanLain,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseInkasoBawahHet.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := ' SELECT Noreferensi,sls_nama Salesman,kredit Bayar,tanggal Tgl_Bayar,fp_tanggal Tanggal_Faktur, DATEDIFF(tanggal,fp_tanggal) SelisihHari, ('
+ '  SELECT sum(fpd_harga*(100-fpd_discpr)/100 *fpd_qty)'
+ ' FROM tfp_dtl'
+ ' INNER JOIN tfp_hdr ON fp_nomor=fpd_fp_nomor '
+ ' INNER JOIN tdo_hdr ON do_nomor=fp_do_nomor'
+ ' INNER JOIN tso_hdr ON so_nomor= do_so_nomor'
+ ' INNER JOIN tsalesman ON sls_kode=so_sls_kode'
+ ' INNER JOIN tbarang ON brg_kode=fpd_brg_kode'
+ ' INNER JOIN tcustomer ON fp_cus_kode=cus_kode'
+ ' WHERE fpd_fp_nomor =noreferensi AND'
+ ' fpd_hrg_min > 0 AND brg_isproductfocus=1 AND (fpd_harga*(100-fpd_discpr)/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)- (((100-fpd_discpr)*fpd_harga/100)*fpd_bp_pr/100)-fpd_bp_rp < fpd_hrg_min ) *(kredit/fp_amount) pengurang,'
+ ' (select cus_nama from tcustomer where cus_kode=a.fp_cus_kode limit 1) Customer' 
+ ' FROM kartu_piutang a'
+ ' INNER JOIN tsalesman ON sls_kode=salesman'
+ ' INNER JOIN tfp_hdr ON fp_nomor=noreferensi'
+ ' WHERE MONTH(tanggal)='+inttostr(cbbbulan.ItemIndex+1)+' AND YEAR(tanggal)=' + edtTahun.Text
+ ' AND nomor LIKE "%CR%"'
+ ' HAVING pengurang > 0'
+ ' order by noreferensi ';


  Self.SQLDetail := 'SELECT fpd_fp_nomor Noreferensi ,brg_nama,fpd_qty,(fpd_harga*(100-fpd_discpr)/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)- (((100-fpd_discpr)*fpd_harga/100)*fpd_bp_pr/100)-fpd_bp_rp Net,'
+ ' fpd_hrg_min HET'
+ ' FROM tfp_dtl'
+ ' INNER JOIN tfp_hdr ON fp_nomor=fpd_fp_nomor'
+ ' INNER JOIN tdo_hdr ON do_nomor=fp_do_nomor'
+ ' INNER JOIN tso_hdr ON so_nomor= do_so_nomor'
+ ' INNER JOIN tsalesman ON sls_kode=so_sls_kode'
+ ' INNER JOIN tbarang ON brg_kode=fpd_brg_kode'
+ ' INNER JOIN tcustomer ON fp_cus_kode=cus_kode'
+ ' WHERE fpd_hrg_min > 0 AND brg_isproductfocus=1'
+ ' AND (fpd_harga*(100-fpd_discpr)/100)-(fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100)- (((100-fpd_discpr)*fpd_harga/100)*fpd_bp_pr/100)-fpd_bp_rp < fpd_hrg_min'
+ ' ORDER by fpd_fp_nomor';
 Self.MasterKeyField := 'Noreferensi';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=100;
    cxGrdMaster.Columns[2].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[2].Summary.FooterFormat:='###,###,###,###';

    cxGrdMaster.Columns[6].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[6].Summary.FooterFormat:='###,###,###,###';

    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseInkasoBawahHet.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseInkasoBawahHet.cxButton2Click(Sender: TObject);
var
  frmPenerimaanLain: TfrmPenerimaanLain;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Penerimaan Lain lain' then
   begin
      frmPenerimaanLain  := frmmenu.ShowForm(TfrmPenerimaanLain) as TfrmPenerimaanLain;
      if frmPenerimaanLain.FLAGEDIT= False then
      frmPenerimaanLain.edtNomor.Text := frmPenerimaanLain.getmaxkode;
   end;
   frmPenerimaanLain.Show;
end;

procedure TfrmBrowseInkasoBawahHet.cxButton1Click(Sender: TObject);
var
  frmPenerimaanLain: TfrmPenerimaanLain;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Penerimaan Lain lain' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmPenerimaanLain  := frmmenu.ShowForm(TfrmPenerimaanLain) as TfrmPenerimaanLain;
      frmPenerimaanLain.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmPenerimaanLain.FLAGEDIT := True;
      frmPenerimaanLain.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmPenerimaanLain.loaddataALL(CDSMaster.FieldByname('Nomor').AsString);
      if CDSMaster.FieldByname('IsClosed').AsString = 'Sudah' then
      begin
        ShowMessage('Transaksi ini sudah tutup Periode,Tidak dapat di edit');
        frmPenerimaanLain.cxButton2.Enabled :=False;
        frmPenerimaanLain.cxButton1.Enabled :=False;
      end;
   end;
   frmPenerimaanLain.Show;
end;

procedure TfrmBrowseInkasoBawahHet.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseInkasoBawahHet.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmPenerimaanLain.doslipmutasi(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowseInkasoBawahHet.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmPenerimaanLain') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;

      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
     s:='delete from tjurnalitem '
        + ' where jurd_jur_no = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
        EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

     s:='delete from tjurnal '
        + ' where jur_no = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
        EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);


      CDSMaster.Delete;
   except
     MessageDlg('Gagal Hapus',mtError, [mbOK],0);
     
     Exit;
   end;
    

end;

end.
