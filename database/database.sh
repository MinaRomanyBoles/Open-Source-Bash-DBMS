# -------------------------- Database functions --------------------------
create_db() {
  read -p "Enter database name:✎𓂃 " dbname
  if ! is_valid_name "$dbname"; then
    echo ""
    echo "		╔═════════════════════════════════════════════════════════════╗"
    echo "		╟── 🚫 Invalid name! ─ use only letters, digits, underscore ──╢"
    echo "		╚═════════════════════════════════════════════════════════════╝"
    echo ""
    return
  fi
  mkdir -p "$DB_DIR/$dbname"
  echo ""
  echo "		╔════════════════════════════════════════╗"
  printf "                ║ $(center_text " Database '$dbname' created 🎉🥳" 36) ║\n"
  echo "		╚════════════════════════════════════════╝"
  echo ""
}

list_dbs() {
  clear
  echo ""
  echo "╔════════════════════════════════════════╗"
  echo "║            🛢️ List Databases!           ║"
  echo "╠═════╦══════════════════════════════════╣"
  echo "║ ID  ║          Database Name           ║"
  
  i=1
  for db in $(ls "$DB_DIR"); do
    centered=$(center_text "$db" 32)
    echo "╠═════╬══════════════════════════════════╣"
    printf "║ ⛁ %-2s║ %-31s ║\n" "$i" "$centered"
    ((i++))
  done
  echo "╚═════╩══════════════════════════════════╝"
  echo ""
  echo "┌─────────────────────────────────────────────┐"
  echo "│ ➥ [Press Enter] to return to Main Menu 🔁   │"
  echo "├─────────────────────────────────────────────┤"
  echo "│ ➥ [Enter Database Name] to Connect to it 🔌 │"
  echo "└─────────────────────────────────────────────┘"
  read -p "✎𓂃" valu

  if [[ -z "$valu" ]]; then return
  elif ! is_valid_name "$valu"; then
      echo ""
      echo "		╔════════════════════════════╗"
      echo "		╟── 🚫 Invalid name format ──╢"
      echo "		╚════════════════════════════╝"
      sleep 1
      return
  elif [[ -d "$DB_DIR/$valu" ]]; then
      connect_db "$valu"
  else
      echo ""
      echo "		╔═══════════════════════════╗"
      echo "		╟── 🚫 Database Not Found ──╢"
      echo "		╚═══════════════════════════╝"
      echo ""
      sleep 2
      return
  fi
}

connect_db() {
  local dbname=$1
  if [ -z "$dbname" ]; then
    read -p "🛢️ Enter database name ✎𓂃" dbname
  fi
  if ! is_valid_name "$dbname"; then
    echo ""
    echo "		╔═════════════════════════════════════════════════════════════╗"
    echo "		╟── 🚫 Invalid name! ─ use only letters, digits, underscore ──╢"
    echo "		╚═════════════════════════════════════════════════════════════╝"
    echo ""
    return
  fi
  if [ -d "$DB_DIR/$dbname" ]; then
    echo ""
    echo "		╔════════════════════════════════════════╗"
    printf "                ║ $(center_text "Connected to $dbname 🤓👍" 36) ║\n"
    echo "		╚════════════════════════════════════════╝"
    echo ""
    db_menu "$DB_DIR/$dbname"
  else
      echo ""
      echo "		╔═══════════════════════════╗"
      echo "		╟── 🚫 Database Not Found ──╢"
      echo "		╚═══════════════════════════╝"
      echo ""
      sleep 2
      return
  fi
}

drop_db() {
  read -p "Enter database name✎𓂃" dbname
  if ! is_valid_name "$dbname"; then
    echo ""
    echo "		╔═════════════════════════════════════════════════════════════╗"
    echo "		╟── 🚫 Invalid name! ─ use only letters, digits, underscore ──╢"
    echo "		╚═════════════════════════════════════════════════════════════╝"
    echo ""
    return
  fi
  if [[ ! -d "$DB_DIR/$dbname" ]]; then
    echo ""
    echo "		╔═══════════════════════════╗"
    echo "		╟── 🚫 Database Not Found ──╢"
    echo "		╚═══════════════════════════╝"
    echo ""
    return
  fi
  read -p "⚠️ Are you sure you want to delete database '$dbname'? (y/N): " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    rm -r "$DB_DIR/$dbname"
    echo ""
    echo "		╔═════════════════════════════════════════════════╗"
    printf "                ║ $(center_text "❌ Database '$dbname' dropped ❌" 45) ║\n"
    echo "		╚═════════════════════════════════════════════════╝"
    echo ""
  else
    echo "Action cancelled."
  fi
}
