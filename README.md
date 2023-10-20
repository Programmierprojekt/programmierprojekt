# Frontend für KMeans und Decision Trees (CART) 

Ein benutzerfreundliches Frontend für die Berechnung von KMeans-Clustering und Decision Trees (CART) sowohl lokal als auch serverseitig. Sie können Sie Daten analysieren und Cluster oder Entscheidungsbäume erstellen, um wertvolle Einblicke aus Ihren Daten zu gewinnen.

## Funktionen

### KMeans-Clustering
Server
- Distanzmetriken:
  - Euklidisch, Manhattan, Jaccard
- Klusterbestimmungsmethoden:
  - Silhouette-Methode

Lokal
  - Distanzmetriken:
      - Euklidisch
  - Klusterbestimmungsmethoden:
      - Elbow-Methode

Benutzerdefinierte Anzahl von Clustern (optional)

### Decision Trees (CART)
Entscheidungsbaum-Erstellung (nur serverseitig) und als Json abspeichern.

## Voraussetzungen
Bevor Sie das Repository verwenden können, müssen Sie sicherstellen, dass die folgenden Voraussetzungen erfüllt sind:

- **Flutter**: Stellen Sie sicher, dass Flutter auf Ihrem lokalen System installiert ist. Weitere Informationen zur  Flutter-Installation finden Sie unter [Flutter Installationsanleitung](https://flutter.dev/docs/get-started/install).

- **Lokales Backend (nur für serverseitige Berechnungen)**:
Wenn Sie die serverseitige Berechnungsoption nutzen möchten, müssen Sie das Backend [progback](https://github.com/axellotl22/progback) lokal installieren. Beachten Sie, dass das Backend auf Windows-Systemen nur mit [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/de-de/windows/wsl/install) funktioniert.

Nachdem Sie diese Schritte abgeschlossen haben, sollten Sie in der Lage sein, das Frontend für KMeans-Clustering und Decision Trees erfolgreich zu verwenden, sowohl lokal als auch serverseitig.

## Verwendung
1. Stellen Sie sicher, dass alle Voraussetzungen erfüllt sind (flutter installiert, lokales Backend für serverseitige Berechnungen eingerichtet, falls erforderlich).
2. Klone oder laden Sie dieses Repository herunter und wechseln Sie in das Verzeichnis.
```bash
git clone https://github.com/Programmierprojekt/programmierprojekt.git && cd programmierprojekt
```
3. Um die Webseite zu starten, führen Sie den folgenden Befehl aus.
```bash
flutter run
```
4. Verwenden Sie die Benutzeroberfläche, um die gewünschten Einstellungen für KMeans oder CART festzulegen.
5. Klicken Sie auf „Berechnen“, um die Ergebnisse zu erhalten.

## Installation von lokalen Backend
Um das lokale Backend [progback](https://github.com/axellotl22/progback) zum Laufen zu bekommen müssen folgende Schritte gemacht werden:

1. WSL installieren
2. Ubuntu (oder eine ähnliche Linux-Distribution) installieren
3. Ubuntu aktualisieren
4. MariaDB installieren
5. MariaDB Benutzer und Datenbank erstellen
6. Backend herunterladen und die .env kon­fi­gu­rie­ren

### 1. WSL installieren
Bitte stellen Sie sicher, dass Sie die erforderlichen Windows-Features installiert sind:
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

**Hinweis:** *Falls Probleme mit WSL auftreten, könnte es hilfreich sein, die Windows-Funktionen auszuschalten, wenn sie bereits aktiviert sind, und sie anschließend erneut zu aktivieren. Beachten Sie jedoch, dass dabei die vorhandenen WSL-Linux-Distributionen gelöscht werden.*

### 2. Ubuntu (oder eine ähnliche Linux-Distribution) installieren
Nachdem Sie WSL installiert haben, öffnen Sie PowerShell oder CMD und führen Sie den Befehl *"wsl --list --online"* aus, um die verfügbaren Linux-Distributionen anzuzeigen.

In der Installation wird Ubuntu verwendet. Führen Sie die folgenden Befehle aus:
```PowerShell
wsl --install Ubuntu
```
**Hinweis:** *Die nachfolgenden Befehle können je nach der verwendeten Linux-Distribution unterschiedlich sein.*
### 3. Ubuntu aktualisieren
Starten Sie die WSL-Umgebung und aktualisieren Sie zunächst die Paketliste, um sicherzustellen, dass Sie die neuesten Pakete erhalten. Zudem updaten Sie Ihr System.
```bash
sudo apt update && sudo apt upgrade
```
### 4. MariaDB installieren
Verwenden Sie den folgenden Befehl, um MariaDB zu installieren:
```bash
sudo apt install mariadb-server
```
Stellen Sie sicher, dass MariaDB gestartet ist und die Datenbank beim Hochfahren automatisch gestartet wird.
```bash
sudo systemctl start mariadb.service
```
```bash
sudo systemctl enable mariadb.service
```
Führen Sie nun das MariaDB-Installations-Skript aus.
```bash
sudo mysql_secure_installation
```
### 5. MariaDB Benutzer und Datenbank erstellen
Nun möchten wir einen Benutzer und eine Datenbank für das Backend erstellen. Dazu müssen wir uns zuerst mit der Datenbank verbinden.
```bash
sudo mysql -u root
```
```MySql
GRANT ALL PRIVILEGES ON *.* TO 'progback'@'%' IDENTIFIED BY 'your_password';
```
```MySql
FLUSH PRIVILEGES;
```
```MySql
CREATE DATABASE your_database;
```
#### Remote-Zugriff
Um den Remote-Zugriff auf MariaDB zu ermöglichen, müssen Sie eine Zeile in der Konfigurationsdatei ändern.
```bash
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
```
Die Zeile *bind-address = 127.0.0.1* mit zu **bind-address = 0.0.0.0** geändert werden. Anschließend ist ein Neustart des Dienstes erforderlich.
```bash
sudo systemctl restart mariadb.service
```
### 6. Backend herunterladen und die .env kon­fi­gu­rie­ren
Laden Sie das Backend herunter und wechseln Sie in das entsprechende Verzeichnis.
```bash
git clone https://github.com/axellotl22/progback && cd progback
```

Entnehmen Sie den Port von MariaDB aus dem Befehl **systemctl status mariadb.service** raus. Standardmäßig ist der Port **3306**.

In Docker gibt es eine Bridge-Gateway-Adresse, die standardmäßig für Container-Netzwerke verwendet wird. Standardmäßig lautet die IP-Adresse **172.17.0.1** für das Container-Gateway. Wenn Sie die IP-Adresse dieses Gateways herausfinden möchten, können Sie dies mit folgendem Befehl tun:
```bash
ip -4 addr show docker0
```

Jetzt können Sie die Datei **.env.example** kopieren, um sie zu bearbeiten.
```bash
cp .env.example .env
```

Mit folgendem Befehl können Sie die **.env** öffnen:
```bash
nano .env
```

Der folgende Inhalt in der **.env**-Datei sieht so aus:
```
TEST_MODE=False
DEV_MODE=True

#Database Config
DB_HOST=172.17.0.1
DB_PORT=3306
DB_PW=your_password
DB_SCHEMA=your_database

#User Config
APP_SECRET=
VERIFICATION_SECRET=
```
Bevor der Container gestartet werden kann, muss **docker-compose** installiert werden.
```bash
sudo apt install docker-compose
```
Jetzt können Sie den Container starten. 
```bash
sudo ./deploy.sh
```
Wenn **Lazydocker** nicht installiert wird, können Sie die Anleitung zur Installation [hier](https://lindevs.com/install-lazydocker-on-ubuntu/) ansehen.