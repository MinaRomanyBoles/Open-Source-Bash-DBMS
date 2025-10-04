# -------------------------- Database Menu --------------------------
db_menu() {
  local current_db=$1
  while true; do
    echo ""
    echo "		╔═════════════════════════════════════════════════════════════════╗"
    printf "                ║  $(center_text "✨ Menu of (${current_db##*/}) ✨" 60) ║\n"
    echo "		╚═════════════════════════════════════════════════════════════════╝"
    echo ""
    echo "╔════════════════════════╗"
    echo "╟─── ⛁ Database Menu ────╢"
    echo "╠═══╦════════════════════╣"
    echo "║ 1 ║ Create Table       ║"
    echo "╠═══╬════════════════════╣"
    echo "║ 2 ║ List Tables        ║"
    echo "╠═══╬════════════════════╣"
    echo "║ 3 ║ Drop Table         ║"
    echo "╠═══╬════════════════════╣"
    echo "║ 4 ║ Insert into Table  ║"
    echo "╠═══╬════════════════════╣"
    echo "║ 5 ║ Select From Table  ║"
    echo "╠═══╬════════════════════╣"
    echo "║ 6 ║ Delete From Table  ║"
    echo "╠═══╬════════════════════╣"
    echo "║ 7 ║ Update Table       ║"
    echo "╠═══╬════════════════════╣"
    echo "║ 8 ║ Back to Main Menu  ║" 
    echo "╚═══╩════════════════════╝"
    read -p "Enter choice ✎𓂃" choice
    case $choice in
      1) create_table "$current_db" ;;
      2) list_tables "$current_db" ;;
      3) drop_table "$current_db" ;;
      4) insert_into_table "$current_db" ;;
      5) select_from_table "$current_db" ;;
      6) delete_from_table "$current_db" ;;
      7) update_table "$current_db" ;;
      8) break ;;
      *) echo "Invalid choice" ;;
    esac
  done
}

