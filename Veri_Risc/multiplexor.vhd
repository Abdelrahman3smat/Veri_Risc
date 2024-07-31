library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity multiplexor is
    Port ( ir_addr : in  STD_LOGIC_VECTOR (4 downto 0);
           pc_addr : in  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC;
           addr : out  STD_LOGIC_VECTOR (4 downto 0));
end multiplexor;

architecture multiplexor_flow of multiplexor is

begin
with sel select
     addr <= ir_addr when '0',
	          pc_addr when others;
end multiplexor_flow;

