library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock200hz is
    Port (clk: in std_logic;
          clk_200: out std_logic);
end clock200hz;

architecture Behavioral of clock200hz is

signal prescaler: integer range 0 to 200_000 := 200_000;
signal counter: integer range 1 to 200_000 :=1 ;
signal newClock: std_logic := '0';

begin

    divisor_clk: process(clk)
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

    clk_60 <= newClock;
    
end Behavioral;