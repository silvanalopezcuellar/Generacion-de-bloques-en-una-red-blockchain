LIBRARY IEEE;
USE ieee.STD_LOGIC_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY Reg_Salida IS
	PORT		( clk					:	IN		STD_ULOGIC;
				  rst					:	IN 	STD_ULOGIC;
				  data_out			:	IN 	STD_ULOGIC_VECTOR(511 DOWNTO 0);
				  salida				:	OUT	STD_ULOGIC_VECTOR(511 DOWNTO 0));
END ENTITY;
---------------------------------- 

----------------------------------
ARCHITECTURE Reg_SalidaArchh OF Reg_Salida IS
	SIGNAL	registro_salida		:	STD_ULOGIC_VECTOR(511 DOWNTO 0); 
BEGIN
	salida <= registro_salida;
	PROCESS(clk,rst)
	BEGIN
		IF(rst = '0') THEN
			registro_salida <=	(OTHERS => '0') ;
		ELSIF(RISING_EDGE(clk)) THEN
			registro_salida <= data_out;
		END IF;
	END PROCESS;
END ARCHITECTURE Reg_SalidaArchh;