library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity RISC_V is
    Port ( CLK : in STD_LOGIC;
           CLR : in STD_LOGIC;
           Instruction : in STD_LOGIC_VECTOR(31 downto 0);
           Result : out STD_LOGIC_VECTOR(15 downto 0);
           Zero : out STD_LOGIC);
end RISC_V;

architecture Behavioral of RISC_V is

    signal PC : unsigned(15 downto 0) := (others => '0');
    signal RegFile : array(0 to 31) of unsigned(15 downto 0);
    signal ALUResult : unsigned(15 downto 0);
    signal ALUZero : std_logic;

begin

    process(CLK, CLR)
    begin
        if CLR = '1' then
            PC <= (others => '0');
            RegFile <= (others => (others => '0'));
        elsif rising_edge(CLK) then
            -- Fetch instruction
            -- Decode and execute instruction
            -- For simplicity, we will just perform an ADD operation
            ALUResult <= RegFile(to_integer(unsigned(Instruction(19 downto 15)))) + 
                         RegFile(to_integer(unsigned(Instruction(24 downto 20))));
                         
            -- Write back result to register file
            RegFile(to_integer(unsigned(Instruction(11 downto 7)))) <= ALUResult;
            
            -- Update Zero flag
            if ALUResult = 0 then
                ALUZero <= '1';
            else
                ALUZero <= '0';
            end if;
            
            -- Increment PC
            PC <= PC + 4;
        end if;
    end process;

    Result <= std_logic_vector(ALUResult);
    Zero <= ALUZero;

end Behavioral;