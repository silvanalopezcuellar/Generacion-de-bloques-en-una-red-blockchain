LIBRARY ieee;              
--USE ieee.std_logic_arith.all;                                 
USE ieee.std_logic_1164.all;  
USE ieee.numeric_std.all; 
USE ieee.std_logic_signed .all ;
USE ieee.std_logic_1164.std_ulogic;

------------------------------------------------------
ENTITY comparador IS
GENERIC	( randL		   :			INTEGER ;
			  halfL  		:			INTEGER  ;  
			  sequL			:			INTEGER	;
			  twicL			:			INTEGER	);
PORT(	maxtickseed			: IN STD_ULOGIC;
		cuadradosm_out		: IN	STD_ULOGIC_VECTOR(randL-1 DOWNTO 0);
		contingencia		: OUT STD_ULOGIC
		);
END ENTITY comparador;  
------------------------------------------------------
ARCHITECTURE comparador_arch OF comparador IS 
------------------------------------------------------
SIGNAL ceros		: STD_ULOGIC_VECTOR(randL-1 DOWNTO 0):=(OTHERS => '0');
BEGIN

	PROCESS(cuadradosm_out, maxtickseed)
	BEGIN
	
		IF (cuadradosm_out = ceros OR maxtickseed = '1') THEN
			
			contingencia <= '1';
			
		ELSE
			
			contingencia <= '0';
									
		END IF;
		
	END PROCESS;	
END ARCHITECTURE comparador_arch;