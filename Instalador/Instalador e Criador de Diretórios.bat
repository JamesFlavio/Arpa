@ECHO off

REM Versão: 1.0.0.0
@CHCP 1252 >NUL
COLOR A

REM Cria diretórios
MKDIR Backups\Arpa\DB
MKDIR Backups\Arpa\XML
MKDIR www.EmporioAutomacao.com.br

REM Baixando PGAdmin 3
curl -o www.EmporioAutomacao.com.br\pgadmin3-1.22.2.zip https://ftp.postgresql.org/pub/pgadmin/pgadmin3/v1.22.2/win32/pgadmin3-1.22.2.zip

REM Descompactando e movendo PGAdmin 3 para o pasta www.EmporioAutomacao.com.br
tar -xvf www.EmporioAutomacao.com.br\pgadmin3-1.22.2.zip pgadmin3.msi
move pgadmin3.msi www.EmporioAutomacao.com.br\

REM Instalando PGAdmin 3
msiexec /i www.EmporioAutomacao.com.br\pgadmin3.msi REINSTALLMODE=vamus REINSTALL=ALL /qr

REM Baixando TeamViewer 15
curl -o www.EmporioAutomacao.com.br\TeamViewer15_Setup.exe https://dl.teamviewer.com/download/version_15x/TeamViewer_Setup.exe

REM Instalação Silenciosa do TeamViewer 15
start /wait www.EmporioAutomacao.com.br\TeamViewer15_Setup.exe /S /norestart

REM Abrindo download do Nexctcloud via navegador
start https://github.com/nextcloud/desktop/releases/download/v3.1.2/Nextcloud-3.1.2-x64.msi

REM Baixando Arpa X64 Bits
curl -o www.EmporioAutomacao.com.br\instaladorx64.zip http://www.arpasistemas.com.br/instaladorx64.zip

REM Descompactando, movendo e executando Arpa X64 Bits para a pasta www.EmporioAutomacao.com.br
tar -xvf www.EmporioAutomacao.com.br\instaladorx64.zip
move instaladorx64.exe www.EmporioAutomacao.com.br\
.\www.EmporioAutomacao.com.br\instaladorx64.exe