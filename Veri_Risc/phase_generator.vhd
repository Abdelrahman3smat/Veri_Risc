----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:00:01 07/13/2024 
-- Design Name: 
-- Module Name:    phase_generator - Behavioral 
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

entity phase_generator is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           phase : out  STD_LOGIC_VECTOR (2 downto 0));
end phase_generator;

architecture phase_generator_flow of phase_generator is
signal count:STD_LOGIC_VECTOR(2 DOWNTO 0);
begin
process(clk,rst)
begin
 if(rst='1') then
   count<="000";
	elsif(rising_edge(clk)) then
	 count<=count+"001";
	 end if;
end process;
  phase<=count;
  
end phase_generator_flow;

