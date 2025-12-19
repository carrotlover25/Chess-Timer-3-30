LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY divisor_frecuencias IS
    PORT (
        clk      : IN  STD_LOGIC;
        reset    : IN  STD_LOGIC;
        tick_1hz : OUT STD_LOGIC
    );
END divisor_frecuencias;

ARCHITECTURE Behavioral OF divisor_frecuencias IS
    CONSTANT MAX_COUNT : INTEGER := 50_000_000 - 1;  
    SIGNAL count : INTEGER RANGE 0 TO MAX_COUNT := 0;
BEGIN
    PROCESS(clk, reset)
    BEGIN
        IF reset = '1' THEN
            count <= 0;
            tick_1hz <= '0';
        ELSIF rising_edge(clk) THEN
            IF count = MAX_COUNT THEN
                count <= 0;
                tick_1hz <= '1';   
            ELSE
                count <= count + 1;
                tick_1hz <= '0';
            END IF;
        END IF;
    END PROCESS;
END Behavioral;

	
	