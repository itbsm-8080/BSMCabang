unit ufrmBrowseJenisKendaraan;

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
  TfrmBrowseJenisKendaraan = class(TfrmCxBrowse)
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
  frmBrowseJenisKendaraan: TfrmBrowseJenisKendaraan;

implementation
   uses ufrmJenisKendaraan,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseJenisKendaraan.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'SELECT kend_nopol, kend_merk, kend_tipe, kend_bagian, kend_pic, kend_cabang FROM tkendaraan';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=200;
end;

procedure TfrmBrowseJenisKendaraan.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseJenisKendaraan.cxButton2Click(Sender: TObject);
var
  frmJenisKendaraan: TfrmJenisKendaraan;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master Cost Center' then
   begin
      frmJenisKendaraan  := frmmenu.ShowForm(TfrmJenisKendaraan) as TfrmJenisKendaraan;
//      frmJenisKendaraan.edtKode.Text := frmJenisKendaraan.getmaxkode;
//      frmJenisKendaraan.edtKode.Enabled :=false;
      frmJenisKendaraan.edtNopol.setfocus;
   end;
   frmJenisKendaraan.Show;
end;

procedure TfrmBrowseJenisKendaraan.cxButton1Click(Sender: TObject);
var
  frmJenisKendaraan: TfrmJenisKendaraan;
begin
  inherited;
  If CDSMaster.FieldByname('kend_nopol').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master Jenis Customer' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmJenisKendaraan  := frmmenu.ShowForm(TfrmJenisKendaraan) as TfrmJenisKendaraan;
      frmJenisKendaraan.ID := CDSMaster.FieldByname('kend_nopol').AsString;
      frmJenisKendaraan.FLAGEDIT := True;
      frmJenisKendaraan.edtNopol.Text := CDSMaster.FieldByname('kend_nopol').AsString;
      frmJenisKendaraan.loaddata(CDSMaster.FieldByname('kend_nopol').AsString);
//      frmJenisKendaraan.edtNopol.Enabled := False;
      frmJenisKendaraan.edtNopol.setfocus;
   end;
   frmJenisKendaraan.Show;
end;

procedure TfrmBrowseJenisKendaraan.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseJenisKendaraan.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmJenisKendaraan') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tkendaraan '
        + ' where kend_nopol = ' + quot(CDSMaster.FieldByname('kend_nopol').AsString) + ';' ;
        EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);


      CDSMaster.Delete;
   except
     MessageDlg('Gagal Hapus',mtError, [mbOK],0);
     
     Exit;
   end;
    

end;

end.
