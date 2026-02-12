unit ufrmSetingJadwalSales;

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
  MyAccess;

type
  TfrmSetingjadwalsales = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtNama: TAdvEdit;
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
    edtKode: TAdvEditBtn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    edtNamaJadwal: TAdvEdit;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure initgrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure simpandata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure edtKodeClickBtn(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure clCustomerPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure cxGrdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function cekada(atahun:string;abulan:string;akode:string):Boolean;

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
  frmSetingjadwalsales: TfrmSetingjadwalsales;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib;

{$R *.dfm}

procedure TfrmSetingjadwalsales.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
end;

procedure TfrmSetingjadwalsales.refreshdata;
begin
  FID:='';
  edtKode.Clear;
  edtNama.Clear;

  initgrid;
end;
procedure TfrmSetingjadwalsales.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;
end;

procedure TfrmSetingjadwalsales.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmSetingjadwalsales.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;


procedure TfrmSetingjadwalsales.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;
begin
   tt := TStringList.Create;
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('kode').Asstring <> '' then
   begin
      s:='insert into tjadwalsales (jd_sls_kode,jd_cus_kode,jd_namajadwal) values ('
       + Quot(edtKode.Text) + ','
       + Quot(CDS.FieldByName('kode').Asstring)+ ','
       + Quot(edtNamaJadwal.Text) +');';
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


procedure TfrmSetingjadwalsales.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmSetingjadwalsales.cxButton1Click(Sender: TObject);
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

procedure TfrmSetingjadwalsales.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmSetingjadwalsales.cxButton2Click(Sender: TObject);
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
procedure TfrmSetingjadwalsales.edtKodeClickBtn(Sender: TObject);
begin
  sqlbantuan := ' SELECT sls_kode Kode,sls_nama Nama from tsalesman ';
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
   begin
  edtKode.Text := varglobal;
  edtNama.Text := varglobal1;

  end;

end;

procedure TfrmSetingjadwalsales.FormShow(Sender: TObject);
begin
refreshdata;
end;

function TfrmSetingjadwalsales.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Kode', ftString, False,20);
    zAddField(FCDS, 'Nama', ftstring, False,100);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

procedure TfrmSetingjadwalsales.clCustomerPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  var
    i:integer;
begin
     sqlbantuan := ' SELECT cus_kode Kode,cus_nama Nama,gc_nama Golongan,cus_piutang Piutang from tcustomer '
                  + ' inner join tgolongancustomer on cus_gc_kode=gc_kode';
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
  begin
   for i := 0 to cxGrdMain.DataController.RecordCount-1 do
    begin

      If (VarToStr(cxGrdMain.DataController.Values[i, clCustomer.Index]) = VarToStr(varglobal)) and (cxGrdMain.DataController.FocusedRecordIndex <> i)
       then
      begin
          ShowMessage('Customer ada yang sama dengan baris '+ IntToStr(i+1));
          CDS.Cancel;
          exit;
      end;
    end;
   If CDS.State <> dsEdit then
         CDS.Edit;

      CDS.FieldByName('kode').AsString := varglobal;
      CDS.FieldByName('nama').AsString := varglobal1;

  end;

end;

procedure TfrmSetingjadwalsales.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmSetingjadwalsales.cxGrdMainKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
if key = VK_DELETE then
begin
  If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;
end;

function TfrmSetingjadwalsales.cekada(atahun:string;abulan:string;akode:string):Boolean;
var
  i:integer;
  s:string;
  tsql:TmyQuery;
begin
  result:=false;
        s:= ' select * from testimasisales_hdr where esh_sls_kode='+ Quot(akode)
          + ' and esh_tahun ='+ atahun
          + ' and esh_periode='+ abulan;

   tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
        if not eof then
        begin
          result:=true;
          Exit;
        end;
    finally
      free;
    end;
  end;


end;

end.
