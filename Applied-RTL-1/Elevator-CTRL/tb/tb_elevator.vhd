library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.ALL;

entity tb_Elevator_Control is
end tb_Elevator_Control;


architecture Behavioral of tb_Elevator_Control is

    -- Component Declaration for the Unit Under Test (UUT)
    component Elevator_Control
        port (
            CLK, CLR, STOP : in std_logic;  -- STOP toggle button input
            CALL : in std_logic_vector(2 downto 0); -- binary floor number: 0–7
            DOOR_OPEN, MOTOR_UP, MOTOR_DOWN : out std_logic
        );
    end component;

    -- Signals to connect to UUT
    signal CLK     : std_logic := '0';
    signal CLR     : std_logic := '0';
    signal STOP    : std_logic := '0';
    signal CALL    : std_logic_vector(2 downto 0) := (others => '0');
    signal DOOR_OPEN  : std_logic;
    signal MOTOR_UP   : std_logic;
    signal MOTOR_DOWN : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Device Under Test (DUT)
    dut: Elevator_Control
        port map (
            CLK => CLK,
            CLR => CLR,
            STOP => STOP,
            CALL => CALL,
            DOOR_OPEN => DOOR_OPEN,
            MOTOR_UP => MOTOR_UP,
            MOTOR_DOWN => MOTOR_DOWN
        );

    -- Clock generation
    clk_process :process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin		
        -- hold reset state
        CLR <= '1';
        wait for 20 ns;	

        CLR <= '0';
        wait for 20 ns;

        -- Call to floor 3
        CALL <= "011";
        wait for 100 ns;

        -- Call to floor 5
        CALL <= "101";
        wait for 100 ns;

        -- Activate STOP
        STOP <= '1';
        wait for 50 ns;
        STOP <= '0';
        wait for 50 ns;

        -- Call to floor 2
        CALL <= "010";
        wait for 100 ns;

        -- Finish simulation
        wait;
    end process;

end architecture Behavioral;