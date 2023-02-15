unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, shellapi,
  System.IOUtils;


type
    TArg<T> = reference to procedure(const Arg: T);


type
  TForm1 = class(TForm)
    Memo1: TMemo;
    buFb25backup: TButton;
    buFb30backup: TButton;
    buKonweruj: TButton;
    edBaza25: TEdit;
    buSelBaza25: TButton;
    OD1: TOpenDialog;
    edBaza30: TEdit;
    buBaza30: TButton;
    buFb25restore: TButton;
    buFb30restore: TButton;
    buFb25info: TButton;
    buFb30info: TButton;
    edBak25: TEdit;
    Button1: TButton;
    Button2: TButton;
    edBak30: TEdit;
    procedure buFb25backupClick(Sender: TObject);
    procedure buFb30backupClick(Sender: TObject);
    procedure buSelBaza25Click(Sender: TObject);
    procedure buKonwerujClick(Sender: TObject);
    procedure buFb25restoreClick(Sender: TObject);
    procedure buFb25infoClick(Sender: TObject);
    procedure buFb30restoreClick(Sender: TObject);
    procedure buFb30infoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    gbk25, dir25, dir30, dir25b, dir30b: string;
    function Gbak(const act, ver: string):boolean;
    { Private declarations }
  public
    { Public declarations }
    procedure  CaptureConsoleOutput(const  ACommand, AParameters: String; CallBack: TArg<PAnsiChar>);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.buFb25backupClick(Sender: TObject);
begin
  Memo1.Lines.Add('!!!!!!!!!!!!!!   FB 2.5 BACKUP      !!!!!!!!!!!');
  Gbak('B','2');
  Memo1.Lines.Add('----------------------------------------------------');
  Memo1.Lines.Add('**************       GOTOWE         ****************');
  Memo1.Lines.Add('====================================================');
end;

procedure TForm1.buFb25infoClick(Sender: TObject);
begin
  Memo1.Lines.Add('!!!!!!!!!!!!!!   FB 2.5 INFO      !!!!!!!!!!!');
  Gbak('Z','2');
  Memo1.Lines.Add('====================================================');
end;

procedure TForm1.buFb25restoreClick(Sender: TObject);
begin
  Memo1.Lines.Add('!!!!!!!!!!!!!!   FB 2.5 RESTORE      !!!!!!!!!!!');
  Gbak('R','2');
  Memo1.Lines.Add('----------------------------------------------------');
  Memo1.Lines.Add('**************       GOTOWE         ****************');
  Memo1.Lines.Add('====================================================');
end;

procedure TForm1.buFb30backupClick(Sender: TObject);
begin
  Memo1.Lines.Add('!!!!!!!!!!!!!!   FB 3.0 BACKUP      !!!!!!!!!!!');
  Gbak('B','3');
  Memo1.Lines.Add('----------------------------------------------------');
  Memo1.Lines.Add('**************       GOTOWE         ****************');
  Memo1.Lines.Add('====================================================');
end;


procedure TForm1.buFb30infoClick(Sender: TObject);
begin
  Gbak('Z','3');
end;

procedure TForm1.buFb30restoreClick(Sender: TObject);
begin
  Memo1.Lines.Add('!!!!!!!!!!!!!!   FB 3.0 RESTORE      !!!!!!!!!!!');
  Gbak('R','3');
  Memo1.Lines.Add('----------------------------------------------------');
  Memo1.Lines.Add('**************       GOTOWE         ****************');
  Memo1.Lines.Add('====================================================');
end;

function TForm1.Gbak(const act, ver:string):boolean;
var s: string;
  gbak, par, ln, dba, gba: string;
begin
  Result := false;
  gbak := 'gbak.exe';
  if ver='2' then
  begin
    dba := edBaza25.Text;
    gba := edBak25.Text;
  end else
  if ver = '3' then
  begin
    dba := edBaza30.Text;
    gba := edBak30.Text;
  end else
    Exit;

  if act='B' then
  begin
    s:='-B '+dba+' '+gba+' -E -T -v -user SYSDBA -pass masterkey';
  end else
  if act='R' then
  begin
    s:='-REP '+gba+' '+dba+' -v -user SYSDBA -pass masterkey -FIX_FSS_METADATA win1250';
  end else
  if act='Z' then
    s:='-Z '+dba+' '+gba+' -v -user SYSDBA -pass masterkey';

  Memo1.Lines.Add('====================================================');
  Memo1.Lines.Add(gbak+' '+s);
  Memo1.Lines.Add('----------------------------------------------------');

  if ver='2' then
    SetCurrentDir(dir25b)
  else
    if ver='3' then
      SetCurrentDir(dir30b);

  par := s;
  if act='Z' then
  begin
    s:='-Z '+dba+' -v -user SYSDBA -pass masterkey';
    CaptureConsoleOutput(gbak, s,
      procedure(const Line: PAnsiChar)
      begin
        ln := String(Line);
        Memo1.Lines.Add( ln );
        if Pos('ERROR', ln)>0  then
          Exit;
      end
    );
    s:='-Z '+gba+' -v -user SYSDBA -pass masterkey';
    CaptureConsoleOutput(gbak ,s,
      procedure(const Line: PAnsiChar)
      begin
        ln := String(Line);
        Memo1.Lines.Add( ln );
        if Pos('ERROR', ln)>0  then
          Exit;
      end
    );
  end;
  Result:=true;
end;


procedure TForm1.buKonwerujClick(Sender: TObject);
var
  plk, db25, bk25, db30, bk30: string;
begin
  if not FileExists( edBaza25.Text ) then
  begin
    ShowMessage('Wybierz plik z baz¹ danych');
    Exit;
  end;
  db25          := edBaza25.Text;
  bk25          := ChangeFileExt(db25, '.gbk');
  edBak25.Text  := bk25;

  plk   := ExtractFileName(db25);
  plk   := ChangeFileExt(plk,'.fdb');
  db30  := dir30 + plk;

  plk   := ExtractFileName(bk25);
  bk30  := dir30 + plk;

  edBaza30.Text := db30;
  edBak30.Text  := bk30;

  if Gbak('B','2') then
  begin
    TFile.Copy(bk25, bk30, true);
    Gbak('R','3');
  end;
  Memo1.Lines.Add('----------------------------------------------------');
  Memo1.Lines.Add('**************       GOTOWE         ****************');
  Memo1.Lines.Add('====================================================');
end;

procedure TForm1.buSelBaza25Click(Sender: TObject);
var plk: string;
begin
  if edBaza25.Text='' then edBaza25.Text := dir25;
  if OD1.FileName='' then  edBaza25.Text;
  if not OD1.Execute() then Exit;
  edBaza25.Text := OD1.FileName;
  gbk25 := ChangeFileExt(edBaza25.Text,'.gbk');
  if TFile.Exists(gbk25) then
    edBak25.Text := gbk25;

  plk   := ExtractFileName(edBaza25.Text);
  edBaza30.Text := dir30+ChangeFileExt(plk,'.fdb');

end;

procedure TForm1.CaptureConsoleOutput(const ACommand, AParameters: String; CallBack: TArg<PAnsiChar>);
const
  CReadBuffer = 2400;
var
  saSecurity: TSecurityAttributes;
  hRead: THandle;
  hWrite: THandle;
  suiStartup: TStartupInfo;
  piProcess: TProcessInformation;
  pBuffer: array [0 .. CReadBuffer] of AnsiChar;
  dBuffer: array [0 .. CReadBuffer] of AnsiChar;
  dRead: DWORD;
  dRunning: DWORD;
  dAvailable: DWORD;
begin
  saSecurity.nLength := SizeOf(TSecurityAttributes);
  saSecurity.bInheritHandle := true;
  saSecurity.lpSecurityDescriptor := nil;
  if CreatePipe(hRead, hWrite, @saSecurity, 0) then
    try
      FillChar(suiStartup, SizeOf(TStartupInfo), #0);
      suiStartup.cb := SizeOf(TStartupInfo);
      suiStartup.hStdInput := hRead;
      suiStartup.hStdOutput := hWrite;
      suiStartup.hStdError := hWrite;
      suiStartup.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
      suiStartup.wShowWindow := SW_HIDE;
      if CreateProcess(nil, PChar(ACommand + ' ' + AParameters), @saSecurity, @saSecurity, true, NORMAL_PRIORITY_CLASS, nil, nil, suiStartup,
        piProcess) then
        try
          repeat
            dRunning := WaitForSingleObject(piProcess.hProcess, 100);
            PeekNamedPipe(hRead, nil, 0, nil, @dAvailable, nil);
            if (dAvailable > 0) then
              repeat
                dRead := 0;
                ReadFile(hRead, pBuffer[0], CReadBuffer, dRead, nil);
                pBuffer[dRead] := #0;
                OemToCharA(pBuffer, dBuffer);
                CallBack(dBuffer);
              until (dRead < CReadBuffer);
            Application.ProcessMessages;
          until (dRunning <> WAIT_TIMEOUT);
        finally
          CloseHandle(piProcess.hProcess);
          CloseHandle(piProcess.hThread);
        end;
    finally
      CloseHandle(hRead);
      CloseHandle(hWrite);
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var cdir: string;
begin
  cdir    := GetCurrentDir;
  dir25   := cdir+'\db25\';
  dir30   := cdir+'\db30\';
  dir25b  := cdir+'\fb25\';
  dir30b  := cdir+'\fb30\';
  if not TDirectory.Exists(dir25) then TDirectory.CreateDirectory(dir25);
  if not TDirectory.Exists(dir30) then TDirectory.CreateDirectory(dir30);
end;

procedure CaptureConsoleOutput(const ACommand, AParameters: String; AMemo: TMemo);
 const
   CReadBuffer = 2400;
 var
   saSecurity: TSecurityAttributes;
   hRead: THandle;
   hWrite: THandle;
   suiStartup: TStartupInfo;
   piProcess: TProcessInformation;
   pBuffer: array[0..CReadBuffer] of AnsiChar;
   dRead: DWord;
   dRunning: DWord;
 begin
   saSecurity.nLength := SizeOf(TSecurityAttributes);
   saSecurity.bInheritHandle := True;
   saSecurity.lpSecurityDescriptor := nil;

   if CreatePipe(hRead, hWrite, @saSecurity, 0) then
   begin
     FillChar(suiStartup, SizeOf(TStartupInfo), #0);
     suiStartup.cb := SizeOf(TStartupInfo);
     suiStartup.hStdInput := hRead;
     suiStartup.hStdOutput := hWrite;
     suiStartup.hStdError := hWrite;
     suiStartup.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
     suiStartup.wShowWindow := SW_HIDE;

     if CreateProcess(nil, PChar(ACommand + ' ' + AParameters), @saSecurity,
       @saSecurity, True, NORMAL_PRIORITY_CLASS, nil, nil, suiStartup, piProcess)
       then
     begin
       repeat
         dRunning  := WaitForSingleObject(piProcess.hProcess, 100);
         Application.ProcessMessages();
         repeat
           dRead := 0;
           ReadFile(hRead, pBuffer[0], CReadBuffer, dRead, nil);
           pBuffer[dRead] := #0;

           OemToAnsi(pBuffer, pBuffer);
           AMemo.Lines.Add(String(pBuffer));
         until (dRead < CReadBuffer);
       until (dRunning <> WAIT_TIMEOUT);
       CloseHandle(piProcess.hProcess);
       CloseHandle(piProcess.hThread);
     end;

     CloseHandle(hRead);
     CloseHandle(hWrite);
   end;
end;

end.
