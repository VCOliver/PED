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
    Port ( MSB_A : in STD_LOGIC;
           MSB_B : in STD_LOGIC;
           S : out STD_LOGIC);
end detector_overflow;

architecture Behavioral of detector_overflow is

begin

S <= (MSB_A xor MSB_B);

end Behavioral;
