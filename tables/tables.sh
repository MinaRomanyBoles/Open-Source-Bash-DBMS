create_table() {
  local db=$1
  read -p "Enter table definition (e.g. table1 {id:int,name:String}) → " definition

  tname=$(echo "$definition" | awk '{print $1}')
  if ! is_valid_name "$tname"; then
    echo ""
    echo "		╔═══════════════════════════════════════════════════════════════════╗"
    echo "		╟── 🚫 Invalid table name! ─ use only letters, digits, underscore ──╢"
    echo "		╚═══════════════════════════════════════════════════════════════════╝"
    echo ""
    return
  fi

  cols=$(echo "$definition" | sed -n 's/.*{\(.*\)}/\1/p' | tr -d ' ')
  if [[ -z "$cols" ]]; then
    echo "🚫 Invalid schema format."
    return
  fi

  if [[ -f "$db/$tname" ]]; then
    echo ""
    echo "		╔═══════════════════════════════╗"
    echo "		╟── 🚫 Table already exists!  ──╢"
    echo "		╚═══════════════════════════════╝"
    echo ""
    return
  fi

  echo "$cols" > "$db/$tname"
  echo ""
  echo "╔══════════════════════════════════════════════════════════════════════════════════╗"
  printf "║ $(center_text "Table '$tname' created with schema [$cols]" 80) ║\n"
  echo "╚══════════════════════════════════════════════════════════════════════════════════╝"
}

list_tables() {
  local db=$1
  clear
  echo ""
  echo "╔════════════════════════════════════════╗"
  printf "║$(center_text "📋 List Tables in ${db##*/}" 39)║\n"
  echo "╠═════╦══════════════════════════════════╣"
  echo "║ ID  ║            Table Name            ║"

  i=1
  for table in $(ls "$db"); do
    centered=$(center_text "$table" 32)
    echo "╠═════╬══════════════════════════════════╣"
    printf "║ 𝄜 %-2s║ %-31s ║\n" "$i" "$centered"
    ((i++))
  done
  echo "╚═════╩══════════════════════════════════╝"
}

drop_table() {
  local db=$1
  read -p "Enter table name✎𓂃" tname
  if ! is_valid_name "$tname"; then
    echo ""
    echo "		╔═══════════════════════════════════════════════════════════════════╗"
    echo "		╟── 🚫 Invalid table name! ─ use only letters, digits, underscore ──╢"
    echo "		╚═══════════════════════════════════════════════════════════════════╝"
    echo ""
    return
  fi
  if [[ ! -f "$db/$tname" ]]; then
    echo ""
    echo "		╔══════════════════════════╗"
    echo "		╟── 🚫 Table not found!  ──╢"
    echo "		╚══════════════════════════╝"
    echo ""
    return
  fi
  read -p "⚠️ Are you sure you want to drop table '$tname'? (y/N): " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    rm "$db/$tname"
    echo "		╔═════════════════════════════════════════════════╗"
    printf "                ║ $(center_text "❌ Table '$tname' dropped. ❌" 45) ║\n"
    echo "		╚═════════════════════════════════════════════════╝"
  else
    echo "Action cancelled."
  fi
}
