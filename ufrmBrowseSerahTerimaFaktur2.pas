unit ufrmBrowseSerahTerimaFaktur2;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, frxClass,
  frxDMPExport, MyAccess;

type
  TfrmBrowseSerahTerimaFaktur2 = class(TfrmCxBrowse)
    cxButton5: TcxButton;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    function cekrealisasi(akode:string):boolean;
    procedure cxButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseSerahTerimaFaktur2: TfrmBrowseSerahTerimaFaktur2;

implementation
   uses Ulib, MAIN, uModuleConnection, ufrmserahterimafaktur2;
{$R *.dfm}

procedure TfrmBrowseSerahTerimaFaktur2.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := ' Select sth2_nomor Nomor,sth2_tanggal Tanggal, sth2_sls_kode SlsKode, '
                  + ' sth2_memo Note '
                  + ' from tserahterimafaktur_hdr2 '
                  + ' where sth2_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime);

  Self.SQLDetail := 'select std2_sth2_nomor Nomor,std2_fp_nomor Faktur, fp_tanggal Tanggal ,fp_jthtempo JthTempo,fp_amount Nilai,cus_nama Customer'
                    + ' from tserahterimafaktur_dtl2'
                    + ' inner join tserahterimafaktur_hdr2 on sth2_nomor=std2_sth2_nomor'
                    + ' inner join tfp_hdr on std2_fp_nomor=fp_nomor'
                    + ' inner join tcustomer on cus_kode=fp_cus_kode'
                    + ' where sth2_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by std2_sth2_nomor ';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=80;
    cxGrdMaster.Columns[3].Width :=100;
    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseSerahTerimaFaktur2.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseSerahTerimaFaktur2.cxButton2Click(Sender: TObject);
var
  frmserahterimafaktur2: Tfrmserahterimafaktur2;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Serah Terima Faktur Salesman' then
   begin
      frmserahterimafaktur2  := frmmenu.ShowForm(Tfrmserahterimafaktur2) as Tfrmserahterimafaktur2;
      if frmserahterimafaktur2.FLAGEDIT = False then
      frmserahterimafaktur2.edtNomor.Text := frmserahterimafaktur2.getmaxkode;
   end;
   frmserahterimafaktur2.Show;
end;

procedure TfrmBrowseSerahTerimaFaktur2.cxButton1Click(Sender: TObject);
var
  frmserahterimafaktur2: Tfrmserahterimafaktur2;
begin
  inherited;
  IF Cekrealisasi(CDSMaster.FieldByname('Nomor').AsString) then
  begin
    ShowMessage('Nomor ini sudah di realisasi , tidak dapat di edit');
    Exit;
  end;

  { if CDSMaster.FieldByname('SERAH').AsString <> frmMenu.KDUSER Then
  begin
    ShowMessage('Anda tidak berhak edit transaksi ini');
    Exit;
  end; }

  If CDSMaster.FieldByname('Nomor').IsNull then exit;

  if ActiveMDIChild.Caption <> 'Serah Terima Faktur' then
  begin
    //      ShowForm(TfrmBrowseBarang).Show;
    frmserahterimafaktur2 := frmmenu.ShowForm(Tfrmserahterimafaktur2) as Tfrmserahterimafaktur2;
    frmserahterimafaktur2.ID := CDSMaster.FieldByname('Nomor').AsString;
    frmserahterimafaktur2.FLAGEDIT := True;
    frmserahterimafaktur2.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
    frmserahterimafaktur2.loaddataall(CDSMaster.FieldByname('Nomor').AsString);
  end;

  frmserahterimafaktur2.Show;
end;

procedure TfrmBrowseSerahTerimaFaktur2.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseSerahTerimaFaktur2.cxButton3Click(Sender: TObject);
begin
  inherited;
  { if CDSMaster.FieldByname('serah').AsString <> frmMenu.KDUSER Then
  begin
    ShowMessage('Anda tidak berhak Cetak transaksi ini');
    Exit;
  end;}
  frmserahterimafaktur2.doslip(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowseSerahTerimaFaktur2.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
  if frmMenu.KDUSER='GUDANG' then
  begin
     if NOT ((CDSMaster.FieldByname('TERIMA').AsString='GUDANG') or (CDSMaster.FieldByname('TERIMA').AsString='SALESMAN')
     or (CDSMaster.FieldByname('TERIMA').AsString='DRIVER'))  THEN
     begin
         ShowMessage('Anda tidak berhak Realisasi transaksi ini');
         Exit;
     end;
  end
  else
  begin
    if frmMenu.KDUSER='piutang' then
      begin
         if NOT ((CDSMaster.FieldByname('TERIMA').AsString = 'piutang') or (CDSMaster.FieldByname('TERIMA').AsString='COLLECTOR')
         or (CDSMaster.FieldByname('TERIMA').AsString='LEGAL')
         )  THEN
         begin
             ShowMessage('Anda tidak berhak Realisasi transaksi ini');
             Exit;
         end;
      end
      ELSE
      BEGIN
        if CDSMaster.FieldByname('TERIMA').AsString <> frmMenu.KDUSER Then
        begin
          ShowMessage('Anda tidak berhak Realisasi transaksi ini');
          Exit;
        end;
     end;
  end;
       if MessageDlg('Yakin Realisasi Serah terima ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='UPDATE tserahterimafaktur_hdr2 set sth2_realisasi=1 '
        + ' where sth2_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
        EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
      
      btnRefreshClick(self);

end;

function TfrmBrowseSerahTerimaFaktur2.cekrealisasi(akode:string):boolean;
var
  s:string;
  tsql:TmyQuery;
begin
  Result := False;

  {S := ' select sth2_realisasi from '
     + ' tserahterimafaktur_hdr2'
     + ' WHERE sth2_nomor = ' + Quot(akode);

  tsql := xOpenQuery(s,frmMenu.conn) ;
  with tsql do
  begin
    try
      if Fields[0].AsInteger = 1  then
      Result := True
    finally
      free;
    end;
  end; }
end;


procedure TfrmBrowseSerahTerimaFaktur2.cxButton5Click(Sender: TObject);
begin
  inherited;
 if CDSMaster.FieldByname('serah').AsString <> frmMenu.KDUSER Then
  begin
    ShowMessage('Anda tidak berhak Cetak transaksi ini');
    Exit;
  end;
 frmserahterimafaktur2.doslip2(CDSMaster.FieldByname('Nomor').AsString);

end;



end.
