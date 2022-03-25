# M300-Services-happy_booth
- Author Luca Blatter
- Vagrant Projekt

# Inahltsverzeichnis
- [Checkliste](#Checklist)
- [Einführung](#Einführung)
- [Umgebung](#Umgebung)
    - [Spezifikationen VM](#spezifikationen_vm)
    - [Codebeschreibung](#codebeschreibung)
- [Anleitung](#Anleitung)
- [Quelle](#Quelle)

# Checklist
## Tag 4
- User wurde geaddet [ + ]
- Tabelle wurde erstellt [ + ]
- Definieren der Mysql/myphpadmin Kreds [ + ]
- Installation Funktioniert [ + ]

## Tag 3
- Entscheiden ob MySQL oder SMB [ + ]
- Informieren über MySQL und interaktion mit einem Webserver [ + ]
- Mysql oder SMB installieren [ + ]
- Webinterface für den Dienst [ + ]

## Tag 2
- Erstellen eines Vagrant Files [ + ]
- Vagrant Testen [ + ]
- Vagrant Script mit update/upgrade ergänzen [ + ]
- V-Script mit einer Webserver Konfiguration erstellen [ + ]
- SSH auf die VM über "vagrant shh" [ + ]


# Einführung
## Einleitung
Das Ziel dieser LB ist es ein Vagrant File zu erstellen und zu verstehen welche Parameter die Umgebung beeinflusst und wie man seine Services aufsetzt.

# Umgebung
## VM
![virtuelle Umgebung](https://github.com/umethe/M300-Services-happy_booth/blob/dev-luca/Gitlab/vagrant-Umgebung.PNG)

### Spezifikationen_VM
- OS: ubuntu/xenial64
- Memory 1024
- Access: http://localhost:8080/phpmyadmin

### Codebeschreibung
Das Vagrant File ist minimal gehalten und beschreibt hauptsächlich die Konfiguration der Umgebung:
    - Virualbox Name
    - Memory
    - Ports (aus sicherheits gründen nur die Ports weitergeleitet die auch Benutzt werden)
    - Verweisung auf das Konfigurations File das über bash und mysql Command Line durchgeführt wird
    

Im Bootstrap File wird zubeginn Variablen Definiert die benutzt werden um MySQL und PHPMyAdmin User Inforamtion zu Definieren. 
Danach werden Updates gesucht

Imanschluss werden die Informatinen für MySQL und PHPMyAdmin gesetzt.
Auf der nächsten Line wird, dann PHPMyAdmin und MySQL-Server installiert.

Danach wird über die Mysql Commandline Tabellen erstellt und befüllt.

Nacher wird ihm Mysqld.cnf eine Line bearbeiten um Remote Access zuerlauben.

# Anleitung
Um die Verbindung mit PHPMyAdmin zuerhalten muss wie oben angegeben: http://localhost:8080/phpmyadmin benutzt werden. 

# Quelle:
- [ ] MYSQL-Server-vagrant: https://www.yourtechy.com/technology/mysql-server-vagrant-virtualbox/
- [ ] Hilfe von Meset Istrefi erhalten ST19D
