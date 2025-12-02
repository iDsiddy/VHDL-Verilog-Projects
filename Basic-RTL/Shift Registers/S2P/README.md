# Serial-to-Parallel (S2P)

This folder contains a 4-bit Serial-to-Parallel shift register implementation and supporting materials.

Tree
- `docs/`  : design notes and documentation.
- `rtl/`   : VHDL sources (main RTL live here).
	- `Serial2Parallel_ShiftReg.vhd` : 4-bit serial-in to parallel-out register.
- `sim/`   : simulation scripts and waveform outputs.
- `tb/`    : testbenches used to verify the RTL.

RTL overview
- Entity: `ShiftRegister_Serial2Parallel`
	- Ports: `clk`, `clr` (reset), `shift_en`, `serial_in`, `q : out std_logic_vector(3 downto 0)`.
	- Behavior: on `clr` the internal 4-bit `shift` is cleared. On rising `clk` with `shift_en = '1'`,
		the register shifts right with `shift <= serial_in & shift(3 downto 1)`; the full register is exposed on `q`.
	- This captures a serial data stream (MSB-first into the register MSB) and provides the 4-bit parallel output.

Usage notes
- Feed `serial_in` with the bit stream and enable `shift_en` for each bit-clock; read the assembled 4-bit word on `q`.
- Use `tb/` to see example stimulus and `sim/` for produced waveforms.

