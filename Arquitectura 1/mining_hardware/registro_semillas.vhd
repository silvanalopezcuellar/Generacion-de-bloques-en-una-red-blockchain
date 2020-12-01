LIBRARY ieee;              
--USE ieee.std_logic_arith.all;                                 
USE ieee.std_logic_1164.all;  
USE ieee.numeric_std.all; 
USE ieee.std_logic_signed .all ;
USE ieee.std_logic_1164.std_ulogic;

------------------------------------------------------
ENTITY registro_semillas IS
GENERIC	( randL		   :			INTEGER 	;
			  halfL  		:			INTEGER  ;  
			  sequL			:			INTEGER	;
			  twicL			:			INTEGER	);
PORT(	clk					: IN  	STD_ULOGIC;
		rst					: IN  	STD_ULOGIC;		
		control_regsem			: IN  STD_ULOGIC_VECTOR(1 DOWNTO 0);
		contseq_regsem			: IN	STD_ULOGIC_VECTOR(halfL-1 DOWNTO 0);
		semilla_x0				: IN  STD_ULOGIC_VECTOR(randL-1 DOWNTO 0);
		cuadradosm_regsem		: IN  STD_ULOGIC_VECTOR(randL-1 DOWNTO 0);
		regsem_mult				: OUT STD_ULOGIC_VECTOR(randL-1 DOWNTO 0)		
		);
END ENTITY registro_semillas;  
------------------------------------------------------
ARCHITECTURE registersem_arch OF registro_semillas IS 
------------------------------------------------------
SIGNAL SEMregister	: STD_ULOGIC_VECTOR(randL-1 DOWNTO 0):= (OTHERS => '0');
SIGNAL contingenciaR: STD_ULOGIC_VECTOR(halfL-1 DOWNTO 0):= (OTHERS => '0');

BEGIN

	PROCESS(clk, rst)

	BEGIN
	
		IF (rst = '0') THEN
			
		regsem_mult <= (OTHERS => '0');
			
		ELSIF(RISING_EDGE(clk)) THEN
		
		contingenciaR	<= SEMregister(randL-1 DOWNTO halfL);
		regsem_mult		<= SEMregister;	
		
			IF (control_regsem = "01") THEN
				
					SEMregister <= semilla_x0;
									
			ELSIF (control_regsem = "10") THEN
					
					SEMregister<= cuadradosm_regsem;
					
			ELSIF (control_regsem = "11") THEN
					
					SEMregister(randL-1 DOWNTO halfL) <= contseq_regsem;
					SEMregister(halfL-1 DOWNTO 0) <= contingenciaR;
			
			END IF;
		END IF;
		
	END PROCESS;	
END ARCHITECTURE registersem_arch;