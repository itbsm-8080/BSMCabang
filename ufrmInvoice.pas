unit ufrmInvoice;

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
  TfrmInvoice = class(TForm)
    PANEL: TAdvPanel;
    Label2: TLabel;
    edtNomor: TAdvEdit;
    Label3: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    Label1: TLabel;
    Label4: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    cxLookupSupplier: TcxExtLookupComboBox;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clSKU: TcxGridDBColumn;
    clNamaBarang: TcxGridDBColumn;
    clQTY: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lbljudul: TLabel;
    dtTanggal: TDateTimePicker;
    AdvPanel5: TAdvPanel;
    Label6: TLabel;
    edtAlamat: TAdvEdit;
    edtmemo: TMemo;
    Label10: TLabel;
    clSatuan: TcxGridDBColumn;
    Label5: TLabel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    dtTglJT: TDateTimePicker;
    edtNomorBPB: TAdvEditBtn;
    chkPajak: TCheckBox;
    edtDiscpr: TAdvEdit;
    edtDisc: TAdvEdit;
    edtPPN: TAdvEdit;
    edtTotal: TAdvEdit;
    edtDiscFaktur: TAdvEdit;
    clHarga: TcxGridDBColumn;
    clDisc: TcxGridDBColumn;
    procedure refreshdata;
   procedure initgrid;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function getmaxkode(aispajak:Integer=1):string;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure cxLookupsupplierPropertiesChange(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);
    procedure clKetPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);

    procedure dtTanggalChange(Sender: TObject);
    procedure simpandata;
    function cekdata:Boolean;
    procedure loaddataBPB(akode : string);
    procedure loaddataall(akode : string);
    procedure hitung;
    procedure initViewSKU;

    procedure edtNomorBPBClickBtn(Sender: TObject);
    procedure edtDiscprExit(Sender: TObject);
    procedure edtDiscExit(Sender: TObject);
    procedure clDiscPropertiesChange(Sender: TObject);
    procedure doslipInv(anomor : string );
    procedure insertketampungan(anomor:string);
  private
    FCDSSupplier: TClientDataset;
    FCDSSKU : TClientDataset;

    FFLAGEDIT: Boolean;
    FID: string;
    apajak :Integer ;
    function GetCDSSupplier: TClientDataset;




    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;
    property CDSSupplier: TClientDataset read GetCDSSupplier write FCDSSupplier;

    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmInvoice: TfrmInvoice;
const
   NOMERATOR = 'INV';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,ureport;

{$R *.dfm}

procedure TfrmInvoice.refreshdata;
begin
  FID:='';
  FLAGEDIT := False;
  dtTanggal.DateTime := Date;
  dtTglJT.DateTime := Date;
  chkPajak.Checked := true;
  edtnomor.Text := getmaxkode(apajak);
  cxLookupsupplier.EditValue := '';
  edtAlamat.Clear;
  edtmemo.Clear;
  edtNomorBPB.SetFocus;
  initgrid;

end;
procedure TfrmInvoice.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.Post;

end;
procedure TfrmInvoice.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmInvoice.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmInvoice.getmaxkode(aispajak:integer=1):string;
var
  s:string;
begin
  if aispajak=1 then
  begin
  s:='select max(right(inv_nomor,4)) from tINV_hdr inner join tbpb_hdr on bpb_nomor=inv_bpb_nomor '
  + ' inner join tpo_hdr on po_nomor=bpb_po_nomor where inv_nomor like ' + quot(NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
  + ' and po_istax=1 ';
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+1),4)
      else
         result:= NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+fields[0].AsInteger+1),4);

    finally
      free;
    end;
  end;
  end
  else
  begin
    s:='select max(right(inv_nomor,4)) from tINV_hdr inner join tbpb_hdr on bpb_nomor=inv_bpb_nomor '
  + ' inner join  tpo_hdr on po_nomor=bpb_po_nomor where inv_nomor like ' + quot(NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
  + ' and po_istax=0 ';

  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(15000+1),4)
      else
         result:= NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(15000+fields[0].AsInteger+1),4);

    finally
      free;
    end;
  end;
  end;
end;

procedure TfrmInvoice.cxButton1Click(Sender: TObject);
begin
    try
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

procedure TfrmInvoice.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmInvoice.cxButton2Click(Sender: TObject);
begin
   try
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

procedure TfrmInvoice.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupSupplier.Properties) do
    LoadFromCDS(CDSSupplier, 'Kode','supplier',['Kode'],Self);
     TcxExtLookupHelper(cxLookupSupplier.Properties).SetMultiPurposeLookup;



     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);

end;

function TfrmInvoice.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftInteger, False);
    zAddField(FCDS, 'QTY', ftInteger, False);
    zAddField(FCDS, 'Satuan', ftString, False, 10);
    zAddField(FCDS, 'Harga', ftFloat, False);
    zAddField(FCDS, 'Disc', ftFloat, False);
    zAddField(FCDS, 'Total', ftFloat, False);
    zAddField(FCDS, 'expired', ftDate, False, 255);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmInvoice.GetCDSSupplier: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSSupplier) then
  begin
    S := 'select sup_nama as supplier, sup_kode Kode, sup_alamat Alamat,sup_telp'
        +' from tsupplier';


    FCDSSupplier := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSSupplier;
end;

procedure TfrmInvoice.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmInvoice.cxLookupsupplierPropertiesChange(Sender: TObject);
begin
edtAlamat.Text := CDSsupplier.Fields[2].AsString;

end;

procedure TfrmInvoice.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmInvoice.clSKUPropertiesEditValueChanged(Sender: TObject);
begin

 CDS.FieldByName('satuan').AsString := CDSSKU.Fields[2].Asstring;

end;

procedure TfrmInvoice.clKetPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  var
    i:integer ;
begin
   i := cxGrdMain.DataController.FocusedRecordIndex;

 If (cVarToInt(cxGrdMain.DataController.Values[i, clSKU.Index])=0) then
 begin
    Error :=True;
    ErrorText := 'Sku Belum Diinput';

 end;
end;


procedure TfrmInvoice.dtTanggalChange(Sender: TObject);
var
  anomorold:string;
begin
   anomorold := edtNomor.Text;
  edtNomor.Text := getmaxkode(apajak);
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


procedure TfrmInvoice.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;
  aistax : integer;
begin
  if chkPajak.Checked then
    aistax :=  1
  else
    aistax := 0;
if FLAGEDIT then
  s:='update TInv_HDR set '
    + ' Inv_sup_kode = ' + Quot(cxLookupsupplier.EditValue) + ','
    + ' inv_bpb_nomor =' +Quot(edtNomorBPB.Text)+','
    + ' Inv_memo = ' + Quot(edtmemo.Text) + ','
    + ' Inv_disc_faktur =' + floattostr(cStrToFloat(edtDisc.Text))+ ','
    + ' Inv_disc_fakturpr = '+ floattostr(cStrToFloat(edtDiscpr.Text))+ ','
    + ' Inv_amount = '+ floattostr(cstrtoFloat(edtTotal.Text))+ ','
    + ' Inv_taxamount = '+ floattostr(cStrToFloat(edtPPN.Text))+ ','
    + ' Inv_istax = ' + IntToStr(aistax)+  ','
    + ' inv_jthtempo='+ quotd(dttGLjt.datetime)+','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where Inv_nomor = ' + quot(FID) + ';'
else
begin
  edtNomor.Text := getmaxkode;
  s :=  ' insert into TInv_HDR '
             + ' (Inv_nomor,inv_bpb_nomor,Inv_tanggal,inv_jthtempo,Inv_memo,Inv_sup_kode,Inv_disc_faktur,'
             + ' Inv_disc_fakturpr,Inv_amount,Inv_taxamount,Inv_istax,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quot(edtNomorBPB.Text)+','
             + Quotd(dtTanggal.Date) + ','
             + quotd(dttGLjt.datetime)+','
             + Quot(edtmemo.Text)+','
             + Quot(cxLookupsupplier.EditValue) + ','
             + floattostr(cStrToFloat(edtDisc.Text))+ ','
             + floattostr(cStrToFloat(edtDiscpr.Text))+ ','
             + floattostr(cStrToFloat(edtTotal.Text))+ ','
             + floattostr(cStrToFloat(edtPPN.Text))+ ','
             + IntToStr(aistax)+  ','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

     tt := TStringList.Create;
   s:= ' delete from tinv_dtl '
      + ' where  invd_inv_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('qty').AsInteger >  0 then
   begin
    S:='insert into tinv_dtl (invd_inv_nomor,invd_brg_kode,invd_brg_satuan,invd_qty,invd_discpr,invd_harga,invd_nourut,invd_expired) values ('
      + Quot(edtNomor.Text) +','
      + IntToStr(CDS.FieldByName('SKU').AsInteger) +','
      + Quot(CDS.FieldByName('satuan').AsString) +','
      + IntToStr(CDS.FieldByName('QTY').AsInteger) +','
      + FloatToStr(cVarToFloat(CDS.FieldByName('DISC').AsFloat))+','
      + FloatToStr(cVarToFloat(CDS.FieldByName('harga').AsFloat))+','
      + IntToStr(i)  +','
      + QuotD(CDS.FieldByName('expired').AsDateTime)
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


function TfrmInvoice.cekdata:Boolean;
var
  i:integer;
begin
  result:=true;
   i := 1;
     If cxLookupsupplier.EditValue = '' then
    begin
      ShowMessage('supplier belum di pilih');
      result:=false;
      Exit;
    end;
  CDS.First;
  While not CDS.Eof do
  begin



    If CDS.FieldByName('SKU').AsInteger = 0 then
    begin
      ShowMessage('SKU Baris : ' + inttostr(i) + ' Belum dipilih');
      result:=false;
      Exit;
    end;

    inc(i);
    CDS.Next;
  end;
end;

procedure TfrmInvoice.loaddataBPB(akode : string);
var
  s: string ;
  tsql : TmyQuery;
  i:Integer;
begin


  s := ' select bpb_nomor,bpb_tanggal,po_sup_kode,po_istax,sup_top,'
     + ' po_DISC_faktur,po_disc_fakturpr,po_istax,pod_keterangan,'
     + ' bpbd_brg_kode,bpbd_bRG_satuan,bpbd_qty,bpbd_tgl_expired expired,'
     + ' pod_harga,pod_discpr,(bpbd_qty*pod_harga*(100-pod_discpr)/100) nilai'
     + ' from tbpb_hdr inner join tpo_hdr a on bpb_po_nomor = po_nomor'
     + ' inner join tbpb_dtl on bpbd_bpb_nomor = bpb_nomor '
     + ' inner join tsupplier on sup_kode =po_sup_kode '
     + ' LEFT join tpo_dtl d on a.po_nomor=d.pod_po_nomor  and bpbd_brg_kode = pod_brg_kode  '
     + ' where bpb_nomor = '+ Quot(akode);
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin

            edtNomorBPB.Text   := fieldbyname('bpb_nomor').AsString;
            apajak := fieldbyname('po_istax').AsInteger;
            if apajak = 1 then
               chkpajak.Checked := True
            else
               chkpajak.Checked := false;

            edtNomor.Text := getmaxkode(apajak);
            cxLookupsupplier.EditValue  := fieldbyname('po_sup_kode').AsString;
            edtDiscpr.Text := fieldbyname('po_disc_fakturpr').AsString;
            edtDisc.Text :=  fieldbyname('po_disc_faktur').AsString;
            dtTglJT.DateTime := fieldbyname('bpb_tanggal').AsDateTime+fieldbyname('sup_top').AsInteger;
            i:=1;
            initViewSKU;
             CDS.EmptyDataSet;
            while  not Eof do
             begin
                      CDS.Append;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('bpbd_brg_kode').AsInteger;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('bpbd_brg_satuan').Asstring;
                      CDS.FieldByName('QTY').AsInteger        := fieldbyname('bpbd_qty').AsInteger;
                      CDS.FieldByName('Harga').AsFloat        := fieldbyname('pod_harga').AsFloat;
                      CDS.FieldByName('disc').AsFloat        := fieldbyname('pod_discpr').AsFloat;
                      CDS.FieldByName('total').AsFloat        := fieldbyname('nilai').AsFloat;
                      CDS.FieldByName('expired').AsDateTime  := fieldbyname('expired').AsDateTime;
                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
            hitung;
        end
        else
        begin
          ShowMessage('Nomor tidak di temukan');
          dttanggal.SetFocus;
        end;
      end;
   finally
     tsql.Free;
   end;

end;

procedure TfrmInvoice.edtNomorBPBClickBtn(Sender: TObject);
var
    SQLbantuan :string;
begin
 sqlbantuan := ' SELECT bpb_NOMOR Nomor,bpb_TANGGAL Tanggal,SUP_NAMA Supplier from tbpb_HDR inner join tpo_hdr on po_nomor=bpb_po_nomor'
            + ' inner join tsupplier on sup_kode=po_sup_kode where bpb_isinvoice=0';
 Application.CreateForm(Tfrmbantuan,frmbantuan);
 frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
  edtNomorBPB.Text := varglobal;
  loaddataBPB(edtNomorBPB.Text);
end;



procedure TfrmInvoice.loaddataall(akode : string);
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
  s := ' select inv_NOMOr,inv_tanggal,bpb_nomor,inv_memo,po_sup_kode,inv_istax,inv_jthtempo,'
     + ' invd_brg_kode,invd_bRG_satuan,invd_qty,invd_harga,invd_discpr,(invd_qty*invd_harga*(100-invd_discpr)/100) nilai,'
     + ' invd_expired,inv_disc_faktur,inv_disc_fakturpr '
     + ' from tinv_hdr inner join tbpb_hdr on bpb_nomor =inv_bpb_nomor '
     + ' inner join tpo_hdr a on bpb_po_nomor=po_nomor'
     + ' inner join tinv_dtl on invd_inv_nomor=inv_nomor'
     + ' where inv_nomor = '+ Quot(akode)
     + ' order by invd_nourut ';
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            apajak :=fieldbyname('inv_istax').AsInteger;
            if apajak =1 then
               chkPajak.Checked := True
            else
               chkPajak.Checked := False;   
            FID :=fieldbyname('inv_nomor').AsString;
            edtnomor.Text := fieldbyname('inv_nomor').AsString;
            edtNomorBPB.Text   := fieldbyname('bpb_nomor').AsString;
            dttanggal.DateTime := fieldbyname('inv_tanggal').AsDateTime;
            edtmemo.Text := fieldbyname('inv_memo').AsString;
            cxLookupsupplier.EditValue  := fieldbyname('po_sup_kode').AsString;
            edtDiscpr.Text :=fieldbyname('inv_disc_fakturpr').AsString;
            edtDisc.Text :=  fieldbyname('inv_disc_faktur').AsString;
            initViewSKU;
            i:=1;
             CDS.EmptyDataSet;
            while  not Eof do
             begin
                      CDS.Append;


                     CDS.Append;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('invd_brg_kode').AsInteger;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('invd_brg_satuan').Asstring;
                      CDS.FieldByName('QTY').AsInteger        := fieldbyname('invd_qty').AsInteger;
                      CDS.FieldByName('Harga').AsFloat        := fieldbyname('invd_harga').AsFloat;
                      CDS.FieldByName('disc').AsFloat        := fieldbyname('invd_discpr').AsFloat;
                      CDS.FieldByName('total').AsFloat        := fieldbyname('nilai').AsFloat;
                      CDS.FieldByName('expired').AsDateTime  := fieldbyname('invd_expired').AsDateTime;

                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
           hitung;

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

procedure TfrmInvoice.hitung;
var
  asubtotal : Double;
  adisc:Double;
begin
  asubtotal :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Total'));
  edtDiscFaktur.Text := FloatToStr((cStrToFloat(edtDiscpr.text)/100*asubtotal)+cStrToFloat(edtDisc.text)) ;
  asubtotal := asubtotal - cStrToFloat(edtDiscFaktur.Text);
  if chkPajak.Checked then
  begin
    edtTotal.Text :=FloatToStr(asubtotal*getangkappn(dtTanggal.DateTime));
    edtPPN.Text := FloatToStr(asubtotal *getangkappn2(dtTanggal.DateTime));
  end
  else
  begin
    edtTotal.Text :=FloatToStr(asubtotal);
    edtPPN.Text := '0';
  end;

end;


procedure TfrmInvoice.initViewSKU;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'select brg_kode sku, brg_nama NamaBarang, brg_satuan Satuan from Tbarang '
  + ' inner join tbpb_dtl on bpbd_brg_kode=brg_kode and bpbd_bpb_nomor =' + Quot(edtNomorbpb.Text);


  FCDSSKU := TConextMain.cOpenCDS(S, nil);

  with TcxExtLookupHelper(clSKU.Properties) do
  begin
    LoadFromCDS(CDSSKU, 'SKU','SKU',['SKU'],Self);
    SetMultiPurposeLookup;
  end;

  with TcxExtLookupHelper(clNamaBarang.Properties) do
    LoadFromCDS(CDSSKU, 'SKU','NamaBarang',['SKU'],Self);
  

end;

procedure TfrmInvoice.edtDiscprExit(Sender: TObject);
begin
if edtDiscpr.Text = '' then
    edtDiscpr.Text :='0';
hitung;
end;

procedure TfrmInvoice.edtDiscExit(Sender: TObject);
begin
if edtDisc.Text = '' then
    edtDisc.Text :='0';
hitung;
end;

procedure TfrmInvoice.clDiscPropertiesChange(Sender: TObject);
var
  i:integer;
  lVal: Double;
begin
 cxGrdMain.DataController.Post;

  i := cxGrdMain.DataController.FocusedRecordIndex;
  lVal := cxGrdMain.DataController.Values[i, clQTY.Index] *  cxGrdMain.DataController.Values[i, clHarga.Index]*(cvartofloat(cxGrdMain.DataController.Values[i,cldisc.Index])/100);
  lVal := cxGrdMain.DataController.Values[i, clQTY.Index] * cxGrdMain.DataController.Values[i, clHarga.Index] - lVal;

  If CDS.State <> dsEdit then CDS.Edit;
  CDS.FieldByName('Total').AsFloat := lVal;
  CDS.Post;

end;


procedure TfrmInvoice.doslipInv(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'INV';

          s:= ' select '
       + ' *,if(invd_nourut is null ,1000,invd_nourut) nourut ,terbilang(inv_amount) terbilang '
       + ' from tinv_hdr '
       + ' inner join tampung on nomor=inv_nomor '
       + ' inner join tbpb_hdr on bpb_nomor=inv_bpb_nomor'
       + ' inner join tpo_hdr on po_nomor=bpb_po_nomor'
       + ' inner join tsupplier on po_sup_kode=sup_kode '
       + ' left join  tinv_dtl on inv_nomor=invd_inv_nomor and tam_nama = invd_brg_kode '
       + ' left join tbarang on invd_brg_kode=brg_kode '
       + ' where '
       + ' inv_nomor=' + quot(anomor)
       + ' order by nourut';
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure TfrmInvoice.insertketampungan(anomor:string);
var
  s:string;
  tsql : TmyQuery;
  a,i,x:integer;
  tt : TStrings;
begin
  a:=9;
  s:='delete from tampung ';
    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
  
  s := 'select invd_brg_kode from tinv_dtl where invd_inv_nomor =' + Quot(anomor) ;
  tsql := xOpenQuery(s,frmMenu.conn) ;
  x:=0;
  tt:=TStringList.Create;

    with tsql do
    begin
      try
       while not Eof do
       begin
         x:=x+1;
          s :=   'insert  into tampung '
                  + '(nomor,tam_nama'
                  + ')values ('
                  + Quot(anomor) + ','
                  + Quot(Fields[0].Asstring)
                  + ');';
          tt.Append(s);
        Next
       end;
       finally
          free;
      end;
    end;


  for i := x to a do
   begin


        s :='insert  into tampung '
            + '(nomor,tam_nama'
            + ')values ('
            + Quot(anomor) + ','
            + Quot('-')
            + ');';
        tt.Append(s);

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



end.
