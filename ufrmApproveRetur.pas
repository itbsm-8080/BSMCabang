unit ufrmApproveRetur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids,  AdvGrid, ComCtrls, StdCtrls, AdvEdit, ExtCtrls,
  AdvPanel, AdvCGrid, BaseGrid,SqlExpr, DBAdvGrd, DB, DBClient, Provider,
  FMTBcd, RAWPrinter, StrUtils, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxDBData, cxSpinEdit, cxCalendar, Menus, cxButtons, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxButtonEdit, cxCurrencyEdit,ExcelXP,ComObj,
  AdvCombo,DateUtils, cxPC, AdvEdBtn;

type
  TfrmApproveRetur = class(TForm)
    AdvPanel1: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel2: TAdvPanel;
    Label5: TLabel;
    RAWPrinter1: TRAWPrinter;
    AdvPanel4: TAdvPanel;
    cxButton8: TcxButton;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    MainMenu1: TMainMenu;
    edtNomorFP: TAdvEditBtn;
    ehasil: TAdvEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cxButton8Click(Sender: TObject);
    procedure edtNomorFPClickBtn(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    private
      { Private declarations }
     protected
  public
    { Public declarations }
  end;

var
  frmApproveRetur: TfrmApproveRetur;

implementation

uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport;

{$R *.dfm}

procedure TfrmApproveRetur.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Release;
end;

procedure TfrmApproveRetur.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     SelectNext(ActiveControl,True,True);
end;



procedure TfrmApproveRetur.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmApproveRetur.edtNomorFPClickBtn(Sender: TObject);
var
    SQLbantuan :string;
begin
 sqlbantuan := ' SELECT fp_NOMOR Nomor,fp_TANGGAL Tanggal,fp_cus_kode Kode,cus_NAMA customer,fp_amount Total from tfp_HDR inner join '
            + ' tcustomer on cus_kode=fp_cus_kode where fp_isbayar=0';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
  begin
    edtNomorFP.Text :=  varglobal;
  end;

end;

procedure TfrmApproveRetur.Button2Click(Sender: TObject);
var  plaintext,ciphertext: string;
P,K,C,i,n : integer;
tt:tstrings;
begin
plaintext := UpperCase(edtNomorFP.Text);
K := 4;
n := Length(plaintext);
ciphertext:='';
For i:= 1 to n do
begin
  P:=ord(plaintext[i])-65;
  C:=(P + K) mod 26;
  ciphertext:=ciphertext+ chr(C+65)
end;
eHasil.Text := ciphertext;
     tt := TStringList.Create;
     tt.Append(ehasil.Text);
     tt.SaveToFile(edtNomorFP.Text+'.apr');

end;
end.
