library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decodificador_7segmentos is
    Port ( BCD : in std_logic_vector (3 downto 0);
           Blank : in STD_LOGIC;
           seg : out std_logic_vector (0 to 6));
end decodificador_7segmentos;

architecture Behavioral of decodificador_7segmentos is
    signal sSeg:std_logic_vector (0 to 6);
begin
    with BCD select
    
        sSeg <= "0000001" when "0000", --0
                "1001111" when "0001", --1
                "0010010" when "0010", --2
                "0000110" when "0011", --3
                "1001100" when "0100", --4
                "0100100" when "0101", --5
                "0100000" when "0110", --6
                "0001111" when "0111", --7
                "0000000" when "1000", --8
                "0000100" when "1001", --9
                "0111111" when others;       
       seg <= "1111111" when Blank = '0' else sSeg;  
        
end Behavioral;
