*** Settings ***
Documentation    Szótár-Robi alkalmazás indító Robot Framework teszt
...              Ez a teszt elindít egy Flask szervert a webapp kiszolgálásához,
...              megnyitja a böngészőben a Szotar-Robi.html-t,
...              megvárja amíg a felhasználó befejezi a munkát,
...              majd leállítja a szervert.
Library          Process
Library          Collections
Library          OperatingSystem
Library          String

*** Variables ***
${WEBAPP_DIR}       ${CURDIR}${/}webapp
${HTML_FILE}        ${WEBAPP_DIR}${/}Szotar-Robi.html
${FLASK_PORT}       5000
${SERVER_URL}       http://localhost:${FLASK_PORT}
${FLASK_APP}        ${CURDIR}${/}flask_server.py
${PYTHON_EXE}       ${CURDIR}${/}.venv${/}Scripts${/}python.exe



*** Keywords ***
Szerver Script Létrehozása
    [Documentation]    Létrehozza a Flask szerver Python script-jét
    
    ${flask_code}=    Catenate    SEPARATOR=\n
    ...    #!/usr/bin/env python3
    ...    # -*- coding: utf-8 -*-
    ...    """
    ...    Flask szerver a Szótár-Robi webapp kiszolgálásához
    ...    """
    ...    
    ...    from flask import Flask, send_from_directory, send_file
    ...    import os
    ...    import sys
    ...    
    ...    app = Flask(__name__)
    ...    
    ...    # Webapp könyvtár meghatározása
    ...    WEBAPP_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'webapp')
    ...    
    ...    @app.route('/')
    ...    def index():
    ...        """Főoldal - átirányítás a Szotar-Robi.html-re"""
    ...        return send_file(os.path.join(WEBAPP_DIR, 'Szotar-Robi.html'))
    ...    
    ...    @app.route('/<path:filename>')
    ...    def serve_static(filename):
    ...        """Statikus fájlok kiszolgálása a webapp könyvtárból"""
    ...        return send_from_directory(WEBAPP_DIR, filename)
    ...    
    ...    @app.route('/sample_lessons/<path:filename>')
    ...    def serve_lessons(filename):
    ...        """Lecke fájlok kiszolgálása"""
    ...        lessons_dir = os.path.join(WEBAPP_DIR, 'sample_lessons')
    ...        return send_from_directory(lessons_dir, filename)
    ...    
    ...    @app.route('/shutdown', methods=['POST'])
    ...    def shutdown():
    ...        """Szerver leállítás endpoint"""
    ...        from flask import request
    ...        import threading
    ...        import time
    ...        
    ...        def shutdown_server():
    ...            time.sleep(0.5)
    ...            print("Szerver leállítás kérve a weboldalról...")
    ...            import os
    ...            import signal
    ...            try:
    ...                os.kill(os.getpid(), signal.SIGTERM)
    ...            except:
    ...                try:
    ...                    os._exit(0)
    ...                except:
    ...                    import sys
    ...                    sys.exit(0)
    ...        
    ...        threading.Thread(target=shutdown_server, daemon=True).start()
    ...        return 'Szerver leállítás folyamatban... Zárja be a böngészőt.'
    ...    
    ...    if __name__ == '__main__':
    ...        print(f"Szótár-Robi Flask szerver indítása...")
    ...        print(f"Webapp könyvtár: {WEBAPP_DIR}")
    ...        print(f"Elérhető lesz: http://localhost:5000")
    ...        print("A szerver leállításához nyomja meg a Ctrl+C kombinációt")
    ...        
    ...        # Ellenőrizni, hogy létezik-e a webapp könyvtár
    ...        if not os.path.exists(WEBAPP_DIR):
    ...            print(f"HIBA: Webapp könyvtár nem található: {WEBAPP_DIR}")
    ...            sys.exit(1)
    ...            
    ...        # Ellenőrizni, hogy létezik-e a Szotar-Robi.html
    ...        html_file = os.path.join(WEBAPP_DIR, 'Szotar-Robi.html')
    ...        if not os.path.exists(html_file):
    ...            print(f"HIBA: Szotar-Robi.html nem található: {html_file}")
    ...            sys.exit(1)
    ...            
    ...        app.run(host='0.0.0.0', port=5000, debug=True, use_reloader=False)
    
    Create File    ${FLASK_APP}    ${flask_code}
    Log    Flask szerver script létrehozva: ${FLASK_APP}

Browser Megnyitása
    [Documentation]    Megnyitja az alapértelmezett böngészőt (nem Simple Browser) a Szótár-Robi alkalmazással
    
    Log    =========================================================================
    Log    FONTOS: A szerver elindult a ${SERVER_URL} címen
    Log    Alapértelmezett böngésző megnyitása...
    Log    =========================================================================
    
    # Windows-on az 'start' parancs megnyitja az alapértelmezett böngészőt
    Run Process    cmd    /c    start    ${SERVER_URL}
    
    Log    A Szótár-Robi alkalmazás megnyílt az alapértelmezett böngészőben

Felhasználói Munkamenet Várakozás
    [Documentation]    Interaktív várakozás - a felhasználó dönti el, mikor fejezte be
    
    Log    A Szótár-Robi alkalmazás fut az alapértelmezett böngészőben.
    Log    =========================================================================
    Log    UTASÍTÁSOK:
    Log    1. Használja a megnyílt böngészőt a szótár gyakorláshoz
    Log    2. Töltse be a kívánt lecke fájlt a 'Lecke betöltése' gombbal  
    Log    3. Gyakoroljon kedvére a minta fájlokkal vagy saját Excel fájlokkal!
    Log    4. LEÁLLÍTÁS: Amikor befejezi a gyakorlást, futtassa a 'stop_server.bat' fájlt
    Log    5. Vagy nyomja meg a Ctrl+C-t ebben a terminál ablakban
    Log    =========================================================================
    Log    A szerver fut a ${SERVER_URL} címen
    Log    Várunk a leállítási jelzésre...
    
    # Interaktív várakozás a felhasználóra
    WHILE    True
        # Stop fájl ellenőrzése
        ${stop_file}=    Set Variable    ${CURDIR}${/}stop_server.txt
        ${stop_exists}=    Run Keyword And Return Status    File Should Exist    ${stop_file}
        
        IF    ${stop_exists}
            Log    ✓ Stop fájl észlelve, szerver leállítása...
            Remove File    ${stop_file}
            BREAK
        END
        
        # Flask szerver futásának ellenőrzése
        ${server_running}=    Is Process Running    flask_server
        IF    not ${server_running}
            Log    ✗ A Flask szerver leállt, kilépés...
            BREAK
        END
        
        # Várakozás 3 másodpercig, majd újra ellenőrzés
        Sleep    3s
        Log    Szerver státusz: AKTÍV (várunk a stop_server.bat futtatására...)
    END
    
    Log    ✓ Felhasználói munkamenet befejezve

*** Tasks ***
Inditas
    [Documentation]    Alternatív entry point Task-ként
    [Tags]             webapp    main
    
    Log    Szótár-Robi alkalmazás indítása...
    
    # Ellenőrzés, hogy létezik-e a Flask script
    File Should Exist    ${FLASK_APP}    Flask szerver script nem található: ${FLASK_APP}
    
    # Flask szerver indítása háttérben
    ${server_process}=    Start Process    
    ...    python    ${FLASK_APP}
    ...    cwd=${CURDIR}
    ...    alias=flask_server
    
    # Várakozás, hogy a szerver elinduljon
    Log    Várakozás a Flask szerver indulására...
    Sleep    3s
    
    # Ellenőrizni, hogy a szerver fut-e
    ${server_running}=    Is Process Running    flask_server
    IF    ${server_running}
        Log    ✓ Flask szerver sikeresen elindult a ${SERVER_URL} címen
    ELSE
        Log    ⚠️ Flask szerver nem indult el azonnal, de folytatjuk...
    END
    
    # Böngésző megnyitása az alkalmazással
    Browser Megnyitása
    
    # Várakozás a felhasználóra - interaktív mód
    Felhasználói Munkamenet Várakozás
    
    # Szerver leállítása
    Log    Flask szerver leállítása...
    Terminate Process    flask_server
    
    Log    Szótár-Robi alkalmazás sikeresen bezárult