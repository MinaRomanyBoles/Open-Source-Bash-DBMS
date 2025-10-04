# -------------------------- Main Menu --------------------------
main_menu() {
  while true; do
    echo "  ꧁⎝ 𓆩༺   SMDB  ༻𓆪 ⎠꧂"
    echo "╔════════════════════════╗"
    echo "╟────── Main Menu ───────╢"
    echo "╠═══╦════════════════════╣"
    echo "║ 1 ║ Create Database    ║"
    echo "╠═══╬════════════════════╣"
    echo "║ 2 ║ List Databases     ║"
    echo "╠═══╬════════════════════╣"
    echo "║ 3 ║ Connect To Database║"
    echo "╠═══╬════════════════════╣"
    echo "║ 4 ║ Drop Database      ║"
    echo "╠═══╬════════════════════╣"
    echo "║ 5 ║ Exit               ║"
    echo "╚═══╩════════════════════╝"
    read -p "Enter choice ✎𓂃 " choice

    case $choice in
      1) create_db ;;
      2) list_dbs ;;
      3) connect_db ;;
      4) drop_db ;;
      5) exit 0 ;;
      *) echo ""
         echo "		╔════════════════════════╗"
         echo "		╟── 🚫Invalid choice!  ──╢"
         echo "		╚════════════════════════╝"
         echo "";;
    esac
  done
}

