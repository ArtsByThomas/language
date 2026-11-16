#!/bin/bash
# Pouziti: nastroje/spust_testy.sh <kompilator> [arm]
# Prelozi kazdy testy/*.pra, spusti ho a porovna vystup s testy/*.ok
#   arm = prelozit pro Linux ARM64 a spustit v emulatoru (potrebuje aarch64-linux-gnu-gcc a qemu-aarch64)
K=$(readlink -f "$1"); CIL=${2:-linux}
[ -x "$K" ] || { echo "Pouziti: $0 <kompilator> [arm]"; exit 1; }
cd "$(dirname "$0")/../testy" || exit 1
TMP=$(mktemp -d); ok=0; bad=0
for t in *.pra; do
  n=${t%.pra}; out=$TMP/$n
  if [ "$CIL" = arm ]; then
    "$K" $t $out --cil=linux-arm > $out.log 2>&1; RUN="qemu-aarch64 $out"
  else
    "$K" $t $out --cil=linux > $out.log 2>&1; RUN="$out"
  fi
  if [ ! -x $out ]; then echo "PREKLAD SELHAL: $n"; grep -iE "chyba|error" $out.log | head -3; bad=$((bad+1)); continue; fi
  timeout 20 $RUN > $out.out 2>&1; kod=$?
  if [ $n = 13_navrat ] && [ $kod != 3 ]; then echo "SPATNY NAVRATOVY KOD: $n ($kod)"; bad=$((bad+1)); continue; fi
  if diff -q $out.out $n.ok > /dev/null; then ok=$((ok+1)); else echo "CHYBA: $n"; diff $out.out $n.ok | head -8; bad=$((bad+1)); fi
done
rm -rf $TMP
echo "=== Uspesne: $ok, neuspesne: $bad ==="
[ $bad = 0 ]
