LIBRARY IEEE;
USE ieee.STD_LOGIC_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY Reg_Go IS
	PORT		( clk						:	IN		STD_ULOGIC;
				  rst						:	IN 	STD_ULOGIC;
				  fin_mensaje			:	IN		STD_ULOGIC;
				  comparar_ceros		:	IN 	STD_ULOGIC;
				  go						:	OUT	STD_ULOGIC);
END ENTITY;
---------------------------------- 

----------------------------------
ARCHITECTURE Reg_GoArchh OF Reg_Go IS
	SIGNAL	go_reg		:	STD_ULOGIC; 
	
BEGIN

	go <= go_reg;
	PROCESS(clk,rst,comparar_ceros,fin_mensaje)
	BEGIN
		IF(rst = '0') THEN
			go_reg <=	'0';
		ELSIF(RISING_EDGE(clk)) THEN
			IF ((fin_mensaje = '1') AND (comparar_ceros = '0')) THEN
				go_reg <= '1';
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE Reg_GoArchh;