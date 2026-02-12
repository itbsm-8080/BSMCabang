unit ufrmEkspedisi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, MyAccess;

type
  TfrmEkspedisi = class(TForm)
    AdvPanel1: TAdvPanel;
    Label3: TLabel;
    edtNamaEkspedisi: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    Label1: TLabel;
    edtIdEkspedisi: TAdvEdit;
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
  frmEkspedisi: TfrmEkspedisi;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib, DB;

{$R *.dfm}

procedure TfrmEkspedisi.refreshdata;
begin
//  FID:='';
//  edtIdEkspedisi.text := '';
  edtNamaEkspedisi.text := '';
//  edtIdEkspedisi.text := False;
//  edtIdEkspedisi.Enabled := False;
  edtNamaEkspedisi.SetFocus;
end;
procedure TfrmEkspedisi.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmEkspedisi.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmEkspedisi.loaddata(akode:string) ;
var
  s: string;
  tsql : TmyQuery;
begin
  s:= 'SELECT ekspedisi_id, ekspedisi_nama FROM tekspedisi WHERE ekspedisi_id = ' + Quot(akode) ;
tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;
//      edtNopol.Enabled := True;
      edtIdEkspedisi.Text := fieldbyname('ekspedisi_id').AsString;
      edtNamaEkspedisi.Text := fieldbyname('ekspedisi_nama').AsString;
//      FID :=fieldbyname('ekspedisi_id').AsString;
    end
    else
     FLAGEDIT := False;

  finally
    Free;
  end;
end;

end;


procedure TfrmEkspedisi.simpandata;
var
  s:string;
begin
if FLAGEDIT then
  s:='update tekspedisi set '
    + ' ekspedisi_nama = ' + Quot(edtNamaEkspedisi.Text)
    + ' where ekspedisi_id = ' + quot(FID) + ';'
else
begin
// edtKode.Text := getmaxkode;
  s :=  ' insert into tekspedisi '
             + ' (ekspedisi_nama) '
             + ' values ( '
//             + Quot(edtIdEkspedisi.Text) + ','
             + Quot(edtNamaEkspedisi.Text)
             + ');';
end;
    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

end;


procedure TfrmEkspedisi.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmEkspedisi.cxButton1Click(Sender: TObject);
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

procedure TfrmEkspedisi.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmEkspedisi.cxButton2Click(Sender: TObject);
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

procedure TfrmEkspedisi.edtKodeExit(Sender: TObject);
begin
loaddata(edtIdEkspedisi.Text);
end;

end.
