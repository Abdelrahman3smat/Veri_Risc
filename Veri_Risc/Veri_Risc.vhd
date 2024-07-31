library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity Veri_Risc is
port(clk: in std_logic;
	  rst: in std_logic;
	  halt: out std_logic);
end Veri_Risc;

architecture Veri_Risc_flow of Veri_Risc is
component accumulator 
    Port ( alu_out : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ld_ac : in  STD_LOGIC;
           ac_out : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component alu 
    port(
        -- in_b = data
        data   : in std_logic_vector (7 downto 0);
        -- in_a = ac_out
        ac_out : in std_logic_vector (7 downto 0);
        opcode : in std_logic_vector (2 downto 0);

        zero    : out std_logic;
        alu_out : out std_logic_vector (7 downto 0)
    );
end component;

component controller 
    port(
        zero   : in std_logic;
        phase  : in std_logic_vector (2 downto 0);
        opcode : in std_logic_vector (2 downto 0);
        clk    : in std_logic;
        rst    : in std_logic;

        sel    : out std_logic;
        rd     : out std_logic;
        ld_ir  : out std_logic;
        halt   : out std_logic;
        inc_pc : out std_logic;
        ld_ac  : out std_logic;
        ld_pc  : out std_logic;
        wr     : out std_logic;
        data_e : out std_logic
    );
end component;

component driver 
    Port ( ld_ir : in  STD_LOGIC;
		   alu_out : in  STD_LOGIC_VECTOR (7 downto 0);
           data : out  STD_LOGIC_VECTOR (7 downto 0)
		   );
end component;

component instruction_register 
    Port ( data : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ld_ir : in  STD_LOGIC;
           ir_addr : out  STD_LOGIC_VECTOR (4 downto 0);
           opcode : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component memory 
    Port ( 
		   clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           wr : in  STD_LOGIC;
           rd : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (4 downto 0);
           data : inout  STD_LOGIC_VECTOR (7 downto 0) 
		   );
end component;

component multiplexor 
    Port ( ir_addr : in  STD_LOGIC_VECTOR (4 downto 0);
           pc_addr : in  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC;
           addr : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

component phase_generator 
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           phase : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component program_counter 
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           inc_pc : in  STD_LOGIC;
           ld_pc : in  STD_LOGIC;
           ir_addr : in  STD_LOGIC_VECTOR (4 downto 0);
           pc_addr : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

signal alu_out,ac_out,data :  STD_LOGIC_VECTOR (7 downto 0);
signal ir_addr,pc_addr,addr :  STD_LOGIC_VECTOR (4 downto 0);
signal phase,opcode :  STD_LOGIC_VECTOR (2 downto 0);
signal ld_ac,
		inc_pc,
		zero,
		sel,
		rd,
		ld_ir,
		ld_pc,
		wr,
		data_e : STD_LOGIC;



begin

accumulator_inst: accumulator port map (alu_out, clk, rst, ld_ac, ac_out);

alu_inst: alu port map (data, ac_out, opcode, zero, alu_out);

controller_inst: controller port map (zero, phase, opcode, clk, rst, sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr,data_e);

driver_inst: driver port map (ld_ir, alu_out, data);

instruction_register_inst: instruction_register port map (data, clk, rst, ld_ir, ir_addr, opcode);

memory_inst: memory port map (clk, rst, wr, rd, addr, data);

multiplexor_inst: multiplexor port map (ir_addr, pc_addr, sel, addr);

phase_generator_inst: phase_generator port map (clk, rst, phase);

program_counter_inst: program_counter port map (clk, rst, inc_pc, ld_pc, ir_addr, pc_addr);



end Veri_Risc_flow;

