----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2023 12:44:41
-- Design Name: 
-- Module Name: SAD - Behavioral
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

entity SAD is
    Port ( clk : in STD_LOGIC;
           inc_i : in STD_LOGIC;
           clr_i : in STD_LOGIC;
           inc_sum : in STD_LOGIC;
           clr_sum : in STD_LOGIC;
           load_res : in STD_LOGIC;
           clr_res : in STD_LOGIC;
           A_data : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           B_data : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           fetch : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           res : out std_logic_vector(15 downto 0);
           i_lt_255 : out STD_LOGIC);
end SAD;

architecture Behavioral of SAD is

    signal i : integer range 0 to 255 := 0;
    signal sum : unsigned(15 downto 0) := (others => '0');
    signal A, B : unsigned(7 downto 0) := (others => '0');

begin
    
    A <= unsigned(A_data);
    B <= unsigned(B_data);

    process(clk, clr_i, inc_i)
    begin
        if clr_i = '1' then
            i <= 0;
            fetch <= (others => '0');
        elsif rising_edge(clk) then
        
            fetch <= std_logic_vector(to_unsigned(i, fetch'length));
            
            if inc_i = '1' then
                i <= i + 1;
            end if;
            
            if i >= 255 then
                i_lt_255 <= '0';
            else 
                i_lt_255 <= '1';
            end if;
        end if;
    end process;
    
    process(clk, inc_sum, clr_sum)
    begin
        if clr_sum = '1' then
            sum <= (others => '0');
        elsif rising_edge(clk) then
            if inc_sum = '1' then
                sum <= sum + unsigned(abs(signed(A - B)));
            end if;
        end if;
    end process; 
       
    process(clk, load_res, clr_res)
    begin
        if clr_res = '1' then
            res <= (others => '0');
        elsif rising_edge(clk) then
            if load_res = '1' then
                res <= std_logic_vector(sum);
            end if;
        end if;
    end process;

end Behavioral;
