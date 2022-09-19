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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display_mux is
  Port (
    clk : in std_logic;
    A : in std_logic_vector(3 downto 0); -- numero do display 3
    B : in std_logic_vector(3 downto 0); -- numero do display 2
    C : in std_logic_vector(3 downto 0); -- numero do display 1
    D : in std_logic_vector(3 downto 0); -- numero do display 0
    an : out std_logic_vector(3 downto 0); -- display
    seg : out std_logic_vector(6 downto 0) -- numero decodificado
  );
end display_mux;

architecture Behavioral of display_mux is

    component seg7_decoder
        Port (
            A   : in STD_LOGIC_VECTOR (3 downto 0); -- Number to be displayed
            seg : out STD_LOGIC_VECTOR (6 downto 0)); -- Decoded vector to light up display LEDs
    end component;

    signal i: std_logic_vector(3 downto 0);
    signal counter : integer range 0 to 3 := 0;

begin
    
    decode : seg7_decoder port map (A => i, seg => seg);

    display_on : process(clk)
        begin
            if rising_edge(clk) then
                case counter is
                    when 0 => 
                         i <= D;
                         an <= "1110";
                         --counter <= 1;
                    when 1 => 
                         i <= C;
                         an <= "1101";
                        --  counter <= 2;
                    when 2 => 
                         i <= B;
                         an <= "1011";
                        --  counter <= 3;   
                    when 3 => 
                         i <= A;
                         an <= "0111";
                        --  counter <= 0;  
                end case;

                counter <= counter + 1;
                if counter = 4 then
                     counter <= 0;
                end if;

            end if;
        end process;
        

end Behavioral;
