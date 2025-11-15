@echo off 
chcp 65001 
REM ========================================= 
REM  SZOTAR-ROBI - FLASK WEB SZERVER 
REM ========================================= 
echo. 
echo ========================================= 
echo   SZOTAR-ROBI FLASK SZERVER 
echo   Port: 5001 
echo ========================================= 
echo. 
 
REM Ellenorizzuk a Flask szerver megletet 
if not exist "flask_server.py" ( 
    echo HIBA: flask_server.py nem talalhato 
    pause 
    exit 1 
) 
 
echo Flask szerver inditasa... 
echo Nyissa meg a bongeszoben: http://localhost:5001 
echo A szerver leallitasahoz nyomja meg a Ctrl+C-t 
echo. 
.venv\Scripts\python.exe flask_server.py 
echo. 
exit 0 
