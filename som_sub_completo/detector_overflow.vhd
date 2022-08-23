library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity detector_overflow is
    Port ( Sign_A : in STD_LOGIC;
           Sign_B : in STD_LOGIC;
           Sign_S : in std_logic;
           S : out STD_LOGIC);
end detector_overflow;

architecture Behavioral of detector_overflow is

begin

--  S <= (Sign_A xor Sign_B);
    
--  S <= (Sign_A and not Sign_S) or (not Sign_A and b) or (not Sign_B and Sign_S);
    
    S <= (Sign_A xnor Sign_B) and (Sign_A xor Sign_S);

end Behavioral;
