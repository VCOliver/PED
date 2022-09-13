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
           Sel1 : in std_logic;
           Sel  : in std_logic;
           Sel_LED : out std_logic; -- LED to show where select button is
           S   : out STD_LOGIC_VECTOR (3 downto 0);
           Cout: out std_logic;
           OVF : out std_logic);
end som_sub_completo;

architecture Behavioral of som_sub_completo is


Component somador_4bits -- Instanciating the 4 bits adder
    Port (
           Av   : in STD_LOGIC;
           Bv   : in STD_LOGIC;
           Cin  : in STD_LOGIC;
           Sv   : out STD_LOGIC;
           Cout : out STD_LOGIC);
           
end Component;

component mux -- Instanciating the Multiplexer
    Port ( A   : in STD_LOGIC_VECTOR (3 downto 0);
           B   : in STD_LOGIC_VECTOR (3 downto 0);
           Sel : in STD_LOGIC;
           S   : out STD_LOGIC_VECTOR (3 downto 0));
          
end component;

component comp2     -- Instanciating the 2's Complement
    Port ( A  : in STD_LOGIC_VECTOR (3 downto 0);
           comp2 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component detector_overflow     -- Instanciating the Overflow detector
    Port ( Sign_A : in STD_LOGIC;
           Sign_B : in STD_LOGIC;
           Sign_S : in std_logic;
           S : out STD_LOGIC);
end component;

signal compB, N : std_logic_vector(3 downto 0); -- Auxiliary signals
  
begin   


    Sel_LED <= '1' -- Turns on the led showing where the "subtraction operation" Switch is
    
    --comp2: comp port map (A => A, comp2 => compA); -- 2's Complement

    comp: comp2 port map (A => B, comp2 => compB); -- 2's Complement

    --mux1: mux port map (A => A, B => compA, Sel1 => Sel, S => M ); --multiplexer
        
    mux2: mux port map (A => B, B => compB, Sel => Sel, S => N ); --multiplexer
  
    -- Saída
    sum:  somador_4bits port map( Av => M, Bv => N, Cin => Cin, Sv => S, Cout => Cout); -- Sum

    detec: detector_overflow port map (Sign_A => M(3), Sign_B => N(3), Sign_S => S(3), S => OVF); -- Overflow Detector

end Behavioral;
