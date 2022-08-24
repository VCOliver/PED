library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity seg7 is
    Port ( 
            A   : in STD_LOGIC_VECTOR (3 downto 0); -- Number to be displayed
            Sel : in STD_LOGIC_VECTOR(2 downto 0);  -- Select which display will be on
            seg : out STD_LOGIC_VECTOR (6 downto 0); -- Decoded vector to light up display LEDs
            an  : out STD_LOGIC_VECTOR (3 downto 0)  -- Deccoded vector to turn on display
    );
end seg7;

architecture Behavioral of seg7 is

    component mux -- Instanciating the multiplexer
        Port ( 
            Sel : in STD_LOGIC_VECTOR (1 downto 0);
            S   : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

begin

    -- 7 Segment Display Decoder
    with A select
        seg <=  "1000000" when "0000", -- 0
                "1111001" when "0001", -- 1
                "0100100" when "0010", -- 2
                "0110000" when "0011", -- 3
                "0011001" when "0100", -- 4
                "0010010" when "0101", -- 5
                "0000010" when "0110", -- 6
                "1111000" when "0111", -- 7
                "0000000" when "1000", -- 8
                "0010000" when "1001", -- 9
                "1111111" when others;   -- Blank
      
    mux: mux port map (Sel => Sel, S => an); -- Choose which of the 4 Displays will be on

end Behavioral;
