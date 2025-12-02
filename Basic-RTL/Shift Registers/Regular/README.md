# Regular Shift Register

This folder contains a simple 4-bit serial shift-register implementation and supporting materials.

Tree
- `docs/`  : design notes and documentation.
- `rtl/`   : VHDL sources (main RTL live here).
	- `ShiftRegister.vhd` : 4-bit serial shift register (serial-in, serial-out).
- `sim/`   : simulation scripts and waveform outputs.
- `tb/`    : testbenches used to verify the RTL.

RTL overview
- Entity: `ShiftRegister`
	- Ports: `clk`, `clr` (reset), `shift_en`, `serial_in`, `serial_out`.
	- Behavior: on `clr` the 4-bit internal `shift` register is cleared. On rising `clk` with `shift_en = '1'`,
		the register shifts right: `shift <= serial_in & shift(3 downto 1)`. `serial_out` is the LSB (`shift(0)`).
	- This implements a 4-bit right-shifting serial register where new bits enter at the MSB (`serial_in`).

Usage notes
- Drive `serial_in` and assert `shift_en` to shift data through the register and observe `serial_out`.
- `clr` asynchronously clears the register in the current RTL; handle in testbenches/synthesis flows.

See `tb/` for verification examples and `sim/` for waveforms.
