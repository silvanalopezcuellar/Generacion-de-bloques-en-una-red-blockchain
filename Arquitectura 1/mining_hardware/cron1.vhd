LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY cron1 IS
	GENERIC	( Con       :			INTEGER  ;  
					N			:			INTEGER	);
	PORT		( clk			:	IN		STD_LOGIC;
				  rst			:	IN 	STD_LOGIC;
				  ena			:	IN 	STD_LOGIC;
				  max_tick	:	OUT 	STD_LOGIC;
				  count		:	OUT 	STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY;
---------------------------------- 

----------------------------------
ARCHITECTURE cron1Arch OF cron1 IS
	SIGNAL	count_s		:	INTEGER RANGE -1 to (Con);
BEGIN
	PROCESS(clk,rst)
		VARIABLE temp	:	INTEGER RANGE -1 to (Con);
	BEGIN
		IF(rst = '0') THEN
			temp	:=	0;
		ELSIF(RISING_EDGE(clk)) THEN
			IF (ena = '1') THEN
				IF (temp=(Con)) THEN
					temp := (-1);
				END IF;
				temp := temp + 1;
			END IF;
		 END IF;
		count	<=	STD_LOGIC_VECTOR(to_unsigned(temp, N));
		count_s	<=	temp;
	END PROCESS;
--
	max_tick	<=	'1' WHEN (count_s) = (Con) ELSE '0';
END ARCHITECTURE cron1Arch;