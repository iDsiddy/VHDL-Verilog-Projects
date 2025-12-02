# Universal Serial Register

This folder contains a 4-bit universal serial register — a small register that supports hold, shift-left,
shift-right and parallel load — plus supporting materials.

Tree
- `docs/`  : design notes and documentation.
- `rtl/`   : VHDL sources (main RTL live here).
	- `UnivSerialRegister.vhd` : universal 4-bit serial register with control signals.
- `sim/`   : simulation scripts and waveform outputs.
- `tb/`    : testbenches used to verify the RTL.

RTL overview
- Entity: `UnivSerialRegister`
	- Ports:
		- Inputs: `CP` (clock), `CLR` (reset), `Serial_IN`, `CTRL : std_logic_vector(1 downto 0)`, `LOAD : std_logic_vector(3 downto 0)`.
		- Outputs: `parOUT : std_logic_vector(3 downto 0)`, `serial_LOUT` (MSB), `serial_ROUT` (LSB).
	- Behavior (on rising edge of `CP` unless `CLR` asserted):
		- `CTRL = "00"` : Hold (no change).
		- `CTRL = "01"` : Shift Right — `Serial_IN` enters MSB, data moves toward LSB.
		- `CTRL = "10"` : Shift Left — `Serial_IN` enters LSB, data moves toward MSB.
		- `CTRL = "11"` : Parallel Load — `LOAD` value is loaded into the register.
	- Outputs: `parOUT` shows the full 4-bit content, `serial_ROUT` is the LSB, `serial_LOUT` is the MSB.

Usage notes
- Use the 2-bit `CTRL` to choose operation mode. Provide `LOAD` for parallel write when `CTRL = "11"`.
- The source includes `UNISIM` in the use-clause but does not instantiate vendor primitives — safe for simulation.
- Consult `tb/` for sample control sequences demonstrating all modes.

