unit ufrmBrowseSubBarangPF;

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
  TfrmBrowseSubBarangPF = class(TfrmCxBrowse)
    Label3: TLabel;
    ComboBox1: TComboBox;
    cxButton5: TcxButton;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseSubBarangPF: TfrmBrowseSubBarangPF;

implementation
   uses Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseSubBarangPF.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select kode_grouppf Kode ,nama_grouppf Nama,nama_deptpf Departemen,hna_grouppf HNA,a.kode_deptpf dept_id'
  + '  from tgrouppf a inner join tdeptpf b on a.kode_deptpf=b.kode_deptpf' ;

   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=200;
end;

procedure TfrmBrowseSubBarangPF.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  combobox1.ItemIndex := 2;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseSubBarangPF.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseSubBarangPF.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmSubBarangpf') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tgrouppf '
        + ' where kode_grouppf = ' + quot(CDSMaster.FieldByname('KODE').AsString) + ';' ;
        EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);


      CDSMaster.Delete;
   except
     MessageDlg('Gagal Hapus',mtError, [mbOK],0);
     
     Exit;
   end;
    

end;

procedure TfrmBrowseSubBarangPF.ComboBox1Change(Sender: TObject);
begin
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseSubBarangPF.cxButton5Click(Sender: TObject);
var
  s:string;
  tt:TStrings;
begin
  inherited;
  if savedlg.Execute then
  begin
      CDSMaster.First;
      CDSMaster.Filter := cxGrdMaster.DataController.Filter.FilterText;
      CDSMaster.Filtered := True;
      tt := TStringList.Create;

      with CDSMaster do
      begin
        s:=' delete from tgrouppf ;';
          tt.Append(s);
        First;
        while not Eof do
        begin
           s:='insert into tgrouppf (kode_grouppf,nama_grouppf,kode_deptpf,hna_grouppf)'
           + ' values ('
           + IntToStr(fieldbyname('kode').asinteger)+','
           + quot(fieldbyname('nama').AsString)+','
           + Quot(fieldbyname('dept_id').AsString)+','
           + FloatToStr(fieldbyname('hna').Asfloat)+');';
           tt.Append(s);

           Next;
        end;
      end;
      tt.SaveToFile(savedlg.FileName);
  end;

end;

end.
