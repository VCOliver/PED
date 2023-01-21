----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2023 16:46:38
-- Design Name: 
-- Module Name: tb - Behavioral
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

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is

component master is
    Port ( clk : in STD_LOGIC;
           start : in STD_LOGIC;
           reset : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;

    signal clk, start, reset : std_logic := '0';
    signal an : std_logic_vector(3 downto 0) := "0000";
    signal seg : std_logic_vector(6 downto 0) := (others => '0');

begin

    m : master port map(
        clk => clk,
        start => start,
        reset => reset,
        an => an,
        seg => seg
    );

    clk <= not clk after 1 ns;
    reset <= '1' after 3 ns, '0' after 5 ns;
    start <= '1' after 5 ns, '0' after 8 ns;

end Behavioral;
