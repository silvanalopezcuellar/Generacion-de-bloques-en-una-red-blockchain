LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------
ENTITY controltransmision IS
	PORT		( clk	               :	IN 	STD_ULOGIC;
				  rst	               :	IN 	STD_ULOGIC;
				  iniciotransmision	:	IN		STD_ULOGIC;
				  conttrMaxTick      :	IN 	STD_ULOGIC;
				  contbitsMaxTick		:	IN		STD_ULOGIC;
				  countbits				:	IN		INTEGER := 0;
				  syn_clr_tr			:	OUT	STD_ULOGIC;
				  syn_clr_bits			:	OUT	STD_ULOGIC;
				  ena_conttr			:	OUT	STD_ULOGIC;
				  ena_contbits			:	OUT	STD_ULOGIC;
				  ena_guardar			:	OUT	STD_ULOGIC;
				  ena_desplazar		:  OUT	STD_ULOGIC;
				  tx						:	OUT	STD_ULOGIC 
				  ); 
END ENTITY;
--------------------------------
ARCHITECTURE oneHot OF controltransmision IS
	SIGNAL txx	: STD_ULOGIC;
	TYPE state IS (uno, dos, tres, cuatro, cinco, seis, siete);
	SIGNAL pr_state, nx_state	:	state;
BEGIN
	
	combinationalreset: PROCESS(clk)
	BEGIN
		IF(rising_edge(clk)) THEN
			tx <= txx;
		END IF;
	END PROCESS;

	combinationaltx: PROCESS( rst, clk, pr_state, iniciotransmision, conttrMaxTick, contbitsMaxTick, countbits)
	BEGIN
	
		IF (rst = '0') THEN
			pr_state	<=	uno;
			txx		<= '0';
		ELSIF (rising_edge(clk)) THEN
		
		CASE pr_state IS
			WHEN uno	=>
				syn_clr_tr 		<= '1';
				syn_clr_bits 	<= '1';
				ena_conttr 		<= '0';
				ena_contbits 	<= '0';
				ena_guardar 	<= '0';
				ena_desplazar 	<= '0';
				txx 				<= '0';
				IF (iniciotransmision = '1') THEN
				pr_state 		<= dos;
				ELSE
				pr_state 		<= uno;
				END IF;
				
			WHEN dos	=>
				syn_clr_tr 		<= '1';
				syn_clr_bits 	<= '1';
				ena_conttr 		<= '0';
				ena_contbits 	<= '0';
				ena_guardar 	<= '1';
				ena_desplazar 	<= '0';
				txx 				<= '0';
				pr_state 		<= tres;
				
			WHEN tres	=>
				syn_clr_tr 		<= '0';
				syn_clr_bits 	<= '0';
				ena_conttr 		<= '1';
				ena_contbits 	<= '0';
				txx 				<= '0';
				ena_guardar 	<= '0';
				ena_desplazar 	<= '0';
				IF (conttrMaxTick = '1') THEN
				pr_state 		<= cuatro;
				ELSE
				pr_state 		<= tres;
				END IF;
				
			WHEN cuatro	=>
				syn_clr_tr 		<= '1';
				syn_clr_bits 	<= '0';
				ena_conttr 		<= '0';
				ena_contbits 	<= '1';
				ena_guardar 	<= '0';
				ena_desplazar 	<= '1';
				txx 				<= '0';
				IF (contbitsMaxTick = '0') THEN
				pr_state 		<= tres;
				ELSIF (contbitsMaxTick = '1') THEN
				pr_state 		<= cinco;
				END IF;
				
			WHEN cinco	=>
				syn_clr_tr 		<= '0';
				syn_clr_bits 	<= '1';
				ena_conttr 		<= '1';
				ena_contbits 	<= '0';
				ena_guardar 	<= '0';
				ena_desplazar 	<= '0';
				txx 				<= '0';
				IF (conttrMaxTick = '1') THEN
				pr_state 		<= seis;
				ELSE
				pr_state 		<= cinco;
				END IF;

			WHEN seis	=>
				syn_clr_tr 		<= '0';
				syn_clr_bits 	<= '1';
				ena_conttr 		<= '1';
				ena_contbits 	<= '0';
				ena_guardar 	<= '0';
				ena_desplazar 	<= '0';
				txx 				<= '1';
				pr_state 		<= siete;
			
			WHEN siete	=>
				syn_clr_tr 		<= '0';
				syn_clr_bits 	<= '1';
				ena_conttr 		<= '1';
				ena_contbits 	<= '0';
				ena_guardar 	<= '0';
				ena_desplazar 	<= '0';
				txx 				<= '1';
				pr_state 		<= uno;
				
		END CASE;
	  END IF;
	END PROCESS combinationaltx;
END ARCHITECTURE;