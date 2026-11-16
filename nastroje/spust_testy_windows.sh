#!/bin/bash
# Testy Windows verze kompilatoru pod Wine (Linux): nastroje/spust_testy_windows.sh <pramen-windows.exe>
# Potrebuje: wine, nasm, x86_64-w64-mingw32-gcc
K=$(readlink -f "$1"); export WINEDEBUG=-all
cd "$(dirname "$0")/../testy" || exit 1
TMP=$(mktemp -d); ok=0; bad=0
for t in *.pra; do n=${t%.pra}; o=$TMP/$n
  wine "$K" $t $o --cil=windows --jen-asm > $o.log 2>&1
  nasm -f win64 $o.asm -o $o.obj 2>>$o.log && x86_64-w64-mingw32-gcc $o.obj -o $o.exe 2>>$o.log || { echo "PREKLAD SELHAL $n"; tail -3 $o.log; bad=$((bad+1)); continue; }
  timeout 30 wine $o.exe 2>/dev/null | tr -d '\r' > $o.out; kod=${PIPESTATUS[0]}
  if [ $n = 13_navrat ] && [ $kod != 3 ]; then echo "SPATNY NAVRATOVY KOD $n=$kod"; bad=$((bad+1)); continue; fi
  if diff -q $o.out $n.ok >/dev/null; then ok=$((ok+1)); else echo "CHYBA $n"; diff $o.out $n.ok | head -6; bad=$((bad+1)); fi
done
rm -rf $TMP
echo "=== Windows: uspesne $ok, neuspesne $bad ==="
[ $bad = 0 ]
