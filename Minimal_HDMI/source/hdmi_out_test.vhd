----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:39:14 09/02/2015 
-- Design Name: 
-- Module Name:    hdmi_out_test - Behavioral 
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

entity hdmi_out_test is
    Port ( 
         pixel_clk  : in  STD_LOGIC;
         --
         tmds_p     : out   STD_LOGIC_VECTOR (2 downto 0);
         tmds_n     : out   STD_LOGIC_VECTOR (2 downto 0);
         tmds_clk_p : out   STD_LOGIC;
         tmds_clk_n : out   STD_LOGIC;
         cec        : inout STD_LOGIC;
         scl        : inout  STD_LOGIC;
         sda        : inout STD_LOGIC;
         hpd        : in    STD_LOGIC
      );
end hdmi_out_test;

architecture Behavioral of hdmi_out_test is

   COMPONENT vga_gen
   PORT(
      pixel_clock     : IN  std_logic;
      red_p           : OUT std_logic_vector(7 downto 0);
      green_p         : OUT std_logic_vector(7 downto 0);
      blue_p          : OUT std_logic_vector(7 downto 0);
      blank           : OUT std_logic;
      hsync           : OUT std_logic;
      vsync           : OUT std_logic
      );
   END COMPONENT;

   COMPONENT Minimal_hdmi_symbols
   PORT(
      clk : IN std_logic;
      blank : IN std_logic;
      hsync : IN std_logic;
      vsync : IN std_logic;
      red   : IN std_logic;
      green : IN std_logic;
      blue  : IN std_logic;          
      c0    : OUT std_logic_vector(9 downto 0);          
      c1    : OUT std_logic_vector(9 downto 0);          
      c2    : OUT std_logic_vector(9 downto 0)         
      );
   END COMPONENT;
 
	COMPONENT serializers
	PORT(
		clk : IN std_logic;
		c0 : IN std_logic_vector(9 downto 0);
		c1 : IN std_logic_vector(9 downto 0);
		c2 : IN std_logic_vector(9 downto 0);          
		hdmi_p : OUT std_logic_vector(3 downto 0);
		hdmi_n : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
 
   signal red_p   : std_logic_vector(7 downto 0);
   signal green_p : std_logic_vector(7 downto 0);
   signal blue_p  : std_logic_vector(7 downto 0);
   signal blank   : std_logic;
   signal hsync   : std_logic;
   signal vsync   : std_logic;          

   signal c0, c1, c2 : std_logic_vector(9 downto 0);
begin
   cec <= 'Z';
   sda <= 'Z';
   scl <= 'Z';
---------------------------------------
-- Generate a 800x600 VGA test pattern
---------------------------------------
Inst_vga_gen: vga_gen PORT MAP(
      pixel_clock     => pixel_clk,      
      red_p           => red_p,
      green_p         => green_p,
      blue_p          => blue_p,
      blank           => blank,
      hsync           => hsync,
      vsync           => vsync
   );

---------------------------------------------------
-- Convert 9 bits of the VGA signals to the DVI-D/TMDS output 
---------------------------------------------------
i_Minimal_hdmi_symbols: Minimal_hdmi_symbols PORT MAP(
      clk    => pixel_clk,
      blank  => blank,
      hsync  => hsync,
      vsync  => vsync,
      red    => red_p(7),
      green  => green_p(7),
      blue   => blue_p(7),
      c0     => c0,
      c1     => c1,
      c2     => c2
   );

i_serializers : serializers PORT MAP (
      clk       => pixel_clk,
      c0        => c0,
      c1        => c1,
      c2        => c2,
      hdmi_p(0) => tmds_p(0),
      hdmi_p(1) => tmds_p(1),
      hdmi_p(2) => tmds_p(2),
      hdmi_p(3) => tmds_clk_p,
      hdmi_n(0) => tmds_n(0),
      hdmi_n(1) => tmds_n(1),
      hdmi_n(2) => tmds_n(2),
      hdmi_n(3) => tmds_clk_n
      );
      
end Behavioral;