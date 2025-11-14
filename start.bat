@echo off
REM Szotar-Robi alkalmazas indito script
REM Ez a script kozvetlenul elindija a Flask szervert es megnyitja a bongeszt

echo.
echo =====================================================
echo           Szotar-Robi Alkalmazas Indito
echo =====================================================
echo.
echo Flask szerver inditasa hatterben...
echo.

REM Flask szerver inditasa hatterben
start "Flask Szerver" "%~dp0\.venv\Scripts\python.exe" "%~dp0\flask_server.py"

REM Varakozas a szerver indulasara
timeout /t 3 /nobreak >nul

echo Szerver elindult: http://localhost:5001
echo Bongeszo megnyitasa...
echo.

REM Bongeszo megnyitasa
start "" "http://localhost:5001"

echo.
echo =====================================================
echo    A Szotar-Robi alkalmazas fut a bongeszoben!
echo =====================================================
echo.
echo UTASITASOK:
echo 1. Hasznalja a megnyilt bongeszt a szotar gyakorlashoz
echo 2. Toltse be a kivant lecke fajlt a 'Lecke betoltese' gombbal
echo 3. Gyakoroljon kedvere!
echo 4. LEALILITAS: Kattintson a 'Kilepes' gombra a weboldalon
echo    vagy futtassa a stop_server.bat fajlt
echo.
echo A szerver a hatterben fut: http://localhost:5001
echo.
exit