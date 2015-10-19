--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:27:13 02/10/2014
-- Design Name:   
-- Module Name:   /class/classes/jmah002/cs161/Lab2/my_alu_tb.vhd
-- Project Name:  Lab2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: my_alu
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY my_alu_tb_vhd IS
END my_alu_tb_vhd;

ARCHITECTURE behavior OF my_alu_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT my_alu
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		Opcode : IN std_logic_vector(3 downto 0);          
		Result : OUT std_logic_vector(35 downto 0);
		Carry_out : OUT std_logic;
		Overflow : OUT std_logic;
		Zero : OUT std_logic
		);
	END COMPONENT;

	--Inputs
	SIGNAL A :  std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL B :  std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL Opcode :  std_logic_vector(3 downto 0) := (others=>'0');

	--Outputs
	SIGNAL Result :  std_logic_vector(35 downto 0);
	SIGNAL Carry_out :  std_logic;
	SIGNAL Overflow :  std_logic;
	SIGNAL Zero :  std_logic;
	


BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: my_alu PORT MAP(
		A => A,
		B => B,
		Opcode => Opcode,
		Result => Result,
		Carry_out => Carry_out,
		Overflow => Overflow,
		Zero => Zero
	);

	-- Clock process definitions
-- Stimulus process
stim_proc: process
begin
-- hold reset state for 100 ns.


wait for 10 ns;
report "Testing Unsigned Add \n";
report "";
opcode <= "1000"; -- unsigned add
A <= "00000000000000000000000000001000";
B <= "00000000000000000000000000001000";
wait for 10 ns;
assert Result = "00010110"						 	report "Test_1ua: result incorrect" 	severity Warning;
assert Carry_out = '0' 								report "Test_1ua: carryout incorrect"	severity Warning;
assert Overflow = '0' 								report "Test_1ua: overflow incorrect"	severity Warning;
assert Zero = '0'										report "Test_1ua: zero incorrect"		severity Warning;



A <= "00000000000101000111000000000001";
B <= "00000011000000110000000000000001";
wait for 10 ns;
assert Result = "0011000101110111000000000010"						 	report "Test_2ua: result incorrect" 	severity Warning;
assert Carry_out = '0' 								report "Test_2ua: carryout incorrect"	severity Warning;
assert Overflow = '0' 								report "Test_2ua: overflow incorrect"	severity Warning;
assert Zero = '0'										report "Test_2ua: zero incorrect"		severity Warning;


A <= "10000000000000000000000000000001";
B <= "10000000000000000000000000000001";
wait for 10 ns;
assert Result = "000101100000000000000000000000000010"						 	report "Test_3ua: result incorrect" 	severity Warning;
assert Carry_out = '1' 								report "Test_3ua: carryout incorrect"	severity Warning;
assert Overflow = '1' 								report "Test_3ua: overflow incorrect"	severity Warning;
assert Zero = '0'										report "Test_3ua: zero incorrect"		severity Warning;


A <= "00001000000000000000100000001000";
B <= "00001000000000000000100000001000";
wait for 10 ns;
assert Result = "00010110000000000001011000010110"						 	report "Test_4ua: result incorrect" 	severity Warning;
assert Carry_out = '0' 								report "Test_4ua: carryout incorrect"	severity Warning;
assert Overflow = '0' 								report "Test_4ua: overflow incorrect"	severity Warning;
assert Zero = '0'										report "Test_4ua: zero incorrect"		severity Warning;


A <= "10011001100110011001100110011001";
B <= "10011001100110011001100110011001";
wait for 10 ns;
assert Result = "000110011001100110011001100110011000"						 	report "Test_5ua: result incorrect" 	severity Warning;
assert Carry_out = '1' 								report "Test_5ua: carryout incorrect"	severity Warning;
assert Overflow = '1' 								report "Test_5ua: overflow incorrect"	severity Warning;
assert Zero = '0'										report "Test_5ua: zero incorrect"		severity Warning;


A <= "00000000000000000000000000000000";
B <= "00000000000000000000000000000000";
wait for 10 ns;
assert Result = "0"						 	report "Test_1ua: result incorrect" 	severity Warning;
assert Carry_out = '0' 								report "Test_6ua: carryout incorrect"	severity Warning;
assert Overflow = '0' 								report "Test_6ua: overflow incorrect"	severity Warning;
assert Zero = '1'										report "Test_6ua: zero incorrect"		severity Warning;
-- signed add

opcode <= "1100";
A <= "00010000000000000000000000001001";
B <= "00000000000000000000000000000101";
wait for 10 ns;
assert Result = "000100000000000000000000000000000100"						 	report "Test_1sa: result incorrect" 	severity Warning;
assert Carry_out = '0' 								report "Test_1sa: carryout incorrect"	severity Warning;
assert Overflow = '0' 								report "Test_1sa: overflow incorrect"	severity Warning;
assert Zero = '0'										report "Test_1sa: zero incorrect"		severity Warning;


A <= "00010000000000000000000000000001";
B <= "00000000000000000000000000000010";
wait for 10 ns;
assert Result = "1"						 	report "Test_2sa: result incorrect" 	severity Warning;
assert Carry_out = '0' 								report "Test_2sa: carryout incorrect"	severity Warning;
assert Overflow = '0' 								report "Test_2sa: overflow incorrect"	severity Warning;
assert Zero = '0'										report "Test_2sa: zero incorrect"		severity Warning;


A <= "00010000000000000000000000000111";
B <= "00000000000000000000000000000111";
wait for 10 ns;
assert Result = "0"						 	report "Test_3sa: result incorrect" 	severity Warning;
assert Carry_out = '0' 								report "Test_3sa: carryout incorrect"	severity Warning;
assert Overflow = '0' 								report "Test_3sa: overflow incorrect"	severity Warning;
assert Zero = '1'										report "Test_3sa: zero incorrect"		severity Warning;


A <= "00010000000000000000000000000111";
B <= "00010000000000000000000000000111";
wait for 10 ns;
assert Result = "000100000000000000000000000000001110"						 	report "Test_4sa: result incorrect" 	severity Warning;
assert Carry_out = '0' 								report "Test_4sa: carryout incorrect"	severity Warning;
assert Overflow = '0' 								report "Test_4sa: overflow incorrect"	severity Warning;
assert Zero = '0'										report "Test_4sa: zero incorrect"		severity Warning;
--subtract
opcode <= "1001";
A <= "10011001100110011001100110011001";
B <= "10010000000000000000000000001001";
wait for 10 ns;
assert Result = "00001001100110011001100110010000"						 	report "Test_1us: result incorrect" 	severity Warning;
assert Carry_out = '0' 								report "Test_1us: carryout incorrect"	severity Warning;
assert Overflow = '0' 								report "Test_1us: overflow incorrect"	severity Warning;
assert Zero = '0'										report "Test_1us: zero incorrect"		severity Warning;

opcode <= "1001";
A <= "10010000000000000000000000001001";
B <= "10011001100110011001100110011001";
wait for 10 ns;
assert Result = "000000000110000101100001011000010000"						 	report "Test_2us: result incorrect" 	severity Warning;
assert Carry_out = '1' 								report "Test_2us: carryout incorrect"	severity Warning;
assert Overflow = '1' 								report "Test_2us: overflow incorrect"	severity Warning;
assert Zero = '0'										report "Test_2us: zero incorrect"		severity Warning;


opcode <= "1001";
A <= "00000000000000000000000000000111";
B <= "00000000000000000000000000000111";
wait for 10 ns;
assert Result = "00000000000000000000000000000000"						 	report "Test_3us: result incorrect" 	severity Warning;
assert Carry_out = '0' 								report "Test_3us: carryout incorrect"	severity Warning;
assert Overflow = '0' 								report "Test_3us: overflow incorrect"	severity Warning;
assert Zero = '1'										report "Test_3us: zero incorrect"		severity Warning;

-- signed subtract
opcode <= "1101";
A <= "00010000000000000000000000001001";
B <= "00000000000000000000000000000101";
wait for 10 ns;
assert Result = "000100000000000000000000000000010100"						 	report "Test_1ss: result incorrect" 	severity Warning;
assert Carry_out = '0' 								report "Test_1ss: carryout incorrect"	severity Warning;
assert Overflow = '0' 								report "Test_1ss: overflow incorrect"	severity Warning;
assert Zero = '0'										report "Test_1ss: zero incorrect"		severity Warning;
opcode <= "1101";
A <= "00010000000000000000000000000101";
B <= "00000000000000000000000000001001";
wait for 10 ns;
assert Result = "000100000000000000000000000000010100"						 	report "Test_2ss: result incorrect" 	severity Warning;
assert Carry_out = '0' 								report "Test_2ss: carryout incorrect"	severity Warning;
assert Overflow = '0' 								report "Test_2ss: overflow incorrect"	severity Warning;
assert Zero = '0'										report "Test_2ss: zero incorrect"		severity Warning;
wait for 10 ns;
opcode <= "1101";
A <= "00010000000000000000000000001001";
B <= "00010000000000000000000000000101";
wait for 10 ns;
assert Result = "000100000000000000000000000000000100"						 	report "Test_3ss: result incorrect" 	severity Warning;
assert Carry_out = '0' 								report "Test_3ss: carryout incorrect"	severity Warning;
assert Overflow = '0' 								report "Test_3ss: overflow incorrect"	severity Warning;
assert Zero = '0'										report "Test_3ss: zero incorrect"		severity Warning;
opcode <= "1101";
A <= "00010011000000000000000000000111";
B <= "00010011000000000000000000000111";
wait for 10 ns;
assert Result = "000000000000000000000000000000000000"						 	report "Test_4ss: result incorrect" 	severity Warning;
assert Carry_out = '0' 								report "Test_4ss: carryout incorrect"	severity Warning;
assert Overflow = '0' 								report "Test_4ss: overflow incorrect"	severity Warning;
assert Zero = '1'										report "Test_4ss: zero incorrect"		severity Warning;
wait for 10 ns;


		wait; -- will wait forever
	END PROCESS;

END;
