--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:31:11 09/02/2015
-- Design Name:   
-- Module Name:   C:/repos/hdmi2usb_designs/Minimal_HDMI/test_bench/tb_top_level.vhd
-- Project Name:  Minimal_HDMI
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_level
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_top_level IS
END tb_top_level;
 
ARCHITECTURE behavior OF tb_top_level IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_level
    PORT(
         gclk : IN  std_logic;
         tx0_tmds_p : OUT  std_logic_vector(2 downto 0);
         tx0_tmds_n : OUT  std_logic_vector(2 downto 0);
         tx0_tmds_clk_p : OUT  std_logic;
         tx0_tmds_clk_n : OUT  std_logic;
         tx0_cec : INOUT  std_logic;
         tx0_scl : INOUT  std_logic;
         tx0_sda : INOUT  std_logic;
         tx0_hpd : IN  std_logic;
         tx1_tmds_p : OUT  std_logic_vector(2 downto 0);
         tx1_tmds_n : OUT  std_logic_vector(2 downto 0);
         tx1_tmds_clk_p : OUT  std_logic;
         tx1_tmds_clk_n : OUT  std_logic;
         tx1_cec : INOUT  std_logic;
         tx1_scl : INOUT  std_logic;
         tx1_sda : INOUT  std_logic;
         tx1_hpd : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal gclk : std_logic := '0';
   signal tx0_hpd : std_logic := '0';
   signal tx1_hpd : std_logic := '0';

	--BiDirs
   signal tx0_cec : std_logic;
   signal tx0_scl : std_logic;
   signal tx0_sda : std_logic;
   signal tx1_cec : std_logic;
   signal tx1_scl : std_logic;
   signal tx1_sda : std_logic;

 	--Outputs
   signal tx0_tmds_p : std_logic_vector(2 downto 0);
   signal tx0_tmds_n : std_logic_vector(2 downto 0);
   signal tx0_tmds_clk_p : std_logic;
   signal tx0_tmds_clk_n : std_logic;
   signal tx1_tmds_p : std_logic_vector(2 downto 0);
   signal tx1_tmds_n : std_logic_vector(2 downto 0);
   signal tx1_tmds_clk_p : std_logic;
   signal tx1_tmds_clk_n : std_logic;

   -- Clock period definitions
   constant gclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_level PORT MAP (
          gclk => gclk,
          tx0_tmds_p => tx0_tmds_p,
          tx0_tmds_n => tx0_tmds_n,
          tx0_tmds_clk_p => tx0_tmds_clk_p,
          tx0_tmds_clk_n => tx0_tmds_clk_n,
          tx0_cec => tx0_cec,
          tx0_scl => tx0_scl,
          tx0_sda => tx0_sda,
          tx0_hpd => tx0_hpd,
          tx1_tmds_p => tx1_tmds_p,
          tx1_tmds_n => tx1_tmds_n,
          tx1_tmds_clk_p => tx1_tmds_clk_p,
          tx1_tmds_clk_n => tx1_tmds_clk_n,
          tx1_cec => tx1_cec,
          tx1_scl => tx1_scl,
          tx1_sda => tx1_sda,
          tx1_hpd => tx1_hpd
        );

   -- Clock process definitions
   gclk_process :process
   begin
		gclk <= '0';
		wait for gclk_period/2;
		gclk <= '1';
		wait for gclk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for gclk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
