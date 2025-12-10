library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.all;

entity tb_vending is
end entity tb_vending;

architecture Behavioral of tb_vending is
    
    -- DUT ports
    signal clk : std_logic := '0';
    signal clr : std_logic := '0';
    signal xcoin : std_logic_vector(2 downto 0) := "001";
    signal disp_water : std_logic;
    signal disp_change : std_logic;
    -- coin encodings
    constant NO_COIN : std_logic_vector(2 downto 0) := "001";
    constant COIN_5  : std_logic_vector(2 downto 0) := "010";
    constant COIN_10 : std_logic_vector(2 downto 0) := "100";

    -- clock period
    constant CLK_PERIOD : time := 10 ns;

begin


    -- Instantiate DUT
    dut : entity work.vending
        port map (
            CLK         => clk,
            CLR         => clr,
            xCOIN       => xcoin,
            DISP_WATER  => disp_water,
            DISP_CHANGE => disp_change
        );

    -- Clock generation
    clk <= not clk after CLK_PERIOD/2;  -- 10 ns clock period
    
    -- Stimulus process
    stimulus : process
    begin
        -- reset DUT
        clr <= '1';
        wait for 2*CLK_PERIOD;
        clr <= '0';
        wait for 2*CLK_PERIOD;

---------------------------------------------
---------------------------------------------

        report " TEST 1: 15c sequence ";
        report "TEST: 5c + 10c = 15c -> WATER expected, NO change";

        xCOIN <= COIN_5;
        wait for CLK_PERIOD;

        xCOIN <= NO_COIN;
        wait for 3*CLK_PERIOD;

        xCOIN <= COIN_10;
        wait for CLK_PERIOD;

        xCOIN <= NO_COIN;
        wait for 5*CLK_PERIOD;

        -- Expect:  Water dispensed, no change
        -- DISP_WATER = '1' for one cycle
        -- DISP_CHANGE = '0'

        report "Finished 15c sequence. Check waveform for DISP_WATER pulse.";
        wait for 10*CLK_PERIOD;

---------------------------------------------
---------------------------------------------

        report " TEST 2: 20c sequence ";        
        report "TEST: 10c + 10c = 20c -> WATER and CHANGE expected";

        xCOIN <= COIN_10;
        wait for CLK_PERIOD;

        xCOIN <= NO_COIN;
        wait for 2*CLK_PERIOD;

        xCOIN <= COIN_10;
        wait for CLK_PERIOD;

        xCOIN <= NO_COIN;
        wait for 5*CLK_PERIOD;

        -- Expect:  Water dispensed and change returned
        -- DISP_WATER = '1' for one cycle
        -- DISP_CHANGE = '1' for one cycle

        report "Finished 20c sequence. Check waveform for DISP_WATER and DISP_CHANGE pulses.";
        wait for 10*CLK_PERIOD;

---------------------------------------------
---------------------------------------------

        report " TEST 3: Timeout sequence ";
        report "TEST: Trigger timeout from input state -> CHANGE expected";

        xCOIN <= COIN_10;
        wait for CLK_PERIOD;

        xCOIN <= NO_COIN;
        wait for 16*CLK_PERIOD;  -- wait for timeout to occur
        wait for 2*CLK_PERIOD; -- ensure pulse is visible

        -- Expect: Change returned to user, no water dispensed
        -- DISP_WATER = '0'
        -- DISP_CHANGE = '1' for one cycle

        report "Finished timeout sequence. Check waveform for DISP_CHANGE pulse.";
        wait for 10*CLK_PERIOD;

---------------------------------------------
---------------------------------------------

        report "End of Testbench.";
        wait;

    end process stimulus;
    
end architecture;