unit ufrmProsesFeeMarketing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids,  AdvGrid, ComCtrls, StdCtrls, AdvEdit, ExtCtrls,
  AdvPanel, AdvCGrid, BaseGrid,SqlExpr, DBAdvGrd, DB, DBClient, Provider,
  FMTBcd, RAWPrinter, StrUtils, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxDBData, cxSpinEdit, cxCalendar, Menus, cxButtons, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxButtonEdit, cxCurrencyEdit,ExcelXP,ComObj,
  AdvCombo,DateUtils, cxPC;

type
  TfrmProsesFeeMarketing = class(TForm)
    AdvPanel1: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel2: TAdvPanel;
    Label3: TLabel;
    Label5: TLabel;
    RAWPrinter1: TRAWPrinter;
    AdvPanel4: TAdvPanel;
    cxButton8: TcxButton;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    OpenDialog1: TOpenDialog;
    cbbBulan: TAdvComboBox;
    edtTahun: TComboBox;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    MainMenu1: TMainMenu;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    private
      { Private declarations }
     protected
  public
    { Public declarations }
  end;

var
  frmProsesFeeMarketing: TfrmProsesFeeMarketing;

implementation

uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport;

{$R *.dfm}

procedure TfrmProsesFeeMarketing.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Release;
end;

procedure TfrmProsesFeeMarketing.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     SelectNext(ActiveControl,True,True);
end;

procedure TfrmProsesFeeMarketing.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmProsesFeeMarketing.cxButton1Click(Sender: TObject);
var
  s:string;

begin
  cShowWaitWindow();
  s:='update '
  + ' tfeemarketing_hdr inner join tfeemarketing_dtl on fmh_nomor=fmd_fmh_nomor '
  + ' inner join tfp_hdr on fp_cus_kode=fmh_cus_kode '
  + ' inner join tfp_dtl on fpd_fp_nomor=fp_nomor and fpd_brg_kode=fmd_brg_kode '
  + ' set fpd_bp_rp2=fmd_rupiah,fpd_bp_pr2=fmd_persen '
  + ' where month(fp_tanggal)='+inttostr(cbbBulan.ItemIndex+1)+' and year(fp_tanggal)='+ edtTahun.Text;
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  s:= 'update tfp_hdr b inner join ( '
+ ' select fp_nomor,sum((((100-fpd_discpr)*fpd_harga*(fpd_qty-ifnull(retjd_qty,0))/100)*fpd_bp_pr2/100)+fpd_bp_rp2*(fpd_qty-ifnull(retjd_qty,0))) nilai from tfp_hdr'
+ ' inner join tfp_dtl on fp_nomor=fpd_fp_nomor'
+ ' LEFT JOIN Tretj_hdr on retj_fp_nomor=fp_nomor '
+ ' left join tretj_dtl on retjd_retj_nomor=retj_nomor and fpd_brg_kode=retjd_brg_kode'
+ ' where month(fp_tanggal)='+inttostr(cbbBulan.ItemIndex+1)+' and year(fp_tanggal)='+ edtTahun.Text
+ ' and (fpd_bp_pr2 > 0 or fpd_bp_rp2 > 0) '
+ ' group by fp_nomor) a on a.fp_nomor=b.FP_nomor '
+ ' set fp_biayarp2=nilai ' ;

  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
  cCloseWaitWindow();

showmessage('Proses Fee Marketing Selesaai')
end;

end.
