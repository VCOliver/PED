----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.09.2022 17:50:12
-- Design Name: 
-- Module Name: display - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display is
  Port (
    A : in std_logic_vector(3 downto 0);
    B : in std_logic_vector(3 downto 0);
    Sel : in std_logic;
    led : out STD_LOGIC;
    an : out std_logic_vector(3 downto 0);
    seg : out std_logic_vector(6 downto 0)
  );
end display;

architecture Behavioral of display is

    component seg7
        Port (
            A   : in STD_LOGIC_VECTOR (3 downto 0); -- Number to be displayed
            seg : out STD_LOGIC_VECTOR (6 downto 0)); -- Decoded vector to light up display LEDs
    end component;

    signal A7, B7 : std_logic_vector(6 downto 0);

begin

    an <= "1110";
    led <= '1';
    
    decode_A : seg7 port map (A => A, seg => A7);
    decode_B : seg7 port map (A => B, seg => B7);

    with Sel select
        seg <= A7 when '0',
               B7 when '1';
        

end Behavioral;
