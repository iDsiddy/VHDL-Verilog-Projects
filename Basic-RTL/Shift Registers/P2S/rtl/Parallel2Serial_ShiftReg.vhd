
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Parallel2Serial_ShiftReg is
    port (
        parallel_in : in std_logic_vector(3 downto 0);
        clk : in std_logic;
        rst : in std_logic;
        shift_en : in std_logic;
        load : in std_logic; 
        q : out std_logic
    );
end Parallel2Serial_ShiftReg;

architecture Behavioral of Parallel2Serial_ShiftReg is
    signal temp : std_logic_vector(3 downto 0);
begin

shiftTransition : process(clk, rst) 
begin
    if rst = '1' then
        temp <= (others => '0');
    elsif (clk'event and clk = '1') then
        if load = '1' then
            temp <= parallel_in;
        elsif shift_en = '1' then
            temp <= '0' & temp (3 downto 1);
        end if;
    end if;
end process;

q <= temp(0);
end Behavioral;
