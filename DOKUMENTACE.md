# Pramen – příručka jazyka

Pramen je jednoduchý programovací jazyk s českými klíčovými slovy. Program v Pramenu se přeloží přímo do strojového kódu procesoru, takže je rychlý a nepotřebuje žádný interpret. Kompilátor Pramenu je sám napsaný v Pramenu.

Příručka je psaná pro úplné začátečníky. Každá část začíná tím nejjednodušším a teprve potom jde do podrobností. Kdo už programuje, může skočit rovnou na [tahák](#tahák) na konci.

---

> **Referenční příručka:** každé klíčové slovo, operátor a vestavěná metoda s popisem, co přesně kompilátor vygeneruje, je v [FUNKCE.md](FUNKCE.md).

## Obsah

1. [První program](#1-první-program)
2. [Jak program přeložit a spustit](#2-jak-program-přeložit-a-spustit)
3. [Jak se Pramen píše](#3-jak-se-pramen-píše)
4. [Proměnné a hodnoty](#4-proměnné-a-hodnoty)
5. [Počítání a operátory](#5-počítání-a-operátory)
6. [Výpis na obrazovku](#6-výpis-na-obrazovku)
7. [Podmínky](#7-podmínky)
8. [Cykly](#8-cykly)
9. [Rozcestník](#9-rozcestník)
10. [Metody (funkce)](#10-metody-funkce)
11. [Pole](#11-pole)
12. [Texty](#12-texty)
13. [Desetinná čísla](#13-desetinná-čísla)
14. [Struktury](#14-struktury)
15. [Paměť a ukazatele](#15-paměť-a-ukazatele)
16. [Konstanty a skupiny](#16-konstanty-a-skupiny)
17. [Odlož – úklid při odchodu z metody](#17-odlož--úklid-při-odchodu-z-metody)
18. [Funkce jazyka C (Externi)](#18-funkce-jazyka-c-externi)
19. [Program ve více souborech (Zahrn)](#19-program-ve-více-souborech-zahrn)
20. [Přístup k hardwaru a vestavěné metody](#20-přístup-k-hardwaru-a-vestavěné-metody)
21. [Assembler uvnitř programu (Asm)](#21-assembler-uvnitř-programu-asm)
22. [Programování operačního systému](#22-programování-operačního-systému)
23. [Optimalizace a co je zaručeno](#23-optimalizace-a-co-je-zaručeno)
24. [Chyby a jak jim rozumět](#24-chyby-a-jak-jim-rozumět)
25. [Omezení jazyka](#25-omezení-jazyka)
26. [Jak kompilátor funguje uvnitř](#26-jak-kompilátor-funguje-uvnitř)
27. [Tahák](#tahák)

---

## 1. První program

Vytvořte soubor `ahoj.pra` s tímto obsahem:

```
Metoda Hlavni() {
    Vypis "Ahoj, svete!"
    Vrat 0
}
```

- `Metoda Hlavni()` je místo, kde program začíná. Každý program ji musí mít.
- `Vypis` vypíše hodnotu na obrazovku a odřádkuje.
- `Vrat 0` ukončí metodu. U metody `Hlavni` je vrácené číslo „návratový kód“ programu (0 = vše v pořádku).
- Složené závorky `{ }` ohraničují tělo metody.

---

## 2. Jak program přeložit a spustit

### Co je potřeba nainstalovat

Kompilátor vyrobí assembler a ten pak přeloží běžné nástroje:

| Systém | Nástroje | Instalace |
|---|---|---|
| Windows | NASM + GCC (MinGW-w64) | např. přes MSYS2: `pacman -S nasm mingw-w64-x86_64-gcc`, obojí musí být v `PATH` |
| Linux (x86-64) | NASM + GCC | `sudo apt install nasm gcc` |
| Linux (ARM64) | GCC (binutils) | `sudo apt install gcc` (na ARM počítači) |
| macOS (Intel) | NASM + Xcode Command Line Tools | `brew install nasm`, `xcode-select --install` |
| macOS (Apple Silicon) | Xcode Command Line Tools | `xcode-select --install` |

Hotové kompilátory jsou ve složce `Kompilery/`:

| Soubor | Pro |
|---|---|
| `pramen-windows.exe` | Windows 64 bit |
| `pramen-linux` | Linux x86-64 |
| `pramen-linux-arm64` | Linux ARM64 (např. Raspberry Pi s 64bitovým systémem) |
| `pramen-macos-x86.o`, `pramen-macos-arm64.o` | macOS – jednou slinkujte: `clang pramen-macos-arm64.o -o pramen` |

### Překlad

```
pramen ahoj.pra ahoj
```

Vznikne spustitelný program `ahoj` (na Windows `ahoj.exe`). Spustíte ho jako každý jiný program: `./ahoj` (Linux, macOS) nebo `ahoj.exe` (Windows).

### Přepínače

| Přepínač | Význam |
|---|---|
| `--cil=linux` | program pro Linux na x86-64 |
| `--cil=windows` | program pro Windows (x86-64) |
| `--cil=macos` | program pro macOS na procesoru Intel |
| `--cil=linux-arm` | program pro Linux na ARM64 |
| `--cil=macos-arm` | program pro macOS na Apple Silicon (M1, M2…) |
| `--cil=kernel` | jádro operačního systému pro x86-64 (bez knihovny C), viz [kap. 22](#22-programování-operačního-systému) |
| `--cil=kernel-arm` | jádro operačního systému pro ARM64 |
| `--jen-asm` | jen vyrobí assembler (`.asm` / `.s`), nepřekládá dál |
| `--podrobne` | vypisuje i ladicí informace kompilátoru (např. které metody vložil a kde zrušil rekurzi) |
| `--bez-kontrol` | vypne kontroly za běhu (meze polí, nulový ukazatel, hloubka rekurze), viz [kap. 24](#24-chyby-a-jak-jim-rozumět) |
| `--bez-vkladani` | nevkládá metody do sebe (inlining); hodí se pro ladění |
| `--bez-redukce` | v cyklech nenahrazuje násobení sčítáním (redukce síly); hodí se pro ladění |
| `--bez-arm-ir` | na ARM64 použije jen jednoduchý generátor (bez optimalizací); hodí se pro ladění |
| `--bez-vektorizace` | nepočítá desetinné cykly po dvou kolech najednou; hodí se pro ladění |
| `--bez-rekurence` | nepočítá rekurenci typu `F(n-1) + F(n-2)` cyklem; hodí se pro ladění a pro měření skutečných volání |
| `--bez-zarovnani` | nezarovnává začátky cyklů na 16 bajtů |
| `--vypis-ir` | vypíše mezikód (IR) každé metody po optimalizacích; pro zvědavé a pro hledání chyb v kompilátoru |

Bez `--cil` se program přeloží pro systém, na kterém kompilátor běží. Jméno výstupu smí obsahovat jen písmena, číslice a znaky `_ - . / \ :`. Je to ochrana před zneužitím, protože jméno se předává příkazové řádce.

> **Ověřeno:** Linux x86-64, Linux ARM64 (v emulátoru QEMU) a Windows (pod Wine) se testují automaticky. Výstup pro macOS se ověřuje jen překladem do objektového souboru, protože na Macu se zatím netestovalo.

---

## 3. Jak se Pramen píše

- **Klíčová slova** se píšou s velkým počátečním písmenem a **bez diakritiky**: `Pokud`, `Jinak`, `Dokud`, `Vrat`, `Lokalni`…
- **Jména** proměnných a metod se skládají z písmen bez diakritiky, číslic a podtržítka a nesmí začínat číslicí: `pocet`, `soucet_bodu`, `x2`. Velikost písmen se rozlišuje (`pocet` a `Pocet` jsou dvě různá jména).
- **Diakritika** je povolená jen uvnitř textů v uvozovkách a v komentářích.
- **Komentáře**: `// do konce řádku` nebo `/* přes víc řádků */`.
- **Středník** `;` je nepovinný. Hodí se, když chcete dát víc příkazů na jeden řádek: `a = 1; b = 2`.

```
// Tohle je komentář
/* Tohle je
   delší komentář */
Lokalni a = 1; Lokalni b = 2
```

---

## 4. Proměnné a hodnoty

Proměnná je pojmenované místo, kam si program ukládá hodnotu.

### Lokální proměnné

Platí jen uvnitř metody (a uvnitř bloku `{ }`, kde vznikly):

```
Lokalni vek = 15
Lokalni jmeno = "Eva"
Lokalni vyska = 1.62
Lokalni nic              // bez hodnoty = 0
vek = vek + 1            // změna hodnoty
vek += 1                 // totéž zkráceně (umí i -=)
```

V jedné metodě nesmí existovat dvě proměnné stejného jména, ani ve vnořeném bloku. Kompilátor to ohlásí jako chybu, protože by to bylo matoucí.

### Globální proměnné

Píšou se mimo metody a vidí je všechny metody:

```
Globalni skore = 0
Globalni pozdrav = "Ahoj"
Globalni pi = 3.14159
Globalni jmeno : String          // zatím bez hodnoty, ale bude to text
```

Počáteční hodnota globální proměnné musí být známá už při překladu: číslo, text, desetinné číslo nebo výpočet z konstant.

**Globální pole** se píše jako lokální, jen s `Globalni`. Je vynulované a vidí ho všechny metody:

```
Konstanta N = 100
Globalni tabulka[N]          // 100 čísel
Globalni mapa[10][20]        // 2D pole
...
tabulka[5] = 42
Vypis Soucet(tabulka, N)     // jméno pole bez indexu = adresa prvního prvku
```

Index se kontroluje stejně jako u lokálních polí.

### Druhy hodnot (typy)

| Typ | Co obsahuje | Příklad |
|---|---|---|
| `Cislo` | celé číslo od −9 223 372 036 854 775 808 do 9 223 372 036 854 775 807 | `42`, `-7`, `0xFF`, `'A'` |
| `Float` | desetinné číslo | `3.14`, `0.5` |
| `String` | text | `"Ahoj"` |
| jméno struktury | ukazatel na strukturu | viz [kap. 14](#14-struktury) |

Typ se určí sám podle počáteční hodnoty, nebo ho napíšete za dvojtečku:

```
Lokalni a = 5              // Cislo
Lokalni b = 2.5            // Float
Lokalni c = "text"         // String
Lokalni d : Float = 1.0    // typ napsaný ručně
```

Typ se určuje **jen při deklaraci**. Pozdější přiřazení ho nezmění.

### Zápis čísel

| Zápis | Hodnota |
|---|---|
| `255` | desítkové číslo |
| `0xFF` | šestnáctkové číslo (255) |
| `'A'` | kód znaku (65) |
| `'\n'` | kód nového řádku (10) |
| `1.5` | desetinné číslo (musí obsahovat tečku) |

---

## 5. Počítání a operátory

```
Lokalni a = 17
Vypis a + 3      // 20
Vypis a - 3      // 14
Vypis a * 3      // 51
Vypis a / 3      // 5   (celočíselné dělení, zaokrouhluje k nule)
Vypis a % 3      // 2   (zbytek po dělení)
Vypis -a         // -17
```

### Porovnání a logika

Porovnání dává `1` (pravda) nebo `0` (nepravda):

| Operátor | Význam |
|---|---|
| `==` `!=` | rovná se, nerovná se |
| `<` `<=` `>` `>=` | menší, menší nebo rovno, … |
| `&&` | a zároveň (pravá strana se vyhodnotí jen když je levá pravdivá) |
| `\|\|` | nebo (pravá strana se vyhodnotí jen když je levá nepravdivá) |
| `!` | negace (`!0` je 1, cokoli jiného dá 0) |

Jako „pravda“ se bere každé číslo kromě nuly.

### Bitové operace

| Operátor | Význam | Příklad |
|---|---|---|
| `&` | bitové A | `12 & 10` = 8 |
| `\|` | bitové NEBO | `12 \| 3` = 15 |
| `^` | bitové XOR | `12 ^ 10` = 6 |
| `<<` | posun doleva | `1 << 4` = 16 |
| `>>` | posun doprava (se znaménkem) | `-16 >> 2` = -4 |

### Priorita (co se počítá dřív)

Od nejvyšší po nejnižší:

1. `-x` `!x` `Alokuj`
2. `*` `/` `%`
3. `+` `-`
4. `<<` `>>`
5. `<` `<=` `>` `>=`
6. `==` `!=`
7. `&`
8. `^`
9. `|`
10. `&&`
11. `||`

Když si nejste jistí, použijte závorky: `(a + b) * c`.

### Přetečení

Celá čísla mají 64 bitů. Když výsledek přeteče, „přetočí se“ (např. největší číslo + 1 = nejmenší číslo). Je to zaručené chování; optimalizátor na něj spoléhá a nikdy z něj nedělá nic jiného.

---

## 6. Výpis na obrazovku

`Vypis` vypíše jednu hodnotu a odřádkuje. Podle typu hodnoty zvolí formát:

```
Vypis 42            // 42
Vypis 2.5           // 2.500000
Vypis "Ahoj"        // Ahoj
Vypis 3 > 2         // 1
```

Pro složitější výpisy (víc hodnot na řádku, počet desetinných míst) použijte funkci `printf` z jazyka C, viz [kap. 18](#18-funkce-jazyka-c-externi):

```
Externi printf
Metoda Hlavni() {
    printf("Mam %d jablek a %.2f korun.\n", 5, 12.5)
}
```

---

## 7. Podmínky

```
Pokud (teplota > 25) {
    Vypis "Je teplo"
} Jinak Pokud (teplota > 10) {
    Vypis "Je prijemne"
} Jinak {
    Vypis "Je zima"
}
```

- Podmínka je vždy v kulatých závorkách.
- Části `Jinak Pokud` a `Jinak` jsou nepovinné.
- Když má větev jediný příkaz, složené závorky můžete vynechat: `Pokud (x < 0) Vrat 0`.

---

## 8. Cykly

### Dokud – opakuj, dokud platí podmínka

```
Lokalni i = 1
Dokud (i <= 5) {
    Vypis i
    i = i + 1
}
```

### Opakuj – cyklus s počítadlem

```
Opakuj (Lokalni i = 0, i < 10, i = i + 1) {
    Vypis i
}
```

Tři části v závorce jsou: *start*, *podmínka* a *krok*. Je to totéž jako:

```
Lokalni i = 0
Dokud (i < 10) {
    Vypis i
    i = i + 1
}
```

### Ukonci a Pokracuj

- `Ukonci` okamžitě opustí cyklus.
- `Pokracuj` přeskočí zbytek těla a pokračuje dalším průchodem (v `Opakuj` se provede i krok).

```
Opakuj (Lokalni i = 1, i <= 100, i = i + 1) {
    Pokud (i % 2 == 0) { Pokracuj }    // sudá přeskočíme
    Pokud (i > 9) { Ukonci }           // a u 9 skončíme
    Vypis i                            // 1 3 5 7 9
}
```

---

## 9. Rozcestník

`Rozcestnik` vybere jednu z cest podle hodnoty. Je to přehlednější než dlouhá řada `Pokud … Jinak Pokud`.

```
Rozcestnik (den) {
    Cesta 1: Vypis "pondeli"
    Cesta 2: Vypis "utery"
    Cesta 6: { Vypis "sobota"; Vypis "vikend!" }
    Hlavni_cesta: Vypis "jiny den"
}
```

- Za `Cesta` musí být celé číslo nebo jméno konstanty.
- Provede se **jen jedna** cesta, z jedné do druhé se nepropadá (na rozdíl od jazyka C).
- `Hlavni_cesta` se provede, když žádná cesta neodpovídá. Je nepovinná.
- `Ukonci` uvnitř rozcestníku ukončí **okolní cyklus**, ne rozcestník.

---

## 10. Metody (funkce)

Metoda je pojmenovaný kus programu, který můžete spouštět opakovaně.

```
Metoda Obsah(sirka, vyska) {
    Vrat sirka * vyska
}

Metoda Hlavni() {
    Vypis Obsah(3, 4)          // 12
    Lokalni o = Obsah(10, 2)
    Vypis o
}
```

- `Vrat hodnota` ukončí metodu a vrátí hodnotu. Metoda bez `Vrat` (nebo s `Vrat` bez hodnoty) vrací 0.
- Metodu zavoláte jménem a závorkami: `Obsah(3, 4)`. Můžete před ni napsat i slovo `Volej` (`Volej Obsah(3, 4)`), význam je stejný.
- Počet argumentů se kontroluje při překladu.
- Metody můžou volat samy sebe (rekurze):

```
Metoda Faktorial(n) {
    Pokud (n <= 1) { Vrat 1 }
    Vrat n * Faktorial(n - 1)
}
```

### Typy parametrů a návratové hodnoty

U parametrů a u metody můžete uvést typ. Je to nutné hlavně u desetinných čísel a struktur:

```
Metoda Prumer(a : Float, b : Float) : Float {
    Vrat (a + b) / 2
}
```

### Pamatuj – metoda, která si pamatuje výsledky

Když metoda jen počítá z jednoho celého čísla (nečte globální proměnné ani paměť, nic nevypisuje a nevolá jiné metody), může si pamatovat výsledky. Každá hodnota se pak počítá jen jednou:

```
Pamatuj Metoda Fib(n) {
    Pokud (n < 2) { Vrat n }
    Vrat Fib(n - 1) + Fib(n - 2)
}
```

- `Fib(35)` se tím zrychlí z ~30 milionů volání na 36. Výsledek je stejný, jen rychleji.
- Pamatují se výsledky pro `n` od 0 do 1023 (tabulka 16 KB v programu). Jiná `n` se počítají normálně.
- Kompilátor ověří, že je metoda opravdu čistá. Když není (čte globální proměnnou, paměť, volá jinou metodu…), ohlásí chybu, protože pamatování by pak mohlo vrátit starý výsledek.

### Metoda jako hodnota

Jméno metody bez závorek je její adresa. Můžete ji uložit do proměnné a pak ji přes proměnnou zavolat:

```
Metoda Dvakrat(x) { Vrat x * 2 }
Metoda Pouzij(f, x) { Vrat f(x) }

Metoda Hlavni() {
    Vypis Pouzij(Dvakrat, 21)     // 42
}
```

### Parametry programu

Globální proměnné `sys_argc` (počet argumentů) a `sys_argv` (adresa pole textů) obsahují parametry z příkazové řádky:

```
Metoda Hlavni() {
    Pokud (sys_argc > 1) {
        Lokalni prvni : String = CtiZAdresu(sys_argv + 8)    // 0. je jméno programu
        Vypis prvni
    }
}
```

---

## 11. Pole

### Lokální pole

```
Lokalni body[5]               // 5 čísel, všechna nastavená na 0
body[0] = 10
body[4] = 7
Vypis body[0] + body[4]       // 17

Lokalni tabulka[3][4]         // 2D pole: 3 řádky, 4 sloupce
tabulka[2][3] = 99
```

- Indexy začínají od 0, tedy pole `body[5]` má prvky `body[0]` až `body[4]`.
- Velikost musí být číslo nebo konstanta (`Lokalni a[MAX]`).
- Jméno pole bez indexu je adresa jeho prvního prvku. Tak ho předáte metodě:

```
Metoda Soucet(pole, pocet) {
    Lokalni s = 0
    Opakuj (Lokalni i = 0, i < pocet, i = i + 1) { s = s + pole[i] }
    Vrat s
}
...
Vypis Soucet(body, 5)
```

### Pole v paměti (dynamické)

Velké pole nebo pole, jehož velikost se zjistí až za běhu, vytvořte pomocí `Alokuj` (počet bajtů = počet prvků × 8):

```
Lokalni n = 1000000
Lokalni p = Alokuj n * 8
p[999999] = 5
Uvolni p
```

> **Lokální pole se kontrolují.** Index mimo pole (`body[5]`, `body[-1]`) zastaví program s hláškou `Chyba za behu (radek N): index mimo meze pole`. Když je index přímo číslo, kompilátor chybu najde už při překladu. Kontrola stojí jedno porovnání.
>
> Paměť z `Alokuj` (`p[i]`) se **nekontroluje**: Pramen neví, kolik paměti jste vyhradili. Zápis mimo ni může poškodit jiná data, stejně jako v jazyce C.

---

## 12. Texty

```
Lokalni a = "Ahoj"
Lokalni b = a + ", svete"            // spojení textů (vznikne nový text)
Vypis b                              // Ahoj, svete
Pokud (a == "Ahoj") { Vypis "ano" }  // porovnání obsahu
```

- `+` mezi dvěma texty je spojí. `==` a `!=` porovnávají obsah textů.
- Text je v paměti řada bajtů zakončená nulou. Jednotlivé znaky čtete pomocí `CtiBajt`:

```
Lokalni t = "Pramen"
Vypis CtiBajt(t)         // 80 (kód písmene P)
Vypis CtiBajt(t + 1)     // 114 (kód písmene r)
```

- `text + číslo` je posun v textu: `t + 2` je text „amen“.
- Další funkce na texty (délka, kopírování, hledání) jsou v knihovně C: `strlen`, `strncpy`, `strstr`… (viz [kap. 18](#18-funkce-jazyka-c-externi)).
- Text v uvozovkách smí mít nejvýš 254 znaků. Speciální znaky se píšou přes zpětné lomítko: `\n` nový řádek, `\t` tabulátor, `\"` uvozovky, `\\` lomítko, `\0` nulový znak, `\r`, `\'`.
- Diakritika v textech funguje (zapisuje se v UTF-8). Windows konzole ji ale nemusí zobrazit správně.

---

## 13. Desetinná čísla

```
Lokalni cena = 12.5
Lokalni kusu = 3
Vypis cena * kusu        // 37.500000 (celé číslo se samo převede)
Vypis cena > 10          // 1
```

- Desetinné číslo se píše s tečkou: `0.5`, ne `,5` ani `.5`.
- Proměnná s typem `Float` musí dostat desetinné číslo: `Lokalni f : Float = 0.0`. Zápis `= 0` je chyba typu a kompilátor poradí, jak to opravit.
- Umí `+ - * /` a porovnání. Operátor `%` ani bitové operace s desetinnými čísly nefungují.
- Když metoda pracuje s desetinnými čísly, uveďte typ u parametrů (`x : Float`) i u výsledku (`: Float`).

---

## 14. Struktury

Struktura spojí několik hodnot do jednoho celku.

```
Struktura Bod {
    x
    y
}

Metoda Hlavni() {
    Lokalni b : Bod = Alokuj Velikost(Bod)    // nová struktura v paměti (vynulovaná)
    b->x = 3
    b->y = 4
    Vypis b->x * b->x + b->y * b->y           // 25
    Uvolni b
}
```

- Každý člen struktury má 8 bajtů. `Velikost(Bod)` vrátí velikost struktury v bajtech (zde 16).
- Proměnná musí mít uvedený typ (`: Bod`), jinak kompilátor neví, kde člen `x` leží.
- K členům se přistupuje šipkou `->`.

### Člen s typem a řetězení `a->b->c`

Když člen ukazuje na jinou strukturu, napište za něj její typ. Pak jde šipky řetězit, číst i zapisovat:

```
Struktura Uzel {
    hodnota
    dalsi : Uzel             // ukazatel na další uzel
}
...
Vypis seznam->dalsi->hodnota
seznam->dalsi->dalsi->hodnota = 30
Lokalni druhy = seznam->dalsi      // druhy má automaticky typ Uzel
```

Bez typu u členu kompilátor neví, kde leží další člen, a ohlásí chybu s radou. Každý krok řetězu má kontrolu nulového ukazatele, takže `a->dalsi->hodnota`, když `a->dalsi` je 0, vypíše srozumitelnou chybu s řádkem.

### Textové pole ve struktuře

Člen se závorkami je místo pro text:

```
Struktura Osoba {
    jmeno[4]        // místo pro text: 4 × 8 = 32 bajtů (max. 31 znaků + nula)
    vek
}
...
Lokalni o : Osoba = Alokuj Velikost(Osoba)
Volej strncpy(o->jmeno, "Pepa", 31)    // zápis textu (funkce z knihovny C)
Vypis o->jmeno                          // Pepa
o->jmeno[0] = 'J'                       // změna jednoho znaku (bajtu)
Vypis o->jmeno                          // Jepa
```

`o->jmeno` je adresa textu (typ `String`), `o->jmeno[i]` je jeden znak (bajt). Index se kontroluje stejně jako u lokálních polí: `o->jmeno[32]` je u `jmeno[4]` chyba (32 bajtů má indexy 0 až 31).

Když je proměnná struktury nula (například po `Uvolni`), přístup `o->vek` neshodí program. Vypíše `Chyba za behu (radek N): pristup pres nulovy ukazatel` a skončí.

---

## 15. Paměť a ukazatele

Každá hodnota v Pramenu má 64 bitů, takže proměnná může obsahovat i adresu v paměti (ukazatel).

| Příkaz | Význam |
|---|---|
| `Alokuj n` | vyhradí `n` bajtů vynulované paměti a vrátí jejich adresu. Když paměť dojde, program skončí s chybou. |
| `Uvolni p` | vrátí paměť systému a nastaví proměnnou `p` na 0, takže omylem uvolněná podruhé nic nerozbije |
| `p[i]` | 8bajtová hodnota na adrese `p + i*8` |
| `CtiZAdresu(a)` | přečte 8 bajtů z adresy `a` |
| `ZapisNaAdresu(a, h)` | zapíše 8 bajtů na adresu `a` |
| `CtiBajt(a)`, `ZapisBajt(a, h)` | jeden bajt |
| `Cti32(a)`, `Zapis32(a, h)` | 4 bajty |

`Alokuj` bere celý výraz za sebou: `Alokuj n * 8` vyhradí `n*8` bajtů.

> Adresová aritmetika je v bajtech: `p + 8` je adresa o 8 bajtů dál (tedy `p[1]`).

---

## 16. Konstanty a skupiny

**Konstanta** je pojmenovaná hodnota, která se nemění. Kompilátor ji dosadí přímo do kódu:

```
Konstanta MAX_HRACU = 4
Konstanta VELIKOST = MAX_HRACU * 8
Konstanta MASKA = 0xF0 | 0x0F
Konstanta ZAPORNA = -1
```

**Skupina** očísluje řadu konstant (0, 1, 2, … nebo od zadaného čísla):

```
Skupina Barva { Cervena, Zelena, Modra = 10, Zluta }
// Cervena = 0, Zelena = 1, Modra = 10, Zluta = 11
```

---

## 17. Odlož – úklid při odchodu z metody

`Odloz prikaz` zařídí, že se příkaz provede až při odchodu z metody, ať odchází jakýmkoli `Vrat`. Hodí se na úklid (zavření souboru, uvolnění paměti):

```
Metoda Zpracuj(jmeno) {
    Lokalni f = fopen(jmeno, "r")
    Pokud (f == 0) { Vrat 0 }
    Odloz fclose(f)           // zavře se vždy, ať skončíme kdekoli níž
    ...
    Pokud (chyba) { Vrat 0 }  // tady se soubor zavře
    ...
    Vrat 1                    // i tady
}
```

- Víc odložených příkazů se provede v opačném pořadí (poslední odložený jako první).
- `Odloz` smí stát jen přímo v těle metody, ne uvnitř `Pokud` nebo cyklu. Tím je zaručeno, že se provede jen to, k čemu program opravdu došel.

---

## 18. Funkce jazyka C (Externi)

Pramen může volat funkce ze standardní knihovny jazyka C. Funkci stačí ohlásit slovem `Externi`:

```
Externi printf
Externi strlen
Externi rand

Metoda Hlavni() {
    printf("Delka: %d\n", strlen("Pramen"))
    Vypis rand() % 6 + 1          // hod kostkou
}
```

Užitečné funkce:

| Oblast | Funkce |
|---|---|
| výpis a čtení | `printf`, `puts`, `scanf`, `fgets`, `getchar` |
| texty | `strlen`, `strcmp`, `strncpy`, `strstr`, `sprintf`, `atoi` |
| soubory | `fopen`, `fclose`, `fputs`, `fgets`, `fread`, `fwrite` |
| matematika (celá čísla) | `abs`, `rand`, `srand`, `time` |
| paměť | `malloc`, `calloc`, `realloc`, `free`, `memcpy`, `memset` |

Pravidla:

- Celá čísla, adresy a texty se předávají normálně. Desetinná čísla (`Float`) se do funkcí jako `printf` předají správně.
- Výsledek funkce se bere jako 64bitové celé číslo. U funkcí, které vrací 32bitový `int` (`strcmp`, `fgetc`, `printf`, `atoi`…), kompilátor výsledek správně rozšíří, takže třeba `-1` z `fgetc` je opravdu `-1`.
- Funkce, které **vrací** desetinné číslo, se deklarují s typem:

```
Externi sqrt : Float
Externi pow : Float
...
Lokalni f : Float = sqrt(2.0)     // 1.414214
Vypis pow(2.0, 10.0)              // 1024.000000
```

Na Linuxu se k programu automaticky připojí matematická knihovna (`-lm`).
- Pro funkce, které zapisují do proměnné (`scanf`), použijte paměť z `Alokuj`:

```
Externi scanf
Lokalni misto = Alokuj 8
scanf("%lld", misto)
Lokalni cislo = CtiZAdresu(misto)
```

---

## 19. Program ve více souborech (Zahrn)

```
Zahrn "knihovna/matematika.pra"

Metoda Hlavni() {
    Vypis Nsd(84, 36)
}
```

- `Zahrn` vloží obsah jiného souboru, jako by byl napsaný na tomto místě.
- Cesta se bere vůči složce, ze které spouštíte kompilátor.
- Každý soubor se vloží jen jednou, i když ho `Zahrn` uvádí víckrát.

---

## 20. Přístup k hardwaru a vestavěné metody

Vestavěné metody se překládají přímo na jednu instrukci procesoru:

| Metoda | Co dělá |
|---|---|
| `CtiBajt(adresa)` | přečte 1 bajt (0–255) |
| `Cti32(adresa)` | přečte 4 bajty (0 – 4 294 967 295) |
| `CtiZAdresu(adresa)` | přečte 8 bajtů |
| `ZapisBajt(adresa, hodnota)` | zapíše 1 bajt |
| `Zapis32(adresa, hodnota)` | zapíše 4 bajty |
| `ZapisNaAdresu(adresa, hodnota)` | zapíše 8 bajtů |
| `Bariera()` | paměťová bariéra (`mfence` / `dmb sy`): všechny dřívější přístupy do paměti se dokončí před pozdějšími |

**Záruka:** optimalizátor tyto přístupy nikdy nevynechá, nespojí ani nepřehází. Fungují proto i pro registry zařízení (MMIO), kde i „zbytečné“ čtení nebo dvojitý zápis něco znamená. Tuhle záruku hlídá automatický test `testy_os/over.sh`.

Jména `CtiBajt`, `Cti32`, `ZapisBajt`, `Zapis32`, `ZapisNaAdresu` a `Bariera` jsou vyhrazená.

---

## 21. Assembler uvnitř programu (Asm)

Pro věci, které jazyk neumí (instrukce `in`/`out`, přerušení…), můžete vložit instrukci procesoru:

```
Asm "x86:out dx, al"          // jen při překladu pro x86-64
Asm "arm:wfi"                 // jen při překladu pro ARM64
Asm "nop"                     // pro všechny procesory
```

Pravidla pro metodu, která obsahuje `Asm`:

- Všechny parametry a lokální proměnné té metody zůstanou **v paměti** na pevných místech:
  - **x86-64:** 1. parametr na `[rbp+16]`, 2. na `[rbp+24]`, …; 1. lokální proměnná na `[rbp-8]`, 2. na `[rbp-16]`, …
  - **ARM64:** 1. parametr na `[x29, #16]`, 2. na `[x29, #24]`, …; 1. lokální proměnná na `[x29, #-8]`, …
- Optimalizátor v takové metodě nedosazuje konstanty a uloží všechny registry, které by `Asm` mohl změnit.
- Výsledek předáte tak, že ho `Asm` uloží do lokální proměnné a metoda ji vrátí přes `Vrat`:

```
Metoda PortCti(port) {
    Lokalni hodnota = 0
    Asm "x86:mov rdx, [rbp+16]"      // port (1. parametr)
    Asm "x86:xor eax, eax"
    Asm "x86:in al, dx"
    Asm "x86:mov [rbp-8], rax"       // do proměnné hodnota
    Vrat hodnota
}
```

---

## 22. Programování operačního systému

Pramen umí přeložit program, který běží přímo na procesoru, bez operačního systému: jádro OS.

```
pramen jadro.pra jadro --cil=kernel-arm     // ARM64
pramen jadro.pra jadro --cil=kernel         // x86-64
```

V režimu jádra:

- Program začíná v `_start`, který nastaví zásobník (64 KiB) a zavolá `Hlavni`. Když se `Hlavni` vrátí, procesor se zastaví.
- **Není k dispozici knihovna C**, takže nefunguje `Vypis`, `Alokuj`, `Uvolni` ani spojování textů (kompilátor ohlásí chybu). Texty v uvozovkách, struktury, pole, metody a všechno ostatní fungují.
- S hardwarem se pracuje vestavěnými metodami z [kap. 20](#20-přístup-k-hardwaru-a-vestavěné-metody) a příkazem `Asm`.
- Optimalizátor v režimu jádra nikdy neodstraní čekací smyčku (`Dokud (i < 1000000) { i = i + 1 }`), protože v jádře může jít o záměrné čekání.

### Ukázková jádra

Ve složce `os/` jsou dvě funkční jádra, která v emulátoru QEMU vypíšou text na sériovou linku:

**ARM64** (počítač „virt“):

```
cd os
./spust_arm.sh
# nebo ručně:
pramen jadro_arm.pra jadro --cil=kernel-arm
qemu-system-aarch64 -M virt -cpu cortex-a53 -nographic -kernel jadro.elf
```

**x86-64** (PC): jádro potřebuje krátký zavaděč `start32.asm`, který přepne procesor z 32bitového režimu (tak ho spustí Multiboot / GRUB / QEMU) do 64bitového:

```
cd os
./spust_x86.sh
```

Obě jádra ukazují zápis do registrů zařízení, čekání na hardware, výpis čísel bez knihovny a vypnutí počítače.

---

## 23. Optimalizace a co je zaručeno

Kompilátor optimalizuje automaticky a zapínat nic nemusíte.

### Co optimalizátor dělá

**Na úrovni stromu programu:**
- skládá konstanty (`3 * 4` → `12`, `x * 1` → `x`, `x * 8` → posun);
- dosazuje známé hodnoty proměnných (GCP);
- vkládá krátké metody bez parametrů přímo do kódu;
- odstraňuje kód za `Vrat`/`Ukonci`;
- jednou spočítá stejný výpočet ve dvou po sobě jdoucích přiřazeních (CSE);
- přepočítá jednoduché sčítací cykly na vzorec (SCEV);
- rozbalí krátké cykly `Opakuj`.

**V generátoru x86-64:**
- převádí program na mezikód (IR), sestavuje graf řízení (CFG) a analyzuje živost proměnných;
- drží proměnné v registrech procesoru, ty v cyklech přednostně (Linear Scan s váhami). Alokátor zná přesné **úseky života** každé hodnoty, i s „dírami“: dvě hodnoty smí sdílet registr, když nejsou živé současně, i když se jejich rozsahy v kódu prolínají. Když registry dojdou, odloží do paměti hodnoty, jejichž součet vah je nejmenší;
- slučuje porovnání se skokem (`cmp` + `jl`);
- dělí konstantou bez pomalé instrukce `idiv`;
- mění koncovou rekurzi na cyklus (`Vrat n * Faktorial(n - 1)` nespotřebuje zásobník);
- **vkládá malé metody i s parametry** přímo na místo volání (inlining). Parametry a lokální proměnné vložené metody dostanou vlastní registry, `Vrat` se změní na skok za vložený kód. Rekurzivní metodu (třeba `Fib`) vloží sama do sebe až třikrát. Každá vložená úroveň má vlastní eliminaci koncové rekurze, takže z `Fib` vzniknou do sebe vnořené cykly a skutečných volání je mnohem méně. Větev typu `Pokud (n < 2) { Vrat n }` přesune za hlavní cestu, aby výsledek nezabíral registr zbytečně dlouho;
- metoda, která nic nemá v paměti, se obejde bez rámce (`push rbp`…) a registr `rbp` použije pro proměnné;
- volání mezi metodami Pramenu je levnější: bez 32bajtové „domovské oblasti“ (tu potřebuje jen Windows a metody s `Asm`) a bez `xor eax, eax` (ten potřebují jen funkce C s proměnným počtem argumentů);
- hodnotu, kterou hned čte argument volání nebo `Vrat`, spočítá rovnou do správného registru (`lea rdi, [rbx - 1]` místo tří instrukcí);
- **redukce síly v cyklech:** když se v cyklu `j` mění jen příkazem `j = j + K` a `i` vůbec, součin `i * j` se nepočítá znovu. Před cyklem se spočítá jednou a pak se při každém kroku `j` přičte `i * K`. Přetečení se „přetáčí“ stejně, takže výsledek je vždy totožný;
- dělení konstantou bere dělence přímo z registru proměnné a zbytek zapíše rovnou do cíle;
- **rozsahy hodnot:** v cyklu `Dokud (j < N)`, kde se `j` jen zvětšuje a začíná na nezáporném čísle, ví kompilátor, že `0 <= j <= N`. Z toho dopočítá rozsahy výrazů (`i * j`, `i ^ j`, `x % 7` …). Když je dělenec určitě nezáporný, dělí konstantou bez opravy pro záporná čísla (o 3 instrukce méně; gcc tu opravu dělá vždy) a index pole s dokázaným rozsahem nekontroluje. Bezpečnost tak v typických cyklech nic nestojí;
- metody Pramenu, které (ani nic, co volají) nevolají funkce C, si při vzájemném volání nezarovnávají zásobník;
- **rotace cyklů:** cyklus „test nahoře, skok zpět dole“ (typicky z koncové rekurze) dostane test i na konec, takže každé kolo má jediný skok;
- výsledek volání se použije přímo z `rax` (`add r14, rax`) bez kopie;
- **vektorizace desetinných cyklů:** cyklus typu `Dokud (i < n) { x = …; s = s + …; i = i + 1 }`, který obsahuje jen desetinné výpočty, počítá dvě kola najednou: jedna instrukce `divpd`/`mulpd`/`addpd` zpracuje dvojici hodnot. Součet `s` se přičítá po jednom prvku ve stejném pořadí jako bez vektorizace, takže výsledek je **bit po bitu stejný**. gcc tohle bez `-ffast-math` nedělá a cyklus nechá po jednom. Lichý zbytek dopočítá původní cyklus. Jen na x86-64 (na Windows jen malé cykly, protože tam smí metoda volně používat jen 6 registrů `xmm`). Vypnout jde přepínačem `--bez-vektorizace`;
- **částečné vkládání:** začíná-li větší metoda příkazem `Pokud (podmínka) { Vrat výraz }`, kde podmínka i výraz čtou jen parametry, vyhodnotí se tahle rychlá cesta už na místě volání. Skutečné volání proběhne, jen když podmínka neplatí. Netýká se rekurzivních volání metody samé do sebe; tam to měřením vycházelo pomaleji;
- **rekurence → cyklus:** čistá metoda tvaru `Pokud (n < K) { Vrat E(n) }` a pak `Vrat F(n - 1) OP F(n - 2)` (OP je `+ - * & | ^`, E čte jen `n`) se spočítá cyklem: napřed `F(K-2)` a `F(K-1)` ze základního případu, pak se opakovaně počítá další hodnota ze dvou předchozích. Celá čísla se přetáčejí stejně, takže výsledek je bit po bitu stejný, jen místo exponenciálně mnoha volání stačí `n` kol. gcc ani clang to nedělají. **Mění to složitost algoritmu**, proto ve výsledcích uvádím i čas skutečné rekurze (`--bez-rekurence`). Mez `K` zatím musí být nezáporné číslo, jinak zůstane rekurze;
- **rychlý vstup:** začíná-li metoda testem parametru proti číslu nebo jinému parametru a vrací parametr, číslo nebo parametr ± číslo (`Pokud (m == 0) { Vrat n + 1 }`), provede se test ještě před prologem. Když platí, metoda skončí `ret` bez rámce a ukládání registrů. Test se dělá tak jako tak, jen dřív;
- začátky cyklů, na které se skáče zpět, zarovná na 16 bajtů (jako gcc), pokud před nimi je nepodmíněný skok, takže výplň se nikdy neprovádí;
- výsledek volání nebo dělení může sdílet registr, který volání přepisuje, i když hodnota žije ve více úsecích (dřív zbytečně zabírala registr, který musí metoda ukládat);
- `p[i] = h` je jediná instrukce `mov [p + i*8], h`;
- odstraňuje nedosažitelný kód za skokem;
- ukládá jen ty registry, které metoda opravdu používá.

Vkládání se nikdy netýká metod s `Asm`, `Odloz` nebo lokálními poli, metody `Hlavni` a metod s desetinným výsledkem. Vypnout jde přepínačem `--bez-vkladani`.

### Rychlost

Měřeno na Linuxu x86-64, nejlepší z 5 běhů (složka `bench/`, programy v Pramenu i v C, skript `bench/mer.sh`). Pramen je přeložený se zapnutými kontrolami za běhu:

| Test | Pramen | gcc -O0 | gcc -O1 | gcc -O2 | gcc -O3 |
|---|---|---|---|---|---|
| Eratosthenovo síto do 20 milionů | 0,28 s | 0,41 | 0,30 | 0,27 | 0,28 |
| vnořené cykly s násobením a `%` | **0,22 s** | 0,56 | 0,31 | 0,25 | 0,24–0,25 |
| Fibonacci(40) | **0,001 s** (rekurence → cyklus) | 0,687 | 0,512 | 0,142 | 0,129–0,142 |
| … skutečná rekurze (`--bez-rekurence`) | 0,150–0,166 s | – | – | – | 0,129–0,142 |
| … s `Pamatuj Metoda Fib` | **0,002 s** | – | – | – | – |
| desetinná čísla: π integrací (50 mil. kroků) | **0,037–0,039 s** | 0,108 | 0,055 | 0,056 | 0,056–0,057 |

Časy kolísají podle zatížení počítače asi o ±10 % (síto, které jen čte a zapisuje paměť, i víc). Desetinná čísla počítá Pramen o třetinu rychleji než `gcc -O3` díky vektorizaci se zachovaným pořadím sčítání. Vnořené cykly zvládá asi o 10 % rychleji. Síto je stejně rychlé, rozhoduje rychlost paměti. Fibonacciho Pramen rozpozná jako rekurenci a spočítá cyklem (výsledek je stejný, algoritmus jiný). Když se ale opravdu volá rekurzivně (`--bez-rekurence`, nebo metoda jiného tvaru), je `gcc -O2/-O3` stále asi o 15 % rychlejší. Obě verze provedou podobně instrukcí, ale gcc volá funkci méně často a vnější úrovně drží v registrech. Fibonacci se dřív měřil pro 35, jenže tak krátký běh (14 ms) zkresluje start programu. 

**ARM64** má od verze 5 stejný optimalizátor jako x86-64. Měřeno v emulátoru `qemu-aarch64` (nejlepší ze 3 běhů; emulátor zkresluje absolutní časy, poměry jsou orientační), gcc je `aarch64-linux-gnu-gcc`:

| Test | Pramen v4 (ARM) | Pramen v5 (ARM) | gcc -O0 | gcc -O2 | gcc -O3 |
|---|---|---|---|---|---|
| síto do 20 milionů | 1,57 s | 0,75 s | 1,08 | 0,68 | 0,73 |
| vnořené cykly s `%` | 4,40 s | 0,73 s | 1,84 | 0,77 | 0,72 |
| Fibonacci(35) | 0,51 s | 0,16 s | 0,33 | 0,11 | 0,11 |
| π integrací (desetinná čísla) | 1,96 s | 1,18 s | 1,51 | – | 1,09 |

Na skutečném procesoru ARM (Apple M1, Raspberry Pi) se zatím neměřilo.

### Záruky (důležité pro operační systémy)

Optimalizátor **nikdy nezmění význam programu**. Konkrétně:

1. **Přístupy k paměti přes vestavěné metody** (`Cti32`, `ZapisBajt`, `CtiZAdresu`…) se nikdy nevynechají, nespojí ani nepřehází.
2. **`Asm` je bariéra:** v metodě s `Asm` zůstávají proměnné v paměti na dokumentovaných místech a nic se přes ni nepřesouvá.
3. **Přetečení celých čísel** se vždy „přetočí“. Optimalizátor z něj nikdy nevyvozuje, že „nemůže nastat“, jako to dělají kompilátory jazyka C.
4. **Cykly v jádře OS** se nikdy neodstraní, i když „nic nedělají“.
5. **Volání metod a funkcí C** se nikdy nevynechají, i když se jejich výsledek nepoužije. Vložená metoda (inlining) provede přesně stejné příkazy ve stejném pořadí jako volaná.
6. Desetinná čísla se nikdy neupravují „chytrými“ triky (třeba `x * 4` na posun).

Každá optimalizace před použitím ověří své předpoklady. Když si není jistá, neudělá nic.

---

## 24. Chyby a jak jim rozumět

### Chyby při překladu

Kompilátor vypíše řádek a popis, např.:

```
Chyba (radek 12): Nedeklarovana promenna 'pocte'.
Typova chyba (radek 7): Metoda 'Obsah' ocekava 2 argumentu, ale bylo predano 1.
Typova chyba (radek 3): Nelze priradit 'Cislo' do promenne 'f' (ocekava 'Float').
Tip: desetinne cislo se pise s teckou, napr. 0.0 misto 0.
```

Časté příčiny:

| Hláška | Co s tím |
|---|---|
| Nedeklarovana promenna | překlep ve jménu, nebo chybí `Lokalni` |
| Neznama metoda | chybí `Metoda` nebo `Externi` |
| Znak s diakritikou je povolen jen v textu a komentari | jména pište bez háčků a čárek |
| Promenna 'x' uz v teto metode existuje | použijte jiné jméno |
| '…' neni pole, nelze ho indexovat | `p->clen[i]` jde jen u členu se závorkami |
| Odloz smi byt jen primo v tele metody | přesuňte `Odloz` mimo `Pokud`/cyklus |

### Chyby za běhu programu

Některé chyby se poznají až při běhu. Program pak vypíše hlášku s řádkem a skončí s kódem 1:

```
Chyba za behu (radek 3): deleni nulou
Chyba za behu (radek 15): Alokuj: nedostatek pameti
Chyba za behu (radek 8): index mimo meze pole
Chyba za behu (radek 21): pristup pres nulovy ukazatel (p->clen, kdyz p = 0)
Chyba za behu: preteceni zasobniku (prilis hluboka rekurze)
```

| Kontrola | Kde | Cena |
|---|---|---|
| dělení nulou | `a / b`, `a % b`, když `b` není číslo | jedno porovnání |
| index lokálního pole a textového členu struktury | `a[i]`, `p->jmeno[i]` | jedno porovnání (záporný index se chytí taky) |
| nulový ukazatel | `p->x`, `p->x = …` | jedno porovnání; v jednom úseku kódu se stejný ukazatel kontroluje jen jednou |
| hloubka rekurze | začátek každé metody, která něco volá | jedno porovnání |

Chybové větve leží až za koncem metody, takže hlavní cestu nezpomalují. Přepínač `--bez-kontrol` vypne kontroly mezí, ukazatelů a rekurze (dělení nulou zůstává).

Co se **nekontroluje**: paměť z `Alokuj` (`p[i]`, `CtiZAdresu`…), protože Pramen nezná její velikost; v jádře OS nulový ukazatel (adresa 0 tam může být platná) a hloubka rekurze (zásobník si spravujete sami). Kontrola rekurze počítá se zásobníkem 8 MB na Linuxu a macOS (hlásí po 7 MB); na Windows zjistí skutečnou velikost zásobníku sama.

---

## 25. Omezení jazyka

Pramen je záměrně jednoduchý. Tohle (zatím) neumí:

- člen struktury jako pole čísel (pole ve struktuře je vždy text; čísla dejte do paměti z `Alokuj`);
- `%` a bitové operátory s desetinnými čísly;
- volání metody Pramenu z jazyka C (metoda Pramenu nemůže být „callback“ pro C, např. pro `qsort`);
- čísla bez znaménka (`unsigned`): porovnání a dělení jsou vždy se znaménkem;
- víc než 254 znaků v jednom textu v uvozovkách (delší texty spojte pomocí `+`);
- víc než 200 do sebe vnořených cyklů;
- jména delší než 254 znaků;
- celé číslo větší než 9223372036854775807 (kompilátor ohlásí chybu, nic tiše neořízne).

### Vyhrazená slova

`Pamatuj Externi Globalni Konstanta Struktura Skupina Metoda Lokalni Pokud Jinak Dokud Opakuj Rozcestnik Cesta Hlavni_cesta Volej Vrat Ukonci Pokracuj Vypis Asm Odloz Zahrn Alokuj Uvolni Velikost CtiZAdresu`

a vestavěné metody `CtiBajt Cti32 ZapisBajt Zapis32 ZapisNaAdresu Bariera`. Předem existují globální proměnné `sys_argc` a `sys_argv`.

---

## 26. Jak kompilátor funguje uvnitř

Kompilátor (`zdrojovy_kod.pra`) je napsaný v Pramenu a překládá sám sebe. Překlad má šest kroků:

1. **Lexer** (`LexerCore`) rozdělí text na tokeny.
2. **Parser** (`Parser`, `ParsePrikaz`, `ParseVyraz`) z tokenů postaví strom programu (AST) a tabulku symbolů.
3. **Kontrola** (`ZkontrolujAST`) ověří typy a počty argumentů a u textů změní `+ == !=` na práci s texty.
4. **Middle-end** (`Optimalizuj*`) provede bezpečné optimalizace stromu.
5. **Backend x86-64**: strom → mezikód IR (`GenerujHodnotu`, `GenerujAST_x86`) → graf bloků (`BudujCFG`) → živost (`SpocitejLiveness`) → přidělení registrů (`ProvedLinearScan`) → assembler NASM (`PrelozIRDoASM`).
   **Backend ARM64** používá stejné IR, CFG, živost a alokaci registrů a pak `PrelozIRDoARM` (registry x9–x15 a x19–x28). Metodu, kterou IR neumí celou (`Asm`, víc než 8 parametrů, některá volání přes ukazatel), přeloží jednoduchý generátor `GenerujAST_ARM`. Obě části mají stejnou volací konvenci, takže se mohou volat navzájem.
6. **Sestavení:** zavolá `nasm`/`as` a `gcc`/`clang`/`ld`.

### Bootstrap a pevný bod

Kompilátor v `Kompilery/` přeloží `zdrojovy_kod.pra` (stage1). Stage1 přeloží zdroj znovu (stage2) a stage2 ještě jednou (stage3). Assembler ze stage2 a stage3 musí být **bajt po bajtu stejný**. To dokazuje, že nový kompilátor překládá sám sebe správně. Skript `nastroje/over_pevny_bod.sh` to ověří.

Testy kompilátoru:

| Skript | Co ověřuje |
|---|---|
| `nastroje/spust_testy.sh` | programy v `testy/` dávají správný výstup (x86-64 i ARM64) |
| `testy_chyby/over.sh` | chybné programy v `testy_chyby/` se nepřeloží a hláška je srozumitelná |
| `testy_os/over.sh` | optimalizátor nevyhodil přístupy k hardwaru ani čekací smyčky |
| `nastroje/over_pevny_bod.sh` | kompilátor přeloží sám sebe a výsledek je stabilní |
| `nastroje/rozdilovy_test.sh` | náhodné programy (generuje je `nastroje/generator_programu.py`) přeložené Pramenem dají stejný výstup jako tytéž programy v C přeložené gcc, s optimalizacemi i bez nich |

Kompilátor se navíc testoval náhodně poškozenými programy (fuzzing, 4 500 programů): nikdy nespadl, nezasekl se ani nevyrobil assembler, který by nešel přeložit. Rozdílovými testy prošlo přes 800 náhodných programů na x86-64 a 140 na ARM64 bez jediného rozdílu.

Původní zavaděč v jazyce C (`C zdrojový kód/language.c`) je historický: překládá jen starou, menší verzi jazyka. Nový kompilátor se proto zavádí z hotových binárek ve `Kompilery/`.

---

## Tahák

```
// --- Struktura programu ---
Externi printf                       // funkce z knihovny C
Zahrn "knihovna.pra"                 // vložení jiného souboru
Konstanta MAX = 10                   // konstanta (i výraz: 4 * 2, 0xFF, -1)
Skupina Barva { Cervena, Modra = 5 } // očíslované konstanty
Globalni pocet = 0                   // globální proměnná (i "text", 1.5, : Typ)
Struktura Bod { x  y  jmeno[4] }     // struktura (jmeno = text 31 znaků)

Metoda Secti(a, b) { Vrat a + b }
Metoda Pul(x : Float) : Float { Vrat x / 2 }

Metoda Hlavni() {                    // začátek programu; Vrat = kód programu
    // --- Proměnné ---
    Lokalni i = 0                    // Cislo (64 bitů)
    Lokalni f = 1.5                  // Float
    Lokalni t = "text"               // String
    Lokalni p : Bod = Alokuj Velikost(Bod)
    Lokalni pole[MAX]                // pole vynulované
    i += 1;  i -= 1

    // --- Řízení ---
    Pokud (i < 5 && t == "text") { } Jinak Pokud (i == 7) { } Jinak { }
    Dokud (i < 10) { i = i + 1 }
    Opakuj (Lokalni k = 0, k < 3, k = k + 1) { Pokracuj }
    Rozcestnik (i) { Cesta 1: Vypis 1  Hlavni_cesta: Vypis 0 }

    // --- Hodnoty ---
    Vypis Secti(2, 3)                // výpis + nový řádek
    p->x = 5; pole[0] = p->x
    Vypis CtiBajt(t)                 // kód prvního znaku
    printf("%d %s\n", 42, t)
    Odloz Vypis "konec"              // provede se při odchodu z metody
    Uvolni p                         // uvolní paměť a nastaví p = 0
    Vrat 0
}
```

| Operátory (od nejvyšší priority) |
|---|
| `-x` `!x` `Alokuj` · `* / %` · `+ -` · `<< >>` · `< <= > >=` · `== !=` · `&` · `^` · `\|` · `&&` · `\|\|` |
