---- MODULE increment_g_lock ----

EXTENDS Integers, FiniteSets, TLC

(* 0: lock
 * 1: t = i;
 * 2: i = t + 1;
 * 3: unlock
 * 4: fin
 *)

VARIABLES i, ts, pcs, lock

CONSTANTS Procs
Symmetry == Permutations({}) \* No Symmetry, process id matters
\*Symmetry == Permutations(Procs) \* Symmetry, process id doesn't matters

Init == 
  /\ i = 0
  /\ ts = [p \in Procs |-> -1]
  /\ pcs = [p \in Procs |-> 0]
  /\ lock = FALSE

lock_lock(p) ==
  /\ pcs[p] = 0
  /\ ~lock
  /\ lock' = TRUE
  /\ pcs' = [pcs EXCEPT ![p] = 1]
  /\ UNCHANGED << i, ts >>

read(p) ==
  /\ pcs[p] = 1
  /\ ts' = [ts EXCEPT![p] = i]
  /\ pcs' = [pcs EXCEPT ![p] = 2]
  /\ i' = i
  /\ lock' = lock

write(p) ==
  /\ pcs[p] = 2
  /\ i' = ts[p] + 1
  /\ pcs' = [pcs EXCEPT ![p] = 3]
  /\ ts' = ts
  /\ lock' = lock

unlock(p) ==
  /\ pcs[p] = 3
  /\ lock' = FALSE
  /\ pcs' = [pcs EXCEPT ![p] = 4]
  /\ UNCHANGED << i, ts >>

fin(p) ==
  /\ pcs[p] = 4
  /\ i' = i
  /\ ts' = ts
  /\ pcs' = pcs
  /\ lock' = lock

Next == \E p \in Procs: read(p) \/ write(p) \/ fin(p) \/ lock_lock(p) \/ unlock(p)

vars == << i, ts, pcs, lock>>

Spec == Init /\ [][Next]_vars /\ \A p \in Procs: /\ WF_vars(read(p))
                                                 /\ WF_vars(write(p))
						 /\ WF_vars(lock_lock(p))
						 /\ WF_vars(unlock(p))
						 /\ WF_vars(fin(p))

Properties == 
  /\ <>[](\A p \in Procs: pcs[p] = 4)
  /\ <>[](i = Cardinality(Procs))

====
