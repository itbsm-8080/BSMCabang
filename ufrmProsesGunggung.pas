unit ufrmProsesGunggung;

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
  cxCheckBox, MyAccess;

type
  TfrmProsesGunggung = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clCustomer: TcxGridDBColumn;
    clNamaCustomer: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    clTotal: TcxGridDBColumn;
    Label1: TLabel;
    Label4: TLabel;
    cbbBulan: TAdvComboBox;
    edtTahun: TComboBox;
    clRetur: TcxGridDBColumn;
    clNilai: TcxGridDBColumn;
    clstatus: TcxGridDBColumn;
    btnRefresh: TcxButton;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    Label2: TLabel;
    edtTotal: TAdvEdit;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure initgrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata() ;
    procedure simpandata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure cxGrdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnRefreshClick(Sender: TObject);
    procedure clstatusPropertiesEditValueChanged(Sender: TObject);
    procedure hitung;

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
  frmProsesGunggung: TfrmProsesGunggung;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib;

{$R *.dfm}

procedure TfrmProsesGunggung.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
end;

procedure TfrmProsesGunggung.refreshdata;
begin
  edtTahun.Text := FormatDateTime('yyyy',Date);
  initgrid;
end;
procedure TfrmProsesGunggung.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;
end;

procedure TfrmProsesGunggung.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmProsesGunggung.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;


procedure TfrmProsesGunggung.loaddata() ;
var
  s,ssql: string;
  tsql : TmyQuery;
  i:Integer;
  akhir,awal : TDateTime;
begin
    akhir := EndOfTheMonth(StrToDate(IntToStr(cbbBulan.itemindex+1)+'/01/'+edttahun.Text));
    awal  :=StrToDate(IntToStr(cbbBulan.itemindex+1)+'/01/'+edttahun.Text);

  s:= 'SELECT cus_kode,cus_nama,SUM(fp_amount) tot,'
+ ' (SELECT ifnull(SUM(retj_amount),0) FROM tretj_hdr INNER JOIN tfp_hdr ON fp_nomor=retj_fp_nomor AND'
+ ' MONTH(fp_tanggal)='+inttostr(cbbBulan.itemindex+1)+' AND YEAR(fp_tanggal)='+edttahun.text+' WHERE fp_cus_kode=X.fp_cus_kode )  Ret,'
+ ' (SELECT if(gg_cus_kode<> "", 1,0) FROM tgunggung WHERE gg_cus_kode=cus_kode AND gg_periode='+inttostr(cbbBulan.itemindex+1)+' AND gg_tahun='+edttahun.text+') sts '
+ ' FROM tfp_hdr x INNER JOIN tcustomer'
+ ' ON cus_kode=fp_cus_kode'
+ ' WHERE MONTH(fp_tanggal)='+inttostr(cbbBulan.itemindex+1)+' AND YEAR(fp_tanggal)='+ edttahun.text
+ ' AND fp_istax=0'
+ ' GROUP BY fp_cus_kode';

tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
    CDS.EmptyDataSet;
    while  not Eof do
    begin
      CDS.Append;
      CDS.FieldByName('kode').AsString := fieldbyname('cus_kode').AsString;
      CDS.FieldByName('nama').AsString  := fieldbyname('cus_nama').AsString;
      CDS.FieldByName('total').asfloat  := fieldbyname('tot').AsFloat;
      CDS.FieldByName('retur').asfloat  := fieldbyname('ret').AsFloat;
      CDS.FieldByName('nilai').asfloat  := fieldbyname('tot').AsFloat-fieldbyname('ret').AsFloat;
      if fieldbyname('sts').AsFloat > 0 then
      CDS.FieldByName('status').asinteger  := 1
      else
      CDS.FieldByName('status').asinteger  := 0;

      CDS.Post;
      i:=i+1;
      next;
    end;
   end;
  finally
    Free;
  end;

 hitung;

end;

end;


procedure TfrmProsesGunggung.simpandata;
var
  s:string;
  i:Integer;
  tt:tstrings;
begin
  CDS.First;
  tt := TStringList.Create;
  s:= ' delete from tgunggung '
      + ' where  gg_periode= ' + inttostr(cbbBulan.ItemIndex+1)
      + ' and gg_tahun = ' + edttahun.Text ;
  tt.Append(s);
  CDS.First;
  i:=1;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('status').AsInteger >  0 then
   begin
      S:='insert into tgunggung (gg_periode,gg_tahun,gg_cus_kode,gg_total,gg_retur,gg_nilai) values ('
      + IntToStr(cbbBulan.ItemIndex+1) +','
      + edtTahun.Text + ' ,'
      + Quot(CDS.fieldbyname('kode').AsString) + ','
      + FloatToStr(CDS.FieldByName('total').AsFloat) + ','
      + FloatToStr(CDS.FieldByName('retur').AsFloat) + ','
      + FloatToStr(CDS.FieldByName('nilai').AsFloat)
      + ');';
    tt.Append(s);

   end;
   CDS.Next;
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


procedure TfrmProsesGunggung.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmProsesGunggung.cxButton1Click(Sender: TObject);
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

procedure TfrmProsesGunggung.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmProsesGunggung.cxButton2Click(Sender: TObject);
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
procedure TfrmProsesGunggung.FormShow(Sender: TObject);
begin
refreshdata;
end;

function TfrmProsesGunggung.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Kode', ftString, False,20);
    zAddField(FCDS, 'Nama', ftstring, False,100);
    zAddField(FCDS, 'total', ftFloat, False);
    zAddField(FCDS, 'retur', ftFloat, False);
    zAddField(FCDS, 'nilai', ftFloat, False);
    zAddField(FCDS, 'status', ftInteger, False);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

procedure TfrmProsesGunggung.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmProsesGunggung.cxGrdMainKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
if key = VK_DELETE then
begin
  If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;
end;

procedure TfrmProsesGunggung.btnRefreshClick(Sender: TObject);
begin
 loaddata();
end;

procedure TfrmProsesGunggung.clstatusPropertiesEditValueChanged(
  Sender: TObject);
begin
   CDS.Post;
  if CDS.FieldByName('status').AsInteger = 1 then
     edttotal.Text :=FormatFloat ('###,###,###,###',cds.FieldByName('nilai').AsFloat+cStrToFloat(edtTotal.Text))
  else
         edttotal.Text :=FormatFloat ('###,###,###,###',cStrToFloat(edtTotal.Text) - cds.FieldByName('nilai').AsFloat);

end;

procedure TfrmProsesGunggung.hitung;
begin
      CDS.First;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('status').AsInteger >  0 then
   begin
     edttotal.Text :=FormatFloat ('###,###,###,###',cds.FieldByName('nilai').AsFloat+cStrToFloat(edtTotal.Text))
   end;
   cds.next
  end;
end;

end.
