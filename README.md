# FPGA Millennium Clock (HDL)

## Overview
A synthesizable Verilog clock for Altera DE2 that displays time or date on 8 seven-segment digits. The design provides manual setting controls, blinking feedback for the selected field, and correct month/leap-year handling.

## Features
- Time display (HH:MM:SS) and date display (DD/MM/YYYY)
- Manual set for seconds, minutes, hours, day, month, and year
- Blinking of the selected field during adjustment
- Correct month lengths and leap-year support
- 1 Hz time base derived from the 50 MHz DE2 clock

## Hardware Requirements
- Altera DE2 kit (50 MHz system clock, 18 slide switches, 8 seven-seg digits)
- Quartus (project setup and synthesis)
- QuestaSim 10.7c (simulation)

## Pinout
Top-level module: `top_module`

Inputs:
- `clk_50MHz`: 50 MHz clock from DE2
- `SW[17:0]`: slide switches

Outputs:
- `HEX7..HEX0`: seven-segment outputs (active-low segments)

Switch mapping:
- `SW[0]`  : `mode_date` (0 = time, 1 = date)
- `SW[1]`  : set seconds
- `SW[2]`  : set minutes
- `SW[3]`  : set hours
- `SW[4]`  : set day
- `SW[5]`  : set month
- `SW[6]`  : set year
- `SW[15]` : increment selected field
- `SW[16]` : decrement selected field
- `SW[17]` : `rst_n` (active-low reset)

Notes:
- Reset with `SW[17] = 0`, run with `SW[17] = 1`.
- When any set switch is active, the time base freezes and the selected field blinks.

## Synthesis/Build (Quartus)
1) Create a new Quartus project and add all `*.v` files in this repo.
2) Set the top-level entity to `top_module`.
3) Assign pins for `clk_50MHz`, `SW[17:0]`, and `HEX7..HEX0` to match the DE2 board.
4) Compile the project and program the FPGA.

## Simulation (QuestaSim 10.7c)
A basic testbench is provided in `tb_top_counter.v`.

Example flow:
1) Compile all RTL files and the testbench.
2) Run the `tb_top_counter` simulation.
3) The testbench prints time/date on each 1 Hz tick and writes a VCD file.

## Usage
- `SW[0]` selects display mode: time or date.
- Use `SW[1]..SW[6]` to choose the field to adjust.
- Use `SW[15]` to increment and `SW[16]` to decrement.
- The active field blinks while being adjusted.

## Contributing
Contributions are welcome. Please open an issue or submit a pull request with a clear description of changes and test coverage.

## License
MIT. See `LICENSE`.
