unit ufrmBrowseTagihanEkspedisi;

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
  TfrmBrowseTagihanEkspedisi = class(TfrmCxBrowse)
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
  frmBrowseTagihanEkspedisi: TfrmBrowseTagihanEkspedisi;

implementation
   uses ufrmTagihanEkspedisi,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseTagihanEkspedisi.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select teh_nomor Nomor,teh_tanggal Tanggal,teh_tg1 Tgl1 , teh_tg2 Tgl2'
                + ' from ttagihanekspedisi_hdr'
                + ' where teh_tanggal between ' + QuotD(startdate.Date) + ' and ' + QuotD(enddate.date) ;

//  Self.SQLDetail := 'select tehd_teh_nomor Nomor ,tehd_fp_nomor NomorFP, cus_nama Customer, fp_tanggal TanggalFP,tehd_nilai Nilai,tehd_biaya Biaya,tehd_biaya/tehd_nilai*100 UOC'
//                + ' from ttagihanekspedisi_dtl inner join ttagihanekspedisi_hdr on teh_nomor=tehd_teh_nomor '
//                + ' inner join tfp_hdr on fp_nomor=tehd_fp_nomor '
//                + ' inner join tcustomer on cus_kode=fp_cus_kode '
//                + ' where teh_tanggal between ' + QuotD(startdate.Date) + ' and ' + QuotD(enddate.date)
//                + ' order by NomorFP asc ';

//    Self.SQLDetail := 'SELECT tehd_teh_nomor Nomor, tehd_fp_nomor NomorFP, '
//                + ' CASE WHEN tehd_fp_nomor = ''ANTARCABANG'' THEN tehd_cus_nama '
//                + ' ELSE cus_nama END AS Customer, '
//                + ' CASE WHEN tehd_fp_nomor = ''ANTARCABANG'' THEN tehd_tanggal '
//                + ' ELSE fp_tanggal END AS TanggalFP, '  // Koreksi pada pemilihan tanggal
//                + ' tehd_nilai Nilai, tehd_biaya Biaya, '
//                + ' CASE WHEN tehd_fp_nomor = ''ANTARCABANG'' THEN 0 '
//                + ' ELSE (tehd_biaya / tehd_nilai) * 100 END AS UOC '
//                + ' FROM ttagihanekspedisi_dtl '
//                + ' INNER JOIN ttagihanekspedisi_hdr ON teh_nomor = tehd_teh_nomor '
//                + ' LEFT JOIN tfp_hdr ON fp_nomor = CASE WHEN tehd_fp_nomor = ''ANTARCABANG'' THEN NULL ELSE tehd_fp_nomor END '
//                + ' LEFT JOIN tcustomer ON cus_kode = CASE WHEN tehd_fp_nomor = ''ANTARCABANG'' THEN NULL ELSE fp_cus_kode END '
//                + ' WHERE teh_tanggal BETWEEN ' + QuotD(startdate.Date) + ' AND ' + QuotD(enddate.Date)
//                + ' ORDER BY NomorFP ASC';

    Self.SQLDetail :=  'SELECT tehd_teh_nomor AS Nomor, tehd_fp_nomor AS NomorFP, '
              + ' CASE WHEN tehd_fp_nomor = ''ANTARCABANG'' THEN tehd_cus_nama '
              + ' ELSE COALESCE(cus_nama, tehd_cus_nama) END AS Customer, '
              + ' CASE WHEN tehd_fp_nomor = ''ANTARCABANG'' THEN tehd_tanggal '
              + ' ELSE COALESCE(fp_tanggal, tehd_tanggal) END AS TanggalFP, '
              + ' tehd_nilai AS Nilai, tehd_biaya AS Biaya, '
              + ' CASE WHEN tehd_fp_nomor = ''ANTARCABANG'' THEN 0 '
              + ' ELSE (tehd_biaya / NULLIF(tehd_nilai,0)) * 100 END AS UOC '
              + ' FROM ttagihanekspedisi_dtl '
              + ' INNER JOIN ttagihanekspedisi_hdr ON teh_nomor = tehd_teh_nomor '
              + ' LEFT JOIN tfp_hdr ON fp_nomor = tehd_fp_nomor '
              + ' LEFT JOIN tcustomer ON cus_kode = fp_cus_kode '
              + ' WHERE teh_tanggal BETWEEN ' + QuotD(startdate.Date) + ' AND ' + QuotD(enddate.Date)
              + ' ' + 'ORDER BY NomorFP ASC';




  Self.MasterKeyField := 'Nomor';
  inherited;
  cxGrdMaster.ApplyBestFit();
  cxGrdMaster.Columns[0].Width := 150;
  cxGrdMaster.Columns[1].Width := 150;
  cxGrdMaster.Columns[2].Width := 150;
  cxGrdMaster.Columns[3].Width := 150;
  cxGrdDetail.Columns[2].Width := 300;
  cxGrdDetail.Columns[3].Width := 100;
  cxGrdDetail.Columns[4].Width := 100;
  cxGrdDetail.Columns[5].Width := 100;
end;

procedure TfrmBrowseTagihanEkspedisi.FormShow(Sender: TObject);
begin
  ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
  bacafile2;
end;

procedure TfrmBrowseTagihanEkspedisi.cxButton2Click(Sender: TObject);
var
  frmtagihanekspedisi: Tfrmtagihanekspedisi;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Tagihan Ekspedisi' then
   begin
      frmtagihanekspedisi  := frmmenu.ShowForm(Tfrmtagihanekspedisi) as Tfrmtagihanekspedisi;
      frmtagihanekspedisi.startdate.SetFocus;
      frmtagihanekspedisi.edtNomor.Text := frmtagihanekspedisi.getmaxkode;
   end;
   frmtagihanekspedisi.Show;
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

procedure TfrmBrowseTagihanEkspedisi.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseTagihanEkspedisi.bacafile2;
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

procedure TfrmBrowseTagihanEkspedisi.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmTagihanEkspedisi.teslip(CDSMaster.FieldByname('Nomor').AsString);
end;

end.
