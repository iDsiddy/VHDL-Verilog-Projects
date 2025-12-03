library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity RingCounter is
    port ( 
        CLK, PRE : in std_logic;
        Q : out std_logic_vector(3 downto 0)
    );
end RingCounter;

architecture Behavioral of RingCounter is

    signal shift : std_logic_vector(3 downto 0) := (others => '0');
    
begin

func : process(CLK, PRE) 
begin
    
    if PRE = '1' then
        shift <= (others => '0');
        shift(0) <= '1';
    elsif rising_edge(CLK) then
        shift(3) <= shift(0);
        shift(2 downto 0) <= shift(3 downto 1);
    end if;    
end process;

Q <= shift;

end Behavioral;
