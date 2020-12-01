LIBRARY ieee;              
--USE ieee.std_logic_arith.all;                                 
USE ieee.std_logic_1164.all;  
USE ieee.numeric_std.all; 
USE ieee.std_logic_signed .all ;
USE ieee.std_logic_1164.std_ulogic;

------------------------------------------------------
ENTITY sha256_outregister IS
PORT(	clk			: IN  STD_ULOGIC;
		reset			: IN  STD_ULOGIC;		
		enable		: IN  STD_ULOGIC;
		address		: IN  STD_ULOGIC_VECTOR(7 DOWNTO 0);
		r_input		: IN  STD_ULOGIC_VECTOR(31 DOWNTO 0);
		r_output		: OUT STD_ULOGIC_VECTOR(255 DOWNTO 0)		
		);
END ENTITY sha256_outregister;  
------------------------------------------------------
ARCHITECTURE register_arch OF sha256_outregister IS 
------------------------------------------------------
SIGNAL n32, n39 : STD_ULOGIC_VECTOR(7 DOWNTO 0);

BEGIN
	n32 		<= STD_ULOGIC_VECTOR(TO_UNSIGNED(32,8));
	n39 		<= STD_ULOGIC_VECTOR(TO_UNSIGNED(39,8));

	PROCESS(clk, reset)
		   VARIABLE initialvalue : INTEGER;
	BEGIN
	
		IF (reset = '0') THEN
			r_output <= (OTHERS => '0');
		ELSIF(RISING_EDGE(clk)) THEN
			IF (enable = '1') THEN
				IF ((address >= n32) AND (address <= n39)) THEN
					initialvalue := (7 - (to_integer(unsigned(address)) - 32))*32;
					r_output((initialvalue+31) DOWNTO (initialvalue)) <= r_input;
				END IF;
			END IF;
		END IF;
		
	END PROCESS;	
END ARCHITECTURE register_arch;