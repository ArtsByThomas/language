# Generator nahodnych programu pro rozdilove testovani: stejny program v Pramenu (p.pra) a v C (p.c).
# Pouziti: python3 generator_programu.py <seed>
import random, sys
R=random.Random(int(sys.argv[1]))
NF=R.randint(2,6)
def expr(vars_, d, fi):
    if d<=0 or R.random()<0.3:
        if R.random()<0.6 and vars_: return R.choice(vars_)
        return str(R.randint(-20,100))
    k=R.random()
    a=expr(vars_,d-1,fi); b=expr(vars_,d-1,fi)
    # V C je poradi vyhodnoceni operandu nespecifikovane (Pramen: zleva doprava).
    # Volani s vypisem tedy smi byt jen v jednom z operandu.
    if 'F' in a and 'F' in b: b=str(R.randint(-20,100))
    if k<0.5: return f"({a} {R.choice(['+','-','*','&','|','^'])} {b})"
    if k<0.65: return f"({a} {R.choice(['/','%'])} {R.choice(['3','7','10','16','1','-5','100'])})"
    if k<0.75: return f"({a} {R.choice(['/','%'])} (({b} & 15) + 1))"
    if k<0.85: return f"({a} {R.choice(['<','>','<=','>=','==','!='])} {b})"
    if k<0.9 and fi>0:
        g=R.randrange(fi); return f"F{g}({a} & 7, {b})"
    if k<0.95: return f"(({a} > 0) && ({b} < 50))"
    return f"(0 - {a})"
def block(vars_, d, fi, out, ind, inloop):
    for _ in range(R.randint(1,4)):
        k=R.random(); p='    '*ind
        if k<0.3 or not vars_:
            v=f"v{len(out)}_{ind}"
            out.append(('decl',p,v,expr(vars_,2,fi))); vars_=vars_+[v]
        elif k<0.55:
            tg=[v for v in vars_ if v!='a' and not v.startswith('c')]
            if tg: out.append(('asg',p,R.choice(tg),expr(vars_,3,fi)))
        elif k<0.7 and d>0:
            out.append(('if',p,expr(vars_,2,fi)))
            block(vars_,d-1,fi,out,ind+1,inloop); out.append(('else',p))
            block(vars_,d-1,fi,out,ind+1,inloop); out.append(('end',p))
        elif k<0.8 and d>0:
            c=f"c{len(out)}"
            out.append(('decl',p,c,'0'))
            out.append(('while',p,f"{c} < {R.randint(1,6)}"))
            out.append(('asg',p+'    ',c,f"{c} + 1"))
            block(vars_+[c],d-1,fi,out,ind+1,True); out.append(('end',p))
            vars_=vars_+[c]
        elif k<0.85:
            out.append(('arr',p,f"arr[(({expr(vars_,2,fi)}) % 8 + 8) % 8]",expr(vars_,2,fi)))
        elif k<0.9 and [v for v in vars_ if v!='a' and not v.startswith('c')]:
            out.append(('asg',p,R.choice([v for v in vars_ if v!='a' and not v.startswith('c')]),f"arr[(({expr(vars_,2,fi)}) % 8 + 8) % 8]"))
        elif k<0.95 and d>0:
            out.append(('ret',p,expr(vars_,2,fi)))
        else:
            out.append(('print',p,expr(vars_,2,fi)))
    return vars_
P=[];C=["#include <stdio.h>","long F0(long,long);"]
for i in range(NF): C.append(f"long F{i}(long a, long b);")
for i in range(NF):
    out=[]
    rec = R.random()<0.5
    block(['a','b'],2,i,out,1,False)
    final=expr(['a','b'],2,i)
    P.append(f"Metoda F{i}(a, b) {{\n    Lokalni arr[8]")
    C.append(f"long F{i}(long a, long b) {{\n    long arr[8]={{0}};")
    if rec:
        P.append(f"    Pokud (a <= 0) {{ Vrat b }}")
        C.append(f"    if (a <= 0) {{ return b; }}")
    for t in out:
        k=t[0];p=t[1]
        if k=='decl': P.append(f"{p}Lokalni {t[2]} = {t[3]}"); C.append(f"{p}long {t[2]} = {t[3]};")
        elif k=='asg': P.append(f"{p}{t[2]} = {t[3]}"); C.append(f"{p}{t[2]} = {t[3]};")
        elif k=='arr': P.append(f"{p}{t[2]} = {t[3]}"); C.append(f"{p}{t[2]} = {t[3]};")
        elif k=='if': P.append(f"{p}Pokud ({t[2]}) {{"); C.append(f"{p}if ({t[2]}) {{")
        elif k=='else': P.append(f"{p}}} Jinak {{"); C.append(f"{p}}} else {{")
        elif k=='end': P.append(f"{p}}}"); C.append(f"{p}}}")
        elif k=='while': P.append(f"{p}Dokud ({t[2]}) {{"); C.append(f"{p}while ({t[2]}) {{")
        elif k=='ret': P.append(f"{p}Vrat {t[2]}"); C.append(f"{p}return {t[2]};")
        elif k=='print': P.append(f"{p}Vypis {t[2]}"); C.append(f'{p}printf("%ld\\n", (long)({t[2]}));')
    if rec:
        P.append(f"    Vrat {final} + F{i}(a - 1, b + 1)"); C.append(f"    {{ long z_ = {final}; return z_ + F{i}(a - 1, b + 1); }}")
    else:
        P.append(f"    Vrat {final}"); C.append(f"    return {final};")
    P.append("}"); C.append("}")
# Rekurence F(n) = F(n-a) OP F(n-b) (kompilator ji pocita cyklem; C rekurzi)
REK=[]
for r in range(R.randint(0,2)):
    k=R.randint(-3,4); op=R.choice(['+','-','*','^','&','|']); a,b=R.choice([(1,2),(2,1)])
    cmpo=R.choice(['<','<='])
    base=R.choice(['n','n + 3','n * n - 1','7 - n','(n ^ 5) + 2','n * 3'])
    nm=f"Rek{r}"; REK.append(nm)
    P.append(f"Metoda {nm}(n) {{\n    Pokud (n {cmpo} {k}) {{ Vrat {base} }}\n    Vrat {nm}(n - {a}) {op} {nm}(n - {b})\n}}")
    C.append(f"long {nm}(long n) {{\n    if (n {cmpo} {k}) return {base};\n    return {nm}(n - {a}) {op} {nm}(n - {b});\n}}")
P.insert(0,"Externi printf")
P.append("Metoda Hlavni() {"); C.append("int main(void) {")
for blk in range(R.randint(0,2)):
    a0,b0=R.randint(-9,9),R.randint(-50,50)
    e1=expr(['a'+str(blk),'b'+str(blk)],2,0); e2=expr(['a'+str(blk),'b'+str(blk)],1,0)
    P.append(f"    Lokalni a{blk} = {a0}"); C.append(f"    long a{blk} = {a0};")
    P.append(f"    Lokalni b{blk} = {b0}"); C.append(f"    long b{blk} = {b0};")
    P.append(f"    Lokalni fz{blk} : Float = 0.5"); C.append(f"    double fz{blk} = 0.5;")
    P.append(f"    Lokalni fk{blk} = 0"); C.append(f"    long fk{blk} = 0;")
    P.append(f"    Dokud (fk{blk} < 5) {{"); C.append(f"    while (fk{blk} < 5) {{")
    P.append(f"        fz{blk} = fz{blk} * 1.5 + ({e1}) / 4.0 - fk{blk}"); C.append(f"        fz{blk} = fz{blk} * 1.5 + ({e1}) / 4.0 - fk{blk};")
    P.append(f"        Pokud (fz{blk} > {e2}) {{ fz{blk} = fz{blk} / 3.0 }}"); C.append(f"        if (fz{blk} > {e2}) {{ fz{blk} = fz{blk} / 3.0; }}")
    P.append(f"        fk{blk} = fk{blk} + 1"); C.append(f"        fk{blk} = fk{blk} + 1;")
    P.append("    }"); C.append("    }")
    P.append(f"    Vypis fz{blk}"); C.append(f'    printf("%f\\n", fz{blk});')
# Desetinne cykly s redukcemi (vektorizace): vysledek se vypisuje na 17 cislic, musi sedet bit po bitu
def fexpr(v, inv, d):
    if d<=0 or R.random()<0.3:
        k=R.random()
        if k<0.4: return f"({v} + {R.choice(['0.5','0.25','1.0','3.5'])})"
        if k<0.7 and inv: return R.choice(inv)
        return R.choice(['0.5','1.5','2.0','0.125','7.0','1000.0'])
    a=fexpr(v,inv,d-1); b=fexpr(v,inv,d-1)
    return f"({a} {R.choice(['+','-','*','/'])} {b})"
for blk in range(R.randint(0,2)):
    lo=R.randint(-20,5); hi=lo+R.randint(0,41)
    v=f"vi{blk}"; t=f"vt{blk}"; inv=[f"vg{blk}"]
    P.append(f"    Lokalni vg{blk} : Float = {R.choice(['0.75','1.25','3.0'])}"); C.append(f"    double vg{blk} = {inv and '0'};")
    C[-1]=f"    double vg{blk} = {P[-1].split('= ')[1]};"
    P.append(f"    Lokalni vs{blk} : Float = 1.0"); C.append(f"    double vs{blk} = 1.0;")
    P.append(f"    Lokalni vr{blk} : Float = 0.0"); C.append(f"    double vr{blk} = 0.0;")
    P.append(f"    Lokalni {v} = {lo}"); C.append(f"    long {v} = {lo};")
    e1=fexpr(v,inv,2); e2=fexpr(v,inv+[t],2); e3=fexpr(v,inv+[t],2); o1=R.choice(['+','-','*'])
    P.append(f"    Dokud ({v} < {hi}) {{"); C.append(f"    while ({v} < {hi}) {{")
    P.append(f"        Lokalni {t} : Float = {e1}"); C.append(f"        double {t} = {e1};")
    P.append(f"        vs{blk} = vs{blk} {o1} {e2}"); C.append(f"        vs{blk} = vs{blk} {o1} {e2};")
    P.append(f"        vr{blk} = vr{blk} + {e3}"); C.append(f"        vr{blk} = vr{blk} + {e3};")
    P.append(f"        {v} = {v} + 1"); C.append(f"        {v} = {v} + 1;")
    P.append("    }"); C.append("    }")
    for z in ('vs','vr'):
        P.append(f'    Volej printf("%.17g\\n", {z}{blk})'); C.append(f'    printf("%.17g\\n", {z}{blk});')
for i in range(NF):
    for _ in range(2):
        x,y=R.randint(-5,9),R.randint(-50,50)
        P.append(f"    Vypis F{i}({x}, {y})"); C.append(f'    printf("%ld\\n", F{i}({x}, {y}));')
for nm in REK:
    for _ in range(3):
        n=R.randint(-6,24)
        P.append(f"    Vypis {nm}({n})"); C.append(f'    printf("%ld\\n", {nm}({n}));')
P.append("    Vrat 0\n}"); C.append("    return 0;\n}")
open('p.pra','w').write('\n'.join(P)+'\n'); open('p.c','w').write('\n'.join(C)+'\n')
