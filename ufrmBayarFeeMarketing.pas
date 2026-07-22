unit ufrmBayarFeeMarketing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox, DBClient, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxSpinEdit, cxCurrencyEdit, AdvEdBtn,DateUtils,
  cxCalendar, cxCheckBox, MyAccess;

type
  TfrmBayarFeeMarketing = class(TForm)
    PANEL: TAdvPanel;
    Label2: TLabel;
    edtNomor: TAdvEdit;
    Label3: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    Label1: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    cxLookupCustomer: TcxExtLookupComboBox;
    AdvPanel4: TAdvPanel;
    te: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clInvoice: TcxGridDBColumn;
    clTglInvoice: TcxGridDBColumn;
    clJthTempo: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lbljudul: TLabel;
    dtTanggal: TDateTimePicker;
    Label6: TLabel;
    edtAlamat: TAdvEdit;
    clBayar: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    clStatus: TcxGridDBColumn;
    cxLookupRekeningCash: TcxExtLookupComboBox;
    Label8: TLabel;
    edtNilaiCash: TAdvEdit;
    LihatFakturPenjualan1: TMenuItem;
    clKontrak: TcxGridDBColumn;
    Label4: TLabel;
    Label5: TLabel;
    edtKeterangan: TAdvEdit;
    clstatusBayar: TcxGridDBColumn;
    procedure refreshdata;
   procedure initgrid;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function getmaxkode:string;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure HapusRecord1Click(Sender: TObject);
    procedure dtTanggalChange(Sender: TObject);
    procedure simpandata;
    function cekdata:Boolean;
    procedure loaddataInvoice(akode : string);
    procedure loaddataall(akode : string);
    procedure cxLookupcustomerPropertiesEditValueChanged(Sender: TObject);
    procedure clStatusPropertiesEditValueChanged(Sender: TObject);
    procedure clBayarPropertiesEditValueChanged(Sender: TObject);
    procedure hitung;
    procedure cxGrdMainDataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
    procedure clBayarPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cxGrdMainCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure LihatFakturPenjualan1Click(Sender: TObject);
    procedure chkPajakClick(Sender: TObject);
  private
    FCDScustomer: TClientDataset;
    FCDSRekeningCash: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;

    function GetCDScustomer: TClientDataset;
    function GetCDSRekeningCash: TClientDataset;


    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDScustomer: TClientDataset read GetCDScustomer write FCDScustomer;
    property CDSRekeningCash: TClientDataset read GetCDSRekeningCash write
        FCDSRekeningCash;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
        procedure doslip(anomor : string );
    { Public declarations }
  end;

var
  frmBayarFeeMarketing: TfrmBayarFeeMarketing;
const
   NOMERATOR = 'CF';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmfp;

{$R *.dfm}

procedure TfrmBayarFeeMarketing.refreshdata;
begin
  FID:='';

  FLAGEDIT := False;
  dtTanggal.DateTime := Date;
  edtnomor.Text := getmaxkode;
  cxLookupcustomer.EditValue := '';
  cxLookupRekeningCash.EditValue := '';
  edtNilaiCash.Text := '0';
  edtAlamat.Clear;
  edtKeterangan.Clear;
  cxLookupcustomer.SetFocus;
  initgrid;

end;

procedure TfrmBayarFeeMarketing.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('bayar').AsCurrency    := 0;
  CDS.Post;

end;
procedure TfrmBayarFeeMarketing.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmBayarFeeMarketing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmBayarFeeMarketing.getmaxkode:string;
var
  s:string;
begin
 s:='select max(right(byf_nomor,4)) from tbayarfm_hdr where byf_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%');
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+1),4)
      else
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+fields[0].AsInteger+1),4);
    finally
      free;
    end;
  end;
end;

procedure TfrmBayarFeeMarketing.cxButton1Click(Sender: TObject);
begin
    try
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;
    
      If not cekdata then exit;

      if (FLAGEDIT) and ( not cekedit(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Edit di Modul ini',mtWarning, [mbOK],0);
           Exit;
        End;
         if (not FLAGEDIT) and ( not cekinsert(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Insert di Modul ini',mtWarning, [mbOK],0);;
           Exit;
        End;

      if MessageDlg('Yakin ingin simpan ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;

      simpandata;
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     
     Exit;
   end;
    
end;

procedure TfrmBayarFeeMarketing.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmBayarFeeMarketing.cxButton2Click(Sender: TObject);
begin
   try
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;
   
     If not cekdata then exit;

      if (FLAGEDIT) and ( not cekedit(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Edit di Modul ini',mtWarning, [mbOK],0);
           Exit;
        End;
         if (not FLAGEDIT) and ( not cekinsert(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Insert di Modul ini',mtWarning, [mbOK],0);;
           Exit;
        End;

      if MessageDlg('Yakin ingin simpan ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;

      simpandata;
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     
     Exit;
   end;
    
    Release;
end;

procedure TfrmBayarFeeMarketing.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupcustomer.Properties) do
    LoadFromCDS(CDScustomer, 'Kode','customer',['Kode'],Self);
     TcxExtLookupHelper(cxLookupcustomer.Properties).SetMultiPurposeLookup;

    with TcxExtLookupHelper(cxLookupRekeningCash.Properties) do
    LoadFromCDS(CDSRekeningCash, 'Kode','Rekening',['Kode'],Self);

     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);

end;

function TfrmBayarFeeMarketing.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Invoice', ftString, False,20);
    zAddField(FCDS, 'Tanggal', ftDate, False);
    zAddField(FCDS, 'JthTempo', ftDate, False, 10);
    zAddField(FCDS, 'Biaya_promosi', ftFloat, False);
    zAddField(FCDS, 'Bayar', ftFloat, False);
    zAddField(FCDS, 'pay', ftInteger, False);
    zAddField(FCDS, 'Status', ftString, False,20);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmBayarFeeMarketing.GetCDScustomer: TClientDataset;
var s:String;
begin
  If not Assigned(FCDScustomer) then
  begin
    S := 'select cus_nama as customer, cus_kode Kode, cus_alamat Alamat,cus_telp'
        +' from tcustomer order by cus_nama ';


    FCDScustomer := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDScustomer;
end;

procedure TfrmBayarFeeMarketing.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmBayarFeeMarketing.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmBayarFeeMarketing.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;


procedure TfrmBayarFeeMarketing.dtTanggalChange(Sender: TObject);
var
  anomorold:string;
begin
   anomorold := edtNomor.Text;
  edtNomor.Text := getmaxkode;
  if FLAGEDIT then
  begin
    if edtNomor.Text <> anomorold then
    begin
      showmessage('Perubahan tanggal tidak bisa beda bulan dan tahun');
      edtNomor.Text := anomorold;
      dtTanggal.date := Date;

    end;
  end;
end;


procedure TfrmBayarFeeMarketing.simpandata;
var
  s:string;
  atax,i:integer;
  tt:TStrings;

begin
  if FLAGEDIT then
    s:='update tbayarfm_hdr set '
      + ' byf_cus_kode = ' + Quot(cxLookupcustomer.EditValue) + ','
      + ' byf_tanggal = ' + Quotd(dtTanggal.Date)+','
      + ' byf_nilai = ' + FloatToStr(cStrToFloat(edtNilaiCash.Text))+','
      + ' byf_rek_kode =  '+ Quot(cxLookupRekeningCash.EditValue) + ','
      + ' byf_keterangan = ' + Quot(edtKeterangan.Text) + ','
      + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
      + ' user_modified = ' + Quot(frmMenu.KDUSER)
      + ' where byf_nomor = ' + quot(FID) + ';'
  else
  begin
    edtNomor.Text := getmaxkode;
    s :=  ' insert into tbayarfm_hdr '
        + ' (byf_nomor,byf_tanggal,byf_cus_kode,byf_keterangan,'
        + ' byf_nilai,byf_rek_kode'
        + ' ,date_create,user_create) '
        + ' values ( '
        + Quot(edtNomor.Text) + ','
        + Quotd(dtTanggal.Date) + ','
        + Quot(cxLookupcustomer.EditValue)+','
        + Quot(edtKeterangan.Text) + ','
        + FloatToStr(cStrToFloat(edtNilaiCash.Text))+','
        + Quot(cxLookupRekeningCash.EditValue) + ','
        + QuotD(cGetServerTime,True) + ','
        + Quot(frmMenu.KDUSER)+')';
  end;

  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  tt := TStringList.Create;

  s:= ' delete from tbayarfm_dtl '
    + ' where  byfd_byf_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('bayar').AsFloat >  0 then
   begin
    S:='insert into tbayarfm_dtl (byfd_byf_nomor, byfd_fp_nomor, byfd_fee_marketing, byfd_bayar) values ('
      + Quot(edtNomor.Text) +','
      + quot(CDS.FieldByName('INVOICE').AsString) +','
     + FloatToStr(CDS.FieldByName('Biaya_promosi').AsFloat)+','
      + FloatToStr(CDS.FieldByName('bayar').AsFloat)
      + ');';
    tt.Append(s);
   end;
    CDS.Next;
    Inc(i);
  end;

  try
    for i:=0 to tt.Count -1 do
    begin
      EnsureConnected(frmMenu.conn);
      ExecSQLDirect(frmMenu.conn, tt[i]);
    end;
  finally
    tt.Free;
  end;
end;


function TfrmBayarFeeMarketing.cekdata:Boolean;
var
  i:integer;
  abayar,atotal : double;
begin
  result:=true;
   i := 1;
     If cxLookupcustomer.EditValue = '' then
    begin
      ShowMessage('customer belum di pilih');
      result:=false;
      Exit;

    end;

   If (cxLookupRekeningCash.EditValue = '') then
    begin
      ShowMessage('Rekening belum di pilih');
      result:=false;
      Exit;
    end;

  CDS.First;
  While not CDS.Eof do
  begin

    If (CDS.FieldByName('pay').AsInteger = 1)  and (CDS.FieldByName('bayar').AsFloat = 0) then
    begin
      ShowMessage('Baris : ' + inttostr(i) + ' Pembayaran masih nol');
      result:=false;
      Exit;
    end;

    inc(i);
    CDS.Next;
  end;

  atotal := cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('bayar'));
  abayar := cStrToFloat(edtNilaiCash.Text) ;
  if ((atotal - abayar) > 1) or ((atotal - abayar) < -1) then
  begin
      ShowMessage('Pembayaran dengan Total '+floattostr(atotal)+' yang di bayar Beda '+floattostr(abayar));
      result:=false;
      Exit;
  end;



end;

procedure TfrmBayarFeeMarketing.loaddataInvoice(akode : string);
var
  s: string ;
  tsql : TmyQuery;
  i:Integer;
begin


  s := ' select fp_nomor,fp_tanggal,fp_jthtempo,((fp_biayapr2*(fp_amount-fp_taxamount - ifnull((select sum(retj_amount) from tretj_hdr where retj_fp_nomor = fp_nomor),0))/100)+fp_biayarp2) Fee_Marketing, '
      + ' ifnull((select sum(byfd_bayar) from tbayarfm_dtl where byfd_fp_nomor=fp_nomor),0) klaim ,'
      + ' case when fp_isbayar=1 then "Sudah" else "Belum" end Status '
      + ' from tfp_hdr '
     + ' where fp_cus_kode = '+ Quot(akode);


     if FLAGEDIT = False then
    s := s + ' having klaim < Fee_Marketing  and Fee_Marketing > 0' ;

     s:= s + ' order by fp_tanggal ';

    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
             CDS.EmptyDataSet;
            if not eof then
         begin

            i:=1;

            while  not Eof do
             begin

                      CDS.Append;
                      CDS.FieldByName('invoice').AsString        := fieldbyname('fp_nomor').AsString;
                      CDS.FieldByName('tanggal').AsDateTime  := fieldbyname('fp_tanggal').AsDateTime;
                      CDS.FieldByName('JthTempo').AsDateTime      := fieldbyname('fp_jthtempo').AsDateTime;
                      CDS.FieldByName('Biaya_Promosi').AsFloat      := fieldbyname('Fee_Marketing').AsFloat - fieldbyname('klaim').AsFloat;
                      CDS.FieldByName('bayar').AsFloat       := 0;
                      CDS.FieldByName('status').AsString        := fieldbyname('status').AsString;
                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
        end
        else
        begin
          cxLookupcustomer.SetFocus;
        end;
      end;
   finally
     tsql.Free;
   end;

end;


procedure TfrmBayarFeeMarketing.loaddataall(akode : string);
var
  s: string ;
  tsql : TmyQuery;
  a,i:Integer;
  aketemu:Boolean;
  aqtypo,qtyterima : Integer;
begin
  if akode = '' then
  begin
    flagedit := false;
    Exit ;
  end;
  s := ' select '
     + ' byf_nomor,byf_tanggal,byf_cus_kode,byf_memo,byf_rek_kode,byf_nilai,'
     + ' byfd_fp_nomor,byfd_bayar,byf_keterangan, fee_marketing '
     + ' from tbayarfm_hdr inner join tbayarfm_dtl a on byf_nomor=byfd_byf_nomor'
     + ' where byf_nomor = '+ Quot(akode);

    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            FID :=fieldbyname('byf_nomor').AsString;
            edtnomor.Text := fieldbyname('byf_nomor').AsString;
            dttanggal.DateTime := fieldbyname('byf_tanggal').AsDateTime;
            cxLookupcustomer.EditValue  := fieldbyname('byf_cus_kode').AsString;
            cxLookupRekeningCash.EditValue := fieldbyname('byf_rek_kode').AsString;
            edtNilaiCash.Text :=  fieldbyname('byf_nilai').AsString;
            edtKeterangan.Text := fieldbyname('byf_keterangan').AsString;
            i:=1;
            while  not Eof do
            begin
                CDS.first;


                while not CDS.Eof do
                begin
                 if CDS.FieldByName('invoice').AsString = FieldByName('byfd_fp_nomor').AsString then
                 begin
                    If CDS.State <> dsEdit then CDS.Edit;
                    CDS.FieldByName('bayar').AsFloat :=fieldbyname('byfd_bayar').AsFloat;
                    CDS.FieldByName('biaya_promosi').AsFloat :=CDS.FieldByName('fee_marketing').AsFloat+fieldbyname('bybd_bayar').AsFloat;

                    CDS.FieldByName('pay').AsInteger := 1;
                    CDS.Post;
                 end;
                  CDS.Next;
                  Inc(i);

                end;
              next;
            end ;
        end
        else
        begin
          ShowMessage('Nomor  tidak di temukan');
          dttanggal.SetFocus;
        end;
      end;
   finally
     tsql.Free;


   end;

end;

procedure TfrmBayarFeeMarketing.cxLookupcustomerPropertiesEditValueChanged(
  Sender: TObject);
begin
  loaddataInvoice(cxLookupcustomer.EditValue);
  edtAlamat.Text := CDScustomer.Fields[2].AsString;
end;

function TfrmBayarFeeMarketing.GetCDSRekeningCash: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSRekeningCash) then
  begin
    S := 'select rek_nama as Rekening, rek_kode Kode '
        +' from trekening';


    FCDSRekeningCash := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSRekeningCash;
end;

procedure TfrmBayarFeeMarketing.clStatusPropertiesEditValueChanged(
  Sender: TObject);
begin
   CDS.Post;
   If CDS.State <> dsEdit then CDS.Edit;
  if CDS.FieldByName('pay').AsInteger = 1 then
     CDS.FieldByName('bayar').AsFloat :=CDS.FieldByName('biaya_promosi').AsFloat
  else
     CDS.FieldByName('bayar').AsFloat := 0;
  cds.post;

end;

procedure TfrmBayarFeeMarketing.clBayarPropertiesEditValueChanged(
  Sender: TObject);
begin
 CDS.Post;

end;

procedure TfrmBayarFeeMarketing.hitung;
var
  asubtotal : Double;
begin
  asubtotal :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('bayar'));
end;

procedure TfrmBayarFeeMarketing.cxGrdMainDataControllerSummaryAfterSummary(
  ASender: TcxDataSummary);
begin
hitung;
end;

procedure TfrmBayarFeeMarketing.clBayarPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
 var
   i:integer;
  akurang:double;
begin

  akurang :=0;

    i:=cxGrdMain.DataController.FocusedRecordIndex;


    if cVarTofloat(DisplayValue) >  cVarTofloat(cxGrdMain.DataController.Values[i,clKontrak.index]) then
    begin
      error := true;
        ErrorText :='Pembayarana melebihi kurang Bayar';
        exit;
    end;

end;


procedure TfrmBayarFeeMarketing.doslip(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin

  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'BYF';

          s:= ' select '
       + ' * ,terbilang(byf_nilai) terbilang '
       + ' from tbayarfm_hdr '
       + ' inner join tbayarfm_dtl on byf_nomor=byfd_byf_nomor'
       + ' inner join tfp_hdr on fp_nomor=byfd_fp_nomor'
       + ' inner join tcustomer on byf_cus_kode=cus_kode '
       + ' LEFT join trekening a on a.rek_kode=byf_rek_kode '
       + ' where '
       + ' byf_nomor=' + quot(anomor);
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;


procedure TfrmBayarFeeMarketing.cxGrdMainCellDblClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
ShowMessage('s');
end;

procedure TfrmBayarFeeMarketing.LihatFakturPenjualan1Click(Sender: TObject);
var
  frmFP: TfrmFP;
begin
  inherited;
  If CDS.FieldByname('Invoice').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Faktur Penjualan' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmFP  := frmmenu.ShowForm(TfrmFP) as TfrmFP;
      frmFP.ID := CDS.FieldByname('Invoice').AsString;
      frmFP.FLAGEDIT := True;
      frmFP.edtnOMOR.Text := CDS.FieldByname('Invoice').AsString;
      frmFP.loaddataall(CDS.FieldByname('Invoice').AsString);
//      if cekbayar(CDS.FieldByname('Invoice').AsString) = 1 then
//      begin
//        ShowMessage('Transaksi ini sudah ada pembayaran,Tidak dapat di edit');
//        frmFP.cxButton2.Enabled :=False;
//        frmFP.cxButton1.Enabled :=False;
//        frmFP.cxButton3.Enabled := False;
//      end;
   end;
   frmFP.Show;
end;


procedure TfrmBayarFeeMarketing.chkPajakClick(Sender: TObject);
begin
loaddataInvoice(cxLookupCustomer.EditValue);
end;

end.
