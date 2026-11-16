# Pramen

**Pramen** je jednoduchý programovací jazyk s českými klíčovými slovy, který se překládá přímo do strojového kódu (x86-64 a ARM64). Kompilátor je napsaný v Pramenu a překládá sám sebe.

```
Metoda Fib(n) {
    Pokud (n < 2) { Vrat n }
    Vrat Fib(n - 1) + Fib(n - 2)
}

Metoda Hlavni() {
    Vypis "Ahoj ze Pramenu!"
    Vypis Fib(30)
    Vrat 0
}
```

## Rychlý start

1. Nainstalujte assembler a linker: **Windows** NASM + MinGW-w64 (gcc), **Linux** `sudo apt install nasm gcc`, **macOS** `brew install nasm` + `xcode-select --install`.
2. Vezměte hotový kompilátor ze složky `Kompilery/` (`pramen-windows.exe`, `pramen-linux`, `pramen-linux-arm64`).
3. Přeložte a spusťte program:

```
pramen priklady/01_ahoj.pra ahoj
./ahoj
```

Celá příručka jazyka pro začátečníky je v souboru **[DOKUMENTACE.md](DOKUMENTACE.md)**. Co se v této verzi změnilo a proč, popisuje **[ZMENY.md](ZMENY.md)**.

## Co Pramen umí

- celá čísla (64 bitů), desetinná čísla, texty, struktury (i řetězení `a->b->c`), lokální i globální pole, ukazatele;
- `Pokud`/`Jinak`, cykly `Dokud` a `Opakuj`, `Rozcestnik`, metody s rekurzí, `Odloz` pro úklid;
- volání libovolných funkcí knihovny C (`Externi printf`…);
- programy rozdělené do více souborů (`Zahrn`);
- **jádra operačních systémů:** režim bez knihovny C, přístup k registrům zařízení a `Asm`. Ukázky pro x86-64 a ARM64 bootují v QEMU;
- **optimalizátor**, který nikdy nemění význam programu. Proměnné drží v registrech, vkládá malé metody (i rekurzivní) na místo volání, dělí konstantou bez `idiv` a mění koncovou rekurzi na cyklus. Desetinné cykly počítá o třetinu rychleji než `gcc -O3` (vektorizace, výsledek bit po bitu stejný), vnořené cykly asi o 10 % rychleji, síto stejně rychle. Rekurenci typu Fibonacci rozpozná a spočítá cyklem (výsledek stejný, Fib(40) za 1 ms místo 130 ms u gcc). Skutečná rekurzivní volání jsou zatím asi o 15 % pomalejší než u gcc;
- **stejný optimalizátor na x86-64 i ARM64** (Linux, Windows, macOS, jádro OS);
- **kontroly za běhu** s číslem řádku: index mimo pole, přístup přes nulový ukazatel, příliš hluboká rekurze, dělení nulou. Stojí jedno porovnání a jdou vypnout (`--bez-kontrol`).

## Cílové platformy

| `--cil=` | Platforma | Stav |
|---|---|---|
| `linux` | Linux x86-64 | testováno automaticky |
| `windows` | Windows x86-64 | testováno automaticky (pod Wine) |
| `linux-arm` | Linux ARM64 | testováno automaticky (QEMU) |
| `macos` | macOS Intel | ověřen jen překlad do objektu |
| `macos-arm` | macOS Apple Silicon | ověřen jen překlad do objektu |
| `kernel` | jádro OS x86-64 | ukázka bootuje v QEMU |
| `kernel-arm` | jádro OS ARM64 | ukázka bootuje v QEMU |

## Složky

| Složka / soubor | Obsah |
|---|---|
| `DOKUMENTACE.md` | učebnice jazyka od prvního programu po jádro OS |
| `FUNKCE.md` | příručka všech funkcí jazyka a toho, jak fungují uvnitř |
| `zdrojovy_kod.pra` | zdrojový kód kompilátoru (v Pramenu) |
| `Kompilery/` | hotové kompilátory pro Windows, Linux, ARM64 a macOS |
| `priklady/` | ukázkové programy pro začátečníky |
| `os/` | ukázková jádra operačního systému (x86-64 a ARM64) |
| `testy/` | automatické testy jazyka (`*.pra` + očekávaný výstup `*.ok`) |
| `testy_chyby/` | chybné programy, které se nesmí přeložit (a jaká hláška se čeká) |
| `testy_os/` | test, že optimalizátor zachová přístupy k hardwaru |
| `bench/` | měření rychlosti proti gcc |
| `nastroje/` | skripty pro testy a ověření, že se kompilátor přeloží sám sebou |
| `C zdrojový kód/` | původní zavaděč v C (historický, překládá jen starou verzi jazyka) |

## Testy

```
nastroje/spust_testy.sh Kompilery/pramen-linux            # Linux x86-64
nastroje/spust_testy.sh Kompilery/pramen-linux arm        # ARM64 (potřebuje qemu-user)
nastroje/over_pevny_bod.sh Kompilery/pramen-linux         # kompilátor přeloží sám sebe 3x a porovná výstup
testy_chyby/over.sh Kompilery/pramen-linux                # chybné programy dají srozumitelnou hlášku
testy_os/over.sh Kompilery/pramen-linux                   # optimalizátor nerozbije kód pro hardware
nastroje/rozdilovy_test.sh Kompilery/pramen-linux 1 100   # 100 náhodných programů: Pramen vs. gcc
```

## Jak upravit kompilátor

1. Upravte `zdrojovy_kod.pra`.
2. Spusťte `nastroje/over_pevny_bod.sh Kompilery/pramen-linux`. Skript nový kompilátor přeloží, nechá ho přeložit sám sebe a ověří, že stage2 a stage3 jsou shodné.
3. Spusťte testy. Když vše projde, nový kompilátor je v `nastroje/build/s3`.
