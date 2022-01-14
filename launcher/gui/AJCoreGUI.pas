program AJCoreGUI;
uses ShellAPI, SysUtils;

{$R AJCoreGUI.rc}

var     verzeichnis, argumente, arg: string;
        i: integer;


begin
verzeichnis:=ExtractFilePath(ParamStr(0)) + '\GUI';
if (fileexists(verzeichnis + '\AJCoreGUI.jar')=true) then
begin
        argumente:='-Duser.home='+ ExtractFilePath(ParamStr(0)) +' -jar AJCoreGUI.jar';
        i := 1;

        for i := 1 to paramCount() do
        begin
             argumente := argumente +' ' + paramStr(i);
        end;

        if (fileexists(verzeichnis + '\Java\bin\javaw.exe')=true) then
          begin
             ShellExecute(0, 'open' ,PChar(verzeichnis + '\Java\bin\javaw.exe'), PChar(argumente), PChar(verzeichnis), 1);
          end
        else
          begin
             ShellExecute(0, 'open' ,PChar('Java\bin\javaw.exe'), PChar(argumente), PChar(verzeichnis), 1);
          end;
        end;
end.
