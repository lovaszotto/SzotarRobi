# Szótár-Robi Robot Framework Teszt

Ez a Robot Framework teszt elindítja a Szótár-Robi webalkalmazást egy Flask szerveren keresztül.

## Fájlok

- `main.robot` - Fő Robot Framework teszt fájl
- `flask_server.py` - Automatikusan generált Flask szerver (a teszt futtatásakor jön létre)
- `stop_server.bat` - Windows batch fájl a szerver leállításához
- `webapp/` - A webalkalmazás fájljai
  - `Szotar-Robi.html` - Fő alkalmazás
  - `sample_lessons/` - Minta lecke fájlok

## Használat

### 1. Alkalmazás indítása

**Legegyszerűbb módszer:**
Dupla kattintás a `start.bat` fájlra

**Vagy Robot Framework paranccsal:**
```cmd
C:/Users/oLovasz/MyRobotFramework/TestDownloadedRobots/SzotarRobi/Szó-kikérdező/.venv/Scripts/python.exe -m robot --task Indítás main.robot
```

**Vagy rövid demo (10 másodpercig fut):**
```cmd
C:/Users/oLovasz/MyRobotFramework/TestDownloadedRobots/SzotarRobi/Szó-kikérdező/.venv/Scripts/python.exe -m robot demo.robot
```

### 2. Mit csinál a teszt?

1. **Flask szerver létrehozása**: Automatikusan létrehoz egy `flask_server.py` fájlt
2. **Szerver indítása**: Elindítja a Flask szervert a `http://localhost:5000` címen
3. **Böngésző megnyitása**: Megnyitja az alapértelmezett böngészőt a Szótár-Robi alkalmazással
4. **Várakozás**: Vár, amíg a felhasználó befejezi a munkát
5. **Szerver leállítása**: Leállítja a Flask szervert

### 3. Hogyan állítsam le a szervert?

Kétféleképpen:

#### A) stop_server.bat futtatása
Dupla kattintás a `stop_server.bat` fájlra, amely jelzi a Robot Framework-nek, hogy állítsa le a szervert.

#### B) Terminál ablak bezárása
Ha a Robot Framework-öt futtató terminál ablakot bezárja (Ctrl+C), az is leállítja a szervert.

## Funkciók

- **Automatikus szerver indítás/leállítás**
- **Böngésző integráció**
- **Lecke fájlok kiszolgálása**
- **Interaktív használat**
- **Graceful shutdown**

## Követelmények

A következő Python csomagok szükségesek (már telepítve):
- Flask
- robotframework

## Hibakeresés

Ha problémája van:

1. **Ellenőrizze a portot**: Győződjön meg róla, hogy az 5000-es port szabad
2. **Manuális indítás**: Futtassa közvetlenül a `python flask_server.py` parancsot
3. **Böngésző**: Manuálisan navigáljon a `http://localhost:5000` címre
4. **Fájlok**: Ellenőrizze, hogy a `webapp/Szotar-Robi.html` létezik

## Példa használat

```cmd
C:\Users\oLovasz\MyRobotFramework\TestDownloadedRobots\SzotarRobi\Szó-kikérdező> robot main.robot

==============================================================================
Main :: Szótár-Robi alkalmazás indító Robot Framework teszt
==============================================================================
Szótár-Robi Alkalmazás Indítása                                      | PASS |
------------------------------------------------------------------------------
Main :: Szótár-Robi alkalmazás indító Robot Framework teszt         | PASS |
1 test, 1 passed, 0 failed
==============================================================================
```

A böngészőben megnyílik a Szótár-Robi alkalmazás, használhatja kedvére, majd amikor befejezi, futtassa a `stop_server.bat` fájlt vagy zárja be a terminál ablakot.