LIBRARY ieee;              
--USE ieee.std_logic_arith.all;                                 
USE ieee.std_logic_1164.all;  
USE ieee.numeric_std.all; 
USE ieee.std_logic_signed .all ;
USE ieee.std_logic_1164.std_ulogic;

------------------------------------------------------
ENTITY cuadrados_medios IS
GENERIC	( randL		   :			INTEGER ;
			  halfL  		:			INTEGER  ;  
			  sequL			:			INTEGER	;
			  twicL			:			INTEGER	);
PORT(	clk						: IN  STD_ULOGIC;
		rst						: IN  STD_ULOGIC;		
		control_cuadm			: IN  STD_ULOGIC;
		mult_cuadm				: IN	STD_ULOGIC_VECTOR(twicL-1 DOWNTO 0);
		cuadradosm_out			: OUT STD_ULOGIC_VECTOR(randL-1 DOWNTO 0)		
		);
END ENTITY cuadrados_medios;  
------------------------------------------------------
ARCHITECTURE cuadm_arch OF cuadrados_medios IS 
------------------------------------------------------
SIGNAL cuadradosM	: STD_ULOGIC_VECTOR(randL-1 DOWNTO 0):= (OTHERS => '0');

BEGIN

	PROCESS(clk, rst, cuadradosM)

	BEGIN
	
	cuadradosm_out <= cuadradosM;
	
		IF (rst = '0') THEN
			
		cuadradosM <= (OTHERS => '0');
			
		ELSIF(RISING_EDGE(clk)) THEN

			IF (control_cuadm = '1') THEN
				
					cuadradosM	   <= mult_cuadm(twicL-halfL-1 DOWNTO halfL);
									
			END IF;
		END IF;
		
	END PROCESS;	
END ARCHITECTURE cuadm_arch;