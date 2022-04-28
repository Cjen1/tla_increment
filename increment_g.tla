---- MODULE increment_g ----

EXTENDS Integers, FiniteSets, TLC

(*
 * 1: t = i;
 * 2: i = t + 1;
 * 3: Fin
 *
 *)

VARIABLES i, ts, pcs

CONSTANTS Procs
Symmetry == Permutations({}) \* No Symmetry, process id matters
\*Symmetry == Permutations(Procs) \* Symmetry, process id doesn't matters

Init == 
  /\ i = 0
  /\ ts = [n \in Procs |-> -1]
  /\ pcs = [n \in Procs |-> 1]

read(p) ==
  /\ pcs[p] = 1
  /\ ts' = [ts EXCEPT![p] = i]
  /\ pcs' = [pcs EXCEPT ![p] = 2]
  /\ i' = i

write(p) ==
  /\ pcs[p] = 2
  /\ i' = ts[p] + 1
  /\ pcs' = [pcs EXCEPT ![p] = 3]
  /\ ts' = ts

fin(p) ==
  /\ pcs[p] = 3
  /\ i' = i
  /\ ts' = ts
  /\ pcs' = pcs

Next == \E p \in Procs: read(p) \/ write(p) \/ fin(p)

vars == << i, ts, pcs >>

Spec == Init /\ [][Next]_vars /\ \A p \in Procs: /\ WF_vars(read(p))
                                                 /\ WF_vars(write(p))
						 /\ WF_vars(fin(p))

Properties == 
  /\ <>[](\A p \in Procs: pcs[p] = 3)
  /\ <>[](i = Cardinality(Procs))

====
