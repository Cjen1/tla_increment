---- MODULE increment_g ----

EXTENDS Integers

(*
 * 1: t = i;
 * 2: i = t + 1;
 * 3: Fin
 *
 *)

VARIABLES i, ts, pcs

N == 2

Init == 
  /\ i = 0
  /\ ts = [n \in 1..N |-> -1]
  /\ pcs = [n \in 1..N |-> 1]

read(n) ==
  /\ pcs[n] = 1
  /\ ts' = [ts EXCEPT![n] = i]
  /\ pcs' = [pcs EXCEPT ![n] = 2]
  /\ i' = i

write(n) ==
  /\ pcs[n] = 2
  /\ i' = ts[n] + 1
  /\ pcs' = [pcs EXCEPT ![n] = 3]
  /\ ts' = ts

fin(n) ==
  /\ pcs[n] = 3
  /\ i' = i
  /\ ts' = ts
  /\ pcs' = pcs

Next == \E n \in 1..N: read(n) \/ write(n) \/ fin(n)

vars == << i, ts, pcs >>

\*Spec == Init /\ [][Next]_vars


Spec == Init /\ [][Next]_vars /\ \A n \in 1..N: /\ WF_vars(read(n))
                                                /\ WF_vars(write(n))
						/\ WF_vars(fin(n))

Properties == 
  /\ <>[](\A n \in 1..N: pcs[n] = 3)
  /\ <>[](i = N)

====
