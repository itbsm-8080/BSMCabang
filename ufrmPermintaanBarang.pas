unit ufrmPermintaanBarang;

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
  dxSkinDarkRoom, dxSkinFoggy, dxSkinSeven, dxSkinSharp, MemDS, DBAccess,
  MyAccess;

type
  TfrmPermintaanBarang = class(TForm)
    PANEL: TAdvPanel;
    Label2: TLabel;
    edtNomor: TAdvEdit;
    Label3: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    Label4: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clSKU: TcxGridDBColumn;
    clNamaBarang: TcxGridDBColumn;
    clQTY: TcxGridDBColumn;
    clStokNow: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lbljudul: TLabel;
    dtTanggal: TDateTimePicker;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    clSatuan: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    clAvgSale: TcxGridDBColumn;
    clKeterangan: TcxGridDBColumn;
    cxButton3: TcxButton;
    edtMemo: TMemo;
    Button1: TButton;
    MyQuery1: TMyQuery;
    cxGrdMainColumn1: TcxGridDBColumn;
    cxGrdMainColumn2: TcxGridDBColumn;
    cxGrdMainColumn3: TcxGridDBColumn;
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
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:TcxCustomGridRecord; var AText: string);
    procedure initViewSKU;
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
    procedure bantuansku;
    procedure clSKUPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure Button1Click(Sender: TObject);
    function getavgsales3bulan(akode:string):Double;
    function getavgsale3bulan(akode:string):Double;
    function getRealisasiIn(akode:string):Integer;
    function getSisa(akode:string):Integer;
    function getMingguLalu(akode:string):Integer;
  private
    FCDScustomer: TClientDataset;
    FCDSSKU : TClientDataset;
    FCDSGudang: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    apajak :Integer ;
    atanggalold:TDateTime;

    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmPermintaanBarang: TfrmPermintaanBarang;
const
   NOMERATOR = 'PB';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmCetak,uFrmbantuan2;

{$R *.dfm}

procedure TfrmPermintaanBarang.refreshdata;
begin
  FID:='';
  FLAGEDIT := False;
  dtTanggal.DateTime := Date;
  edtnomor.Text := getmaxkode;
  edtmemo.Clear;
  dtTanggal.SetFocus;
  initgrid;

end;
procedure TfrmPermintaanBarang.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.Post;

end;
procedure TfrmPermintaanBarang.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;           

procedure TfrmPermintaanBarang.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmPermintaanBarang.getmaxkode:string;
var
  s:string;
 begin
  s := ' SELECT MAX(RIGHT(pb_nomor,3)) FROM tpermintaanbarang_hdr WHERE pb_nomor LIKE ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%');
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

procedure TfrmPermintaanBarang.cxButton1Click(Sender: TObject);
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

procedure TfrmPermintaanBarang.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmPermintaanBarang.cxButton2Click(Sender: TObject);
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

procedure TfrmPermintaanBarang.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
   
end;

function TfrmPermintaanBarang.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftInteger, False);
    zAddField(FCDS, 'NamaBarang', ftstring, False,100);
    zAddField(FCDS, 'Satuan', ftString, False, 10);
    zAddField(FCDS, 'MingguLalu', ftInteger, False);
    zAddField(FCDS, 'RealisasiIN', ftInteger, False);
    zAddField(FCDS, 'Sisa', ftInteger, False);
    zAddField(FCDS, 'QTY', ftInteger, False);
    zAddField(FCDS, 'StokNow', ftInteger, False);
    zAddField(FCDS, 'AvgSale', ftFloat, False);
    zAddField(FCDS, 'Keterangan', ftString, False, 255);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

procedure TfrmPermintaanBarang.FormShow(Sender: TObject);
begin

refreshdata;
end;

procedure TfrmPermintaanBarang.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmPermintaanBarang.initViewSKU;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'SELECT brg_kode SKU, brg_nama NamaBarang, brg_satuan Satuan '
  + ' FROM tbarang '
  + ' INNER JOIN tpermintaanbarang_dtl ON pbd_brg_kode = brg_kode and pbd_pb_nomor =' + Quot(edtNomor.Text);

  FCDSSKU := TConextMain.cOpenCDS(S, nil);

  with TcxExtLookupHelper(clSKU.Properties) do
  begin
    LoadFromCDS(CDSSKU, 'SKU','SKU',['SKU'],Self);
    SetMultiPurposeLookup;
  end;
  with TcxExtLookupHelper(clNamaBarang.Properties) do
    LoadFromCDS(CDSSKU, 'SKU','NamaBarang',['SKU'],Self);
end;

procedure TfrmPermintaanBarang.clQTYPropertiesEditValueChanged(Sender: TObject);
var
  i: Integer;
  lVal: Double;
begin
  inherited;

 If CDS.State <> dsEdit then
   CDS.Edit;
  cxGrdMain.DataController.Post;

end;
procedure TfrmPermintaanBarang.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmPermintaanBarang.clSKUPropertiesEditValueChanged(Sender: TObject);
begin
 bantuansku;
end;

procedure TfrmPermintaanBarang.clKetPropertiesValidate(Sender: TObject;
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

procedure TfrmPermintaanBarang.dtTanggalChange(Sender: TObject);
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


procedure TfrmPermintaanBarang.simpandata;
var
  s:string;
  aisecer,i:integer;
  tt:TStrings;

begin
  if FLAGEDIT then
    s := 'UPDATE tpermintaanbarang_hdr set '
      + ' pb_memo = ' + Quot(edtmemo.Text) + ','
      + ' pb_tanggal = ' + Quotd(dtTanggal.Date)+','
      + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
      + ' user_modified = ' + Quot(frmMenu.KDUSER)
      + ' where pb_nomor = ' + quot(FID) + ';'
  else
  begin
    edtNomor.Text := getmaxkode;
    s := ' INSERT INTO tpermintaanbarang_hdr '
       + ' (pb_nomor, pb_tanggal, pb_memo, date_create, user_create) '
       + ' values ( '
       + Quot(edtNomor.Text) + ','
       + Quotd(dtTanggal.Date) + ','
       + Quot(edtmemo.Text)+','
       + QuotD(cGetServerTime,True) + ','
       + Quot(frmMenu.KDUSER)+')';
  end;

    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  tt := TStringList.Create;
  s := ' DELETE FROM tpermintaanbarang_dtl '
     + ' WHERE  pbd_pb_nomor =' + quot(FID);

  tt.Append(s);
  CDS.First;
  i:=1;

  while not CDS.Eof do
  begin
   if CDS.FieldByName('qty').AsInteger >  0 then
     begin
      S:='INSERT INTO tpermintaanbarang_dtl (pbd_pb_nomor, pbd_brg_kode, pbd_satuan, pbd_qty, pbd_StokNow, pbd_AvgSale, pbd_keterangan, pbd_nourut) values ('
        + Quot(edtNomor.Text) +','
        + IntToStr(CDS.FieldByName('SKU').AsInteger) +','
        + Quot(CDS.FieldByName('satuan').AsString) +','
        + IntToStr(CDS.FieldByName('QTY').AsInteger) +','
        + IntToStr(CDS.FieldByName('StokNow').AsInteger) +','
        + FloatToStr(CDS.FieldByName('AvgSale').AsFloat) +','
        + Quot(CDS.FieldByName('Keterangan').AsString)+','
        + IntToStr(i)
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

function TfrmPermintaanBarang.cekdata:Boolean;
var
  i:integer;
begin
  result:=true;
  i := 1;

  CDS.First;
  While not CDS.Eof do
  begin
    If CDS.FieldByName('SKU').AsInteger = 0 then
    begin
      ShowMessage('SKU Baris : ' + inttostr(i) + ' Belum dipilih');
      result:=false;
      Exit;
    end;

//    If (CDS.FieldByName('qty').AsInteger <= 0 ) then
//    begin
//      ShowMessage('QTY Baris : ' + inttostr(i) + ' Belum diisi');
//      result:=false;
//      Exit;
//    end;
    inc(i);
    CDS.Next;
  end;
end;

procedure TfrmPermintaanBarang.loaddataall(akode : string);
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

  s := ' SELECT pb_nomor Nomor, pb_tanggal Tanggal, pbd_brg_kode SKU, brg_nama NamaBarang, pbd_satuan Satuan, '
     + ' pbd_qty QTY, pbd_stoknow StokNow, pbd_avgsale AvgSale, pb_memo Memo, pbd_keterangan Keterangan'
     + ' FROM tpermintaanbarang_hdr a '
     + ' LEFT JOIN tpermintaanbarang_dtl b ON b.pbd_pb_nomor = a.pb_nomor '
     + ' LEFT JOIN tbarang c ON c.brg_kode = b.pbd_brg_kode '
     + ' WHERE pb_nomor = '+ Quot(akode)
     + ' ORDER BY pbd_nourut ';

    tsql := xOpenQuery(s,frmMenu.conn) ;
   try
      with  tsql do
      begin
        if not eof then
        begin
            flagedit := True;
            FID :=fieldbyname('Nomor').AsString;
            edtnomor.Text := fieldbyname('Nomor').AsString;
            dttanggal.DateTime := fieldbyname('Tanggal').AsDateTime;
            if cGetServerTime - dtTanggal.DateTime >= 3  then
            begin
              cxButton1.Enabled := False;
              cxButton2.Enabled := false;
            end;
            atanggalold := fieldbyname('Tanggal').AsDateTime;
            edtmemo.Text := fieldbyname('Keterangan').AsString;

            i:=1;
            CDS.EmptyDataSet;
            while not Eof do
            begin
            CDS.Append;
            aketemu:=False;
              for a := 0 to cxGrdMain.DataController.RecordCount-1 do
              begin
                If (cVarToInt(cxGrdMain.DataController.Values[a, clSKU.Index]) = fieldbyname('SKU').AsInteger) and (cxGrdMain.DataController.FocusedRecordIndex <> a) then
                begin
                  aketemu := True;
                end;
              end;

              CDS.FieldByName('No').AsInteger           := i;
              CDS.FieldByName('SKU').AsInteger          := fieldbyname('SKU').AsInteger;
              CDS.FieldByName('Namabarang').AsString    := fieldbyname('NamaBarang').AsString;
              CDS.FieldByName('Satuan').AsString        := fieldbyname('Satuan').Asstring;
              CDS.FieldByName('MingguLalu').AsInteger   := fieldbyname('QTY').AsInteger; //getMingguLalu(Fields[1].AsString);
              CDS.FieldByName('RealisasiIN').AsInteger  := getRealisasiIn(Fields[1].AsString);
              CDS.FieldByName('Sisa').AsInteger         := fieldbyname('QTY').AsInteger - CDS.FieldByName('RealisasiIN').AsInteger;//getSisa(Fields[1].AsString);
              CDS.FieldByName('QTY').AsInteger          := fieldbyname('QTY').AsInteger;
              CDS.FieldByName('StokNow').AsInteger      := fieldbyname('StokNow').AsInteger;
              CDS.FieldByName('AvgSale').AsFloat        := fieldbyname('AvgSale').AsFloat;
              CDS.FieldByName('Keterangan').AsString := fieldbyname('Keterangan').AsString;

              CDS.Post;
              i:=i+1;
              next;
            end ;
        end
        else
        begin
          ShowMessage('Nomor PB tidak di temukan');
          dttanggal.SetFocus;
        end;
      end;
   finally
     tsql.Free;
   end;
end;

procedure TfrmPermintaanBarang.bantuansku;
  var
    s:string;
    tsql:TmyQuery;
    i:Integer;
      a:Integer;
  aketemu:Boolean;
  aqtypo,qtykirim : Integer;
begin
  sqlbantuan := 'SELECT brg_kode SKU, brg_nama NamaBarang, brg_satuan Satuan FROM tbarang ' ;

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
//  ShowMessage(varglobal1);
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
      CDS.FieldByName('NamaBarang').AsString := Quot(varglobal1);

      s := ' SELECT brg_kode SKU, brg_nama NamaBarang, brg_satuan Satuan, IFNULL(pbd_qty, 0) QTY, '
        + ' SUM(mst_stok_in - mst_stok_out) StokNow, IFNULL(pbd_avgsale, 0) AvgSale, pbd_keterangan Keterangan'
        + ' FROM tbarang '
        + ' INNER JOIN tmasterstok ON mst_brg_kode = brg_kode '
        + ' LEFT JOIN tpermintaanbarang_dtl ON pbd_brg_kode = brg_kode and pbd_pb_nomor = ' + Quot(edtNomor.Text)
        + ' WHERE brg_kode = ' + Quot(CDS.Fieldbyname('sku').AsString)
        + ' GROUP BY brg_kode , brg_nama , brg_satuan ';

    tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
      try
        if not Eof then
        begin
          CDS.FieldByName('NamaBarang').AsString   := Fields[1].AsString;
          CDS.FieldByName('Satuan').AsString       := Fields[2].AsString;
          CDS.FieldByName('MingguLalu').AsInteger  := Fields[3].AsInteger;//getMingguLalu(Fields[1].AsString);
          CDS.FieldByName('RealisasiIN').AsInteger := getRealisasiIn(Fields[1].AsString);
          CDS.FieldByName('Sisa').AsInteger        := Fields[3].AsInteger - CDS.FieldByName('RealisasiIN').AsInteger;//getSisa(Fields[1].AsString);
          CDS.FieldByName('QTY').AsInteger         := Fields[3].AsInteger; 
          CDS.FieldByName('StokNow').AsInteger     := Fields[4].AsInteger;
          CDS.FieldByName('AvgSale').AsFloat       := getavgsale3bulan(Fields[1].AsString);
          CDS.FieldByName('Keterangan').AsString   := Fields[6].AsString;
        end
        else
          bantuansku;
        finally
          free;
      end;
    end;
  end;
end;

procedure TfrmPermintaanBarang.clSKUPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  bantuansku;
end;

procedure TfrmPermintaanBarang.Button1Click(Sender: TObject);
var
    s:string;
    tsql:TmyQuery;
    i:Integer;
begin

  sqlbantuan := ' SELECT pb_nomor Nomor_Permintaan, DATE(pb_tanggal) Tanggal_Permintaan'
              // + ' mutcid_brg_kode SKU, brg_nama NamaBarang, pbd_qty QTY_Permintaan, cbg_nama Cabang '
              + ' FROM tpermintaanbarang_hdr e '
              + ' WHERE '
              + ' pb_tanggal >= '+QuotD(dtTanggal.DateTime)+' - INTERVAL 7 DAY '
              + ' GROUP BY pb_nomor '
              + ' ORDER BY Nomor_Permintaan ASC ';

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;

  if varglobal <> '' then
   begin
   CDS.emptydataset;

   s := ' SELECT brg_satuan, pbd_brg_kode, brg_nama, pbd_qty,'
      + ' (select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_brg_kode=pbd_brg_kode and mst_gdg_kode="WH-01") pbd_stoknow, pbd_avgsale, pbd_keterangan '
      + ' FROM tpermintaanbarang_dtl '
      + ' INNER JOIN tbarang ON brg_kode = pbd_brg_kode'
      + ' INNER JOIN tpermintaanbarang_hdr ON pb_nomor = pbd_pb_nomor '
      + ' WHERE pbd_pb_nomor = ' + Quot(varglobal) ;

   tsql := xOpenQuery(s,frmMenu.conn);

     with tsql do
     begin
        try
          while not Eof do
          begin
              CDS.Append;
              CDS.FieldByName('SKU').AsString          := Fields[1].AsString;
              CDS.FieldByName('NamaBarang').AsString   := Fields[2].AsString;
              CDS.FieldByName('Satuan').AsString       := Fields[0].AsString;
              CDS.FieldByName('MingguLalu').AsInteger  := Fields[3].AsInteger;
              CDS.FieldByName('RealisasiIN').AsInteger := getRealisasiIn(Fields[1].AsString);
              CDS.FieldByName('Sisa').AsInteger        := Fields[3].AsInteger - CDS.FieldByName('RealisasiIN').AsInteger;
              if CDS.FieldByName('Sisa').AsInteger <= 0 then
                CDS.FieldByName('QTY').AsInteger := 0
              else
                CDS.FieldByName('QTY').AsInteger       := Fields[3].AsInteger - CDS.FieldByName('RealisasiIN').AsInteger;
              CDS.FieldByName('StokNow').AsInteger     := Fields[4].AsInteger;
              CDS.FieldByName('AvgSale').AsFloat       := getavgsales3bulan(Fields[1].AsString);
              CDS.FieldByName('Keterangan').AsString   := Fields[6].AsString;

              Next;
          end  
        finally
          Free;
        end;
     end;
   end;
end;

function TfrmPermintaanBarang.getavgsales3bulan(akode:string):Double;
var
  s:string;
  tsql:TmyQuery;
begin
  s := 'SELECT SUM(fpd_qty)/3 FROM tfp_dtl '
    + ' INNER JOIN tfp_hdr ON fp_nomor = fpd_fp_nomor'
    + ' WHERE fp_tanggal >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH) AND fp_tanggal <= CURDATE()'
    + ' AND fpd_brg_kode = ' + Quot(akode)
    + ' GROUP BY fpd_brg_kode ';
  tsql := xOpenQuery(s,frmMenu.conn) ;
  with tsql do
  begin
    try
      Result :=  Fields[0].AsFloat;
    finally
      Free;
    end;
  end;
end;

function TfrmPermintaanBarang.getRealisasiIn(akode:string):Integer;
var
  s:string;
  tsql:TmyQuery;
begin
  s := 'SELECT SUM(mutcid_qty) RealisasiIn '
    + ' FROM tmutcabin_dtl a '
    + ' INNER JOIN tmutcabin_hdr b ON b.mutci_nomor = a.mutcid_mutci_nomor '
//    + ' INNER JOIN tpermintaanbarang_dtl c ON c.pbd_brg_kode = a.mutcid_brg_kode '
//    + ' INNER JOIN tpermintaanbarang_hdr d ON d.pb_nomor = c.pbd_pb_nomor '
    + ' WHERE '
    + ' mutcid_brg_kode =' + Quot(akode)
    + ' AND '
    + ' mutci_tanggal >= '+QuotD(dtTanggal.DateTime)+' - INTERVAL 7 DAY;';

  tsql := xOpenQuery(s,frmMenu.conn) ;
  with tsql do
  begin
    try
      Result :=  Fields[0].AsInteger;
    finally
      Free;
    end;
  end;
end;

function TfrmPermintaanBarang.getSisa(akode:string):Integer;
var
  s:string;
  tsql:TmyQuery;
begin
  s := 'SELECT (pbd_qty - (SUM(mutcid_qty))) AS Sisa '
    + ' FROM tmutcabin_dtl a '
    + ' INNER JOIN tmutcabin_hdr b ON b.mutci_nomor = a.mutcid_mutci_nomor '
    + ' INNER JOIN tpermintaanbarang_dtl c ON c.pbd_brg_kode = a.mutcid_brg_kode '
    + ' INNER JOIN tpermintaanbarang_hdr d ON d.pb_nomor = c.pbd_pb_nomor '
    + ' WHERE '
    + ' mutcid_brg_kode =' + Quot(akode)
    + ' AND '
    + ' mutci_tanggal >= '+QuotD(dtTanggal.DateTime)+' - INTERVAL 7 DAY;';

  tsql := xOpenQuery(s,frmMenu.conn) ;
  with tsql do
  begin
    try
      Result :=  Fields[0].AsInteger;
    finally
      Free;
    end;
  end;
end;

function TfrmPermintaanBarang.getMingguLalu(akode:string):Integer;
var
  s:string;
  tsql:TmyQuery;
begin
  s := 'SELECT pbd_qty '
    + ' FROM tpermintaanbarang_dtl a '
    + ' INNER JOIN tpermintaanbarang_hdr b ON b.pb_nomor = a.pbd_pb_nomor '
    + ' WHERE '
    + ' pbd_brg_kode =' + Quot(akode)
    + ' AND '
    + ' pb_tanggal >= CURDATE() - INTERVAL 7 DAY;';

  tsql := xOpenQuery(s,frmMenu.conn) ;
  with tsql do
  begin
    try
      Result :=  Fields[0].AsInteger;
    finally
      Free;
    end;
  end;
end;

function TfrmPermintaanBarang.getavgsale3bulan(akode:string):Double;
var
  s:string;
  tsql:TmyQuery;
begin
  s := 'SELECT SUM(fpd_qty)/3 FROM tfp_dtl '
    + ' INNER JOIN tfp_hdr ON fp_nomor = fpd_fp_nomor'
    + ' WHERE fp_tanggal >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH) AND fp_tanggal <= CURDATE()'
    + ' AND fpd_brg_kode = ' + Quot(varglobal)
    + ' GROUP BY fpd_brg_kode ';
  tsql := xOpenQuery(s,frmMenu.conn) ;
  with tsql do
  begin
    try
      Result :=  Fields[0].AsFloat;
    finally
      Free;
    end;
  end;
end;

end.
