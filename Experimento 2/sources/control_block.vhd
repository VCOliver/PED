----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.01.2023 23:40:59
-- Design Name: 
-- Module Name: control_block - Behavioral
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

entity control_block is
    Port ( clk : in STD_LOGIC;
           reset : in std_logic;
           rst : in std_logic;
           B : in std_logic;
           rCount_lt_2k : in std_logic;
           wCount_lt_10k : in std_logic;
           loadrTime : out std_logic;
           rstrTime : out std_logic;
           loadrCount : out std_logic;
           rstrCount : out std_logic;
           loadwCount : out std_logic;
           rstwCount : out std_logic;
           len_led : out std_logic;
           slow_led : out std_logic);
end control_block;

architecture Behavioral of control_block is

type state is (init, hold, count, slow, done);
signal current_state, next_state : state := init;

signal loadslow_led, clrslow_led : std_logic := '0';

begin

    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= init;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;
    
    process(current_state, rst, wCount_lt_10k, rCount_lt_2k, B)
    begin
        
        case current_state is
            when init =>
                if rst = '1' then
                    next_state <= hold;
                else
                    next_state <= init;
                end if;
            when hold =>
                if wCount_lt_10k = '1' then  
                    next_state <= hold;
                else
                    next_state <= Count;
                end if;
            when Count =>
                if B = '1' then
                    next_state <= done;
                elsif rCount_lt_2k = '0' then
                    next_state <= slow;
                else
                    next_state <= Count;
                end if;
            when slow =>
                next_state <= done;
                
            when done =>
                next_state <= init;
            
            when others =>
                next_state <= init;
            end case;
        
    end process;
    
    process(current_state, reset, B, rCount_lt_2k)
    begin
        if reset = '1' then
            loadwCount <= '0';
            rstwCount <= '1';
            loadrCount <= '0';
            rstrCount <= '1';
            loadrTime <= '0';
            rstrTime <= '1';
            loadslow_led <= '0';
            clrslow_led <= '1';
            len_led <= '0'; 
        else
            case current_state is
                when init =>
                    loadwCount <= '0';
                    rstwCount <= '1';
                    loadrCount <= '0';
                    rstrCount <= '1';
                    loadrTime <= '0';
                    rstrTime <= '0';
                    loadslow_led <= '0';
                    clrslow_led <= '0';
                    len_led <= '0';
                when hold =>
                    loadwCount <= '1';
                    rstwCount <= '0';
                    loadrCount <= '0';
                    rstrCount <= '1';
                    loadrTime <= '0';
                    rstrTime <= '1';
                    loadslow_led <= '0';
                    clrslow_led <= '1';
                    len_led <= '0';
                when count =>
                    loadwCount <= '0';
                    rstwCount <= '1';
                    if rCount_lt_2k = '0' or B = '1' then
                        loadrCount <= '0';
                        loadrTime <= '1';
                    else
                        loadrCount <= '1';
                        loadrTime <= '0';
                    end if;
                    rstrCount <= '0';
                    rstrTime <= '0';
                    loadslow_led <= '0';
                    clrslow_led <= '1';
                    len_led <= '1';
                when slow =>
                    loadwCount <= '0';
                    rstwCount <= '1';
                    loadrCount <= '0';
                    rstrCount <= '0';
                    loadrTime <= '0';
                    rstrTime <= '1';
                    loadslow_led <= '1';
                    clrslow_led <= '0';
                    len_led <= '0';                    
                when done =>
                    loadwCount <= '0';
                    rstwCount <= '1';
                    loadrCount <= '0';
                    rstrCount <= '0';
                    loadrTime <= '1';
                    rstrTime <= '0';
                    loadslow_led <= '0';
                    clrslow_led <= '0';
                    len_led <= '0';   
                when others =>
                    loadwCount <= '0';
                    rstwCount <= '1';
                    loadrCount <= '0';
                    rstrCount <= '1';
                    loadrTime <= '0';
                    rstrTime <= '1';
                    loadslow_led <= '0';
                    clrslow_led <= '1';
                    len_led <= '0';   
                end case;
        end if;
    end process;
    
    process(clk, loadslow_led, clrslow_led)
    begin
        if clrslow_led = '1' then
            slow_led <= '0';
        elsif falling_edge(clk) then
            if loadslow_led = '1' then
                slow_led <= '1';
            end if;
        end if;
    end process;

end Behavioral;
