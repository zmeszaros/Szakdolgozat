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

- Soros / Párhuzamos port alapú adatátvitel
- Egyedi, egyszerű adatkapcsolati protokoll
- Szimulált simplex megáll-és-vár mechanizmus

---

## 🧰 Technológia

- **Nyelv:** Delphi (Object Pascal)
- **Fejlesztőkörnyezet:** Delphi 5 Professional
- **Platform:** Windows (Win9x / ME / 2000 / NT)
- **Architektúra:** asztali alkalmazások

---

## ⚠️ Állapot

Ez a projekt **legacy / archivált állapotú**.

- Nem aktívan karbantartott
- Modern operációs rendszereken módosítás nélkül nem garantáltan fut
- Oktatási, dokumentációs és történeti célokra ajánlott

---

## 🎓 Szerző

**Mészáros Zoltán**  
ELTE Természettudományi Kar  
Programozó matematikus szak  
📅 2004

---

## 📄 Licenc

A projekt **oktatási célból készült**.

Jelenleg nincs hivatalosan meghatározott licenc  
(*educational / archive* jellegű projekt).

---



# English version

---

# IntellHouse – Building Control System

![Language](https://img.shields.io/badge/language-Delphi-red)
![Status](https://img.shields.io/badge/status-legacy%20project-lightgrey)
![Type](https://img.shields.io/badge/type-university%20thesis-blue)
![Platform](https://img.shields.io/badge/platform-Windows-blue)
![Year](https://img.shields.io/badge/year-2004-informational)

> University thesis (ELTE Faculty of Science) – Intelligent building monitoring and control system

---

## 📘 Overview

**IntellHouse** is a **PC-based intelligent building monitoring and control system**
designed to support:

- building layout design,
- device supervision,
- centralized control,
- and device behavior simulation

within a unified software environment.

The project was created as a **university thesis in 2004** and reflects
the architectural, technological, and software engineering approaches
available at that time.

---

## 🧩 System Architecture

The solution consists of **three standalone desktop applications**:

### 🛠 Designer
- Create simplified building floor plans
- Define rooms, zones, and logical objects
- Place and organize controlled devices

### 🎛 Controller
- Control connected devices in real time
- Monitor device states and events
- Handle alarms, rules, and logging

### 🧪 Tester
- Simulate physical devices independently
- Test communication between components
- Model sensor values and state changes

---

## 🔌 Supported Devices

- 🌡 Thermometers
- 🚨 Alarms
- 🔥 Fire detectors
- ♨️ Heaters
- ⚙️ Other general-purpose devices

---

## 💬 Communication

- Serial / Parallel port–based communication
- Custom lightweight communication protocol
- Simplex stop-and-wait message handling

---

## 🧰 Technology Stack

- **Language:** Delphi (Object Pascal)
- **IDE:** Delphi 5 Professional
- **Platform:** Microsoft Windows (Win9x / ME / 2000 / NT)
- **Architecture:** Desktop applications

---

## ⚠️ Project Status

This is a **legacy / archived project**.

- Not actively maintained
- Compatibility with modern operating systems is not guaranteed
- Intended for educational, documentation, and historical reference

---

## 🎓 Author

**Zoltán Mészáros**  
ELTE Faculty of Science  
Programmer Mathematician  
📅 2004

---

## 📄 License

This project was created for **educational purposes**.

No formal license has been specified  
(*educational / archive project*).
