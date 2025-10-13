@echo off
REM =====================================================
REM  SZOTAR-ROBI - TELEPITO v1.13
REM  Robot Framework alapú szótár gyakorló alkalmazás
REM  Interaktív szókincs fejlesztő rendszer
REM  Port frissítve: 5001 (korábban 5000)
REM =====================================================
setlocal EnableDelayedExpansion

echo.
echo =====================================================
echo   SZOTAR-ROBI TELEPITO v1.13
echo   
echo   Funkcionalitas:
echo   - Interaktiv szotar gyakorlas
echo   - Flask web szerver (Port: 5001)
echo   - Excel lecke fajlok tamogatasa
echo   - Robot Framework automatizalas
echo   - Webapplikacio bongeszoben
echo   - Virtualis kornyezet (.venv) tamogatas
echo =====================================================
echo.

REM Telepitesi konyvtar bekeres
echo Adja meg a telepitesi konyvtar eleresi utjat:
echo (pl: C:\SzotarRobi vagy D:\MyProjects\SzotarRobi)
echo. 
REM Automatikus telepitesi konyvtar beallitasa: az aktualis folder nevében a DownloadedRobots kifejezést InstalledRobots-ra cseréljük
set "CURDIR=%CD%"
set "TARGET_DIR=%CURDIR:DownloadedRobots=InstalledRobots%"
echo [INFO] Alapértelmezett telepítési konyvtár: %TARGET_DIR%

REM Ha nem letezik a konyvtar, hozzuk letre
if not exist "%TARGET_DIR%" (
    echo [INFO] Telepitesi konyvtar letrehozasa: %TARGET_DIR%
    mkdir "%TARGET_DIR%"
)


echo.
echo Telepitesi cel: %TARGET_DIR%
echo.

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
    exit /b 1
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

REM Konyvtar letrehozasa ha nem letezik
if not exist "%TARGET_DIR%" (
    echo Konyvtar letrehozasa: %TARGET_DIR%
    mkdir "%TARGET_DIR%"
    if errorlevel 1 (
        echo HIBA: Nem sikerult letrehozni a konyvtarat!
        pause
        exit /b 1
    )
) else (
    echo Konyvtar mar letezik: %TARGET_DIR%
)

echo.
echo Fajlok masolasa...

REM Szukseges robot fajlok masolasa
copy "main.robot" "%TARGET_DIR%\"
copy "demo.robot" "%TARGET_DIR%\"

REM Flask szerver es web fajlok masolasa
copy "flask_server.py" "%TARGET_DIR%\"
copy "start.bat" "%TARGET_DIR%\"
copy "start_fixed.bat" "%TARGET_DIR%\"
copy "stop_server.bat" "%TARGET_DIR%\"
copy "stop_server_fixed.bat" "%TARGET_DIR%\"

REM Markdown dokumentacio fajlok masolasa
copy "README.md" "%TARGET_DIR%\"
copy "HASZNÁLAT.md" "%TARGET_DIR%\"
copy "ÖSSZEFOGLALÓ.md" "%TARGET_DIR%\"

REM Eredmeny fajlok masolasa (ha leteznek)
if exist "log.html" copy "log.html" "%TARGET_DIR%\"
if exist "output.xml" copy "output.xml" "%TARGET_DIR%\"
if exist "report.html" copy "report.html" "%TARGET_DIR%\"

REM Webapp mappa masolasa (webes alkalmazas)
if exist "webapp" (
    echo Webapp konyvtar masolasa...
    xcopy "webapp" "%TARGET_DIR%\webapp" /E /I /Y
) else (
    echo HIBA: webapp konyvtar nem talalhato!
    echo A Szotar-Robi alkalmazas szukseges a webapp konyvtarat.
    pause
    exit /b 1
)

echo Fajlok sikeresen masolva.

REM Ellenorizzuk es javitsuk a hianyzo fajlokat
echo Hianyzo fajlok ellenorzese es potellepites...

REM Fontos fajlok ellenorzese
if not exist "%TARGET_DIR%\flask_server.py" (
    echo flask_server.py hianyzo, ujra letrehozas...
    copy "flask_server.py" "%TARGET_DIR%\"
)

if not exist "%TARGET_DIR%\main.robot" (
    echo main.robot hianyzo, ujra letrehozas...
    copy "main.robot" "%TARGET_DIR%\"
)

if not exist "%TARGET_DIR%\webapp" (
    echo webapp konyvtar hianyzo, ujra letrehozas...
    xcopy "webapp" "%TARGET_DIR%\webapp" /E /I /Y
)

REM Results konyvtar letrehozasa a Robot Framework eredmenyekhez
if not exist "%TARGET_DIR%\results" (
    echo Results konyvtar letrehozasa...
    mkdir "%TARGET_DIR%\results"
)

echo.

REM Atlepunk a cel konyvtarba
cd /d "%TARGET_DIR%"

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
echo start.bat fajl letrehozasa...

REM Modern start.bat fajl letrehozasa Flask szerver alapon
echo @echo off > start.bat
echo REM Szotar-Robi alkalmazas indito script >> start.bat
echo REM Ez a script kozvetlenul elindija a Flask szervert es megnyitja a bongeszt >> start.bat
echo. >> start.bat
echo echo. >> start.bat
echo echo ===================================================== >> start.bat
echo echo           Szotar-Robi Alkalmazas Indito >> start.bat
echo echo ===================================================== >> start.bat
echo echo. >> start.bat
echo echo Flask szerver inditasa hatterben... >> start.bat
echo echo. >> start.bat
echo. >> start.bat
echo REM Flask szerver inditasa hatterben >> start.bat
echo start "Flask Szerver" "%%~dp0\.venv\Scripts\python.exe" "%%~dp0\flask_server.py" >> start.bat
echo. >> start.bat
echo REM Varakozas a szerver indulasara >> start.bat
echo timeout /t 3 /nobreak ^>nul >> start.bat
echo. >> start.bat
echo echo Szerver elindult: http://localhost:5001 >> start.bat
echo echo Bongeszo megnyitasa... >> start.bat
echo echo. >> start.bat
echo. >> start.bat
echo REM Bongeszo megnyitasa >> start.bat
echo start "" "http://localhost:5001" >> start.bat
echo. >> start.bat
echo echo. >> start.bat
echo echo ===================================================== >> start.bat
echo echo    A Szotar-Robi alkalmazas fut a bongeszoben! >> start.bat
echo echo ===================================================== >> start.bat
echo echo. >> start.bat
echo echo UTASITASOK: >> start.bat
echo echo 1. Hasznalja a megnyilt bongeszt a szotar gyakorlashoz >> start.bat
echo echo 2. Toltse be a kivant lecke fajlt a 'Lecke betoltese' gombbal >> start.bat
echo echo 3. Gyakoroljon kedvere! >> start.bat
echo echo 4. LEALILITAS: Kattintson a 'Kilepes' gombra a weboldalon >> start.bat
echo echo    vagy futtassa a stop_server.bat fajlt >> start.bat
echo echo. >> start.bat
echo echo A szerver a hatterben fut: http://localhost:5001 >> start.bat
echo echo. >> start.bat


echo.
echo =========================================
echo TELEPITES SIKERES! v1.13
echo.
echo Telepitesi hely: %TARGET_DIR%
echo.
echo Telepitett komponensek:
echo - Robot Framework (automatizalasi keretrendszer)
echo - Flask web szerver (Port: 5001)
echo - OpenPyXL (Excel fajlok kezelesere)
echo - Pandas (adatelemzeshez)
echo - Virtualis kornyezet (.venv)
echo - Teljes Szotar-Robi alkalmazas
echo - Web interfesz (webapp\Szotar-Robi.html)
echo - Modern Flask szerver (flask_server.py)
echo - Dokumentacio es futtato scriptok
echo - start.bat futtato script
echo.
echo Hasznalat:
echo 1. AJANLOTT - Flask szerver automatikus inditas:
echo    Menjen a telepitesi konyvtarba: %TARGET_DIR%
echo    Es futtassa: start.bat
echo    (Automatikusan megnyitja a bongeszt a http://localhost:5001 cimen)
echo 2. Manual Flask szerver inditas:
echo    Futtassa: webserver.bat
echo    Majd nyissa meg: http://localhost:5001
echo 3. Robot Framework teszt (fejlett hasznalatra):
echo    Futtassa: .venv\Scripts\robot.exe main.robot
echo 4. Direkt webapp megnyitas (offline):
echo    Nyissa meg bongeszoben: webapp\Szotar-Robi.html
echo.
echo Dokumentacio: 
echo - README.md: Altalanos leiras
echo - HASZNÁLAT.md: Reszletes hasznalati utasitas
echo - ÖSSZEFOGLALÓ.md: Projekt osszefoglalo
echo - Eredmenyek: results\ konyvtar (Robot Framework logok)
echo - Minta leckek: webapp\sample_lessons\ konyvtar
echo.
echo =========================================
echo.
echo webserver.bat fajl letrehozasa webes inditashoz...

REM webserver.bat fajl letrehozasa
echo @echo off > webserver.bat
echo REM ========================================= >> webserver.bat
echo REM  SZOTAR-ROBI - FLASK WEB SZERVER >> webserver.bat
echo REM ========================================= >> webserver.bat
echo echo. >> webserver.bat
echo echo ========================================= >> webserver.bat
echo echo   SZOTAR-ROBI FLASK SZERVER >> webserver.bat
echo echo   Port: 5001 >> webserver.bat
echo echo ========================================= >> webserver.bat
echo echo. >> webserver.bat
echo. >> webserver.bat
echo REM Ellenorizzuk a Flask szerver megletet >> webserver.bat
echo if not exist "flask_server.py" ^( >> webserver.bat
echo     echo HIBA: flask_server.py nem talalhato! >> webserver.bat
echo     pause >> webserver.bat
echo     exit /b 1 >> webserver.bat
echo ^) >> webserver.bat
echo. >> webserver.bat
echo echo Flask szerver inditasa... >> webserver.bat
echo echo Nyissa meg a bongeszoben: http://localhost:5001 >> webserver.bat
echo echo A szerver leallitasahoz nyomja meg a Ctrl+C-t >> webserver.bat
echo echo. >> webserver.bat
echo .venv\Scripts\python.exe flask_server.py >> webserver.bat

REM stop_server.bat fajl letrehozasa
echo.
echo stop_server.bat fajl letrehozasa leallitashoz...
echo @echo off > stop_server.bat
echo REM ========================================= >> stop_server.bat
echo REM  SZOTAR-ROBI SZERVER LEALLITAS >> stop_server.bat
echo REM ========================================= >> stop_server.bat
echo echo. >> stop_server.bat
echo echo Szerver leallitasi jelzes letrehozasa... >> stop_server.bat
echo echo stop > stop_server.txt >> stop_server.bat
echo echo Szerver leallitas jelzes elkuldve. >> stop_server.bat
echo echo A Robot Framework alkalmazas hamarosan leall. >> stop_server.bat
echo pause >> stop_server.bat


