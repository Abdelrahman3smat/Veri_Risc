----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:02:00 07/13/2024 
-- Design Name: 
-- Module Name:    program_counter - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity program_counter is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           inc_pc : in  STD_LOGIC;
           ld_pc : in  STD_LOGIC;
           ir_addr : in  STD_LOGIC_VECTOR (4 downto 0);
           pc_addr : out  STD_LOGIC_VECTOR (4 downto 0));
end program_counter;

architecture program_counter_flow of program_counter is
signal count:STD_LOGIC_VECTOR(4 DOWNTO 0);
begin
process(clk,rst)
begin
  if(rst='1') then
     count<="00000";
elsif(rising_edge(clk)) then
   if(ld_pc='1') then
     count<=ir_addr;
   elsif(inc_pc='1') then
     count<=count+"00001";
   end if;
end if;
end process;
pc_addr<=count;
end program_counter_flow;

