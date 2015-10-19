----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:47:24 01/06/2014 
-- Design Name: 
-- Module Name:    my_alu - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity my_alu is
	Generic( NUMBITS : natural := 8
	);
    Port ( A : in  STD_LOGIC_VECTOR (NUMBITS - 1 downto 0);
           B : in  STD_LOGIC_VECTOR (NUMBITS - 1 downto 0);
           opcode : in  STD_LOGIC_VECTOR (2 downto 0);
           overflow : out  STD_LOGIC;
           zero : out  STD_LOGIC;
           result : out  STD_LOGIC_VECTOR (NUMBITS - 1 downto 0);
           carry_out : out  STD_LOGIC);
end my_alu;

architecture Behavioral of my_alu is



begin
	process(A,B,opcode)
		variable temp : STD_LOGIC_VECTOR (NUMBITS downto 0);
		variable zero1 : STD_LOGIC_VECTOR (NUMBITS-1 downto 0);
	begin
	carry_out <= '0';
	overflow <= '0';
	zero <= '0';
	zero1 := (OTHERS =>'0');
	
	
		case opcode is
			when "000" => 
-- unsigned add
				temp := ('0'&A) + ('0'&B);

				if(temp(NUMBITS) = '1') then
					overflow <= '1';
					carry_out <= '1';
				end if;
				if(temp(NUMBITS-1 downto 0) = zero1) then
					zero <= '1';
				end if;
				
				result <= temp(NUMBITS-1 downto 0);
				
    		when "001" => 
-- signed add
				temp := std_logic_vector(signed('0'&A)+signed('0'&B));
				if(temp(NUMBITS) = '1') then
					carry_out<= '1';
				end if;
				if (temp(NUMBITS-1 downto 0) = zero1) then
					zero <= '1';
				end if;
				if( ((signed(A)>=0) and (signed(B) >=0) and (signed(temp(NUMBITS-1 downto 0)) <0)) or
				((signed(A)<0) and (signed(B)<0) and (signed(temp(NUMBITS-1 downto 0)) >=0))) then
				overflow <= '1';
				end if;
				result <= temp(NUMBITS-1 downto 0);
				
			when "010" => 
-- unsigned sub		
				temp := ('0'&A) - ('0'&B);

				if(temp(NUMBITS) = '1') then
					overflow <= '1';
					carry_out <= '1';
				end if;
				if(temp(NUMBITS-1 downto 0) = zero1) then
					zero <= '1';
				end if;
				
				result <= temp(NUMBITS-1 downto 0);

			when "011" => 
-- signed sub
				temp := std_logic_vector(signed('0'&A)-signed('0'&B));
				if(temp(NUMBITS) = '1') then
					carry_out<= '1';
				end if;
				if (temp(NUMBITS-1 downto 0) = zero1) then
					zero <= '1';
				end if;
				if( ((A>=0) and (B < 0) and (temp(NUMBITS-1 downto 0) <0)) or
				((A<0) and (B>=0) and (temp(NUMBITS-1 downto 0) >=0))) then
				overflow <= '1';
				end if;
				result <= temp(NUMBITS-1 downto 0);
				
			when "100" => 
--and
				temp := '0'&(A and B);
				if (temp(NUMBITS-1 downto 0) = zero1) then
				zero <= '1';
				end if;
				result <= temp(NUMBITS-1 downto 0);
			when "101" => 
--or
				temp :=  '0'&(A or B);
				if (temp(NUMBITS-1 downto 0) = zero1) then
				zero <= '1';
				end if;
				result <= temp(NUMBITS-1 downto 0);
			when "110" =>
--xor
				temp :=  '0'&(A xor B);
				if (temp(NUMBITS-1 downto 0) = zero1) then
				zero <= '1';
				end if;
				result <= temp(NUMBITS-1 downto 0);
				
			when"111" =>
--Divide A by 2
				temp := ('0'&A);
				if(temp = 0)	then
					zero <= '1';
				end if;
				result <= temp(NUMBITS downto 1);
				
			when others =>			
				result <= "11111111";
			end case;
	end process;

end Behavioral;

