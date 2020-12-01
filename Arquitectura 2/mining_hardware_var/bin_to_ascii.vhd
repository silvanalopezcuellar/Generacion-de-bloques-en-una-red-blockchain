LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY bin_to_ascii IS
	PORT		( bin			:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
				  ascii		:	OUT 	STD_LOGIC_VECTOR(7 DOWNTO 0));
END ENTITY bin_to_ascii;
---------------------------------- 

----------------------------------
ARCHITECTURE behaviour2 OF bin_to_ascii IS
BEGIN
	
		WITH bin SELECT
		ascii		<=				
									"00110000" WHEN "0000",
									"00110001" WHEN "0001",
									"00110010" WHEN "0010",
									"00110011" WHEN "0011",
									"00110100" WHEN "0100",
									"00110101" WHEN "0101",
									"00110110" WHEN "0110",
									"00110111" WHEN "0111",
									"00111000" WHEN "1000",
									"00111001" WHEN "1001",
									"00111111" WHEN OTHERS;
									
END behaviour2;