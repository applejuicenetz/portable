# appleJuice Portable

appleJuice, Portable, ohne Setup, mit Java, einfach downloaden und starten.

## Zusammensetzung 

Die Portable Version von appleJuice setzt sich zusammen aus:
- der aktuellsten openJDK JRE Version 1.8 von [AdoptOpenJDK](https://github.com/AdoptOpenJDK/openjdk8-binaries) 
- der aktuellsten [AJCoreGUI](https://github.com/applejuicenet/gui-java/releases)
- dem aktuellsten [AJCore](https://github.com/applejuicenet/core/releases)
- extra Wrapper EXE Dateien für die Portable Version (siehe nachfolgend)

## Release
Siehe [create_x86.sh](create_x86.sh) bzw [create_x64.sh](create_x64.sh).

## Quellcode

nachfolgend finden sich Erklärungen zu den extra für die Portable erstellten Komponenten.

Alle ausführbaren Dateien wurden mit [UPX](https://upx.github.io/) verkleinert.
 
### AJCore.exe

Die `AJCore.exe` wurde mit [Launch4j](http://launch4j.sourceforge.net) erstellt.
Es wird immer das mitgelieferte JRE im `Java` Ordner genommen.

Der AJCore bekommt automatisch `50%` des _aktuell_ freien RAM.
Sind also `4GB` RAM verbaut, und es sind davon _aktuell_ noch `2GB` frei, dann bekommt der AJCore `1GB` RAM zugewiesen :sunglasses: 

Der `AJCore` wird nicht mit `-c` bzw. `--configinjardir` gestartet, sondern dem Java Prozess wird der parameter `-Duser.home=.` mitgegeben (aktuller Ordner).

So denkt der `AJCore`, das Heimatverzeichnis des Benutzers ist der aktuelle Ordner der EXE Dateien. :sunglasses: 

Das hat den Vorteil, dass beim ersten start ein `appleJuice` Ordner im aktuellen Ordner angelegt wird, wo alle persistenten Dateien liegen!

### AjCoreGUI.exe

Der original [Quellcode](https://github.com/applejuicenet/gui-java/tree/master/AJClientGUI/starterexe) für `AJCoreGUI.exe` wurde für die Portable Version mittels [Lazarus](https://www.lazarus-ide.org) [angepasst](AJCoreGUI.lpr) und neu kompiliert,
so das ebenfalls die mitgelieferte JRE genommen wird.
Das [Icon](ajgui.ico) wurde extra geändert, damit es sich zum Original unterscheidet.
Außerdem wird beim erstellen der ZIP Datei die original `AjcoreGUI.exe` aus dem GUI Ordner entfernt um eine Verwechslung zu vermeiden.
