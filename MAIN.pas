
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}                           
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}           
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
unit MAIN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, SqlExpr, ComCtrls, jpeg, ExtCtrls, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, cxLookAndFeels, dxSkinsForm,
  dxGDIPlusClasses, dxSkinsdxBarPainter, cxGraphics, cxControls,
  cxLookAndFeelPainters, dxRibbonSkins, cxClasses, dxRibbon, dxBar,
    dxNavBarCollns,
  dxNavBarBase, dxNavBar, dxBarDBNav,
  dxSkinsdxRibbonPainter,
   cxPC, dxDockControl,
  dxDockPanel, dxSkinsdxNavBar2Painter, ImgList  , ShellAPI, DBAccess,
  MyAccess, dxSkinDarkRoom, dxSkinFoggy, dxSkinSeven, dxSkinSharp;

type
  TfrmMenu = class(TForm)
    dxSkinController1: TdxSkinController;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    User1: TMenuItem;
    IdentitasPerusahaan1: TMenuItem;
    Relogin1: TMenuItem;
    Daftar1: TMenuItem;
    Persediaan1: TMenuItem;
    Penjualan1: TMenuItem;
    Barang1: TMenuItem;
    Katagori1: TMenuItem;
    Gudang1: TMenuItem;
    PenyesuaianStok1: TMenuItem;
    MutasiAntarGudang1: TMenuItem;
    MutasiantarCabang1: TMenuItem;
    PesananPenjuaalan1: TMenuItem;
    Pengiriman1: TMenuItem;
    Invoice1: TMenuItem;
    PenerimaanCustomer1: TMenuItem;
    ReturPenjualan1: TMenuItem;
    KasBank1: TMenuItem;
    PenerimaanLainlain1: TMenuItem;
    PembayaranLainlain1: TMenuItem;
    Bukubank1: TMenuItem;
    Utility1: TMenuItem;
    GantiPeriodeAktif1: TMenuItem;
    utupPeriode1: TMenuItem;
    Costcenter1: TMenuItem;
    Salesman1: TMenuItem;
    Customer1: TMenuItem;
    JenisCustomer1: TMenuItem;
    Laporan1: TMenuItem;
    ListFakturOutstanding1: TMenuItem;
    ListPenjualanFakturRiil1: TMenuItem;
    ListPenjualanperOutletRiil1: TMenuItem;
    N1: TMenuItem;
    ListPenjualanperItemAkumulatif1: TMenuItem;
    ListInkaso1: TMenuItem;
    N2: TMenuItem;
    MutasiStok1: TMenuItem;
    ListPenjualanperFakturwMargin1: TMenuItem;
    Image1: TImage;
    MutasiCabangIn1: TMenuItem;
    Jurnal1: TMenuItem;
    ListJurnal1: TMenuItem;
    N3: TMenuItem;
    LaporanSalesBulanan1: TMenuItem;
    LaporanYTD1: TMenuItem;
    HistoryHargaJual1: TMenuItem;
    KartuStok1: TMenuItem;
    Rekening1: TMenuItem;
    LaporanTransakskHarian1: TMenuItem;
    LaporanTransaksiHarianbyCustomer1: TMenuItem;
    LaporanSaldoPiutang1: TMenuItem;
    HistoryStok1: TMenuItem;
    LaporanItemMarginMinusLastcost1: TMenuItem;
    dxDockSite1: TdxDockSite;
    dxNavBar2: TdxNavBar;
    dxNavBarGroup1: TdxNavBarGroup;
    dxNavBarGroup2: TdxNavBarGroup;
    dxNavBarGroup3: TdxNavBarGroup;
    dxNavBar2Group4: TdxNavBarGroup;
    dxUser: TdxNavBarItem;
    dxIdentitas: TdxNavBarItem;
    dxRelogin: TdxNavBarItem;
    dxDockPanel1: TdxDockPanel;
    dxLayoutDockSite1: TdxLayoutDockSite;
    dxCostcenter: TdxNavBarItem;
    dxSalesman: TdxNavBarItem;
    dxCustomer: TdxNavBarItem;
    dxSupplier: TdxNavBarItem;
    dxJenisCustomer: TdxNavBarItem;
    dxBarang: TdxNavBarItem;
    dxGudang: TdxNavBarItem;
    dxKategori: TdxNavBarItem;
    dxPenyesuaianStok: TdxNavBarItem;
    dxmutasigudang: TdxNavBarItem;
    dxMutasiCabang: TdxNavBarItem;
    dxPesananJual: TdxNavBarItem;
    dxPengiriman: TdxNavBarItem;
    dxFakturJual: TdxNavBarItem;
    dxPenerimaan: TdxNavBarItem;
    dxReturPenjualan: TdxNavBarItem;
    dxPesananBeli: TdxNavBarItem;
    dxPenerimaanBarang: TdxNavBarItem;
    dxFakturBeli: TdxNavBarItem;
    dxPembayaransup: TdxNavBarItem;
    dxReturBeli: TdxNavBarItem;
    dxBukuBank: TdxNavBarItem;
    dxPenerimaanlain: TdxNavBarItem;
    dxPembayaralain: TdxNavBarItem;
    dxJurnalUmum: TdxNavBarItem;
    dxMutasiCabang2: TdxNavBarItem;
    dxfeeCustomer: TdxNavBarItem;
    dxhitungstok: TdxNavBarItem;
    dxlistJual: TdxNavBarItem;
    dxListPersediaan: TdxNavBarItem;
    dxFakturBayangan: TdxNavBarItem;
    dxFakturPajak: TdxNavBarItem;
    dxListJurnal: TdxNavBarItem;
    dxPencairanGiro: TdxNavBarItem;
    dxbayarbiayapromosi: TdxNavBarItem;
    dxNavBar2Group1: TdxNavBarGroup;
    dxNavBar2Group2: TdxNavBarGroup;
    dxBukuBesar: TdxNavBarItem;
    LaporanItemterlarisStok1: TMenuItem;
    Komisi1: TMenuItem;
    SetingCustomer1: TMenuItem;
    SettingKomisi1: TMenuItem;
    KomisiMarketing1: TMenuItem;
    Marketing1: TMenuItem;
    Salesma1: TMenuItem;
    SettingKomisi2: TMenuItem;
    KomisiSalesman1: TMenuItem;
    frmListKas2: TdxNavBarItem;
    dxMusnah: TdxNavBarItem;
    dxSetingPacking: TdxNavBarItem;
    dxsettingbiayapromosi: TdxNavBarItem;
    dxgrouppf: TdxNavBarItem;
    dxpf: TdxNavBarItem;
    dxttfaktur: TdxNavBarItem;
    dxNavBar2Group3: TdxNavBarGroup;
    dxlapAbsensi: TdxNavBarItem;
    dxlapkunjungan: TdxNavBarItem;
    dxdownloadkunjungan: TdxNavBarItem;
    SerahTerimaFaktur1: TMenuItem;
    ProsesBiayaPromosi1: TMenuItem;
    SettingEstimasiSalesman1: TMenuItem;
    SettinhJadwalSales1: TMenuItem;
    S1: TMenuItem;
    CetakKunjungan1: TMenuItem;
    LaporanEstimasiSalesmanvsRealisasi1: TMenuItem;
    LaporanPenjualanMarketing1: TMenuItem;
    LaporanKunjunganMarketing1: TMenuItem;
    LaporanPencapaianMarketing1: TMenuItem;
    N4: TMenuItem;
    LapInkasoBawahHET1: TMenuItem;
    ImageList1: TImageList;
    Kirimdatakepusat1: TMenuItem;
    dxRayon: TdxNavBarItem;
    dxPermintaanBarang: TdxNavBarItem;
    dxtagihanekspedisi: TdxNavBarItem;
    dxGunggung: TdxNavBarItem;
    VerifikasiAbsensi1: TMenuItem;
    dxkendaraan: TdxNavBarItem;
    LaporanAbsensi1: TMenuItem;
    dxekspedisi: TdxNavBarItem;
    dxserahterima2: TdxNavBarItem;
    LaporanSalesBulananNew1: TMenuItem;
    tmr1: TTimer;
    dxSettingFeeMarketing: TdxNavBarItem;
    ProsesFeeMarketing1: TMenuItem;
    procedure FileExit1Execute(Sender: TObject);
    function ShowForm(AFormClass: TFormClass): TForm;
    procedure Maximized1Click(Sender: TObject);

    procedure FormShow(Sender: TObject);
    procedure bacafile;
    procedure bacafile2;
    procedure Exit1Click(Sender: TObject);
    procedure frmUserClick(Sender: TObject);
    procedure frmRELoginClick(Sender: TObject);
    procedure dxNavBar1Item1Click(Sender: TObject);
    procedure dxGudangClick(Sender: TObject);
    procedure dxCostcenterClick(Sender: TObject);
    procedure dxSalesmanClick(Sender: TObject);
    procedure dxCustomerClick(Sender: TObject);
    procedure dxSupplierClick(Sender: TObject);
    procedure dxJenisCustomerClick(Sender: TObject);
    procedure dxReloginClick(Sender: TObject);
    procedure dxKategoriClick(Sender: TObject);
    procedure dxPesananJualClick(Sender: TObject);
    procedure dxBarangClick(Sender: TObject);
    procedure dxPesananBeliClick(Sender: TObject);
    procedure dxPenerimaanBarangClick(Sender: TObject);
    procedure dxFakturBeliClick(Sender: TObject);
    procedure dxFakturJualClick(Sender: TObject);
    procedure dxMutasiCabang2Click(Sender: TObject);
    procedure dxMutasiCabangClick(Sender: TObject);
    procedure dxmutasigudangClick(Sender: TObject);
    procedure dxPembayaransupClick(Sender: TObject);
    procedure dxPengirimanClick(Sender: TObject);
    procedure dxReturBeliClick(Sender: TObject);
    procedure dxfeeCustomerClick(Sender: TObject);
    procedure dxPenerimaanClick(Sender: TObject);
    procedure dxReturPenjualanClick(Sender: TObject);
    procedure dxPenerimaanlainClick(Sender: TObject);
    procedure dxPembayaralainClick(Sender: TObject);
    procedure dxhitungstokClick(Sender: TObject);
    procedure dxlistJualClick(Sender: TObject);
    procedure dxPenyesuaianStokClick(Sender: TObject);
    procedure dxListPersediaanClick(Sender: TObject);
    procedure dxFakturBayanganClick(Sender: TObject);
    procedure ListPenjualanPerItem1Click(Sender: TObject);
    procedure ListPenjualanvsTarget1Click(Sender: TObject);
    procedure ListFakturOutstanding1Click(Sender: TObject);
    procedure ListPenjualanFakturRiil1Click(Sender: TObject);
    procedure ListPenjualanperOutletRiil1Click(Sender: TObject);
    procedure ListPenjualanperItemAkumulatif1Click(Sender: TObject);
    procedure ListInkaso1Click(Sender: TObject);
    procedure MutasiStok1Click(Sender: TObject);
    procedure ListPenjualanperFakturwMargin1Click(Sender: TObject);
    procedure dxBukuBankClick(Sender: TObject);
    procedure dxFakturPajakClick(Sender: TObject);
    procedure dxJurnalUmumClick(Sender: TObject);
    procedure dxListJurnalClick(Sender: TObject);
    procedure User1Click(Sender: TObject);
    procedure IdentitasPerusahaan1Click(Sender: TObject);
    procedure Relogin1Click(Sender: TObject);
    procedure dxIdentitasClick(Sender: TObject);
    procedure Costcenter1Click(Sender: TObject);
    procedure Salesman1Click(Sender: TObject);
    procedure Customer1Click(Sender: TObject);
    procedure JenisCustomer1Click(Sender: TObject);
    procedure Barang1Click(Sender: TObject);
    procedure Katagori1Click(Sender: TObject);
    procedure Gudang1Click(Sender: TObject);
    procedure PenyesuaianStok1Click(Sender: TObject);
    procedure MutasiAntarGudang1Click(Sender: TObject);
    procedure MutasiantarCabang1Click(Sender: TObject);
    procedure MutasiCabangIn1Click(Sender: TObject);
    procedure PesananPenjuaalan1Click(Sender: TObject);
    procedure Pengiriman1Click(Sender: TObject);
    procedure Invoice1Click(Sender: TObject);
    procedure PenerimaanCustomer1Click(Sender: TObject);
    procedure ReturPenjualan1Click(Sender: TObject);
    procedure PenerimaanLainlain1Click(Sender: TObject);
    procedure PembayaranLainlain1Click(Sender: TObject);
    procedure Bukubank1Click(Sender: TObject);
    procedure Jurnal1Click(Sender: TObject);
    procedure ListJurnal1Click(Sender: TObject);
    procedure LaporanSalesBulanan1Click(Sender: TObject);
    procedure LaporanYTD1Click(Sender: TObject);
    procedure HistoryHargaJual1Click(Sender: TObject);
    procedure LaporanInkasoperSalesman1Click(Sender: TObject);
    procedure KartuStok1Click(Sender: TObject);
    procedure Rekening1Click(Sender: TObject);
    procedure LaporanTransakskHarian1Click(Sender: TObject);
    procedure dxPencairanGiroClick(Sender: TObject);
    procedure LaporanTransaksiHarianbyCustomer1Click(Sender: TObject);
    procedure LaporanTargetvsRealisasi1Click(Sender: TObject);
    procedure LaporanSaldoPiutang1Click(Sender: TObject);
    procedure HistoryStok1Click(Sender: TObject);
    procedure LaporanItemMarginMinusLastcost1Click(Sender: TObject);
    procedure StokExpired1Click(Sender: TObject);
    procedure dxDockPanel1AutoHideChanged(Sender: TdxCustomDockControl);
    procedure dxbayarbiayapromosiClick(Sender: TObject);
    procedure dxMusnahClick(Sender: TObject);
    procedure frmListKas2Click(Sender: TObject);
    procedure KomisiMarketing1Click(Sender: TObject);
    procedure KomisiSalesman1Click(Sender: TObject);
    procedure LaporanItemterlarisStok1Click(Sender: TObject);
    procedure SetingCustomer1Click(Sender: TObject);
    procedure SettingKomisi1Click(Sender: TObject);
    procedure SettingKomisi2Click(Sender: TObject);
    procedure utupPeriode1Click(Sender: TObject);
    procedure dxSetingPackingClick(Sender: TObject);
    procedure dxsettingbiayapromosiClick(Sender: TObject);
    procedure dxgrouppfClick(Sender: TObject);
    procedure dxttfakturClick(Sender: TObject);
    procedure dxlapAbsensiClick(Sender: TObject);
    procedure dxlapkunjunganClick(Sender: TObject);
    procedure dxdownloadkunjunganClick(Sender: TObject);
    procedure SerahTerimaFaktur1Click(Sender: TObject);
    procedure ProsesBiayaPromosi1Click(Sender: TObject);
    procedure SettingEstimasiSalesman1Click(Sender: TObject);
    procedure SettinhJadwalSales1Click(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure CetakKunjungan1Click(Sender: TObject);
    procedure LapInkasoBawahHET1Click(Sender: TObject);
    procedure LaporanPencapaianMarketing1Click(Sender: TObject);
    procedure LaporanKunjunganMarketing1Click(Sender: TObject);
    procedure LaporanPenjualanMarketing1Click(Sender: TObject);
    procedure LaporanEstimasiSalesmanvsRealisasi1Click(Sender: TObject);
    procedure Kirimdatakepusat1Click(Sender: TObject);
    procedure dxPermintaanBarangClick(Sender: TObject);
    procedure dxtagihanekspedisiClick(Sender: TObject);
    procedure VerifikasiAbsensi1Click(Sender: TObject);
    procedure dxkendaraanClick(Sender: TObject);
    procedure LaporanAbsensi1Click(Sender: TObject);
    procedure dxekspedisiClick(Sender: TObject);
    procedure dxserahterima2Click(Sender: TObject);
    procedure LaporanSalesBulananNew1Click(Sender: TObject);
    procedure LoadMenu(const AUser: string);
    procedure ApplyNavBarItems(ANavBar: TdxNavBar);
    procedure ApplyNavBarGroups(ANavBar: TdxNavBar);
    procedure tmrHeartbeatTimer(Sender: TObject);
    procedure dxSettingFeeMarketingClick(Sender: TObject);
    procedure ProsesFeeMarketing1Click(Sender: TObject);
    procedure SembunyikanMenu(AMainMenu: TMainMenu);
    function ApplyMainMenuAccess(AMenuItem: TMenuItem): Boolean;
    procedure ApplyMainMenu(AMainMenu: TMainMenu);
    procedure HideMenuItem(AMenuItem: TMenuItem);
  private
    { Private declarations }

    FaDatabase: string;
    FaHost: string;
    Fapassword: string;
    Fauser: string;
    Faport: Integer;
    Fapathimage : string;
    FaDatabase2: string;
    FaHost2: string;
    Fapassword2: string;
    Fauser2: string;

  public
    { Public declarations }
    conn: TMyConnection;
//    conn2: TMyConnection;
    // conn: TSQLConnection;
    connmy: TMyConnection;

        KDUSER,NMUSER,KDCABANG,NMCABANG,RKCABANG : String;
        otorisasi : Boolean;
      property aDatabase: string read FaDatabase write FaDatabase;
      property aHost: string read FaHost write FaHost;
      property apassword: string read Fapassword write Fapassword;
      property apathimage: string read Fapathimage write Fapathimage;
      property auser: string read Fauser write Fauser;
      property aport: Integer read Faport write Faport;
      property aDatabase2: string read FaDatabase2 write FaDatabase2;
      property aHost2: string read FaHost2 write FaHost2;
      property apassword2: string read Fapassword2 write Fapassword2;
      property auser2: string read Fauser2 write Fauser2;
end;

var

  frmMenu: TfrmMenu;

//  for help / bantuan...
// ThreadBusy: Boolean = False;
  varglobal : string;
  varglobal1 : string;
  varglobal2 : string;
  sqlbantuan : string;
  sqlfilter : string;
  zVersi:string;
  apath:string;
  hakUser: TStringList;

implementation
uses Ulib,uModuleConnection,ufrmUser, UfrmLogin,ufrmBrowseGudang,ufrmBrowseCostCenter,
ufrmBrowseSalesman,ufrmBrowseCustomer,ufrmBrowseSupplier,ufrmBrowseJC,ufrmBrowseSubBarang,
ufrmBrowsePesanan,ufrmBrowseBarang,ufrmBrowsePO,ufrmBrowseBPB,ufrmBrowseInvoice,
ufrmBrowseMutasiGudang,ufrmBrowseBayarSup,ufrmBrowseMutasiCabang,ufrmBrowseReturBeli,ufrmBrowseMutasiCabang2,
ufrmBrowseDO,ufrmBrowseFP,ufrmBrowseFeeCustomer,ufrmBrowseBayarCustomer,ufrmBrowseReturJual,ufrmBrowsePenerimaanLain,
ufrmBrowsePembayaranLain,ufrmBrowseHitungStok,ufrmListJual,ufrmBrowseKoreksiStok,
ufrmLapPersediaan,ufrmListJualvsTarget,ufrmListFOS,ufrmListJual2,ufrmlistjual3,ufrmListJual4,
ufrmListInkaso,ufrmListMutasiStok,ufrmListJual5,ufrmBrowseFPBayangan,ufrmListKas,ufrmBrowseFakturPajak,
ufrmBrowseJurnalUmum,ufrmBrowseJurnal,ufrmperusahaan,ufrmLapBulanan,ufrmLapYTD,ufrmBrowseHistoryHargaJual,
ufrmLapBulananInkaso,ufrmBrowseKartuStok,ufrmBrowseRekening,ufrmListTransaksiHarian,ufrmBrowsePencairanGiro,
ufrmListTransaksiHarian2,ufrmLapBulanan2,ufrmListSaldoPiutang,ufrmListMutasiStok2,ufrmListItemMinus,
ufrmBrowseStokExpired,ufrmBrowseBayarBiayaPromosi,ufrmLapStokItemTerlaris,ufrmSalesMarketing,
ufrmSettingKomisi,ufrmKomisiMarketing,ufrmSettingKomisi2,ufrmKomisiSalesman,ufrmListKas2,ufrmtutupperiode,
ufrmBrowseMusnah,ufrmBrowseSetingPacking,ufrmBrowseSetingBiayaPromosi,ufrmBrowseSubBarangPF,
ufrmBrowseBarangPF,ufrmBrowseTTFaktur,ufrmLapAbsensi,ufrmLapDetailCheckIn,ufrmDownloadkunjungan,
ufrmBrowseSerahTerimaFaktur,ufrmProsesBiayaPromosi,ufrmEstimasiSales,ufrmBrowseSetingJadwalSales,
ufrmBrowsejurnal2,ufrmBrowseSuratJalan,ufrmCetakKunjungan,ufrmLapBulanan4,ufrmLapBulanan5,
ufrmBrowseInkasoBawahHet,ufrmLapBulananMarketing,ufrmLapKunjunganMarketing,
ufrmListJualMarketing,ufrmBrowseEstimasiSales,ufrmPencapaianMarketing2,ufrmLapBulananMarketing2,
ufrmupload,ufrmBrowsePermintaanBarang,ufrmBrowseTagihanEkspedisi,ufrmprosesgunggung,ufrmfakturpajak3,
ufrmVerifikasiAbsensi,ufrmBrowseJenisKendaraan,ufrmBrowseEkspedisi,ufrmBrowseSerahTerimaFaktur2,
ufrmBrowseSetingFeeMarketing,ufrmProsesFeeMarketing;
{$R *.dfm}


procedure TfrmMenu.FileExit1Execute(Sender: TObject);
begin
  application.terminate;
end;

function TfrmMenu.ShowForm(AFormClass: TFormClass): TForm;
var
  aForm: TForm;
  i: Integer;
begin
  inherited;
  Result := nil;

  if ( not ceKVIEW(frmMenu.KDUSER, AFormClass.ClassName)) then
  begin
    MessageDlg('Anda tidak berhak Membuka di Modul ini',mtWarning, [mbOK],0);
    Exit;
  End;
  
  for i := 0 to MDIChildCount - 1 do
  begin
    if MDIChildren[i].ClassName = AFormClass.ClassName then
    begin
      Result := MDIChildren[i];
      // mdiChildrenTabs.TabIndex := GetTabSetIndex(Result);
      Exit;
    end;
  end;

  aForm := AFormClass.Create(Application);
  aForm.FormStyle := fsMDIChild;
  // aForm.Position := poDefault;

  aForm.WindowState := wsMaximized;
  Result := (aForm as AFormClass);
end;

procedure TfrmMenu.Maximized1Click(Sender: TObject);
begin
  if MDIChildCount <> 0 then
    ActiveMDIChild.WindowState := wsMaximized;
end;

procedure TfrmMenu.FormShow(Sender: TObject);
var
  sql:string;
  tsql:TmyQuery;
  AppVersi, DbVersi:Double;
  arc: Integer;
begin
  dxNavBar2.Visible := False;
  SembunyikanMenu(MainMenu1);

  apath := 'C:\Users\';
  apath := apath+vartostr(trim(GetCurrentUserName));
  apath := apath+'\Documents\Default\';

  bacafile;
  //      bacafile2;
  StatusBar1.Panels[1].Text := 'Connected  to ' + aHost;
  StatusBar1.Panels[2].Text := 'Database  ' + aDatabase;

  conn := xCreateConnection(ctMySQL,aHost,aDatabase,auser,apassword, aport);
//  conn2 := xCreateConnection(ctMySQL,aHost,aDatabase,auser,apassword, aport);

  // connmy:= xCreateConnection2(ctMySQL,aHost,aDatabase,auser,apassword);
  conn.Connected := True;

  ThousandSeparator := ',';
  ShortDateFormat := 'M/d/yyyy';
  DateSeparator   := '/';
  DecimalSeparator := '.';
  Application.UpdateFormatSettings := True;

  zVersi := '6.0.21';
  StatusBar1.Panels[4].Text := 'Versi ' + zVersi;

  // cek ver si
  sql := 'select versi from tversi where aplikasi = "Inventorycab"';
  tsql := xOpenQuery(sql, arc, frmmenu.conn);
  AppVersi := StrToFloat(StringReplace(zVersi,'.','',[rfReplaceAll]));
  DbVersi := StrToFloat(StringReplace(tsql.FieldByName('versi').AsString,'.','',[rfReplaceAll]));

  if AppVersi<dbVersi then
  begin
    ShowMessage('Program belum update silakan hubungi programmer');
    application.terminate;
  end;

  frmLogin.Show;
end;

procedure TfrmMenu.bacafile;
var
  ltemp : TStringList;
begin
  if FileExists(apath+'default.cfg') then
  begin
    ltemp := TStringList.Create;
    ltemp.loadfromfile(apath+'default.cfg');
    aHost     := ltemp[0];
    aDatabase := ltemp[1];
    auser     := ltemp[2];
    apassword := 'BsmCabang321?';
    aport := StrToInt(ltemp[6]);
    apathimage := ltemp[5];
    ltemp.free;
  end
  else
  begin
    ltemp := TStringList.Create;
    ltemp.loadfromfile(ExtractFileDir(application.ExeName) + '\' + 'default.cfg');
    aHost     := ltemp[0];
    aDatabase := ltemp[1];
    auser     := ltemp[2];
    apassword := ltemp[3];
    aport := StrToInt(ltemp[6]);
    apathimage := ltemp [5];
    ltemp.free;
  end;
end;

procedure TfrmMenu.Exit1Click(Sender: TObject);
begin
 Close;
end;

procedure TfrmMenu.frmUserClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Master User' then
  begin
    ShowForm(TfrmUser).Show;
  end
  else
    ActiveMDIChild.WindowState := wsMaximized;
end;

procedure TfrmMenu.frmRELoginClick(Sender: TObject);
var
  i : Integer;
begin
   for i := 0 to MDIChildCount - 1 do
   begin
      MDIChildren[i].Release;
   end;
   
   Self.Enabled := False;
   frmlogin.edtuser.Clear;
   frmlogin.edtPassword.Clear;
   frmLogin.Show;
end;

procedure TfrmMenu.dxNavBar1Item1Click(Sender: TObject);
begin
  frmUserClick(self);
end;

procedure TfrmMenu.dxGudangClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Gudang' then
  begin
    ShowForm(TfrmBrowseGudang).Show;
  end;
end;

procedure TfrmMenu.dxCostcenterClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Cost Center' then
  begin
    ShowForm(TfrmBrowseCostCenter).Show;
  end;
end;

procedure TfrmMenu.dxSalesmanClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Salesman' then
  begin
    ShowForm(TfrmBrowseSalesman).Show;
  end;
end;

procedure TfrmMenu.dxCustomerClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Customer' then
  begin
    ShowForm(TfrmBrowseCustomer).Show;
  end;
end;

procedure TfrmMenu.dxSupplierClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Supplier' then
  begin
    ShowForm(TfrmBrowseSupplier).Show;
  end;
end;

procedure TfrmMenu.dxJenisCustomerClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Jenis Customer' then
  begin
    ShowForm(TfrmBrowseJC).Show;
  end;
end;

procedure TfrmMenu.dxReloginClick(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to MDIChildCount - 1 do
  begin
    MDIChildren[i].Release;
  end;

  Self.Enabled := False;
  frmlogin.edtuser.Clear;
  frmlogin.edtPassword.Clear;
  frmLogin.Show;
end;


procedure TfrmMenu.dxKategoriClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse SubBarang' then
  begin
    ShowForm(TfrmBrowseSubBarang).Show;
  end;
end;

procedure TfrmMenu.dxPesananJualClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Pesanan' then
  begin
    ShowForm(TfrmBrowsePesanan).Show;
  end;
end;

procedure TfrmMenu.dxBarangClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Barang' then
  begin
    ShowForm(TfrmBrowseBarang).Show;
  end;
end;

procedure TfrmMenu.dxPesananBeliClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse PO' then
  begin
    ShowForm(TfrmBrowsePO).Show;
  end;
end;

procedure TfrmMenu.dxPenerimaanBarangClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse BPB' then
  begin
    ShowForm(TfrmBrowseBPB).Show;
  end;
end;

procedure TfrmMenu.dxFakturBeliClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Invoice' then
  begin
    ShowForm(TfrmBrowseInvoice).Show;
  end;
end;

procedure TfrmMenu.dxFakturJualClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Faktur Penjualan' then
  begin
    ShowForm(TfrmBrowseFP).Show;
  end;
end;

procedure TfrmMenu.dxMutasiCabang2Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Mutasi Cabang In' then
  begin
    ShowForm(TfrmBrowseMutasiCabang2).Show;
  end;
end;

procedure TfrmMenu.dxMutasiCabangClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Mutasi Cabang' then
  begin
    ShowForm(TfrmBrowseMutasiCabang).Show;
  end;
end;

procedure TfrmMenu.dxmutasigudangClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Mutasi Gudang' then
  begin
    ShowForm(TfrmBrowseMutasiGudang).Show;
  end;
end;

procedure TfrmMenu.dxPembayaransupClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Pembayaran Supplier' then
  begin
    ShowForm(TfrmBrowseBayarSup).Show;
  end;
end;

procedure TfrmMenu.dxPengirimanClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Pengiriman Barang' then
  begin
    ShowForm(TfrmBrowseDO).Show;
  end;
end;

procedure TfrmMenu.dxReturBeliClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Retur Beli' then
  begin
    ShowForm(TfrmBrowseReturBeli).Show;
  end;
end;

procedure TfrmMenu.dxfeeCustomerClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Fee Customer' then
  begin
    ShowForm(TfrmBrowseFeeCustomer).Show;
  end;
end;

procedure TfrmMenu.dxPenerimaanClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Pembayaran Customer' then
  begin
    ShowForm(TfrmBrowseBayarCustomer).Show;
  end;
end;

procedure TfrmMenu.dxReturPenjualanClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Retur Jual' then
  begin
    ShowForm(TfrmBrowseReturJual).Show;
  end;
end;

procedure TfrmMenu.dxPenerimaanlainClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Penerimaan Lain Lain' then
  begin
    ShowForm(TfrmBrowsePenerimaanLain).Show;
  end;
end;

procedure TfrmMenu.dxPembayaralainClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Pembayaran Lain Lain' then
  begin
    ShowForm(TfrmBrowsePembayaranLain).Show;
  end;
end;

procedure TfrmMenu.dxhitungstokClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Hitung Stok' then
 begin
    ShowForm(TfrmBrowseHitungStok).Show;
 end;

end;

procedure TfrmMenu.dxlistJualClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Penjualan per Item' then
 begin
    ShowForm(TfrmListJual).Show;
 end;

end;

procedure TfrmMenu.dxPenyesuaianStokClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Koreksi Stok' then
 begin
    ShowForm(TfrmBrowseKoreksiStok).Show;
 end;

end;

procedure TfrmMenu.dxListPersediaanClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Laporan Persediaan' then
 begin
    ShowForm(TfrmLapPersediaan).Show;
 end;

end;

procedure TfrmMenu.dxFakturBayanganClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Faktur Penjualan Manual' then
 begin
    ShowForm(TfrmbrowsefpBAYANGAN).Show;
 end;


end;

procedure TfrmMenu.ListPenjualanPerItem1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Penjualan per Item' then
 begin
    ShowForm(TfrmListJual).Show;
 end;

end;

procedure TfrmMenu.ListPenjualanvsTarget1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Penjualan vs Target' then
 begin
    ShowForm(TfrmListJualvsTarget).Show;
 end;

end;

procedure TfrmMenu.ListFakturOutstanding1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Faktur Outstanding' then
 begin
    ShowForm(TfrmListFOS).Show;
 end;

end;

procedure TfrmMenu.ListPenjualanFakturRiil1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Penjualan per Faktur' then
 begin
    ShowForm(TfrmListJual2).Show;
 end;

end;

procedure TfrmMenu.ListPenjualanperOutletRiil1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Penjualan per Outlet' then
 begin
    ShowForm(TfrmListJual3).Show;
 end;

end;

procedure TfrmMenu.ListPenjualanperItemAkumulatif1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Penjualan per Item (Akumulatif)' then
 begin
    ShowForm(TfrmListJual4).Show;
 end;

end;

procedure TfrmMenu.ListInkaso1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Inkaso' then
 begin
    ShowForm(TfrmListInkaso).Show;
 end;

end;

procedure TfrmMenu.MutasiStok1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Mutasi Stok' then
 begin
    ShowForm(TfrmListMutasiStok).Show;
 end;


end;

procedure TfrmMenu.ListPenjualanperFakturwMargin1Click(Sender: TObject);
begin
if ActiveMDIChild.Caption <> 'List Penjualan per Faktur (Margin)' then
 begin
    ShowForm(TfrmListJual5).Show;
 end;

end;

procedure TfrmMenu.dxBukuBankClick(Sender: TObject);
begin
if ActiveMDIChild.Caption <> 'Buku Bank' then
 begin
    ShowForm(TfrmlistKas).Show;
 end;

end;

procedure TfrmMenu.dxFakturPajakClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Faktur Pajak' then
 begin
    ShowForm(TfrmBrowseFakturPajak).Show;
 end;

end;

procedure TfrmMenu.dxJurnalUmumClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Jurnal Umum' then
 begin
    ShowForm(TfrmBrowseJurnalUmum).Show;
 end;

end;

procedure TfrmMenu.dxListJurnalClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Jurnal' then
 begin
    ShowForm(TfrmBrowseJurnal2).Show;
 end;

end;

procedure TfrmMenu.User1Click(Sender: TObject);
begin
  frmUserClick(self);
end;

procedure TfrmMenu.IdentitasPerusahaan1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Identitas Perusahaan' then
  begin
    ShowForm(TfrmPerusahaan).Show;
  end;
    ActiveMDIChild.WindowState := wsMaximized;
end;

procedure TfrmMenu.Relogin1Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to MDIChildCount - 1 do
  begin
    MDIChildren[i].Release;
  end;

  Self.Enabled := False;
  frmlogin.edtuser.Clear;
  frmlogin.edtPassword.Clear;
  frmLogin.Show;
end;

procedure TfrmMenu.dxIdentitasClick(Sender: TObject);
begin
  IdentitasPerusahaan1Click(Self);
end;

procedure TfrmMenu.Costcenter1Click(Sender: TObject);
begin
  dxCostcenterClick(Self)
end;

procedure TfrmMenu.Salesman1Click(Sender: TObject);
begin
  dxSalesmanClick(Self);
end;

procedure TfrmMenu.Customer1Click(Sender: TObject);
begin
  dxCustomerClick(Self);
end;

procedure TfrmMenu.JenisCustomer1Click(Sender: TObject);
begin
   dxJenisCustomerClick(Self);
end;

procedure TfrmMenu.Barang1Click(Sender: TObject);
begin
  dxBarangClick(Self);
end;

procedure TfrmMenu.Katagori1Click(Sender: TObject);
begin
   dxKategoriClick(Self);
end;

procedure TfrmMenu.Gudang1Click(Sender: TObject);
begin
  dxGudangClick(Self);
end;

procedure TfrmMenu.PenyesuaianStok1Click(Sender: TObject);
begin
   dxPenyesuaianStokClick(Self);
end;

procedure TfrmMenu.MutasiAntarGudang1Click(Sender: TObject);
begin
   dxmutasigudangClick(Self);
end;

procedure TfrmMenu.MutasiantarCabang1Click(Sender: TObject);
begin
    dxMutasiCabangClick(Self);
end;

procedure TfrmMenu.MutasiCabangIn1Click(Sender: TObject);
begin
dxMutasiCabang2Click(Self)
end;

procedure TfrmMenu.PesananPenjuaalan1Click(Sender: TObject);
begin
  dxPesananJualClick(Self);
end;

procedure TfrmMenu.Pengiriman1Click(Sender: TObject);
begin
  dxPengirimanClick(Self);
end;

procedure TfrmMenu.Invoice1Click(Sender: TObject);
begin
  dxFakturJualClick(Self);
end;

procedure TfrmMenu.PenerimaanCustomer1Click(Sender: TObject);
begin
  dxPenerimaanClick(Self);
end;

procedure TfrmMenu.ReturPenjualan1Click(Sender: TObject);
begin
  dxReturPenjualanClick(Self);
end;

procedure TfrmMenu.PenerimaanLainlain1Click(Sender: TObject);
begin
  dxPenerimaanlainClick(self);
end;

procedure TfrmMenu.PembayaranLainlain1Click(Sender: TObject);
begin
  dxPembayaralainClick(Self);
end;

procedure TfrmMenu.Bukubank1Click(Sender: TObject);
begin
   dxBukuBankClick(self);
end;

procedure TfrmMenu.Jurnal1Click(Sender: TObject);
begin
  dxJurnalUmumClick(Self);
end;

procedure TfrmMenu.ListJurnal1Click(Sender: TObject);
begin
   dxListJurnalClick(Self);
end;

procedure TfrmMenu.LaporanSalesBulanan1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Lap Bulanan New' then
 begin
    ShowForm(TfrmLapBulanan4).Show;
 end;

end;

procedure TfrmMenu.LaporanYTD1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Laporan YTD' then
 begin
    ShowForm(TfrmLapYTD).Show;
 end;

end;

procedure TfrmMenu.HistoryHargaJual1Click(Sender: TObject);
begin

 if ActiveMDIChild.Caption <> 'Browse History Harga Jual' then
 begin
    ShowForm(TfrmBrowseHistoryHargaJual).Show;
 end;

end;

procedure TfrmMenu.LaporanInkasoperSalesman1Click(Sender: TObject);
begin

 if ActiveMDIChild.Caption <> 'Laporan Inkaso Bulanan' then
 begin
    ShowForm(TfrmLapbulananinkaso).Show;
 end;

end;

procedure TfrmMenu.KartuStok1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Kartu Stok' then
 begin
    ShowForm(TfrmBrowseKartuStok).Show;
 end;

end;

procedure TfrmMenu.Rekening1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Rekening' then
 begin
    ShowForm(TfrmBrowseRekening).Show;
 end;

end;

procedure TfrmMenu.LaporanTransakskHarian1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Transaksi Harian' then
 begin
    ShowForm(TfrmListTransaksiHarian).Show;
 end;

end;

procedure TfrmMenu.dxPencairanGiroClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Pencairan Giro' then
 begin
    ShowForm(TfrmBrowsePencairanGiro).Show;
 end;

end;

procedure TfrmMenu.LaporanTransaksiHarianbyCustomer1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Transaksi Harian by Customer' then
 begin
    ShowForm(TfrmListTransaksiHarian2).Show;
 end;

end;

procedure TfrmMenu.LaporanTargetvsRealisasi1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Laporan Target vs Realisasi Bulanan' then
 begin
    ShowForm(TfrmLapBulanan2).Show;
 end;


end;

procedure TfrmMenu.LaporanSaldoPiutang1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Laporan Saldo Piutang' then
 begin
    ShowForm(TfrmListSaldoPiutang).Show;
 end;

end;

procedure TfrmMenu.HistoryStok1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'History Stok' then
 begin
    ShowForm(TfrmListMutasiStok2).Show;
 end;

end;

procedure TfrmMenu.LaporanItemMarginMinusLastcost1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Item Margin Minus' then
 begin
    ShowForm(TfrmListItemMinus).Show;
 end;

end;

procedure TfrmMenu.StokExpired1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Stok Expired' then
 begin
    ShowForm(TfrmBrowseStokExpired).Show;
 end;

end;

procedure TfrmMenu.dxDockPanel1AutoHideChanged(
  Sender: TdxCustomDockControl);
begin
  if dxDockPanel1.AutoHide then
     dxDockSite1.Width := 24
  else
     dxDockSite1.Width := 200;
end;

procedure TfrmMenu.dxbayarbiayapromosiClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Pembayaran Biaya Promosi' then
 begin
    ShowForm(TfrmBrowseBayarBiayapromosi).Show;
 end;
end;

procedure TfrmMenu.dxMusnahClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Pemusnahan' then
 begin
    ShowForm(TfrmBrowseMusnah).Show;
 end;

end;

procedure TfrmMenu.frmListKas2Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Kas Harian' then
 begin
    ShowForm(TfrmListKas2).Show;
 end;

end;

procedure TfrmMenu.KomisiMarketing1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Komisi Marketing' then
 begin
    ShowForm(TfrmKomisiMarketing).Show;
 end;
end;

procedure TfrmMenu.KomisiSalesman1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Komisi Salesman' then
 begin
    ShowForm(TfrmKomisiSalesman).Show;
 end;

end;

procedure TfrmMenu.LaporanItemterlarisStok1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Laporan Stok Item terlaris' then
 begin
    ShowForm(TfrmLapStokItemterlaris).Show;
 end;
end;

procedure TfrmMenu.SetingCustomer1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Sales Marketing' then
 begin
    ShowForm(TfrmSalesMarketing).Show;
 end;
end;

procedure TfrmMenu.SettingKomisi1Click(Sender: TObject);
begin
   if ActiveMDIChild.Caption <> 'Setting Komisi' then
   begin
      ShowForm(TfrmSettingKomisi).Show;
   end;
end;

procedure TfrmMenu.SettingKomisi2Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Setting Komisi Salesman' then
   begin
      ShowForm(TfrmSettingKomisi2).Show;
   end;
end;

procedure TfrmMenu.utupPeriode1Click(Sender: TObject);
begin
     if ActiveMDIChild.Caption <> 'Tutup Periode' then
   begin
      ShowForm(TfrmTutupPeriode).Show;
   end;
end;

procedure TfrmMenu.dxSetingPackingClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Setting Packing' then
  begin
    ShowForm(TfrmBrowseSetingPacking).Show;
  end;
end;

procedure TfrmMenu.dxsettingbiayapromosiClick(Sender: TObject);
begin
     if ActiveMDIChild.Caption <> 'Setting Biaya Prmosi' then
   begin
      ShowForm(TfrmBrowseSetingBiayaPromosi).Show;
   end;

end;

procedure TfrmMenu.dxgrouppfClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Barang pf' then
  begin
    ShowForm(TfrmBrowseBarangPF).Show;
  end;
end;

procedure TfrmMenu.dxttfakturClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse TT Faktur' then
   begin
      ShowForm(TfrmBrowseTTFaktur).Show;
   end;

end;

procedure TfrmMenu.dxlapAbsensiClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Laporan Absensi' then
   begin
      ShowForm(TfrmLapAbsensi).Show;
   end;

end;

procedure TfrmMenu.dxlapkunjunganClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Laporan Detail CheckIn' then
   begin
      ShowForm(TfrmLapDetailCheckIn).Show;
   end;

end;

procedure TfrmMenu.dxdownloadkunjunganClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Download Kunjungan' then
   begin
      ShowForm(TfrmDownloadkunjungan).Show;
   end;

end;

procedure TfrmMenu.SerahTerimaFaktur1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Serah Terima Faktur' then
   begin
      ShowForm(TfrmbrowseSerahTerimaFaktur).Show;
   end;

end;

procedure TfrmMenu.ProsesBiayaPromosi1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Proses Biaya Promosi' then
   begin
      ShowForm(TfrmProsesBiayaPromosi).Show;
   end;

end;

procedure TfrmMenu.SettingEstimasiSalesman1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Estimasi Salesman' then
   begin
      ShowForm(TfrmEstimasiSales).Show;
   end;

end;

procedure TfrmMenu.SettinhJadwalSales1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Seting Jadwal Sales' then
   begin
      ShowForm(TfrmBrowseSetingJadwalSales).Show;
   end;

end;

procedure TfrmMenu.S1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Surat Jalan' then
   begin
      ShowForm(TfrmBrowseSuratJalan).Show;
   end;

end;

procedure TfrmMenu.CetakKunjungan1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Cetak Kunjungan Salesman' then
   begin
      ShowForm(TfrmCetakKunjungan).Show;
   end;

end;

procedure TfrmMenu.LapInkasoBawahHET1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Inkaso bawah HET' then
   begin
      ShowForm(TfrmBrowseInkasoBawahHet).Show;
   end;
end;

procedure TfrmMenu.LaporanPencapaianMarketing1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Laporan Pencapaian Marketing' then
   begin
      ShowForm(Tfrmlapbulananmarketing).Show;
   end;
end;

procedure TfrmMenu.LaporanKunjunganMarketing1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Laporan Kunjungan Marketing' then
   begin
      ShowForm(TfrmLapKunjunganMarketing).Show;
   end;
end;

procedure TfrmMenu.LaporanPenjualanMarketing1Click(Sender: TObject);
begin

if ActiveMDIChild.Caption <> 'Laporan Penjualan Marketing' then
   begin
      ShowForm(TfrmListJualMarketing).Show;
   end;
end;

procedure TfrmMenu.LaporanEstimasiSalesmanvsRealisasi1Click(
  Sender: TObject);
begin
   if ActiveMDIChild.Caption <> 'Laporan Estimasi Salesman' then
   begin
      ShowForm(TfrmBrowseEstimasiSales).Show;
   end;

end;

procedure TfrmMenu.Kirimdatakepusat1Click(Sender: TObject);
begin
   if ActiveMDIChild.Caption <> 'Kirim data ke pusat' then
   begin
      ShowForm(Tfrmupload).Show;
   end;

end;

procedure TfrmMenu.bacafile2;
var
s:string;
tsql:TmyQuery;

 begin
   s:='select ahost,adatabase,auser,apassword from tsetingdb where nama like '+Quot('default2') +';';
   tsql:=xOpenQuery(s,frmmenu.conn);
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



procedure TfrmMenu.dxPermintaanBarangClick(Sender: TObject);
begin
if ActiveMDIChild.Caption <> 'Permintaan Barang' then
 begin
    ShowForm(TfrmBrowsePermintaanBarang).Show;
 end;
end;

procedure TfrmMenu.dxtagihanekspedisiClick(Sender: TObject);
begin
   if ActiveMDIChild.Caption <> 'Tagihan Ekspedisi' then
 begin
    ShowForm(TfrmBrowseTagihanEkspedisi).Show;
 end;
end;

procedure TfrmMenu.VerifikasiAbsensi1Click(Sender: TObject);
begin
     if ActiveMDIChild.Caption <> 'Verifikasi Absensi' then
 begin
    ShowForm(TfrmVerifikasiAbsensi).Show;
 end;
end;

procedure TfrmMenu.dxkendaraanClick(Sender: TObject);
begin
   if ActiveMDIChild.Caption <> 'Browse Jenis Customer' then
 begin
    ShowForm(TfrmBrowseJeniskendaraan).Show;
 end;

end;

procedure TfrmMenu.LaporanAbsensi1Click(Sender: TObject);
begin
   if ActiveMDIChild.Caption <> 'Laporana Absensi' then
 begin
    ShowForm(TfrmLapAbsensi).Show;
 end;

end;

procedure TfrmMenu.dxekspedisiClick(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Ekspedisi' then
 begin
    ShowForm(TfrmBrowseEkspedisi).Show;
 end;

end;

procedure TfrmMenu.dxserahterima2Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Serah Terima Faktur Salesman' then
 begin
    ShowForm(TfrmBrowseSerahTerimaFaktur2).Show;
 end;
end;

procedure TfrmMenu.LaporanSalesBulananNew1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Lap Sales Dep' then
 begin
    ShowForm(TfrmLapBulanan5).Show;
 end;

end;

procedure TfrmMenu.LoadMenu(const AUser: string);
  var
  s: string;
  tsql: TmyQuery;
begin
   hakUser := TStringList.Create;
  hakUser.Sorted := True;
  hakUser.Duplicates := dupIgnore;

  s := 'SELECT hak_men_id FROM thakuser WHERE trim(hak_user_kode) = '+Quot(AUser)+';';
  tsql:=xOpenQuery(s,frmmenu.conn);

  try

       with  tsql do
       begin
         if not eof then
         begin
            hakUser.Add(fieldbyname('hak_men_id').AsString);
            Next;
        end;
      end;
   finally
     tsql.Free;
   end;
end;

procedure TfrmMenu.SembunyikanMenu(AMainMenu: TMainMenu);
var
  i: Integer;
begin
  for i := 0 to AMainMenu.Items.Count - 1 do
    HideMenuItem(AMainMenu.Items[i]);
end;

procedure TfrmMenu.HideMenuItem(AMenuItem: TMenuItem);
var
  i: Integer;
begin
  AMenuItem.Visible := False;

  for i := 0 to AMenuItem.Count - 1 do
    HideMenuItem(AMenuItem.Items[i]);
end;

procedure TfrmMenu.ApplyNavBarItems(ANavBar: TdxNavBar);
var
  i: Integer;
begin
  for i := 0 to ANavBar.Items.Count - 1 do
  begin
    ANavBar.Items[i].Visible :=
      hakUser.IndexOf(IntToStr(ANavBar.Items[i].Tag)) >= 0;
  end;
end;

procedure TfrmMenu.ApplyNavBarGroups(ANavBar: TdxNavBar);
var
  g, l: Integer;
  AGroup: TdxNavBarGroup;
begin
  for g := 0 to ANavBar.Groups.Count - 1 do
  begin
    AGroup := ANavBar.Groups[g];
    AGroup.Visible := False;

    for l := 0 to AGroup.LinkCount - 1 do
      if AGroup.Links[l].Item.Visible then
      begin
        AGroup.Visible := True;
        Break;
      end;
  end;
end;

function TfrmMenu.ApplyMainMenuAccess(AMenuItem: TMenuItem): Boolean;
var
  i: Integer;
  ChildVisible: Boolean;
begin
  ChildVisible := False;

  for i := 0 to AMenuItem.Count - 1 do
    if ApplyMainMenuAccess(AMenuItem.Items[i]) then
      ChildVisible := True;

  if AMenuItem.Tag <> 0 then
    AMenuItem.Visible :=
      hakUser.IndexOf(IntToStr(AMenuItem.Tag)) >= 0
  else
    AMenuItem.Visible := ChildVisible;

  Result := AMenuItem.Visible or ChildVisible;
end;

procedure TfrmMenu.ApplyMainMenu(AMainMenu: TMainMenu);
var
  i: Integer;
begin
  for i := 0 to AMainMenu.Items.Count - 1 do
    ApplyMainMenuAccess(AMainMenu.Items[i]);
end;

procedure TfrmMenu.tmrHeartbeatTimer(Sender: TObject);
begin
  try
    if conn.Connected then
      conn.Ping
    else
      conn.Connect;
  except
    on E: Exception do
    begin
      try
        conn.Disconnect;
        conn.Connect;
      except
        // sengaja dikosongkan biar user tidak panik
      end;
    end;
  end;
end;

procedure TfrmMenu.dxSettingFeeMarketingClick(Sender: TObject);
begin
     if ActiveMDIChild.Caption <> 'Setting Fee Marketing' then
   begin
      ShowForm(TfrmBrowseSetingFeeMarketing).Show;
   end;
end;

procedure TfrmMenu.ProsesFeeMarketing1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Proses Fee Marketing' then
   begin
      ShowForm(TfrmProsesFeeMarketing).Show;
   end;

end;

end.
