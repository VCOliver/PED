----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2023 12:44:41
-- Design Name: 
-- Module Name: master - Behavioral
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

entity master is
    Port ( clk : in STD_LOGIC;
           start : in STD_LOGIC;
           reset : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end master;

architecture Behavioral of master is

    component control_block is
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
    end component;
    
    component SAD is
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
    end component;
    
    component display_mux is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               C : in STD_LOGIC_VECTOR (3 downto 0);
               D : in STD_LOGIC_VECTOR (3 downto 0);
               an : out STD_LOGIC_VECTOR (3 downto 0);
               seg : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    component clock_240hz is
        Port ( clk : in STD_LOGIC;
               clk_240hz : out STD_LOGIC;
               rst : in std_logic);
    end component;
    
    COMPONENT ROM_A IS
      PORT (
        a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        clk : IN STD_LOGIC;
        qspo_ce : IN STD_LOGIC;
        qspo_rst : IN STD_LOGIC;
        qspo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
    END COMPONENT;
        
    COMPONENT ROM_B IS
      PORT (
        a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        clk : IN STD_LOGIC;
        qspo_ce : IN STD_LOGIC;
        qspo_rst : IN STD_LOGIC;
        qspo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
    END COMPONENT;
    
    signal i_lt_255, qspo_ce, inc_i, clr_i, inc_sum, clr_sum, load_res, clr_res, sclk : std_logic := '0';
    signal A_data, B_data, address : std_logic_vector(7 downto 0) := (others => '0');
    signal res : std_logic_vector(15 downto 0) := (others => '0');

begin

    clk_display : clock_240hz port map( 
        clk => clk,
        clk_240hz => sclk,
        rst => reset);

    control : control_block port map(
        clk => clk,
        inc_i => inc_i,
        clr_i => clr_i,
        inc_sum => inc_sum,
        clr_sum => clr_sum,
        load_res => load_res,
        clr_res => clr_res,
        i_lt_255 => i_lt_255,
        qspo_ce => qspo_ce,
        reset => reset,
        start => start
    );

    op : SAD port map(
        clk => clk,
        inc_i => inc_i,
        clr_i => clr_i,
        inc_sum => inc_sum,
        clr_sum => clr_sum,
        load_res => load_res,
        clr_res => clr_res,
        A_data => A_data,
        B_data => B_data,
        fetch => address,
        res => res,
        i_lt_255 => i_lt_255
    );    
    
    display : display_mux port map(
        clk => sclk,
        rst => reset,
        A => res(15 downto 12),
        B => res(11 downto 8),
        C => res(7 downto 4),
        D => res(3 downto 0),
        an => an,
        seg => seg
    );
        
    rom1 : ROM_A port map(
        a => address,
        clk => clk,
        qspo_ce => qspo_ce,
        qspo_rst => reset,
        qspo => A_data
    );
        
    rom2 : ROM_B port map(
        a => address,
        clk => clk,
        qspo_ce => qspo_ce,
        qspo_rst => reset,
        qspo => B_data
    );           

end Behavioral;
