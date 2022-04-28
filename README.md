# Specifications modelling multiple processes concurrently incrementing a shared variable

This set of specifications is useful for demonstrating many of the interesting properties of TLA+, TLC and model checking.

- Single process `increment_1.tla`
  - Introduce TLA+ syntax and actions
  - Basic invariants and properties
- Two processes `increment_2.tla`
  - How to model non-determinism in the `Next` formula
  - Counter-examples for properties
  - Liveness properties and fairness
- Arbitrary processes `increment_g.tla`
  - Complete (ish) TLA+ syntax
  - State space explosion
  - Symmetry reduction solving the state space explosion
- Locking variants `increment_[2,g]_lock.tla`
  - Fixes for the counter-examples

To run: `tlc2 increment_{variant}.tla`.
