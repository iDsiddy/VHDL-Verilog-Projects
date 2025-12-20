library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-----------------------------------------------------------------
--   16-bit ALu with basic operations: AND, OR, ADD, SUB 
--   These operations can be changed by modifying the Op input
-----------------------------------------------------------------

entity ALU16bit is
    Port ( CLR : in STD_LOGIC := '0';
           A : in STD_LOGIC_VECTOR(15 downto 0);
           B : in STD_LOGIC_VECTOR(15 downto 0);
           Op : in STD_LOGIC_VECTOR(1 downto 0);
           Result : out STD_LOGIC_VECTOR(15 downto 0);
           Zero : out STD_LOGIC);
end ALU16bit;

architecture Behavioral of ALU16bit is

signal Y : STD_LOGIC_VECTOR(15 downto 0);  

begin
    process(A, B, Op, CLR)
    begin
        if CLR = '1' then
            Y <= (others => '0');
        else
            case Op is
                when "00" =>  -- AND operation
                    Y <= A and B;
                when "01" =>  -- OR operation
                    Y <= A or B;
                when "10" =>  -- ADD operation
                    Y <= std_logic_vector(unsigned(A) + unsigned(B));
                when "11" =>  -- SUB operation
                    Y <= std_logic_vector(unsigned(A) - unsigned(B));
                when others =>
                    Y <= (others => '0');
            end case;
        end if;
    end process;
    
    Result <= Y;
    Zero <= '1' when (unsigned(Y) = 0) else '0';
    
end Behavioral;