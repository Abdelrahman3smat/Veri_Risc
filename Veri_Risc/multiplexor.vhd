----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:46:28 07/14/2024 
-- Design Name: 
-- Module Name:    multiplexor - Behavioral 
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

