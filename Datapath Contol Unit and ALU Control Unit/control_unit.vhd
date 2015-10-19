----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jeremy Mah
-- 
-- Create Date:    
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
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

entity control_unit is
    Port ( instr_op : in  STD_LOGIC_VECTOR (5 downto 0);
           reg_dst : out  STD_LOGIC;
           branch : out  STD_LOGIC;
           mem_read : out  STD_LOGIC;
           mem_to_reg : out  STD_LOGIC;
           alu_op : out  STD_LOGIC_VECTOR (1 downto 0);
           mem_write : out  STD_LOGIC;
           alu_src : out  STD_LOGIC;
           reg_write : out  STD_LOGIC);
end control_unit;

architecture Behavioral of control_unit is

--signals go here.

begin
	process(instr_op)
	--variables go here.
	begin
		--point signals here
		reg_dst <= '0';
		branch <= '0';
		mem_read <= '0';
		mem_to_reg <= '0';
		alu_op <= "00";
		mem_write <= '0';
		alu_src <= '0';
		reg_write <= '0';
		
		--set variables here
		--code
		
		case instr_op is
			when "000000" => --R-format
				reg_dst <= '1';
				reg_write <= '1';
				alu_op <= "10";
         when "100011" => --lw
				alu_src <= '1';
				mem_to_reg <= '1';
				reg_write <= '1';
				mem_read <= '1';
         when "101011" => --sw
				reg_dst <= '-';
				alu_src <= '1';
				mem_write <= '1';
				mem_to_reg <= '-';
		when "000100" => --beq
				reg_dst <= '-';
				branch <= '1';
				alu_op <= "01";
				mem_to_reg <= '-';
        when "001000" => --beq
				reg_write <= '1';
				alu_src <= '1';
        when "001001" =>	
                reg_dst <= '0';
                mem_read <= '0';
                mem_write <= '0';
                branch <= '0';
                alu_op <= "00";
                alu_src <= '1';
                mem_to_reg <= '0';
                reg_write <= '1';    
			when OTHERS =>
				NULL;
		end case;
		
	end process;

end Behavioral;

