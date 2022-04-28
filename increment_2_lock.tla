---- MODULE increment_2_lock ----

EXTENDS Integers

(* 0: lock
 * 1: t = i;
 * 2: i = t + 1;
 * 3: unlock
 * 4: fin
 *)

VARIABLES i, t1, pc1, t2, pc2, lock

Init == 
  /\ i = 0
  /\ t1 = -1 /\ pc1 = 0
  /\ t2 = -1 /\ pc2 = 0
  /\ lock = FALSE

lock1 ==
  /\ pc1 = 0
  /\ ~lock
  /\ lock' = TRUE
  /\ pc1' = 1
  /\ UNCHANGED << i, t1, t2, pc2 >>

lock2 ==
  /\ pc2 = 0
  /\ ~lock
  /\ lock' = TRUE
  /\ pc2' = 1
  /\ UNCHANGED << i, t2, t1, pc1 >>

read1 ==
  /\ pc1 = 1
  /\ t1' = i
  /\ pc1' = 2
  /\ UNCHANGED << i, t2, pc2, lock >>

read2 ==
  /\ pc2 = 1
  /\ t2' = i
  /\ pc2' = 2
  /\ UNCHANGED << i, t1, pc1, lock >>

write1 ==
  /\ pc1 = 2
  /\ i' = t1 + 1
  /\ pc1' = 3
  /\ t1' = t1
  /\ UNCHANGED << t2, pc2, lock >>

write2 ==
  /\ pc2 = 2
  /\ i' = t2 + 1
  /\ pc2' = 3
  /\ t2' = t2
  /\ UNCHANGED << t1, pc1, lock >>

unlock1 ==
  /\ pc1 = 3
  /\ lock
  /\ lock' = FALSE
  /\ pc1' = 4
  /\ UNCHANGED << i, t1, t2, pc2 >>

unlock2 ==
  /\ pc2 = 3
  /\ lock
  /\ lock' = FALSE
  /\ pc2' = 4
  /\ UNCHANGED << i, t2, t1, pc1 >>

fin1 ==
  /\ pc1 = 4
  /\ UNCHANGED << i, t1, pc1, t2, pc2, lock >>

fin2 ==
  /\ pc2 = 4
  /\ UNCHANGED << i, t1, pc1, t2, pc2, lock >>


Next == 
  \/ lock1 \/ read1 \/ write1 \/ unlock1 \/ fin1
  \/ lock2 \/ read2 \/ write2 \/ unlock2 \/ fin2

vars == << i, t1, pc1, t2, pc2, lock >>

Spec == Init /\ [][Next]_vars /\ WF_vars(read1) /\ WF_vars(write1) /\ WF_vars(lock1) /\ WF_vars(unlock1)
                              /\ WF_vars(read2) /\ WF_vars(write2) /\ WF_vars(lock2) /\ WF_vars(unlock2)

Properties == 
  /\ <>[](pc1 = 4 /\ pc2 = 4)
  /\ <>[](i = 2)
====
