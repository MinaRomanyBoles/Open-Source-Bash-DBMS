<div align="center">

# 🛢️ OSMDB – Open-Source Bash Database Management System  

![This is an alt text.](https://sdmntprnortheu.oaiusercontent.com/files/00000000-c4f0-61f4-a70d-91e4037d6fed/raw?se=2025-10-04T05%3A11%3A59Z&sp=r&sv=2024-08-04&sr=b&scid=b866a14f-f8df-57fd-a8dd-7dd2ff5ba8d6&skoid=b32d65cd-c8f1-46fb-90df-c208671889d4&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2025-10-04T02%3A07%3A50Z&ske=2025-10-05T02%3A07%3A50Z&sks=b&skv=2024-08-04&sig=bI5Rybzz1ACe1FBRx9QaeQTCN1ySIYzLToCQCX4hF9U%3D "This is a sample image.")</div>

---

<div align="center">
  
  
  A lightweight, menu-driven **Database Management System (DBMS)** built entirely in **Bash scripting**.  
  Manage databases and tables using just your terminal — no external dependencies required!  

  [![Bash Version](https://img.shields.io/badge/Bash-4.0%2B-green.svg)](https://www.gnu.org/software/bash/)
  [![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
  [![Made with](https://img.shields.io/badge/Made%20with-%E2%9D%A4-red)](#)

---

</div>

## 🎯 Overview
This project simulates a **file-based DBMS** using **directories as databases** and **files as tables**.  
It supports all fundamental **CRUD operations** (Create, Read, Update, Delete) and provides a text-based UI with ASCII art for a cleaner user experience.  

It was built as a collaborative project by:  
- **👨🏻‍💻 Mina Romany**  
- **👨🏻‍💻 Sayed El-Banna**
---

## ✨ Features
- 📂 **Database Management**  
  - Create, list, connect, and drop databases  
- 📄 **Table Operations**  
  - Create, list, and drop tables  
  - Insert, select, update, and delete rows  
- 🔑 **Column Handling**  
  - Datatype definition (`int`, `string`, etc.)  
  - Display column headers with datatypes  
- ✅ **Validation**  
  - Prevent invalid database/table names (spaces or special characters)  
- 🎨 **User Interface**  
  - Menu-driven navigation with clear ASCII borders  
  - Centered headers and formatted table views  

---

## 🚀 Getting Started

### 🔹 Prerequisites
- **Bash 4.0+**  
- **Unix-like OS** (Linux, macOS, or WSL on Windows)

### 🔹 Installation
Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/smdb.git
cd smdb 
```
---
### 🔹Give execute permissions.
```
chmod +x main.sh
```
---
### 🔹Run the Project.
```
./main.sh
```
---
📂 Project Structure 
```
OS-Bash-DBMS/
│
├── main.sh              # Entry point (Main Menu)
│
├── utils/
│   └── utils.sh         # Helper functions (validation, formatting, etc.)
│
├── menus/
│   ├── main_menu.sh     # Main menu
│   └── db_menu.sh       # Database menu
│
├── database/
│   └── database.sh      # Database management (create, list, drop)
│
└── tables/
    ├── tables.sh        # Table management
    └── crud.sh          # CRUD operations (insert, select, update, delete)
```
---
# 📸 Screenshots

## 🔹 Main Menu
```
╔════════════════════════╗
╟────── Main Menu ───────╢
╠═══╦════════════════════╣
║ 1 ║ Create Database    ║
║ 2 ║ List Databases     ║
║ 3 ║ Connect To DB      ║
║ 4 ║ Drop Database      ║
║ 5 ║ Exit               ║
╚═══╩════════════════════╝
```

## 🔹 Database Menu
```
╔════════════════════════╗
╟─── ⛁ Database Menu ────╢
╠═══╦════════════════════╣
║ 1 ║ Create Table       ║
║ 2 ║ List Tables        ║
║ 3 ║ Drop Table         ║
║ 4 ║ Insert into Table  ║
║ 5 ║ Select From Table  ║
║ 6 ║ Delete From Table  ║
║ 7 ║ Update Table       ║
║ 8 ║ Back to Main Menu  ║
╚═══╩════════════════════╝
```
---
## 📌 Notes

Each **database** is a folder.

Each **table** is a text file *(CSV-like format)*.

Data is stored in a simple, human-readable structure.

This project is **educational and experimental** not intended for production use.

---
## 🤝 Contributing
Contributions are welcome ❤️ 
Feel free to fork the repo, open issues, or submit pull requests.

---
## 🏷️ License
This project is licensed under the **MIT** License.

---

<div align="center"> Built with ❤️ by <b>Mina Romany</b> & <b>Sayed El-Banna</b> </div> 
