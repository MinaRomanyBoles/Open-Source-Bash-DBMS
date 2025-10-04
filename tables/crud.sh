# improved insert: preserve spaces inside quoted fields, remove surrounding quotes, keep original formatting/boxes
insert_into_table() {
  local db=$1
  local input
  read -p "Enter insert command (e.g. insin table1:(1,Mina);(2,Ali);) → " input

  tname=$(echo "$input" | awk '{print $2}' | cut -d':' -f1)
  rows=$(echo "$input" | sed -n 's/.*:(\(.*\));/\1/p')

  if [[ ! -f "$db/$tname" ]]; then
    echo ""
    echo "		╔══════════════════════════╗"
    echo "		╟── 🚫 Table not found!  ──╢"
    echo "		╚══════════════════════════╝"
    echo ""
    return
  fi

  # split by semicolons (entries)
  IFS=';' read -ra entries <<< "$rows"
  for entry in "${entries[@]}"; do
    # remove surrounding parentheses and trim
    clean=$(echo "$entry" | sed -e 's/^[[:space:]]*(//' -e 's/)[[:space:]]*$//' )
    clean=$(trim "$clean")
    [[ -z "$clean" ]] && continue

    # now split fields by comma, but remove surrounding quotes for each field and trim inner spaces
    IFS=',' read -ra flds <<< "$clean"
    out=""
    first_field=1
    for fld in "${flds[@]}"; do
      fld=$(trim "$fld")
      # remove surrounding double quotes if present
      if [[ "${fld:0:1}" == "\"" && "${fld: -1}" == "\"" && ${#fld} -ge 2 ]]; then
        fld="${fld:1:${#fld}-2}"
      fi
      # don't strip inner spaces (we keep them)
      if [[ $first_field -eq 1 ]]; then
        out="$fld"
        first_field=0
      else
        out="$out,$fld"
      fi
    done

    # append clean line to table file
    echo "$out" >> "$db/$tname"
  done

  echo "✅ Rows inserted into $tname."
}

select_from_table() {
  local db=$1
  read -p "Enter table name✎𓂃" tname
  if [ ! -f "$db/$tname" ]; then
    echo ""
    echo "		╔══════════════════════════╗"
    echo "		╟── 🚫 Table not found!  ──╢"
    echo "		╚══════════════════════════╝"
    echo ""
    return
  fi

  echo ""
  echo "		╔═════════════════════════════════════════════════╗"
  printf "                ║ $(center_text "📋 Contents of $tname" 46) ║\n"
  echo "		╚═════════════════════════════════════════════════╝"

  header=$(head -n 1 "$db/$tname")
  IFS=',' read -ra cols <<< "$header"
  n=${#cols[@]}

  declare -a widths
  for ((i=0;i<n;i++)); do
    col="${cols[i]}"
    col="${col#"${col%%[![:space:]]*}"}"
    col="${col%"${col##*[![:space:]]}"}"

    name=${col%%:*}
    type=${col##*:}
    title="$name ($type)"
    widths[i]=${#title}
    cols[i]="$title"
  done

  mapfile -t rows < <(tail -n +2 "$db/$tname")
  for line in "${rows[@]}"; do
    [[ -z "$line" ]] && continue
    IFS=',' read -ra fields <<< "$line"
    for ((j=0;j<n;j++)); do
      field="${fields[j]:-}" 
      field="${field#"${field%%[![:space:]]*}"}"
      field="${field%"${field##*[![:space:]]}"}"
      len=${#field}
      if [ ${widths[j]} -lt $len ]; then widths[j]=$len; fi
    done
  done

  for ((i=0;i<n;i++)); do widths[i]=$((widths[i]+2)); done

  repeat() { local c=$1; local num=$2; for _ in $(seq 1 $num); do printf "%s" "$c"; done }

  printf "╔"
  for ((i=0;i < n;i++)); do
    repeat "═" "${widths[i]}"
    if [ $i -lt $((n-1)) ]; then printf "══╦"; else printf "══╗"; fi
  done
  printf "\n"

  printf "║"
  for ((i=0;i<n;i++)); do
    w=${widths[i]}
    printf " %-${w}s " "${cols[i]}"
    printf "║"
  done
  printf "\n"

  printf "╠"
  for ((i=0;i<n;i++)); do
    repeat "═" "${widths[i]}"
    if [ $i -lt $((n-1)) ]; then printf "══╬"; else printf "══╣"; fi
  done
  printf "\n"

  for line in "${rows[@]}"; do
    [[ -z "$line" ]] && continue
    IFS=',' read -ra fields <<< "$line"
    printf "║"
    for ((i=0;i<n;i++)); do
      val="${fields[i]:-}"
      val="${val#"${val%%[![:space:]]*}"}"
      val="${val%"${val##*[![:space:]]}"}"
      w=${widths[i]}
      printf " %-${w}s " "$val"
      printf "║"
    done
    printf "\n"
  done

  printf "╚"
  for ((i=0;i<n;i++)); do
    repeat "═" "${widths[i]}"
    if [ $i -lt $((n-1)) ]; then printf "══╩"; else printf "══╝"; fi
  done
  printf "\n"
}

delete_from_table() {
  local db=$1
  read -p "Enter delete command (e.g. delin table1:1) → " input

  tname=$(echo "$input" | awk '{print $2}' | cut -d':' -f1)
  key=$(echo "$input" | cut -d':' -f2)

  if [[ ! -f "$db/$tname" ]]; then
    echo ""
    echo "		╔══════════════════════════╗"
    echo "		╟── 🚫 Table not found!  ──╢"
    echo "		╚══════════════════════════╝"
    echo ""
    return
  fi

  sed -i "/^$key,/d" "$db/$tname"
  echo "✅ Row with id=$key deleted."
}

update_table() {
  local db=$1
  read -p "Enter update command (e.g. updin table1:1(1,Mina);) → " input

  # extract table name (before ':')
  tname=$(echo "$input" | awk '{print $2}' | cut -d':' -f1)
  # extract key: anything between ':' and '(' (supports non-digit keys too)
  key=$(echo "$input" | sed -n 's/.*:\([^()]*\)(.*/\1/p')
  # extract new row content inside parentheses (between '(' and ')'), without trailing ;
  newrow=$(echo "$input" | sed -n 's/.*(\(.*\));*/\1/p')

  if [[ -z "$tname" || -z "$key" || -z "$newrow" ]]; then
    echo ""
    echo "		╔══════════════════════════════════════╗"
    echo "		╟── 🚫 Invalid update command format ──╢"
    echo "		╚══════════════════════════════════════╝"
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

  # backup file (timestamped)
  bak="$db/${tname}bak$(date +%s)"
  cp "$db/$tname" "$bak"

  # use awk to rewrite file: keep header, replace row where first field == key
  tmp=$(mktemp) || tmp="$db/${tname}.tmp.$$"
  awk -v KEY="$key" -v NEW="$newrow" -F',' 'BEGIN{OFS=","}
    NR==1 { print; next } 
    {
      # trim possible CR
      gsub(/\r$/,"")
      # compare first field exactly (after trimming)
      f=$1
      sub(/^[[:space:]]+/,"",f); sub(/[[:space:]]+$/,"",f)
      if(f==KEY){
        print NEW; found=1
      } else {
        print
      }
    }
    END {
      if(!found) exit 2
    }' "$db/$tname" > "$tmp"
  rc=$?

  if [ $rc -eq 0 ]; then
    mv "$tmp" "$db/$tname"
    echo ""
    echo "		╔════════════════════════════════════╗"
    printf "		║ $(center_text "✅ Row with id=$key updated." 33) ║\n"
    echo "		╚════════════════════════════════════╝"
    echo ""
    echo "Backup saved to: $bak"
  elif [ $rc -eq 2 ]; then
    rm -f "$tmp"
    echo ""
    echo "		╔════════════════════════════════════╗"
    echo "		╟── 🚫 Row with id=$key not found. ──╢"
    echo "		╚════════════════════════════════════╝"
    echo ""
    echo "No changes made. Backup is at: $bak"
  else
    rm -f "$tmp"
    echo ""
    echo "		╔════════════════════════════════════╗"
    echo "		╟── 🚫 Error while updating file!  ──╢"
    echo "		╚════════════════════════════════════╝"
    echo ""
    echo "Backup saved to: $bak"
  fi
}
