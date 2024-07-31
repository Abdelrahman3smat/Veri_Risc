library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity accumulator is
    Port ( alu_out : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ld_ac : in  STD_LOGIC;
           ac_out : out  STD_LOGIC_VECTOR (7 downto 0));
end accumulator;

architecture accumulator_flow of accumulator is

begin
process(clk)
begin
if(rst = '1') then
	ac_out <= "00000000";
	elsif(rising_edge(clk)) then
		if(ld_ac = '1') then
			ac_out <= alu_out ;
      end if;
end if;
end process;		


end accumulator_flow;

