unit uSyncDOThread;

interface

uses
  Classes, SysUtils, MyAccess; // sesuaikan dengan komponen MyDAC/MySQL yang kamu pakai

type
  TSyncDOThread = class(TThread)
  private
    FSQL: string;
    FErrorMsg: string;
    procedure NotifyDone;
    procedure NotifyError;
  protected
    procedure Execute; override;
  public
    constructor Create(const ASQL: string);
  end;

var
  ThreadBusy: Boolean = False; // flag global (supaya eksekusi antri)

implementation

uses
  Dialogs, MAIN; // uDM = DataModule yang ada koneksi utama (MainConn)

{ TSyncDOThread }

constructor TSyncDOThread.Create(const ASQL: string);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FSQL := ASQL;
  Resume;
end;

procedure TSyncDOThread.Execute;
var
  Conn: TMyConnection;
  Q: TMyQuery;
begin
  // tunggu jika ada thread lain sedang jalan
  while ThreadBusy do
    Sleep(100);

  ThreadBusy := True;
  try
    Conn := TMyConnection.Create(nil);
    try
      // copy setting dari koneksi utama (MainConn di DataModule)
      Conn.Server   := frmMenu.conn.Server;
      Conn.Username := frmMenu.conn.Username;
      Conn.Password := frmMenu.conn.Password;
      Conn.Database := frmMenu.conn.Database;
      Conn.Port     := frmMenu.conn.Port;
      Conn.LoginPrompt := False;
      Conn.Connect;

      Conn.StartTransaction;
      Q := TMyQuery.Create(nil);
      try
        Q.Connection := Conn;
        Q.SQL.Text := FSQL;
        Q.ExecSQL;
      finally
        Q.Free;
      end;
      Conn.Commit;
      Synchronize(NotifyDone);
    except
      on E: Exception do
      begin
        if Conn.InTransaction then
          Conn.Rollback;
        FErrorMsg := E.Message;
        Synchronize(NotifyError);
      end;
    end;
  finally
    Conn.Free;
    ThreadBusy := False;
  end;
end;

procedure TSyncDOThread.NotifyDone;
begin
//  ShowMessage('Sukses menyimpan data.');
end;

procedure TSyncDOThread.NotifyError;
begin
  ShowMessage('Gagal: ' + FErrorMsg);
end;

end.

