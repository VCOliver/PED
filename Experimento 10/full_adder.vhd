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

entity full_adder is
    Port (
        clk : in std_logic;
        A : in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        Sel : in std_logic;
        OVF : out std_logic;
        S: out std_logic_vector(3 downto 0)
    );
end full_adder;

architecture Behavioral of full_adder is

    signal x, y, z : integer range -8 to 7;

begin

    x <= to_integer(signed(A));
    y <= to_integer(signed(A));

    S <= to_signed(z);

    sum_sub : process(clk)
        begin
            if rising_edge(clk) then 
                case Sel is 
                    when 0 =>
                        z <= x + y;
                        if z < x then
                            OVF <= '1';
                        else
                            OVF <= '0';
                        end if;
                    when 1 =>
                        z <= x - y;
                        if z > x then
                            OVF <= '1';
                        else
                            OVF <= '0';
                        end if;
                end case;
                
            end if;
        end process;


end Behavioral;
