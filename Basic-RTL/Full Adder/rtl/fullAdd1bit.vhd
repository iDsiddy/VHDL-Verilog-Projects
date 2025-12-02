library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fullAdd1bit is
    PORT(
        A : in std_logic;
        B : in std_logic;
        CIN : in std_logic;
        S : out std_logic;
        COUT : out std_logic
     );
end fullAdd1bit;

architecture Structural of fullAdd1bit is
begin
    S <= A xor B xor CIN;
    COUT <= (A and B) or (A and CIN) or (B and CIN);
end Structural;


