----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:21:48 09/02/2015 
-- Design Name: 
-- Module Name:    top_level - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( 
      gclk : in  STD_LOGIC;
      --
      tx0_tmds_p     : out   STD_LOGIC_VECTOR (2 downto 0);
      tx0_tmds_n     : out   STD_LOGIC_VECTOR (2 downto 0);
      tx0_tmds_clk_p : out   STD_LOGIC;
      tx0_tmds_clk_n : out   STD_LOGIC;
      tx0_cec        : inout STD_LOGIC;
      tx0_scl        : inout STD_LOGIC;
      tx0_sda        : inout STD_LOGIC;
      tx0_hpd        : in    STD_LOGIC;
      ---
      tx1_tmds_p     : out   STD_LOGIC_VECTOR (2 downto 0);
      tx1_tmds_n     : out   STD_LOGIC_VECTOR (2 downto 0);
      tx1_tmds_clk_p : out   STD_LOGIC;
      tx1_tmds_clk_n : out   STD_LOGIC;
      tx1_cec        : inout STD_LOGIC;
      tx1_scl        : inout STD_LOGIC;
      tx1_sda        : inout STD_LOGIC;
      tx1_hpd        : in    STD_LOGIC        
   );
end top_level;

architecture Behavioral of top_level is
   component clocking_100_to_40 is
      port (
         i      : in  std_logic;
         o      : out std_logic;
         locked : in  std_logic
      );
   end component;
   
   component hdmi_out_test is
    Port ( 
         pixel_clk  : in    STD_LOGIC;
         --
         tmds_p     : out   STD_LOGIC_VECTOR (2 downto 0);
         tmds_n     : out   STD_LOGIC_VECTOR (2 downto 0);
         tmds_clk_p : out   STD_LOGIC;
         tmds_clk_n : out   STD_LOGIC;
         cec        : inout STD_LOGIC;
         scl        : inout STD_LOGIC;
         sda        : inout STD_LOGIC;
         hpd        : in    STD_LOGIC
      );
   end component;
   
   signal clk40  : std_logic;
   signal locked :  std_logic; 
begin

clocking: clocking_100_to_40 port map (
   i      => gclk,
   o      => clk40,
   locked => locked);
      
hdmi_out_test_0: hdmi_out_test port map (
   pixel_clk  => clk40,
   --
   tmds_p     => tx0_tmds_p,
   tmds_n     => tx0_tmds_n,
   tmds_clk_p => tx0_tmds_clk_p,
   tmds_clk_n => tx0_tmds_clk_n,
   cec        => tx0_cec,
   scl        => tx0_scl,
   sda        => tx0_sda,
   hpd        => tx0_hpd);

hdmi_out_test_1: hdmi_out_test port map (
   pixel_clk  => clk40,
   --
   tmds_p     => tx1_tmds_p,
   tmds_n     => tx1_tmds_n,
   tmds_clk_p => tx1_tmds_clk_p,
   tmds_clk_n => tx1_tmds_clk_n,
   cec        => tx1_cec,
   scl        => tx1_scl,
   sda        => tx1_sda,
   hpd        => tx1_hpd);

end Behavioral;

