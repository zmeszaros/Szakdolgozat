# IntellHouse – Épületvezérlő rendszer

![Language](https://img.shields.io/badge/language-Delphi-red)
![Status](https://img.shields.io/badge/status-legacy%20project-lightgrey)
![Type](https://img.shields.io/badge/type-university%20thesis-blue)
![Platform](https://img.shields.io/badge/platform-Windows-blue)
![Year](https://img.shields.io/badge/year-2004-informational)

> ELTE TTK szakdolgozat – Intelligens épület-felügyeleti és vezérlő rendszer

---

## 📘 Áttekintés

Az **IntellHouse** egy **PC-alapú intelligens épületvezérlő rendszer**,  
amely egy épület vagy épületegyüttes elektromos berendezéseinek:

- tervezését,
- felügyeletét,
- vezérlését,
- és szimulációját

teszi lehetővé egységes programrendszerben.

A projekt **2004-ben készült szakdolgozatként**, és a korabeli
épületautomatizálási, biztonságtechnikai és integrációs igényekre ad választ.

---

## 🧩 Rendszerfelépítés

A megoldás **három különálló alkalmazásból** áll:

### 🛠 Tervező (Designer)
- Épületek egyszerűsített alaprajzának rajzolása
- Objektumok (helyiségek, zónák) definiálása
- Berendezések elhelyezése és strukturálása

### 🎛 Vezérlő (Controller)
- Berendezések valós idejű irányítása
- Állapotfigyelés és eseménykezelés
- Naplózás és riasztási logika

### 🧪 Tesztelő (Tester)
- Fizikai berendezések működésének szimulációja
- Kommunikáció tesztelése külön számítógépről
- Szenzor- és állapotváltozások modellezése

---

## 🔌 Támogatott berendezések

- 🌡 Hőmérők
- 🚨 Riasztók
- 🔥 Tűzjelzők
- ♨️ Fűtőtestek
- ⚙️ Egyéb általános berendezések

---

## 💬 Kommunikáció

- Soros / párhuzamos port alapú adatátvitel
- Egyedi, egyszerű adatkapcsolati protokoll
- Szimulált simplex megáll-és-vár mechanizmus

---

## 🧰 Technológia

- **Nyelv:** Delphi (Object Pascal)
- **Fejlesztőkörnyezet:** Delphi 5 Professional
- **Platform:** Windows (Win9x / ME / 2000 / NT)
- **Architektúra:** asztali alkalmazások
