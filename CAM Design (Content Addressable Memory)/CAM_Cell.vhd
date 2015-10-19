library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Binary_Input_Cell is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           cell_search_bit : in  STD_LOGIC;
           cell_dont_care_bit : in  STD_LOGIC;
			  cell_match_bit_in : in  STD_LOGIC ;
           cell_match_bit_out : out  STD_LOGIC);
end Binary_Input_Cell;

architecture Behavioral of Binary_Input_Cell is
SIGNAL temp : std_logic:='0';
begin
	process (clk, rst, we, cell_search_bit)
	begin
		if (we='1' AND clk = '1') then
			temp<=cell_search_bit;
		else 
			if(cell_search_bit = temp AND cell_match_bit_in = '1') then
				cell_match_bit_out <= '1';
			else
				cell_match_bit_out <= '0';
		end if;
end if;

	end process;
	
	
end Behavioral ;



-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Stored_Ternary_State_Cell is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           cell_search_bit : in  STD_LOGIC;
           cell_dont_care_bit : in  STD_LOGIC;
			  cell_match_bit_in : in  STD_LOGIC ;
           cell_match_bit_out : out  STD_LOGIC);
end Stored_Ternary_State_Cell;

architecture Behavioral of Stored_Ternary_State_Cell is
SIGNAL temp : std_logic:='0';
SIGNAL temp1: std_logic:='0'; 
begin
	process (clk, rst, we, cell_search_bit)
	begin
		if clk='1' then
			if rst='1' then			
				temp<='0';
				temp1<='0';
			else
				if we='1' then
					temp <=cell_search_bit;
					temp1 <=cell_search_bit; 					
				end if;
			end if;
		end if;
	end process;
	
	process(cell_search_bit, cell_match_bit_in, temp1, temp1)
	begin 
	cell_match_bit_out <= ((cell_search_bit XNOR temp1 )AND cell_match_bit_in ) OR temp1; 
	end process;
	
end Behavioral ;


-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Ternary_at_Input_Cell is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           cell_search_bit : in  STD_LOGIC;
           cell_dont_care_bit : in  STD_LOGIC;
			  cell_match_bit_in : in  STD_LOGIC ;
           cell_match_bit_out : out  STD_LOGIC);
end Ternary_at_Input_Cell;

architecture Behavioral of Ternary_at_Input_Cell is
SIGNAL temp : std_logic:='0';
begin
	process (clk, rst, we, cell_search_bit)
	begin
		if clk='1' then
			if rst='1' then			
				temp<='0';
			else
				if we='1' then
					temp<=cell_search_bit; 
				end if;
			end if;
		end if;
	end process;

	process( cell_search_bit, cell_match_bit_in, temp, cell_dont_care_bit)
	begin 
		cell_match_bit_out <= ((cell_search_bit XNOR temp) AND cell_match_bit_in ) OR cell_dont_care_bit; 
	end process; 


end Behavioral ;







