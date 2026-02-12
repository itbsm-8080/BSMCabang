unit ufrmSetingPacking;

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
  cxCalendar, cxCheckBox, Buttons, cxButtonEdit, MyAccess;

type
  TfrmSetingPacking = class(TForm)
    PANEL: TAdvPanel;
    Label2: TLabel;
    edtNomor: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    Label1: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    AdvPanel4: TAdvPanel;
    te: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clKode: TcxGridDBColumn;
    clNama: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lbljudul: TLabel;
    Label6: TLabel;
    edtNama: TAdvEdit;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    clQty: TcxGridDBColumn;
    edtKode: TAdvEditBtn;
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
    procedure simpandata;
    function cekdata:Boolean;

    procedure loaddataall(akode : string);
    procedure BitBtn1Click(Sender: TObject);
    procedure clKodePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure bantuansku;
    procedure edtKodeClickBtn(Sender: TObject);
  private
    FCDScustomer: TClientDataset;
    FCDSRekeningCash: TClientDataset;
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
  frmSetingPacking: TfrmSetingPacking;
  
const
   NOMERATOR = 'CB';
   
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmfp;

{$R *.dfm}

procedure TfrmSetingPacking.refreshdata;
begin
  FID := '';
  FLAGEDIT := False;
  edtnomor.Text := getmaxkode;
  edtnama.Clear;
  initgrid;
end;

procedure TfrmSetingPacking.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;
end;

procedure TfrmSetingPacking.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  SelectNext(ActiveControl, True, True);
end;

procedure TfrmSetingPacking.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Release;
end;

function TfrmSetingPacking.getmaxkode:string;
var
  s: String;
begin
  s := 'select max(right(pck_nomor,2)) from tpacking_hdr';
  with xOpenQuery(s, frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
        result:= RightStr(IntToStr(10+1),2)
      else
        result:= RightStr(IntToStr(10+fields[0].AsInteger+1),2);
    finally
      free;
    end;
  end;
end;

procedure TfrmSetingPacking.cxButton1Click(Sender: TObject);
begin
  try
    If not cekdata then exit;

    if (FLAGEDIT) and ( not cekedit(frmMenu.KDUSER, self.name)) then
    begin
      MessageDlg('Anda tidak berhak Edit di Modul ini', mtWarning, [mbOK],0);
      Exit;
    End;

    if (not FLAGEDIT) and ( not cekinsert(frmMenu.KDUSER, self.name)) then
    begin
      MessageDlg('Anda tidak berhak Insert di Modul ini', mtWarning, [mbOK],0);
      Exit;
    End;

    if MessageDlg('Yakin ingin simpan ?',mtCustom,
                            [mbYes,mbNo], 0)= mrNo
    then Exit;

    simpandata;
    refreshdata;
  except
    ShowMessage('Gagal Simpan');
    Exit;
  end;
end;

procedure TfrmSetingPacking.cxButton8Click(Sender: TObject);
begin
  Release;
end;

procedure TfrmSetingPacking.cxButton2Click(Sender: TObject);
begin
  try
    If not cekdata then exit;

    if (FLAGEDIT) and ( not cekedit(frmMenu.KDUSER, self.name)) then
    begin
      MessageDlg('Anda tidak berhak Edit di Modul ini', mtWarning, [mbOK],0);
      Exit;
    End;
    
    if (not FLAGEDIT) and ( not cekinsert(frmMenu.KDUSER, self.name)) then
    begin
      MessageDlg('Anda tidak berhak Insert di Modul ini', mtWarning, [mbOK],0);
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

procedure TfrmSetingPacking.FormCreate(Sender: TObject);
begin
  TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
end;

function TfrmSetingPacking.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Kode', ftString, False, 20);
    zAddField(FCDS, 'Nama', ftString, False, 100);
    zAddField(FCDS, 'Qty', ftFloat, False);
    FCDS.CreateDataSet;
  end;
  
  Result := FCDS;
end;

procedure TfrmSetingPacking.FormShow(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmSetingPacking.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmSetingPacking.HapusRecord1Click(Sender: TObject);
begin
  If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmSetingPacking.simpandata;
var
  s: String;
  tt: TStrings;
  I: Integer;
begin
  if FLAGEDIT then
    s := ' update tpacking_hdr set '
       + ' pck_nama = ' + Quot(edtNama.Text)+','
       + ' pck_brg_kode = ' + Quot(edtKode.Text)
       + ' where pck_nomor = ' + quot(FID) + ';'
  else
  begin
    edtNomor.Text := getmaxkode;
    s := ' insert into tpacking_HDR '
       + ' (pck_nomor,pck_brg_kode,pck_nama'
       + ' ) '
       + ' values ( '
       + Quot(edtNomor.Text) + ','
       + Quot(edtKode.Text) + ','
       + Quot(edtNama.Text)
       +');';
  end;
  
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  tt := TStringList.Create;
  s := ' delete from tpacking_DTL '
     + ' where  pckd_pck_nomor =' + quot(FID);
  tt.Append(s);
  CDS.First;
  i:=1;
  
  while not CDS.Eof do
  begin
    S := 'insert into tpacking_DTL (pckd_pck_nomor,pckd_brg_kode,pckd_qty) values ('
       + Quot(edtNomor.Text) +','
       + quot(CDS.FieldByName('kode').AsString) +','
       + FloatToStr(CDS.FieldByName('qty').AsFloat)
       + ');';
    tt.Append(s);
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


function TfrmSetingPacking.cekdata:Boolean;
var
  i: integer;
  abayar, atotal: double;
begin
  result:=true;
  i := 1;
end;

procedure TfrmSetingPacking.loaddataall(akode : string);
var
  s: String;
  tsql: TmyQuery;
  a,i: Integer;
  aketemu: Boolean;
  aqtypo, qtyterima: Integer;
begin
  if akode = '' then
  begin
    flagedit := false;
    Exit ;
  end;
  
  s := ' SELECT pck_nomor, pck_nama, pck_brg_kode, '
     + ' pckd_brg_kode, brg_nama, pckd_qty '
     + ' FROM tpacking_hdr '
     + ' INNER JOIN tpacking_dtl a ON pck_nomor = pckd_pck_nomor '
     + ' inner join tbarang on brg_kode = pckd_brg_kode '
     + ' WHERE pck_nomor = '+ Quot(akode);

  tsql := xOpenQuery(s,frmMenu.conn) ;
  try
    with  tsql do
    begin
      if not eof then
      begin
        flagedit := True;
        FID := fieldbyname('pck_nomor').AsString;
        edtnomor.Text := fieldbyname('pck_nomor').AsString;
        edtkode.text := fieldbyname('pck_brg_kode').AsString;
        edtNama.Text := fieldbyname('pck_nama').AsString;
        i:=1;
        CDS.EmptyDataSet;
        while not Eof do
        begin
          CDS.Append;
          If CDS.State <> dsEdit then CDS.Edit;
          CDS.FieldByName('kode').AsString := fieldbyname('pckd_brg_kode').Asstring;
          CDS.FieldByName('nama').AsString := fieldbyname('brg_nama').Asstring;
          CDS.FieldByName('qty').AsFloat := fieldbyname('pckd_qty').AsFloat;
          CDS.Post;
          Inc(i);
          next;
        end;
      end
      else
      begin
        ShowMessage('Nomor  tidak di temukan');
      end;
    end;
  finally
    tsql.Free;
  end;
end;


procedure TfrmSetingPacking.BitBtn1Click(Sender: TObject);
var
  awal,akhir: String;
  i: Integer;
begin
  CDS.First;
  i := 0;
end;

procedure TfrmSetingPacking.clKodePropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  bantuansku;
end;

procedure TfrmSetingPacking.bantuansku;
var
  s: String;
  tsql2, tsql: TmyQuery;
  i: Integer;
begin
  sqlbantuan := 'select brg_kode Kode, brg_nama NamaBarang, brg_satuan Satuan from Tbarang ';

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  
  if varglobal <> '' then
  begin
    If CDS.State <> dsEdit then
    CDS.Edit;
    CDS.FieldByName('kode').AsString := varglobal;
    CDS.FieldByName('Nama').AsString := varglobal1;
  end;
end;

procedure TfrmSetingPacking.edtKodeClickBtn(Sender: TObject);
begin
  sqlbantuan := 'select brg_kode Sku, brg_nama NamaBarang, brg_satuan Satuan  from Tbarang ';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  
  if varglobal <> '' then
  begin
    edtKode.Text := varglobal;
    edtNama.Text := varglobal1;
  end;
end;

end.
