
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity UnivSerialRegister is
    port (
        CP, CLR, Serial_IN  : in std_logic;
        CTRL                : in std_logic_vector(1 downto 0);
        LOAD                : in std_logic_vector(3 downto 0);
        parOUT              : out std_logic_vector(3 downto 0);
        serial_LOUT         : out std_logic;
        serial_ROUT         : out std_logic
    );        
end UnivSerialRegister;

architecture Behavioral of UnivSerialRegister is
signal shift : std_logic_vector(3 downto 0);
begin
transition : process(CP, CLR)
begin
    if CLR = '1' then
        shift <= (others => '0');
    elsif rising_edge(CP) then
        case CTRL is
            when "00" =>  -- Hold
                shift <= shift;
            when "01" =>  -- Shift Right
                shift <= Serial_IN & shift(3 downto 1);
            when "10" =>  -- Shift Left
                shift <= shift(2 downto 0) & Serial_IN;
            when "11" =>  -- Load Parallel
                shift <= LOAD;
            when others =>
                shift <= shift;
        end case;
    end if;
end process;

parOUT <= shift;
serial_ROUT <= shift(0);
serial_LOUT <= shift(3);

end Behavioral;
