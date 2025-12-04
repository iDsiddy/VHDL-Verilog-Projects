# Counters

This folder contains small synchronous counter examples written in VHDL. They are compact, synthesizable, and suitable for interview demonstrations of FSMs, shift registers, and sequential logic.

## Summary of RTL files (in `rtl/`)

- `Counter2bit` (file: `BinCounter.vhd`): 2-bit binary counter implemented as a small FSM.
	- Ports:
		- `Clk` : in std_logic — clock input
		- `Clr` : in std_logic — synchronous/asynchronous clear (used in the sensitivity list)
		- `Qout`: out std_logic_vector(1 downto 0) — 2-bit count output
	- Behavior: cycles through states S0..S3 producing `00`, `01`, `10`, `11` (implemented with explicit state encoding in an FSM design process).

- `RingCounter.vhd`: 4-bit ring counter
	- Ports: `CLK`, `PRE` (preset), `Q` (4-bit output)
	- Behavior: on `PRE='1'` sets `Q` to `0001`. On rising `CLK` rotates the 1 through the 4-bit vector (ring shift).

- `JohnsonCounter.vhd`: 4-bit Johnson (twisted ring) counter
	- Ports: `CLK`, `PRE`, `Q` (4-bit)
	- Behavior: on `PRE='1'` initializes `Q` to all ones. On rising `CLK` shifts with inverted feedback from LSB to MSB producing the Johnson sequence.

## Folder layout

- `rtl/` — VHDL sources.
- `tb/`  — testbenches.
- `sim/` — simulation outputs and waveforms.
- `docs/` — design notes and explanation (if present).

## Simulation Demo (GHDL)

Example PowerShell workflow to simulate `RingCounter` after adding a testbench `tb/ringcounter_tb.vhd`:

```powershell
ghdl -a "Basic-RTL/Counters/rtl/RingCounter.vhd"
ghdl -a "Basic-RTL/Counters/tb/ringcounter_tb.vhd"
ghdl -e ringcounter_tb
ghdl -r ringcounter_tb --vcd=ringcounter.vcd
gtkwave ringcounter.vcd
```
