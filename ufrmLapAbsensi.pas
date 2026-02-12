unit ufrmLapAbsensi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
   dxSkinsDefaultPainters, DBClient, cxControls, cxContainer,
  cxEdit, AdvEdBtn, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBExtLookupComboBox, cxSpinEdit, cxTimeEdit, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxButtonEdit,
  cxCheckBox, cxCurrencyEdit, AdvCombo, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinDarkRoom, dxSkinFoggy,
  dxSkinSeven, dxSkinSharp, DBAccess, MyAccess, MemDS;

type
  TfrmLapAbsensi = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel4: TAdvPanel;
    cxGrid1: TcxGrid;
    cxGridLembur: TcxGridDBTableView;
    clNama: TcxGridDBColumn;
    clTanggal: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    Label1: TLabel;
    Button1: TButton;
    cxButton7: TcxButton;
    savedlg: TSaveDialog;
    startdate: TDateTimePicker;
    Label2: TLabel;
    enddate: TDateTimePicker;
    clCabang: TcxGridDBColumn;
    clTerlambat: TcxGridDBColumn;
    clPotonganHari: TcxGridDBColumn;
    clJabatan: TcxGridDBColumn;
    clHari: TcxGridDBColumn;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    clTidakMasuk: TcxGridDBColumn;
    clKeterangan: TcxGridDBColumn;
    clJmlMasuk: TcxGridDBColumn;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    procedure refreshdata;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure loaddataall ;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton8Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function GetCDSLembur: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure RefreshClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cxButton7Click(Sender: TObject);
    procedure cxGridLemburStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
      procedure bacafile2;
  private
   aHost2,aDatabase2,auser2,apassword2 : string;
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
  frmLapAbsensi: TfrmLapAbsensi;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,cxGridExportLink,uReport;

{$R *.dfm}

procedure TfrmLapAbsensi.refreshdata;
begin
StartDate.DateTime := StrToDate(FormatDateTime('mm',Now)+'/01/'+FormatDateTime('yyyy',Now));
  EndDate.DateTime := Date;
  CDSLembur.EmptyDataSet;
  CDSLembur.Append;
  CDSLembur.Post;
end;
procedure TfrmLapAbsensi.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
      Release;
  end;


end;

procedure TfrmLapAbsensi.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;


procedure TfrmLapAbsensi.loaddataall ;
var
  s: string;
  i:integer;
  tsql : TmyQuery;
  aterjadwal,atidakterjadwal : Integer;
begin
  s:= 'call absensifix('+quotd(startdate.date)+','+quotd(enddate.date)+','+quot(frmmenu.KDCABANG)+') ;';
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

                      CDSLembur.Append;
                      CDSLembur.fieldbyname('nama').AsString := fieldbyname('nama').AsString;
                      CDSLembur.fieldbyname('nik').asstring := fieldbyname('nik').asstring;
                      CDSLembur.fieldbyname('hari').asstring := fieldbyname('HARI').asstring;
                      CDSLembur.fieldbyname('cabang').asstring  := fieldbyname('cabang').AsString;
                      CDSLembur.fieldbyname('Jabatan').asstring  := fieldbyname('jabatan').AsString;
                      CDSLembur.fieldbyname('Masuk').asstring  := fieldbyname('Masuk').AsString;
                      CDSLembur.fieldbyname('tidakmasuk').asstring  := fieldbyname('tidakmasuk').AsString;
                      CDSLembur.fieldbyname('terlambat').asstring  := fieldbyname('terlambat').AsString;
                      CDSLembur.fieldbyname('potonganhari').asstring  := fieldbyname('potonganhari').AsString;
                      CDSLembur.fieldbyname('keterangan').asstring  := fieldbyname('keterangan').AsString;
                      CDSLembur.Post;

                   i:=i+1;
                   next;
               end;

  finally

  end;


end;

end;

procedure TfrmLapAbsensi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;


procedure TfrmLapAbsensi.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmLapAbsensi.FormShow(Sender: TObject);
begin
 refreshdata ;
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

function TfrmLapAbsensi.GetCDSLembur: TClientDataSet;
begin
  If not Assigned(FCDSLembur) then
  begin
    FCDSLembur := TClientDataSet.Create(Self);
    zAddField(FCDSLembur, 'nama', ftString, False,100);
    zAddField(FCDSLembur, 'nik', ftString, False,30);
    zAddField(FCDSLembur, 'hari', ftString, False,20);
    zAddField(FCDSLembur, 'Cabang', ftString, False,50);
    zAddField(FCDSLembur, 'Jabatan', ftString, False,20);
    zAddField(FCDSLembur, 'Terlambat', ftString, False,20);
    zAddField(FCDSLembur, 'Masuk', ftString, False,20);    
    zAddField(FCDSLembur, 'PotonganHari', ftString, False,30);
    zAddField(FCDSLembur, 'TidakMasuk', ftString, False,20);
    zAddField(FCDSLembur, 'Keterangan', ftString, False,200);

    FCDSLembur.CreateDataSet;
  end;
  Result := FCDSLembur;
end;

procedure TfrmLapAbsensi.FormCreate(Sender: TObject);
begin

   TcxDBGridHelper(cxGridLembur).LoadFromCDS(CDSLembur, False, False);
end;

procedure TfrmLapAbsensi.RefreshClick(Sender: TObject);
begin
loaddataall;
end;

procedure TfrmLapAbsensi.Button1Click(Sender: TObject);
begin
loaddataall;
end;

procedure TfrmLapAbsensi.cxButton7Click(Sender: TObject);
begin
  if SaveDlg.Execute then
    ExportGridToExcel(SaveDlg.FileName, cxGrid1);

  cxGridLembur.DataController.CollapseDetails;
end;


procedure TfrmLapAbsensi.cxGridLemburStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  AColumn : TcxCustomGridTableItem;
begin
  AColumn := (Sender as TcxGridDBTableView).GetColumnByFieldName('status');


  if (AColumn <> nil)  and (cVarToInt(ARecord.Values[AColumn.Index]) = 1) then
    AStyle := cxStyle2;
  if (AColumn <> nil)  and (cVarToInt(ARecord.Values[AColumn.Index]) =2) then
    AStyle := cxStyle1;

end;


procedure TfrmLapAbsensi.bacafile2;
var
s:string;
tsql:TmyQuery;

 begin
   s:='select ahost,adatabase,auser,apassword from tsetingdb where nama like '+Quot('default4') +';';
   tsql:=xOpenQuery(s,frmmenu.conn);

  with tsql do
  begin
    try
       aHost2     := fields[0].AsString;
       aDatabase2 := 'hrd';
       auser2     := fields[2].AsString;
       apassword2 := fields[3].AsString;

    finally
      free;
    end;
  end;

 end;


end.
