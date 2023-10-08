# Frontend für KMeans und Decision Trees (CART) 

Ein benutzerfreundliches Frontend für die Berechnung von KMeans-Clustering und Decision Trees (CART) sowohl lokal als auch serverseitig. Sie können Sie Daten analysieren und Cluster oder Entscheidungsbäume erstellen, um wertvolle Einblicke aus Ihren Daten zu gewinnen.

## Funktionen

### KMeans-Clustering
- Berechnung mit verschiedenen Distanzmetriken:
  - Euklidisch
  - Manhattan
  - Jaccard-Index
- Klusterbestimmungsmethoden:
  - Elbow-Methode
  - Silhouette-Methode
- Benutzerdefinierte Anzahl von Clustern (optional)
- Lokale Berechnung NUR mit Euklidischer Distanz und der Elbow-Methode

### Decision Trees (CART)
- Entscheidungsbaum-Erstellung und Visualisierung
- Anpassbare Parameter für die Baumkonstruktion

## Voraussetzungen
Bevor Sie das Repository verwenden können, müssen Sie sicherstellen, dass die folgenden Voraussetzungen erfüllt sind:

- **Flutter**: Stellen Sie sicher, dass Flutter auf Ihrem lokalen System installiert ist. Weitere Informationen zur Flutter-
Installation finden Sie unter [Flutter Installationsanleitung](https://flutter.dev/docs/get-started/install).

- **Lokales Backend (nur für serverseitige Berechnungen)**:
Wenn Sie die serverseitige Berechnungsoption nutzen möchten, müssen Sie das Backend [progback](https://github.com/axellotl22/progback) lokal installieren. Beachten Sie, dass das Backend auf Windows-Systemen nur mit [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/de-de/windows/wsl/install) funktioniert.

Nachdem Sie diese Schritte abgeschlossen haben, sollten Sie in der Lage sein, das Frontend für KMeans-Clustering und Decision Trees erfolgreich zu verwenden, sowohl lokal als auch serverseitig.

### Probleme mit WSL
Bei Probleme mit dem Backend kann die Ursache bei WSL liegen. Bitte stellen Sie sicher, dass Sie die erforderlichen Windows-Feature installiert sind:
- **VM-Plattform (Virtual Machine Platform)**
- **Windows-Subsystem für Linux (Windows Subsystem for Linux)**

Die Windows-Features können durch folgende Befehle in PowerShell oder CMD als Administrator aktiviert werden:
```PowerShell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```
```PowerShell
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

Darüber hinaus sollten Sie WSL2 als die Standardversion festlegen.
```bash
wsl --set-default-version 2
```
Anschließend führen Sie einen Neustart Ihres PCs durch.

**Hinweis:** *Falls weiterhin Probleme mit WSL auftreten, könnte es hilfreich sein, Windows-Funktionen auszuschalten, wenn sie bereits aktiviert sind, und sie anschließend erneut zu aktivieren. Beachten Sie jedoch, dass dabei die vorhandenen WSL-Linux-Distributionen gelöscht werden.*


## Verwendung
1. Stellen Sie sicher, dass alle Voraussetzungen erfüllt sind (flutter installiert, lokales Backend für serverseitige Berechnungen eingerichtet, falls erforderlich).
2. Klone oder laden Sie dieses Repository herunter und wechseln Sie in das Verzeichnis.
```bash
git clone https://github.com/Programmierprojekt/programmierprojekt.git & cd programmierprojekt
```
3. Um die Webseite zu starten, führen Sie den folgenden Befehl aus.
```bash
flutter run
```
4. Verwenden Sie die Benutzeroberfläche, um die gewünschten Einstellungen für KMeans oder CART festzulegen.
5. Klicken Sie auf "Berechnen", um die Ergebnisse zu erhalten.
