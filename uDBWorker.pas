unit uDBWorker;

interface

uses
  Classes, SysUtils, SyncObjs, Contnrs, MyAccess,Windows;

type
  TDBWorker = class(TThread)
  private
    FQueue: TThreadList;     // antrian SQL
    FEvent: TEvent;          // event untuk wake up thread
    FErrorMsg: string;
    procedure NotifyError;
    procedure NotifyDone;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;

    procedure EnqueueSQL(const ASQL: string);
  end;

var
  DBWorker: TDBWorker;

implementation

uses
  Dialogs, MAIN; // DM.MainConn = koneksi utama untuk ambil setting

{ TDBWorker }

constructor TDBWorker.Create;
begin
  inherited Create(True);
  FreeOnTerminate := False; // biar hidup terus
  FQueue := TThreadList.Create;
  FEvent := TEvent.Create(nil, False, False, '');
  Resume;
end;

destructor TDBWorker.Destroy;
begin
  FQueue.Free;
  FEvent.Free;
  inherited;
end;

procedure TDBWorker.EnqueueSQL(const ASQL: string);
var
  L: TList;
  S: PString;
begin
  New(S);
  S^ := ASQL;
  L := FQueue.LockList;
  try
    L.Add(S);
  finally
    FQueue.UnlockList;
  end;
  FEvent.SetEvent; // bangunkan thread
end;

procedure TDBWorker.Execute;
var
  Conn: TMyConnection;
  Q: TMyQuery;
  L: TList;
  Item: Pointer;
  SQL: string;
begin
  Conn := TMyConnection.Create(nil);
  try
    Conn.Server   := frmMenu.conn.Server;
    Conn.Username := frmMenu.conn.Username;
    Conn.Password := frmMenu.conn.Password;
    Conn.Database := frmMenu.conn.Database;
    Conn.Port     := frmMenu.conn.Port;
    Conn.LoginPrompt := False;
    Conn.Connect;

    while not Terminated do
    begin
      // tunggu ada job
      FEvent.WaitFor(INFINITE);

      // ambil semua job dalam queue
      L := FQueue.LockList;
      try
        while L.Count > 0 do
        begin
          Item := L[0];
          L.Delete(0);
          SQL := PString(Item)^;
          Dispose(PString(Item));

          try
            Conn.StartTransaction;
            Q := TMyQuery.Create(nil);
            try
              Q.Connection := Conn;
              Q.SQL.Text := SQL;
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
        end;
      finally
        FQueue.UnlockList;
      end;
    end;
  finally
    Conn.Free;
  end;
end;

procedure TDBWorker.NotifyDone;
begin
  ShowMessage('SQL sukses dieksekusi.');
end;

procedure TDBWorker.NotifyError;
begin
  ShowMessage('Error SQL: ' + FErrorMsg);
end;

end.

