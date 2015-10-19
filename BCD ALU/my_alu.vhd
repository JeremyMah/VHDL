----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:08:35 02/10/2014 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity my_alu is
    Port ( A : in  STD_LOGIC_VECTOR(31 downto 0);
           B : in  STD_LOGIC_VECTOR(31 downto 0);
           Opcode : in  STD_LOGIC_VECTOR(3 downto 0);
           Result : out  STD_LOGIC_VECTOR(35 downto 0);
           Carry_out : out  STD_LOGIC;
           Overflow : out  STD_LOGIC;
           Zero : out  STD_LOGIC);
end my_alu;

architecture Behavioral of my_alu is

begin

	process(opcode, A, B)
	
	variable temp1, temp2: STD_LOGIC_VECTOR(31 downto 0);
	variable temp : STD_LOGIC_VECTOR(35 downto 0);
	variable sign1, sign2: STD_LOGIC;
	
	begin
	
	
	Result <= "000000000000000000000000000000000000";
	Overflow <= '0';
	Carry_out <= '0'; 
	Zero <= '0';
	temp1(31 downto 0) := (A);
	temp2(31 downto 0) := (B);
	temp := "000000000000000000000000000000000000";
	
	
	case opcode is

		when "1000" => --  BCD unsigned add
		
			temp(31 downto 28) := temp1(31 downto 28) + temp2(31 downto 28);
			if((temp1(31) = '1') AND (temp2(31) = '1')) then
				temp(31 downto 28) := temp(31 downto 28) + "0110";
				temp(35 downto 32) := temp(35 downto 32) + "1";
			end if;
				
		   temp(27 downto 24) := temp1(27 downto 24) + temp2(27 downto 24);
			if((temp1(27) = '1') AND (temp2(27) = '1')) then
				temp(27 downto 24) := temp(27 downto 24) + "0110";
				temp(31 downto 28) := temp(31 downto 28) + "1";
			end if; 
				
			temp(23 downto 20) := temp1(23 downto 20) + temp2(23 downto 20);
			if((temp1(23) = '1') AND (temp2(23) = '1')) then 
				temp(23 downto 20) := temp(23 downto 20) + "0110";
				temp(27 downto 24) := temp(27 downto 24) + "1";
			end if;
	
			temp(19 downto 16) := temp1(19 downto 16) + temp2(19 downto 16);
			if((temp1(19) = '1') AND (temp2(19) = '1')) then
				temp(19 downto 16) := temp(19 downto 16) + "0110";
				temp(23 downto 20) := temp(23 downto 20) + "1";
			end if;
				
			temp(15 downto 12) := temp1(15 downto 12) + temp2(15 downto 12);
			if((temp1(15) = '1') AND (temp2(15) = '1')) then
				temp(15 downto 12) := temp(15 downto 12) + "0110";
				temp(19 downto 16) := temp(19 downto 16) + "1";
			end if;
		
			temp(11 downto 8)  := temp1(11 downto 8)  + temp2(11 downto 8);
			if((temp1(11) = '1') AND (temp2(11) = '1')) then
				temp(11 downto 8) := temp(11 downto 8) + "0110";
				temp(15 downto 12) := temp(15 downto 12) + "1";
			end if;
				
			temp(7  downto 4)  := temp1(7  downto 4)  + temp2(7  downto 4);
			if((temp1(7) = '1') AND (temp2(7) = '1')) then
				temp(7 downto 4) := temp(7 downto 4) + "0110";
				temp(11 downto 8) := temp(11 downto 8) + "1";
			end if;

			temp(3  downto 0)  := temp1(3  downto 0)  + temp2(3  downto 0);
			if((temp1(3) = '1') AND (temp2(3) = '1')) then
				temp(3 downto 0) := temp(3 downto 0) + "0110";
				temp(7 downto 4) := temp(7 downto 4) + "1";
			end if;
				
			if(temp(35 downto 32) > 0)then
				Carry_out <= '1';
				Overflow <= '1';
			end if;
				
			if(temp = "000000000000000000000000000000000000") then
					Zero <= '1';
			end if;
					
			Result <= temp; 
				
			when "1001" => -- BCD unsigned sub 
			
			if( temp1 < temp2 ) then
				Carry_out <= '1';
				Overflow <= '1';
			end if;

			if(temp1(3 downto 0) < temp2(3 downto 0)) then
				temp1(7 downto 4) := temp1(7 downto 4) - 1;
				temp2(3 downto 0) := temp2(3 downto 0) + "0110";
			end if;
			
			temp(3  downto 0)  := temp1(3  downto 0)  + not(temp2(3  downto 0))+1;
			if(temp(3 downto 0) > 9) then
				temp(3 downto 0) := temp(3 downto 0) - "0110";
			end if;
			
			if(temp1(7 downto 4) < temp2(7 downto 4)) then
				temp1(11 downto 8) := temp1(11 downto 8) - 1;
				temp2(7 downto 4) := temp2(7 downto 4) + "0110";
			end if; 	
			
			temp(7  downto 4)  := temp1(7  downto 4)  + not(temp2(7  downto 4))+1;
			if(temp(7 downto 4) > 9) then
				temp(7 downto 4) := temp(7 downto 4) - "0110";
			end if;
				
			if(temp1(11 downto 8) < temp2(11 downto 8)) then
				temp1(15 downto 12) := temp1(15 downto 12) - 1;
				temp2(11 downto 8) := temp2(11 downto 8) + "0110";
			end if;  
				
			temp(11 downto 8)  := temp1(11 downto 8)  + not(temp2(11 downto 8))+1;
			if(temp(11 downto 8) > 9) then
				temp(11 downto 8) := temp(11 downto 8) - "0110";
			end if;
				
			if(temp1(15 downto 12) < temp2(15 downto 12)) then
				temp1(19 downto 16) := temp1(19 downto 16) - 1;
				temp2(15 downto 12) := temp2(15 downto 12) + "0110";
			end if;  
		
			temp(15 downto 12) := temp1(15 downto 12) + not(temp2(15 downto 12))+1;
			if(temp(15 downto 12) > 9) then
				temp(15 downto 12) := temp(15 downto 12) - "0110";
			end if;
				
			if(temp1(19 downto 16) < temp2(19 downto 16)) then
				temp1(23 downto 20) := temp1(23 downto 20) - 1;
				temp2(19 downto 16) := temp2(19 downto 16) + "0110";
			end if; 
			
			temp(19 downto 16) := temp1(19 downto 16) + not(temp2(19 downto 16))+1;
			if(temp(19 downto 16) > 9) then
				temp(19 downto 16) := temp(19 downto 16) - "0110";
			end if;
				
			if(temp1(23 downto 20) < temp2(23 downto 20)) then
				temp1(27 downto 24) := temp1(27 downto 24) - 1;
				temp2(23 downto 20) := temp2(23 downto 20) + "0110";
			end if; 
				
			temp(23 downto 20) := temp1(23 downto 20) + not(temp2(23 downto 20))+1;
			if(temp(23 downto 20) > 9) then
				temp(23 downto 20) := temp(23 downto 20) - "0110";
			end if;
				
			if(temp1(27 downto 24) < temp2(27 downto 24)) then
				temp1(31 downto 28) := temp1(31 downto 28) - 1;
				temp2(27 downto 24) := temp2(27 downto 24) + "0110";
			end if; 
			   
			temp(27 downto 24) := temp1(27 downto 24) + not(temp2(27 downto 24))+1;
			if(temp(27 downto 24) > 9) then
				temp(27 downto 24) := temp(27 downto 24) - "0110";
			end if;
				
			temp(31 downto 28) := temp1(31 downto 28) + not(temp2(31 downto 28))+1;
			if(temp(31 downto 28) > 9) then
				temp(31 downto 28) := temp(31 downto 28) - "0110";
			end if;
			
			if(temp = "000000000000000000000000000000000000") then
				Zero <= '1';
			end if;
					
				
				
			Result <= temp;
				
		when "1100" => -- BCD signed add
			if( temp2 < temp1 ) then
				sign1 := A(28);
				temp1(27 downto 0) := A(27 downto 0);
				sign2 := B(28);
				temp2(27 downto 0) := B(27 downto 0);
			else
				sign1 := B(28);
				temp1(27 downto 0) := B(27 downto 0);
				sign2 := A(28);
				temp2(27 downto 0):= A(27 downto 0);
			end if;
				
				
			if(sign1 = sign2) then
					
				temp(27 downto 24) := temp1(27 downto 24) + temp2(27 downto 24);
				if((temp1(27) = '1') AND (temp2(27) = '1')) then
					temp(27 downto 24) := temp(27 downto 24) + "0110";
					temp(31 downto 28) := temp(31 downto 28) + "1";
				end if; 
				
				temp(23 downto 20) := temp1(23 downto 20) + temp2(23 downto 20);
				if((temp1(23) = '1') AND (temp2(23) = '1')) then 
					temp(23 downto 20) := temp(23 downto 20) + "0110";
					temp(27 downto 24) := temp(27 downto 24) + "1";
				end if;
		
				temp(19 downto 16) := temp1(19 downto 16) + temp2(19 downto 16);
				if((temp1(19) = '1') AND (temp2(19) = '1')) then
					temp(19 downto 16) := temp(19 downto 16) + "0110";
					temp(23 downto 20) := temp(23 downto 20) + "1";
				end if;
				
				temp(15 downto 12) := temp1(15 downto 12) + temp2(15 downto 12);
				if((temp1(15) = '1') AND (temp2(15) = '1')) then
					temp(15 downto 12) := temp(15 downto 12) + "0110";
					temp(19 downto 16) := temp(19 downto 16) + "1";
				end if;
			
				temp(11 downto 8)  := temp1(11 downto 8)  + temp2(11 downto 8);
				if((temp1(11) = '1') AND (temp2(11) = '1')) then
					temp(11 downto 8) := temp(11 downto 8) + "0110";
					temp(15 downto 12) := temp(15 downto 12) + "1";
				end if;
				
				temp(7  downto 4)  := temp1(7  downto 4)  + temp2(7  downto 4);
				if((temp1(7) = '1') AND (temp2(7) = '1')) then
					temp(7 downto 4) := temp(7 downto 4) + "0110";
					temp(11 downto 8) := temp(11 downto 8) + "1";
				end if;

				temp(3  downto 0)  := temp1(3  downto 0)  + temp2(3  downto 0);
				if((temp1(3) = '1') AND (temp2(3) = '1')) then
					temp(3 downto 0) := temp(3 downto 0) + "0110";
					temp(7 downto 4) := temp(7 downto 4) + "1";
				end if;
				
				if(sign1 = '1') then
					temp(32) := '1';
				else
					temp(32) := '0';
				end if;
					
		else
				if(temp1(3 downto 0) < temp2(3 downto 0)) then
					temp1(7 downto 4) := temp1(7 downto 4) - 1;
					temp2(3 downto 0) := temp2(3 downto 0) + "0110";
				end if;
				temp(3  downto 0)  := temp1(3  downto 0)  + not(temp2(3  downto 0))+1;
				if(temp(3 downto 0) > 9) then
					temp(3 downto 0) := temp(3 downto 0) - "0110";
				end if;
			
				if(temp1(7 downto 4) < temp2(7 downto 4)) then
					temp1(11 downto 8) := temp1(11 downto 8) - 1;
					temp2(7 downto 4) := temp2(7 downto 4) + "0110";
				end if; 
				
				temp(7  downto 4)  := temp1(7  downto 4)  + not(temp2(7  downto 4))+1;
				if(temp(7 downto 4) > 9) then
					temp(7 downto 4) := temp(7 downto 4) - "0110";
				end if;
				
				if(temp1(11 downto 8) < temp2(11 downto 8)) then
					temp1(15 downto 12) := temp1(15 downto 12) - 1;
					temp2(11 downto 8) := temp2(11 downto 8) + "0110";
				end if;  
				
				temp(11 downto 8)  := temp1(11 downto 8)  + not(temp2(11 downto 8))+1;
				if(temp(11 downto 8) > 9) then
					temp(11 downto 8) := temp(11 downto 8) - "0110";
				end if;
				
				if(temp1(15 downto 12) < temp2(15 downto 12)) then
					temp1(19 downto 16) := temp1(19 downto 16) - 1;
					temp2(15 downto 12) := temp2(15 downto 12) + "0110";
				end if;
				
				temp(15 downto 12) := temp1(15 downto 12) + not(temp2(15 downto 12))+1;
				if(temp(15 downto 12) > 9) then
					temp(15 downto 12) := temp(15 downto 12) - "0110";
				end if;
				
				if(temp1(19 downto 16) < temp2(19 downto 16)) then
					temp1(23 downto 20) := temp1(23 downto 20) - 1;
					temp2(19 downto 16) := temp2(19 downto 16) + "0110";
				end if; 
				temp(19 downto 16) := temp1(19 downto 16) + not(temp2(19 downto 16))+1;
				if(temp(19 downto 16) > 9) then
					temp(19 downto 16) := temp(19 downto 16) - "0110";
				end if;
				
				if(temp1(23 downto 20) < temp2(23 downto 20)) then
					temp1(27 downto 24) := temp1(27 downto 24) - 1;
					temp2(23 downto 20) := temp2(23 downto 20) + "0110";
				end if; 
				
				temp(23 downto 20) := temp1(23 downto 20) + not(temp2(23 downto 20))+1;
				if(temp(23 downto 20) > 9) then
					temp(23 downto 20) := temp(23 downto 20) - "0110";
				end if;
				
				if(temp1(27 downto 24) < temp2(27 downto 24)) then
					temp1(31 downto 28) := temp1(31 downto 28) - 1;
					temp2(27 downto 24) := temp2(27 downto 24) + "0110";
				end if; 
				temp(27 downto 24) := temp1(27 downto 24) + not(temp2(27 downto 24))+1;
				if(temp(27 downto 24) > 9) then
					temp(27 downto 24) := temp(27 downto 24) - "0110";
				end if;
				
						
			temp(32) := sign1;
			end if;
				if(temp = "000100000000000000000000000000000000") then
					temp:="000000000000000000000000000000000000";
				end if;
				if(temp = "000000000000000000000000000000000000") then
					Zero <= '1';
				end if;
								
				if(temp(31 downto 28) > 0)then
					Carry_out <= '1';
					Overflow <= '1';
				end if;
				Result <= temp;
				
		
			
			when "1101" => -- BCD signed sub
		
			if( temp2 < temp1 ) then
					sign1 := A(28);
					temp1(27 downto 0) := A(27 downto 0);
					sign2 := B(28);
					temp2(27 downto 0) := B(27 downto 0);
					sign2 := not(sign2);
				else
					sign1 := B(28);
					temp1(27 downto 0) := B(27 downto 0);
					sign2 := A(28);
					temp2(27 downto 0):= A(27 downto 0);
					sign1 := not(sign1);
				end if;
				
				
				if(sign1 = sign2) then
					
					temp(27 downto 24) := temp1(27 downto 24) + temp2(27 downto 24);
					if(temp(27 downto 24) > 9) then
						temp(27 downto 24) := temp(27 downto 24) + "0110";
						temp(31 downto 28) := temp(31 downto 28) + "1";
					end if; 
				
					temp(23 downto 20) := temp1(23 downto 20) + temp2(23 downto 20);
					if(temp(23 downto 20) > 9) then 
						temp(23 downto 20) := temp(23 downto 20) + "0110";
						temp(27 downto 24) := temp(27 downto 24) + "1";
					end if;
		
					temp(19 downto 16) := temp1(19 downto 16) + temp2(19 downto 16);
					if(temp(19 downto 16) > 9) then
						temp(19 downto 16) := temp(19 downto 16) + "0110";
						temp(23 downto 20) := temp(23 downto 20) + "1";
					end if;
				
					temp(15 downto 12) := temp1(15 downto 12) + temp2(15 downto 12);
					if(temp(15 downto 12) > 9) then
						temp(15 downto 12) := temp(15 downto 12) + "0110";
						temp(19 downto 16) := temp(19 downto 16) + "1";
					end if;
			
					temp(11 downto 8)  := temp1(11 downto 8)  + temp2(11 downto 8);
					if(temp(11 downto 8) > 9) then
						temp(11 downto 8) := temp(11 downto 8) + "0110";
						temp(15 downto 12) := temp(15 downto 12) + "1";
					end if;
				
					temp(7  downto 4)  := temp1(7  downto 4)  + temp2(7  downto 4);
					if(temp(7 downto 4) > 9) then
						temp(7 downto 4) := temp(7 downto 4) + "0110";
						temp(11 downto 8) := temp(11 downto 8) + "1";
					end if;

					temp(3  downto 0)  := temp1(3  downto 0)  + temp2(3  downto 0);
					if(temp(3 downto 0) > 9) then
						temp(3 downto 0) := temp(3 downto 0) + "0110";
						temp(7 downto 4) := temp(7 downto 4) + "1";
					end if;
				
						if(sign1 = '1') then
							temp(32) := '1';
						else
							temp(32) := '0';
						end if;
					
		else
						
						if(temp1(3 downto 0) < temp2(3 downto 0)) then
							temp1(7 downto 4) := temp1(7 downto 4) - 1;
							temp2(3 downto 0) := temp2(3 downto 0) + "0110";
						end if;
						temp(3  downto 0)  := temp1(3  downto 0)  + not(temp2(3  downto 0))+1;
						if(temp(3 downto 0) > 9) then
							temp(3 downto 0) := temp(3 downto 0) - "0110";
						end if;
			
						if(temp1(7 downto 4) < temp2(7 downto 4)) then
							temp1(11 downto 8) := temp1(11 downto 8) - 1;
							temp2(7 downto 4) := temp2(7 downto 4) + "0110";
						end if; 
						temp(7  downto 4)  := temp1(7  downto 4)  + not(temp2(7  downto 4))+1;
						if(temp(7 downto 4) > 9) then
							temp(7 downto 4) := temp(7 downto 4) - "0110";
						end if;
				
						if(temp1(11 downto 8) < temp2(11 downto 8)) then
							temp1(15 downto 12) := temp1(15 downto 12) - 1;
							temp2(11 downto 8) := temp2(11 downto 8) + "0110";
						end if;  
						temp(11 downto 8)  := temp1(11 downto 8)  + not(temp2(11 downto 8))+1;
						if(temp(11 downto 8) > 9) then
							temp(11 downto 8) := temp(11 downto 8) - "0110";
						end if;
				
						if(temp1(15 downto 12) < temp2(15 downto 12)) then
							temp1(19 downto 16) := temp1(19 downto 16) - 1;
							temp2(15 downto 12) := temp2(15 downto 12) + "0110";
						end if;  
						temp(15 downto 12) := temp1(15 downto 12) + not(temp2(15 downto 12))+1;
						if(temp(15 downto 12) > 9) then
							temp(15 downto 12) := temp(15 downto 12) - "0110";
						end if;
				
						if(temp1(19 downto 16) < temp2(19 downto 16)) then
							temp1(23 downto 20) := temp1(23 downto 20) - 1;
							temp2(19 downto 16) := temp2(19 downto 16) + "0110";
						end if; 
						temp(19 downto 16) := temp1(19 downto 16) + not(temp2(19 downto 16))+1;
						if(temp(19 downto 16) > 9) then
							temp(19 downto 16) := temp(19 downto 16) - "0110";
						end if;
				
						if(temp1(23 downto 20) < temp2(23 downto 20)) then
							temp1(27 downto 24) := temp1(27 downto 24) - 1;
							temp2(23 downto 20) := temp2(23 downto 20) + "0110";
						end if; 
						temp(23 downto 20) := temp1(23 downto 20) + not(temp2(23 downto 20))+1;
						if(temp(23 downto 20) > 9) then
							temp(23 downto 20) := temp(23 downto 20) - "0110";
						end if;
				
						if(temp1(27 downto 24) < temp2(27 downto 24)) then
							temp1(31 downto 28) := temp1(31 downto 28) - 1;
							temp2(27 downto 24) := temp2(27 downto 24) + "0110";
						end if; 
						temp(27 downto 24) := temp1(27 downto 24) + not(temp2(27 downto 24))+1;
						if(temp(27 downto 24) > 9) then
							temp(27 downto 24) := temp(27 downto 24) - "0110";
						end if;
				
						
				temp(32) := sign1;
			end if;
				if(temp = "000100000000000000000000000000000000") then
					temp:="000000000000000000000000000000000000";
				end if;
				if(temp = "000000000000000000000000000000000000") then
					Zero <= '1';
				end if;
				Result <= temp;
 
			when others => zero <= '1'; 
	
		end case;
		
	end process; 


end Behavioral; 
