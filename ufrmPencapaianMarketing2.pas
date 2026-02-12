unit ufrmPencapaianMarketing2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  DBClient, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxSpinEdit, cxButtonEdit, cxTextEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, AdvEdBtn, cxCurrencyEdit,
  cxRadioGroup, AdvCombo, MyAccess;

type
  TfrmPencapaianMarketing = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxButton1: TcxButton;
    AdvPanel4: TAdvPanel;
    cxButton7: TcxButton;
    SaveDialog1: TSaveDialog;
    PopupMenu1: TPopupMenu;
    LihatDetail1: TMenuItem;
    Pencapaian1: TMenuItem;
    cxRadioButton1: TcxRadioButton;
    cxRadioButton2: TcxRadioButton;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clNama: TcxGridDBColumn;
    clTarget: TcxGridDBColumn;
    clRealisasi: TcxGridDBColumn;
    clcapai: TcxGridDBColumn;
    clHet: TcxGridDBColumn;
    clPenjualan: TcxGridDBColumn;
    clPresentase: TcxGridDBColumn;
    clPengali: TcxGridDBColumn;
    clInsentif: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    clPersen: TcxGridDBColumn;
    Label1: TLabel;
    cbbBulan: TAdvComboBox;
    edtTahun: TComboBox;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure initgrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton8Click(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure cxButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxButton7Click(Sender: TObject);
    procedure cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems4GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);

  private
    FFLAGEDIT: Boolean;
    FID: string;


    { Private declarations }
  protected
    FCDS: TClientDataSet;

  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmPencapaianMarketing: TfrmPencapaianMarketing;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,cxgridExportlink,uReport;

{$R *.dfm}

procedure TfrmPencapaianMarketing.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
end;

procedure TfrmPencapaianMarketing.refreshdata;
begin
  FID:='';
  edttahun.text :=  FormatDateTime('yyyy',Date);
  initgrid;
end;
procedure TfrmPencapaianMarketing.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;

end;

procedure TfrmPencapaianMarketing.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
      Release;
  end;


end;

procedure TfrmPencapaianMarketing.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmPencapaianMarketing.loaddata;
var
  sfilter,s,ss: string;
  tsql,tsql2 : TmyQuery;
  i:Integer;

begin
  if cxRadioButton1.Checked then
     sfilter :=  ' where pmh_nomor like '+Quot('MEDIA%')
  else
     sfilter :=  ' where pmh_nomor like '+Quot('N3%');

  s:= 'SELECT pmh_nama Nama,IFNULL(realisasi_bsm,0) Bsm,IFNULL(realisasi_bsm_value,0) Bsm_Value,'
+ ' IFNULL(realisasi_krm,0) Krm,IFNULL(realisasi_krm_value,0) Krm_Value,'
+ ' IFNULL(realisasi_bsm,0) + IFNULL(realisasi_krm,0) Total_Realisasi,'
+ ' IFNULL(realisasi_bsm_value,0) + IFNULL(realisasi_krm_value,0) Total_Realisasi_Value,'
+ ' IFNULL(target,0) Target,IFNULL(target,0)*pmh_het_bawah Target_Value'
+ '  FROM'
+ ' (SELECT pmh_nomor,pmh_nama,pmh_het_bawah,'
+ ' (SELECT SUM(fpd_qty)  FROM tprodukmarketing_hdr'
+ ' inner join tprodukmarketing_dtl ON pmh_nomor=pmd_pmh_nomor'
+ ' INNER  JOIN tfp_dtl ON fpd_brg_kode=pmd_brg_kode'
+ ' inner JOIN tfp_hdr ON fp_nomor=fpd_fp_nomor'
+ ' INNER JOIN tsalescustomer  ON sc_cus_kode=fp_cus_kode'
+ ' WHERE MONTH(fp_tanggal)=' + IntToStr(cbbBulan.itemindex +1)+ ' AND YEAR(fp_tanggal)='+edttahun.Text
+ ' AND pmh_nomor=x.pmh_nomor) realisasi_bsm,'
+ ' (SELECT'
+ ' sum((100-fpd_discpr)*(fpd_harga*fpd_qty)/100) -'
+ ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*fpd_qty/100) -'
+ ' sum(fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)*fpd_qty/100)+sum(fpd_bp_rp*fpd_qty)'
+ ' FROM tprodukmarketing_hdr'
+ ' inner join tprodukmarketing_dtl ON pmh_nomor=pmd_pmh_nomor'
+ ' INNER  JOIN tfp_dtl ON fpd_brg_kode=pmd_brg_kode'
+ ' inner JOIN tfp_hdr ON fp_nomor=fpd_fp_nomor'
+ ' INNER JOIN tsalescustomer  ON sc_cus_kode=fp_cus_kode'
+ ' WHERE MONTH(fp_tanggal)= ' + IntToStr(cbbBulan.itemindex +1)+ '  AND YEAR(fp_tanggal)='+ edtTahun.Text
+ ' AND pmh_nomor=x.pmh_nomor) realisasi_bsm_value,'
+ ' (SELECT SUM(fpd_qty)  FROM krm.tprodukmarketing_hdr'
+ ' inner join krm.tprodukmarketing_dtl ON pmh_nomor=pmd_pmh_nomor'
+ ' INNER  JOIN krm.tfp_dtl ON fpd_brg_kode=pmd_brg_kode'
+ ' inner JOIN krm.tfp_hdr ON fp_nomor=fpd_fp_nomor'
+ ' INNER JOIN krm.tsalescustomer  ON sc_cus_kode=fp_cus_kode'
+ ' WHERE MONTH(fp_tanggal)='+ IntToStr(cbbBulan.itemindex +1) +' AND YEAR(fp_tanggal)='+ edtTahun.Text
+ ' AND pmh_nomor=x.pmh_nomor) realisasi_krm,'
+ ' (SELECT'
+ ' sum((100-fpd_discpr)*(fpd_harga*fpd_qty)/100) -'
+ ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*fpd_qty/100) -'
+ ' sum(fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)*fpd_qty/100)+sum(fpd_bp_rp*fpd_qty)'
+ ' FROM krm.tprodukmarketing_hdr'
+ ' inner join krm.tprodukmarketing_dtl ON pmh_nomor=pmd_pmh_nomor'
+ ' INNER  JOIN krm.tfp_dtl ON fpd_brg_kode=pmd_brg_kode'
+ ' inner JOIN krm.tfp_hdr ON fp_nomor=fpd_fp_nomor'
+ ' INNER JOIN krm.tsalescustomer  ON sc_cus_kode=fp_cus_kode'
+ ' WHERE MONTH(fp_tanggal)='+ IntToStr(cbbBulan.itemindex +1)+' AND YEAR(fp_tanggal)='+ edtTahun.Text
+ ' AND pmh_nomor=x.pmh_nomor) realisasi_krm_value,'
+ ' (select SUM(pmd2_target) FROM tprodukmarketing_dtl2 WHERE pmd2_pmh_nomor=pmh_Nomor) target'
+ ' FROM tprodukmarketing_hdr X) a'
+ sfilter ;



  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
   try

    CDS.EmptyDataSet;
    while  not Eof do
    begin
      CDS.Append;
      CDS.FieldByName('nama').AsString  := fieldbyname('nama').AsString;
      CDS.FieldByName('bsm').Asfloat  := fieldbyname('bsm').AsFloat;
      CDS.FieldByName('bsm_value').AsFloat  := fieldbyname('bsm_value').AsFloat;
      CDS.FieldByName('krm').AsFloat  := fieldbyname('krm').AsFloat;
      CDS.FieldByName('krm_value').AsFloat  := fieldbyname('krm_value').AsFloat;
      CDS.FieldByName('total_realisasi').AsFloat  := fieldbyname('total_realisasi').AsFloat;
      CDS.FieldByName('total_realisasi_value').AsFloat  := fieldbyname('total_realisasi_value').AsFloat;
      CDS.FieldByName('target').AsFloat := fieldbyname('target').AsFloat;
      CDS.FieldByName('target_value').AsFloat := fieldbyname('target_value').AsFloat;
      if fieldbyname('target_value').AsFloat > 0 then
      CDS.FieldByName('persen').AsFloat := fieldbyname('total_realisasi_value').AsFloat/fieldbyname('target_value').AsFloat*100
      else
      CDS.FieldByName('persen').AsFloat := 0;

      CDS.Post;
      i:=i+1;
      next;
    end;

   finally
    Free;
   end;

  end;


end;


procedure TfrmPencapaianMarketing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmPencapaianMarketing.cxButton8Click(Sender: TObject);
begin
Release;
end;

function TfrmPencapaianMarketing.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Nama', ftString, False,200);
    zAddField(FCDS, 'BSM', ftFloat, False);
    zAddField(FCDS, 'BSM_Value', ftFloat, False);
    zAddField(FCDS, 'krm', ftFloat, False);
    zAddField(FCDS, 'krm_value', ftFloat, False);
    zAddField(FCDS, 'total_realisasi', ftFloat, False);
    zAddField(FCDS, 'total_realisasi_value', ftFloat, False);
    zAddField(FCDS, 'target', ftFloat, False);
    zAddField(FCDS, 'target_value', ftFloat, False);
    zAddField(FCDS, 'persen', ftFloat, False);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;
procedure TfrmPencapaianMarketing.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmPencapaianMarketing.cxButton1Click(Sender: TObject);
begin
loaddata;

end;

procedure TfrmPencapaianMarketing.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmPencapaianMarketing.cxButton7Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid);
     end;

end;

procedure TfrmPencapaianMarketing.cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems4GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('total_realisasi_value')) > 0  then
       capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('total_realisasi_value'))/ cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('target_value'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

end.
