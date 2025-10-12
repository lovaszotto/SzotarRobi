*** Settings ***
Documentation    Egyszerű demo a Szótár-Robi alkalmazáshoz
Library          Process
Library          OperatingSystem

*** Variables ***
${FLASK_APP}    ${CURDIR}${/}flask_server.py
${SERVER_URL}   http://localhost:5000

*** Tasks ***
Demo
    [Documentation]    Rövid demo - elindítja a szervert, megnyitja a böngészőt, majd leállítja
    
    Log    === Szótár-Robi Demo ===
    
    # Flask szerver indítása háttérben
    ${server_process}=    Start Process    
    ...    python    ${FLASK_APP}
    ...    cwd=${CURDIR}
    ...    alias=flask_server
    
    Log    Flask szerver indítása...
    Sleep    3s
    
    # Szerver státusz ellenőrzése
    ${server_running}=    Is Process Running    flask_server
    IF    ${server_running}
        Log    ✓ Flask szerver sikeresen fut a ${SERVER_URL} címen
        
        # Böngésző megnyitása
        Log    Böngésző megnyitása...
        Run Process    cmd    /c    start    ${SERVER_URL}
        
        Log    A Szótár-Robi alkalmazás megnyílt a böngészőben!
        Log    Nézze meg az alkalmazást, majd 10 másodperc múlva automatikusan leáll.
        
        Sleep    10s
    ELSE
        Log    ✗ Hiba: A Flask szerver nem indult el
    END
    
    # Szerver leállítása
    Log    Flask szerver leállítása...
    Terminate Process    flask_server
    
    Log    === Demo befejezve ===