# 🎓 Szótár-Robi Robot Framework Integráció

## 📋 Összefoglaló

Sikeresen elkészült a **main.robot** fájl, amely egy Flask szerverben elindítja a **webapp/Szotar-Robi.html** alkalmazást, megvárja a felhasználó munkamenetét, majd leállítja a szervert.

## 📁 Létrehozott Fájlok

| Fájl | Leírás |
|------|--------|
| `main.robot` | Fő Robot Framework teszt - elindítja a Flask szervert és a webalkalmazást |
| `demo.robot` | Rövid demo verzió (10 másodpercig fut) |
| `flask_server.py` | Automatikusan generált Flask szerver (futáskor jön létre) |
| `start.bat` | Windows indító script |
| `stop_server.bat` | Szerver leállító script |
| `HASZNÁLAT.md` | Részletes használati útmutató |

## 🚀 Gyors Indítás

### 1️⃣ Egyszerű módszer
```bash
# Dupla kattintás erre a fájlra:
start.bat
```

### 2️⃣ Robot Framework parancs
```bash
robot --task Indítás main.robot
```

### 3️⃣ Rövid demo
```bash
robot demo.robot
```

## ⚙️ Működési Folyamat

1. **Flask szerver létrehozása** - Automatikusan generálja a `flask_server.py` fájlt
2. **Szerver indítása** - Elindítja a Flask szervert a `http://localhost:5000` címen
3. **Böngésző megnyitása** - Automatikusan megnyitja az alapértelmezett böngészőt
4. **Webalkalmazás** - A Szótár-Robi alkalmazás betöltődik és használható
5. **Várakozás** - A Robot Framework vár a felhasználóra
6. **Leállítás** - `stop_server.bat` futtatásával vagy Ctrl+C-vel

## 📚 Funkciók

### Webalkalmazás Funkciók
- ✅ Excel lecke fájlok betöltése
- ✅ Véletlenszerű szókikérdezés
- ✅ Speciális karakterek támogatása (ékezetes betűk)
- ✅ Statisztikák követése
- ✅ Timer funkció
- ✅ Hibajegy küldés e-mailben
- ✅ Minta lecke fájlok

### Robot Framework Funkciók
- ✅ Automatikus Flask szerver kezelés
- ✅ Böngésző integráció
- ✅ Graceful shutdown
- ✅ Hibakezelés
- ✅ Logging és monitoring

## 📊 Excel Fájl Formátum

A lecke fájloknak Excel formátumúnak (.xlsx) kell lenniük a következő oszlopokkal:

| kerdes | valasz | megj1 | megj2 | megj3 |
|--------|--------|-------|-------|-------|
| Kérdés szövege | Helyes válasz | Példa | Kiejtés | Megjegyzés |

## 🛠️ Környezeti Követelmények

- ✅ Python 3.13.7 (virtuális környezet konfigurálva)
- ✅ Flask telepítve
- ✅ Robot Framework telepítve
- ✅ Windows operációs rendszer
- ✅ Modern böngésző (Chrome, Firefox, Edge)

## 🔧 Hibakeresés

Ha problémába ütközik:

1. **Port foglalás**: Ellenőrizze, hogy az 5000-es port szabad-e
2. **Fájlok hiánya**: Győződjön meg róla, hogy a `webapp/Szotar-Robi.html` létezik
3. **Python környezet**: A virtuális környezet aktív legyen
4. **Böngésző**: Manuálisan navigáljon a `http://localhost:5000` címre

## 🎯 Használati Tippek

- A minta lecke fájlok a `webapp/sample_lessons/` könyvtárban találhatók
- Saját Excel fájlokat is feltölthet a megfelelő formátumban
- A "help" szó beírásával megjelenítheti a helyes választ
- Az alkalmazás mentis a statisztikákat és az időt
- Hibák esetén e-mail küldése lehetséges

---

**🎉 Gratulálok! A Szótár-Robi Robot Framework integráció elkészült és használatra kész!**