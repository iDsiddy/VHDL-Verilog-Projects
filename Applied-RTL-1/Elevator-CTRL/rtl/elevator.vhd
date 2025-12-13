library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Elevator_Control is
    port (
        CLK, CLR, STOP : in std_logic;  -- STOP toggle button input
        CALL : in std_logic_vector(2 downto 0); -- binary floor number: 0–7
        DOOR_OPEN, MOTOR_UP, MOTOR_DOWN : out std_logic
    );
end Elevator_Control;

architecture Behavioral of Elevator_Control is

    type state_type is (IDLE, GOING_UP, GOING_DOWN, OPEN_DOOR, EMG_STOP);
    signal current_state, next_state : state_type;

    signal curr_floor  : unsigned(2 downto 0) := (others => '0');
    signal latched_target : unsigned(2 downto 0);
    
    signal timer : unsigned(3 downto 0) := (others => '0');

begin

-- State Register + floor movement  (Transition Function)
seq_logic : process(CLK)
begin
    if rising_edge(CLK) then
        if CLR = '1' then
            current_state <= IDLE;
            curr_floor <= (others => '0');
            timer <= (others => '0');
            latched_target <= (others => '0');
        else
            current_state <= next_state;
            
            -- Convert CALL to unsigned floor index
            if current_state = IDLE then
                latched_target <= unsigned(CALL);
            end if;
            
            -- Move elevator floor-by-floor
            if current_state = GOING_UP then
                if curr_floor < latched_target then
                    curr_floor <= curr_floor + 1;
                end if;
            elsif current_state = GOING_DOWN then
                if curr_floor > latched_target then
                    curr_floor <= curr_floor - 1;
                end if;
            end if;
    
            -- Timer logic
            if current_state = OPEN_DOOR then
                timer <= timer + 1;     -- increments
            else
                timer <= (others => '0');   -- reset timer
            end if;
        end if;

   end if;
end process;


-- Next-State and Output Logic
comb_logic : process(current_state, curr_floor, latched_target, STOP, timer)
begin

    -- default outputs
    MOTOR_UP <= '0';
    MOTOR_DOWN <= '0';
    DOOR_OPEN <= '0';


    next_state <= current_state;

    if STOP = '1' then
        next_state <= EMG_STOP;
    else
        case current_state is

            when IDLE =>
                DOOR_OPEN <= '0';

                if curr_floor < latched_target then
                    next_state <= GOING_UP;
                elsif curr_floor > latched_target then
                    next_state <= GOING_DOWN;
                else
                    next_state <= IDLE;
                end if;

            when GOING_UP =>
                MOTOR_UP <= '1';
                if curr_floor = latched_target then
                    next_state <= OPEN_DOOR;
                else
                    next_state <= GOING_UP;
                end if;

            when GOING_DOWN =>
                MOTOR_DOWN <= '1';
                if curr_floor = latched_target then
                    next_state <= OPEN_DOOR;
                else
                    next_state <= GOING_DOWN;
                end if;

            when OPEN_DOOR =>
                DOOR_OPEN <= '1';
                
                if timer = "0101" then   -- 5 cycles door open
                    next_state <= IDLE;
                else
                    next_state <= OPEN_DOOR;
                end if;

            when EMG_STOP =>
                -- hold until STOP released

                if STOP = '0' then
                    next_state <= IDLE;
                end if;

        end case;
    end if;
end process;

end Behavioral;
