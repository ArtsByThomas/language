#!/bin/bash
# Overeni, ze se kompilator spravne preklada sam sebou (Linux x86-64).
# Pouziti: nastroje/over_pevny_bod.sh <fungujici_kompilator>
#   stage1 = fungujici_kompilator(zdrojovy_kod.pra)
#   stage2 = stage1(zdrojovy_kod.pra)
#   stage3 = stage2(zdrojovy_kod.pra)
# Assembler stage2 a stage3 musi byt bajt po bajtu stejny. Vysledek: nastroje/build/s3
K=$(readlink -f "$1")
[ -x "$K" ] || { echo "Pouziti: $0 <fungujici_kompilator>"; exit 1; }
D="$(cd "$(dirname "$0")" && pwd)"; Z="$D/../zdrojovy_kod.pra"
mkdir -p "$D/build"; cd "$D/build" || exit 1
for st in s1 s2 s3; do
  rm -f $st $st.asm
  "$K" "$Z" $st --cil=linux > $st.log 2>&1
  [ -x $st ] || { echo "Preklad $st selhal:"; grep -iE "chyba|error" $st.log | head -5; exit 1; }
  echo "$st: OK"
  K=$(readlink -f $st)
done
if cmp -s s2.asm s3.asm; then echo "PEVNY BOD OK: stage2 == stage3 (novy kompilator: nastroje/build/s3)"; else echo "CHYBA: stage2 a stage3 se lisi!"; exit 1; fi
