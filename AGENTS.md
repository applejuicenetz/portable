# appleJuice Portable

@../project/AGENTS.md

## Build

`create.sh` benötigt einen Windows-Host mit JDK 25 (inklusive `jpackage`) und
Python 3. JDK-Architektur und Zielarchitektur müssen übereinstimmen:

```bash
./create.sh amd64
./create.sh aarch64
```

Das Skript lädt die aktuellen stabilen Core- und JavaGUI-Releases und erstellt
portable App-Images mit gebündelter Java-Laufzeit. GitHub Actions baut und prüft
beide ZIP-Artefakte auf `windows-2025` und `windows-11-arm`.

## Releases und Trigger

`.github/workflows/release.yml` reagiert auf Tags, `workflow_dispatch` und
`repository_dispatch` mit `event_type=portable-release`. Der JavaGUI-Release
startet diesen Repository-Dispatch nach erfolgreicher Veröffentlichung.

Bei einem Tag-Push wird genau dieser Tag veröffentlicht. Bei manuellem Start
oder Repository-Dispatch ermittelt `scripts/next-release-tag.py` nach erfolgreichem
Build den höchsten stabilen Versionstag und erhöht nur dessen Patch-Level,
beispielsweise `4.0.1` auf `4.0.2`. Ein vorhandenes `v`-Präfix bleibt erhalten;
Prerelease-Tags werden ignoriert. Ohne stabilen Ausgangstag schlägt der Schritt fehl.

`softprops/action-gh-release` erstellt den neuen Tag auf dem gebauten Commit und
veröffentlicht beide ZIPs. `contents: write` ist auf den Release-Job begrenzt.
Die Concurrency-Gruppe `portable-release` verhindert gleichzeitig laufende
Build-/Release-Workflows und damit doppelt berechnete Patch-Versionen.

Manueller Start:

```bash
gh workflow run release.yml --repo applejuicenetz/portable --ref main
```
