
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister_Serial2Parallel is
    Port (
        clk       : in  std_logic;
        clr       : in  std_logic;
        shift_en  : in  std_logic;
        serial_in : in  std_logic;
        q         : out std_logic_vector(3 downto 0)
    );
end ShiftRegister_Serial2Parallel;

architecture Behavioral of ShiftRegister_Serial2Parallel is
    signal shift : std_logic_vector(3 downto 0);
begin

shiftTransition : process(clk, clr) 
begin
    if clr = '1' then
        shift <= (others => '0');
    elsif (clk'event and clk = '1') then
        if shift_en = '1' then
            shift <= serial_in & shift(3 downto 1);
        end if;
    end if;
end process;

q <= shift;
end Behavioral;
