#!/bin/bash
# Rozdilove testovani: nahodne programy v Pramenu + stejne programy v C (gcc je "rozhodci").
# Pouziti: nastroje/rozdilovy_test.sh <kompilator> [od] [do] [arm]
#   Kazdy program se prelozi s optimalizacemi, bez nich a bez kontrol; vystup se musi
#   shodovat s vystupem gcc. S "arm" se navic spousti ARM64 verze v qemu-aarch64.
K=$(readlink -f "$1"); OD=${2:-1}; DO=${3:-100}
GEN=$(readlink -f "$(dirname "$0")/generator_programu.py")
T=$(mktemp -d); cd "$T"; bad=0; n=0
for s in $(seq $OD $DO); do
  python3 "$GEN" $s
  gcc -fwrapv -O0 -w p.c -o pc -lm || continue
  timeout 5 ./pc > c.out || continue
  n=$((n+1))
  for opt in "" "--bez-vkladani --bez-redukce" "--bez-kontrol"; do
    if ! "$K" p.pra pp $opt > log 2>&1; then echo "seed $s: preklad selhal ($opt)"; bad=$((bad+1)); continue; fi
    timeout 5 ./pp > p.out 2>&1
    cmp -s c.out p.out || { echo "seed $s: JINY VYSTUP ($opt) -> $T/chyba_$s.pra"; cp p.pra chyba_$s.pra; bad=$((bad+1)); }
  done
  if [ "$4" = arm ]; then
    "$K" p.pra pa --cil=linux-arm --jen-asm > /dev/null 2>&1 && aarch64-linux-gnu-gcc -static pa.s -o pa 2>/dev/null && timeout 20 qemu-aarch64 ./pa > a.out 2>&1
    # rozhodci pro ARM je gcc pro ARM (napr. NaN bez znamenka je vlastnost procesoru)
    ref=c.out
    if aarch64-linux-gnu-gcc -static -fwrapv -O0 -w p.c -o pca -lm 2>/dev/null && timeout 20 qemu-aarch64 ./pca > ca.out 2>&1; then ref=ca.out; fi
    cmp -s $ref a.out || { echo "seed $s: JINY VYSTUP (ARM64)"; cp p.pra chyba_arm_$s.pra; bad=$((bad+1)); }
  fi
done
echo "=== Rozdilove testy: $n programu, rozdilu $bad ==="
[ $bad -eq 0 ] && rm -rf "$T"
