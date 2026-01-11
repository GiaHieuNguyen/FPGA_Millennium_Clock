# Contributing

Thanks for your interest in improving this project. This guide keeps changes
consistent and easy to review.

## Workflow
1) Fork the repo and create a feature branch.
2) Keep changes focused and well-scoped.
3) Update documentation when behavior changes.
4) Run simulation (or explain why you could not).
5) Open a pull request with a clear summary.

## Code style
- Use Verilog-2001 syntax.
- Keep module interfaces stable unless the change is intentional and documented.
- Prefer simple, readable logic and avoid unnecessary complexity.
- Add brief comments only where needed to explain non-obvious behavior.

## Simulation (QuestaSim 10.7c)
Testbench: `sim/tb_top_counter.v`

Example commands:
```sh
vlib work
vlog hdl/*.v sim/tb_top_counter.v
vsim tb_top_counter
run -all
```

The testbench prints time/date at each 1 Hz tick and writes a VCD file.

## Quartus (DE2)
For synthesis, add all `hdl/*.v` files to your Quartus project and set the
top-level entity to `top_module`.

## Reporting issues
When reporting a bug, include:
- Steps to reproduce
- Expected vs actual behavior
- Simulator or Quartus version
- Any relevant logs or waveforms
