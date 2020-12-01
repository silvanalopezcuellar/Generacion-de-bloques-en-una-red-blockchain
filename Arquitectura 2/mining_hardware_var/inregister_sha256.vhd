LIBRARY ieee;              
--USE ieee.std_logic_arith.all;                                 
USE ieee.std_logic_1164.all;  
USE ieee.numeric_std.all; 
USE ieee.std_logic_signed .all ;
USE ieee.std_logic_1164.std_ulogic;

------------------------------------------------------
ENTITY inregister_sha256 IS
GENERIC	( 	nonceL		   	:		INTEGER );
PORT(			clk					: IN  STD_ULOGIC;
				reset					: IN  STD_ULOGIC;	
				mas_bloques			: IN	STD_ULOGIC;
				first_sig			: IN	STD_ULOGIC;
				Write_enable		: IN  STD_ULOGIC;
				read_enable			: IN  STD_ULOGIC;
				address				: IN	STD_ULOGIC_VECTOR(7 DOWNTO 0);
				msg_input			: IN  STD_ULOGIC_VECTOR(511 DOWNTO 0):= (OTHERS => '0');
				nonce_input			: IN  STD_ULOGIC_VECTOR(nonceL-1 DOWNTO 0):= (OTHERS => '0');
				w_output				: OUT STD_ULOGIC_VECTOR(31 DOWNTO 0)		
		);
END ENTITY inregister_sha256;  
------------------------------------------------------
ARCHITECTURE inregister_arch OF inregister_sha256 IS 
------------------------------------------------------
SIGNAL n16, n31 	: STD_ULOGIC_VECTOR(7 DOWNTO 0);
SIGNAL INregister	: STD_ULOGIC_VECTOR(511 DOWNTO 0);

BEGIN

	n16 		<= STD_ULOGIC_VECTOR(TO_UNSIGNED(16,8));	
	n31 		<= STD_ULOGIC_VECTOR(TO_UNSIGNED(31,8));

	PROCESS(clk, reset)
		   VARIABLE initialvalue : INTEGER;
	BEGIN
	
		IF (reset = '0') THEN
			
			w_output <= (OTHERS => '0');
			
		ELSIF(RISING_EDGE(clk)) THEN
			
			IF (Write_enable = '1' AND first_sig ='0') THEN
				
					INregister(511 DOWNTO (512-nonceL)) <= nonce_input;
					INregister((512-nonceL-1) DOWNTO 0)	<= msg_input((512-nonceL-1) DOWNTO 0);
					w_output <= (OTHERS => '0');
		
			ELSIF(Write_enable = '1' AND first_sig 
			='1') THEN
			
					INregister <= msg_input;
				
			ELSIF ((read_enable= '1') AND (address >= n16) AND (address <= n31)) THEN
					
					initialvalue := ((to_integer(unsigned(address))) - 16)*32;
					w_output <= INregister((511-initialvalue) DOWNTO (480-initialvalue));
			
			ELSE
					
					w_output <= (OTHERS => '0');
			
			END IF;
		END IF;
		
	END PROCESS;	
END ARCHITECTURE inregister_arch;