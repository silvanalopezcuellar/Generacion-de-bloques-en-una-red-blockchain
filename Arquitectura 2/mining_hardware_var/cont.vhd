LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_1164.std_ulogic;
----------------------------------
ENTITY cont IS
	GENERIC	( Rstvalue       	:			INTEGER  ;
				  Con       		:			INTEGER  ;  
				  N					:			INTEGER	);
	PORT		( clk					:	IN		STD_ULOGIC;
				  rst					:	IN 	STD_ULOGIC := '1';
				  syn_clr_cont	:	IN 	STD_ULOGIC := '0';
				  ena_cont		:	IN 	STD_ULOGIC := '0';
				  contMaxTick	:	OUT 	STD_ULOGIC := '0';
				  salidacount	:	OUT	STD_ULOGIC_VECTOR(N-1 DOWNTO 0)
				  );
END ENTITY;
---------------------------------- 

----------------------------------
ARCHITECTURE contArchh OF cont IS
	SIGNAL	count_s		:	INTEGER := 0; --RANGE -1 to (Con);
BEGIN
	salidacount <= STD_ULOGIC_VECTOR ( TO_UNSIGNED(count_s, N));
	PROCESS(clk,rst)
		VARIABLE temp	:	INTEGER; --RANGE -1 to (Con);
	BEGIN
		IF(rst = '0') THEN
			temp	:=	Rstvalue;
		ELSIF(RISING_EDGE(clk)) THEN
			IF (syn_clr_cont='1') THEN
				temp := Rstvalue;
			ELSE IF (ena_cont = '1') THEN
				IF (temp=(Con)) THEN
					temp := (con - 1);
				END IF;
				temp := temp + 1;
			END IF;
		 END IF;
		END IF;
		count_s	<=	temp;
		
	END PROCESS;
--
	contMaxTick	<=	'1' WHEN (count_s) = (Con) ELSE '0';
END ARCHITECTURE contArchh;