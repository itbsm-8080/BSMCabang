unit ufrmBrowseSerahTerimaEkspedisi;

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
  TfrmBrowseSerahTerimaEkspedisi = class(TfrmCxBrowse)
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    OpenDialog1: TOpenDialog;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure bacafile2;
    procedure cxButton3Click(Sender: TObject);

  private
    connpusat : TSQLConnection;
    ahost2,auser2,apassword2,adatabase2 : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseSerahTerimaEkspedisi: TfrmBrowseSerahTerimaEkspedisi;

implementation
   uses ufrmSerahTerimaEkspedisi,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseSerahTerimaEkspedisi.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'SELECT ste_nomor Nomor, ste_tanggal Tanggal, ste_tanggal1 Tanggal1, '
                  + 'ste_tanggal2 Tanggal2, ste_serah Serah, ste_namaekspedisi Terima,  if(ste_realisasi=0,"Belum","Sudah") Realisasi, ste_keterangan Note '
                  + 'FROM tserahterimaekspedisi_hdr '
                  + 'WHERE ste_tanggal between ' + QuotD(startdate.Date) + ' and ' + QuotD(enddate.date) ;

  Self.SQLDetail := 'SELECT '
                  + '    sted_ste_nomor AS Nomor, '
                  + '    sted_fp_nomor AS NomorFP, '
                  + '    COALESCE(cus_nama, sted_cus_nama) AS Customer, '
                  + '    COALESCE(fp_tanggal, sted_tanggal) AS TanggalFP, '
                  + '    sted_nilai AS Nilai '
                  + 'FROM tserahterimaekspedisi_dtl '
                  + 'INNER JOIN tserahterimaekspedisi_hdr ON ste_nomor = sted_ste_nomor '
                  + 'LEFT JOIN tfp_hdr ON fp_nomor = sted_fp_nomor '
                  + 'LEFT JOIN tcustomer ON cus_kode = fp_cus_kode '
                  + 'WHERE ste_tanggal BETWEEN ' + QuotD(startdate.Date) + ' AND ' + QuotD(enddate.Date)
                  + 'ORDER BY NomorFP ASC';

  Self.MasterKeyField := 'Nomor';
  inherited;
  cxGrdMaster.ApplyBestFit();
  cxGrdMaster.Columns[0].Width := 150;
  cxGrdMaster.Columns[1].Width := 150;
  cxGrdMaster.Columns[2].Width := 150;
  cxGrdMaster.Columns[3].Width := 150;
  cxGrdMaster.Columns[4].Width := 150;
  cxGrdMaster.Columns[5].Width := 150;
  cxGrdMaster.Columns[6].Width := 150;
  cxGrdMaster.Columns[7].Width := 200;

  cxGrdDetail.Columns[0].Width := 150;
  cxGrdDetail.Columns[1].Width := 150;
  cxGrdDetail.Columns[2].Width := 250;
  cxGrdDetail.Columns[3].Width := 100;
  cxGrdDetail.Columns[4].Width := 150;
end;

procedure TfrmBrowseSerahTerimaEkspedisi.FormShow(Sender: TObject);
begin
  ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
  bacafile2;
end;

procedure TfrmBrowseSerahTerimaEkspedisi.cxButton2Click(Sender: TObject);
var
  frmserahterimaekspedisi: TfrmSerahTerimaEkspedisi;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Tagihan Ekspedisi' then
   begin
      frmserahterimaekspedisi  := frmmenu.ShowForm(TfrmSerahTerimaEkspedisi) as TfrmSerahTerimaEkspedisi;
      frmserahterimaekspedisi.startdate.SetFocus;
      frmserahterimaekspedisi.edtNomor.Text := frmserahterimaekspedisi.getmaxkode;
   end;
   frmserahterimaekspedisi.Show;
end;

//procedure TfrmBrowseTagihanEkspedisi.cxButton5Click(Sender: TObject);
//var
//  frmtagihanekspedisimanual: TfrmTagihanEkspedisiManual;
//begin
//  inherited;
//    if ActiveMDIChild.Caption <> 'Tagihan Ekspedisi Manual' then
//   begin
//      frmTagihanEkspedisiManual  := frmmenu.ShowForm(TfrmTagihanEkspedisiManual) as TfrmTagihanEkspedisiManual;
//      frmTagihanEkspedisiManual.startdate.SetFocus;
//      frmTagihanEkspedisiManual.edtNomor.Text := frmTagihanEkspedisiManual.getmaxkode;
//   end;
//   frmTagihanEkspedisiManual.Show;
//end;

procedure TfrmBrowseSerahTerimaEkspedisi.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseSerahTerimaEkspedisi.bacafile2;
var
s:string;
tsql: TmyQuery;

 begin
   s:='select ahost,adatabase,auser,apassword from tsetingdb where nama like '+Quot('default1') +';';
   tsql:=xOpenQuery(s, frmmenu.conn);
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

procedure TfrmBrowseSerahTerimaEkspedisi.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmSerahTerimaEkspedisi.teslip(CDSMaster.FieldByname('Nomor').AsString);
end;

end.
