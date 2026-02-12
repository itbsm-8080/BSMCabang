unit ufrmBrowsePermintaanBarang;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmCxBrowse, Menus, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, FMTBcd, Provider, SqlExpr, ImgList,
  ComCtrls, StdCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, MyAccess;

type
  TfrmBrowsePermintaanBarang = class(TfrmCxBrowse)
    PopupMenu1: TPopupMenu;
    UpdateStatusKembali1: TMenuItem;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxButton5: TcxButton;
    procedure btnRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton6Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
//    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxGrdMasterStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
//    procedure cxButton9Click(Sender: TObject);

  private
    conn2 : TSQLConnection;
    aHost2,aDatabase2,auser2,apassword2 : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowsePermintaanBarang: TfrmBrowsePermintaanBarang;

implementation
   uses ufrmPermintaanBarang,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowsePermintaanBarang.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'SELECT pb_nomor Nomor, pb_tanggal Tanggal, pb_memo Memo, user_create User, date_create'
                  + ' FROM tpermintaanbarang_hdr'
                  + ' WHERE pb_tanggal BETWEEN ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' GROUP BY pb_nomor, pb_tanggal, pb_memo; ';

  Self.SQLDetail := ' SELECT pbd_pb_nomor Nomor, pbd_brg_kode SKU, brg_nama NamaBarang, pbd_satuan Satuan, pbd_qty QTY, pbd_stoknow StokNow, pbd_avgsale AvgSale'
                    + ' FROM tpermintaanbarang_dtl a'
                    + ' INNER JOIN tpermintaanbarang_hdr b ON b.pb_nomor = a.pbd_pb_nomor'
                    + ' INNER JOIN tbarang c ON c.brg_kode = a.pbd_brg_kode'
                    + ' WHERE pb_tanggal BETWEEN ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' ORDER BY pb_nomor; ';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=200;
    cxGrdMaster.Columns[4].Width :=200;

    cxGrdDetail.Columns[0].Width :=100;
    cxGrdDetail.Columns[1].Width :=100;
    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowsePermintaanBarang.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowsePermintaanBarang.cxButton2Click(Sender: TObject);
var
  frmPermintaanBarang: TfrmPermintaanBarang;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Permintaan Barang' then
   begin
      frmPermintaanBarang  := frmmenu.ShowForm(TfrmPermintaanBarang) as TfrmPermintaanBarang;
      if frmPermintaanBarang.FLAGEDIT = False then
      frmPermintaanBarang.edtNomor.Text := frmPermintaanBarang.getmaxkode;
   end;
   frmPermintaanBarang.Show;
end;

procedure TfrmBrowsePermintaanBarang.cxButton1Click(Sender: TObject);
var
  frmPermintaanBarang: TfrmPermintaanBarang;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Permintaan Barang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmPermintaanBarang  := frmmenu.ShowForm(TfrmPermintaanBarang) as TfrmPermintaanBarang;
      frmPermintaanBarang.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmPermintaanBarang.FLAGEDIT := True;
      frmPermintaanBarang.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmPermintaanBarang.loaddataall(CDSMaster.FieldByname('Nomor').AsString);
   end;
   frmPermintaanBarang.Show;
end;

procedure TfrmBrowsePermintaanBarang.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

//procedure TfrmBrowsePermintaanBarang.cxButton3Click(Sender: TObject);
//begin
//  inherited;
//  frmPermintaanBarang.doslip(CDSMaster.FieldByname('Nomor').AsString);
//end;

procedure TfrmBrowsePermintaanBarang.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmPermintaanBarang') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;

      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tpermintaanbarang_dtl '
        + ' where pbd_pb_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
        EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

       s:='delete from tpermintaanbarang_hdr '
        + ' where pb_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
        EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);


      CDSMaster.Delete;
   except
     MessageDlg('Gagal Hapus',mtError, [mbOK],0);
     
     Exit;
   end;
    

end;


procedure TfrmBrowsePermintaanBarang.cxGrdMasterStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  AColumn : TcxCustomGridTableItem;
begin
  AColumn := (Sender as TcxGridDBTableView).GetColumnByFieldName('Kembali');

  if (AColumn <> nil)  and (ARecord <> nil) and (AItem <> nil) and
     (cVarToFloat(ARecord.Values[AColumn.Index]) > 0) then
    AStyle := cxStyle1;
end;

procedure TfrmBrowsePermintaanBarang.cxButton5Click(Sender: TObject);
var
 ss,s,anoreferensi:String;
  ttt,tt : TStrings;

  i:integer;
  tsql:TmyQuery;
begin
  ttt := TStringList.Create;

 // if chkbarang.Checked then
 begin


  s := 'SELECT * FROM tpermintaanbarang_hdr WHERE (date_create between '+Quotd(startdate.DateTime) +' and '+Quotd(enddate.DateTime+1)+')'
  +' OR (date_modified between '+quotd(startdate.datetime)+' and '+Quotd(enddate.DateTime+1)+')';


  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin
      ss:='delete from bsm.tpermintaanbarang_dtl where pbd_pb_nomor ='+Quot(Fieldbyname('pb_nomor').AsString)+';';
       ttt.Append(ss);
      ss:='delete from bsm.tpermintaanbarang_hdr  where pb_nomor ='+ Quot(FieldByname('pb_nomor').AsString)+';';
      ttt.Append(ss);

      ss := 'insert ignore into bsm.tpermintaanbarang_hdr ('
          + ' pb_nomor,pb_tanggal,pb_memo,date_create,date_modified,user_create,user_modified'
          + ' ) values ('
          + Quot(fieldbyname('pb_nomor').AsString) +','+ Quotd(fieldbyname('pb_tanggal').AsDateTime) +','
          + quot(fieldbyname('pb_memo').Asstring) +','
          + quotd(fieldbyname('date_create').AsDateTime) +','+ quotd(fieldbyname('date_modified').AsDateTime)+','
          + quot(fieldbyname('user_create').Asstring) +','+quot(fieldbyname('user_modified').Asstring)
          +');';

         ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;
        

      s := 'SELECT * '
        + ' FROM tpermintaanbarang_dtl inner join tpermintaanbarang_hdr on pb_nomor=pbd_pb_nomor'
        + ' WHERE (date_create between '+Quotd(startdate.DateTime) +' and '+Quotd(enddate.DateTime+1)+')'
        +' OR (date_modified between '+quotd(startdate.datetime)+' and '+Quotd(enddate.DateTime+1)+')';
      tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin

      ss:='insert ignore into bsm.tpermintaanbarang_dtl (pbd_pb_nomor,pbd_brg_kode,pbd_satuan,pbd_qty,'
      + ' pbd_stoknow,pbd_avgsale,pbd_nourut,pbd_keterangan'
      + ' ) values ('
      + Quot(Fieldbyname('pbd_pb_nomor').AsString) +','
      + Quot(Fieldbyname('pbd_brg_kode').AsString) +','
      + Quot(Fieldbyname('pbd_satuan').AsString) +','
      + FloatToStr(Fieldbyname('pbd_qty').AsFloat) +','
      + FloatToStr(Fieldbyname('pbd_stoknow').AsFloat) +','
      + FloatToStr(Fieldbyname('pbd_avgsale').AsFloat) +','
      + intToStr(Fieldbyname('pbd_nourut').AsInteger) +','
      + Quot(Fieldbyname('pbd_keterangan').AsString)  +');';


     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;

   s:='SELECT * '
      + ' FROM tpermintaanbarang_dtl inner join tpermintaanbarang_hdr on pb_nomor=pbd_pb_nomor'
      + ' WHERE (date_create between '+Quotd(startdate.DateTime) +' and '+Quotd(enddate.DateTime+1)+')'
      +' OR (date_modified between '+quotd(startdate.datetime)+' and '+Quotd(enddate.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin

      ss:='insert ignore into bsm.tpermintaanbarang_dtl (pbd_pb_nomor,pbd_brg_kode,pbd_satuan,pbd_qty,'
      + ' pbd_stoknow,pbd_avgsale,pbd_nourut,pbd_keterangan'
      + ' ) values ('
      + Quot(Fieldbyname('pbd_pb_nomor').AsString) +','
      + Quot(Fieldbyname('pbd_brg_kode').AsString) +','
      + Quot(Fieldbyname('pbd_satuan').AsString) +','
      + FloatToStr(Fieldbyname('pbd_qty').AsFloat) +','
      + FloatToStr(Fieldbyname('pbd_stoknow').AsFloat) +','
      + FloatToStr(Fieldbyname('pbd_avgsale').AsFloat) +','
      + intToStr(Fieldbyname('pbd_nourut').AsInteger) +','
      + Quot(Fieldbyname('pbd_keterangan').AsString)  +');';


     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;



      try
       ttt.SaveToFile(cGetReportPath+'datapermintaan'+frmmenu.NMCABANG+FormatDateTime('yyymmdd',date)+'.sql');

      finally
        ttt.Free;
      end;

  end;

  showmessage('file terbentuk di '+cGetReportPath+'datapermintaan'+frmmenu.NMCABANG+FormatDateTime('yyymmdd',date)+'.sql');
end;


end.
