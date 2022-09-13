----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.09.2022 17:34:14
-- Design Name: 
-- Module Name: seg7 - Behavioral
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

entity info is

    Port(
        clk : in std_logic;
        A : out std_logic_vector(3 downto 0);
        B : out std_logic_vector(3 downto 0);
        C : out std_logic_vector(3 downto 0);
        D : out std_logic_vector(3 downto 0)
    );

end info;

architecture Behavioral of info is

    signal counter : integer range 0 to 2 := 0;

begin

    numbers : process(clk)
    begin
        if rising_edge(clk) then
            case counter is
                when 0 =>  
                     A <= "1111"; -- BLANK
                     B <= "1111"; -- BLANK
                     C <= "0000"; -- 0
                     D <= "1001"; -- 9
                     counter <= 1;
                when 1 => 
                     A <= "0001"; -- 1
                     B <= "1000"; -- 8
                     C <= "0100"; -- 4
                     D <= "0010"; -- 2
                     counter <= 2;
                when 2 => 
                     A <= "1111"; -- BLANK
                     B <= "1111"; -- BLANK
                     C <= "1111"; -- BLANK
                     D <= "1111"; -- BLANK
                     counter <= 0;
            end case;
        end if;
    end process;

end Behavioral;