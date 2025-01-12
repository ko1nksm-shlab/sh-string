replace_all() {
  set -- "$1" "$2" "$3" "$4" "${2#*"$3"}" ""
  until [ "$2" = "$5" ] && eval "$1=\$6\$2"; do
    set -- "$1" "$5" "$3" "$4" "${5#*"$3"}" "$6${2%%"$3"*}$4"
  done
}

trim() {
  set -- "$1" "$2" "${3:-"$IFS"}"
  set -- "$1" "${2#"${2%%[!"$3"]*}"}" "$3"
  set -- "$1" "${2%"${2##*[!"$3"]}"}" "$3"
  eval "$1=\$2"
}

ltrim() {
  set -- "$1" "$2" "${3:-"$IFS"}"
  set -- "$1" "${2#"${2%%[!"$3"]*}"}" "$3"
  eval "$1=\$2"
}

rtrim() {
  set -- "$1" "$2" "${3:-"$IFS"}"
  set -- "$1" "${2%"${2##*[!"$3"]}"}" "$3"
  eval "$1=\$2"
}

trim0() {
  set -- "$1" "${2#"${2%%[!0]*}"}"
  eval "$1=\${2:-0}"
}

pad0() {
  set -- "$1" "$2" $(($3 - ${#2}))
  while [ "$3" -gt 0 ]; do
    set -- "$1" "0$2" $(($3 - 1))
  done
  eval "$1=\$2"
}

generate_translator() {
  echo "$1() {"
  echo '  set -- "$1" "$2" ""'
  echo '  while [ "$2" ]; do'
  echo '    case $2 in'
  shift
  while [ $# -gt 0 ]; do
    echo '      '"$1"'*) set -- "$1" "${2#'"$1"'}" "${3}'"$2"'" ;;'
    shift 2
  done
  echo '      *) set -- "$1" "${2#?}" "$3${2%"${2#?}"}" ;;'
  echo '    esac'
  echo '  done'
  echo '  eval "$1=\$3"'
  echo '}'
}

eval "$(generate_translator uppercase \
  a A b B c C d D e E f F g G h H i I j J k K l L m M \
  n N o O p P q Q r R s S t T u U v V w W x X y Y z Z)"

eval "$(generate_translator lowercase \
  A a B b C c D d E e F f G g H h I i J j K k L l M m \
  N n O o P p Q q R r S s T t U u V v W w X x Y y Z z)"

