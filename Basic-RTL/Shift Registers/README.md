# Shift Registers — Collection Overview

This folder collects small, interview-ready shift-register examples implemented in VHDL. Each variant demonstrates a common shift-register use case and highlights design choices (parallel load, serial capture, bidirectional shifting, and a universal control interface).

## Layout
- `PISO/` (Parallel-In Serial-Out) — `rtl/Parallel2Serial_ShiftReg.vhd`
- `SIPO/` (Serial-In Parallel-Out) — `rtl/Serial2Parallel_ShiftReg.vhd`
- `Regular/` — basic serial shift register (`rtl/ShiftRegister.vhd`)
- `Universal/` — universal serial register with mode control (`rtl/UnivSerialRegister.vhd`)

## Design summaries

- `PISO/rtl/Parallel2Serial_ShiftReg.vhd`
	- Purpose: Load a 4-bit parallel word and produce it serially at the LSB output.
	- Ports: `parallel_in : in std_logic_vector(3 downto 0)`, `clk`, `rst`, `shift_en`, `load`, `q : out std_logic`.
	- Behavior: On `rst` clears internal register. On rising `clk`:
		- if `load = '1'` the 4-bit `parallel_in` is loaded, else if `shift_en = '1'` the register shifts right (logical shift) and `q` reflects current LSB.

- `SIPO/rtl/Serial2Parallel_ShiftReg.vhd`
	- Purpose: Capture a serial bitstream into a 4-bit parallel word.
	- Ports: `clk`, `clr`, `shift_en`, `serial_in`, `q : out std_logic_vector(3 downto 0)`.
	- Behavior: On `clr` clears the register. On rising `clk` with `shift_en='1'` the register shifts right inserting `serial_in` at MSB; `q` exposes the full parallel contents.

- `Regular/rtl/ShiftRegister.vhd`
	- Purpose: Simple 4-bit serial register (illustrates basic shifting mechanics).
	- Ports: `clk`, `clr`, `shift_en`, `serial_in`, `serial_out`.
	- Behavior: On each enabled clock it shifts right with `serial_in` entering the MSB; `serial_out` is the LSB.

- `Universal/rtl/UnivSerialRegister.vhd`
	- Purpose: 4-bit universal register supporting hold, shift-right, shift-left, and parallel load via control signals.
	- Ports: `CP` (clock), `CLR` (reset), `Serial_IN`, `CTRL : std_logic_vector(1 downto 0)`, `LOAD : std_logic_vector(3 downto 0)`, `parOUT : out std_logic_vector(3 downto 0)`, `serial_LOUT`, `serial_ROUT`.
	- Behavior: On `CTRL`:
		- `"00"` : Hold
		- `"01"` : Shift Right (Serial_IN -> MSB)
		- `"10"` : Shift Left (Serial_IN -> LSB)
		- `"11"` : Parallel Load from `LOAD`
	- Outputs: `parOUT` (entire register), `serial_LOUT` (MSB), `serial_ROUT` (LSB).

## Design notes (interview-ready talking points)

- Abstraction: each module exposes a small, well-documented interface; internals are encapsulated so implementations can be replaced without changing the interface.
- Port mapping and modularity: the universal register shows how a single component can support multiple behaviors with a small control bus (2-bit `CTRL`) rather than separate modules for each mode.
- Reset semantics: some modules use `clr`/`rst` in the sensitivity list and others check `rising_edge(clk)`; discuss synchronous vs asynchronous reset conventions and how that affects synthesis and timing.
- Scaling: the core patterns (shift, load, hold) scale naturally to larger widths; mention trade-offs (serial shifting is area-efficient but slower than parallel operations).

## Simulation Demo (GHDL, PowerShell)

Example: simulate `Parallel2Serial_ShiftReg` once you have a testbench `PISO/tb/p2s_tb.vhd`:

```powershell
ghdl -a "Basic-RTL/Shift Registers/PISO/rtl/Parallel2Serial_ShiftReg.vhd"
ghdl -a "Basic-RTL/Shift Registers/PISO/tb/p2s_tb.vhd"
ghdl -e p2s_tb
ghdl -r p2s_tb --vcd=p2s_out.vcd
gtkwave p2s_out.vcd
```

Paths containing spaces are quoted above for PowerShell. Replace testbench names and entities with the actual filenames used in the `tb/` folders.
