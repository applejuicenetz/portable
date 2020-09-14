# appleJuice Portable

![](https://img.shields.io/github/license/applejuicenet/portable.svg)
![](https://img.shields.io/github/release/applejuicenet/portable.svg)
![](https://img.shields.io/github/downloads/applejuicenet/portable/total)
![](https://github.com/applejuicenet/portable/workflows/release/badge.svg)

appleJuice, Portable, ohne Setup, mit Java, einfach downloaden und starten.

## Zusammensetzung 

Die Portable Version von appleJuice setzt sich zusammen aus:
- der aktuellsten openJDK JRE Version 1.8 von [AdoptOpenJDK](https://github.com/AdoptOpenJDK/openjdk8-binaries) 
- der aktuellsten [AJCoreGUI](https://github.com/applejuicenet/portable/releases)
- dem aktuellsten [AJCore](https://github.com/applejuicenet/core/releases)
- extra Wrapper EXE Dateien für die Portable Version (siehe nachfolgend)

## RAM (-Xmx)
Der AJCore bekommt automatisch `50%` des _aktuell_ freien RAM.
Sind also `4GB` RAM verbaut und es sind davon _aktuell_ noch `2GB` frei, 
dann bekommt der AJCore `1GB` RAM zugewiesen :tada: 

Um den Wert fest zu definieren, muss die Datei `AJCore.l4j.ini` mit dem Inhalt `-Xmx2048m` angelegt werden. 

## Home Verzeichnis 

Beide Exe Dateien bekommen den Parameter `-Duser.home=.` mitgegeben.

So denken beide Anwendungen, das Heimatverzeichnis des Benutzers ist der aktuelle Ordner der EXE Dateien. :sunglasses: 

Das hat den Vorteil, dass alle persistenten Dateien im `appleJuice` Ordner des Portable Clients liegen!

## neues Release erstellen

### github action
Einfach ein `neues Release` mit Changelog als Kommentar erstellen.

Es wird dann automatisch via `github action` alles ausgeführt, die fertigen ZIP-Dateien an das Release attached!

### manuel
Zum Erstellen einer neuen Version kann die Datei [create.sh](create.sh) wie folgt ausgeführt werden:
- `./create.sh x64` -> 64bit
- `./create.sh x86` -> 32bit

Alle benötigten Komponenten/Abhängigkeiten werden heruntergeladen und in die richtige Struktur gebracht.
 
## Quellcode

nachfolgend finden sich Erklärungen zu den extra für die Portable erstellten Komponenten.

Alle ausführbaren Dateien wurden mit [UPX](https://upx.github.io/) verkleinert.

### Starter: AJCore.exe

Die `AJCore.exe` wurde mit [Launch4j](http://launch4j.sourceforge.net) erstellt.
Es wird immer das mitgelieferte JRE im `Java` Ordner genommen.

Der `AJCore` wird nicht mit `-c` bzw. `--configinjardir` gestartet (siehe _Home Verzeichnis_)!

### Starter: AjCoreGUI.exe

Der original [Quellcode](https://github.com/applejuicenet/portable/tree/master/AJClientGUI/starterexe) für `AJCoreGUI.exe` wurde für die Portable Version mittels [Lazarus](https://www.lazarus-ide.org) für diese Version [angepasst](AJCoreGUI.lpr) und neu kompiliert,
so das ebenfalls die mitgelieferte JRE genommen wird.

Das [Icon](ajgui.ico) wurde extra geändert, damit es sich zum Original unterscheidet.

Außerdem wird beim erstellen der ZIP Datei die original `AjcoreGUI.exe` aus dem GUI Ordner entfernt um eine Verwechslung zu vermeiden.
