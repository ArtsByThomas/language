# Fuzzing kompilatoru: nahodne poskozene programy (smazane, zdvojene, prohozene znaky a tokeny).
# Kompilator smi program odmitnout chybovou hlaskou, ale nikdy nesmi spadnout ani se zaseknout.
# Pouziti: python3 fuzz_kompilatoru.py <kompilator> <adresar_s_testy> [pocet] [seed]
import random, subprocess, sys, os, glob, tempfile
K = os.path.abspath(sys.argv[1]); D = sys.argv[2]
N = int(sys.argv[3]) if len(sys.argv) > 3 else 1000
R = random.Random(int(sys.argv[4]) if len(sys.argv) > 4 else 1)
zdroje = [open(f, encoding='utf-8', errors='replace').read() for f in sorted(glob.glob(os.path.join(D, '*.pra')))]
kousky = ['(', ')', '{', '}', '[', ']', '"', '0', '-', '*', '/', '%', '.', ',', ':', '->', 'Vrat ', 'Pokud ', 'Dokud ',
          'Metoda ', 'Lokalni ', 'Float', '9223372036854775807', '1.5', '\n', ' ', 'Pamatuj ', 'Alokuj ', '&&', '!']
T = tempfile.mkdtemp(); pady = 0
for k in range(N):
    s = list(R.choice(zdroje))
    for _ in range(R.randint(1, 6)):
        if not s: break
        i = R.randrange(len(s)); m = R.random()
        if m < 0.3: del s[i:i + R.randint(1, 8)]
        elif m < 0.6: s[i:i] = list(R.choice(kousky))
        elif m < 0.8: j = R.randrange(len(s)); s[i], s[j] = s[j], s[i]
        else: s[i:i] = s[i:i + R.randint(1, 30)]
    p = os.path.join(T, 'f.pra'); open(p, 'w', encoding='utf-8').write(''.join(s))
    try:
        r = subprocess.run([K, p, os.path.join(T, 'f'), '--jen-asm'], capture_output=True, timeout=20)
        if r.returncode < 0 or r.returncode >= 128:
            pady += 1; open(os.path.join(T, f'pad_{k}.pra'), 'w', encoding='utf-8').write(''.join(s))
            print(f'PAD (signal {r.returncode}) -> {T}/pad_{k}.pra')
    except subprocess.TimeoutExpired:
        pady += 1; open(os.path.join(T, f'zaseknuti_{k}.pra'), 'w', encoding='utf-8').write(''.join(s))
        print(f'ZASEKNUTI -> {T}/zaseknuti_{k}.pra')
print(f'=== Fuzzing: {N} poskozenych programu, padu/zaseknuti {pady} ===')
