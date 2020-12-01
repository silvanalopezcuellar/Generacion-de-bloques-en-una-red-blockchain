LIBRARY IEEE;
USE ieee.std_logic_1164.all;  
USE ieee.numeric_std.all; 
USE ieee.std_logic_signed .all ;
USE ieee.std_logic_1164.std_ulogic;

------------------------------------------------------
ENTITY multiplicador IS
GENERIC	( randL		   :			INTEGER ;
			  halfL  		:			INTEGER ;  
			  sequL			:			INTEGER	;
			  twicL			:			INTEGER	);
PORT(	dataa						: IN  STD_ULOGIC_VECTOR(randL-1 DOWNTO 0);
		control_mult			: IN	STD_ULOGIC;
		mult_control			: OUT	STD_ULOGIC;
		mult_cuadm				: OUT STD_ULOGIC_VECTOR(twicL-1 DOWNTO 0)		
		);
END ENTITY multiplicador;  
------------------------------------------------------
ARCHITECTURE mult_arch OF multiplicador IS 
------------------------------------------------------
SIGNAL	result		:	INTEGER := 0; --RANGE -1 to (Con);

BEGIN
	mult_cuadm <= STD_ULOGIC_VECTOR (TO_UNSIGNED(result, twicL));
	
	PROCESS(control_mult)
	
		   VARIABLE multvalue : INTEGER;
	BEGIN

			IF (control_mult = '1') THEN
				
					multvalue := (to_integer(unsigned(dataa))) * (to_integer(unsigned(dataa)));
					
					mult_control <= '1';
					
			ELSE
					multvalue := 0;
					mult_control <= '0';
			END IF;
			
		result <= multvalue;
		
	END PROCESS;	
END ARCHITECTURE mult_arch;