_as_regex() {
  echo "$1" \
    | sed -E "s/\[(.*)\]/(\1)?/g" \
    | sed -E "s/<${VARIABLE_REGEX}>/${VARIABLE_REGEX}/g"
}

usg::match() {
  local readonly usage="$1"
  local readonly input="$2"
  IFS=$'\n'
  local r
  for p in $usage; do
    r="$(_as_regex "$p")"
    if echo "$input" | grep -Eq "$r"; then
      echo "$p"
      exit 0
    fi
  done
}

usg::vars() {
  local readonly usage="$1"
  echo "$usage" \
    | grep -Eo "[${VARIABLE_CHARS}<>]+" \
    | grep -v "<"
}

_expand_optionals() { 
  awk '{ 
    for (i = 1; i <= NF; ++i) 
      if ($i ~ /^\[/) { 
        $i=substr($i, 2, length($i) - 2); 
        print $0; 
        $i=""; 
        print $0; 
        break; 
      } 
  }' 
}

usg::remove_first_word() {
  awk '{$1=""; print $0}' \
    | str::trim
}

usg::expand_optionals() {
  local usage="$(cat)"
  local tmp="$usage"
  while echo "$tmp" | grep -q "\["; do
    tmp="$(echo "$tmp" | _expand_optionals)"
  done
  echo "$usage" | grep -v "\["
  echo "$tmp" | awk '$1=$1'
}

usg::from_doc() {
  awk '{
    if ($1 ~ /sage/) should_print=1;
    else if (should_print && NF == 0 || $1 ~ /:/) exit;
    else if (should_print) print $0;
  }'
}
