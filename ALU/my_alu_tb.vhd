LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.NUMERIC_STD.ALL;

 
ENTITY my_alu_tb IS
END my_alu_tb;
 
ARCHITECTURE behavior OF my_alu_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT my_alu
			generic(
					numbits : natural			:= 32
			);
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         opcode : IN  std_logic_vector(2 downto 0);
         result : OUT  std_logic_vector(7 downto 0);
         carry_out : OUT  std_logic;
         overflow : OUT  std_logic;
         zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal opcode : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(7 downto 0);
   signal carryout : std_logic;
   signal overflow : std_logic;
   signal zero : std_logic;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: my_alu generic map(
						numbits => 8
		)
		PORT MAP (
          A => A,
          B => B,
          opcode => opcode,
          result => result,
          carry_out => carryout,
          overflow => overflow,
          zero => zero
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		wait for 10 ns;

		-- insert stimulus here
		
		-- --------------------------------------------------------------------------------
		-- --------------------------------------------------------------------------------
		-- Testing Unsigned Add
		-- --------------------------------------------------------------------------------
		-- --------------------------------------------------------------------------------
		report "Testing Unsigned Add \n";
		report "";
		opcode <= "000";
		
			-- Test 1
			A <= conv_std_logic_vector(2, 8);
			B <= conv_std_logic_vector(2, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(4, 8) 	report "Test_1ua: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_1ua: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_1ua: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_1ua: zero incorrect"		severity Warning;
			
			
			-- Test 2
			A <= conv_std_logic_vector(0, 8);
			B <= conv_std_logic_vector(0, 8);

			wait for 10 ns;
			assert result = conv_std_logic_vector(0, 8) 	report "Test_2ua: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_2ua: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_2ua: overflow incorrect"	severity Warning;
			assert zero = '1'										report "Test_2ua: zero incorrect"		severity Warning;
			
			-- Test 3
			A <= conv_std_logic_vector(128, 8);
			B <= conv_std_logic_vector(4, 8);

			wait for 10 ns;
			assert result = conv_std_logic_vector(132, 8) report "Test_3ua: result incorrect" 	severity Warning;
			assert carryout = '0' 								 report "Test_3ua: carryout incorrect"	severity Warning;
			assert overflow = '0' 								 report "Test_3ua: overflow incorrect"	severity Warning;
			assert zero = '0'										 report "Test_3ua: zero incorrect"		severity Warning;
		
			-- Test 4
			A <= conv_std_logic_vector(128, 8);
			B <= conv_std_logic_vector(128, 8);

			wait for 10 ns;
			assert result = conv_std_logic_vector(0, 8) 	report "Test_4ua: result incorrect" 	severity Warning;
			assert carryout = '1' 								report "Test_4ua: carryout incorrect"	severity Warning;
			assert overflow = '1' 								report "Test_4ua: overflow incorrect"	severity Warning;
			assert zero = '1'										report "Test_4ua: zero incorrect"		severity Warning;
			
			-- Test 5
			A <= conv_std_logic_vector(128, 8);
			B <= conv_std_logic_vector(132, 8);

			wait for 10 ns;
			assert result = conv_std_logic_vector(4, 8) 	report "Test_5ua: result incorrect" 	severity Warning;
			assert carryout = '1' 								report "Test_5ua: carryout incorrect"	severity Warning;
			assert overflow = '1' 								report "Test_5ua: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_5ua: zero incorrect"		severity Warning;
			
      wait for 10 ns;	

		
		
		-- --------------------------------------------------------------------------------
		-- --------------------------------------------------------------------------------
		-- Testing Signed Add
		-- --------------------------------------------------------------------------------
		-- --------------------------------------------------------------------------------
		report "Testing Signed Add";
		report "";
		opcode <= "001";
		
			-- Test 1
			A <= conv_std_logic_vector(-2, 8);
			B <= conv_std_logic_vector(-2, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(-4, 8) report "Test_1sa: result incorrect" 	severity Warning;
			assert carryout = '1' 								report "Test_1sa: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_1sa: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_1sa: zero incorrect"		severity Warning;
			
			
			-- Test 2
			A <= conv_std_logic_vector(0, 8);
			B <= conv_std_logic_vector(0, 8);

			wait for 10 ns;
			assert result = conv_std_logic_vector(0, 8) 	report "Test_2sa: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_2sa: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_2sa: overflow incorrect"	severity Warning;
			assert zero = '1'										report "Test_2sa: zero incorrect"		severity Warning;
			
			-- Test 3
			A <= conv_std_logic_vector(100, 8);
			B <= conv_std_logic_vector(50, 8);

			wait for 10 ns;
			assert result = conv_std_logic_vector(-106, 8) 	report "Test_3sa: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_3sa: carryout incorrect"	severity Warning;
			assert overflow = '1' 								report "Test_3sa: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_3sa: zero incorrect"		severity Warning;
			
			
			-- Test 4
			A <= conv_std_logic_vector(64, 8);
			B <= conv_std_logic_vector(64, 8);

			wait for 10 ns;
			assert result = conv_std_logic_vector(-128, 8) 	report "Test_4sa: result incorrect" 	severity Warning;
			assert carryout = '0' 								   report "Test_4sa: carryout incorrect"	severity Warning;
			assert overflow = '1' 								   report "Test_4sa: overflow incorrect"	severity Warning;
			assert zero = '0'										   report "Test_4sa: zero incorrect"		severity Warning;

			-- Test 5
			A <= conv_std_logic_vector(-64, 8);
			B <= conv_std_logic_vector(-64, 8);

			wait for 10 ns;
			assert result = conv_std_logic_vector(-128, 8) 	report "Test_5sa: result incorrect" 	severity Warning;
			assert carryout = '1' 								   report "Test_5sa: carryout incorrect"	severity Warning;
			assert overflow = '0' 								   report "Test_5sa: overflow incorrect"	severity Warning;
			assert zero = '0'										   report "Test_5sa: zero incorrect"		severity Warning;
			
      wait for 10 ns;	
	  
		-- --------------------------------------------------------------------------------
		-- --------------------------------------------------------------------------------
		-- Testing Unsigned Subtract
		-- --------------------------------------------------------------------------------
		-- --------------------------------------------------------------------------------
		report "Testing Unsigned Sub";
		report "";
		opcode <= "010";
		
			-- Test 1
			A <= conv_std_logic_vector(10, 8);
			B <= conv_std_logic_vector(8, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(2, 8) report "Test_1us: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_1us: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_1us: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_1us: zero incorrect"		severity Warning;
			
			
			-- Test 2
			A <= conv_std_logic_vector(10, 8);
			B <= conv_std_logic_vector(10, 8);

			wait for 10 ns;
			assert result = conv_std_logic_vector(0, 8) 	report "Test_2us: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_2us: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_2us: overflow incorrect"	severity Warning;
			assert zero = '1'										report "Test_2us: zero incorrect"		severity Warning;
			
			-- Test 3
			A <= conv_std_logic_vector(5, 8);
			B <= conv_std_logic_vector(10, 8);

			wait for 10 ns;
			assert result = conv_std_logic_vector(-5, 8) 	report "Test_3us: result incorrect" 	severity Warning;
			assert carryout = '1' 								report "Test_3us: carryout incorrect"	severity Warning;
			assert overflow = '1' 								report "Test_3us: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_3us: zero incorrect"		severity Warning;
				
      wait for 10 ns;	
	  
		-- --------------------------------------------------------------------------------
		-- --------------------------------------------------------------------------------
		-- Testing Signed Subtract
		-- --------------------------------------------------------------------------------
		-- --------------------------------------------------------------------------------
		report "Testing Signed Sub";
		report "";
		opcode <= "011";
		
			-- Test 1
			A <= conv_std_logic_vector(-1, 8);
			B <= conv_std_logic_vector(-11, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(10, 8) report "Test_1ss: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_1ss: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_1ss: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_1ss: zero incorrect"		severity Warning;
			
			
			-- Test 2
			A <= conv_std_logic_vector(0, 8);
			B <= conv_std_logic_vector(0, 8);

			wait for 10 ns;
			assert result = conv_std_logic_vector(0, 8) 	report "Test_2ss: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_2ss: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_2ss: overflow incorrect"	severity Warning;
			assert zero = '1'										report "Test_2ss: zero incorrect"		severity Warning;
						
			-- Test 3
			A <= conv_std_logic_vector(-10, 8);
			B <= conv_std_logic_vector(-10, 8);

			wait for 10 ns;
			assert result = conv_std_logic_vector(0, 8) 	report "Test_3ss: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_3ss: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_3ss: overflow incorrect"	severity Warning;
			assert zero = '1'										report "Test_3ss: zero incorrect"		severity Warning;
			
			-- Test 4
			A <= conv_std_logic_vector(-50, 8);
			B <= conv_std_logic_vector(30, 8);

			wait for 10 ns;
			assert result = conv_std_logic_vector(-80, 8) 	report "Test_4ss: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_4ss: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_4ss: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_4ss: zero incorrect"		severity Warning;
			
			
			-- Test 5
			A <= conv_std_logic_vector(-64, 8);
			B <= conv_std_logic_vector(64, 8);

			wait for 10 ns;
			assert result = conv_std_logic_vector(-128, 8) 	report "Test_5ss: result incorrect" 	severity Warning;
			assert carryout = '0' 								   report "Test_5ss: carryout incorrect"	severity Warning;
			assert overflow = '0' 								   report "Test_5ss: overflow incorrect"	severity Warning;
			assert zero = '0'										   report "Test_5ss: zero incorrect"		severity Warning;
			
						
			-- Test 6
			A <= conv_std_logic_vector(64, 8);
			B <= conv_std_logic_vector(64, 8);

			wait for 10 ns;
			assert result = conv_std_logic_vector(0, 8) 	report "Test_6ss: result incorrect" 	severity Warning;
			assert carryout = '0' 								   report "Test_6ss: carryout incorrect"	severity Warning;
			assert overflow = '0' 								   report "Test_6ss: overflow incorrect"	severity Warning;
			assert zero = '1'										   report "Test_6ss: zero incorrect"		severity Warning;

			wait for 10 ns;
	  
	  
		-- --------------------------------------------------------------------------------
		-- --------------------------------------------------------------------------------
		-- Testing AND
		-- --------------------------------------------------------------------------------
		-- --------------------------------------------------------------------------------
		report "Testing AND";
		report "";
		opcode <= "100";
		
			-- Test 1
			A <= conv_std_logic_vector(0, 8);
			B <= conv_std_logic_vector(0, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(0, 8) report "Test_1and: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_1and: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_1and: overflow incorrect"	severity Warning;
			assert zero = '1'										report "Test_1and: zero incorrect"		severity Warning;

			-- Test 2
			A <= conv_std_logic_vector(255, 8);
			B <= conv_std_logic_vector(0, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(0, 8) report "Test_2and: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_2and: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_2and: overflow incorrect"	severity Warning;
			assert zero = '1'										report "Test_2and: zero incorrect"		severity Warning;

			-- Test 3
			A <= conv_std_logic_vector(255, 8);
			B <= conv_std_logic_vector(170, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(170, 8) report "Test_3and: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_3and: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_3and: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_3and: zero incorrect"		severity Warning;
			
			-- Test 4
			A <= conv_std_logic_vector(240, 8);
			B <= conv_std_logic_vector(15, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(0, 8) report "Test_4and: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_4and: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_4and: overflow incorrect"	severity Warning;
			assert zero = '1'										report "Test_4and: zero incorrect"		severity Warning;


      wait for 10 ns;	
	  
		-- --------------------------------------------------------------------------------
		-- --------------------------------------------------------------------------------
		-- Testing OR
		-- --------------------------------------------------------------------------------
		-- --------------------------------------------------------------------------------
		report "Testing OR";
		report "";
		opcode <= "101";
		
			-- Test 1
			A <= conv_std_logic_vector(0, 8);
			B <= conv_std_logic_vector(255, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(255, 8) report "Test_1or: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_1or: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_1or: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_1or: zero incorrect"		severity Warning;
			
			-- Test 2
			A <= conv_std_logic_vector(0, 8);
			B <= conv_std_logic_vector(0, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(0, 8) report "Test_2or: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_2or: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_2or: overflow incorrect"	severity Warning;
			assert zero = '1'										report "Test_2or: zero incorrect"		severity Warning;
			
			-- Test 3
			A <= conv_std_logic_vector(240, 8);
			B <= conv_std_logic_vector(15, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(255, 8) report "Test_3or: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_3or: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_3or: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_3or: zero incorrect"		severity Warning;
			
			-- Test 4
			A <= conv_std_logic_vector(170, 8);
			B <= conv_std_logic_vector(85, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(255, 8) report "Test_4or: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_4or: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_4or: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_4or: zero incorrect"		severity Warning;
			
			
      wait for 10 ns;	
	  
		-- --------------------------------------------------------------------------------
		-- --------------------------------------------------------------------------------
		-- Testing XOR
		-- --------------------------------------------------------------------------------
		-- --------------------------------------------------------------------------------
		report "Testing XOR";
		report "";
		opcode <= "110";
		
			-- Test 1
			A <= conv_std_logic_vector(255, 8);
			B <= conv_std_logic_vector(0, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(255, 8) report "Test_1xor: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_1xor: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_1xor: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_1xor: zero incorrect"		severity Warning;
			
      wait for 10 ns;	
	  
			-- Test 2
			A <= conv_std_logic_vector(255, 8);
			B <= conv_std_logic_vector(255, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(0, 8) report "Test_2xor: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_2xor: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_2xor: overflow incorrect"	severity Warning;
			assert zero = '1'										report "Test_2xor: zero incorrect"		severity Warning;
			
			-- Test 3
			A <= conv_std_logic_vector(255, 8);
			B <= conv_std_logic_vector(240, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(15, 8) report "Test_3xor: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_3xor: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_3xor: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_3xor: zero incorrect"		severity Warning;
			
			-- Test 4
			A <= conv_std_logic_vector(0, 8);
			B <= conv_std_logic_vector(240, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(240, 8) report "Test_4xor: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_4xor: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_4xor: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_4xor: zero incorrect"		severity Warning;
			
			-- Test 5
			A <= conv_std_logic_vector(255, 8);
			B <= conv_std_logic_vector(170, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(85, 8) report "Test_4xor: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_4xor: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_4xor: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_4xor: zero incorrect"		severity Warning;
			
		-- --------------------------------------------------------------------------------
		-- --------------------------------------------------------------------------------
		-- Testing Divide By 2
		-- --------------------------------------------------------------------------------
		-- --------------------------------------------------------------------------------
		report "Testing Divide By 2";
		report "";
		opcode <= "111";
		
			-- Test 1
			A <= conv_std_logic_vector(10, 8);
report "1";
			wait for 10 ns;
			assert result = conv_std_logic_vector(5, 8) report "Test_1d: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_1d: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_1d: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_1d: zero incorrect"		severity Warning;
      wait for 10 ns;	

			-- Test 2
			A <= conv_std_logic_vector(5, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(2, 8) report "Test_2d: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_2d: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_2d: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_2d: zero incorrect"		severity Warning;
			
			-- Test 3

			A <= conv_std_logic_vector(10, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(5, 8) report "Test_3d: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_3d: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_3d: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_3d: zero incorrect"		severity Warning;

		  	-- Test 4

			A <= conv_std_logic_vector(255, 8);
			
			wait for 10 ns;
			assert result = conv_std_logic_vector(127, 8) report "Test_4d: result incorrect" 	severity Warning;
			assert carryout = '0' 								report "Test_4d: carryout incorrect"	severity Warning;
			assert overflow = '0' 								report "Test_4d: overflow incorrect"	severity Warning;
			assert zero = '0'										report "Test_4d: zero incorrect"		severity Warning;
			
				report "FINISHED TESTING";
		wait;
   end process;

END;