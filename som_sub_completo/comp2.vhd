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
           comp2 : out std_logic_vector (3 downto 0)
         );
end comp2;

architecture Behavioral of comp2 is
  
  signal comp1 : std_logic_vector(3 downto 0);
  signal i     : std_logic_vector(3 downto 0) := "0001";
  signal j : std_logic;

  component somador_4bits
      Port(
          Av : in std_logic_vertor(3 downto 0);
          Bv : in std_logic_vector(3 downto 0);
          Cin : in std_logic
          Sv : out std_logic_vector(3 downto 0);
          Cout : out std_logic);
   end component;
   
begin
  
  comp1 <= not A;
  comp2 : somador_4bits port map(Av => comp1, Bv => i, Cin => '0', Sv => comp2, Cout => j);
       
end Behavioral;
