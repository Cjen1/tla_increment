---- MODULE increment_g_lock ----

EXTENDS Integers

(*
 * 1: t = i;
 * 2: i = t + 1;
 * 3: Fin
 *
 *)

VARIABLES i, ts, pcs, lock

N == 2

Init == 
  /\ i = 0
  /\ ts = [n \in 1..N |-> -1]
  /\ pcs = [n \in 1..N |-> 0]
  /\ lock = FALSE

lock_lock(n) ==
  /\ pcs[n] = 0
  /\ ~lock
  /\ lock' = TRUE
  /\ pcs' = [pcs EXCEPT ![n] = 1]
  /\ UNCHANGED << i, ts >>

read(n) ==
  /\ pcs[n] = 1
  /\ ts' = [ts EXCEPT![n] = i]
  /\ pcs' = [pcs EXCEPT ![n] = 2]
  /\ i' = i
  /\ lock' = lock

write(n) ==
  /\ pcs[n] = 2
  /\ i' = ts[n] + 1
  /\ pcs' = [pcs EXCEPT ![n] = 3]
  /\ ts' = ts
  /\ lock' = lock

unlock(n) ==
  /\ pcs[n] = 3
  /\ lock' = FALSE
  /\ pcs' = [pcs EXCEPT ![n] = 4]
  /\ UNCHANGED << i, ts >>

fin(n) ==
  /\ pcs[n] = 4
  /\ i' = i
  /\ ts' = ts
  /\ pcs' = pcs
  /\ lock' = lock

Next == \E n \in 1..N: read(n) \/ write(n) \/ fin(n) \/ lock_lock(n) \/ unlock(n)

vars == << i, ts, pcs >>

\*Spec == Init /\ [][Next]_vars


Spec == Init /\ [][Next]_vars /\ \A n \in 1..N: /\ WF_vars(read(n))
                                                /\ WF_vars(write(n))
						/\ WF_vars(lock_lock(n))
						/\ WF_vars(unlock(n))
						/\ WF_vars(fin(n))


Properties == 
  /\ <>[](\A n \in 1..N: pcs[n] = 4)
  /\ <>[](i = N)

====
