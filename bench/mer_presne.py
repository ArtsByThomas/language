# Presnejsi mereni: programy se spousti stridave (N kol). Vypise nejlepsi a medianovy
# skutecny cas a nejlepsi cas procesoru (user+sys), ktery mene zavisi na zatizeni stroje.
# Pouziti: python3 mer_presne.py [-n 21] prog1 prog2 ...
import subprocess, sys, time, statistics, os
a = sys.argv[1:]; N = 21
if a and a[0] == '-n': N = int(a[1]); a = a[2:]
t = {p: [] for p in a}; c = {p: [] for p in a}
for _ in range(N):
    for p in a:
        z = time.perf_counter(); r0 = os.times()
        subprocess.run(['./' + p], stdout=subprocess.DEVNULL)
        r1 = os.times(); t[p].append(time.perf_counter() - z)
        c[p].append((r1.children_user - r0.children_user) + (r1.children_system - r0.children_system))
for p in a:
    print(f"{p:16s} min {min(t[p]):.3f} s   median {statistics.median(t[p]):.3f} s   procesor min {min(c[p]):.3f} s")
