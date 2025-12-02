
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister is
    Port (
        clk        : in  std_logic;
        clr        : in  std_logic;
        shift_en   : in  std_logic;
        serial_in  : in  std_logic;
        serial_out : out std_logic
    );
end ShiftRegister;

architecture Behavioral of ShiftRegister is
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

serial_out <= shift(0);
end Behavioral;
