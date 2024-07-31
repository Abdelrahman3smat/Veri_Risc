library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity controller is
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
end controller;

architecture controller_flow of controller is
    
constant INST_ADDR  : std_logic_vector (2 downto 0) := "000";
constant INST_FETCH : std_logic_vector (2 downto 0) := "001";
constant INST_LOAD  : std_logic_vector (2 downto 0) := "010";
constant IDLE       : std_logic_vector (2 downto 0) := "011";
constant OP_ADDR    : std_logic_vector (2 downto 0) := "100";
constant OP_FETCH   : std_logic_vector (2 downto 0) := "101";
constant ALU_OP     : std_logic_vector (2 downto 0) := "110";
constant STORE      : std_logic_vector (2 downto 0) := "111";

signal aluop        : std_logic;
signal skz_and_zero : std_logic;
signal jmp          : std_logic;
signal sto          : std_logic;
signal hlt          : std_logic;

constant opcode_hlt : std_logic_vector (2 downto 0) := "000";
constant opcode_skz : std_logic_vector (2 downto 0) := "001";
constant opcode_add : std_logic_vector (2 downto 0) := "010";
constant opcode_and : std_logic_vector (2 downto 0) := "011";
constant opcode_xor : std_logic_vector (2 downto 0) := "100";
constant opcode_lda : std_logic_vector (2 downto 0) := "101";
constant opcode_sto : std_logic_vector (2 downto 0) := "110";
constant opcode_jmp : std_logic_vector (2 downto 0) := "111";
begin

    hlt <= '1' when (opcode = opcode_hlt) else '0';
    aluop <= '1' when (opcode = opcode_add 
                        or opcode = opcode_and 
                        or opcode = opcode_xor 
                        or opcode = opcode_lda
                        ) else '0';
    skz_and_zero <= '1' when (opcode = opcode_skz and zero = '1') else '0';
    jmp <= '1' when (opcode = opcode_jmp) else '0';
    sto <= '1' when (opcode = opcode_sto) else '0';

    process(clk, rst)
    begin
        if (rst = '1') then
            sel    <= '0';
            rd     <= '0';
            ld_ir  <= '0';
            halt   <= '0';
            inc_pc <= '0';
            ld_ac  <= '0';
            ld_pc  <= '0';
            wr     <= '0';
            data_e <= '0';
        elsif (rising_edge(clk)) then
            case phase is
                when INST_ADDR => 
                    sel    <= '1';
                    rd     <= '0';
                    ld_ir  <= '0';
                    halt   <= '0';
                    inc_pc <= '0';
                    ld_ac  <= '0';
                    ld_pc  <= '0';
                    wr     <= '0';
                    data_e <= '0';
                when INST_FETCH => 
                    sel    <= '1';
                    rd     <= '1';
                    ld_ir  <= '0';
                    halt   <= '0';
                    inc_pc <= '0';
                    ld_ac  <= '0';
                    ld_pc  <= '0';
                    wr     <= '0';
                    data_e <= '0';
                when INST_LOAD => 
                    sel    <= '1';
                    rd     <= '1';
                    ld_ir  <= '1';
                    halt   <= '0';
                    inc_pc <= '0';
                    ld_ac  <= '0';
                    ld_pc  <= '0';
                    wr     <= '0';
                    data_e <= '0';
                when IDLE => 
                    sel    <= '1';
                    rd     <= '1';
                    ld_ir  <= '1';
                    halt   <= '0';
                    inc_pc <= '0';
                    ld_ac  <= '0';
                    ld_pc  <= '0';
                    wr     <= '0';
                    data_e <= '0';
                when OP_ADDR => 
                    sel    <= '0';
                    rd     <= '0';
                    ld_ir  <= '0';
                    halt   <= hlt;
                    inc_pc <= '1';
                    ld_ac  <= '0';
                    ld_pc  <= '0';
                    wr     <= '0';
                    data_e <= '0';
                when OP_FETCH => 
                    sel    <= '0';
                    rd     <= aluop;
                    ld_ir  <= '0';
                    halt   <= '0';
                    inc_pc <= '0';
                    ld_ac  <= '0';
                    ld_pc  <= '0';
                    wr     <= '0';
                    data_e <= '0';
                when ALU_OP => 
                    sel    <= '0';
                    rd     <= aluop;
                    ld_ir  <= '0';
                    halt   <= '0';
                    inc_pc <= skz_and_zero;
                    ld_ac  <= '0';
                    ld_pc  <= jmp;
                    wr     <= '0';
                    data_e <= sto;
                when STORE =>
                    sel    <= '0';
                    rd     <= aluop;
                    ld_ir  <= '0';
                    halt   <= '0';
                    inc_pc <= sto;
                    ld_ac  <= aluop;
                    ld_pc  <= jmp;
                    wr     <= sto;
                    data_e <= sto;
                    -- error state
                    when others =>
                        sel    <= '0';
                        rd     <= '0';
                        ld_ir  <= '0';
                        halt   <= '0';
                        inc_pc <= '0';
                        ld_ac  <= '0';
                        ld_pc  <= '0';
                        wr     <= '0';
                        data_e <= '0';
                end case; 
        end if;
            
    end process;
    
end architecture controller_flow;