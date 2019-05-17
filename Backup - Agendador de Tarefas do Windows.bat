@echo off
REM Muda a cor da fonte para verde
color A

REM Cria os diretórios para backup.

mkdir "C:\Program Files (x86)\arpa\Backup"
mkdir "D:\BACKUP\ARPA\BD"
mkdir "E:\BACKUP\ARPA\BD"

REM Altera caracteres de data e hora para caracteres permitidos para nome de arquivos.

for /f "tokens=1,2,3,4 delims=/ " %%a in ('DATE /T') do set Date=%%c-%%b-%%a
for /f "tokens=1,2,3,4 delims=: " %%a in ('time /T') do set time=%%a-%%b

SET PGDIR="C:\Program Files (x86)\arpa\PostgreSQL\bin"
SET HOST=127.0.0.1
SET DATABASE=control
SET PGUSER=postgres
SET ARQUIVO_DESTINO="C:\Program Files (x86)\arpa\backup\Control%Date%-%time%.sql"

echo %PGDIR%
echo %PGUSER%
echo %HOST%
echo %DATABASE%
echo %ARQUIVO_DESTINO%

%PGDIR%\pg_dump -h %HOST% -U %PGUSER% %DATABASE% > %ARQUIVO_DESTINO%

REM Compacta o arquivo

"C:\Program Files\7-Zip\7z.exe" a -tzip %ARQUIVO_DESTINO%.zip %ARQUIVO_DESTINO%

REM Copia para os demais discos o backup.

copy %ARQUIVO_DESTINO%.zip "D:\BACKUP\ARPA\BD"
copy %ARQUIVO_DESTINO%.zip "E:\BACKUP\ARPA\BD"

REM Deleta arquivo .Sql

del /s %ARQUIVO_DESTINO%