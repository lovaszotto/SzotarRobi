@echo off
REM Szotar-Robi alkalmazas indito script
REM Ez a script elindija a Robot Framework-ot, amely elindija a Flask szervert es megnyitja a bongeszt

echo.
echo =====================================================
echo           Szotar-Robi Alkalmazas Indito
echo =====================================================
echo.
echo Az alkalmazas inditasa folyamatban...
echo.

REM Robot Framework futtatasa
"%~dp0\.venv\Scripts\python.exe" -m robot --task "Inditas" "%~dp0\main.robot"

echo.
echo Az alkalmazas bezarult.
echo.