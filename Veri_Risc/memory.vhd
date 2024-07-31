library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memory is
    Port ( 
		   clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           wr : in  STD_LOGIC;
           rd : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (4 downto 0);
           data : inout  STD_LOGIC_VECTOR (7 downto 0) 
		   );
         
		   
end memory;

architecture memory_flow of memory is
	type memory_type is array (31 downto 0) of std_logic_vector(7 downto 0);
	signal memo : memory_type := (others => (others => '0'));
	signal addr_reg : std_logic_vector(4 downto 0);
	signal data_out : std_logic_vector(7 downto 0);
	signal data_way : std_logic;  --to control the direction of the data ( 1 for out, 0 for in )
	
begin
	process(clk,rst)
	begin
		if (rst = '1') then 
				addr_reg <= (others => '0');
                memo <= (others => (others => '0')); 
                data_out <= (others => '0');  
			elsif (rising_edge(clk)) then 
				if (wr= '1') then
					memo (to_integer (unsigned(addr))) <= data ;
					data_way <= '0' ;
				end if;
				if (rd= '1') then 
					addr_reg <= addr;
					data_out <= memo (to_integer (unsigned(addr)));
					data_way <= '1' ;
				end if;
		end if;
	end process;
	
	data <= data_out when data_way = '1' else (others => 'Z') ; --high impedance to separate the line

end memory_flow;

