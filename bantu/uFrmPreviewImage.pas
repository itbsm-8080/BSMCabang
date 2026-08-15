unit uFrmPreviewImage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, Grids, BaseGrid, AdvGrid, DBAdvGrd, ExtCtrls,
  AdvPanel, FMTBcd, DB, DBClient, Provider, SqlExpr, AdvCombo, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Menus, cxButtons,cxCurrencyEdit, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinXmas2008Blue, DBAccess, MyAccess, MemDS,
  dxSkinDarkRoom, dxSkinFoggy, dxSkinSeven, dxSkinSharp, jpeg, cxContainer,
  cxImage;

type
  TfrmPrevImg = class(TForm)
    AdvPanel4: TAdvPanel;
    ScrollBox1: TScrollBox;
    cxImage1: TcxImage;
    procedure FormShow(Sender: TObject);
    procedure loadbantuan(afilter : string='') ;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTutupClick(Sender: TObject);
  private
    { Private declarations }
    Fanamaform: string;
  public
    SQLMaster : string;
    foto : string;
    property anamaform: string read Fanamaform write Fanamaform;
    { Public declarations }
  end;

var
  frmPrevImg: TfrmPrevImg;

implementation
  uses MAIN, Ulib;
{$R *.dfm}

procedure TfrmPrevImg.FormShow(Sender: TObject);
begin
  loadbantuan;
end;

procedure TfrmPrevImg.loadbantuan(afilter : string='') ;
var
  i:integer;
begin
   cxLoadImageFromURL('http://103.103.22.7/cutikaryawan/bukti/' + foto, cxImage1);
end;

procedure TfrmPrevImg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfrmPrevImg.btnTutupClick(Sender: TObject);
begin
  Close;
end;

end.
