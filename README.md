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

## Links und .ajl-Dateien (fixajfsp)

Die Portable-Version schreibt nichts in die Registry. Damit Windows `ajfsp://`-Links und `.ajl`-Dateien mit der GUI öffnet,
einmal `fixajfsp.exe` starten (fragt nach Administratorrechten). Das Programm schlägt `GUI\GUI.exe` vor, zeigt den aktuellen Zustand der Registry
und trägt die Einträge nach einem Klick auf **Registry-Einträge setzen** ein. Nach dem Verschieben des Ordners erneut starten.
Mehr dazu im Repository [fixajfsp](https://github.com/applejuicenetz/fixajfsp).

## RAM (-Xmx)
Der AJCore bekommt automatisch maximal `50%` des gesamten RAM (`-XX:MaxRAMPercentage=50`).
Sind also `8GB` RAM verbaut, darf der AJCore bis zu `4GB` nutzen :tada: 

Um den Wert fest zu definieren, in der Datei `Core\app\Core.cfg` im Abschnitt `[JavaOptions]` die Zeile `java-options=-Xmx2048m` ergänzen.
Ein explizites `-Xmx` hat Vorrang vor `-XX:MaxRAMPercentage`. 

## Home Verzeichnis 

Beide Starter bekommen den Parameter `-Duser.home=$ROOTDIR/..` mitgegeben.

So denken beide Anwendungen, das Heimatverzeichnis des Benutzers ist der aktuelle Ordner der EXE Dateien. :sunglasses: 

Das hat den Vorteil, dass alle persistenten Dateien im `appleJuice` Ordner des Portable Clients liegen!

Bei einem JVM-Absturz schreibt der Core die Datei `hs_err_pid<PID>.log` ebenfalls dorthin (`-XX:ErrorFile`).

## Aktualisierungen

Neue JavaGUI-Releases starten automatisch einen Portable-Build. Nach erfolgreichem
Build erscheint ein neues Portable-Patch-Release, zum Beispiel `4.0.2` nach `4.0.1`,
mit ZIP-Dateien für Windows AMD64 und ARM64. Auch manuell gestartete Builds
veröffentlichen ein neues Patch-Release.
