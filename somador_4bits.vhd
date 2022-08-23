library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity somador_4bits is
    Port ( Av : in std_logic_vector (3 downto 0);
           Bv : in std_logic_vector (3 downto 0);
           Cin : in STD_LOGIC;
           Sv : out std_logic_vector (3 downto 0);
           Cout : out STD_LOGIC);
end somador_4bits;

architecture Behavioral of somador_4bits is
    signal aux : std_logic_vector (2 downto 0);
    
     component  somador_1bit
        Port ( 
           A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           S : out STD_LOGIC;
           Cout : out STD_LOGIC);
    end component ;
begin
       bit0:  somador_1bit port map( A => Av(0), B => Bv(0), Cin => Cin   , S => Sv(0), Cout => aux(0));
       bit1:  somador_1bit port map( A => Av(1), B => Bv(1), Cin => aux(0), S => Sv(1), Cout => aux(1));
       bit2:  somador_1bit port map( A => Av(2), B => Bv(2), Cin => aux(1), S => Sv(2), Cout => aux(2));
       bit3:  somador_1bit port map( A => Av(3), B => Bv(3), Cin => aux(2), S => Sv(3), Cout => Cout);
end Behavioral;
