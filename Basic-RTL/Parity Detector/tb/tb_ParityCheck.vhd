
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.ALL;

entity tb_ParityCheck is
end tb_ParityCheck;

architecture Behavioral of tb_ParityCheck is
    signal clk : std_logic  := '0';
    signal rst : std_logic  := '1';

    signal x : std_logic;
    signal y : std_logic;
begin

dut: entity work.ParityCheck
    port map (
        clk => clk,
        rst => rst,
        x => x,
        y => y
    );
    
    
    clk <= not clk after 5 ns;  -- Clock Period = 10 ns
    
stim: process
begin

    wait for 20 ns;
    rst <= '0';     -- Release Reset
    
    -- Test Vector "101100110101", expected parity output: "1"
    x <= '1'; wait for 10 ns;
    x <= '0'; wait for 10 ns;
    x <= '1'; wait for 10 ns;
    x <= '1'; wait for 10 ns;
    x <= '0'; wait for 10 ns;
    x <= '0'; wait for 10 ns;
    x <= '1'; wait for 10 ns;
    x <= '0'; wait for 10 ns;
    x <= '1'; wait for 10 ns;
    x <= '1'; wait for 10 ns;
    x <= '0'; wait for 10 ns;
    x <= '1'; wait for 10 ns;
    
    wait for 10 ns;
    assert false report "Simulation Finished" severity failure; -- End simulation

    wait;
    
end process stim;

end Behavioral;
