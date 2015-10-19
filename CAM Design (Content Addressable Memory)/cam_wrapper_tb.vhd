--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:13:39 03/12/2014
-- Design Name:   
-- Module Name:   /class/classes/jmah002/cs161/Lab6/cam_wrapper_tb.vhd
-- Project Name:  Lab6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CAM_Wrapper
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
 
ENTITY cam_wrapper_tb IS
END cam_wrapper_tb;
 
ARCHITECTURE behavior OF cam_wrapper_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CAM_Wrapper
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         we_decoded_row_address : IN  std_logic_vector(7 downto 0);
         search_word : IN  std_logic_vector(7 downto 0);
         dont_care_mask : IN  std_logic_vector(7 downto 0);
         decoded_match_address : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';
   signal we_decoded_row_address : std_logic_vector(7 downto 0) := (others => '0');
   signal search_word : std_logic_vector(7 downto 0) := (others => '0');
   signal dont_care_mask : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal decoded_match_address : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CAM_Wrapper PORT MAP (
          clk => clk,
          rst => rst,
          we_decoded_row_address => we_decoded_row_address,
          search_word => search_word,
          dont_care_mask => dont_care_mask,
          decoded_match_address => decoded_match_address
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;
		rst <= '0';
      -- insert stimulus here 
		---binary cam
--		search_word <= "00000000";
--		we_decoded_row_address <= "11111111";
--      wait for clk_period*10;
--		we_decoded_row_address <= "00000000";	
--		assert decoded_match_address = "11111111" report "Test_1: incorrect"	severity Warning;
--
--		
--		search_word <= "00000000";
--		wait for clk_period*10;
--		search_word <= "11111111";
--		wait for clk_period*10;
--		assert decoded_match_address = "00000000" report "Test_2: incorrect"	severity Warning;
--		wait for clk_period*10;
--		search_word <= "10101010";
--		wait for clk_period*10;
--		assert decoded_match_address = "00000000" report "Test_3: incorrect"	severity Warning;
--     	wait for clk_period*10;
--		search_word <= "01010101";
--		wait for clk_period*10;
--		assert decoded_match_address = "00000000" report "Test_4: incorrect"	severity Warning;
--		
--      we_decoded_row_address <= "11101111";
--      wait for clk_period*10;
--		we_decoded_row_address <= "00000000";	
--		wait for clk_period*10;
--		search_word <= "01010101";
--		assert decoded_match_address = "11101111" report "Test_5: incorrect"	severity Warning;
--		wait for clk_period*10;
--		
--- stored ternary
		rst <= '1';
		rst <= '0';
		search_word <= "00000000";
		dont_care_mask <="10101010";
		we_decoded_row_address <= "11111111";
      wait for clk_period*10;
		we_decoded_row_address <= "00000000";	
		assert decoded_match_address = "11111111" report "Test_1_stored_ternary: incorrect"	severity Warning;

		
		search_word <= "00000000";
		wait for clk_period*10;
		search_word <= "11111111";
		wait for clk_period*10;
		assert decoded_match_address = "00000000" report "Test_2_stored_ternary: incorrect"	severity Warning;
		wait for clk_period*10;
		dont_care_mask <="00000000";
		search_word <= "10101010";
		wait for clk_period*10;
		assert decoded_match_address = "00000000" report "Test_3_stored_ternary: incorrect"	severity Warning;
     	wait for clk_period*10;
		search_word <= "01010101";
		wait for clk_period*10;
		assert decoded_match_address = "00000000" report "Test_4_stored_ternary: incorrect"	severity Warning;
		
		dont_care_mask <="11111111";
      we_decoded_row_address <= "11101111";
      wait for clk_period*10;
		we_decoded_row_address <= "00000000";	
		wait for clk_period*10;
		search_word <= "01010101";
		assert decoded_match_address = "11111111" report "Test_5_stored_ternary: incorrect"	severity Warning;

--- ternary at input
		rst <= '1';
		rst <= '0';
		search_word <= "00000000";
		dont_care_mask <="10101010";
		we_decoded_row_address <= "11111111";
      wait for clk_period*10;
		we_decoded_row_address <= "00000000";	
		assert decoded_match_address = "11111111" report "Test_1_ternary: incorrect"	severity Warning;

		
		search_word <= "00000000";
		wait for clk_period*10;
		search_word <= "11111111";
		wait for clk_period*10;
		assert decoded_match_address = "00000000" report "Test_2_ternary: incorrect"	severity Warning;
		wait for clk_period*10;
		dont_care_mask <="00000000";
		search_word <= "10101010";
		wait for clk_period*10;
		assert decoded_match_address = "00000000" report "Test_3_ternary: incorrect"	severity Warning;
     	wait for clk_period*10;
		search_word <= "01010101";
		wait for clk_period*10;
		assert decoded_match_address = "00000000" report "Test_4_ternary: incorrect"	severity Warning;
		
		dont_care_mask <="11111111";
      we_decoded_row_address <= "11101111";
      wait for clk_period*10;
		we_decoded_row_address <= "00000000";	
		wait for clk_period*10;
		search_word <= "01010101";
		assert decoded_match_address = "11111111" report "Test_5_ternary: incorrect"	severity Warning;

	  wait;		
   end process;

END;
