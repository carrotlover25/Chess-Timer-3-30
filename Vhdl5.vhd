library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer_single is
    port (
        clk        : in  std_logic;
        reset      : in  std_logic;
        tick_1hz   : in  std_logic;
        enable_btn : in  std_logic;
        minutos    : out integer range 0 to 3;
        segundos   : out integer range 0 to 59
    );
end timer_single;


architecture Behavioral of timer_single is

    constant MAX_TIME : integer := 210;  -- 3 min 30 seg
    signal count : integer range 0 to MAX_TIME := MAX_TIME;

begin

    process(clk, reset)
    begin
        if reset = '1' then
            count <= MAX_TIME;

        elsif rising_edge(clk) then
            if tick_1hz = '1' then
                if enable_btn = '1' then
                    if count > 0 then
                        count <= count - 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    minutos  <= count / 60;
    segundos <= count mod 60;

end Behavioral;
