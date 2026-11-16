#!/bin/bash
# Porovnani rychlosti Pramenu s gcc: bench/mer.sh <kompilator Pramenu>
K=$(readlink -f "$1"); cd "$(dirname "$0")"; TMP=$(mktemp -d)
cas() { best=999; for r in 1 2 3 4 5; do s=$(date +%s.%N); "$@" > /dev/null; e=$(date +%s.%N); t=$(echo "$e - $s" | bc); best=$(echo "if ($t < $best) $t else $best" | bc); done; printf "%7.3f s" $best; }
printf "%-8s %10s %10s %10s %10s %10s\n" test Pramen gcc-O0 gcc-O1 gcc-O2 gcc-O3
for b in sito smycky fib plovouci; do
  "$K" $b.pra $TMP/${b}_pra --cil=linux > /dev/null
  for o in 0 1 2 3; do gcc -O$o -o $TMP/${b}_O$o $b.c; done
  printf "%-8s %10s %10s %10s %10s %10s\n" $b "$(cas $TMP/${b}_pra)" "$(cas $TMP/${b}_O0)" "$(cas $TMP/${b}_O1)" "$(cas $TMP/${b}_O2)" "$(cas $TMP/${b}_O3)"
done
rm -rf $TMP
