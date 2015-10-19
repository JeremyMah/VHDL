library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity CAM_Row is
		Generic (CAM_WIDTH : integer := 8) ;
		Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           search_word : in  STD_LOGIC_VECTOR (CAM_WIDTH-1 downto 0);
           dont_care_mask : in  STD_LOGIC_VECTOR (CAM_WIDTH-1 downto 0);
           row_match : out  STD_LOGIC);
end CAM_Row;

architecture Behavioral of CAM_Row is


component Stored_Ternary_State_Cell is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           cell_search_bit : in  STD_LOGIC;
           cell_dont_care_bit : in  STD_LOGIC;
			  cell_match_bit_in : in  STD_LOGIC ;
           cell_match_bit_out : out  STD_LOGIC);
end component ;

--for all : CAM_Cell use entity work.CAM_Cell(Binary_Input_Cell) ; 
SIGNAL cell_matches:STD_LOGIC_VECTOR(CAM_WIDTH downto 0);

begin

-- Connect the CAM cells here
cell_matches(0) <= '1';
	gen_loop: for N in 0 to CAM_WIDTH-1 generate 
		Cont: Stored_Ternary_State_Cell
			port map(
				clk => clk,
				rst => rst, 
				we => we,
				cell_search_bit => search_word(N),
				cell_dont_care_bit => dont_care_mask(N),
				cell_match_bit_in => cell_matches(N), 
				cell_match_bit_out => cell_matches(N+1)
				); 
		end generate gen_loop; 
	row_match <= cell_matches(CAM_WIDTH);
end Behavioral;



