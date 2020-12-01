LIBRARY ieee;              
--USE ieee.std_logic_arith.all;                                 
USE ieee.std_logic_1164.all;  
USE ieee.numeric_std.all; 
USE ieee.std_logic_signed .all ;
USE ieee.std_logic_1164.std_ulogic;

------------------------------------------------------
ENTITY nonce_build IS
GENERIC	( randL		   :			INTEGER ;
			  halfL  		:			INTEGER ;  
			  sequL			:			INTEGER	;
			  twicL			:			INTEGER	);
PORT(	clk						: IN  STD_ULOGIC;
		rst						: IN  STD_ULOGIC;		
		control_nbluid			: IN  STD_ULOGIC;
		cuadradosm_out			: IN	STD_ULOGIC_VECTOR(randL-1 DOWNTO 0);
		contseq					: IN	STD_ULOGIC_VECTOR(sequL-1 DOWNTO 0);
		nonce						: OUT STD_ULOGIC_VECTOR(randL+sequL-1 DOWNTO 0)		
		);
END ENTITY nonce_build;  
------------------------------------------------------
ARCHITECTURE nbuild_arch OF nonce_build IS 
------------------------------------------------------
SIGNAL nonceREG	: STD_ULOGIC_VECTOR(randL+sequL-1 DOWNTO 0):= (OTHERS => '0');

BEGIN

	PROCESS(clk, rst, nonceREG)

	BEGIN
	
	nonce <= nonceREG;
	
		IF (rst = '0') THEN
			
		nonce <= (OTHERS => '0');
		nonceREG <= (OTHERS => '0');
			
		ELSIF(RISING_EDGE(clk)) THEN
		
			IF (control_nbluid = '1') THEN
				
					nonceREG <= cuadradosm_out & contseq;
									
			END IF;
		END IF;
		
	END PROCESS;	
END ARCHITECTURE nbuild_arch;