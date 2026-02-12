unit ufrmSettingKomisiMarketing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  DBClient, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxSpinEdit, cxButtonEdit, cxTextEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, AdvEdBtn, cxCurrencyEdit, AdvCombo,
  MyAccess;

type
  TfrmSettingKomisiMarketing = class(TForm)
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
    edtKode: TAdvEditBtn;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    Label1: TLabel;
    Label4: TLabel;
    cbbBulan: TAdvComboBox;
    edtTahun: TComboBox;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clKode: TcxGridDBColumn;
    clNamaGroup: TcxGridDBColumn;
    clHNA: TcxGridDBColumn;
    clTargetQty: TcxGridDBColumn;
    clTotal: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata(akode:string) ;
    procedure simpandata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure edtKodeClickBtn(Sender: TObject);
    procedure edtKodeExit(Sender: TObject);
    procedure clTargetQtyPropertiesEditValueChanged(Sender: TObject);

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
  frmSettingKomisiMarketing: TfrmSettingKomisiMarketing;
 const
     NOMERATOR = 'SK';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib;

{$R *.dfm}

procedure TfrmSettingKomisiMarketing.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
end;

procedure TfrmSettingKomisiMarketing.refreshdata;
begin
  FID:='';
  FLAGEDIT := False;
  edtkode.Clear;
  edtNama.Clear;
  cbbBulan.SetFocus;

end;
procedure TfrmSettingKomisiMarketing.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmSettingKomisiMarketing.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmSettingKomisiMarketing.loaddata(akode:string) ;
var
  s: string;
  tsql : TmyQuery;
  i:Integer;
begin
  s:= 'select kode_grouppf,nama_grouppf,hna_grouppf,ifnull(tm_target,0) qty,ifnull(tm_target,0)*hna_grouppf total from '
    + ' tgrouppf '
    + ' left join ttargetmarketing on kode_grouppf=tm_grouppf and  tm_tahun='+edttahun.Text
    + ' and tm_periode ='+inttostr(cbbBulan.ItemIndex+1)
    + ' and tm_salesman = '+ Quot(edtKode.Text);
tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
  try


    CDS.EmptyDataSet;
    i:=1;
    while  not Eof do
    begin
      CDS.Append;
      CDS.FieldByName('no').AsString := IntToStr(i);
      CDS.FieldByName('kode').AsString  := fieldbyname('kode_grouppf').AsString;
      CDS.FieldByName('nama').AsString  := fieldbyname('nama_grouppf').AsString;
      CDS.FieldByName('hna').Asfloat  := fieldbyname('hna_grouppf').Asfloat;
      CDS.FieldByName('qty').Asfloat  := fieldbyname('qty').Asfloat;
      CDS.FieldByName('total').Asfloat  := fieldbyname('total').Asfloat;
      CDS.Post;
      i:=i+1;
      next;
    end;



  finally
    Free;
  end;
 end;

end;


procedure TfrmSettingKomisiMarketing.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;
begin
     tt := TStringList.Create;
   s:= ' delete from ttargetmarketing'
      + ' where  tm_periode =' + inttostr(cbbBulan.ItemIndex+1)
      + ' and tm_tahun = ' + edtTahun.Text
      + ' and tm_salesman='+ quot(edtkode.text);
   tt.Append(s);

      CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
    S:='insert into ttargetmarketing (tm_grouppf,tm_salesman,tm_hna,tm_target,tm_periode,tm_tahun) values ('
      + quot(CDS.FieldByName('kode').Asstring)+','
      + quot(edtkode.text)+','
      + floattostr(CDS.FieldByName('hna').Asfloat)+','
      + floattostr(CDS.FieldByName('qty').Asfloat)+','
      + inttostr(cbbBulan.ItemIndex+1) + ','
      + edttahun.text
      + ');';
    tt.Append(s);
    cds.Next;
   end;
    CDS.Next;
    Inc(i);
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


procedure TfrmSettingKomisiMarketing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmSettingKomisiMarketing.cxButton1Click(Sender: TObject);
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

procedure TfrmSettingKomisiMarketing.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmSettingKomisiMarketing.cxButton2Click(Sender: TObject);
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
procedure TfrmSettingKomisiMarketing.FormShow(Sender: TObject);
begin
refreshdata;
end;

function TfrmSettingKomisiMarketing.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Kode', ftString, False,20);
    zAddField(FCDS, 'Nama', ftstring, False,100);
    zAddField(FCDS, 'HNA', ftfloat, False,100);
    zAddField(FCDS, 'Qty', ftfloat, False,100);
    zAddField(FCDS, 'Total', ftfloat, False,100);


    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

procedure TfrmSettingKomisiMarketing.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmSettingKomisiMarketing.edtKodeClickBtn(Sender: TObject);
begin
     sqlbantuan := ' SELECT sls_kode Kode,sls_nama Nama from tsalesman';

  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
  begin
    edtKode.Text := varglobal;
    edtNama.Text :=  varglobal1;
  end;

end;

procedure TfrmSettingKomisiMarketing.edtKodeExit(Sender: TObject);
begin
loaddata(edtKode.Text);
end;

procedure TfrmSettingKomisiMarketing.clTargetQtyPropertiesEditValueChanged(
  Sender: TObject);
  var
    lVal:double;
    i:Integer;
begin
   cxGrdMain.DataController.Post;

  i := cxGrdMain.DataController.FocusedRecordIndex;
lVal := cxGrdMain.DataController.Values[i, clTargetQty.Index] *  cxGrdMain.DataController.Values[i, clHNA.Index];
  If CDS.State <> dsEdit then CDS.Edit;
  CDS.FieldByName('Total').AsFloat := lVal;
  
  CDS.Post;
end;

end.
