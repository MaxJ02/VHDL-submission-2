library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sub2 is
port(clock, button_n, reset_n : in std_logic;
     hex0                     : out std_logic_vector(6 downto 0));
end entity;

architecture behaviour of sub2 is
signal button_n_previous      : std_logic := '1';
signal button_pressed         : std_logic := '0';
signal button_counter         : natural range 0 to 15;
constant COUNTER_MAX          : natural := 15;        -- Can be changed to any value between 1 - 15.
begin

	display0: entity work.displaymodule
   port map(button_counter, hex0);

   EDGE_DETECT_PROCESS: process(clock, reset_n) is
   begin
       if(reset_n = '0') then
           button_pressed <= '0';
            button_n_previous <= '1';
        elsif(rising_edge(clock)) then
            if(button_n = '0' and button_n_previous = '1') then
                button_pressed <= '1';
            else
               button_pressed <= '0';
            end if;
            button_n_previous <= button_n;
        end if;
    end process;

    BUTTON_COUNT_PROCESS: process(clock, reset_n) is
    begin
       if(reset_n = '0') then
            button_counter <= 0;
        elsif (rising_edge(clock)) then
            if (button_pressed = '1') then
                 if (button_counter < COUNTER_MAX) then
                      button_counter <= button_counter + 1;
                  else
                      button_counter <= 0;
                  end if;
             end if;
       end if;
    end process;
end architecture;
