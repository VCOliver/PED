library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comp2 is
    Port ( A  : in std_logic_vector (3 downto 0);
           Ab : out std_logic_vector (3 downto 0)
         );
end comp2;

architecture Behavioral of comp2 is
  
  signal aux : std_logic_vector(3 downto 0);
   
begin
  
  aux <= not A;
  Ab <= std_logic_vector(to_unsigned(to_integer(unsigned( in )) + 1, 4));
       
end Behavioral;
