---- MODULE increment_2 ----

EXTENDS Integers

(*
 * 1: t = i;
 * 2: i = t + 1;
 * 3: Fin
 *
 *)

VARIABLES i, t1, pc1, t2, pc2

Init == 
  /\ i = 0
  /\ t1 = -1 /\ pc1 = 1
  /\ t2 = -1 /\ pc2 = 1

read1 ==
  /\ pc1 = 1
  /\ t1' = i
  /\ pc1' = 2
  /\ UNCHANGED << i, t2, pc2 >>

read2 ==
  /\ pc2 = 1
  /\ t2' = i
  /\ pc2' = 2
  /\ UNCHANGED << i, t1, pc1 >>

write1 ==
  /\ pc1 = 2
  /\ i' = t1 + 1
  /\ pc1' = 3
  /\ t1' = t1
  /\ UNCHANGED << t2, pc2 >>

write2 ==
  /\ pc2 = 2
  /\ i' = t2 + 1
  /\ pc2' = 3
  /\ t2' = t2
  /\ UNCHANGED << t1, pc1 >>

fin1 ==
  /\ pc1 = 3
  /\ UNCHANGED << i, t1, pc1, t2, pc2 >>

fin2 ==
  /\ pc2 = 3
  /\ UNCHANGED << i, t1, pc1, t2, pc2 >>


Next == 
  \/ read1 \/ write1 \/ fin1
  \/ read2 \/ write2 \/ fin2

vars == << i, t1, pc1, t2, pc2 >>

Spec == Init /\ [][Next]_vars /\ WF_vars(read1) /\ WF_vars(write1) /\ WF_vars(fin1)
                              /\ WF_vars(read2) /\ WF_vars(write2) /\ WF_vars(fin2)

Properties == 
  /\ <>[](pc1 = 3 /\ pc2 = 3) \* Eventually it finishes
  /\ <>[](i = 2)
====
