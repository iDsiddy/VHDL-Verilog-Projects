# Parity Detector

This folder contains a small, interview-friendly parity-check example implemented as a Moore finite state machine in VHDL.

## Summary of RTL
- `rtl/ParityCheck.vhd` — Parity check FSM (Moore machine)
  - Ports:
    - `clk : in std_logic` — clock
    - `rst : in std_logic` — synchronous reset (active high)
    - `x   : in std_logic` — serial input bit stream
    - `y   : out std_logic` — parity output (1 when odd parity seen)
  - Behavior: two-state FSM (`S0`, `S1`) tracks parity of incoming bits on `x`.
    - `S0` represents even parity (output `y = 0`)
    - `S1` represents odd parity (output `y = 1`)
    - On each rising `clk`, the FSM updates state based on `x` (if `x='1'` the parity toggles).
  - Implementation details: Moore output assigned directly from `current_state`, state register in one clocked process, combinational next-state logic in a separate process.

## Folder layout
- `rtl/` — VHDL sources 
- `tb/`  — testbenches
- `sim/` — simulation outputs
- `docs/` — design notes and explanation (if present).

## Simulation Demo (GHDL, PowerShell)

1) Add or create a testbench `tb/paritycheck_tb.vhd` that toggles `rst`, drives `x` with bit patterns, and checks `y`.

2) Example commands (replace TB filename/entity as needed):

```powershell
ghdl -a "Basic-RTL/Parity Detector/rtl/ParityCheck.vhd"
ghdl -a "Basic-RTL/Parity Detector/tb/paritycheck_tb.vhd"
ghdl -e paritycheck_tb
ghdl -r paritycheck_tb --vcd=paritycheck.vcd
gtkwave paritycheck.vcd
```