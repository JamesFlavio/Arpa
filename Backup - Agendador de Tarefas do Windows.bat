@echo off

REM Versão: 1.0.0.3
@CHCP 1252 >NUL

REM Muda a cor da fonte para verde
color A

REM Variáveis

SET DIRETORIO01="D:\Backups\Arpa\DB"
SET DIRETORIO02="\\NAS\Backups\Arpa\DB" 

REM Cria os diretórios para backup se não existir.

IF NOT EXIST %DIRETORIO01% MKDIR %DIRETORIO01%
IF NOT EXIST %DIRETORIO02% MKDIR %DIRETORIO02%

REM Altera caracteres de data e hora para caracteres permitidos para nome de arquivos.

for /f "tokens=1,2,3,4 delims=/ " %%a in ('DATE /T') do set Date=%%a-%%b-%%c
for /f "tokens=1,2,3,4 delims=: " %%a in ('time /T') do set time=%%a-%%b

SET PGDIR="C:\Program Files (x86)\arpa\PostgreSQL\bin"
SET HOST=127.0.0.1
SET DATABASE=control
SET PGUSER=postgres
SET ARQUIVO_DESTINO=%DIRETORIO01%\Control%Date%-%time%.sql

echo %PGDIR%
echo %PGUSER%
echo %HOST%
echo %DATABASE%
echo %ARQUIVO_DESTINO%

%PGDIR%\pg_dump -h %HOST% -U %PGUSER% %DATABASE% > %ARQUIVO_DESTINO%

REM Verifica se o aplicativo 7-Zip está instalado.

IF NOT EXIST "C:\Program Files\7-Zip\7z.exe" ECHO "Não foi encontrado o aplicativo 7-Zip instalado, o mesmo é necessário para que o processo seja completamente concluído!"

REM Compacta o arquivo

"C:\Program Files\7-Zip\7z.exe" a -tzip %ARQUIVO_DESTINO%.zip %ARQUIVO_DESTINO%

REM Copia para os demais discos o backup.

copy %ARQUIVO_DESTINO%.zip %DIRETORIO02%

REM Deleta arquivo .Sql

del /s %ARQUIVO_DESTINO%

forfiles -p "%DIRETORIO01%" -d -7 -c "cmd /c del /f /q @path"
forfiles -p "%DIRETORIO02%" -d -7 -c "cmd /c del /f /q @path"
pause