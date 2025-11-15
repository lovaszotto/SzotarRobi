@echo off
REM =====================================================
REM  SZOTAR-ROBI - TELEPITO v1.2
REM  Robot Framework alapú szótár gyakorló alkalmazás
REM  Interaktív szókincs fejlesztő rendszer
REM  Port frissítve: 5001 (korábban 5000)
REM =====================================================
setlocal EnableDelayedExpansion

echo.
echo =====================================================
echo   SZOTAR-ROBI TELEPITO v2.0
echo   
echo   Funkcionalitas:
echo   - Interaktiv szotar gyakorlas
echo   - Flask web szerver (Port: 5001)
echo   - Excel lecke fajlok tamogatasa
REM Automatikus telepitesi konyvtar beallitasa: az aktualis folder nevében a DownloadedRobots kifejezést InstalledRobots-ra cseréljük

set "CURDIR=%CD%"
set "TARGET_DIR=%CURDIR%"
echo [INFO] Alapértelmezett telepítési konyvtár: %TARGET_DIR%"

REM Ellenorizzuk a Python megletet es verziot
echo Python verzio ellenorzese...
python --version >nul 2>&1
if errorlevel 1 (
    echo HIBA: Python nincs telepitve vagy nem elerheto a PATH-ban!
    echo.
    echo Megoldasok:
    echo 1. Telepitse a Python 3.8+ verzioit a python.org oldalrol
    echo 2. Vagy hasznaja az Install\python-3.13.7-amd64.exe fajlt
    echo 3. Adja hoza a Python-t a rendszer PATH valtozojához
    echo.
    pause
    exit 1
)

echo Python verzio:
python --version

REM Python verzió ellenőrzés (3.8+ ajánlott)
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo Talalt Python verzio: %PYTHON_VERSION%

echo.
echo Python modullok ellenorzese...
python -c "import sys; print('Python executable:', sys.executable)"
echo.


REM Virtualis kornyezet letrehozasa
echo Virtualis kornyezet letrehozasa...
if not exist ".venv" (
    python -m venv .venv
    if errorlevel 1 (
        echo HIBA: Virtualis kornyezet letrehozasa sikertelen!
        pause
        exit /b 1
    )
    echo Virtualis kornyezet sikeresen letrehozva.
) else (
    echo Virtualis kornyezet mar letezik.
)
echo.

REM Virtualis kornyezet aktivalasa es csomagok telepitese
echo Csomagok telepitese...
REM .venv\Scripts\activate (nem szükséges, pip elérési út miatt)
.venv\Scripts\pip.exe install --upgrade pip
.venv\Scripts\pip.exe install robotframework
.venv\Scripts\pip.exe install flask
.venv\Scripts\pip.exe install openpyxl
.venv\Scripts\pip.exe install pandas

if errorlevel 1 (
    echo HIBA: Csomagok telepitese sikertelen!
    pause
    exit /b 1
)

   
    echo.
    echo =========================================
    echo TELEPITES SIKERES! v1.2
    echo.
    echo Telepitesi hely: %TARGET_DIR%
    echo.
   exit 0
