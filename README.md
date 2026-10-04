# appleJuice Portable

![](https://img.shields.io/github/license/applejuicenetz/portable.svg)
![](https://img.shields.io/github/release/applejuicenetz/portable.svg)
![](https://img.shields.io/github/downloads/applejuicenetz/portable/total)
![](https://github.com/applejuicenetz/portable/workflows/release/badge.svg)

appleJuice, Portable, ohne Setup, mit Java, einfach downloaden und starten.

## Zusammensetzung 

Die Portable Version von appleJuice setzt sich zusammen aus:
- der letzten openJDK ZULU JRE Version 25 von [Azul](https://www.azul.com/downloads/)
- dem aktuellsten [AJCore](https://github.com/applejuicenetz/core/releases)
- der aktuellsten [AJCoreGUI](https://github.com/applejuicenetz/gui-java/releases)
- nativen Startern (`Core\Core.exe`, `GUI\GUI.exe`) mit eingebauter Java 25 Runtime, erzeugt per `jpackage --type app-image`

## RAM (-Xmx)
Der AJCore bekommt automatisch `50%` des _aktuell_ freien RAM.
Sind also `4GB` RAM verbaut und es sind davon _aktuell_ noch `2GB` frei, 
dann bekommt der AJCore `1GB` RAM zugewiesen :tada: 

Um den Wert fest zu definieren, muss die Datei `AJCore.l4j.ini` mit dem Inhalt `-Xmx2048m` angelegt werden. 

## Home Verzeichnis 

Beide Starter bekommen den Parameter `-Duser.home=$ROOTDIR/..` mitgegeben.

So denken beide Anwendungen, das Heimatverzeichnis des Benutzers ist der aktuelle Ordner der EXE Dateien. :sunglasses: 

Das hat den Vorteil, dass alle persistenten Dateien im `appleJuice` Ordner des Portable Clients liegen!

## Aktualisierungen

Neue JavaGUI-Releases starten automatisch einen Portable-Build. Nach erfolgreichem
Build erscheint ein neues Portable-Patch-Release, zum Beispiel `4.0.2` nach `4.0.1`,
mit ZIP-Dateien für Windows AMD64 und ARM64. Auch manuell gestartete Builds
veröffentlichen ein neues Patch-Release.
