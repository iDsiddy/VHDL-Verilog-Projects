# **VHDL · RTL Projects**

Small, synthesizable RTL designs with clean testbenches and simulation results.

![VHDL](https://img.shields.io/badge/VHDL-005F9E.svg?style=flat&logo=vhdl&logoColor=white)
![RTL Design](https://img.shields.io/badge/RTL-Design-blueviolet)
![Synthesizable](https://img.shields.io/badge/Synthesizable-Yes-brightgreen)
![GHDL](https://img.shields.io/badge/GHDL-Simulator-purple)
![Vivado](https://img.shields.io/badge/Xilinx-Vivado-orange)
![FPGA Ready](https://img.shields.io/badge/FPGA-Ready-blue)
![Portfolio](https://img.shields.io/badge/Portfolio-RTL%20Design-critical)
![License](https://img.shields.io/badge/License-MIT-green)


A clean, organized collection of small RTL modules written in **VHDL**, along with simple testbenches and simulation results.  
This repository serves as a **personal learning portfolio** and a reusable reference for anyone practicing digital design.

---

## **Skills Demonstrated**
- Synchronous digital design (FSMs, counters, shift registers)
- Writing synthesizable **VHDL** and lightweight testbenches
- Unit simulation using **GHDL** & **Vivado**
- Building reusable, beginner friendly yet complex RTL components

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


Applied-RTL-1/	(WIP)
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
└── Vending-CTRL/
	
```

Each design folder typically follows:

- rtl/ — synthesizable source
- tb/ — testbench
- sim/ — waveforms or outputs
- docs/ — notes, diagrams (WIP)

---

## **Simulating with GHDL (Example)**

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

## **Simulating in Vivado (Alternative)**

1. Add RTL + Testbench using Add Sources → Simulation Sources
2. Set the testbench as Simulation Top
3. Run Behavioral Simulation
4. View waveforms in the simulator

## **Purpose**

This repo exists as a learning-focused, clean reference set of small RTL modules.
Each design is meant to be:

- Easy to read, understand & synthesize
- Reusability
- Easy to simulate

## **Up-Coming**

- 16-bit ALU
- Elevator FSM
- Traffic Light FSM
- Vending Machine FSM
- UART TX/RX
- Mini-RISC Processor datapath components

## **License**

MIT License — feel free to use any code from this repo.
