# Specifications modelling multiple processes concurrently incrementing a shared variable

This set of specifications is useful for demonstrating many of the interesting properties of TLA+, TLC and model checking.

- Single process `increment_1.tla`
  - Introduce TLA+ syntax and actions
  - Basic invariants and properties
  - Liveness properties, stuttering and fairness
- Two processes `increment_2.tla` and the corrected `increment_2_lock.tla`
  - How to model non-determinism in the `Next` formula
  - Counter-examples for properties and how we can fix it in this case
- Arbitrary processes `increment_g.tla` and `increment_g_lock.tla`
  - Complete (ish) TLA+ syntax
  - State space explosion (increase the number of processes in `increment_g.cfg` and `increment_g_lock.cfg`)
  - Symmetry reduction solving the state space explosion

To run: `tlc2 increment_{variant}.tla`.
