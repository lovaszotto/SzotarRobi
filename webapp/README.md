
# Szótár-Robi Webapp

Ez a projekt egy szótár gyakorló webalkalmazás, amely lehetővé teszi Excel fájlokból származó kérdések gyakorlását, helyes/hibás válaszok statisztikájának követését, valamint hibajelentés küldését emailben.

## Fő funkciók
- **Excel alapú lecke betöltése**: Kérdések és válaszok importálása Excel fájlból.
- **Véletlenszerű kérdés**: Minden alkalommal új, még meg nem válaszolt kérdést kap a felhasználó.
- **Válasz ellenőrzése**: A felhasználó válaszát automatikusan ellenőrzi, visszajelzést ad.
- **Statisztika**: Helyes és hibás válaszok száma, aránya, vizuális (bar chart) megjelenítéssel.
- **Email hibajelentés**: Hibás kérdésről egy kattintással emailt lehet küldeni, amely tartalmazza a kérdés, válasz, példa, kiejtés, megjegyzés, sorszám és fájlnév mezőket.
- **Speciális karakterek paletta**: Külön gombbal elérhető, a fő UI-ból eltávolítva.
- **Időmérés**: A lecke megoldásához eltelt időt mutatja.
- **Szüneteltetés (Pause/Play)**: Az óra előtt egy pause/play ikon található. Szüneteltetéskor az óra megáll, minden interaktív elem inaktívvá válik, play-re folytatódik az időmérés és újra aktív lesz a felület.

## Telepítés és futtatás
1. Másold a projektet egy tetszőleges mappába.
2. Nyisd meg a `webapp/Szotar-Robi.html` fájlt böngészőben.
3. Használathoz nincs szükség szerverre vagy telepítésre.

## Használat
- Kattints a "Lecke betöltése" gombra, és válassz ki egy Excel fájlt.
- A kérdések megválaszolása után a statisztika automatikusan frissül.
- Hibás válasz esetén lehetőség van hibajelentést küldeni emailben.
- A speciális karakterek paletta a ceruza ikonra kattintva érhető el.

## Főbb technológiák
- HTML, CSS, JavaScript
- [Chart.js](https://www.chartjs.org/) a statisztikai diagramhoz

## Verziótörténet
- Email popupban a sorszám mező a fájlnév után jelenik meg.
- A speciális karakterek csoportja eltávolítva a fő UI-ból, külön palettán érhető el.
- Helyes/hibás válaszok vízszintes bar charton jelennek meg, címkék nélkül, vastag vonalakkal.
- A "Kérdés" label dinamikusan mutatja, hányadik kérdést tettük fel.
- Pause/play ikon az óra előtt, szüneteltetéskor minden inaktív, folytatásra visszaáll.
- Pause/play ikon és óra magassága, távolsága egységesítve, UI finomítások.

## Szerző
Lovász Ottó
