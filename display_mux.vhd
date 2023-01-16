----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.01.2023 23:40:59
-- Design Name: 
-- Module Name: display_mux - Behavioral
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
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           C : in STD_LOGIC_VECTOR (3 downto 0);
           D : in STD_LOGIC_VECTOR (3 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end display_mux;

architecture Behavioral of display_mux is

    component seg7_decoder
        Port (
            A   : in STD_LOGIC_VECTOR (3 downto 0); -- Number to be displayed
            seg : out STD_LOGIC_VECTOR (6 downto 0)); -- Decoded vector to light up display LEDs
    end component;

    signal i : std_logic_vector(3 downto 0);
    signal counter : unsigned(1 downto 0) := "00";

begin

    decode : seg7_decoder port map (A => i, seg => seg);
    --decode : seg7_HexDecoder port map (A => i, seg => seg);

    display_on : process(clk, rst)
        begin
            if rst = '1' then
                an <= "1111";
                i <= (other => '0');
            elsif rising_edge(clk) then
                case counter is
                    when "00" => -- primeiro liga o primeiro display com o numero D
                         i <= D;
                         an <= "1110";
                    when "01" => -- depois liga o segundo display com o numero C
                         i <= C;
                         an <= "1101";
                    when "10" => -- depois liga o terceiro display com o numero B
                         i <= B;
                         an <= "1011";  
                    when "11" => -- depois liga o quarto display com o numero A
                         i <= A;
                         an <= "0111";
                    when others =>
                         an <= "1111";
                end case;
                 
                 counter <= counter + "01";
                 
            end if;
        end process;

end Behavioral;
