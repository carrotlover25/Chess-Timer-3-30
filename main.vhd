library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TOP is
    port (
        CLOCK_50 : in std_logic;
        KEY0     : in std_logic;
        KEY1     : in std_logic;
        SW0      : in std_logic;

        HEX7, HEX6, HEX5, HEX4 : out std_logic_vector(6 downto 0);
        HEX3, HEX2, HEX1, HEX0 : out std_logic_vector(6 downto 0)
    );
end TOP;

architecture Structural of TOP is

    component divisor_frecuencias
        port (
            clk      : in std_logic;
            reset    : in std_logic;
            tick_1hz : out std_logic
        );
    end component;

    component timer_single
        port (
            clk        : in std_logic;
            reset      : in std_logic;
            tick_1hz   : in std_logic;
            enable_btn : in std_logic;
            minutos    : out integer range 0 to 3;
            segundos   : out integer range 0 to 59
        );
    end component;

    component segmentos7
        port (
            minutos  : in integer range 0 to 3;
            segundos : in integer range 0 to 59;
            HEX3, HEX2, HEX1, HEX0 : out std_logic_vector(6 downto 0)
        );
    end component;

    signal tick_1hz_sig : std_logic;
    signal minA, minB   : integer range 0 to 3;
    signal segA, segB   : integer range 0 to 59;

    signal pause        : std_logic := '0';
    signal start        : std_logic := '1';

    signal enableA, enableB : std_logic;

begin

    u_div: divisor_frecuencias
        port map(
            clk      => CLOCK_50,
            reset    => not KEY0,
            tick_1hz => tick_1hz_sig
        );

    process(CLOCK_50)
    begin
        if rising_edge(CLOCK_50) then
            if KEY1 = '0' and start = '1' then
                pause <= not pause;
            end if;

            start <= KEY1;
        end if;
    end process;

    enableA <= SW0 AND (NOT pause);
    enableB <= (NOT SW0) AND (NOT pause);


    u_timerA: timer_single
        port map(
            clk        => CLOCK_50,
            reset      => not KEY0,
            tick_1hz   => tick_1hz_sig,
            enable_btn => enableA,
            minutos    => minA,
            segundos   => segA
        );


    u_timerB: timer_single
        port map(
            clk        => CLOCK_50,
            reset      => not KEY0,
            tick_1hz   => tick_1hz_sig,
            enable_btn => enableB,
            minutos    => minB,
            segundos   => segB
        );


    u_dispA: segmentos7
        port map(
            minutos  => minA,
            segundos => segA,
            HEX3 => HEX7,
            HEX2 => HEX6,
            HEX1 => HEX5,
            HEX0 => HEX4
        );

    u_dispB: segmentos7
        port map(
            minutos  => minB,
            segundos => segB,
            HEX3 => HEX3,
            HEX2 => HEX2,
            HEX1 => HEX1,
            HEX0 => HEX0
        );

end Structural;



