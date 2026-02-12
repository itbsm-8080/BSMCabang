unit ufrmSuratJalan;

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
  cxCalendar, cxCheckBox, cxButtonEdit, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinPumpkin, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue,
  frxClass, frxDMPExport, MyAccess;

type
  TfrmSuratJalan = class(TForm)
    PANEL: TAdvPanel;
    Label2: TLabel;
    edtNomor: TAdvEdit;
    Label3: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clSKU: TcxGridDBColumn;
    clNamaBarang: TcxGridDBColumn;
    clQTY: TcxGridDBColumn;
    clExpired: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lbljudul: TLabel;
    dtTanggal: TDateTimePicker;
    AdvPanel5: TAdvPanel;
    edtmemo: TMemo;
    Label10: TLabel;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    clSatuan: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    clStatus: TcxGridDBColumn;
    clgudang: TcxGridDBColumn;
    cxButton3: TcxButton;
    Label5: TLabel;
    edtKeterangan: TAdvEdit;
    cxGrdMainColumn1: TcxGridDBColumn;
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

    procedure clQTYPropertiesEditValueChanged(Sender: TObject);
    procedure HapusRecord1Click(Sender: TObject);
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);
    procedure clKetPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);

    procedure dtTanggalChange(Sender: TObject);
    procedure simpandata;
    function cekdata:Boolean;

    procedure loaddataall(akode : string);
    function getqtyPO(anomor:string;asku:integer): integer;
    function cari(anomor:string): Boolean;
    function getstatusexpired(asku:integer): integer;
    procedure clQTYPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
   procedure bantuansku;
    procedure clSKUPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure doslip(anomor : string );
    procedure cxButton3Click(Sender: TObject);
  private
    FCDScustomer: TClientDataset;
    FCDSSKU : TClientDataset;
    FCDSGudang: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    apajak :Integer ;
    atanggalold:TDateTime;
    function GetCDScustomer: TClientDataset;
    function GetCDSGudang: TClientDataset;



    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;
    property CDScustomer: TClientDataset read GetCDScustomer write FCDScustomer;
    property CDSGudang: TClientDataset read GetCDSGudang write FCDSGudang;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmSuratJalan: TfrmSuratJalan;
const
   NOMERATOR = 'SJ';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmCetak;

{$R *.dfm}

procedure TfrmSuratJalan.refreshdata;
begin
  FID:='';
  apajak:=1;
  FLAGEDIT := False;
  dtTanggal.DateTime := Date;
  edtnomor.Text := getmaxkode;
  edtmemo.Clear;
  initgrid;

end;
procedure TfrmSuratJalan.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.Post;

end;
procedure TfrmSuratJalan.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmSuratJalan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmSuratJalan.getmaxkode:string;
var
  s:string;
begin

  s:='select max(right(sj_nomor,4)) from tSj_hdr where sj_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%');
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

procedure TfrmSuratJalan.cxButton1Click(Sender: TObject);
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

procedure TfrmSuratJalan.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmSuratJalan.cxButton2Click(Sender: TObject);
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

procedure TfrmSuratJalan.FormCreate(Sender: TObject);
begin

     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
   
end;

function TfrmSuratJalan.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftInteger, False);
    zAddField(FCDS, 'Namabarang', ftstring, False,100);

    zAddField(FCDS, 'QTY', ftInteger, False);
    zAddField(FCDS, 'Satuan', ftString, False, 10);
    zAddField(FCDS, 'Expired', ftDate, False, 255);
    zAddField(FCDS, 'Closed', ftInteger, False);
    zAddField(FCDS, 'keterangan', ftString, False, 100);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmSuratJalan.GetCDScustomer: TClientDataset;
var s:String;
begin
  If not Assigned(FCDScustomer) then
  begin
    S := 'select cus_nama as customer, cus_kode Kode, cus_alamat Alamat,cus_shipaddress Ship,cus_telp'
        +' from tcustomer';


    FCDScustomer := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDScustomer;
end;

procedure TfrmSuratJalan.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmSuratJalan.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;


procedure TfrmSuratJalan.clQTYPropertiesEditValueChanged(Sender: TObject);
var
  i: Integer;
  lVal: Double;
begin
  inherited;

 If CDS.State <> dsEdit then
   CDS.Edit;
  cxGrdMain.DataController.Post;

end;
procedure TfrmSuratJalan.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmSuratJalan.clSKUPropertiesEditValueChanged(Sender: TObject);
begin
 bantuansku;
end;

procedure TfrmSuratJalan.clKetPropertiesValidate(Sender: TObject;
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


procedure TfrmSuratJalan.dtTanggalChange(Sender: TObject);
var
  anomorold:string;
  anomornew:string;
begin
   anomorold := edtNomor.Text;
  anomornew := getmaxkode;
  if FLAGEDIT then
  begin
    if Copy(anomornew,1,11) <> Copy(anomorold,1,11)then
    begin
      showmessage('Perubahan tanggal tidak bisa beda bulan dan tahun');
      edtNomor.Text := anomorold;
      dtTanggal.Date :=atanggalold;
    end;
  end;
end;


procedure TfrmSuratJalan.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;

begin

if FLAGEDIT then
  s:='update Tsj_HDR set '
    + ' sj_keterangan = ' + Quot(edtketerangan.Text) + ','
    + ' sj_tanggal = ' + Quotd(dtTanggal.Date)
    + ' where sj_nomor = ' + quot(FID) + ';'
else
begin
  edtNomor.Text := getmaxkode;
  s :=  ' insert into Tsj_HDR '
             + ' (sj_nomor,sj_tanggal,sj_keterangan) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quotd(dtTanggal.Date) + ','
             + Quot(edtketerangan.Text)+')';
end;
    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);


     tt := TStringList.Create;
   s:= ' delete from Tsj_DTL '
      + ' where  sjd_sj_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('qty').AsInteger >  0 then
   begin
    S:='insert into tsj_DTL (sjd_sj_nomor,sjd_brg_kode,sjd_satuan,sjd_qty,sjd_keterangan) values ('
      + Quot(edtNomor.Text) +','
      + IntToStr(CDS.FieldByName('SKU').AsInteger) +','
      + Quot(CDS.FieldByName('satuan').AsString) +','
      + IntToStr(CDS.FieldByName('QTY').AsInteger)+','
      + Quot(CDS.FieldByName('keterangan').AsString)
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


function TfrmSuratJalan.cekdata:Boolean;
var
  i:integer;
begin
  result:=true;
   i := 1;
//   If cxLookupGudang.EditValue = '' then
//    begin
//      ShowMessage('Gudang belum di pilih');
//      result:=false;
//      Exit;
//    end;
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

function TfrmSuratJalan.GetCDSGudang: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSGudang) then
  begin
    S := 'select gdg_nama as Gudang, gdg_kode Kode '
        +' from tgudang';


    FCDSGudang := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSGudang;
end;


procedure TfrmSuratJalan.loaddataall(akode : string);
var
  s: string ;
  tsql : TmyQuery;
  a,i:Integer;
  aketemu:Boolean;
  aqtypo,qtykirim : Integer;
begin
  if akode = '' then
  begin
    flagedit := false;
    Exit ;
  end;
  s := ' select sj_NOMOr,sj_tanggal,sj_keterangan,'
     + ' sjd_brg_kode,sjd_satuan,brg_nama,sjd_qty,sjd_keterangan'
     + ' from tsj_hdr '
     + ' left join tsj_dtl on sjd_sj_nomor=sj_nomor'
     + ' left join tbarang on brg_kode=sjd_brg_kode '
     + ' where sj_nomor = '+ Quot(akode);
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            FID :=fieldbyname('sj_nomor').AsString;
            edtnomor.Text := fieldbyname('sj_nomor').AsString;
            dttanggal.DateTime := fieldbyname('sj_tanggal').AsDateTime;
            edtketerangan.Text := fieldbyname('sj_keterangan').AsString;

            i:=1;
             CDS.EmptyDataSet;
            while  not Eof do
             begin
                      CDS.Append;
                      CDS.FieldByName('no').AsInteger        := i;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('sjd_brg_kode').AsInteger;
                      CDS.FieldByName('Namabarang').AsString  := fieldbyname('brg_nama').AsString;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('sjd_satuan').Asstring;
                      CDS.FieldByName('QTY').AsInteger        := fieldbyname('sjd_qty').AsInteger;
                      CDS.FieldByName('keterangan').AsString      := fieldbyname('sjd_keterangan').Asstring;

                      CDS.Post;
                   i:=i+1;
                   next;
            end ;


        end
        else
        begin
          ShowMessage('Nomor so tidak di temukan');
          dttanggal.SetFocus;
        end;
      end;
   finally
     tsql.Free;


   end;

end;

function TfrmSuratJalan.getqtyPO(anomor:string;asku:integer): integer;
var
  s:string;
  tsql:TmyQuery;
begin
  Result :=0;
  s:='select sod_qty from tso_dtl where sod_so_nomor ='+Quot(anomor)
   + ' and sod_brg_kode='+inttostr(asku) ;
   tsql := xOpenQuery(s,frmMenu.conn);
   with tsql do
   begin
     try
       if not eof then
          Result := Fields[0].AsInteger;
     finally
       free;
     end;
   end;

end;

function TfrmSuratJalan.cari(anomor:string): Boolean;
var
  s:string;
  tsql:TmyQuery;
begin
  Result :=False;
  s:='select so_nomor from tso_hdr where so_nomor ='+Quot(anomor);
   tsql := xOpenQuery(s,frmMenu.conn);
   with tsql do
   begin
     try
       if not eof then
          Result := True;
     finally
       free;
     end;
   end;

end;

function TfrmSuratJalan.getstatusexpired(asku:integer): integer;
var
  s:string  ;
  tsql:TmyQuery  ;
begin
    Result :=0;
  s:='select brg_isexpired from tbarang where brg_kode ='+inttostr(asku);

   tsql := xOpenQuery(s,frmMenu.conn);
   with tsql do
   begin
     try
       if not eof then
          Result := Fields[0].AsInteger;
     finally
       free;
     end;
   end;
end;

procedure TfrmSuratJalan.clQTYPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
 var
  i:integer;
  aqtykurang,aqtylain:integer;
begin
  aqtylain := 0;
  aqtykurang :=0;
  cxGrdMain.DataController.Post;


end;

procedure TfrmSuratJalan.bantuansku;
  var
    s:string;
    tsql2,tsql:TmyQuery;
    i:Integer;
begin
    sqlbantuan := 'select brg_kode Sku,brg_nama NamaBarang, brg_satuan Satuan from Tbarang ';

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
   begin
     for i := 0 to cxGrdMain.DataController.RecordCount-1 do
    begin

      If (cVarToInt(cxGrdMain.DataController.Values[i, clSKU.Index]) = StrToInt(varglobal)) and (cxGrdMain.DataController.FocusedRecordIndex <> i)
      then
      begin

        ShowMessage('Sku ada yang sama dengan baris '+ IntToStr(i+1));
        CDS.Cancel;
        exit;
      end;
    end;
 If CDS.State <> dsEdit then
   CDS.Edit;

      CDS.FieldByName('sku').AsInteger := StrToInt(varglobal);
      CDS.FieldByName('expired').AsDateTime := cVarTodate(varglobal1);

  s:='select brg_kode Sku, brg_nama NamaBarang, brg_satuan Satuan '
  + ' from Tbarang '
  + ' where brg_kode = ' + Quot(CDS.Fieldbyname('sku').AsString)
  + ' group by brg_kode , brg_nama , brg_satuan';
    tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
      try
        if not Eof then
        begin
          CDS.FieldByName('NamaBarang').AsString := Fields[1].AsString;
          CDS.FieldByName('Satuan').AsString := Fields[2].AsString;

        end
        ELSE
        begin
          s:='select brg_nama,brg_satuan,0,brg_hrgbeli from tbarang where brg_kode = '+Quot(CDS.Fieldbyname('sku').AsString);
          tsql2 := xOpenQuery(s,frmMenu.conn);
          with tsql2 do
          begin
            try
              if not Eof then
              begin
                CDS.FieldByName('NamaBarang').AsString := Fields[0].AsString;
                CDS.FieldByName('Satuan').AsString := Fields[1].AsString;


              end
              ELSE
              bantuansku;
            finally
              Free;
            end;
          end;
        end;


        finally
          free;
      end;
    end;
  end;
end;
procedure TfrmSuratJalan.clSKUPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
bantuansku;
end;

procedure TfrmSuratJalan.doslip(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'SJ';

          s:= ' select '
       + ' * '
       + ' from tsj_hdr '
       + ' left join  tsj_dtl on sj_nomor=sjd_sj_nomor '
       + ' left join tbarang on sjd_brg_kode=brg_kode '
       + ' where '
       + ' sj_nomor=' + quot(anomor);
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure TfrmSuratJalan.cxButton3Click(Sender: TObject);
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
      doslip(edtNomor.Text);
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     
     Exit;
   end;
    
end;

end.
