LIBRARY IEEE;
USE ieee.STD_LOGIC_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY Reg_Num_Ceros IS
	PORT		( clk						:	IN		STD_ULOGIC;
				  rst						:	IN 	STD_ULOGIC;
				  countnumceros		:	IN		INTEGER := 0;
				  ena_num_ceros		:	IN 	STD_ULOGIC;
				  num_ceros				:	IN 	STD_ULOGIC;
				  salida_num_ceros	:	OUT	STD_ULOGIC_VECTOR(15 DOWNTO 0));
END ENTITY;
---------------------------------- 

----------------------------------
ARCHITECTURE Reg_Num_CerosArchh OF Reg_Num_Ceros IS
	SIGNAL	registro_ceros		:	STD_ULOGIC_VECTOR(15 DOWNTO 0); 
BEGIN
	salida_num_ceros  <= registro_ceros;
	PROCESS(clk,rst)
	BEGIN
		IF(rst = '0') THEN
			registro_ceros <= (OTHERS => '0');
		ELSIF(RISING_EDGE(clk)) THEN
			IF (ena_num_ceros = '1') THEN
				registro_ceros (countnumceros) <= num_ceros;

			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE Reg_Num_CerosArchh;