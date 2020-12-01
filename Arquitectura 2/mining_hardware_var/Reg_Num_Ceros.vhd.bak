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
	--SIGNAL   cuenta				:	STD_ULOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	--cuenta 					<= STD_ULOGIC_VECTOR(to_unsigned(countnumceros, 4);
	salida_num_ceros(15)  <= registro_ceros(15);
	salida_num_ceros(14)  <= registro_ceros(14);
	salida_num_ceros(13)  <= registro_ceros(13);
	salida_num_ceros(12)  <= registro_ceros(12);
	salida_num_ceros(11)  <= registro_ceros(11);
	salida_num_ceros(10)  <= registro_ceros(10);
	salida_num_ceros(9)  <= registro_ceros(9);
	salida_num_ceros(8)  <= registro_ceros(8);
	salida_num_ceros(7)  <= registro_ceros(7);
	salida_num_ceros(6)  <= registro_ceros(6);
	salida_num_ceros(5)  <= registro_ceros(5);
	salida_num_ceros(4)  <= registro_ceros(4);
	salida_num_ceros(3)  <= registro_ceros(3);
	salida_num_ceros(2)  <= registro_ceros(2);
	salida_num_ceros(1)  <= registro_ceros(1);
	salida_num_ceros(0)  <= registro_ceros(0);
	PROCESS(clk,rst)
	BEGIN
		IF(rst = '0') THEN
			registro_ceros(0) <=	'0';
			registro_ceros(1) <=	'0';
			registro_ceros(2) <=	'0';
			registro_ceros(3) <=	'0';
			registro_ceros(4) <=	'0';
			registro_ceros(5) <=	'0';
			registro_ceros(6) <=	'0';
			registro_ceros(7) <=	'0';
			registro_ceros(8) <=	'0';
			registro_ceros(9) <=	'0';
			registro_ceros(10) <=	'0';
			registro_ceros(11) <=	'0';
			registro_ceros(12) <=	'0';
			registro_ceros(13) <=	'0';
			registro_ceros(14) <=	'0';
			registro_ceros(15) <=	'0';
		ELSIF(RISING_EDGE(clk)) THEN
			IF (ena_num_ceros = '1') THEN
				registro_ceros (countnumceros) <= num_ceros;
--				IF (countnumceros = 0) THEN
--					registro_ceros (0) <= num_ceros;
--				ELSIF (countnumceros = 1) THEN
--					registro_ceros (1) <= num_ceros;
--				ELSIF (countnumceros = 2) THEN
--					registro_ceros (2) <= num_ceros;
--				ELSIF (countnumceros = 3) THEN
--					registro_ceros (3) <= num_ceros;
--				ELSIF (countnumceros = 4) THEN
--					registro_ceros (4) <= num_ceros;
--				ELSIF (countnumceros = 5) THEN
--					registro_ceros (5) <= num_ceros;
--				ELSIF (countnumceros = 6) THEN
--					registro_ceros (6) <= num_ceros;
--				ELSIF (countnumceros = 7) THEN
--					registro_ceros (7) <= num_ceros;
--				ELSIF (countnumceros = 8) THEN
--					registro_ceros (8) <= num_ceros;
--				ELSIF (countnumceros = 9) THEN
--					registro_ceros (9) <= num_ceros;
--				ELSIF (countnumceros = 10) THEN
--					registro_ceros (10) <= num_ceros;
--				ELSIF (countnumceros = 11) THEN
--					registro_ceros (11) <= num_ceros;
--				ELSIF (countnumceros = 12) THEN
--					registro_ceros (12) <= num_ceros;
--				ELSIF (countnumceros = 13) THEN
--					registro_ceros (13) <= num_ceros;
--				ELSIF (countnumceros = 14) THEN
--					registro_ceros (14) <= num_ceros;
--				ELSIF (countnumceros = 15) THEN
--					registro_ceros (15) <= num_ceros;
--				END IF;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE Reg_Num_CerosArchh;