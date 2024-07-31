----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:14:22 07/14/2024 
-- Design Name: 
-- Module Name:    instruction_register - Behavioral 
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
use IEEE.std_logic_unsigned.all; 
use IEEE.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruction_register is
    Port ( data : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ld_ir : in  STD_LOGIC;
           ir_addr : out  STD_LOGIC_VECTOR (4 downto 0);
           opcode : out  STD_LOGIC_VECTOR (2 downto 0));
end instruction_register;

architecture instruction_register_flow of instruction_register is

begin
process(clk)
begin
if(rst = '1') then
	ir_addr <= "00000";
	opcode <= "000";
	elsif(rising_edge(clk)) then
		if(ld_ir = '1') then
			ir_addr <= data(4 downto 0);
			opcode <= data(7 downto 5);
      end if;
end if;
end process;


end instruction_register_flow;

