#!/bin/bash

DB_DIR=~/myDBMS
mkdir -p "$DB_DIR"

# استدعاء الملفات
source utils/utils.sh
source database/database.sh
source tables/tables.sh
source tables/crud.sh
source menus/main_menu.sh
source menus/db_menu.sh

# -------------------------- start --------------------------
main_menu

