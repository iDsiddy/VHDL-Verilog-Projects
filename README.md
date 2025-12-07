# **VHDL-Verilog-Projects**

A curated collection of small, well-scoped RTL designs implemented primarily in **VHDL** (with a few utilities in Verilog).  
This repository is structured as a **personal progress portfolio**, showcasing clean, synthesizable modules, simple testbenches, and organized documentation.  
Every block is designed to be **standalone, interview-ready, and easy to simulate**.

---

## **Skills Demonstrated**
- Synchronous digital design (clocked logic, resets, enables)
- Arithmetic blocks, counters, shift registers, basic control logic
- Writing synthesizable **VHDL** and lightweight testbenches
- Unit-level simulation using **GHDL + GTKWave**
- Clean project structuring using `rtl/`, `tb/`, `docs/`, `sim/`

---

## **Repository Layout (Top-Level)**

```
Basic-RTL/
│
├── Counters/
│ 	├── BinCounter.vhd
│ 	├── RingCounter.vhd
│ 	└── JohnsonCounter.vhd
│
├── Full Adder/
│ 	├── fullAdd1bit.vhd
│ 	├── fullAdd2bit.vhd
│ 	├── fullAdd4bit.vhd
│ 	└── fullAdd8bit.vhd
│
├── Parity Detector/
│	└── ParityCheck.vhd (Odd-1 Parity gen/check)
│
└── Shift Registers/
	├── P2S/
	├── S2P/
	├── Regular/
	└── Universal/

Applied-RTL-1/
│
├── ALU-16bit/
│
├── Elevator-CTRL/
│
├── Mini-RISC/
│
├── Traffic-Lights_CTRL/
│
├── UART-CTRL/
│
├── Vending-CTRL/
│
└── Shift Registers/
	
```

Each design folder typically follows:

- rtl/ — synthesizable source
- tb/ — testbench
- sim/ — waveforms or outputs
- docs/ — notes, diagrams (WIP)

---

## **Quick Start — Simulating with GHDL (Example)**

Quick start — simulate a block (GHDL, PowerShell examples) 1) Analyze the RTL and its testbench (adjust names to the specific block):
```powershell
	ghdl -a "Basic-RTL/Shift Registers/P2S/rtl/Parallel2Serial_ShiftReg.vhd"
	ghdl -a "Basic-RTL/Shift Registers/P2S/tb/your_testbench.vhd"
```
2) Elaborate the testbench entity (replace with the TB entity name):
```powershell
	ghdl -e your_testbench_entity_name
```
3) Run the simulation and create a VCD for waveform inspection:
```powershell
	ghdl -r your_testbench_entity_name --vcd=out.vcd
	gtkwave out.vcd
```

## **Purpose**

This repo exists as a learning-focused, clean reference set of small RTL modules.
Each design is meant to be:

- Easy to read & understand
- Easy to reuse
- Easy to simulate

## Notes

A lot of the design & testbench files and simulation outputs are a **Work in Progess**, a lot of furbishing goes into them. They will be added as and when completed, Thank you!

## **License**

MIT License — feel free to use any code from this repo.
