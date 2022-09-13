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

entity clock05hz is
    Port(
        clk : in std_logic;
        clk_50 : out std_logic
    );
end clock05hz;

architecture Behavioral of clock05hz is

    signal prescaler : integer range 0 to 1_000_000 := 100_000_000;
    signal counter : integer range 1 to 1_000_000 := 1;
    signal newClock : std_logic := '0';

begin

    clkDivisor : process(clk)
        begin
            if rising_edge(clk) then
                if counter = prescaler then
                    counter <= 1;
                    newClock <= not newClock;
                else
                    counter <= counter + 1;
                end if;
            end if;
        end process;

    clk_50 <= newClock;

end Behavioral;