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

## neues Release erstellen

### github action
Einfach ein `neues Release` mit Changelog als Kommentar erstellen.

Es wird dann automatisch via `github action` alles ausgeführt, die fertigen ZIP-Dateien an das Release attached!

### manuel
Zum Erstellen einer neuen Version kann die Datei [create.sh](create.sh) wie folgt ausgeführt werden:
- `./create.sh amd64` -> Windows AMD64
- `./create.sh aarch64` -> Windows ARM64

Alle benötigten Komponenten/Abhängigkeiten werden heruntergeladen und in die richtige Struktur gebracht.
 
## Build

`create.sh` muss auf einem Windows Host mit JDK 25 der jeweiligen Architektur laufen (GitHub Action: `windows-2025` für AMD64, `windows-11-arm` für ARM64).
Die Action kann auch manuell per `workflow_dispatch` gestartet werden, dann wird kein Release erstellt, die ZIPs liegen als Artefakt am Run.
