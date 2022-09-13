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

entity master is
    Port ( 
        clk : in std_logic;
        an : out std_logic_vector(3 downto 0);
        seg : out std_logic_vector(6 downto 0)
    );
end master;

architecture Behavioral of master is

    component display
        Port(
            A : in std_logic_vector(3 downto 0); -- numero do display 3
            B : in std_logic_vector(3 downto 0); -- numero do display 2
            C : in std_logic_vector(3 downto 0); -- numero do display 1
            D : in std_logic_vector(3 downto 0); -- numero do display 0
            an : out std_logic_vector(3 downto 0); -- display
            seg : out std_logic_vector(6 downto 0) -- numero decodificado
        );
    end component;

    component info
        Port(
            clk : in std_logic;
            A : out std_logic_vector(3 downto 0);
            B : out std_logic_vector(3 downto 0);
            C : out std_logic_vector(3 downto 0);
            D : out std_logic_vector(3 downto 0)
        );
    end component;

    signal clk_05, clk_50 : std_logic;
    signal A, B, C, D : std_logic_vector(3 downto 0);

begin

    clock_05hz : clock05hz port map(clk => clk, clk_05 => clk_05);
    clock_50hz : clock05hz port map(clk => clk, clk_50 => clk_50);

    info1 : info port map(clk => clk_05, A => A, B => B, C => C, D => D);

    display1 : display port map(clk => clk_50, A => A, B => B, C => C, D => D, an => an, seg => seg);

end Behavioral;