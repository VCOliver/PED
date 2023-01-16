----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.01.2023 23:40:59
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity master is
    Port ( clk : in STD_LOGIC;
           an : out std_logic_vector(3 downto 0);
           seg: out std_logic_vector(6 downto 0);
           reset : in std_logic;
           rst : in std_logic;
           B : in std_logic;
           len_led : out std_logic;
           slow_led : out std_logic);
end master;

architecture Behavioral of master is

function to_bcd ( bin : std_logic_vector(10 downto 0) ) return std_logic_vector is
    variable i : integer:=0;
    variable bcd : unsigned(13 downto 0) := (others => '0');
    variable bint : unsigned(10 downto 0) := unsigned(bin);

    begin
        for i in 0 to 10 loop  -- repeating 10 times.
            bcd(13 downto 1) := bcd(12 downto 0);  --shifting the bits.
            bcd(0) := bint(10);
            bint(10 downto 1) := bint(9 downto 0);
            bint(0) := '0';
            
            
            if(i < 10 and bcd(3 downto 0) > "0100") then --add 3 if BCD digit is greater than 4.
                bcd(3 downto 0) := bcd(3 downto 0) + "0011";
            end if;
            
            if(i < 10 and bcd(7 downto 4) > "0100") then --add 3 if BCD digit is greater than 4.
                bcd(7 downto 4) := bcd(7 downto 4) + "0011";
            end if;
            
            if(i < 10 and bcd(11 downto 8) > "0100") then  --add 3 if BCD digit is greater than 4.
                bcd(11 downto 8) := bcd(11 downto 8) + "0011";
            end if;
        
        
        end loop;
        return std_logic_vector(bcd);
end to_bcd;

    component control_block is
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
    end component;
    
    component op_block is
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
    end component;

    component display_mux is
        Port ( clk : in STD_LOGIC;
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
   
   component clock_millis is
       Port ( clk : in STD_LOGIC;
              clk_1khz : out STD_LOGIC;
              rst : in std_logic);
   end component;
    
    signal rTime : std_logic_vector(10 downto 0);
    signal time_bcd : std_logic_vector(13 downto 0);
    signal singles, tens, hundreds, thousands : std_logic_vector(3 downto 0) := "0000";
    signal clk_240hz, clk_1khz, rCount_lt_2k, wCount_lt_10k,loadrTime, rstrTime, loadrCount, rstrCount, loadwCount, rstwCount : std_logic := '0';

begin

    control : control_block port map(
           clk => clk_1khz,
           --clk => clk,
           reset => reset,
           rst => rst,
           B => B,
           rCount_lt_2k => rCount_lt_2k,
           wCount_lt_10k => wCount_lt_10k,
           loadrTime => loadrTime,
           rstrTime => rstrTime,
           loadrCount => loadrCount,
           rstrCount => rstrCount,
           loadwCount => loadwCount,
           rstwCount => rstwCount,
           len_led => len_led,
           slow_led => slow_led);
           
    operational : op_block port map(
           clk => clk_1khz,
           --clk => clk,
           loadrTime => loadrTime,
           rstrTime => rstrTime,
           loadrCount => loadrCount,
           rstrCount => rstrCount,
           loadwCount => loadwCount,
           rstwCount => rstwCount,
           rCount_lt_2k => rCount_lt_2k,
           wCount_lt_10k => wCount_lt_10k,
           rTime => rTime);

    clk_display : clock_240hz port map(clk => clk, clk_240hz => clk_240hz, rst => '0');
    clk_op : clock_millis port map(clk => clk, clk_1khz => clk_1khz, rst => '0');

    time_bcd <= to_bcd(rTime);
    thousands <= "00" & time_bcd(13 downto 12);
    hundreds <= time_bcd(11 downto 8);
    tens <= time_bcd(7 downto 4);
    singles <= time_bcd(3 downto 0);

    display : display_mux port map(clk => clk_240hz, A => thousands, B => hundreds, C => tens, D => singles, an => an, seg => seg);

end Behavioral;
