----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2023 12:44:41
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
           start : in STD_LOGIC;
           reset : in STD_LOGIC;
           i_lt_255 : in STD_LOGIC;
           qspo_ce : out STD_LOGIC;
           inc_i : out STD_LOGIC;
           clr_i : out STD_LOGIC;
           inc_sum : out STD_LOGIC;
           clr_sum : out STD_LOGIC;
           load_res : out STD_LOGIC;
           clr_res : out STD_LOGIC);
end control_block;

architecture Behavioral of control_block is

    type state is (s0, res, compare, sum, output);
    signal current_state, next_state : state := s0;

begin

    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= s0;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;
    
    next_state_logic : process(current_state, start, i_lt_255)
    begin
        case current_state is
            when s0 =>
                if start = '1' then
                    next_state <= res;
                else
                    next_state <= s0;
                end if;
            when res =>
                next_state <= compare;
            when compare =>
                if i_lt_255 = '1' then
                    next_state <= sum;
                else 
                    next_state <= output;
                end if;
            when sum =>
                next_state <= compare;
            when output =>
                next_state <= s0;
            when others =>
                next_state <= s0;
        end case;
    end process;
    
    out_logic : process(current_state, reset, i_lt_255)
    begin
        if reset = '1' then
            qspo_ce <= '0';
            inc_i <= '0';
            clr_i <= '1';
            inc_sum <= '0';
            clr_sum <= '1';
            load_res <= '0';
            clr_res <= '1';
        else
            case current_state is
                when s0 =>
                    qspo_ce <= '0';
                    inc_i <= '0';
                    clr_i <= '0';
                    inc_sum <= '-';
                    clr_sum <= '1';
                    load_res <= '0';
                    clr_res <= '0';
                when res =>
                    qspo_ce <= '0';
                    inc_i <= '-';
                    clr_i <= '1';
                    inc_sum <= '-';
                    clr_sum <= '1';
                    load_res <= '-';
                    clr_res <= '1';                
                when compare =>
                    qspo_ce <= '0';
                    inc_i <= '0';
                    clr_i <= '0';
                    inc_sum <= '0';
                    clr_sum <= '0';
                    if i_lt_255 = '0' then
                        load_res <= '1';  
                    else
                        load_res <= '0';
                    end if;
                    clr_res <= '0';                
                when sum =>
                    qspo_ce <= '1';
                    inc_i <= '1';
                    clr_i <= '0';
                    inc_sum <= '1';
                    clr_sum <= '0';
                    load_res <= '0';
                    clr_res <= '0';                
                when output =>
                    qspo_ce <= '0';
                    inc_i <= '0';
                    clr_i <= '0';
                    inc_sum <= '0';
                    clr_sum <= '0';
                    load_res <= '1';
                    clr_res <= '0';
            end case;        
        end if;
        
    end process;
end Behavioral;
