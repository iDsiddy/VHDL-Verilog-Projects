
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ParityCheck is
    port (
        clk : in std_logic;
        rst : in std_logic;
        x : in std_logic;
        y : out std_logic
    );
end ParityCheck;

architecture Behavioral of ParityCheck is
type state_type is (S0, S1);
signal current_state, next_state : state_type;
begin
    
-- State Register Control
rstFunc : process(clk, rst)
begin
    if rst = '1' then
        current_state <= S0;
    elsif (clk'event and clk = '1') then
        current_state <= next_state;
    end if;
end process;

-- Next State Logic Control
nextStateLogic : process(current_state, x)
begin 
    case current_state is
        when S0 =>
            if x = '1' then
                next_state <= S1;
            else
                next_state <= S0;
            end if;
            
        when S1 =>
            if x = '1' then
                next_state <= S0;
            else
                next_state <= S1;
            end if;
    end case;
end process;

-- Output Logic (Moore)
y <= '1' when current_state = S1 else '0'; 
end Behavioral;
