---- MODULE increment_1 ----

EXTENDS Integers

(*
 * 1: t = i;
 * 2: i = t + 1;
 * 3: Fin
 *
 *)

VARIABLES i, t, pc

Init == 
  /\ i = 0
  /\ t = -1
  /\ pc = 1

read ==
  /\ pc = 1
  /\ t' = i
  /\ pc' = 2
  /\ i' = i

write ==
  /\ pc = 2
  /\ i' = t + 1
  /\ pc' = 3
  /\ t' = t

fin ==
  /\ pc = 3
  /\ i' = i
  /\ t' = t
  /\ pc' = pc

Next == \/ read \/ write \/ fin

vars == << i, t, pc >>

\*Spec == Init /\ [][Next]_vars


Spec == Init /\ [][Next]_vars /\ WF_vars(read)
                             /\ WF_vars(write)

Invariants ==
  /\ i >= 0
  /\ t = -1 \/ i = t \/ i = t + 1

Properties == 
  /\ <>[](pc = 3)
  /\ <>[](i = 1)
====
