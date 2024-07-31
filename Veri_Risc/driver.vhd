library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity driver is
    Port ( ld_ir : in  STD_LOGIC;
		   alu_out : in  STD_LOGIC_VECTOR (7 downto 0);
           data : out  STD_LOGIC_VECTOR (7 downto 0)
		   );
end driver;

architecture driver_flow of driver is
begin
	process (ld_ir)
	begin
		if (ld_ir = '1') then 
			data <= alu_out;
		else 
			data <= (others => 'Z' );
		end if;
	end process;

end driver_flow;


