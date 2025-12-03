library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Counter2bit is
    PORT (
        Clk : in STD_LOGIC;
        Clr : in STD_LOGIC;
        Qout : out std_logic_vector (1 downto 0)
    );
end Counter2bit;

architecture BehavioralCounterFSM of Counter2bit is

type state_type is (S0, S1, S2, S3);
signal currState, nxtState : state_type;

begin
cntState : process(Clr, Clk) 
begin 
    if Clr = '1' then
        currState <= S0;
    elsif (Clk'event and Clk = '1') then
        currState <= nxtState;
    end if;
end process;

fsmCount : process(currState)
begin
    case currState is 
        when S0 =>
            Qout <= "00";
            nxtState <= S1;
        when S1 =>
            Qout <= "01";
            nxtState <= S2;
        when S2 =>
            Qout <= "10";
            nxtState <= S3;
        when S3 =>
            Qout <= "11";
            nxtState <= S0;
        when others =>
            Qout <= "00";
            nxtState <= S0;
     end case;
end process;

end architecture;