----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:38:19 09/02/2015 
-- Design Name: 
-- Module Name:    clocking_100_to_74p25 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

library UNISIM;
use UNISIM.VComponents.all;

entity clocking_100_to_40 is
    Port ( i       : in  STD_LOGIC;
           o       : out  STD_LOGIC;
           locked  : out  STD_LOGIC);
end clocking_100_to_40;

architecture Behavioral of clocking_100_to_40 is
   signal clkfb        : std_logic;
   signal o_unbuffered : std_logic;
begin

PLL_BASE_inst : PLL_BASE
   generic map (
      CLKFBOUT_MULT  => 8,                  
      CLKOUT0_DIVIDE => 20,      
      CLKOUT0_PHASE  => 0.0,   -- Output 5x original frequency
      CLK_FEEDBACK   => "CLKFBOUT",
      CLKIN_PERIOD   => 10.0,
      DIVCLK_DIVIDE  => 1
   )
      port map (
      CLKFBOUT => clkfb, 
      CLKOUT0  => o_unbuffered,
      CLKFBIN  => clkfb,    
      CLKIN    => i, 
      RST      => '0'
   );
   
BUFG_i: BUFG PORT MAP (
      i => o_unbuffered,
      o => o
   );
end Behavioral;

