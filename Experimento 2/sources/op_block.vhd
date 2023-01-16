----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.01.2023 23:40:59
-- Design Name: 
-- Module Name: op_block - Behavioral
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

entity op_block is
    Port ( clk : in STD_LOGIC;
           loadrTime : in std_logic;
           rstrTime : in std_logic;
           loadrCount : in std_logic;
           rstrCount : in std_logic;
           loadwCount : in std_logic;
           rstwCount : in std_logic;
           rCount_lt_2k : out STD_LOGIC;
           wCount_lt_10k : out STD_LOGIC;
           rTime : out std_logic_vector(10 downto 0));
end op_block;

architecture Behavioral of op_block is

    signal wCount : integer range 0 to 10000 := 0;
    signal rCount : integer range 0 to 2000 := 0;

begin

    process(loadwCount, rstwCount, clk)
    begin
        if rstwCount = '1' then
            wCount <= 0;
        elsif rising_edge(clk) then
            if loadwCount = '1' then
                wCount <= wCount + 1;
            end if;
            
        end if;      
    end process;
    
    process(wCount)
    begin
        if wCount >= 10000 then
            wCount_lt_10k <= '0';
        else
           wCount_lt_10k <= '1'; 
        end if;
   end process;
    
    process(loadrCount, rstrCount, clk)
        begin
            if rstrCount = '1' then
                rCount <= 0;
            elsif rising_edge(clk) then
                if loadrCount = '1' then
                    rCount <= rCount + 1;
                end if;
            end if;
    end process;
    
    process(rCount)
    begin
        if rCount >= 2000 then
           rCount_lt_2k <= '0';
        else
           rCount_lt_2k <= '1'; 
        end if;
   end process;
    
    process(loadrTime, rstrTime, clk)
    begin
        if rstrTime = '1' then
            rTime <= (others => '0');
        elsif rising_edge(clk) then
            if loadrTime = '1' then
                rTime <= std_logic_vector(to_unsigned(rCount, rTime'length));
            end if;
        end if;
    end process;

end Behavioral;
