unit ufrmBrowseTTFaktur;

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
  TfrmBrowseTTFaktur = class(TfrmCxBrowse)
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  private
    { Private declarations }
    adatabase:string;
  public
    { Public declarations }
  end;

var
  frmBrowseTTFaktur: TfrmBrowseTTFaktur;

implementation
   uses ufrmJC,Ulib, MAIN, uModuleConnection,ufrmCetak,ufrmttfaktur;
{$R *.dfm}

procedure TfrmBrowseTTFaktur.btnRefreshClick(Sender: TObject);
begin

  Self.SQLMaster := 'select tt_nomor Nomor,tt_tanggal Tanggal,sls_nama Salesman,cus_nama Customer ,'
            + ' (select sum(fp_amount-fp_bayar) from tfp_hdr inner join '+adatabase+'.ttt_dtl on ttd_fp_nomor=fp_nomor where ttd_tt_nomor=tt_nomor ) Total '
            + ' from '+adatabase+'.ttt_hdr inner join tcustomer on cus_kode=tt_cus_kode'
            + ' inner join tsalesman on sls_kode=tt_sls_kode '
            + ' where tt_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime);
  Self.SQLDetail := 'select ttd_tt_nomor Nomor,'
                    + ' ttd_fp_nomor No_Faktur,fp_tanggal Tanggal,fp_jthtempo JT_Tempo,fp_amount Nilai,(fp_amount-fp_bayar) Sisa_piutang'
                    + ' from '+adatabase+'.ttt_dtl'
                    + ' inner join '+adatabase+'.ttt_hdr on tt_nomor=ttd_tt_nomor '
                    + ' inner join tfp_hdr on ttd_fp_nomor =fp_nomor'
                    + ' where tt_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by tt_nomor' ;
 Self.MasterKeyField := 'Nomor';

   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=150;
    cxGrdMaster.Columns[1].Width :=200;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=200;
end;

procedure TfrmBrowseTTFaktur.FormShow(Sender: TObject);
var
  s:string;
  tsql:TmyQuery;

begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
   s:='SELECT adatabase FROM tsetingdb WHERE nama="default2"';
   tsql :=xOpenQuery(s,frmMenu.conn);
   adatabase := tsql.Fields[0].AsString;

  btnRefreshClick(Self);
end;

procedure TfrmBrowseTTFaktur.cxButton3Click(Sender: TObject);
var
  s: string ;
  tsql2,tsql : TmyQuery;
  abaris,i,a:Integer;
  anamabarang: String;
  anilai : double;

begin
    Application.CreateForm(TfrmCetak,frmCetak);
    abaris := 13;
 with frmCetak do
 begin
    memo.Clear;
    memo.Lines.Add('');

       s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp '
      + ' from tperusahaan ';

  tsql := xOpenQuery(s, frmMenu.conn);
  with tsql do
  begin
    try
      memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' T A N D A   T E R I M A  F A K T U R ', 40 , ' '));
      memo.Lines.Add(StrPadRight(Fields[1].AsString, 120, ' '));
      memo.Lines.Add(StrPadRight(Fields[3].AsString, 120, ' '));
    finally
      Free;
    end;
  end;

          s:= ' select '
       + ' *,ADDDATE(fp_tanggal, INTERVAL 30 DAY) jt,(FP_AMOUNT-fp_dp-fp_bayar-if(fp_isdtp=1,fp_taxamount,0)) nilai,'
       + ' (select sum(retj_amount) from tretj_hdr where retj_fp_nomor =z.fp_nomor) retur'
       + ' from '+adatabase+'.ttt_hdr '
       + ' inner join '+adatabase+'.ttt_dtl on tt_nomor=ttd_tt_nomor'
       + ' inner join tcustomer on cus_kode=tt_cus_kode '
       + ' left join tsalesman on sls_kode=tt_sls_kode '
       + ' left join  tfp_hdr z on fp_nomor=ttd_fp_nomor '
       + ' where '
       + ' tt_nomor=' + quot(CDSMaster.FieldByname('nomor').AsString)
       + ' order by ttd_fp_nomor ';

tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try

    if not Eof then
    begin
      memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('tt_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('tt_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Salesman : '+fieldbyname('sls_nama').AsString, 60, ' '));

      memo.Lines.Add(StrPadRight('', 120, '-'));
      memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
                          +StrPadRight('Nomor', 20, ' ')+' '
                          +StrPadRight('Tanggal', 20, ' ')+' '
                          +StrPadRight('Jt. Tempo', 20, ' ')+' '
                          +StrPadLeft('Nilai', 20, ' ')
                          );
       memo.Lines.Add(StrPadRight('', 120, '-'));
    end;
    anilai:=0;
     while not eof do
     begin

       i:=i+1;
       memo.Lines.Add(StrPadRight(IntToStr(i), 3, ' ')+' '
                          +StrPadRight(fieldbyname('ttd_fp_nomor').AsString, 20, ' ')+' '
                          +StrPadRight(FormatDateTime('dd/mm/yyyy',fieldbyname('fp_tanggal').asdatetime), 20, ' ')+' '
                          +StrPadRight(FormatDateTime('dd/mm/yyyy',fieldbyname('jt').asdatetime), 20, ' ')+' '
                          +StrPadLeft(FormatFloat('###,###,###',fieldbyname('nilai').Asfloat-fieldbyname('retur').Asfloat), 20, ' ')
                          );
       anilai := anilai +   (fieldbyname('nilai').Asfloat-fieldbyname('retur').Asfloat);
       Next;
       if (i mod abaris =0) and (not eof) then
       begin
         memo.Lines.Add(StrPadRight('', 120, '-'));
            for a:=1 to 7 do
            begin
              memo.Lines.Add('');
            end;
                        s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp from tperusahaan ';

            tsql2 := xOpenQuery(s, frmMenu.conn);
            with tsql2 do
            begin
              try
                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' T A N D A   T E R I M A  F A K T U R ', 40 , ' '));
                memo.Lines.Add(StrPadRight(Fields[1].AsString, 120, ' '));
                memo.Lines.Add(StrPadRight(Fields[3].AsString, 120, ' '));
              finally
                Free;
              end;
            end;


      memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('tt_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('tt_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Salesman : '+fieldbyname('sls_nama').AsString, 60, ' '));

            memo.Lines.Add(StrPadRight('', 120, '-'));
      memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
                          +StrPadRight('Nomor', 20, ' ')+' '
                          +StrPadRight('Tanggal', 20, ' ')+' '
                          +StrPadRight('Jt. Tempo', 20, ' ')+' '
                          +StrPadLeft('Nilai', 20, ' ')
                          );

                   memo.Lines.Add(StrPadRight('', 120, '-'));
       end;
     end;
    if  i mod abaris <> 0 then
    begin
      for a:=1 to (abaris - (i mod abaris)) do
      begin
        memo.Lines.Add('');
      end;
    end;
    memo.Lines.Add(StrPadRight('', 120, '-'));
    memo.Lines.Add(   StrPadRight('', 60, ' ')+' '
                          +StrPadRight('Total  :', 12, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###.##',anilai), 15, ' ')+ ' '
                          );
    memo.Lines.Add('');
     memo.Lines.Add(      StrPadRight('', 20, ' ')+' '
                          +StrPadRight('DiSiapkan oleh,', 32, ' ')+' '
                          +StrPadRight('Yang Menyerahkan,  ', 32, ' ')
                          +StrPadRight('Penerima ,  ', 30, ' ')

                          );
//


    memo.Lines.Add('');
    memo.Lines.Add('');
    memo.Lines.Add(  StrPadRight('', 21, ' ')
                          +StrPadRight('(               )', 32, ' ')+' '
                          +StrPadRight('(               )', 30, ' ')+' '
                          +StrPadRight('(               )', 30, ' ')
                          );

    memo.Lines.Add('');


  finally
     free;
  end
  end;
  end;
    frmCetak.ShowModal;
END;

procedure TfrmBrowseTTFaktur.cxButton2Click(Sender: TObject);
var
  frmttfaktur: Tfrmttfaktur;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'TT Faktur' then
   begin
      frmttfaktur  := frmmenu.ShowForm(tfrmttfaktur) as Tfrmttfaktur;
      frmttfaktur.edtKode.SetFocus;
//      frmttfaktur.edtnomor.Text := frmttfaktur.getmaxkode;

   end;
   frmttfaktur.Show;
end;
procedure TfrmBrowseTTFaktur.cxButton4Click(Sender: TObject);
var
  s:String;
begin
  inherited;
    try
       if not cekdelete(frmMenu.KDUSER,'frmTTfaktur') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from '+adatabase+'.ttt_hdr '
        + ' where tt_nomor = ' + quot(CDSMaster.FieldByname('nomor').AsString) + ';' ;
        EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
       s:='delete from '+adatabase+'.ttt_dtl '
        + ' where ttd_tt_nomor = ' + quot(CDSMaster.FieldByname('nomor').AsString) + ';' ;
        EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);



      CDSMaster.Delete;
   except
     MessageDlg('Gagal Hapus',mtError, [mbOK],0);
     
     Exit;
   end;
    
end;

procedure TfrmBrowseTTFaktur.cxButton1Click(Sender: TObject);
var
  frmttfakur: TfrmTTFaktur;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'TT Faktur' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmttfakur  := frmmenu.ShowForm(TfrmTTFaktur) as TfrmTTFaktur;
      frmttfakur.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmttfakur.FLAGEDIT := True;
      frmttfakur.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmttfakur.loaddataALL(CDSMaster.FieldByname('Nomor').AsString);
      

   end;
   frmTTFaktur.Show;
end;
end.
