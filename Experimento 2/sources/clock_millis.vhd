----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.01.2023 23:40:59
-- Design Name: 
-- Module Name: clock_millis - Behavioral
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

entity clock_millis is
    Port ( clk : in STD_LOGIC;
           clk_1khz : out STD_LOGIC;
           rst : in std_logic);
end clock_millis;

architecture Behavioral of clock_millis is

    constant prescaler : integer := 50_000;
    signal counter : integer range 1 to 50_000 := 1;
    signal newClock : std_logic := '0';

begin

    clkDivisor : process(clk, rst)
        begin
            if rst = '1' then
                newClock <= '0';
                counter <= 1;
            elsif rising_edge(clk) then
                if counter = prescaler then
                    counter <= 1;
                    newClock <= not newClock;
                else
                    counter <= counter + 1;
                end if;
            end if;
        end process;

    clk_1khz <= newClock;

end Behavioral;
