LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY ascii_to_integer IS
	PORT		( ascii					:	IN		STD_ULOGIC_VECTOR(15 DOWNTO 0);
				  ceros_integer		:	OUT 	INTEGER);
END ENTITY ascii_to_integer;
---------------------------------- 

----------------------------------
ARCHITECTURE behaviour OF ascii_to_integer IS
BEGIN
	
		WITH ascii SELECT
		ceros_integer		<=				
									0 	WHEN "0011000000110000",
									1 	WHEN "0011000000110001",
									2 	WHEN "0011000000110010",
									3 	WHEN "0011000000110011",
									4 	WHEN "0011000000110100",
									5 	WHEN "0011000000110101",
									6 	WHEN "0011000000110110",
									7 	WHEN "0011000000110111",
									8 	WHEN "0011000000111000",
									9 	WHEN "0011000000111001",
									10 WHEN "0011000100110000",
									11 WHEN "0011000100110001",
									12 WHEN "0011000100110010",
									13 WHEN "0011000100110011",
									14 WHEN "0011000100110100",
									15 WHEN "0011000100110101",
									16 WHEN "0011000100110110",
									17 WHEN "0011000100110111",
									18 WHEN "0011000100111000",
									19 WHEN "0011000100111001",
									20 WHEN "0011001000110000",
									21 WHEN "0011001000110001",
									22 WHEN "0011001000110010",
									23 WHEN "0011001000110011",
									24 WHEN "0011001000110100",
									25 WHEN "0011001000110101",
									26 WHEN "0011001000110110",
									27 WHEN "0011001000110111",
									28 WHEN "0011001000111000",
									29 WHEN "0011001000111001",
									30 WHEN "0011001100110000",
									31 WHEN "0011001100110001",
									32 WHEN "0011001100110010",
									0 WHEN OTHERS;
									
END behaviour;