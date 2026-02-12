unit ufrmUpload;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons, ExtCtrls,
  AdvPanel, DB, MemDS, DBAccess, MyAccess, ComCtrls,SqlExpr;

type
  TfrmUpload = class(TForm)
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    cxButton1: TcxButton;
    AdvPanel1: TAdvPanel;
    chkstok: TCheckBox;
    chkjual: TCheckBox;
    chkjurnal: TCheckBox;
    MyQuery1: TMyQuery;
    Label1: TLabel;
    dtTanggal: TDateTimePicker;
    chkRetur: TCheckBox;
    chkMutasiOut: TCheckBox;
    chkMutasiin: TCheckBox;
    chkKoreksi: TCheckBox;
    chkMusnah: TCheckBox;
    chkCustomer: TCheckBox;
    chkbayarcus: TCheckBox;
    Label2: TLabel;
    dtTanggalkirim: TDateTimePicker;
    Label3: TLabel;
    dttanggaldata: TDateTimePicker;
    chkbarang: TCheckBox;
    dtTanggal2: TDateTimePicker;
    Label4: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    chkpermintaan: TCheckBox;
    chkJenisCustomer: TCheckBox;

    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function gettanggallog: TDateTime;
    procedure bacafile;
    procedure bacafile2;
    procedure RadioButton1Click(Sender: TObject);
  private
    conn2 : TMyConnection;
    aHost2,aDatabase2,auser2,apassword2 : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUpload: TfrmUpload;

implementation
uses MAIN,Ulib,uModuleConnection;

{$R *.dfm}


procedure TfrmUpload.cxButton1Click(Sender: TObject);
var
 ss,s,anoreferensi:String;
  ttt,tt : TStrings;

  i:integer;
  tsql:TmyQuery;
begin

 s:='update '
  + ' tbiayapromosi_hdr inner join tbiayapromosi_dtl on bph_nomor=bpd_bph_nomor '
  + ' inner join tfp_hdr on fp_cus_kode=bph_cus_kode '
  + ' inner join tfp_dtl on fpd_fp_nomor=fp_nomor and fpd_brg_kode=bpd_brg_kode '
  + ' set fpd_bp_rp=bpd_rupiah,fpd_bp_pr=bpd_persen '
  + ' where month(fp_tanggal)='+FormatDateTime('mm',dtTanggal.DateTime)+' and year(fp_tanggal)='+ FormatDateTime('yyyy',dtTanggal.DateTime);
    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
  

  s:= 'update tfp_hdr b inner join ( '
+ ' select fp_nomor,sum((((100-fpd_discpr)*fpd_harga*(fpd_qty-ifnull(retjd_qty,0))/100)*fpd_bp_pr/100)+fpd_bp_rp*(fpd_qty-ifnull(retjd_qty,0))) nilai from tfp_hdr'
+ ' inner join tfp_dtl on fp_nomor=fpd_fp_nomor'
+ ' LEFT JOIN Tretj_hdr on retj_fp_nomor=fp_nomor '
+ ' left join tretj_dtl on retjd_retj_nomor=retj_nomor and fpd_brg_kode=retjd_brg_kode'
+ ' where month(fp_tanggal)= '+ FormatDateTime('mm',dtTanggal.DateTime)+' and year(fp_tanggal)='+ FormatDateTime('yyyy',dtTanggal.DateTime)
+ ' and (fpd_bp_pr > 0 or fpd_bp_rp > 0) '
+ ' group by fp_nomor) a on a.fp_nomor=b.FP_nomor '
+ ' set fp_biayarp=nilai ' ;

    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  s:='update '
  + ' tfeemarketing_hdr inner join tfeemarketing_dtl on fmh_nomor=fmd_fmh_nomor '
  + ' inner join tfp_hdr on fp_cus_kode=fmh_cus_kode '
  + ' inner join tfp_dtl on fpd_fp_nomor=fp_nomor and fpd_brg_kode=fmd_brg_kode '
  + ' set fpd_bp_rp2=fmd_rupiah,fpd_bp_pr2=fmd_persen '
  + ' where month(fp_tanggal)='+FormatDateTime('mm',dtTanggal.DateTime)+' and year(fp_tanggal)='+ FormatDateTime('yyyy',dtTanggal.DateTime);
    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
  

  s:= 'update tfp_hdr b inner join ( '
+ ' select fp_nomor,sum((((100-fpd_discpr)*fpd_harga*(fpd_qty-ifnull(retjd_qty,0))/100)*fpd_bp_pr2/100)+fpd_bp_rp2*(fpd_qty-ifnull(retjd_qty,0))) nilai from tfp_hdr'
+ ' inner join tfp_dtl on fp_nomor=fpd_fp_nomor'
+ ' LEFT JOIN Tretj_hdr on retj_fp_nomor=fp_nomor '
+ ' left join tretj_dtl on retjd_retj_nomor=retj_nomor and fpd_brg_kode=retjd_brg_kode'
+ ' where month(fp_tanggal)= '+ FormatDateTime('mm',dtTanggal.DateTime)+' and year(fp_tanggal)='+ FormatDateTime('yyyy',dtTanggal.DateTime)
+ ' and (fpd_bp_pr2 > 0 or fpd_bp_rp2 > 0) '
+ ' group by fp_nomor) a on a.fp_nomor=b.FP_nomor '
+ ' set fp_biayarp2=nilai ' ;

    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
  

 // unlocked customer
  s:='update tcustomer set cus_locked=0;';
    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

 // locked customer

s:=' UPDATE tcustomer set cus_locked=1 where cus_kode in ( '
+ ' SELECT DISTINCT CUS_KODE '
+ ' FROM ( '
+ ' SELECT fp_nomor Nomor,fp_tanggal Tanggal,fp_jthtempo JthTempo, fp_Memo Memo, sls_nama Salesman, IF(fp_istax=1,"PPN","Non PPN") Tax,'
+ ' cus_kode,cus_nama Customer, fp_amount Total, (fp_biayapr*(fp_amount-fp_taxamount)/100)+fp_biayarp CN_user, fp_cn Kontrak,fp_DP DP,fp_bayar Bayar,fp_istax, ( '
+ ' SELECT SUM(retj_amount)'
+ ' FROM tretj_hdr '
+ ' WHERE retj_fp_nomor =z.fp_nomor) Retur, (FP_AMOUNT-fp_dp-fp_bayar) Sisa_Piutang, DATEDIFF(curdate(),fp_jthtempo) AS OVERDUE,fp_tipecash '
+ ' FROM tfp_hdr z'
+ ' INNER JOIN tcustomer ON cus_kode=fp_cus_kode'
+ ' LEFT JOIN tdo_hdr ON fp_do_nomor=do_nomor'
+ ' LEFT JOIN tso_hdr ON do_so_nomor=so_nomor'
+ ' LEFT JOIN Tsalesman ON sls_kode=so_sls_kode'
+ ' WHERE (FP_AMOUNT-fp_dp-fp_bayar) > 0'
+ ' GROUP BY fp_nomor,fp_tanggal,fp_memo,cus_nama) a'
+ ' WHERE (sisa_piutang- IFNULL(Retur,0)) > 1 AND tanggal <= curdate()'
+ ' and overdue > 60 and salesman not in  ("INTERNAL","SEWA","KONTRAK"));';
    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

  ttt := TStringList.Create;
  ttt.Append('use '+ frmMenu.aDatabase+';');
 if chkbarang.Checked then
 begin
    tt := TStringList.Create;
    s:='select * from tbarang WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
    +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';
  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin
      ss:='delete from tbarang where brg_kode ='+ Quot(FieldByname('brg_kode').AsString)+';';
      tt.Append(ss);

      ttt.Append(ss);

      ss :=  ' insert ignore into tbarang '
             + ' (brg_kode,brg_nama,brg_satuan,brg_gr_kode,brg_ktg_kode,brg_gdg_DEFAULT,brg_sup_kode ,'
             + ' brg_hrgjual,brg_hrgbeli,brg_isaktif,brg_isstok,brg_isexpired,brg_isproductfocus,date_create,user_create'
             + ' ) '
             + ' values ( '
             + Quot(fieldbyname('brg_kode').AsString) + ','
             + Quot(fieldbyname('brg_nama').AsString) + ','
             + Quot(fieldbyname('brg_satuan').AsString) + ','
             + Quot(fieldbyname('brg_gr_kode').AsString) + ','
             + Quot(fieldbyname('brg_ktg_kode').AsString) + ','
             + Quot(fieldbyname('brg_gdg_default').AsString) + ','
             + Quot(fieldbyname('brg_sup_kode').AsString) + ','
             + FloatToStr(fieldbyname('brg_hrgjual').Asfloat) + ','
             + FloatToStr(fieldbyname('brg_hrgjual').Asfloat) + ',1,1,0,'
             + inttostr(fieldbyname('brg_isproductfocus').asinteger) +','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+');';
         tt.Append(ss);
         ttt.Append(ss);



      Next;
    end;
      tsql.Free;
   end;
         try
        for i:=0 to tt.Count -1 do
        begin
            s:=s;;
         end;
      finally
        tt.Free;
      end;

 end;


    IF chkCustomer.Checked THen
  begin
  tt := TStringList.Create;

  s:='SELECT cus_kode,cus_nama,cus_alamat,cus_kota,cus_fax,cus_telp,cus_cp,cus_email,cus_jc_kode, '
  + ' cus_gc_kode,cus_cabang,date_create,date_modified '
  + '  FROM tcustomer WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
  +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin
      ss:='delete from tcustomer where cus_kode ='+ Quot(FieldByname('cus_kode').AsString)+';';
      tt.Append(ss);
      ttt.Append(ss);


//      xExecQuery(ss,frmMenu.conn);
      ss:='insert ignore into tcustomer (cus_kode,cus_nama,cus_alamat,cus_kota,cus_fax,cus_telp,'
      + ' cus_cp,cus_email,cus_jc_kode ,cus_gc_kode,cus_cabang,date_create,date_modified'
      + ' ) values ('
      + Quot(fieldbyname('cus_kode').AsString) +','+ Quot(fieldbyname('cus_nama').Asstring) +','
      + Quot(fieldbyname('cus_alamat').AsString) +','+ quot(fieldbyname('cus_kota').Asstring) +','
      + quot(fieldbyname('cus_fax').Asstring) +','+ quot(fieldbyname('cus_telp').Asstring)+ ','
      + quot(fieldbyname('cus_cp').Asstring) +','
      + quot(fieldbyname('cus_email').Asstring) +','+ quot(fieldbyname('cus_jc_kode').Asstring)+ ','
      + quot(fieldbyname('cus_gc_kode').Asstring) +','+ quot(fieldbyname('cus_cabang').Asstring)+','
      + QuotD(fieldbyname('date_create').AsDateTime)+','+QuotD(fieldbyname('date_modified').AsDateTime)
      +');';
//      xExecQuery(ss,frmMenu.conn2);
     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;
         try
        for i:=0 to tt.Count -1 do
        begin
            s:=s;;
         end;
      finally
        tt.Free;
      end;
  end;


  IF chkJenisCustomer.Checked THen
  begin
  tt := TStringList.Create;

  s:='SELECT jc_kode,jc_nama '
  + '  FROM tjeniscustomer ';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
      ss:='delete from tjeniscustomer;';
      tt.Append(ss);
      ttt.Append(ss);

    while not eof do
    begin


//      xExecQuery(ss,frmMenu.conn);
      ss:='insert ignore into tjeniscustomer (jc_kode,jc_nama'
      + ' ) values ('
      + Quot(fieldbyname('jc_kode').AsString) +','+ Quot(fieldbyname('jc_nama').Asstring)
      +');';
//      xExecQuery(ss,frmMenu.conn2);
     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;
         try
        for i:=0 to tt.Count -1 do
        begin
            s:=s;;
         end;
      finally
        tt.Free;
      end;
  end;
;



  IF chkbayarcus.Checked THen
  begin
  tt := TStringList.Create;

  s:='SELECT * FROM tbayarcus_hdr WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
  +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin
      ss:='delete from tbayarcus_hdr  where byc_nomor ='+ Quot(FieldByname('byc_nomor').AsString)+';';
      tt.Append(ss);
      ttt.Append(ss);



      ss:='insert ignore into tbayarcus_hdr ('
      + ' byc_nomor,byc_tanggal,byc_cus_kode,byc_memo,byc_cash,byc_rek_cash,byc_transfer,byc_rek_transfer,'
      + ' byc_giro,byc_rek_giro,byc_nogiro,byc_tglcair,byc_potongan,byc_rek_potongan,'
      + ' byc_istax,byc_ppn,byc_pph,'
      + ' byc_rek_pph,byc_rek_ppn,byc_NTPN,date_create,date_modified'
      + ' ) values ('
      + Quot(fieldbyname('byc_nomor').AsString) +','+ Quotd(fieldbyname('byc_tanggal').AsDateTime) +','
      + Quot(fieldbyname('byc_cus_kode').AsString) +','+ quot(fieldbyname('byc_memo').Asstring) +','
      + FloatToStr(fieldbyname('byc_cash').AsFloat) +','+ quot(fieldbyname('byc_rek_cash').Asstring) +','
      + FloatToStr(fieldbyname('byc_transfer').AsFloat) +','+ quot(fieldbyname('byc_rek_transfer').Asstring) +','
      + FloatToStr(fieldbyname('byc_giro').AsFloat) +','+ quot(fieldbyname('byc_rek_giro').Asstring) +','
      + quot(fieldbyname('byc_nogiro').Asstring) +','+ Quotd(fieldbyname('byc_tglcair').AsDateTime) +','
      + FloatToStr(fieldbyname('byc_potongan').AsFloat) +','+ quot(fieldbyname('byc_rek_potongan').Asstring) +','
      + inttostr(fieldbyname('byc_istax').AsInteger) +','+ FloatToStr(fieldbyname('byc_ppn').AsFloat) +','
      + FloatToStr(fieldbyname('byc_pph').AsFloat) +','+ quot(fieldbyname('byc_rek_pph').Asstring) +','
      + quot(fieldbyname('byc_rek_ppn').Asstring) +','+ quot(fieldbyname('byc_NTPN').AsString)+','
      + quotd(fieldbyname('date_create').asdatetime)+','+quotd(fieldbyname('date_modified').AsDateTime)
       +');';
//      xExecQuery(ss,frmMenu.conn2);
     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;
    s:='SELECT bycd_byc_nomor,bycd_fp_nomor,bycd_bayar,bycd_keterangan'
      + ' FROM tbayarcus_dtl inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor'
      + ' WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
      +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin

      ss:='insert ignore into tbayarcus_dtl (bycd_byc_nomor,bycd_fp_nomor,bycd_bayar,bycd_keterangan'
      + ' ) values ('
      + Quot(Fields[0].AsString) +','
      + Quot(Fields[1].Asstring) +','
      + FloatToStr(Fields[2].AsFloat) +','
      + quot(Fields[3].AsString) +');';

     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;
//   tt.SaveToFile('d:\tt.txt');
         try
        for i:=0 to tt.Count -1 do
        begin
            s:=s;;
         end;
      finally
        tt.Free;
      end;
  end;


  IF chkMutasiOut.Checked THen
  begin
  tt := TStringList.Create;

  s:='SELECT * FROM tmutcab_hdr WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
  +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin
      ss:='delete from tmutcab_hdr  where mutc_nomor ='+ Quot(FieldByname('mutc_nomor').AsString)+';';
      tt.Append(ss);
      ttt.Append(ss);

      ss:='delete from tmutcab_dtl  where mutcd_mutc_nomor ='+ Quot(FieldByname('mutc_nomor').AsString)+';';
      tt.Append(ss);
      ttt.Append(ss);


//      xExecQuery(ss,frmMenu.conn);
      ss:='insert ignore into tmutcab_hdr (mutc_nomor,mutc_tanggal,mutc_gdg_kode,mutc_cbg_asal,'
      + ' mutc_cbg_tujuan,mutc_keterangan,mutc_status,date_create,date_modified'
      + ' ) values ('
      + Quot(fieldbyname('mutc_nomor').AsString) +','+ Quotd(fieldbyname('mutc_tanggal').AsDateTime) +','
      + Quot(fieldbyname('mutc_gdg_kode').AsString) +','+ quot(fieldbyname('mutc_cbg_asal').Asstring) +','
      + quot(fieldbyname('mutc_cbg_tujuan').Asstring) +','+ quot(fieldbyname('mutc_keterangan').Asstring) +','
      + intToStr(Fieldbyname('mutc_status').AsInteger)+','+quotd(fieldbyname('date_create').AsDateTime)+','
      + quotd(fieldbyname('date_modified').AsDateTime)
      +');';
//      xExecQuery(ss,frmMenu.conn2);
      tt.Append(ss);
      ttt.append(ss);
      Next;
    end;
      tsql.Free;
   end;
    s:='SELECT mutcd_mutc_nomor,mutcd_brg_kode,mutcd_qty,mutcd_expired,mutcd_keterangan,mutcd_nourut,mutcd_harga,mutcd_gdg_kode'
      + ' FROM tmutcab_dtl inner join tmutcab_hdr on mutc_nomor=mutcd_mutc_nomor'
      + ' WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
      +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin

      ss:='insert ignore into tmutcab_dtl ('
      + ' mutcd_mutc_nomor,mutcd_brg_kode,mutcd_qty,mutcd_expired,mutcd_keterangan,'
      + ' mutcd_nourut,mutcd_harga,mutcd_gdg_kode'
      + ' ) values ('
      + Quot(Fields[0].AsString) +','
      + Quot(Fields[1].Asstring) +','
      + FloatToStr(Fields[2].AsFloat) +','
      + quotd(Fields[3].AsDateTime) +','
      + quot(Fields[4].AsString) +','
      + intToStr(Fields[5].AsInteger) +','
      + FloatToStr(Fields[6].AsFloat) +','
      + quot(Fields[7].AsString) +');';

     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;
         try
        for i:=0 to tt.Count -1 do
        begin
            s:=s;;
         end;
      finally
        tt.Free;
      end;
  end;



  IF chkMutasiin.Checked THen
  begin
  tt := TStringList.Create;

  s:='SELECT * FROM tmutcabin_hdr WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
  +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin
      ss:='delete from tmutcabin_hdr  where mutci_nomor ='+ Quot(FieldByname('mutci_nomor').AsString)+';';
      tt.Append(ss);
      ttt.Append(ss);

      ss:='delete from tmutcabin_dtl  where mutcid_mutci_nomor ='+ Quot(FieldByname('mutci_nomor').AsString)+';';
      tt.Append(ss);
      ttt.Append(ss);


//      xExecQuery(ss,frmMenu.conn);
      ss:='insert ignore into tmutcabin_hdr (mutci_nomor,mutci_tanggal,mutci_gdg_kode,mutci_cbg_asal,'
      + ' mutci_cbg_tujuan,mutci_nomormutasi,date_create,date_modified'
      + ' ) values ('
      + Quot(fieldbyname('mutci_nomor').AsString) +','+ Quotd(fieldbyname('mutci_tanggal').AsDateTime) +','
      + Quot(fieldbyname('mutci_gdg_kode').AsString) +','+ quot(fieldbyname('mutci_cbg_asal').Asstring) +','
      + quot(fieldbyname('mutci_cbg_tujuan').Asstring) +','+ quot(fieldbyname('mutci_nomormutasi').Asstring) +','
      + QuotD(fieldbyname('date_create').AsDateTime)+','+QuotD(fieldbyname('date_modified').AsDateTime)
      +');';
//      xExecQuery(ss,frmMenu.conn2);
     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;
    s:='SELECT mutcid_mutci_nomor,mutcid_brg_kode,mutcid_qty,mutcid_expired,mutcid_keterangan,mutcid_nourut,mutcid_harga'
      + ' FROM tmutcabin_dtl inner join tmutcabin_hdr on mutci_nomor=mutcid_mutci_nomor'
      + ' WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
      +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin

      ss:='insert ignore into tmutcabin_dtl ('
      + ' mutcid_mutci_nomor,mutcid_brg_kode,mutcid_qty,mutcid_expired,'
      + ' mutcid_keterangan,mutcid_nourut,mutcid_harga'
      + ' ) values ('
      + Quot(Fields[0].AsString) +','
      + Quot(Fields[1].Asstring) +','
      + FloatToStr(Fields[2].AsFloat) +','
      + quotd(Fields[3].AsDateTime) +','
      + quot(Fields[4].AsString) +','
      + intToStr(Fields[5].AsInteger) +','
      + FloatToStr(Fields[6].AsFloat)  +');';

     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;
         try
        for i:=0 to tt.Count -1 do
        begin
            s:=s;;
         end;
      finally
        tt.Free;
      end;
  end;



    IF chkKoreksi.Checked THen
  begin
  tt := TStringList.Create;

  s:='SELECT * FROM tkor_hdr WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
  +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin
      ss:='delete from tkor_hdr  where korh_nomor ='+ Quot(FieldByname('korh_nomor').AsString)+';';
      tt.Append(ss);
      ttt.Append(ss);

      ss:='delete from tkor_dtl  where kord_korh_nomor ='+ Quot(FieldByname('korh_nomor').AsString)+';';
      tt.Append(ss);
      ttt.Append(ss);


//      xExecQuery(ss,frmMenu.conn);
      ss:='insert ignore into tkor_hdr (korh_nomor,korh_tanggal,korh_notes,korh_total,korh_gdg_kode,date_create,date_modified'
      + ' ) values ('
      + Quot(fieldbyname('korh_nomor').AsString) +','+ Quotd(fieldbyname('korh_tanggal').AsDateTime) +','
      + Quot(fieldbyname('korh_notes').AsString) +','+ floattostr(fieldbyname('korh_total').AsFloat) +','
      + quot(fieldbyname('korh_gdg_kode').Asstring)  +','
      + QuotD(fieldbyname('date_create').AsDateTime)+','+QuotD(fieldbyname('date_modified').AsDateTime)
      +');';
//      xExecQuery(ss,frmMenu.conn2);
     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;
    s:='SELECT kord_korh_nomor,kord_brg_kode,kord_expired,kord_qty,kord_harga,kord_nilai,kord_satuan,kord_stok,kord_nourut'
      + ' FROM tkor_dtl inner join tkor_hdr on korh_nomor=kord_korH_nomor'
      + ' WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
      +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin

      ss:='insert ignore into tkor_dtl ('
      + ' kord_korh_nomor,kord_brg_kode,kord_expired,kord_qty,'
      + ' kord_harga,kord_nilai,kord_satuan,kord_stok,kord_nourut'
      + ' ) values ('
      + Quot(Fields[0].AsString) +','
      + Quot(Fields[1].Asstring) +','
      + quotd(Fields[2].AsDateTime) +','
      + FloatToStr(Fields[3].AsFloat) +','
      + FloatToStr(Fields[4].AsFloat) +','
      + FloatToStr(Fields[5].AsFloat) +','
      + quot(Fields[6].AsString) +','
      + FloatToStr(Fields[7].AsFloat) +','
      + intToStr(Fields[8].AsInteger)  +');';

     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;
         try
        for i:=0 to tt.Count -1 do
        begin
            s:=s;;
         end;
      finally
        tt.Free;
      end;
  end;
    //xCommit(conn2);


  IF chkjual.Checked THen
  begin
  tt := TStringList.Create;

  s:='SELECT * FROM tso_hdr WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
  +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin
      ss:='delete from tso_hdr  where so_nomor ='+ Quot(FieldByname('so_nomor').AsString)+';';
      tt.Append(ss);
      ttt.Append(ss);

      ss:='delete from tso_dtl  where sod_so_nomor ='+ Quot(FieldByname('so_nomor').AsString)+';';
      tt.Append(ss);
      ttt.Append(ss);


//      xExecQuery(ss,frmMenu.conn);
      ss:='insert ignore into tso_hdr (so_nomor,so_tanggal,so_memo,so_cus_kode,'
      + ' so_sls_kode,so_disc_faktur,so_disc_fakturpr,so_amount,so_taxamount,'
      + ' so_dp,so_iskirim,so_isclosed,so_istax,so_rek_dp,so_isproforma,date_create,date_modified'
      + ' ) values ('
      + Quot(fieldbyname('so_nomor').AsString) +','+ Quotd(fieldbyname('so_tanggal').AsDateTime) +','
      + Quot(fieldbyname('so_memo').AsString) +','+ quot(fieldbyname('so_cus_kode').Asstring) +','
      + quot(fieldbyname('so_sls_kode').Asstring) +','+ FloatToStr(fieldbyname('so_disc_faktur').AsFloat) +','
      + FloatToStr(fieldbyname('so_disc_fakturpr').AsFloat) +','+ FloatToStr(fieldbyname('so_amount').AsFloat) +','
      + FloatToStr(fieldbyname('so_taxamount').AsFloat) +','+ FloatToStr(fieldbyname('so_dp').AsFloat) +','
      + intToStr(Fieldbyname('so_iskirim').AsInteger) +','+ intToStr(Fieldbyname('so_isclosed').AsInteger) +','
      + intToStr(Fieldbyname('so_istax').AsInteger) +','+quot(fieldbyname('so_rek_dp').Asstring) +','
      + inttostr(fieldbyname('so_isproforma').AsInteger)+','
      + QuotD(fieldbyname('date_create').AsDateTime)+','+QuotD(fieldbyname('date_modified').AsDateTime)
      +');';
//      xExecQuery(ss,frmMenu.conn2);
     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;
    s:='SELECT sod_so_nomor,sod_brg_kode,sod_brg_satuan,sod_qty,sod_qty_kirim,sod_discpr,'
      + ' sod_harga,sod_iskirim,sod_isclosed,sod_nourut,sod_keterangan'
      + ' FROM tso_dtl inner join tso_hdr on so_nomor=sod_so_nomor'
      + ' WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
      +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin

      ss:='insert ignore into tso_dtl (sod_so_nomor,sod_brg_kode,sod_brg_satuan,'
      + ' sod_qty,sod_qty_kirim,sod_discpr,'
      + ' sod_harga,sod_iskirim,sod_isclosed,sod_nourut,sod_keterangan'
      + ' ) values ('
      + Quot(Fields[0].AsString) +','
      + Quot(Fields[1].Asstring) +','
      + Quot(Fields[2].AsString) +','
      + FloatToStr(Fields[3].AsFloat) +','
      + FloatToStr(Fields[4].AsFloat) +','
      + FloatToStr(Fields[5].AsFloat) +','
      + FloatToStr(Fields[6].AsFloat) +','
      + intToStr(Fields[7].Asinteger) +','
      + intToStr(Fields[8].Asinteger) +','
      + FloatToStr(Fields[9].AsFloat) +','
      + quot(Fields[10].AsString) +');';

     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;

  s:='SELECT * FROM tdo_hdr WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
  +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin
      ss:='delete from tdo_hdr  where do_nomor ='+ Quot(FieldByname('do_nomor').AsString)+';';
      tt.Append(ss);
      ttt.Append(ss);

      ss:='delete from tdo_dtl  where dod_do_nomor ='+ Quot(FieldByname('do_nomor').AsString)+';';
      tt.Append(ss);
      ttt.Append(ss);


//      xExecQuery(ss,frmMenu.conn);
      ss:='insert ignore into tdo_hdr (do_nomor,do_tanggal,do_so_nomor,do_cus_kode,'
      + ' do_shipaddress,do_memo,do_gdg_kode,do_isinvoice,do_isclosed,do_iskembali ,date_create,date_modified '
      + ' ) values ('
      + Quot(fieldbyname('do_nomor').AsString) +','+ Quotd(fieldbyname('do_tanggal').AsDateTime) +','
      + Quot(fieldbyname('do_so_nomor').AsString) +','+ quot(fieldbyname('do_cus_kode').Asstring) +','
      + quot(fieldbyname('do_shipaddress').Asstring) +','+ quot(fieldbyname('do_memo').Asstring) +','
      + quot(fieldbyname('do_gdg_kode').Asstring) +','
      + intToStr(Fieldbyname('do_isinvoice').AsInteger) +','+ intToStr(Fieldbyname('do_isclosed').AsInteger) +','
      + intToStr(Fieldbyname('do_iskembali').AsInteger) +','
      + QuotD(fieldbyname('date_create').AsDateTime)+','+QuotD(fieldbyname('date_modified').AsDateTime)
      +');';
//      xExecQuery(ss,frmMenu.conn2);
     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;
    s:='SELECT dod_do_nomor,dod_brg_kode,dod_brg_satuan,dod_qty,dod_tgl_expired,dod_nourut,'
      + ' dod_status,dod_qty_invoice,dod_isclosed,dod_gdg_kode '
      + ' FROM tdo_dtl inner join tdo_hdr on do_nomor=dod_do_nomor'
      + ' WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
      +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin

      ss:='insert ignore into tdo_dtl (dod_do_nomor,dod_brg_kode,dod_brg_satuan,'
      + ' dod_qty,dod_tgl_expired,dod_nourut,'
      + ' dod_status,dod_qty_invoice,dod_isclosed,dod_gdg_kode '
      + ' ) values ('
      + Quot(Fields[0].AsString) +','
      + Quot(Fields[1].Asstring) +','
      + Quot(Fields[2].AsString) +','
      + FloatToStr(Fields[3].AsFloat) +','
      + quotd(Fields[4].AsDateTime) +','
      + FloatToStr(Fields[5].AsFloat) +','
      + intToStr(Fields[6].Asinteger) +','
      + FloatToStr(Fields[7].AsFloat) +','
      + intToStr(Fields[8].Asinteger) +','
      + quot(Fields[9].AsString) +');';

     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;

  s:='SELECT * FROM tfp_hdr WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
  +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin
      ss:='delete from tfp_hdr  where fp_nomor ='+ Quot(FieldByname('fp_nomor').AsString)+';';
      tt.Append(ss);
      ttt.Append(ss);

      ss:='delete from tfp_dtl  where fpd_fp_nomor ='+ Quot(FieldByname('fp_nomor').AsString)+';';
      tt.Append(ss);
      ttt.Append(ss);


//      xExecQuery(ss,frmMenu.conn);
      ss:='insert ignore into tfp_hdr (fp_nomor,fp_tanggal,fp_do_nomor,fp_cus_kode,'
      + ' fp_jthtempo,fp_memo,fp_istax,fp_disc_fakturpr,fp_disc_faktur,fp_disc_item,fp_amount, '
      + ' fp_taxamount,fp_dp,fp_bayar,fp_isbayar,fp_cn,fp_freight,fp_biayarp,fp_biayapr,fp_iskembali,'
      + ' fp_status_faktur,fp_iscetak,fp_tipecash,fp_isdtp,date_create,date_modified '
      + ' ) values ('
      + Quot(fieldbyname('fp_nomor').AsString) +','+ Quotd(fieldbyname('fp_tanggal').AsDateTime) +','
      + Quot(fieldbyname('fp_do_nomor').AsString) +','+ quot(fieldbyname('fp_cus_kode').Asstring) +','
      + Quotd(fieldbyname('fp_jthtempo').AsDateTime) +','+ quot(fieldbyname('fp_memo').Asstring) +','
      + intToStr(Fieldbyname('fp_istax').AsInteger) +','+ floatToStr(Fieldbyname('fp_disc_fakturpr').Asfloat) +','
      + floatToStr(Fieldbyname('fp_disc_faktur').Asfloat) +','+ floatToStr(Fieldbyname('fp_disc_item').Asfloat) +','
      + floatToStr(Fieldbyname('fp_amount').Asfloat) +','+ floatToStr(Fieldbyname('fp_taxamount').Asfloat) +','
      + floatToStr(Fieldbyname('fp_dp').Asfloat) +','+ floatToStr(Fieldbyname('fp_bayar').Asfloat) +','
      + intToStr(Fieldbyname('fp_isbayar').AsInteger) +','+ floatToStr(Fieldbyname('fp_cn').Asfloat) +','
      + floatToStr(Fieldbyname('fp_freight').Asfloat) +','+ floatToStr(Fieldbyname('fp_biayarp').Asfloat) +','
      + floatToStr(Fieldbyname('fp_biayapr').Asfloat) +','
      + intToStr(Fieldbyname('fp_iskembali').AsInteger)+','
      + Quot(fieldbyname('fp_status_faktur').AsString) +','+ intToStr(Fieldbyname('fp_iscetak').Asinteger) +','
      + intToStr(Fieldbyname('fp_tipecash').Asinteger) +','
      + intToStr(Fieldbyname('fp_isdtp').Asinteger)+','
      + QuotD(fieldbyname('date_create').AsDateTime)+','+QuotD(fieldbyname('date_modified').AsDateTime)
      +');';
//      xExecQuery(ss,frmMenu.conn2);
     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;
    s:='SELECT fpd_fp_nomor,fpd_brg_kode,fpd_brg_satuan,fpd_qty,fpd_harga,fpd_discpr,fpd_nourut, '
      + ' fpd_expired,fpd_cn,fpd_gdg_kode,fpd_bp_rp,fpd_bp_pr,fpd_hrg_min,fpd_idbatch '
      + ' FROM tfp_dtl inner join tfp_hdr on fp_nomor=fpd_fp_nomor'
      + ' WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
      +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin

      ss:='insert ignore into tfp_dtl (fpd_fp_nomor,fpd_brg_kode,fpd_brg_satuan,'
      + ' fpd_qty,fpd_harga,fpd_discpr,fpd_nourut, '
      + ' fpd_expired,fpd_cn,fpd_gdg_kode,fpd_bp_rp,fpd_bp_pr,fpd_hrg_min,fpd_idbatch '
      + ' ) values ('
      + Quot(Fields[0].AsString) +','
      + Quot(Fields[1].Asstring) +','
      + Quot(Fields[2].AsString) +','
      + FloatToStr(Fields[3].AsFloat) +','
      + FloatToStr(Fields[4].AsFloat) +','
      + FloatToStr(Fields[5].AsFloat) +','
      + inttostr(Fields[6].AsInteger) +','
      + quotd(Fields[7].AsDateTime) +','
      + FloatToStr(Fields[8].AsFloat) +','
      + quot(Fields[9].AsString) +','

      + FloatToStr(Fields[10].AsFloat) +','
      + FloatToStr(Fields[11].AsFloat) +','
      + FloatToStr(Fields[12].Asfloat) + ','
      + Quot(Fields[13].AsString)
      +');';

     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;

       try
        for i:=0 to tt.Count -1 do
        begin
            s:=s;;
         end;
      finally
        tt.Free;
      end;
  end;
   // xCommit(conn2);

  IF chkRetur.Checked THen
  begin
  tt := TStringList.Create;

  s:='SELECT * FROM tretj_hdr WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
  +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin
      ss:='delete from tretj_hdr  where retj_nomor ='+ Quot(FieldByname('retj_nomor').AsString)+';';
      EnsureConnected(conn2);
      ExecSQLDirect(conn2, ss);

      ss:='delete from tretj_dtl  where retjd_retj_nomor ='+ Quot(FieldByname('retj_nomor').AsString)+';';
      EnsureConnected(conn2);
      ExecSQLDirect(conn2, ss);

//      xExecQuery(ss,frmMenu.conn);
      ss:='insert ignore into tretj_hdr (retj_nomor,retj_tanggal,retj_memo,retj_cus_kode,retj_gdg_kode,retj_fp_nomor,'
      + ' retj_istax,retj_disc_faktur,retj_disc_fakturpr,retj_amount,retj_taxamount,'
      + ' retj_cn,date_create,date_modified'
      + ' ) values ('
      + Quot(fieldbyname('retj_nomor').AsString) +','+ Quotd(fieldbyname('retj_tanggal').AsDateTime) +','
      + Quot(fieldbyname('retj_memo').AsString) +','+ quot(fieldbyname('retj_cus_kode').Asstring) +','
      + quot(fieldbyname('retj_gdg_kode').Asstring) +','+ quot(fieldbyname('retj_fp_nomor').Asstring) +','
      + intToStr(Fieldbyname('retj_istax').AsInteger) +','
      + FloatToStr(fieldbyname('retj_disc_faktur').AsFloat) +','
      + FloatToStr(fieldbyname('retj_disc_fakturpr').AsFloat) +','+ FloatToStr(fieldbyname('retj_amount').AsFloat) +','
      + FloatToStr(fieldbyname('retj_taxamount').AsFloat) +','+ FloatToStr(fieldbyname('retj_cn').AsFloat)+','
      + QuotD(fieldbyname('date_create').AsDateTime)+','+QuotD(fieldbyname('date_modified').AsDateTime)
      +');';
//      xExecQuery(ss,frmMenu.conn2);
      EnsureConnected(conn2);
      ExecSQLDirect(conn2, ss);
      Next;
    end;
      tsql.Free;
   end;

    s:='SELECT retjd_retj_nomor,retjd_brg_kode,retjd_brg_satuan,retjd_qty,retjd_harga,retjd_discpr,'
      + ' retjd_nourut,retjd_expired'
      + ' FROM tretj_dtl inner join tretj_hdr on retj_nomor=retjd_retj_nomor'
      + ' WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
      +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin

      ss:='insert ignore into tretj_dtl (retjd_retj_nomor,retjd_brg_kode,retjd_brg_satuan,'
      + ' retjd_qty,retjd_harga,retjd_discpr,'
      + ' retjd_nourut,retjd_expired'
      + ' ) values ('
      + Quot(Fields[0].AsString) +','
      + Quot(Fields[1].Asstring) +','
      + Quot(Fields[2].AsString) +','
      + FloatToStr(Fields[3].AsFloat) +','
      + FloatToStr(Fields[4].AsFloat) +','
      + FloatToStr(Fields[5].AsFloat) +','
      + FloatToStr(Fields[6].AsFloat) +','
      + quotd(Fields[7].AsDateTime) +');';

     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;
         try
        for i:=0 to tt.Count -1 do
        begin
            s:=s;;
         end;
      finally
        tt.Free;
      end;
  end;
    //xCommit(conn2);


  IF chkstok.Checked THen
  begin
    tt := TStringList.Create;
    s:='SELECT mst_brg_kode,mst_gdg_kode,mst_stok_in,mst_stok_out,mst_noreferensi,'
    + ' mst_hargabeli,mst_tanggal,date_create from tmasterstok where '
    + ' (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
      anoreferensi:='';
      while not eof do
      begin
        if anoreferensi <> Fields[4].AsString then
        begin
          ss:='delete from tmasterstok where mst_noreferensi='+Quot(Fields[4].AsString)
              +';';
          tt.Append(ss);
          ttt.Append(ss);

        end;

        ss:='insert ignore into tmasterstok ('
          + ' mst_brg_kode,mst_gdg_kode,mst_stok_in,mst_stok_out,mst_noreferensi,'
          + ' mst_hargabeli,mst_tanggal,date_create) values ('
          + Quot(Fields[0].AsString)+ ','
          + Quot(Fields[1].AsString)+ ','
          + floattostr(Fields[2].AsFloat)+ ','
          + floattostr(Fields[3].AsFloat)+ ','
          + Quot(Fields[4].AsString)+ ','
          + floattostr(Fields[5].AsFloat)+ ','
          + QuotD(Fields[6].AsDateTime) +','
          + QuotD(fieldbyname('date_create').AsDateTime)
          + ');';
       tt.Append(ss);
       ttt.Append(ss);




        Next;
        anoreferensi := Fields[4].AsString;
      end;
      tsql.Free;
    end;
       try
        for i:=0 to tt.Count -1 do
        begin
            s:=s;;
         end;
      finally
        tt.Free;
      end;
  end;
    //xCommit(conn2);

    IF chkjurnal.Checked THen
  begin
  tt := TStringList.Create;

  s:='SELECT jur_tanggal,jur_tipetransaksi,jur_no,jur_keterangan,jur_isclosed,date_create,date_modified FROM tjurnal WHERE '
  + ' (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
  + ' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')'
  + ' OR (jur_tanggal= '+quotd(dtTanggal.DateTime)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin
      ss:='delete from tjurnal  where jur_no ='+ Quot(Fields[2].AsString)+';';
      tt.Append(ss);
      ttt.Append(ss);

      ss:='delete from tjurnalitem  where jurd_jur_no ='+ Quot(Fields[2].AsString)+';';
      tt.Append(ss);
      ttt.Append(ss);


//      xExecQuery(ss,frmMenu.conn);
      ss:='insert ignore into tjurnal (jur_tanggal,jur_tipetransaksi,jur_no,jur_keterangan,jur_isclosed,date_create,date_modified '
      + ' ) values ('
      + Quotd(Fields[0].AsDateTime) +','
      + Quot(Fields[1].AsString) +','
      + Quot(Fields[2].AsString) +','
      + Quot(Fields[3].AsString) +','
      + intToStr(Fields[4].AsInteger)+','
      + QuotD(Fields[5].Asdatetime)+','
      + QuotD(Fields[6].Asdatetime)
      +');';
//      xExecQuery(ss,frmMenu.conn2);
     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;
    s:='SELECT jurd_jur_no,jurd_rek_kode,jurd_debet,jurd_kredit,jurd_nourut, jurd_cc_kode,jurd_keterangan,jurd_nopol,jurd_cus_kode,jurd_ekspedisi'
      + ' FROM tjurnalitem inner join tjurnal on jurd_jur_no =jur_no'
      + ' WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
      + ' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')'
      + ' OR (jur_tanggal= '+quotd(dtTanggal.DateTime)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin

      ss:='insert ignore into tjurnalitem ('
      + ' jurd_jur_no,jurd_rek_kode,jurd_debet,jurd_kredit,jurd_nourut,jurd_keterangan,jurd_cc_kode,jurd_nopol,jurd_cus_kode,jurd_ekspedisi'
      + ' ) values ('
      + Quot(Fields[0].AsString) +','
      + Quot(Fields[1].Asstring) +','
      + FloatToStr(Fields[2].AsFloat) +','
      + FloatToStr(Fields[3].AsFloat) +','
      + FloatToStr(Fields[4].AsFloat) +','
      + Quot(Fields[6].Asstring) +','
      + Quot(Fields[5].Asstring) +','
      + Quot(Fields[7].Asstring) +','
      + Quot(Fields[8].Asstring) +','
      + Quot(Fields[9].Asstring)
      +');';

     tt.append(ss);
     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;



       try
        for i:=0 to tt.Count -1 do
        begin
            s:=s;;
         end;
      finally
        tt.Free;
      end;
  end;

  //xCommit(conn2);

  IF chkbayarcus.Checked THen
  begin
  tt := TStringList.Create;

  s:='SELECT * FROM tpermintaanbarang_hdr WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
  +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin
      ss:='delete from bsm.tpermintaanbarang_hdr  where pb_nomor ='+ Quot(FieldByname('pb_nomor').AsString)+';';

      ttt.Append(ss);



      ss:='insert ignore into bsm.tpermintaanbarang_hdr ('
      + ' pb_nomor,pb_tanggal,pb_memo,date_create,date_modified,user_create,user_modified'
      + ' ) values ('
      + Quot(fieldbyname('pb_nomor').AsString) +','+ Quotd(fieldbyname('pb_tanggal').AsDateTime) +','
      + quot(fieldbyname('pb_memo').Asstring) +','
      + quotd(fieldbyname('date_create').AsDateTime) +','+ quotd(fieldbyname('date_modified').AsDateTime)+','
      + quot(fieldbyname('user_create').Asstring) +','+quot(fieldbyname('user_modified').Asstring)
       +');';
//      xExecQuery(ss,frmMenu.conn2);

     ttt.Append(ss);

      Next;
    end;
      tsql.Free;
   end;
    s:='SELECT * '
      + ' FROM tpermintaanbarang_dtl inner join tpermintaanbarang_hdr on pb_nomor=pbd_pb_nomor'
      + ' WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal2.DateTime+1)+')'
      +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal2.DateTime+1)+')';

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
//   tt.SaveToFile('d:\tt.txt');
  end;
//    xCommit(conn2);
  ttt.Append('use bsm;');
  s:='insert into tlogkirim (tanggal,tanggaldata) values ('+ QuotD(cGetServerTime,true)
  +','+QuotD(dtTanggal.Date)+');';

   try
       ttt.SaveToFile(cGetReportPath+'KirimData_'+frmmenu.NMCABANG+FormatDateTime('yyymmdd',date)+'.sql');

      finally
        ttt.Free;
      end;
    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
  
  showmessage('file terbentuk di '+cGetReportPath+'KirimData_'+frmmenu.NMCABANG+FormatDateTime('yyymmdd',date)+'.sql');
end;

procedure TfrmUpload.cxButton8Click(Sender: TObject);
begin
release;
end;

procedure TfrmUpload.FormShow(Sender: TObject);
var
  s:String;
  tsql:TmyQuery;
begin
dtTanggal.datetime :=gettanggallog ;
dtTanggal2.datetime :=gettanggallog ;

bacafile;
 conn2 := xCreateConnection(ctMySQL,aHost2,aDatabase2,auser2,apassword2);

 s:='select * from tlogkirim order by tanggal desc limit 1' ;
 tsql := xOpenQuery(s,frmmenu.conn);

 with tsql do
 begin
   try
      dttanggalkirim.date := fields[0].asdatetime;
      dttanggaldata.date :=  fields[1].asdatetime;
   finally
     free;
   end;
 end;

end;

function TfrmUpload.gettanggallog: TDateTime;
var
    S: string;
begin
    S := 'Select now()';
    with xOpenQuery(S,frmMenu.conn) do
    begin
         Result := fields[0].AsDateTime;
         free;
    end;

end;

procedure TfrmUpload.bacafile;
var
s:string;
tsql:TmyQuery;

 begin
   s:='select ahost,adatabase,auser,apassword from tsetingdb where nama like '+Quot('default5') +';';
   tsql:=xOpenQuery(s,frmmenu.conn);
  with tsql do
  begin
    try
       aHost2     := fields[0].AsString;
       aDatabase2 := fields[1].AsString;
       auser2     := fields[2].AsString;
       apassword2 := fields[3].AsString;

    finally
      free;
    end;
  end;

 end;

procedure TfrmUpload.bacafile2;
var
s:string;
tsql:TmyQuery;

 begin
   s:='select ahost,adatabase,auser,apassword from tsetingdb where nama like '+Quot('default6') +';';
   tsql:=xOpenQuery(s,frmmenu.conn);
  with tsql do
  begin
    try
       aHost2     := fields[0].AsString;
       aDatabase2 := fields[1].AsString;
       auser2     := fields[2].AsString;
       apassword2 := fields[3].AsString;

    finally
      free;
    end;
  end;

 end;



procedure TfrmUpload.RadioButton1Click(Sender: TObject);
begin
IF RadioButton1.Checked then
   bacafile
else if RadioButton2.Checked then
   bacafile2;

conn2 := xCreateConnection(ctMySQL,aHost2,aDatabase2,auser2,apassword2);   
end;

end.
