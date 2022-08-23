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
    Port ( 
           A  : in std_logic_vector (3 downto 0);
           Ab : out std_logic_vector (3 downto 0)
         );
end comp2;

architecture Behavioral of comp2 is
  
  signal comp1 : std_logic_vector(3 downto 0);
  signal i     : std_logic_vector(3 downto 0) := "0001";
   
begin
  
  comp1 <= not A;
  Ab <= (comp1 + i);
       
end Behavioral;
