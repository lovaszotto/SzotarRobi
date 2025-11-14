@echo off
REM Szotar-Robi Flask szerver leallito script
REM Ez a script letrehoz egy stop_server.txt fajlt, amely jelzi a Robot Framework-nek,
REM hogy le kell allitania a szervert.

echo.
echo =====================================================
echo         Szotar-Robi Szerver Leallito
echo =====================================================
echo.
echo Ez a script leallitja a futo Szotar-Robi szervert.
echo.

REM Stop fajl letrehozasa
echo STOP > stop_server.txt

echo Stop jelzes elkuldve a szervernek.
echo A szerver hamarosan leal...
exit 0