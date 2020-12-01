LIBRARY IEEE;
USE ieee.STD_LOGIC_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY cont_c IS
	GENERIC	( Con       		:			INTEGER  ;  
				  N					:			INTEGER	);
	PORT		( clk					:	IN		STD_ULOGIC;
				  rst					:	IN 	STD_ULOGIC;
				  syn_clr_cont	:	IN 	STD_ULOGIC;
				  ena_cont		:	IN 	STD_ULOGIC;
				  contMaxTick	:	OUT 	STD_ULOGIC;
				  salidacount	:	OUT	INTEGER);
END ENTITY;
---------------------------------- 

----------------------------------
ARCHITECTURE cont_cArchh OF cont_c IS
	SIGNAL	count_s		:	INTEGER; --RANGE -1 to (Con);
BEGIN
	salidacount <= count_s;
	PROCESS(clk,rst)
		VARIABLE temp	:	INTEGER; --RANGE -1 to (Con);
	BEGIN
		IF(rst = '0') THEN
			temp	:=	0;
		ELSIF(RISING_EDGE(clk)) THEN
			IF (syn_clr_cont='1') THEN
				temp := 0;
			ELSE IF (ena_cont = '1') THEN
				IF (temp=(Con)) THEN
					temp := (-1);
				END IF;
				temp := temp + 1;
			END IF;
		 END IF;
		END IF;
		count_s	<=	temp;
	END PROCESS;
--
	contMaxTick	<=	'1' WHEN (count_s) = (Con) ELSE '0';
END ARCHITECTURE cont_cArchh;