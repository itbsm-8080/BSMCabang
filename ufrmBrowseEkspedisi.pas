unit ufrmBrowseEkspedisi;

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
  TfrmBrowseEkspedisi = class(TfrmCxBrowse)
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
  frmBrowseEkspedisi: TfrmBrowseEkspedisi;

implementation
   uses ufrmEkspedisi,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseEkspedisi.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'SELECT ekspedisi_id, ekspedisi_nama FROM tekspedisi';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=200;
end;

procedure TfrmBrowseEkspedisi.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseEkspedisi.cxButton2Click(Sender: TObject);
var
  frmEkspedisi: TfrmEkspedisi;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master Ekspedisi' then
   begin
      frmEkspedisi  := frmmenu.ShowForm(TfrmEkspedisi) as TfrmEkspedisi;
//      frmEkspedisi.edtIdEkspedisi.Text := frmEkspedisi.getmaxkode;
//      frmEkspedisi.edtIdEkspedisi.Enabled :=false;
      frmEkspedisi.edtNamaEkspedisi.setfocus;
   end;
   frmEkspedisi.Show;
end;

procedure TfrmBrowseEkspedisi.cxButton1Click(Sender: TObject);
var
  frmEkspedisi: TfrmEkspedisi;
begin
  inherited;
  If CDSMaster.FieldByname('ekspedisi_id').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master Ekspedisi' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmEkspedisi  := frmmenu.ShowForm(TfrmEkspedisi) as TfrmEkspedisi;
      frmEkspedisi.ID := CDSMaster.FieldByname('ekspedisi_id').AsString;
      frmEkspedisi.FLAGEDIT := True;
      frmEkspedisi.edtIdEkspedisi.Text := CDSMaster.FieldByname('ekspedisi_id').AsString;
      frmEkspedisi.loaddata(CDSMaster.FieldByname('ekspedisi_id').AsString);
//      frmEkspedisi.edtIdEkspedisi.Enabled := False;
      frmEkspedisi.edtNamaEkspedisi.setfocus;
   end;
   frmEkspedisi.Show;
end;

procedure TfrmBrowseEkspedisi.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseEkspedisi.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmEkspedisi') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tekspedisi '
        + ' where ekspedisi_id = ' + quot(CDSMaster.FieldByname('ekspedisi_id').AsString) + ';' ;
        EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);


      CDSMaster.Delete;
   except
     MessageDlg('Gagal Hapus',mtError, [mbOK],0);
     
     Exit;
   end;
    

end;

end.
