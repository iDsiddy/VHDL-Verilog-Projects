library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.ALL;

entity tb_counter is
end tb_counter;

architecture Behavioral of tb_counter is

    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';
    signal output : std_logic_vector(3 downto 0);   -- Adjust size as per counter width

begin

    dut: entity work.<Counter_Name>     
        port map (
            CLK => clk,
            PRE => reset,   
            Q   => output
        );

    clk <= not clk after 5 ns;  -- Clock Period = 10 ns

    stimulus: process
    begin
        
        reset <= '1';
        wait for 20 ns;     -- Release reset after 2 cycles

        reset <= '0';
        
        wait for 200 ns;    -- Let it run for a few cycles

        assert false report "Simulation Finished" severity failure;
        wait;
    end process;

end Behavioral;
