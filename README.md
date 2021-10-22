# TLA+ specifications for multiple nodes performing `i += 1` concurrently

To run each use `tlc2 increment_{variant}.tla`.

Variants available:
- increment_1: single process increment
- increment_2: two process increment
- increment_g: n-process increment
- increment_*_lock: variant with a locking primitive to ensure correctness
