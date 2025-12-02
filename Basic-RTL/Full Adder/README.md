
## Overview
- Purpose: demonstrate modular arithmetic design using a ripple-carry adder built from 1-bit full-adder building blocks.
- Focus: clear separation between behavioral and structural styles; emphasis on reusability and testability.

## Files
- `rtl/fullAdd8bit.vhd` — top-level 8-bit adder (structural composition of 1-bit full-adders).

## Design approach
- Structural architecture: the top-level 8-bit adder is implemented using a `structural` architecture that instantiates multiple 1-bit full-adder components and connects them with `port map` statements. This approach explicitly shows how small, well-defined modules compose into larger systems and makes dataflow and carry propagation visible.

- Abstraction & modularity via `port map`: each 1-bit full-adder exposes a fixed interface (A, B, Cin, Sum, Cout). The top-level `port map` binds signals between instances, so the internal implementation of a 1-bit adder can be changed without modifying the top-level wiring. This demonstrates clean abstraction boundaries and easier unit testing.

## Why structural design here
- Teaches hardware composition: structural code mirrors physical gate/register interconnections and is helpful for understanding timing and carry chains.
- Reusability: 1-bit full-adder is a reusable building block; the same component can be used in different widths or other arithmetic circuits.
- Testability: unit-test 1-bit blocks independently, then run integration tests on the 8-bit wrapper.

## Example (conceptual) 
This is a short port mapping display for a 2-bit Full Adder from a 1-bit Full Adder: 
```
-- instantiate AFA0 (LSB)
FA_inst0: entity work.FullAdder1bit
	port map (
		A => A(0),
		B => B(0),
		Cin => Cin,
		Sum => Sum(0),
		Cout => c1
	);

-- instantiate AFA1
FA_inst1: entity work.FullAdder1bit
	port map (
		A => A(1),
		B => B(1),
		Cin => c1,
		Sum => Sum(1),
		Cout => c2
	);
```

## Testing and simulation
- The folder includes a simple testbench that exercises addition, carry propagation, and edge cases. Run the testbench with a VHDL simulator (e.g., GHDL) and inspect waveforms with GTKWave.

## Notes

A related Lab Report for the same has been uploaded in /docs for further conceptual depth