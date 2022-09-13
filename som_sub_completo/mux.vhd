library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux is
    Port ( A   : in STD_LOGIC_VECTOR (3 downto 0);   -- First vector
           B   : in STD_LOGIC_VECTOR (3 downto 0);   -- Second vector
           Sel : in STD_LOGIC;                       -- Selects which vector is to be passed
           S   : out STD_LOGIC_VECTOR (3 downto 0)); -- Exits the chosen vector
           
end mux;

architecture Behavioral of mux is

begin


with Sel select
  
  S  <= A when '0', -- Vector A exits when 0 is selected
        B when others; -- Else B

end Behavioral;
