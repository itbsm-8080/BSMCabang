unit ufrmJenisKendaraan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, MyAccess;

type
  TfrmJenisKendaraan = class(TForm)
    AdvPanel1: TAdvPanel;
    Label3: TLabel;
    edtMerk: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    Label1: TLabel;
    edtNopol: TAdvEdit;
    edtTipe: TAdvEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtBagian: TAdvEdit;
    Label6: TLabel;
    edtPic: TAdvEdit;
    Label7: TLabel;
    edtCabang: TAdvEdit;
    procedure refreshdata;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata(akode:string) ;
    procedure simpandata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
//    function getmaxkode:string;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure edtKodeExit(Sender: TObject);

  private
    FFLAGEDIT: Boolean;
    FID: string;


    { Private declarations }
  public
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmJenisKendaraan: TfrmJenisKendaraan;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib, DB;

{$R *.dfm}

procedure TfrmJenisKendaraan.refreshdata;
begin
//  FID:='';
  edtNopol.Clear;
  edtMerk.Clear;
  edtTipe.Clear;
  edtBagian.Clear;
  edtPic.Clear;
  edtCabang.Clear;
  edtNopol.SetFocus;
end;
procedure TfrmJenisKendaraan.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmJenisKendaraan.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmJenisKendaraan.loaddata(akode:string) ;
var
  s: string;
  tsql : TmyQuery;
begin
  s:= 'SELECT kend_nopol, kend_merk, kend_tipe, kend_bagian, kend_pic, kend_cabang FROM tkendaraan where kend_nopol = ' + Quot(akode) ;
tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;
//      edtNopol.Enabled := True;
      edtNopol.Text := fieldbyname('kend_nopol').AsString;
      edtMerk.Text := fieldbyname('kend_merk').AsString;
      edtTipe.Text := fieldbyname('kend_tipe').AsString;
      edtBagian.Text := fieldbyname('kend_bagian').AsString;
      edtPic.Text := fieldbyname('kend_pic').AsString;
      edtCabang.Text := fieldbyname('kend_cabang').AsString;
//      FID :=fieldbyname('kend_nopol').Asstring;
    end
    else
     FLAGEDIT := False;

  finally
    Free;
  end;
end;

end;


procedure TfrmJenisKendaraan.simpandata;
var
  s:string;
begin
if FLAGEDIT then
  s:='update tkendaraan set '
    + ' kend_nopol = ' + Quot(edtNopol.Text) + ','
    + ' kend_merk = ' + Quot(edtMerk.Text) + ','
    + ' kend_tipe = ' + Quot(edtTipe.Text) + ','
    + ' kend_bagian = ' + Quot(edtBagian.Text) + ','
    + ' kend_pic = ' + Quot(edtPic.Text) + ','
    + ' kend_cabang = ' + Quot(edtCabang.Text)
    + ' where kend_nopol = ' + quot(FID) + ';'
else
begin
// edtKode.Text := getmaxkode;
  s :=  ' insert into tkendaraan '
             + ' (kend_nopol, kend_merk, kend_tipe, kend_bagian, kend_pic, kend_cabang) '
             + ' values ( '
             + Quot(edtNopol.Text) + ','
             + Quot(edtMerk.Text) + ','
             + Quot(edtTipe.Text) + ','
             + Quot(edtBagian.Text) + ','
             + Quot(edtPic.Text) + ','
             + Quot(edtCabang.Text)
             + ');';
end;
    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

end;


procedure TfrmJenisKendaraan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

//function TfrmJenisKendaraan.getmaxkode:string;
//var
//  s:string;
//begin
//  s:='select max(jc_kode) from tjeniscustomer';
//  with xOpenQuery(s,frmMenu.conn) do
//  begin
//    try
//      if Fields[0].AsString = '' then
//         result:= '1'
//      else
//         result:= IntToStr(fields[0].AsInteger+1);
//
//    finally
//      free;
//    end;
//  end;
//end;

procedure TfrmJenisKendaraan.cxButton1Click(Sender: TObject);
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

procedure TfrmJenisKendaraan.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmJenisKendaraan.cxButton2Click(Sender: TObject);
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

procedure TfrmJenisKendaraan.edtKodeExit(Sender: TObject);
begin
loaddata(edtNopol.Text);
end;

end.
