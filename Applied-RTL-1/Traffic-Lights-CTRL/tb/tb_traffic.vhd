library IEEE;
use IEEE.std_logic_1164.all;

entity tb_traffic is
end entity tb_traffic;

architecture behavior of tb_traffic is

    -- Component Declaration for the Device Under Test (DUT)
    component traffic_lights_ctrl
    port(
        clk     : in  std_logic;
        clr     : in  std_logic;
        NS_Light, EW_Light : out std_logic_vector(2 downto 0)
    );
    end component;

    -- Signals to connect to DUT
    signal clk     : std_logic := '0';
    signal clr     : std_logic := '0';
    signal NS_Light, EW_Light : std_logic_vector(2 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

end architecture behavior;