unit ufrmBrowseJurnal;

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
  dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinXmas2008Blue,dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, FMTBcd, Provider, SqlExpr, ImgList,
  ComCtrls, StdCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, MyAccess;

type
  TfrmBrowseJurnal = class(TfrmCxBrowse)
    cxButton5: TcxButton;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseJurnal: TfrmBrowseJurnal;

implementation
   uses ufrmPembayaranLain,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseJurnal.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := ' select jur_no Nomor,jur_tanggal Tanggal, jur_keterangan Keterangan,if(jur_isclosed =1,"Sudah","Belum") IsClosed ,'
                  + ' SUM(jurd_debet) NilaiDebet,sum(jurd_kredit) NilaiKredit,JUR_TIpetransaksi Tipe_Transaksi '
                  + ' from tjurnal inner join tjurnalitem on jur_no=jurd_jur_no where '
                  + ' jur_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' GROUP BY JUR_NO '                                                     
                  + ' order by jur_tanggal ';

  Self.SQLDetail := 'select JUR_NO Nomor,JURD_REK_KODE Account,rek_nama AccountName, jurd_debet Debet,jurd_kredit Kredit,cc_nama CostCenter from tjurnal'
                    + ' inner join tjurnalitem on jur_no=jurd_jur_no'
                    + ' inner join trekening on rek_kode=jurd_rek_KODE'
                    + ' LEFT JOIN tcostcenter on cc_kode=jurd_cc_kode'
                    + ' where '
                    + ' jur_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by JUR_NO ,jurd_nourut';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=100;

    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;
        cxGrdMaster.Columns[4].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[4].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[5].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[5].Summary.FooterFormat:='###,###,###,###';


end;

procedure TfrmBrowseJurnal.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseJurnal.cxButton2Click(Sender: TObject);
var
  frmPembayaranLain: TfrmPembayaranLain;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Pembayaran Lain lain' then
   begin
      frmPembayaranLain  := frmmenu.ShowForm(TfrmPembayaranLain) as TfrmPembayaranLain;
      if frmPembayaranLain.FLAGEDIT = false then
      frmPembayaranLain.edtNomor.Text := frmPembayaranLain.getmaxkode;
   end;
   frmPembayaranLain.Show;
end;

procedure TfrmBrowseJurnal.cxButton1Click(Sender: TObject);
var
  frmPembayaranLain: TfrmPembayaranLain;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Pembayaran Lain lain' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmPembayaranLain  := frmmenu.ShowForm(TfrmPembayaranLain) as TfrmPembayaranLain;
      frmPembayaranLain.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmPembayaranLain.FLAGEDIT := True;
      frmPembayaranLain.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmPembayaranLain.loaddataALL(CDSMaster.FieldByname('Nomor').AsString);
      if CDSMaster.FieldByname('IsClosed').AsString = 'Sudah' then
      begin
        ShowMessage('Transaksi ini sudah tutup Periode,Tidak dapat di edit');
        frmPembayaranLain.cxButton2.Enabled :=False;
        frmPembayaranLain.cxButton1.Enabled :=False;
      end;
   end;
   frmPembayaranLain.Show;
end;

procedure TfrmBrowseJurnal.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseJurnal.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmPembayaranLain.doslipmutasi(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowseJurnal.cxButton5Click(Sender: TObject);
var
  ss,s:String ;
  tt:tstrings;
  i:integer;
  tsql:TmyQuery;
  conn2 :TMyConnection;
begin
  inherited;
    tt := TStringList.Create;
    s:='select * from tsetingdb where nama="default1"';
    tsql:=xOpenQuery(s,frmmenu.conn);
    with tsql do
    begin
      try
        conn2 := xCreateConnection(ctMySQL,fieldbyname('aHost').AsString,fieldbyname('aDatabase').AsString,fieldbyname('auser').AsString,fieldbyname('apassword').AsString);
      finally
        free;
      end;
    end;


  s:='SELECT jur_tanggal,jur_tipetransaksi,jur_no,jur_keterangan,jur_isclosed FROM tjurnal WHERE jur_no='+quot(CDSMaster.FieldByname('Nomor').AsString) ;

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin
      ss:='delete from tjurnal  where jur_no ='+ Quot(Fields[2].AsString)+';';
      tt.Append(ss);


      ss:='delete from tjurnalitem  where jurd_jur_no ='+ Quot(Fields[2].AsString)+';';
      tt.Append(ss);



//      xExecQuery(ss,frmMenu.conn);
      ss:='insert ignore into tjurnal (jur_tanggal,jur_tipetransaksi,jur_no,jur_keterangan,jur_isclosed '
      + ' ) values ('
      + Quotd(Fields[0].AsDateTime) +','
      + Quot(Fields[1].AsString) +','
      + Quot(Fields[2].AsString) +','
      + Quot(Fields[3].AsString) +','
      + intToStr(Fields[4].AsInteger)
      +');';
//      xExecQuery(ss,frmMenu.conn2);
     tt.append(ss);


      Next;
    end;
      tsql.Free;
   end;
    s:='SELECT jurd_jur_no,jurd_rek_kode,jurd_debet,jurd_kredit,jurd_nourut, jurd_cc_kode,jurd_keterangan'
      + ' FROM tjurnalitem inner join tjurnal on jurd_jur_no =jur_no'
      + ' WHERE jurd_jur_No='+ quot(CDSMaster.FieldByname('Nomor').AsString) ;

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin

      ss:='insert ignore into tjurnalitem ('
      + ' jurd_jur_no,jurd_rek_kode,jurd_debet,jurd_kredit,jurd_nourut,jurd_keterangan,jurd_cc_kode'
      + ' ) values ('
      + Quot(Fields[0].AsString) +','
      + Quot(Fields[1].Asstring) +','
      + FloatToStr(Fields[2].AsFloat) +','
      + FloatToStr(Fields[3].AsFloat) +','
      + FloatToStr(Fields[4].AsFloat) +','
      + Quot(Fields[6].Asstring) +','
      + Quot(Fields[5].Asstring) +');';

     tt.append(ss);


      Next;
    end;
      tsql.Free;
   end;



       try
        for i:=0 to tt.Count -1 do
        begin
            EnsureConnected(conn2);
            ExecSQLDirect(conn2, tt[i]);
         end;
      finally
        tt.Free;
      end;
  conn2.free;


end;

end.
