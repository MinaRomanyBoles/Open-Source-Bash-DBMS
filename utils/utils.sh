# -------------------------- utilities --------------------------
center_text() {
  text="$1"
  width="$2"
  len=${#text}
  pad=$(( (width - len) / 2 ))
  printf -v result "%*s%s%*s" $pad "" "$text" $((width - len - pad)) ""
  echo "$result"
}

# validate name: only letters, digits, underscore (no spaces, no special chars)
is_valid_name() {
  local name="$1"
  if [[ "$name" =~ ^[a-zA-Z0-9_]+$ ]]; then
    return 0
  else
    return 1
  fi
}

# trim helpers
ltrim() { local s="$1"; echo "${s#"${s%%[![:space:]]*}"}"; }
rtrim() { local s="$1"; echo "${s%"${s##*[![:space:]]}"}"; }
trim()  { local s="$1"; s="${s#"${s%%[![:space:]]*}"}"; s="${s%"${s##*[![:space:]]}"}"; echo "$s"; }

