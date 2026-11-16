# Pramen: příručka funkcí a jak fungují

Tahle příručka projde **každou součást jazyka**: klíčová slova, operátory, vestavěné metody a přepínače kompilátoru. U každé najdete:

- **Zápis** – jak se to píše;
- **Co dělá** – význam pro program;
- **Příklad**;
- **Jak to funguje uvnitř** – co z toho kompilátor udělá na procesoru x86-64 a ARM64 a jaké kontroly přidá.

Výuková cesta jazykem je v [DOKUMENTACE.md](DOKUMENTACE.md). Tady je referenční popis: hledáte jednu věc a chcete o ní vědět všechno.

## Obsah

1. [Cesta programu kompilátorem](#1-cesta-programu-kompilátorem)
2. [Hodnoty a proměnné](#2-hodnoty-a-proměnné): `Lokalni`, `Globalni`, `Konstanta`, `Skupina`, typy
3. [Operátory](#3-operátory): aritmetika, porovnání, logika, bity, texty, desetinná čísla
4. [Řízení běhu](#4-řízení-běhu): `Pokud`, `Jinak`, `Dokud`, `Opakuj`, `Ukonci`, `Pokracuj`, `Rozcestnik`
5. [Metody](#5-metody): `Metoda`, `Vrat`, `Pamatuj`, `Volej`, `Hlavni`, metoda jako hodnota, `sys_argc`/`sys_argv`
6. [Paměť](#6-paměť): `Alokuj`, `Uvolni`, `Velikost`, `CtiZAdresu`, `ZapisNaAdresu`, `p[i]`
7. [Pole](#7-pole): lokální a globální
8. [Struktury](#8-struktury): `Struktura`, `->`, typované členy, textové členy
9. [Texty](#9-texty)
10. [Desetinná čísla](#10-desetinná-čísla)
11. [Výpis](#11-výpis): `Vypis`
12. [Úklid](#12-úklid-odloz): `Odloz`
13. [Funkce jazyka C](#13-funkce-jazyka-c-externi): `Externi`
14. [Více souborů](#14-více-souborů-zahrn): `Zahrn`
15. [Hardware](#15-hardware): `CtiBajt`, `Cti32`, `ZapisBajt`, `Zapis32`, `Bariera`, `Asm`
16. [Režim jádra OS](#16-režim-jádra-os)
17. [Kontroly za běhu](#17-kontroly-za-běhu)
18. [Přepínače kompilátoru](#18-přepínače-kompilátoru)
19. [Volací konvence](#19-volací-konvence)

---

## 1. Cesta programu kompilátorem

```
 zdroj .pra
     │  Lexer          rozseká text na slova (tokeny), hlídá délku jmen a velikost čísel
     ▼
 Parser               postaví strom programu (AST), zkontroluje závorky, jména, parametry
     │  Typová kontrola  zjistí typ každého výrazu (celé číslo, Float, String, struktura)
     ▼
 Optimalizace stromu  skládání konstant, vkládání krátkých metod, rozbalení malých cyklů
     │
     ▼
 IR                   jednoduché instrukce „d = a + b“; proměnné jsou virtuální registry.
     │                Tady se vkládají metody (i rekurzivní), mění koncová rekurze na cyklus,
     │                násobení v cyklech na sčítání a přidávají kontroly za běhu.
     ▼
 Úklid IR             nedosažitelný kód, vytažení konstant z cyklů, slučování kopií, mrtvý kód
     ▼
 CFG + živost         graf bloků a pro každou hodnotu přesné úseky, kdy je potřeba
     ▼
 Linear Scan          přidělí registry procesoru (celá čísla do rbx/rsi/… nebo x9–x28,
     │                desetinná do xmm0–xmm13 nebo d18–d31); co se nevejde, jde do paměti
     ▼
 Překlad IR           x86-64: NASM   │   ARM64: GNU as
     ▼
 assembler + linker   → spustitelný program
```

Na ARM64 metodu, kterou IR neumí celou (`Asm`, metoda s víc než 8 parametry, volání přes ukazatel s desetinnými čísly), přeloží jednodušší generátor. Na x86-64 se takové části překládají „surově“ uvnitř jinak optimalizované metody.

---

## 2. Hodnoty a proměnné

### `Lokalni`

**Zápis:** `Lokalni jmeno = výraz`, `Lokalni jmeno : Typ = výraz`, `Lokalni jmeno` (= 0)

**Co dělá:** vytvoří proměnnou viditelnou v metodě od místa deklarace. Bez hodnoty začíná na 0. Typ se určí jen při deklaraci: z `: Typ`, nebo z hodnoty (`Lokalni s = "ahoj"` je `String`, `Lokalni p = a->dalsi` má typ člena).

```
Lokalni pocet = 10
Lokalni f : Float = 2.5
Lokalni b : Bod = Alokuj Velikost(Bod)
```

**Jak to funguje uvnitř:**
- Proměnná je **virtuální registr** (vreg). Alokátor jí přidělí registr procesoru jen v místech, kde je její hodnota opravdu potřeba. Mezi tím může tentýž registr držet jinou proměnnou.
- Celá čísla jdou do `rbx, rsi, rdi, r8–r15, rcx, rdx` (x86-64) nebo `x9–x15, x19–x28` (ARM64). Desetinná čísla do `xmm0–xmm13` nebo `d18–d31`.
- Když registry dojdou, odloží se do paměti hodnota s nejmenší „vahou“. Váha roste 8× s každou úrovní zanoření cyklu, takže proměnné z vnitřních cyklů zůstávají v registrech.
- V metodě s `Asm` jsou všechny proměnné v paměti na pevných místech (`[rbp-8]`, `[x29, #-8]` …), aby k nim `Asm` mohl.
- Jméno nesmí zastínit jinou proměnnou ve vnějším bloku. Kompilátor by jinak oba bloky spojil do jedné proměnné, proto hlásí chybu.

### `Globalni`

**Zápis:** `Globalni jmeno = hodnota`, `Globalni jmeno : Typ`, `Globalni pole[N]`, `Globalni mapa[N][M]`

**Co dělá:** proměnná viditelná ze všech metod. Počáteční hodnota musí být známá při překladu: číslo, text, desetinné číslo nebo výraz z konstant.

**Jak to funguje uvnitř:** leží v datové části programu pod jménem `gvar_jmeno`. Čtení je `mov r, [rel gvar_x]` (x86-64) nebo `adrp` + `ldr` (ARM64). Globální proměnné optimalizátor nikdy nedrží v registru přes volání, protože je může změnit jiná metoda. Globální pole je blok vynulované paměti (`times N dq 0` / `.zero`).

### `Konstanta`

**Zápis:** `Konstanta JMENO = výraz z čísel a jiných konstant`

**Co dělá:** pojmenované číslo, které se nemění.

**Jak to funguje uvnitř:** v paměti nikde neleží. Kompilátor hodnotu vypočítá při překladu a dosadí ji přímo do instrukcí (`cmp rax, 100`, `add x9, x9, #8`). Konstanty jdou použít i jako velikost pole a v `Cesta`.

### `Skupina`

**Zápis:** `Skupina Jmeno { A, B, C = 10, D }`

**Co dělá:** očísluje řadu konstant: A = 0, B = 1, C = 10, D = 11.

**Jak to funguje uvnitř:** totéž co řada `Konstanta`; za běhu nic nestojí.

### Typy

| Typ | Co drží | Uvnitř |
|---|---|---|
| (bez typu) | celé číslo −2⁶³ až 2⁶³−1 | 64bitový registr |
| `Float` | desetinné číslo (double) | 64 bitů IEEE 754; v registru xmm/d, nebo jako bity v obyčejném registru |
| `String` | adresa textu zakončeného nulou | 64bitová adresa |
| jméno struktury | adresa struktury v paměti | 64bitová adresa |

Typ ovlivňuje jen to, **jakou instrukci** kompilátor zvolí (celočíselné `add` nebo `addsd`, `printf("%lld")` nebo `"%f"`, kde leží člen struktury). Za běhu se typ nikde neukládá.

---

## 3. Operátory

### Aritmetika `+ - * / %`

**Co dělá:** počítá s celými čísly (64 bitů). `/` zaokrouhluje k nule, `%` má znaménko dělence (jako v C). Při přetečení se výsledek „přetočí“ (2⁶³−1 + 1 = −2⁶³). Optimalizátor z přetečení nikdy nic nevyvozuje.

**Jak to funguje uvnitř:**

| Výraz | x86-64 | ARM64 |
|---|---|---|
| `a + b`, `a - b` | `add` / `sub`, s malou konstantou `lea d, [a + 5]` | `add` / `sub` (konstanta až 4095 přímo v instrukci) |
| `a * b` | `imul` | `mul` |
| `a / 7`, `a % 7` | **bez dělení**: vynásobení „magickým číslem“ (`imul`), posun, oprava pro záporná čísla | `smulh` + `asr`, zbytek `msub` |
| `a / 8` | posuny (se správným zaokrouhlením záporných čísel) | totéž |
| `a / b` (proměnná) | kontrola `b == 0` → chyba s řádkem; pak `idiv` | `cbz` → chyba; `sdiv` |
| `a % b` | `idiv`, zbytek z `rdx` | `sdiv` + `msub` |
| `-a` | `neg` | `neg` |

Magická čísla pro 259 nejčastějších dělitelů jsou v kompilátoru předpočítaná a ověřená proti skutečnému dělení. Dělení konstantou je asi 5–10× rychlejší než instrukce dělení.

**Rozsahy hodnot:** uvnitř cyklu `Dokud (j < N)`, kde `j` začíná na nezáporném čísle a jen roste o konstantu, kompilátor ví, že `j` je mezi začátkem a `N`. Když z toho vyplyne, že dělenec je nezáporný, vynechá u dělení konstantou opravu pro záporná čísla (u mocniny dvou je to jen posun nebo maska). Stejně tak vynechá kontrolu mezí pole, když index určitě leží v poli.

**Redukce síly:** když se v cyklu `j` mění jen příkazem `j = j + K` a `i` se nemění, kompilátor `i * j` nepočítá pokaždé. Spočítá ho jednou před cyklem a pak při každém kroku přičte `i * K`.

### Porovnání `== != < > <= >=`

**Co dělá:** výsledek je 1 (pravda) nebo 0 (nepravda).

**Jak to funguje uvnitř:** v podmínce (`Pokud`, `Dokud`) se porovnání nepočítá jako číslo, ale spojí se se skokem do jedné dvojice instrukcí: `cmp a, b` + `jl` (x86-64) nebo `cmp` + `b.lt` (ARM64). Porovnání s nulou je na ARM jediná instrukce `cbz`/`cbnz`. Jako hodnota (`x = a < b`) se použije `setl` / `cset`.

### Logika `&& || !`

**Co dělá:** `a && b` je pravda, když obě strany jsou nenulové; `a || b`, když aspoň jedna. Pravá strana se vyhodnotí **jen když je potřeba** (zkrácené vyhodnocení). `!a` dá 1 pro 0, jinak 0. `&&` váže silněji než `||`.

**Jak to funguje uvnitř:** žádné násobení ani porovnávání výsledků. Každá strana je samostatný podmíněný skok. `Pokud (a > 0 && b > 0)` se přeloží na „když `a <= 0`, skoč na Jinak; když `b <= 0`, skoč na Jinak“.

### Bitové operace `& | ^ << >>`

**Co dělá:** pracuje s jednotlivými bity. `>>` je aritmetický posun (zachová znaménko).

**Jak to funguje uvnitř:** `and`, `or`, `xor`, `shl`, `sar` (x86-64) a `and`, `orr`, `eor`, `lsl`, `asr` (ARM64). Posun o proměnnou bere jen dolních 6 bitů (posun o 64 je posun o 0) na obou procesorech stejně.

### Operátory s texty

| Výraz | Co dělá | Uvnitř |
|---|---|---|
| `a + b` (texty) | nový text spojením | `strlen(a)`, `strlen(b)`, `malloc(délka+1)` s kontrolou paměti, 2× `memcpy` |
| `a == b`, `a != b` (texty) | porovná obsah, ne adresy | `strcmp(a, b)` a porovnání s 0 |

Spojený text je nová paměť. Když ho už nepotřebujete, uvolněte ho `Uvolni`.

### Operátory s desetinnými čísly

| Výraz | x86-64 | ARM64 |
|---|---|---|
| `a + b`, `- * /` | `addsd`, `subsd`, `mulsd`, `divsd` v registrech xmm | `fadd`, `fsub`, `fmul`, `fdiv` v registrech d |
| `a < b` … | `ucomisd` + `seta`/`setae`, při NaN nepravda | `fcmp` + `cset`, při NaN nepravda |
| `a == b` | pravda jen když se rovnají a nejsou NaN | `fcmp` + `eq` |
| celé číslo s desetinným (`i + 0.5`) | `cvtsi2sd` (převod celého čísla) | `scvtf` |
| `-x` | překlopení znaménkového bitu | totéž |
| literál `2.5` | uložený v datech, načtený `movsd`; v cyklu se načte jednou před cyklem | `ldr d, [flt]` |

`%` a bitové operace s desetinnými čísly hlásí chybu při překladu.

---

## 4. Řízení běhu

### `Pokud` / `Jinak`

**Zápis:** `Pokud (podmínka) { … } Jinak Pokud (…) { … } Jinak { … }`

**Jak to funguje uvnitř:** podmínka se přeloží na skok **při nepravdě** přes tělo. Optimalizátor nic nepřesouvá přes hranici `Pokud`. Ve vložené metodě se větev, která končí `Vrat`, přesune za hlavní cestu, aby rychlá cesta byla souvislá.

### `Dokud`

**Zápis:** `Dokud (podmínka) { … }`

**Jak to funguje uvnitř:**

```
        jmp podminka
telo:   … tělo …
podminka:
        cmp …
        jl telo           ; skok zpět, dokud podmínka platí
```

Podmínka je na konci, takže každé kolo má jen jeden skok. Stejně se upraví i cykly vzniklé z koncové rekurze (rotace cyklu: test se zkopíruje na konec). Cyklus se nikdy neodstraní, ani když „nic nedělá“. V jádře OS jde často o záměrné čekání.

### `Opakuj`

**Zápis:** `Opakuj (Lokalni i = 0, i < 10, i = i + 1) { … }`

**Co dělá:** počáteční příkaz, podmínka, krok – jako `for` v C.

**Jak to funguje uvnitř:** stejně jako `Dokud`, krok je před podmínkou na konci. Krátké cykly `Opakuj` se známým počtem kol (nejvýš 10) se rozbalí. Cykly s `Ukonci`/`Pokracuj` se nerozbalují nikdy.

### `Ukonci`, `Pokracuj`

**Co dělá:** `Ukonci` vyskočí z nejbližšího cyklu. `Pokracuj` skočí na další kolo: na krok (`Opakuj`) nebo podmínku (`Dokud`).

**Jak to funguje uvnitř:** jeden `jmp` na návěští konce nebo kroku cyklu. Kompilátor drží zásobník návěští vnořených cyklů; víc než 200 vnořených cyklů je chyba.

### `Rozcestnik`, `Cesta`, `Hlavni_cesta`

**Zápis:**
```
Rozcestnik (hodnota) {
    Cesta 1: …
    Cesta KONSTANTA: { … }
    Hlavni_cesta: …
}
```

**Co dělá:** provede **jednu** cestu, jejíž číslo se rovná hodnotě (bez propadání do další), jinak `Hlavni_cesta`.

**Jak to funguje uvnitř:** hodnota se spočítá jednou, pak řada `cmp` + `je` na jednotlivé cesty a nakonec skok na `Hlavni_cesta`. Každá cesta končí skokem za rozcestník.

---

## 5. Metody

### `Metoda`, `Vrat`

**Zápis:**
```
Metoda Jmeno(a, b : Float, p : Bod) : Float {
    …
    Vrat výraz
}
```

**Co dělá:** pojmenovaný kus programu s parametry. `Vrat` ukončí metodu a vrátí hodnotu. Bez `Vrat` metoda vrací 0. Počet argumentů se kontroluje při překladu.

**Jak to funguje uvnitř:**
- **Parametry** přicházejí v registrech (viz [volací konvence](#19-volací-konvence)) a zůstanou v registrech, nic se neukládá do paměti.
- **Prolog** ukládá jen ty registry, které metoda opravdu použije. Metoda, která nepotřebuje paměť, nemá rámec (`push rbp` / `stp x29, x30`). Listová metoda na ARM nemá prolog vůbec.
- **Kontrola hloubky rekurze:** metoda, která něco volá, na začátku porovná ukazatel zásobníku s mezí (jedno `cmp`). Příliš hluboká rekurze vypíše chybu místo pádu.
- **Koncová rekurze** (`Vrat Fakt(n - 1, a * n)`) a rekurze s akumulátorem (`Vrat n * Fakt(n - 1)`, `Vrat Fib(n-1) + Fib(n-2)`) se změní na cyklus. Nespotřebují zásobník a nevolají se.
- **Vkládání (inlining):** malá metoda (do 40 uzlů stromu) se vloží na místo volání a její parametry dostanou nové virtuální registry. Rekurzivní metoda se vloží sama do sebe až do hloubky 3, každá vložená úroveň je opět cyklus. Nevkládají se metody s `Asm`, `Odloz`, lokálními poli a metoda `Hlavni`.

### `Pamatuj`

**Zápis:** `Pamatuj Metoda Jmeno(n) { … }`

**Co dělá:** metoda si pamatuje výsledky pro `n` od 0 do 1023. Druhé volání se stejným `n` vrátí uložený výsledek bez počítání.

**Uvnitř:**
- V datech programu vzniknou dvě tabulky po 1024 číslech: výsledky a příznaky „spočítáno“.
- Na začátku metody je porovnání bez znaménka `n < 1024` (zachytí i záporná `n`), načtení příznaku a při úspěchu rovnou návrat.
- Každé `Vrat` výsledek uloží (dvě instrukce `mov` do tabulek).
- Taková metoda se nevkládá a koncová rekurze se v ní nemění na cyklus, aby každé volání šlo přes tabulku.
- Kompilátor ověří čistotu: jen jeden celočíselný parametr, žádné globální proměnné, paměť, ukazatele, výpis, `Alokuj` ani volání jiných metod. Jinak hlásí chybu.

### Rekurence → cyklus

**Kdy:** metoda má jediný celočíselný parametr a tělo přesně ze dvou příkazů:

```
Metoda Fib(n) {
    Pokud (n < 2) { Vrat n }           // nebo n <= K; výraz smí číst jen n
    Vrat Fib(n - 1) + Fib(n - 2)       // + - * & | ^, operandy v libovolném pořadí
}
```

**Co se stane:** kompilátor místo rekurze vygeneruje cyklus:

```
Pokud (n < K) { Vrat E(n) }
a = E(K - 2)      // F(K-2)
b = E(K - 1)      // F(K-1)
i = K
opakuj: c = b OP a; a = b; b = c; když i == n, konec; i = i + 1
Vrat b
```

Každé `F(i)` se spočítá jednou. Fibonacci(40) potřebuje 39 kol místo 330 milionů volání. Výsledek je bit po bitu stejný: celá čísla se přetáčí stejně a pořadí operandů zůstává. Test konce je `i == n`, takže ani `n` blízko maxima nepřeteče. Taková metoda se nevkládá do jiných metod, protože vložený strom by byl zase rekurze.

**Kdy ne:** `Pamatuj`, `Asm`, desetinná čísla, záporná mez `K` a jiný tvar těla. Pak zůstane obyčejná rekurze. Vypíná se přepínačem `--bez-rekurence`.

### Rychlý vstup

Začíná-li metoda `Pokud (a OP b) { Vrat e }`, kde `a`, `b` jsou parametry nebo čísla a `e` je parametr, číslo nebo parametr ± číslo, vypíše se tenhle test před prologem, jen nad registry argumentů:

```
Ack:
    cmp rdi, 0
    jne .L_plny_vstup_1
    lea rax, [rsi + 1]
    ret
.L_plny_vstup_1:
    push rbp …
```

### Částečné vkládání

**Kdy:** volaná metoda je moc velká na celé vložení a začíná příkazem `Pokud (podmínka) { Vrat výraz }`. Podmínka i výraz smí číst jen parametry (žádná paměť, volání ani dělení).

**Co se stane:** na místě volání se nejdřív spočítají argumenty a vyhodnotí podmínka. Když platí, výsledek je rovnou `výraz` a k volání vůbec nedojde (žádný prolog, ukládání registrů ani kontrola zásobníku). Jinak se metoda zavolá normálně se stejnými, už spočítanými argumenty. Každý argument se tedy vyhodnotí právě jednou.

**Kdy ne:** u rekurzivního volání metody samé do sebe. Tam koncová rekurze s akumulátorem odstranila většinu volání listů a test navíc na konci vnitřního cyklu procesor často špatně odhadne (Fibonacci byl o 10 % pomalejší). Dál ne u `Pamatuj`, `Odloz`, `Asm` a desetinných argumentů.

### `Volej`

**Zápis:** `Volej Jmeno(…)` nebo jen `Jmeno(…)`

**Co dělá:** zavolá metodu a výsledek zahodí. Je to totéž co volání bez `Volej`.

**Jak to funguje uvnitř:** `call` / `bl`. Volání metody se nikdy nevynechá, ani když se výsledek nepoužije, protože metoda může mít vedlejší účinky.

### `Hlavni`

Program začíná v metodě `Hlavni()`. Její výsledek je **návratový kód programu** (`Vrat 3` → `echo $?` vypíše 3). Program bez `Hlavni` se nepřeloží.

**Uvnitř:** kompilátor přidá funkci `main`, která uloží parametry programu do `sys_argc`/`sys_argv`, nastaví mez zásobníku a zavolá `Hlavni`.

### Metoda jako hodnota

**Zápis:** `Lokalni f = Dvakrat` (bez závorek), pak `f(21)`

**Co dělá:** jméno metody bez závorek je její adresa. Volání přes proměnnou zavolá metodu na té adrese.

**Uvnitř:** `lea r, [rel Dvakrat]` a pak `call r` (nepřímé volání). Tyto metody se nevkládají.

### `sys_argc`, `sys_argv`

Globální proměnné s počtem parametrů příkazové řádky a adresou pole textů. `CtiZAdresu(sys_argv + 8)` je první parametr.

---

## 6. Paměť

### `Alokuj`

**Zápis:** `Alokuj výraz` – výraz je počet bajtů

**Co dělá:** vyhradí paměť a vrátí její adresu. Paměť je **vynulovaná**. Když paměť dojde, program skončí s chybou a číslem řádku.

**Uvnitř:** `calloc(1, n)` a kontrola nuly. `Alokuj` bere celý výraz za sebou: `Alokuj n * 8` je `n*8` bajtů.

### `Uvolni`

**Zápis:** `Uvolni p`

**Co dělá:** vrátí paměť systému a **nastaví `p` na 0**. Druhé `Uvolni p` je pak neškodné a přístup `p->x` ohlásí chybu nulového ukazatele, místo aby četl uvolněnou paměť.

**Uvnitř:** `free(p)`; `p = 0`.

### `Velikost`

**Zápis:** `Velikost(Struktura)`

**Co dělá:** velikost struktury v bajtech (každý člen 8 bajtů, textové členy podle deklarace).

**Uvnitř:** číslo dosazené při překladu.

### `CtiZAdresu`, `ZapisNaAdresu`

**Zápis:** `CtiZAdresu(adresa)`, `ZapisNaAdresu(adresa, hodnota)`

**Co dělá:** přečte nebo zapíše 8 bajtů na libovolné adrese.

**Uvnitř:** jedna instrukce `mov` / `ldr` / `str`. Optimalizátor ji nikdy nevynechá ani nepřesune, takže funguje i pro registry zařízení.

### `p[i]` (paměť z `Alokuj`)

**Co dělá:** `i`-té 8bajtové číslo od adresy `p`. `p + 8` je adresa o 8 **bajtů** dál.

**Uvnitř:** `mov r, [p + i*8]` / `ldr x, [p, i, lsl #3]`; zápis `p[i] = h` je jediná instrukce. Index se **nekontroluje**, protože Pramen nezná velikost paměti z `Alokuj`.

---

## 7. Pole

**Zápis:** `Lokalni a[10]`, `Lokalni m[3][4]`, `Globalni t[100]`, `Globalni mapa[10][20]`; čtení `a[i]`, `m[r][s]`

**Co dělá:** řada 8bajtových čísel. Pole je vynulované. Jméno bez indexu je adresa prvního prvku (dá se předat metodě).

**Uvnitř:**
- Lokální pole leží v rámci metody (`[rbp - posun]`), globální v datech (`gvar_t`).
- 2D index `m[r][s]` se přepočítá na `m[r * 4 + s]`.
- **Kontrola mezí:** index se porovná s velikostí jedním porovnáním bez znaménka, které zachytí i záporný index (`cmp i, N` + `jae chyba`). Konstantní index mimo pole je chyba už při překladu. Když kompilátor z cyklu dokáže, že index leží v poli (např. `Dokud (i < 16) { a[i] = … }` u pole `a[16]`), kontrolu vynechá.
- Lokální pole se vynuluje při deklaraci krátkou smyčkou (`mov qword [rax], 0` / `str xzr, [x8], #8`).

---

## 8. Struktury

### `Struktura`

**Zápis:**
```
Struktura Uzel {
    hodnota
    jmeno[16]          // text o 16 znacich (bajtech) primo ve strukture
    dalsi : Uzel       // clen s typem: ukazatel na dalsi Uzel
}
```

**Co dělá:** popíše rozložení paměti. Každý člen má 8 bajtů (textový člen `[N]` má N×8 bajtů). Proměnná se strukturou je adresa: `Lokalni u : Uzel = Alokuj Velikost(Uzel)`.

### `->`

**Zápis:** `u->hodnota`, `u->hodnota = 5`, `u->dalsi->hodnota`, `u->dalsi->dalsi->hodnota = 7`

**Co dělá:** čte nebo zapisuje člen. Řetězit jde přes členy s uvedeným typem (`dalsi : Uzel`).

**Uvnitř:**
- `u->hodnota` je jedna instrukce `mov r, [u + posun]` (posun se zná při překladu).
- **Kontrola nulového ukazatele:** před prvním přístupem přes `u` v úseku kódu je `test u, u` + `jz chyba`. Další přístupy přes stejné `u` v tom úseku se už nekontrolují. V režimu jádra se nekontroluje, protože adresa 0 tam může být platná.
- Řetěz `a->b->c` je řada načtení, každé s vlastní kontrolou nuly.
- `Lokalni x = u->dalsi` dostane typ `Uzel` automaticky.

### Textový člen `jmeno[N]`

`u->jmeno` je **adresa** textu uvnitř struktury (typ `String`), `u->jmeno[i]` je jeden bajt. Index se kontroluje proti velikosti člena.

---

## 9. Texty

**Zápis:** `"text"`, `'A'` (číslo znaku 65), `Lokalni t : String = "…"`, `a + b`, `a == b`, `a != b`, `t[i]`

**Co dělá:** text je adresa řady znaků zakončené nulou, stejně jako v C, takže jde přímo předat funkcím C (`printf`, `strlen`, `fopen`…).

**Uvnitř:**
- Texty v uvozovkách leží v datech programu (`str0`, `str1`…) a za běhu se nekopírují.
- `a + b` vytvoří nový text přesně potřebné délky: `strlen` + `malloc` + 2× `memcpy`. Když paměť dojde, program skončí s chybou.
- `a == b` porovná obsah funkcí `strcmp`.
- Jeden text v uvozovkách má nejvýš 254 znaků; delší spojte pomocí `+`.

---

## 10. Desetinná čísla

**Zápis:** `2.5`, `0.0 - 1.5`, `Lokalni f : Float = …`, `Metoda F(x : Float) : Float`

**Co dělá:** 64bitová čísla s plovoucí čárkou (IEEE 754 double). Celé číslo ve výrazu s desetinným se převede: `7 / 2.0` = 3.5. Přiřazení **nepřevádí**: proměnná musí mít typ `Float`.

**Uvnitř:**
- Proměnné a mezivýsledky leží v registrech `xmm0–xmm13` (x86-64) nebo `d18–d31` (ARM64). Do obyčejného registru se převádí jen při předání metodě Pramenu (jako bity) nebo do paměti.
- Literály se v cyklu načtou jednou před cyklem.
- Převod celého čísla na desetinné (`cvtsi2sd`) se předchází `pxor`, aby procesor nečekal na starou hodnotu registru. Jinak by se celý cyklus zřetězil a běžel několikrát pomaleji.
- Metodě Pramenu se desetinné číslo předává jako 64 bitů v obyčejném registru, funkci C ve `xmm`/`d` registru podle ABI systému.
- **Vektorizace (x86-64):** cyklus `Dokud (i < n)` s krokem `i = i + 1`, jehož tělo obsahuje jen desetinné `+ - * /`, převod `i` na desetinné číslo a součty typu `s = s + …`, se přeloží dvakrát. Napřed běží vektorová verze: hodnoty dvou kol leží v jednom registru `xmm` (dolní a horní polovina) a každá operace je jedna instrukce (`addpd`, `mulpd`, `divpd` …). Hodnoty zvenku cyklu (`h`, konstanty) se před cyklem rozkopírují do obou polovin. Součet se nepřeskupuje: nejdřív se přičte dolní polovina, pak horní (`unpckhpd`), stejně jako by běžela dvě kola za sebou. Proto je výsledek bit po bitu stejný. Až zbývá méně než dvě kola, doběhne původní cyklus. Kompilátor vektorizaci nepoužije, když by dvojice nemusely všechny dostat registr `xmm` (Windows má volných jen 6), když tělo obsahuje skok, volání nebo práci s pamětí, nebo když se hodnota z těla čte až za cyklem. Pak zůstane obyčejný cyklus. Přepínač `--bez-vektorizace` ji vypne.

---

## 11. Výpis

### `Vypis`

**Zápis:** `Vypis výraz`

**Co dělá:** vypíše hodnotu a odřádkuje. Formát podle typu: celé číslo `%lld`, `Float` `%f` (6 desetinných míst), `String` `%s`.

**Uvnitř:** volání `printf` s formátem z dat programu (`fmt_int`, `fmt_flt`, `fmt_str`). Na Linuxu x86-64 se v `al` předá počet desetinných argumentů. Na macOS ARM jdou variadické argumenty na zásobník, jak vyžaduje Apple. V režimu jádra `Vypis` nejde použít (není knihovna C).

---

## 12. Úklid: `Odloz`

**Zápis:** `Odloz příkaz` (jen přímo v těle metody)

**Co dělá:** příkaz se provede při **každém** odchodu z metody, ať to je kterýmkoli `Vrat`. Víc odložených příkazů se provede v opačném pořadí.

**Uvnitř:** kompilátor odložené příkazy zkopíruje před každý návrat. `Odloz` uvnitř `Pokud` nebo cyklu je chyba, protože by se provedl i příkaz, ke kterému program nedošel.

---

## 13. Funkce jazyka C: `Externi`

**Zápis:** `Externi printf`, `Externi sqrt : Float`

**Co dělá:** zpřístupní funkci knihovny C. `: Float` říká, že funkce vrací desetinné číslo.

**Uvnitř:**
- Volání dodrží ABI systému: Linux a macOS (System V) mají celá čísla v `rdi, rsi, rdx, rcx, r8, r9` a desetinná ve `xmm0–7`, Windows podle pozice `rcx, rdx, r8, r9` / `xmm0–3` s 32bajtovou „stínovou oblastí“, ARM64 `x0–x7` a `d0–d7`.
- Zásobník je před voláním zarovnaný na 16 bajtů. Zarovnání kompilátor spočítá při překladu, za běhu nic nestojí.
- Funkce vracející `int` (např. `strcmp`, `fgetc`) se rozšíří na 64 bitů se znaménkem, takže `-1` zůstane `-1`. Funkce s `: Float` vrací výsledek ve `xmm0`/`d0`.
- Na Linuxu se k programu automaticky připojí matematická knihovna (`-lm`).

---

## 14. Více souborů: `Zahrn`

**Zápis:** `Zahrn "knihovna/matematika.pra"`

**Co dělá:** vloží obsah souboru na místo příkazu. Každý soubor se vloží jen jednou, i když ho zahrnuje víc souborů.

**Uvnitř:** lexer si pamatuje už zahrnuté soubory (nejvýš 256).

---

## 15. Hardware

### `CtiBajt`, `Cti32`, `ZapisBajt`, `Zapis32`

**Zápis:** `CtiBajt(adresa)`, `Cti32(adresa)`, `ZapisBajt(adresa, h)`, `Zapis32(adresa, h)`

**Co dělá:** přečte nebo zapíše 1 nebo 4 bajty. Čtené hodnoty jsou bez znaménka (0–255, 0–4 294 967 295).

**Uvnitř:** jedna instrukce (`movzx`, `mov dword`, `ldrb`, `ldr w`, `strb`, `str w`). **Záruka:** optimalizátor tyto přístupy nevynechá, nespojí ani nepřehází, takže fungují pro registry zařízení (MMIO). Hlídá to test `testy_os/over.sh`.

### `Bariera()`

**Co dělá:** všechny dřívější přístupy do paměti se dokončí dřív než pozdější.

**Uvnitř:** `mfence` (x86-64), `dmb sy` (ARM64).

### `Asm`

**Zápis:** `Asm "x86:instrukce"`, `Asm "arm:instrukce"`, `Asm "instrukce"`

**Co dělá:** vloží instrukci procesoru. Řádek s `x86:` se použije jen pro x86-64, s `arm:` jen pro ARM64.

**Uvnitř:** text se vloží beze změny. Metoda s `Asm` má všechny proměnné v paměti na dokumentovaných místech a optimalizátor v ní nic nedosazuje ani nevkládá. Na ARM64 ji vždy překládá jednoduchý generátor, aby se žádný řádek neztratil. Test `testy_os` ověřuje, že `Asm` zůstane na obou procesorech.

---

## 16. Režim jádra OS

**Zápis:** `pramen jadro.pra jadro --cil=kernel` nebo `--cil=kernel-arm`

**Co dělá:** program běží přímo na procesoru bez operačního systému.

**Uvnitř:**
- Vstupní bod `_start` nastaví zásobník (64 KiB) a zavolá `Hlavni`. Po návratu procesor zastaví (`hlt` / `wfe`).
- Nefungují `Vypis`, `Alokuj`, `Uvolni` a práce s texty (`+`, `==`), protože potřebují knihovnu C. Kompilátor ohlásí chybu.
- Nepřidává se kontrola nulového ukazatele a hloubky rekurze. Kontrola mezí polí a dělení nulou zůstává; chyba zastaví procesor.
- Optimalizace zůstávají zapnuté, ale nikdy neodstraní čekací smyčku ani přístup k hardwaru.

---

## 17. Kontroly za běhu

Každá kontrola je jedno porovnání. Chybový kód leží až za koncem metody, takže hlavní cestu nezpomaluje. Program vypíše hlášku s řádkem a skončí s kódem 1.

| Kontrola | Kdy | Hláška | Vypne `--bez-kontrol` |
|---|---|---|---|
| dělení nulou | `a / b`, `a % b` s proměnnou | `deleni nulou` | ne |
| nedostatek paměti | `Alokuj`, spojení textů | `Alokuj: nedostatek pameti` | ne |
| meze pole | `a[i]`, `p->jmeno[i]` | `index mimo meze pole` | ano |
| nulový ukazatel | `p->x`, `a->b->c` | `pristup pres nulovy ukazatel` | ano |
| hloubka rekurze | začátek metody, která volá | `preteceni zasobniku` | ano |

Při překladu se navíc hlásí: index-konstanta mimo pole, číslo větší než 2⁶³−1, jméno delší než 254 znaků, dvě metody stejného jména, chybějící `Hlavni`, víc než 200 vnořených cyklů, zastínění proměnné, `Odloz` mimo tělo metody.

---

## 18. Přepínače kompilátoru

| Přepínač | Význam |
|---|---|
| `--cil=linux` `windows` `macos` `linux-arm` `macos-arm` `kernel` `kernel-arm` | cílová platforma (výchozí je systém, na kterém kompilátor běží) |
| `--jen-asm` | jen vytvoří assembler (`.asm` / `.s`), nesestavuje |
| `--podrobne` | vypíše, co optimalizátor udělal (vkládání, redukce síly, záložní generátor na ARM) |
| `--bez-kontrol` | vypne kontroly mezí, nulového ukazatele a hloubky rekurze |
| `--bez-vkladani` | nevkládá metody (ladění) |
| `--bez-redukce` | nemění násobení v cyklech na sčítání (ladění) |
| `--bez-arm-ir` | na ARM64 jen jednoduchý generátor (ladění) |
| `--bez-vektorizace` | desetinné cykly se nepočítají po dvou kolech (ladění) |
| `--bez-rekurence` | rekurence `F(n-1) OP F(n-2)` se nepočítá cyklem (ladění, měření) |
| `--bez-zarovnani` | začátky cyklů se nezarovnávají na 16 bajtů |
| `--vypis-ir` | vypíše mezikód každé metody po optimalizacích: číslo instrukce, kód operace, cíl a operandy (`v12` = virtuální registr, `#5` = konstanta) |

---

## 19. Volací konvence

Jak metody Pramenu předávají argumenty. Důležité pro `Asm` a pro spojení s jinými jazyky.

| | x86-64 Linux/macOS | x86-64 Windows | ARM64 |
|---|---|---|---|
| argumenty Pramen → Pramen | `rdi, rsi, rdx, rcx`, další na zásobníku | `rcx, rdx, r8, r9`, další na zásobníku | `x0–x7`, další na zásobníku |
| desetinné argumenty metod Pramenu | jako 64 bitů v těchže registrech | totéž | totéž |
| výsledek | `rax` | `rax` | `x0` |
| registry, které metoda musí zachovat | `rbx, rbp, r12–r15` | navíc `rsi, rdi` | `x19–x28`, `x29`, `x30` |
| domovská oblast | jen pro metody s `Asm` (32 B) | 32 B vždy | metody jednoduchého generátoru si 64 B vyhradí samy |

Metoda s `Asm` najde své parametry v paměti na `[rbp+16]`, `[rbp+24]` … (x86-64) nebo `[x29, #16]`, `[x29, #24]` … (ARM64).
