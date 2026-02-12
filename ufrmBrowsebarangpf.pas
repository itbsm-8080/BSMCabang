unit ufrmBrowseBarangPF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmCxBrowse, Menus, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, FMTBcd, Provider, SqlExpr, ImgList,
  ComCtrls, StdCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels;

type
  TfrmBrowseBarangPF = class(TfrmCxBrowse)
    cxButton5: TcxButton;
    OpenDialog1: TOpenDialog;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseBarangPF: TfrmBrowseBarangPF;

implementation
   uses Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseBarangPF.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := ' select '
                  + ' bpf_periode Periode, bpf_tahun Tahun, bpf_brg_kode Kode, bpf_nama Nama, bpf_grup Grup,bpf_het Het,bpf_dept Dept,bpf_hna HNA'
                  + ' from tbarangpf';
  inherited;
  cxGrdMaster.ApplyBestFit();
  cxGrdMaster.Columns[0].Width := 100;
  cxGrdMaster.Columns[1].Width := 100;
end;

procedure TfrmBrowseBarangPF.FormShow(Sender: TObject);
begin
  ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseBarangPF.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseBarangPF.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
  try
  if not cekdelete(frmMenu.KDUSER,'frmGudang') then
  begin
    MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
    Exit;
  End;

  if MessageDlg('Yakin ingin hapus ?',mtCustom,
                        [mbYes,mbNo], 0)= mrNo
  then Exit ;

  s := 'delete from tsetingbarangpf '
     + ' where set_periode = ' + quot(CDSMaster.FieldByname('periode').AsString)
     + ' and set_tahun = ' + quot(CDSMaster.FieldByname('tahun').AsString)+';' ;
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  //      CDSMaster.Delete;
  except
    MessageDlg('Gagal Hapus',mtError, [mbOK],0);
    Exit;
  end;
    
  btnRefreshClick(self);
end;

procedure TfrmBrowseBarangPF.cxButton5Click(Sender: TObject);
var
  s:string;
  tt :TStrings;
   i:integer;
begin
  inherited;
  if OpenDialog1.Execute then
  begin
  tt:=TStringList.Create;
  tt.LoadFromFile(OpenDialog1.FileName);
   try
    try
        for i:=0 to tt.Count -1 do
        begin
            EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, tt[i]);
        end;
      finally
        tt.Free;
      end;
   except
     ShowMessage('gagal import');
     
     Exit;
   end;

    
    ShowMessage('Import data berhasil');


  end;
end;
end.
