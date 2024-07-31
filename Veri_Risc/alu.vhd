library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
    port(
        -- in_b = data
        data   : in std_logic_vector (7 downto 0);
        -- in_a = ac_out
        ac_out : in std_logic_vector (7 downto 0);
        opcode : in std_logic_vector (2 downto 0);

        zero    : out std_logic;
        alu_out : out std_logic_vector (7 downto 0)
    );
end alu;
    
architecture alu_flow of alu is
    
constant opcode_hlt : std_logic_vector (2 downto 0) := "000";
constant opcode_skz : std_logic_vector (2 downto 0) := "001";
constant opcode_add : std_logic_vector (2 downto 0) := "010";
constant opcode_and : std_logic_vector (2 downto 0) := "011";
constant opcode_xor : std_logic_vector (2 downto 0) := "100";
constant opcode_lda : std_logic_vector (2 downto 0) := "101";
constant opcode_sto : std_logic_vector (2 downto 0) := "110";
constant opcode_jmp : std_logic_vector (2 downto 0) := "111";

begin
    
    process(ac_out)
    begin
        if (ac_out = "00000000") then
            zero <= '1';
        else
            zero <= '0';
        end if;
    end process;

    process(opcode)
    begin
        case opcode is
            when opcode_hlt => alu_out <= ac_out;
            when opcode_skz => alu_out <= ac_out;
            when opcode_add => alu_out <= std_logic_vector(unsigned(ac_out) + unsigned(data));
            when opcode_and => alu_out <= ac_out and data;
            when opcode_xor => alu_out <= ac_out xor data;
            when opcode_lda => alu_out <= data;
            when opcode_sto => alu_out <= ac_out;
            when opcode_jmp => alu_out <= ac_out;
            -- error state
            when others     => alu_out <= ac_out;
        end case;
    end process;
    
end architecture alu_flow;