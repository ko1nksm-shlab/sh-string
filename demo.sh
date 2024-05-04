#!/bin/sh

. ./string.sh

echo "=== replace_all ==="
replace_all ret "foobarbaz" ba BA
echo "$ret"
echo

echo "=== trim, ltrim, rtrim ==="
trim ret "   abc   "
echo "[$ret]"
ltrim ret "   abc   "
echo "[$ret]"
rtrim ret "   abc   "
echo "[$ret]"
echo

echo "=== trim0 ==="
trim0 ret "000"
echo "$ret"
trim0 ret "000123"
echo "$ret"
echo

echo "=== pad0 ==="
pad0 ret 123 5
echo "$ret"
echo

echo "=== uppercase ==="
uppercase str "abc123DEF"
echo "$str" # => ABC123DEF
echo

echo "=== lowercase ==="
lowercase str "abc123DEF"
echo "$str" # => abc123def

