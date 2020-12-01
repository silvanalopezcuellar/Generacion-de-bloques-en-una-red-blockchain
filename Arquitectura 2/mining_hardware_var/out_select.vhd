LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
-------------------------------
ENTITY out_select IS
		PORT  ( clk				:	IN STD_ULOGIC;
				 rst				:	IN	STD_ULOGIC;
				 comparar_ceros:	IN	STD_ULOGIC_VECTOR (15 DOWNTO 0);
				 enable			:	OUT STD_ULOGIC;
				 ceros_ok		:	OUT STD_ULOGIC_VECTOR (15 DOWNTO 0));
END ENTITY;
--------------------------------
ARCHITECTURE out_select_rtl OF out_select IS
	SIGNAL reg_cerosOK		: STD_ULOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL reg_enable			: STD_ULOGIC;
BEGIN
	
	ceros_ok <= reg_cerosOK;
	enable	<= reg_enable;
	
	PROCESS (clk, rst, comparar_ceros(0), comparar_ceros(1), comparar_ceros(2), comparar_ceros(3),
				comparar_ceros(4), comparar_ceros(5), comparar_ceros(6), comparar_ceros(7), comparar_ceros(8), 
				comparar_ceros(9), comparar_ceros(10), comparar_ceros(11), comparar_ceros(12), comparar_ceros(13), 
				comparar_ceros(14), comparar_ceros(15))
	BEGIN
		IF (rst='0') THEN
			reg_enable 	<= '0';
			reg_cerosOK	<= "0000000000000000";
		ELSIF (rising_edge(clk)) THEN
		
			IF(comparar_ceros(0)='1' OR comparar_ceros(1)='1' OR comparar_ceros(2)='1' 
				OR comparar_ceros(3)='1' OR comparar_ceros(4)='1' OR comparar_ceros(5)='1' 
				OR comparar_ceros(6)='1' OR comparar_ceros(7)='1' OR comparar_ceros(8)='1' 
				OR comparar_ceros(9)='1' OR comparar_ceros(10)='1' OR comparar_ceros(11)='1' 
				OR comparar_ceros(12)='1' OR comparar_ceros(13)='1' OR comparar_ceros(14)='1' 
				OR comparar_ceros(15)='1') THEN
				
				IF (comparar_ceros(0)='1') THEN
					reg_enable 	<= '1';
					reg_cerosOK	<= "1000000000000000";
				ELSIF (comparar_ceros(1)='1') THEN
					reg_enable 	<= '1';
					reg_cerosOK	<= "0100000000000000";
				ELSIF (comparar_ceros(2)='1') THEN
					reg_enable 	<= '1';
					reg_cerosOK	<= "0010000000000000";
				ELSIF (comparar_ceros(3)='1') THEN
					reg_enable 	<= '1';
					reg_cerosOK	<= "0001000000000000";
				ELSIF (comparar_ceros(4)='1') THEN
					reg_enable 	<= '1';
					reg_cerosOK	<= "0000100000000000";
				ELSIF (comparar_ceros(5)='1') THEN
					reg_enable 	<= '1';
					reg_cerosOK	<= "0000010000000000";
				ELSIF (comparar_ceros(6)='1') THEN
					reg_enable 	<= '1';
					reg_cerosOK	<= "0000001000000000";
				ELSIF (comparar_ceros(7)='1') THEN
					reg_enable 	<= '1';
					reg_cerosOK	<= "0000000100000000";
				ELSIF (comparar_ceros(8)='1') THEN
					reg_enable 	<= '1';
					reg_cerosOK	<= "0000000010000000";
				ELSIF (comparar_ceros(9)='1') THEN
					reg_enable 	<= '1';
					reg_cerosOK	<= "0000000001000000";
				ELSIF (comparar_ceros(10)='1') THEN
					reg_enable 	<= '1';
					reg_cerosOK	<= "0000000000100000";
				ELSIF (comparar_ceros(11)='1') THEN
					reg_enable 	<= '1';
					reg_cerosOK	<= "0000000000010000";
				ELSIF (comparar_ceros(12)='1') THEN
					reg_enable 	<= '1';
					reg_cerosOK	<= "0000000000001000";
				ELSIF (comparar_ceros(13)='1') THEN
					reg_enable 	<= '1';
					reg_cerosOK	<= "0000000000000100";
				ELSIF (comparar_ceros(14)='1') THEN
					reg_enable 	<= '1';
					reg_cerosOK	<= "0000000000000010";
				ELSIF (comparar_ceros(15)='1') THEN
					reg_enable 	<= '1';
					reg_cerosOK	<= "0000000000000001";
				ELSE
				reg_enable 	<= '0';
				reg_cerosOK	<= "0000000000000000";
				END IF;
			ELSE
			reg_enable 	<= '0';
			reg_cerosOK	<= "0000000000000000";
			END IF;
		END IF;
		
	END PROCESS;
	
END ARCHITECTURE;