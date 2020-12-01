LIBRARY IEEE;
USE ieee.STD_LOGIC_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY salida_tr IS
	PORT		( clk						:	IN		STD_ULOGIC;
				  rst						:	IN 	STD_ULOGIC;
				  failed					:	IN		STD_ULOGIC;
				  fail_s					:	OUT	STD_ULOGIC
				 );
END ENTITY;
---------------------------------- 

----------------------------------
ARCHITECTURE salida_trArchh OF salida_tr IS
SIGNAL Reg_fail : STD_ULOGIC;
BEGIN

	fail_s <= Reg_fail;

	PROCESS(clk, rst, failed)
	BEGIN
			IF (rst = '0') THEN
				Reg_fail <= '0';
			ELSIF(RISING_EDGE(clk) AND failed = '1') THEN
				Reg_fail <= '1';
			END IF;
			
	END PROCESS;
END ARCHITECTURE salida_trArchh;