----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jeremy Mah
-- 
-- Create Date:   
-- Design Name: 
-- Module Name:    alu_control - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;    

entity alu_control is
    Port ( alu_op : in  STD_LOGIC_VECTOR (1 downto 0); --alu_op
           instruction_5_0 : in  STD_LOGIC_VECTOR (5 downto 0); --funct field
           alu_out : out  STD_LOGIC_VECTOR (3 downto 0));
end alu_control;

architecture Behavioral of alu_control is
begin
	process(alu_op, instruction_5_0)

	begin
		alu_out <= "0000";
		case alu_op is
			when "00" => 
			--lw and sw
				alu_out <= "0010";
			when "01" => 
			--beq
				alu_out <= "0110";
			when "10" => 
			--add, subtract, AND, OR, set on less than
			
				if std_match("--0000",instruction_5_0 ) then --add
					alu_out <= "0010";
				elsif std_match("--0010",instruction_5_0) then --subtract
					alu_out <= "0110";
            elsif std_match("--0100",instruction_5_0) then --and
					alu_out <= "0000";
            elsif std_match("--0101",instruction_5_0) then --or
					alu_out <= "0001";
				elsif std_match("--1010",instruction_5_0) then --set on less than
					alu_out <= "0111";
				elsif std_match("--0111",instruction_5_0) then --set on less than
					alu_out <= "1100";	
				end if;
			when OTHERS =>
				NULL;
		end case;
	end process;
end Behavioral;

