unit ufrmTagihanEkspedisi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  DBClient, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxSpinEdit, cxButtonEdit, cxTextEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, AdvEdBtn, AdvCombo, cxCurrencyEdit,DateUtils,
  cxCalendar, MemDS, DBAccess, MyAccess;

type
  TfrmTagihanEkspedisi = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clNomor: TcxGridDBColumn;
    clNamaCustomer: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    cltanggal: TcxGridDBColumn;
    Label1: TLabel;
    clnilai: TcxGridDBColumn;
    btnRefresh: TcxButton;
    startdate: TDateTimePicker;
    Label4: TLabel;
    enddate: TDateTimePicker;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    clbiaya: TcxGridDBColumn;
    cxButton3: TcxButton;
    cluoc: TcxGridDBColumn;
    cxButton7: TcxButton;
    savedlg: TSaveDialog;
    Label2: TLabel;
    Label3: TLabel;
    dttanggal: TDateTimePicker;
    edtNomor: TAdvEdit;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    Label5: TLabel;
    edtNamaEkspedisi: TAdvEdit;
    edtKeterangan: TAdvEdit;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure initgrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton8Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function GetCDS: TClientDataSet;
//    procedure clCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure cxGrdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bacafile2;
    procedure insertketampungan(anomor:string);
    procedure cxButton7Click(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    function getUoc(akode:string):Integer;
    procedure cxButton2Click(Sender: TObject);
    procedure simpandata;
    procedure clbiayaPropertiesEditValueChanged(Sender: TObject);
    function getmaxkode:string;
    procedure cxButton1Click(Sender: TObject);
    function cekdata:Boolean;
    procedure HapusRecord1Click(Sender: TObject);
    procedure teslip(anomor : string );

  private
    FFLAGEDIT: Boolean;
    FID: string;
    aHost2,aDatabase2,auser2,apassword2 : string;

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
  frmTagihanEkspedisi: TfrmTagihanEkspedisi;
const
   NOMERATOR = 'TE';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,ufrmCetak,ureport,cxGridExportLink;

{$R *.dfm}

procedure TfrmTagihanEkspedisi.FormCreate(Sender: TObject);
begin
  TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
end;

procedure TfrmTagihanEkspedisi.refreshdata;
begin
  FID:='';
  dttanggal.Date := Date;
  startdate.Date := Date;
  enddate.Date :=  date;
  initgrid;
end;
procedure TfrmTagihanEkspedisi.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;
end;

procedure TfrmTagihanEkspedisi.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F8 then
  begin
      Release;
  end;
end;

procedure TfrmTagihanEkspedisi.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;


procedure TfrmTagihanEkspedisi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmTagihanEkspedisi.cxButton8Click(Sender: TObject);
begin
  Release;
end;

procedure TfrmTagihanEkspedisi.FormShow(Sender: TObject);
begin
  refreshdata;
  bacafile2;
  with MyConnection1 do
  begin
     LoginPrompt := False;
     Server := aHost2;
     Database := aDatabase2;
     Username := auser2;
     Password := apassword2;
     Connected := True;
  end;
end;

function TfrmTagihanEkspedisi.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Nomor', ftString, False,20);
    zAddField(FCDS, 'Nama', ftstring, False,100);
    zAddField(FCDS, 'tanggal', ftDate, False);
    zAddField(FCDS, 'Nilai', ftfloat, False);
    zAddField(FCDS, 'biaya', ftfloat, False);
    zAddField(FCDS, 'UOC', ftfloat, False);

    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

//procedure TfrmTagihanEkspedisi.clCustomerPropertiesButtonClick(
//  Sender: TObject; AButtonIndex: Integer);
//  var
//    i:integer;
//begin
//     sqlbantuan := ' SELECT cus_kode Kode,cus_nama Nama FROM tcustomer';
//
//  sqlfilter := 'Kode,Nama';
//  Application.CreateForm(Tfrmbantuan,frmbantuan);
//  frmBantuan.SQLMaster := SQLbantuan;
//  frmBantuan.ShowModal;
//  if varglobal <> '' then
//  begin
//   for i := 0 to cxGrdMain.DataController.RecordCount-1 do
//    begin
//
//      If (VarToStr(cxGrdMain.DataController.Values[i, clCustomer.Index]) = VarToStr(varglobal)) and (cxGrdMain.DataController.FocusedRecordIndex <> i)
//       then
//      begin
//          ShowMessage('Customer ada yang sama dengan baris '+ IntToStr(i+1));
//          CDS.Cancel;
//          exit;
//      end;
//    end;
//   If CDS.State <> dsEdit then
//         CDS.Edit;
//
//      CDS.FieldByName('kode').AsString := varglobal;
//      CDS.FieldByName('nama').AsString := varglobal1;
//
//  end;
//
//end;

procedure TfrmTagihanEkspedisi.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmTagihanEkspedisi.cxGrdMainKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
  if key = VK_DELETE then
  begin
    If CDS.Eof then exit;
    CDS.Delete;
    If CDS.Eof then initgrid;
  end;
end;

procedure TfrmTagihanEkspedisi.bacafile2;
var
s:string;
tsql:tmyquery;

 begin
   s:='select ahost,adatabase,auser,apassword from tsetingdb where nama like '+Quot('default4') +';';
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

procedure TfrmTagihanEkspedisi.insertketampungan(anomor:string);
var
  s:string;
  tsql : TmyQuery;
  a,i,x:integer;
  tt : TStrings;
begin
  A:=getbarisslip('SO');
  s:='delete from tampung ';
   EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
  s := 'select tehd_teh_nomor from ttagihanekspedisi_dtl where tehd_teh_nomor =' + Quot(anomor) ;
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

procedure TfrmTagihanEkspedisi.cxButton7Click(Sender: TObject);
begin
  if SaveDlg.Execute then
    ExportGridToExcel(SaveDlg.FileName, cxGrid,True,True,True);

  cxGrdmain.DataController.CollapseDetails;
end;

procedure TfrmTagihanEkspedisi.btnRefreshClick(Sender: TObject);
var
    s:string;
    tsql:TmyQuery;
    i:Integer;
begin
     CDS.emptydataset;

     s := ' SELECT fp_nomor, fp_tanggal, fp_cus_kode, cus_nama, (fp_amount-fp_taxamount)fp_amount, fp_taxamount '
        + ' FROM tfp_hdr a '
        + ' INNER JOIN tcustomer b ON b.Cus_kode = a.FP_cus_kode '
        + ' WHERE fp_tanggal BETWEEN '+ QuotD(startdate.Date) + ' AND ' + QuotD(enddate.date)
        + ' AND fp_nomor NOT IN (SELECT tehd_fp_nomor FROM ttagihanekspedisi_dtl) '
        + ' ORDER BY fp_nomor ASC; ' ;

     tsql := xOpenQuery(s,frmMenu.conn);

     with tsql do
     begin
        try
          while not Eof do
          begin
            CDS.Append;
            CDS.FieldByName('Nomor').AsString   := Fields[0].AsString;
            CDS.FieldByName('Nama').AsString    := Fields[3].AsString;
            CDS.FieldByName('Tanggal').AsDateTime := Fields[1].AsDateTime;
            CDS.FieldByName('Nilai').AsFloat   := Fields[4].AsFloat;

            Next;
          end  
        finally
          Free;
        end;
     end;
end;

function TfrmTagihanEkspedisi.getUoc(akode:string):Integer;
var
  s:string;
  tsql:TmyQuery;
begin
    s := ' SELECT fp_nomor, fp_tanggal, fp_cus_kode, cus_nama, fp_amount, fp_taxamount '
        + ' FROM tfp_hdr a '
        + ' INNER JOIN tcustomer b ON b.Cus_kode = a.FP_cus_kode '
        + ' WHERE fp_tanggal BETWEEN '+ QuotD(startdate.Date) + ' AND ' + QuotD(enddate.date)
        + ' ORDER BY fp_nomor; ' ;

//  tsql := xOpenQuery(s,frmMenu.conn) ;
//  with tsql do
//  begin
//    try
//      Result :=  Fields[0].AsInteger;
//    finally
//      Free;
//    end;
//  end;

    tsql := xOpenQuery(s, frmMenu.conn);
    with tsql do
    begin
      try
        if Fields[0].AsString = '' then
        begin
          Result := 0;
        end
        else
        begin
          Result := Fields[0].AsInteger;
        end;
      finally
        Free;
      end;
    end;
end;

procedure TfrmTagihanEkspedisi.cxButton2Click(Sender: TObject);
begin
   try
//     If not cekdata then exit;
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
//     xRollback(frmMenu.conn);
     Exit;
   end;
//    xCommit(frmMenu.conn);
    Release;
end;

procedure TfrmTagihanEkspedisi.simpandata;
var
  s:string;
  aisecer,i:integer;
  tt:TStrings;
begin
  if FLAGEDIT then
    s := 'UPDATE ttagihanekspedisi_hdr set '
      + ' teh_nomor = ' + Quot(edtNomor.Text) + ','
      + ' teh_tanggal = ' + Quotd(dtTanggal.Date) + ','
      + ' teh_tg1 = ' + Quotd(startdate.Date) + ','
      + ' teh_tg2 = ' + Quotd(enddate.Date) + ','
      + ' teh_namaekspedisi = ' + Quot(edtNamaEkspedisi.Text) + ','
      + ' teh_keterangan = ' + Quot(edtKeterangan.Text)
      + ' WHERE teh_nomor = ' + quot(FID) + ';'
  else
  begin
    edtNomor.Text := getmaxkode;
    s := ' INSERT INTO ttagihanekspedisi_hdr '
       + ' (teh_nomor, teh_tanggal, teh_tg1, teh_tg2, teh_namaekspedisi, teh_keterangan) '
       + ' VALUES( '
       + Quot(edtNomor.Text) + ','
       + Quotd(dtTanggal.Date) + ','
       + QuotD(startdate.Date) + ','
       + QuotD(enddate.Date) + ','
       + Quot(edtNamaEkspedisi.Text) + ','
       + Quot(edtKeterangan.Text) + ')';
  end;

    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  tt := TStringList.Create;
  s := ' DELETE FROM ttagihanekspedisi_dtl '
     + ' WHERE  tehd_teh_nomor =' + quot(FID);

  tt.Append(s);
  CDS.First;
  i:=1;

  while not CDS.Eof do
  begin
   if CDS.FieldByName('biaya').Asfloat >  0 then
     begin
       if CDS.FieldByName('Nomor').AsString = '' then
          s := 'INSERT INTO ttagihanekspedisi_dtl (tehd_teh_nomor, tehd_fp_nomor, tehd_nilai, tehd_biaya, tehd_cus_nama, tehd_tanggal) VALUES ('
          + Quot(edtNomor.Text) +','
          + Quot(CDS.FieldByName('Nomor').AsString) + ','
          + FloatToStr(CDS.FieldByName('Nilai').AsFloat) + ','
          + FloatToStr(CDS.FieldByName('Biaya').AsFloat) + ','
          + Quot(CDS.FieldByName('Nama').AsString) + ','
          + QuotD(CDS.FieldByName('Tanggal').AsDateTime) + ');'
       else
          S:='INSERT INTO ttagihanekspedisi_dtl (tehd_teh_nomor, tehd_fp_nomor, tehd_nilai, tehd_biaya, tehd_cus_nama, tehd_tanggal) VALUES ('
            + Quot(edtNomor.Text) +','
            + Quot(CDS.FieldByName('Nomor').AsString) + ','
            + FloatToStr(CDS.FieldByName('Nilai').AsFloat) + ','
            + FloatToStr(CDS.FieldByName('Biaya').AsFloat) + ','
            + Quot(CDS.FieldByName('Nama').AsString) + ','
            + QuotD(CDS.FieldByName('Tanggal').AsDateTime)
    //        + FloatToStr(CDS.FieldByName('uoc').AsFloat)
            + ');'    ;

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

function TfrmTagihanEkspedisi.getmaxkode:string;
var
  s:string;
begin
  s := ' SELECT MAX(RIGHT(teh_nomor,3)) FROM ttagihanekspedisi_hdr WHERE teh_nomor LIKE ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%');
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

procedure TfrmTagihanEkspedisi.clbiayaPropertiesEditValueChanged(Sender: TObject);
var
  i: Integer;
  lVal: Double;

  begin
  inherited;
  cxGrdMain.DataController.Post;

  i := cxGrdMain.DataController.FocusedRecordIndex;
  if not VarIsStr(cxGrdMain.DataController.Values[i, clNomor.Index]) or
     (cxGrdMain.DataController.Values[i, clNomor.Index] = '')
  then
    lVal := 0
  else
  lVal := cxGrdMain.DataController.Values[i, clbiaya.Index] / cxGrdMain.DataController.Values[i, clnilai.Index] * 100;

  if CDS.State <> dsEdit then
    CDS.Edit;

  CDS.FieldByName('UOC').AsFloat := lVal;
  CDS.Post;
end;


procedure TfrmTagihanEkspedisi.cxButton1Click(Sender: TObject);
begin
   try
//      If not cekdata then exit;

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
//     xRollback(frmMenu.conn);
     Exit;
   end;
//    xCommit(frmMenu.conn);
end;

function TfrmTagihanEkspedisi.cekdata:Boolean;
var
  i:integer;
begin
  result:=true;
  i := 1;

  CDS.First;
  While not CDS.Eof do
  begin
    If CDS.FieldByName('Nomor').AsString <> '' then
    begin
      ShowMessage('SKU Baris : ' + inttostr(i) + ' Sudah diinput');
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

procedure TfrmTagihanEkspedisi.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmTagihanEkspedisi.teslip(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'TE';

    s:= ' SELECT * '
       + ' FROM ttagihanekspedisi_hdr a '
       + ' INNER JOIN ttagihanekspedisi_dtl b ON b.tehd_teh_nomor = a.teh_nomor'
//       + ' INNER JOIN tfp_hdr c ON c.FP_nomor = b.tehd_fp_nomor '
//       + ' INNER JOIN tcustomer d ON d.Cus_kode = c.FP_cus_kode '
       + ' LEFT JOIN tfp_hdr c ON c.fp_nomor = CASE WHEN b.tehd_fp_nomor = ''ANTARCABANG'' THEN NULL ELSE b.tehd_fp_nomor END '
       + ' LEFT JOIN tcustomer d ON d.cus_kode = CASE WHEN b.tehd_fp_nomor = ''ANTARCABANG'' THEN NULL ELSE fp_cus_kode END '
       + ' WHERE '
       + ' teh_nomor=' + quot(anomor)
       + ' ORDER BY tehd_fp_nomor DESC';

    ftsreport.AddSQL(s);
     ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

end.
