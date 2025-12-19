LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY segmentos7 IS
    PORT (
        minutos  : IN INTEGER RANGE 0 TO 3;
        segundos : IN INTEGER RANGE 0 TO 59;
        HEX3, HEX2, HEX1, HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END segmentos7;

ARCHITECTURE Behavioral OF segmentos7 IS

    FUNCTION bcd_7seg (digit : INTEGER) RETURN STD_LOGIC_VECTOR IS
        VARIABLE seg : STD_LOGIC_VECTOR(6 DOWNTO 0);
    BEGIN
        CASE digit IS
            WHEN 0 => seg := "1000000"; 
            WHEN 1 => seg := "1111001"; 
            WHEN 2 => seg := "0100100"; 
            WHEN 3 => seg := "0110000"; 
            WHEN 4 => seg := "0011001"; 
            WHEN 5 => seg := "0010010"; 
            WHEN 6 => seg := "0000010"; 
            WHEN 7 => seg := "1111000"; 
            WHEN 8 => seg := "0000000"; 
            WHEN 9 => seg := "0010000"; 
            WHEN OTHERS => seg := "1111111"; 
        END CASE;
        RETURN seg;
    END FUNCTION;

BEGIN

    HEX3 <= bcd_7seg(minutos / 10);     
    HEX2 <= bcd_7seg(minutos MOD 10);   
    HEX1 <= bcd_7seg(segundos / 10);    
    HEX0 <= bcd_7seg(segundos MOD 10);  

END Behavioral;

