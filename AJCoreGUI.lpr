program AJCoreGUI;
uses ShellAPI, SysUtils;

{$R project.rc}

var     verzeichnis, argumente, arg: string;
        i: integer;
begin
verzeichnis:=ExtractFilePath(ParamStr(0)) + '\GUI';
if fileexists(verzeichnis+'\AJCoreGUI.jar')=true then begin
        argumente:='-Duser.home='+ ExtractFilePath(ParamStr(0)) +' -jar AJCoreGUI.jar';
        i:=1;
        while ParamStr(i)<>'' do begin
                arg:=ParamStr(i);
                if copy(arg,0,8)='ajfsp://' then arg:='-link='+arg;
                argumente:=argumente+' "'+arg+'"';
                i:=i+1;
                end;
        ShellExecute(0, 'open' ,PChar('..\Java\bin\javaw.exe'), PChar(argumente), PChar(verzeichnis), 1);
        end;
end.
