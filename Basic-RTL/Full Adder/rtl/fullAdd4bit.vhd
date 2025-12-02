
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fullAdd4bit is 
    PORT (
        Xin : in std_logic_vector(3 downto 0);
        Yin : in std_logic_vector(3 downto 0);
        Cin : in std_logic;
        Sout : out std_logic_vector(3 downto 0);
        Cout: out std_logic
    );
end fullAdd4bit;

architecture structural of fullAdd4bit is
component fullAdd1bit is
    PORT(
        A : in std_logic;
        B : in std_logic;
        CIN : in std_logic;
        S : out std_logic;
        COUT : out std_logic
     );
end component;

signal c0, c1, c2 : std_logic;  -- Carry signals between the full adders

begin
    S0 :  fullAdd1bit PORT MAP (A => Xin(0), B => Yin(0), CIN => Cin, S => Sout(0), COUT => c0);
    S1 :  fullAdd1bit PORT MAP (A => Xin(1), B => Yin(1), CIN => c0, S => Sout(1), COUT => c1);
    S2 :  fullAdd1bit PORT MAP (A => Xin(2), B => Yin(2), CIN => c1, S => Sout(2), COUT => c2);
    S3 :  fullAdd1bit PORT MAP (A => Xin(3), B => Yin(3), CIN => c2, S => Sout(3), COUT => Cout);
    
end structural;