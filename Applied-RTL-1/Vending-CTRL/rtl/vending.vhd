library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vending is
    port (
        CLK         : in  std_logic;                      -- clock
        CLR         : in  std_logic;                      -- active high synchronous reset
        xCOIN       : in  std_logic_vector(2 downto 0);   -- one-hot: "001"=no coin, "010"=5c, "100"=10c
        DISP_WATER  : out std_logic;
        DISP_CHANGE: out std_logic
    );
end entity vending;

architecture Behavioral of vending is

    -- State Definition (Moore machine)
    type state_type is (IDLE, INP_5, INP_10, INP_15, INP_20);
    signal current_state, next_state : state_type := IDLE;

    -- Timeout counter: counts cycles while state remains unchanged
    signal CLK_count : unsigned(3 downto 0) := (others => '0');  -- counts 0..15
    constant TIMEOUT : integer := 15; -- 15 second timer

    -- internal signals
    signal disp_w_reg, disp_c_reg : std_logic := '0';

begin

    seq_proc: process(CLK)
    begin
        if rising_edge(CLK) then
            if CLR = '1' then
                current_state <= IDLE;
                CLK_count     <= (others => '0');
                disp_w_reg    <= '0';
                disp_c_reg    <= '0';
            else
                -- update counter: increment only if next_state = current_state (i.e., staying)
                  if next_state = current_state then
                    if CLK_count = to_unsigned(TIMEOUT, CLK_count'length) then
                        CLK_count <= (others => '0'); -- clear after reaching TIMEOUT
                    else
                        CLK_count <= CLK_count + 1;
                    end if;
                else
                    CLK_count <= (others => '0');   -- reset timer on state change
                end if;

                -- state update
                current_state <= next_state;
                
                -- registered outputs (Moore -> glitch-free)
                case current_state is
                    when INP_15 =>
                        -- when in INP_15, dispense water for one registered clock cycle
                        disp_w_reg <= '1';
                        disp_c_reg <= '0';
                    when INP_20 =>
                        disp_w_reg <= '1';
                        disp_c_reg <= '1';
                    when others =>
                        -- default outputs
                        disp_w_reg <= '0';
                        disp_c_reg <= '0';
                end case;
                
                if (CLK_count = to_unsigned(TIMEOUT, CLK_count'length)) and (current_state /= IDLE) then
                    disp_c_reg <= '1';
                end if;
                
                -- produce a one-cycle change output. 
                -- We assert disp_c_reg here as well so it is registered 
                -- (glitch-free) for exactly one clock cycle.
            end if;
        end if;
    end process seq_proc;


    comb_proc: process(current_state, xCOIN, CLK_count)
    begin
        -- defaults
        next_state <= current_state;

        -- timeout force: if machine stayed in same state long enough, go to IDLE
        if (CLK_count = to_unsigned(TIMEOUT, CLK_count'length)) and (current_state /= IDLE) then
            next_state <= IDLE;
        else
            -- State transitions
            case current_state is

                when IDLE =>
                    -- only accept 5c or 10c; "001" = no coin (stay)
                    if xCOIN = "010" then           -- 5c inserted
                        next_state <= INP_5;
                    elsif xCOIN = "100" then        -- 10c inserted
                        next_state <= INP_10;
                    else
                        next_state <= IDLE;
                    end if;

                when INP_5 =>
                    if xCOIN = "010" then           -- +5c -> total 10c
                        next_state <= INP_10;
                    elsif xCOIN = "100" then        -- +10c -> total 15c
                        next_state <= INP_15;
                    else
                        next_state <= INP_5;
                    end if;

                when INP_10 =>
                    if xCOIN = "010" then           -- +5c -> total 15c
                        next_state <= INP_15;
                    elsif xCOIN = "100" then        -- +10c -> total 20c
                        next_state <= INP_20;
                    else
                        next_state <= INP_10;
                    end if;

                when INP_15 =>
                    -- dispense water for 1 machine cycle, then go to IDLE
                    next_state <= IDLE;

                when INP_20 =>
                    -- dispense + change in next cycle
                    next_state <= IDLE;

                when others =>
                    next_state <= IDLE;
            end case;
        end if;
    end process comb_proc;


    -- Output port mapping
    DISP_WATER   <= disp_w_reg;
    DISP_CHANGE <= disp_c_reg;

end Behavioral;
