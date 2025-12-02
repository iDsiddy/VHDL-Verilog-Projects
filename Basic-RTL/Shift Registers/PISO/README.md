# Parallel-to-Serial (P2S)

This folder contains an implementation of a 4-bit Parallel-to-Serial shift register and supporting material.

Tree
- `docs/`  : design notes, specifications, and diagrams.
- `rtl/`   : VHDL sources (main RTL live here).
	- `Parallel2Serial_ShiftReg.vhd` : 4-bit parallel-in, serial-out register.
- `sim/`   : simulation scripts and waveform outputs.
- `tb/`    : testbenches used to verify the RTL.

RTL overview
- Entity: `Parallel2Serial_ShiftReg`
	- Ports: `parallel_in : in std_logic_vector(3 downto 0)`, `clk`, `rst`, `shift_en`, `load`, `q : out std_logic`.
	- Behavior: on `rst` the internal 4-bit register `temp` is cleared. On rising `clk`:
		- if `load = '1'` then `temp` <= `parallel_in` (parallel load),
		- elsif `shift_en = '1'` then `temp` <= `'0' & temp(3 downto 1)` (logical right-shift with '0' shifted into MSB).
	- Output: `q` drives the current LSB (`temp(0)`), producing a serial bit stream.

Usage notes
- To output the loaded parallel word serially, assert `load` for one clock, then enable `shift_en` for subsequent clocks.
- `rst` is asynchronous in the source; use appropriately in testbenches and synthesis constraints.

See `tb/` for example testbenches and `sim/` for waveforms.
