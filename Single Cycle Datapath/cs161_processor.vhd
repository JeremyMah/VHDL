library ieee;
use ieee.std_logic_1164.all;
use work.cpu_component_library.all;


entity cs161_processor is
  port (
    clk            : in std_logic;
    rst            : in std_logic;
    
    -- Debug Signals
    prog_count     : out std_logic_vector(31 downto 0);
    instr_opcode   : out std_logic_vector(5 downto 0);
    reg1_addr      : out std_logic_vector(4 downto 0);
    reg1_data      : out std_logic_vector(31 downto 0);
    reg2_addr      : out std_logic_vector(4 downto 0);
    reg2_data      : out std_logic_vector(31 downto 0);
    write_reg_addr : out std_logic_vector(4 downto 0);
    write_reg_data : out std_logic_vector(31 downto 0)
    );
end cs161_processor;

architecture Behavioral of cs161_processor is

signal add : std_logic_vector(3 downto 0) := "0010";
signal procountinc : std_logic_vector(31 downto 0);
signal jumpoutput : std_logic_vector(31 downto 0);
signal muxandoutput : std_logic;
signal datareadout : std_logic_vector(31 downto 0);
signal one : std_logic_vector(31 downto 0) := "00000000000000000000000000000001";
signal procountfinal : std_logic_vector(31 downto 0);
signal procount : std_logic_vector(31 downto 0) := "00000000000000000000000000000001";
signal instructions : std_logic_vector(31 downto 0);
signal instraddress : std_logic_vector(7 downto 0);
signal instrinstruction : std_logic_vector(31 downto 0);
signal datamemwrite       : std_logic;
signal dataaddress         : std_logic_vector(7 downto 0);
signal datawrite_data      : std_logic_vector(31 downto 0);
signal dataread_data       : std_logic_vector(31 downto 0);
signal writeoutputmux : std_logic_vector(4 downto 0);
signal write_data : std_logic_vector(31 downto 0);
signal read_data1 : std_logic_vector(31 downto 0);
signal read_data2 : std_logic_vector(31 downto 0);
signal signextend : std_logic_vector(31 downto 0);
signal readoutputmux : std_logic_vector(31 downto 0);
signal alucontrolout : std_logic_vector(3 downto 0);
signal aluoutput : std_logic_vector(31 downto 0);
signal alu_zero : std_logic;
signal zeroflag : std_logic;
signal RegDst : std_logic;
signal branch : std_logic;
signal memread : std_logic;
signal memtoreg : std_logic;
signal ALUOp : std_logic_vector(1 downto 0);
signal memwrite : std_logic;
signal alusrc : std_logic;
signal regwrite : std_logic;

begin

		Progcount: generic_register
		generic map(SIZE => 32)
				PORT MAP(clk, rst, '1', procountfinal, procount);

		InstructionMemory: memory
				PORT MAP(rst, procount(7 downto 0), instructions, datamemwrite, dataaddress, datawrite_data, dataread_data);
				 
		Control: control_unit
				PORT MAP(instructions(31 downto 26), RegDst, branch, memtoreg, memread, ALUOp(1 downto 0), memwrite, alusrc, regwrite);
				 
		WMux: mux_2_1
		generic map(SIZE => 5)
				PORT MAP(RegDst, instructions(20 downto 16), instructions(15 downto 11), writeoutputmux);
				 
		Registers: cpu_registers
				PORT MAP(rst, regwrite, instructions(25 downto 21), instructions(20 downto 16), writeoutputmux, write_data, read_data1, read_data2);
				 
		Sext: sign_ext 
				PORT MAP(instructions(15 downto 0), signextend);
				 
		RMux: mux_2_1
		generic map(SIZE => 32)
				PORT MAP(alusrc, read_data2, signextend, readoutputmux);
				 
		ALUControl: alu_control
				PORT MAP(ALUop, instructions(5 downto 0), alucontrolout);
				 
		ALU1: alu
				PORT MAP(alucontrolout, read_data1, readoutputmux, alu_zero, aluoutput);
				 
		PCIncrement: alu
				PORT MAP(add, procount, one, zeroflag, procountinc);
				 
		JALU: alu
				PORT MAP(add, procountinc, signextend, zeroflag, jumpoutput);
		
		MuxAnd: andtomux
				PORT MAP(branch, alu_zero, muxandoutput); 
		
		JMux: mux_2_1
		generic map(SIZE => 32)
				PORT MAP(muxandoutput, procountinc, jumpoutput, procountfinal);
		
		DataMem: memory
				PORT MAP(rst, instraddress, instrinstruction, memwrite, aluoutput(7 downto 0), read_data2, datareadout);
		
		MemMux: mux_2_1
		generic map(SIZE => 32)
				PORT MAP(memtoreg, aluoutput, datareadout, write_data);
		
process(rst, clk)
begin
    prog_count <= procount;
    instr_opcode <= instructions(5 downto 0);
    reg1_addr <= instructions(25 downto 21);
    reg1_data <= read_data1; 
    reg2_addr <= instructions(20 downto 16);  
    reg2_data <= read_data2;
    write_reg_addr <= writeoutputmux;
    write_reg_data <= write_data;
end process;
		

end Behavioral;

