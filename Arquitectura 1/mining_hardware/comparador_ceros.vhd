LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY comparador_ceros IS
	PORT		(  clk					:	IN		STD_ULOGIC;
					rst					:	IN		STD_ULOGIC;
					ena_num_ceros_comp:	IN		STD_ULOGIC;
					digest_ceros		:	IN		STD_ULOGIC_VECTOR (127 DOWNTO 0);
					ceros_integer		:	IN		INTEGER;
					cerosOK				:	OUT	STD_ULOGIC
				);
END ENTITY comparador_ceros;
---------------------------------- 

----------------------------------
ARCHITECTURE zeros OF comparador_ceros IS
SIGNAL b128 		: STD_ULOGIC_VECTOR(127 DOWNTO 0):=(OTHERS => '0');
SIGNAL b64 			: STD_ULOGIC_VECTOR(63 DOWNTO 0)	:=(OTHERS => '0');
SIGNAL b32 			: STD_ULOGIC_VECTOR(31 DOWNTO 0)	:=(OTHERS => '0');
SIGNAL b28 			: STD_ULOGIC_VECTOR(27 DOWNTO 0)	:=(OTHERS => '0');
SIGNAL b24 			: STD_ULOGIC_VECTOR(23 DOWNTO 0)	:=(OTHERS => '0');
SIGNAL b20 			: STD_ULOGIC_VECTOR(19 DOWNTO 0)	:=(OTHERS => '0');
SIGNAL b16 			: STD_ULOGIC_VECTOR(15 DOWNTO 0)	:=(OTHERS => '0');
SIGNAL b12 			: STD_ULOGIC_VECTOR(11 DOWNTO 0)	:=(OTHERS => '0');
SIGNAL b8  			: STD_ULOGIC_VECTOR(7 DOWNTO 0)	:=(OTHERS => '0');
SIGNAL b4  			: STD_ULOGIC_VECTOR(3 DOWNTO 0)	:=(OTHERS => '0');
SIGNAL CEROS_reg	: STD_ULOGIC;


BEGIN
	
	cerosOK <= CEROS_reg;
	
	PROCESS(clk, rst, ena_num_ceros_comp)
	BEGIN
	
		IF (rst = '0' OR ena_num_ceros_comp='0') THEN
		
			CEROS_reg <= '0';
		
		ELSIF(RISING_EDGE(clk) AND ena_num_ceros_comp = '1') THEN
		
			IF (ena_num_ceros_comp = '1') THEN
			
				IF ((ceros_integer=128) AND (digest_ceros = b128)) THEN
					CEROS_reg <= '1';
				ELSIF ((ceros_integer=64) AND (digest_ceros(127 DOWNTO 64) = b64)) THEN
					CEROS_reg <= '1';
				ELSIF ((ceros_integer=32) AND (digest_ceros(127 DOWNTO 96) = b32)) THEN
					CEROS_reg <= '1';
				ELSIF ((ceros_integer=28) AND (digest_ceros(127 DOWNTO 100) = b28)) THEN
					CEROS_reg <= '1';
				ELSIF ((ceros_integer=24) AND (digest_ceros(127 DOWNTO 104) = b24)) THEN
					CEROS_reg <= '1';
				ELSIF ((ceros_integer=20) AND (digest_ceros(127 DOWNTO 108) = b20)) THEN
					CEROS_reg <= '1';
				ELSIF ((ceros_integer=16) AND (digest_ceros(127 DOWNTO 112) = b16)) THEN
					CEROS_reg <= '1';
				ELSIF ((ceros_integer=12) AND (digest_ceros(127 DOWNTO 116) = b12)) THEN
					CEROS_reg <= '1';
				ELSIF ((ceros_integer=8) AND (digest_ceros(127 DOWNTO 120) = b8)) THEN
					CEROS_reg <= '1';
				ELSIF ((ceros_integer=4) AND (digest_ceros(127 DOWNTO 124) = b4)) THEN
					CEROS_reg <= '1';
				ELSIF ((ceros_integer=0) AND (digest_ceros(127 DOWNTO 124) = b4)) THEN
					CEROS_reg <= '1';
				ELSE
					CEROS_reg <= '0';
					END IF;
			END IF;
		END IF;
	END PROCESS;										
END ARCHITECTURE zeros;