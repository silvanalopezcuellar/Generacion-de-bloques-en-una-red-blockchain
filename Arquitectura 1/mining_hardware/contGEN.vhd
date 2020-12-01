LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_1164.std_ulogic;

----------------------------------
ENTITY contGEN IS
	GENERIC	( 	  Con       		:			INTEGER  ;  
				  N					:			INTEGER	 ;
				  R					:			INTEGER	  );
	PORT		( clk					:	IN		STD_ULOGIC;
				  rst					:	IN 	STD_ULOGIC := '1';
				  syn_clr_cont	:	IN 	STD_ULOGIC := '0';
				  ena_cont		:	IN 	STD_ULOGIC := '0';
				  contMaxTick	:	OUT 	STD_ULOGIC := '0';
				  salidacount	:	OUT	STD_ULOGIC_VECTOR(N-1 DOWNTO 0);
				  contseq_regsem:	OUT	STD_ULOGIC_VECTOR(R-1 DOWNTO 0)
				  );
END ENTITY;
---------------------------------- 

----------------------------------
ARCHITECTURE contGENArchh OF contGEN IS
	SIGNAL	count_s		:	INTEGER := 0; --RANGE -1 to (Con);
	SIGNAL	registro	:	STD_ULOGIC_VECTOR(N-1 DOWNTO 0);
BEGIN

	salidacount <= STD_ULOGIC_VECTOR ( TO_UNSIGNED(count_s, N));
	contseq_regsem <= registro(R-1 DOWNTO 0);
	
	PROCESS(clk,rst)
		VARIABLE temp	:	INTEGER; --RANGE -1 to (Con);
	BEGIN
		IF(rst = '0') THEN
			temp	:= 0;
			registro	<= (OTHERS => '0');
		ELSIF(RISING_EDGE(clk)) THEN
			registro	<= STD_ULOGIC_VECTOR ( TO_UNSIGNED(count_s, N));
			
			IF (syn_clr_cont='1') THEN
				temp := 0;
			ELSE IF (ena_cont = '1') THEN
				IF (temp=(Con)) THEN
					temp := 0;
				END IF;
				temp := temp + 1;
			END IF;
		 END IF;
		END IF;
		count_s	<=	temp;
	END PROCESS;
--
	contMaxTick	<=	'1' WHEN (count_s) = (Con) ELSE '0';
END ARCHITECTURE contGENArchh;