LIBRARY IEEE;
USE ieee.STD_LOGIC_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY Reg_Nonce IS
	PORT		( clk						:	IN		STD_ULOGIC;
				  rst						:	IN 	STD_ULOGIC;
				  nonce					:	IN		STD_ULOGIC_VECTOR(31 DOWNTO 0);
				  tiempo_ok				:	IN		STD_ULOGIC_VECTOR(15 DOWNTO 0);
				  cerosOK				:	IN 	STD_ULOGIC;
				  salida_nonce			:	OUT	STD_ULOGIC_VECTOR(31 DOWNTO 0);
				  salida_reg_tiempo	:	OUT 	STD_ULOGIC_VECTOR(15 DOWNTO 0));
END ENTITY;
---------------------------------- 

----------------------------------
ARCHITECTURE Reg_NonceArchh OF Reg_Nonce IS
	SIGNAL	registro_nonce		:	STD_ULOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL	registro_tiempo	:	STD_ULOGIC_VECTOR(15 DOWNTO 0);
BEGIN

	
	salida_nonce 		<= registro_nonce;
	salida_reg_tiempo <= registro_tiempo;
	
	PROCESS(clk,rst,cerosOK)
	BEGIN
		IF(rst = '0') THEN
		
			registro_nonce  <=	(OTHERS => '0');
			registro_tiempo <=	(OTHERS => '0');

		ELSIF(RISING_EDGE(clk)) THEN
			IF (cerosOK = '1') THEN
				registro_nonce  <= nonce;
				registro_tiempo <= tiempo_ok;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE Reg_NonceArchh;