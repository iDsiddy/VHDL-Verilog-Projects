library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fullAdd8bit is
    Port (
        X    : in  std_logic_vector(7 downto 0);
        Y    : in  std_logic_vector(7 downto 0);
        Cin  : in  std_logic;
        Sum  : out std_logic_vector(7 downto 0);
        Cout : out std_logic
    );
end fullAdd8bit;

architecture structural of fullAdd8bit is
    -- Internal carry signals
    signal carry : std_logic_vector(8 downto 0);
begin
    -- Connect input carry
    carry(0) <= Cin;

    -- Instantiate 8 one-bit full adders
    gen_adders: for i in 0 to 7 generate
        fa: entity work.fullAdd1bit
            port map (
                A    => X(i),
                B    => Y(i),
                Cin  => carry(i),
                Sum  => Sum(i),
                Cout => carry(i+1)
            );
    end generate;

    -- Final carry out
    Cout <= carry(8);

end structural;
