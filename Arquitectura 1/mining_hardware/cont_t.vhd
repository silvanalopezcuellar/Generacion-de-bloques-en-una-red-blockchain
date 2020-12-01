LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_1164.std_ulogic;
----------------------------------
ENTITY cont_t IS
	GENERIC	( Rstvalue       	:			INTEGER  ;
				  Con       		:			INTEGER  ;  
				  N					:			INTEGER	);
	PORT		( clk					:	IN		STD_ULOGIC;
				  rst					:	IN 	STD_ULOGIC ;
				  syn_clr_cont	:	IN 	STD_ULOGIC ;
				  ena_cont		:	IN 	STD_ULOGIC ;
				  contMaxTick	:	OUT 	STD_ULOGIC ;
				  salidacount	:	OUT	STD_ULOGIC_VECTOR(N-1 DOWNTO 0)
				  );
END ENTITY;
---------------------------------- 

----------------------------------
ARCHITECTURE cont_tArchh OF cont_t IS
	SIGNAL	count_s		:	INTEGER := 0; --RANGE -1 to (Con);
BEGIN
	salidacount <= STD_ULOGIC_VECTOR ( TO_UNSIGNED(count_s, N));
	PROCESS(clk,rst, syn_clr_cont)
		VARIABLE temp	:	INTEGER; --RANGE -1 to (Con);
	BEGIN
		IF(rst = '0') THEN
			temp	:=	Rstvalue;
		ELSIF(RISING_EDGE(clk)) THEN
			IF (syn_clr_cont='1') THEN
				temp := 0;
			ELSIF (ena_cont = '1') THEN
				IF (temp=(Con)) THEN
				temp := (Rstvalue-1);
				END IF;
				temp := temp + 1;
			END IF;
		END IF;
		count_s	<=	temp;
	END PROCESS;
	contMaxTick	<=	'1' WHEN (count_s) = (Con) ELSE '0';
END ARCHITECTURE cont_tArchh;