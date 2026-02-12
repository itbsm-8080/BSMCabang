unit ufrmApproveAbsensi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, DBClient, cxControls, cxContainer,
  cxEdit, AdvEdBtn, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBExtLookupComboBox, cxSpinEdit, cxTimeEdit, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxButtonEdit,
  cxCheckBox, cxCurrencyEdit, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue, dxSkinDarkRoom,
  dxSkinFoggy, dxSkinSeven, dxSkinSharp, cxCalendar, MemDS, DBAccess,
  MyAccess;

type
  TfrmApproveAbsensi = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxButton1: TcxButton;
    AdvPanel4: TAdvPanel;
    cxGrid1: TcxGrid;
    cxGridLembur: TcxGridDBTableView;
    clNik: TcxGridDBColumn;
    clNama: TcxGridDBColumn;
    clunit: TcxGridDBColumn;
    cltanggal: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    Label3: TLabel;
    cljam: TcxGridDBColumn;
    clstatus: TcxGridDBColumn;
    clketerangan: TcxGridDBColumn;
    clalasan: TcxGridDBColumn;
    Refresh: TButton;
    cxButton7: TcxButton;
    savedlg: TSaveDialog;
    startdate: TDateTimePicker;
    Label2: TLabel;
    enddate: TDateTimePicker;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    cxButton4: TcxButton;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cljabatan: TcxGridDBColumn;
    clapprove: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    erlambat1: TMenuItem;
    idakMasuk1: TMenuItem;
    Masuk1: TMenuItem;
    procedure refreshdata;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure loaddataall() ;
    procedure simpandata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function GetCDSLembur: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure RefreshClick(Sender: TObject);
    procedure cxButton7Click(Sender: TObject);
    procedure cxGridLemburStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure erlambat1Click(Sender: TObject);
    procedure idakMasuk1Click(Sender: TObject);
    procedure Masuk1Click(Sender: TObject);


  private
    FCDSPabrik: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;


    { Private declarations }
  protected
    FCDSLembur: TClientDataSet;
  public
    property CDSLembur: TClientDataSet read GetCDSLembur write FCDSLembur;

    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmApproveAbsensi: TfrmApproveAbsensi;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,cxGridExportLink;

{$R *.dfm}

procedure TfrmApproveAbsensi.refreshdata;
begin
  startdate.DateTime := date;
  enddate.DateTime := date;
  CDSLembur.EmptyDataSet;
  CDSLembur.Append;
  CDSLembur.Post;
end;
procedure TfrmApproveAbsensi.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
      Release;
  end;


  if Key= VK_F10 then
  begin
    try
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
end;

procedure TfrmApproveAbsensi.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;


procedure TfrmApproveAbsensi.loaddataall() ;
var
  s: string;
  i:integer;
  tsql : TmyQuery;
begin
  s:= 'SELECT nm_unit NamaUnit,ABS_nik NIK,ucase(abs_nama) NAMA,nm_jabat Jabatan,date_format(abs_tanggal,"%Y-%m-%d") Tanggal,'
  + ' date_format(abs_jammasuk,"%H:%i:%s") Jam,abs_keterangan Keterangan,abs_status Status,abs_alasan Alasan,abs_isapprove'
+ ' FROM tabsensifix INNER JOIN tkaryawan ON kar_Nik=abs_nik  and kar_pengecualian=0'
+ ' INNER JOIN tunit ON kd_unit=kar_kd_unit'
+ ' left join tjabatan on kd_jabat=kar_kd_jabat'
+ ' where abs_tanggal between '+ QuotD(startdate.Date)+' and ' + QuotD(enddate.Date)+';';
MyQuery1.Close;
MyQuery1.SQL.Text := s;
MyQuery1.Open;

with MyQuery1 do
begin
  try
             i:=1;
             CDSLembur.EmptyDataSet;
             CDSLembur.Append;
            while  not Eof do
             begin

               if fieldbyname('nik').AsString <> '' then
               begin
                      CDSLembur.Append;
                      CDSLembur.FieldByName('nik').AsString      := fieldbyname('NIK').AsString;
                      CDSLembur.fieldbyname('Nama').AsString     := fieldbyname('NAMA').AsString;
                      CDSLembur.fieldbyname('jabatan').AsString     := fieldbyname('jabatan').AsString;
                      CDSLembur.fieldbyname('unit').AsString  := fieldbyname('NamaUnit').AsString;
                      CDSLembur.fieldbyname('tanggal').AsString     := fieldbyname('tanggal').AsString;
                      CDSLembur.fieldbyname('jam').asstring     := fieldbyname('jam').asstring;
                      CDSLembur.FieldByName('status').Asstring :=  fieldbyname('status').asstring;
                      CDSLembur.FieldByName('keterangan').Asstring :=  fieldbyname('keterangan').asstring;
                      CDSLembur.FieldByName('alasan').Asstring :=  fieldbyname('alasan').asstring;
                      CDSLembur.FieldByName('approve').Asstring :=  fieldbyname('abs_isapprove').asstring;                      
                      CDSLembur.Post;
                   i:=i+1;
               end;
                   next;
            end ;

  

  finally
    close;
  end;

    cxGridLembur.Columns[8].Width :=200;
    cxGridLembur.Columns[9].Width :=100;


end;

end;
procedure TfrmApproveAbsensi.simpandata;
var
  s:string;
  tt:TStrings;
  i:integer;
begin

     tt := TStringList.Create;
   i:=1;
    CDSLembur.First;
while not CDSLembur.Eof do
  begin
   if (CDSLembur.FieldByName('nik').asstring <> '')  then
   begin
        s:='update tkaryawan set '
        + ' kar_gapok = '+FloatToStr(CDSLembur.FieldByName('gapok').AsFloat) + ','
        + ' kar_t_kompetensi = ' + FloatToStr(CDSLembur.FieldByName('kompetensi').AsFloat) + ','
        + ' kar_t_jabatan = ' + FloatToStr(CDSLembur.FieldByName('tjabatan').AsFloat) + ','
        + ' kar_t_lain = ' + FloatToStr(CDSLembur.FieldByName('lain').AsFloat) + ','
        + ' kar_t_bpjstk = ' + FloatToStr(CDSLembur.FieldByName('bpjstk').AsFloat) + ','
        + ' kar_t_bpjs = ' + FloatToStr(CDSLembur.FieldByName('bpjs').AsFloat)+ ','
        + ' kar_t_koperasi = ' + FloatToStr(CDSLembur.FieldByName('koperasi').AsFloat)+','
        + ' kar_t_PPH21 = ' + FloatToStr(CDSLembur.FieldByName('pph21').AsFloat)
        + ' where kar_nik = ' + Quot(CDSLembur.FieldByName('nik').AsString)+';';
       tt.Append(s);
     end;
     CDSLembur.next;
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


procedure TfrmApproveAbsensi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;


procedure TfrmApproveAbsensi.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmApproveAbsensi.cxButton2Click(Sender: TObject);
begin
   try
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

procedure TfrmApproveAbsensi.FormShow(Sender: TObject);
begin
refreshdata ;
end;

function TfrmApproveAbsensi.GetCDSLembur: TClientDataSet;
begin
  If not Assigned(FCDSLembur) then
  begin
    FCDSLembur := TClientDataSet.Create(Self);
    zAddField(FCDSLembur, 'nik', ftString, False,100);
    zAddField(FCDSLembur, 'nama', ftString, False,100);
    zAddField(FCDSLembur, 'Jabatan', ftString, False,100);
    zAddField(FCDSLembur, 'unit', ftString, False,100);
    zAddField(FCDSLembur, 'tanggal', ftString, False,15);
    zAddField(FCDSLembur, 'jam', ftstring, False,10);
    zAddField(FCDSLembur, 'status', ftstring, False,10);
    zAddField(FCDSLembur, 'keterangan', ftstring, False,100);
    zAddField(FCDSLembur, 'alasan', ftstring, False,100);
    zAddField(FCDSLembur, 'approve', ftstring, False,100);
    FCDSLembur.CreateDataSet;
  end;
  Result := FCDSLembur;
end;

procedure TfrmApproveAbsensi.FormCreate(Sender: TObject);
begin

   TcxDBGridHelper(cxGridLembur).LoadFromCDS(CDSLembur, False, False);
end;


procedure TfrmApproveAbsensi.RefreshClick(Sender: TObject);
begin
loaddataall;
end;

procedure TfrmApproveAbsensi.cxButton7Click(Sender: TObject);
begin
  if SaveDlg.Execute then
    ExportGridToExcel(SaveDlg.FileName, cxGrid1);

  cxGridLembur.DataController.CollapseDetails;

end;

procedure TfrmApproveAbsensi.cxGridLemburStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  AColumn : TcxCustomGridTableItem;
begin
  AColumn := (Sender as TcxGridDBTableView).GetColumnByFieldName('Keterangan');


  if (AColumn <> nil)  and ((ARecord.Values[AColumn.Index]) = 'Tidak Masuk') then
    AStyle := cxStyle2;
  if (AColumn <> nil)  and ((ARecord.Values[AColumn.Index]) = 'Terlambat') then
    AStyle := cxStyle1;

end;
procedure TfrmApproveAbsensi.erlambat1Click(Sender: TObject);
var
  s:String;
begin
 s:='update tabsensifix SET abs_keterangan ="Terlambat",abs_status="OK", '
+ ' abs_isapprove="Terlambat" '
+ ' WHERE abs_nik= '+Quot(CDSLembur.FieldByName('nik').AsString)
+ ' AND abs_tanggal= '+ Quot(CDSLembur.fieldbyname('tanggal').AsString)+';';
MyConnection1.ExecSQL(s,[]);
ShowMessage(CDSLembur.FieldByName('nama').AsString + ' dinyatakan Terlambat ');
If CDSLembur.State <> dsEdit then
   CDSLembur.Edit;
 CDSLembur.FieldByName('status').Asstring :=  'OK';
 CDSLembur.FieldByName('keterangan').Asstring := 'Terlambat';
 CDSLembur.FieldByName('approve').Asstring := 'Terlambat';

end;

procedure TfrmApproveAbsensi.idakMasuk1Click(Sender: TObject);
var
  s:string;
begin
   s:='update tabsensifix SET abs_keterangan ="Tidak Masuk",abs_status="OK", '
+ ' abs_isapprove="Tidak Masuk" '
+ ' WHERE abs_nik= '+Quot(CDSLembur.FieldByName('nik').AsString)
+ ' AND abs_tanggal= '+ Quot(CDSLembur.fieldbyname('tanggal').AsString)+';';
MyConnection1.ExecSQL(s,[]);
ShowMessage(CDSLembur.FieldByName('nama').AsString + ' dinyatakan Tidak Masuk ');
If CDSLembur.State <> dsEdit then
   CDSLembur.Edit;
 CDSLembur.FieldByName('status').Asstring :=  'OK';
 CDSLembur.FieldByName('keterangan').Asstring := 'Tidak Masuk';
 CDSLembur.FieldByName('approve').Asstring := 'Tidak Masuk';

end;

procedure TfrmApproveAbsensi.Masuk1Click(Sender: TObject);
var
  s:string;
begin
   s:='update tabsensifix SET abs_keterangan ="",abs_status="OK", '
+ ' abs_isapprove="Masuk" '
+ ' WHERE abs_nik= '+Quot(CDSLembur.FieldByName('nik').AsString)
+ ' AND abs_tanggal= '+ Quot(CDSLembur.fieldbyname('tanggal').AsString)+';';
MyConnection1.ExecSQL(s,[]);
ShowMessage(CDSLembur.FieldByName('nama').AsString + ' dinyatakan Masuk ');
If CDSLembur.State <> dsEdit then
   CDSLembur.Edit;
 CDSLembur.FieldByName('status').Asstring :=  'OK';
 CDSLembur.FieldByName('keterangan').Asstring := '';
 CDSLembur.FieldByName('approve').Asstring := 'Masuk';

end;

end.
