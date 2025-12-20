library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_ALU is
end tb_ALU;


architecture Behavioral of tb_alu is

    signal A, B : std_logic_vector(15 downto 0);
    signal Op : std_logic_vector(1 downto 0);
    signal Result : std_logic_vector(15 downto 0);
    signal Zero : std_logic;
    signal CLR : std_logic := '0';

begin

    dut: entity work.ALU16bit
        port map (
            A => A,
            B => B,
            Op => Op,
            Result => Result,
            Zero => Zero,
            CLR => CLR
        );

    stim_proc: process
    begin		
        -- Test AND operation
        A <= x"0F0F"; B <= x"00FF"; Op <= "00";
        wait for 100 ns;
        
        -- Test OR operation
        A <= x"0F0F"; B <= x"00FF"; Op <= "01";
        wait for 100 ns;
        
        -- Test ADD operation
        A <= x"0001"; B <= x"0001"; Op <= "10";
        wait for 100 ns;
        
        -- Test SUB operation
        A <= x"0002"; B <= x"0001"; Op <= "11";
        wait for 100 ns;
        
        -- Test Zero flag
        A <= x"0001"; B <= x"0001"; Op <= "11";
        wait for 100 ns;

        -- Test Clear functionality
        A <= x"0005"; B <= x"0003"; Op <= "10";
        wait for 50 ns;
        CLR <= '1';
        wait for 50 ns;

        wait;
    end process;

end architecture;
