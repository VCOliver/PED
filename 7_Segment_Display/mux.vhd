library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux is
    Port ( 
           Sel : in STD_LOGIC_VECTOR (1 downto 0); -- Select which of the 4 Displays will be on
           S : out STD_LOGIC_VECTOR (3 downto 0)   -- Decoded vector
    );
end mux;

architecture Behavioral of Mux_2 is

begin
   
    with Sel select
        S <= "1110" when "00",
             "1101" when "01",
             "1011" when "10",
             "0111" when "11";

end Behavioral;
