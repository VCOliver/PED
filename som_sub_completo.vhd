library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity som_sub_completo is
    Port ( A   : in STD_LOGIC_VECTOR (3 downto 0);
           B   : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Sel : in std_logic;
           S   : out STD_LOGIC_VECTOR (3 downto 0);
           OVF : out std_logic);
end som_sub_completo;

architecture Behavioral of som_sub_completo is


Component somador_4bits -- Somador de um bit
    Port ( Av : in STD_LOGIC;
           Bv : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Sv : out STD_LOGIC;
           Cout : out STD_LOGIC);
           
end Component;

component mux 
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Sel : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0));
          
end component;

component comp2 
    Port ( B : in STD_LOGIC_VECTOR (3 downto 0);
           Bb : out STD_LOGIC_VECTOR (3 downto 0));
end component;

-- signal c0,c1,c2,Coutc,ov :std_logic;
-- signal U1,U2,U3,U4,U5,U6 :std_logic_vector(3 downto 0);   

component detector_overflow 
    Port ( Sign_A : in STD_LOGIC;
           Sign_B : in STD_LOGIC;
           Sign_S : in std_logic;
           S : out STD_LOGIC);
end component;

signal compB, M : std_logic_vector(3 downto 0);
  
begin   

compB <= B;

comp: comp2 port map (B => B, Bb => compB); -- complemento de 2

mux1: mux port map (A => B, B => compB, Sel => Sel, S => M ); --multiplexador
  
  -- Saída
  sum:  somador_4bit port map( Av => A, Bv => M, Cin => Cin, Sv => S, Cout => OVF);

  detec: detector_dverflow port map (Sign_A => A[3], Sign_B => M[3], Sign_S => S[3], S => OVF); --Detector de Overflow

end Behavioral;
