LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_1164.std_ulogic;

-------------------------------
ENTITY controlGLOBAL IS
	PORT		( clk	            	:	IN STD_ULOGIC;
				  rst	        	    	:	IN STD_ULOGIC;
				  leer_ok0				:	IN	STD_ULOGIC;
				  leer_ok1				:	IN	STD_ULOGIC;
				  leer_ok2				:	IN	STD_ULOGIC;
				  leer_ok3				:	IN	STD_ULOGIC;
				  leer_ok4				:	IN	STD_ULOGIC;
				  leer_ok5				:	IN	STD_ULOGIC;
				  leer_ok6				:	IN	STD_ULOGIC;
				  leer_ok7				:	IN	STD_ULOGIC;
				  leer_ok8				:	IN	STD_ULOGIC;
				  leer_ok9				:	IN	STD_ULOGIC;
				  leer_okA				:	IN	STD_ULOGIC;
				  leer_okB				:	IN	STD_ULOGIC;
				  leer_okC				:	IN	STD_ULOGIC;
				  leer_okD				:	IN	STD_ULOGIC;
				  leer_okE				:	IN	STD_ULOGIC;
				  leer_okF				:	IN	STD_ULOGIC;
				  fin_mensaje			:	IN	STD_ULOGIC;
				  nonce_valid0			:	IN	STD_ULOGIC;
				  nonce_valid1			:	IN	STD_ULOGIC;
				  nonce_valid2			:	IN	STD_ULOGIC;
				  nonce_valid3			:	IN	STD_ULOGIC;
				  nonce_valid4			:	IN	STD_ULOGIC;
				  nonce_valid5			:	IN	STD_ULOGIC;
				  nonce_valid6			:	IN	STD_ULOGIC;
				  nonce_valid7			:	IN	STD_ULOGIC;
				  nonce_valid8			:	IN	STD_ULOGIC;
				  nonce_valid9			:	IN	STD_ULOGIC;
				  nonce_validA			:	IN	STD_ULOGIC;
				  nonce_validB			:	IN	STD_ULOGIC;
				  nonce_validC			:	IN	STD_ULOGIC;
				  nonce_validD			:	IN	STD_ULOGIC;
				  nonce_validE			:	IN	STD_ULOGIC;
				  nonce_validF			:	IN	STD_ULOGIC;
				  digest_valid0		:  IN STD_ULOGIC;
				  digest_valid1		:  IN STD_ULOGIC;
				  digest_valid2		:  IN STD_ULOGIC;
				  digest_valid3		:  IN STD_ULOGIC;
				  digest_valid4		:  IN STD_ULOGIC;
				  digest_valid5		:  IN STD_ULOGIC;
				  digest_valid6		:  IN STD_ULOGIC;
				  digest_valid7		:  IN STD_ULOGIC;
				  digest_valid8		:  IN STD_ULOGIC;
				  digest_valid9		:  IN STD_ULOGIC;
				  digest_validA		:  IN STD_ULOGIC;
				  digest_validB		:  IN STD_ULOGIC;
				  digest_validC		:  IN STD_ULOGIC;
				  digest_validD		:  IN STD_ULOGIC;
				  digest_validE		:  IN STD_ULOGIC;
				  digest_validF		:  IN STD_ULOGIC;
				  comparar_ceros0		:	IN	STD_ULOGIC;
				  comparar_ceros1		:	IN	STD_ULOGIC;
				  comparar_ceros2		:	IN	STD_ULOGIC;
				  comparar_ceros3		:	IN	STD_ULOGIC;
				  comparar_ceros4		:	IN	STD_ULOGIC;
				  comparar_ceros5		:	IN	STD_ULOGIC;
				  comparar_ceros6		:	IN	STD_ULOGIC;
				  comparar_ceros7		:	IN	STD_ULOGIC;
				  comparar_ceros8		:	IN	STD_ULOGIC;
				  comparar_ceros9		:	IN	STD_ULOGIC;
				  comparar_cerosA		:	IN	STD_ULOGIC;
				  comparar_cerosB		:	IN	STD_ULOGIC;
				  comparar_cerosC		:	IN	STD_ULOGIC;
				  comparar_cerosD		:	IN	STD_ULOGIC;
				  comparar_cerosE		:	IN	STD_ULOGIC;
				  comparar_cerosF		:	IN	STD_ULOGIC;
				  MaxTseq0				:	IN	STD_ULOGIC;
				  MaxTseq1				:	IN	STD_ULOGIC;
				  MaxTseq2				:	IN	STD_ULOGIC;
				  MaxTseq3				:	IN	STD_ULOGIC;
				  MaxTseq4				:	IN	STD_ULOGIC;
				  MaxTseq5				:	IN	STD_ULOGIC;
				  MaxTseq6				:	IN	STD_ULOGIC;
				  MaxTseq7				:	IN	STD_ULOGIC;
				  MaxTseq8				:	IN	STD_ULOGIC;
				  MaxTseq9				:	IN	STD_ULOGIC;
				  MaxTseqA				:	IN	STD_ULOGIC;
				  MaxTseqB				:	IN	STD_ULOGIC;
				  MaxTseqC				:	IN	STD_ULOGIC;
				  MaxTseqD				:	IN	STD_ULOGIC;
				  MaxTseqE				:	IN	STD_ULOGIC;
				  MaxTseqF				:	IN	STD_ULOGIC;
				  bloques_cuenta		:	IN INTEGER;
				  contB					:	IN INTEGER;
				  hash					:	OUT STD_ULOGIC;
				  mas_bloques			:  OUT STD_ULOGIC;
				  activo_nonce			:	OUT STD_ULOGIC;
				  inicio_transmision	:	OUT STD_ULOGIC;
				  ena_num_ceros_comp	:	OUT STD_ULOGIC;
				  syn_clr_contB	   :	OUT STD_ULOGIC;
				  ena_contB				:	OUT STD_ULOGIC;
				  reset_all				:	OUT STD_ULOGIC;
				  ready					:	OUT STD_ULOGIC;
				  column_rd_addr	   :	OUT INTEGER := 0;
				  new_msg_ready		:	OUT STD_ULOGIC;
				  failed					:	OUT STD_ULOGIC;
				  test					:	OUT STD_ULOGIC;
				  go						:	OUT STD_ULOGIC
				  
				  ); 
END ENTITY;
--------------------------------
ARCHITECTURE controlglob OF controlGLOBAL IS
--------------------------------

	TYPE state IS (uno, dos, tres, espera, cuatro, cinco, seis, siete, ocho, nueve, no_leer, wait_comp, diez, once, doce, fail, trece);
	SIGNAL nx_state	:	state;
	SIGNAL contB_bloques_cuenta : STD_ULOGIC:='0';
	
BEGIN
	
	test <= contB_bloques_cuenta;
		CombinationalGLOBAL: PROCESS(rst, contB, clk, contB_bloques_cuenta, MaxTseq0, MaxTseq1, MaxTseq2, MaxTseq3, 
												MaxTseq4, MaxTseq5, MaxTseq6, MaxTseq7, MaxTseq8, MaxTseq9, MaxTseqA, MaxTseqB, 
												MaxTseqC, MaxTseqD, MaxTseqE, MaxTseqF, leer_ok0, leer_ok1, leer_ok2, leer_ok3, 
												leer_ok4, leer_ok5, leer_ok6, leer_ok7, leer_ok8, leer_ok9, leer_okA, leer_okB, 
												leer_okC, leer_okD, leer_okE, leer_okF, fin_mensaje, nonce_valid0, nonce_valid1, 
												nonce_valid2, nonce_valid3, nonce_valid4, nonce_valid5, nonce_valid6, nonce_valid7, 
												nonce_valid8, nonce_valid9, nonce_validA, nonce_validB, nonce_validC, nonce_validD, 
												nonce_validE, nonce_validF, digest_valid0, digest_valid1, digest_valid2, digest_valid3, 
												digest_valid4, digest_valid5, digest_valid6, digest_valid7, digest_valid8, 
												digest_valid9, digest_validA, digest_validB, digest_validC, digest_validD, digest_validE, 
												digest_validF, comparar_ceros0, comparar_ceros1, comparar_ceros2, comparar_ceros3, 
												comparar_ceros4, comparar_ceros5, comparar_ceros6, comparar_ceros7, comparar_ceros8, 
												comparar_ceros9, comparar_cerosA, comparar_cerosB, comparar_cerosC, comparar_cerosD, 
												comparar_cerosE, comparar_cerosF, bloques_cuenta, contB, bloques_cuenta)
	BEGIN
		IF (rst = '0') THEN
		
			nx_state	<=	uno;
			contB_bloques_cuenta <= '0';
			
		ELSIF (rising_edge(clk)) THEN
		
				IF (contB = bloques_cuenta) THEN
					contB_bloques_cuenta	<=	'1';
				ELSE
					contB_bloques_cuenta	<=	'0';
				END IF;
				
			CASE nx_state IS
			
			WHEN uno =>
				hash						<= '0';
				mas_bloques				<= '0';
				activo_nonce			<= '0';
				inicio_transmision	<= '0';
				ena_num_ceros_comp	<= '0';
				syn_clr_contB	  		<= '1';
				ena_contB				<= '0';
				reset_all				<= '1';
				column_rd_addr			<= 0 ;
				ready						<= '0';
				new_msg_ready			<= '0';
				failed					<= '0';
				go 						<= '0';
				IF (fin_mensaje = '0') THEN
				nx_state 				<= uno;
				ELSIF (fin_mensaje = '1') THEN
				nx_state 				<= dos;
				END IF;
				
			WHEN dos =>
				hash						<= '0';
				mas_bloques				<= '0';
				activo_nonce			<= '0';
				inicio_transmision	<= '0';
				ena_num_ceros_comp	<= '0';
				syn_clr_contB	  		<= '1';
				ena_contB				<= '0';
				reset_all				<= '0';
				column_rd_addr			<= contB;
				ready						<= '0';
				new_msg_ready			<= '0';
				failed					<= '0';
				go 						<= '1';
				nx_state 				<= tres;

			
			WHEN tres =>
				hash						<= '0';
				mas_bloques				<= '0';
				activo_nonce			<= '1';
				inicio_transmision	<= '0';
				ena_num_ceros_comp	<= '0';
				syn_clr_contB	  		<= '0';
				ena_contB				<= '1';
				reset_all				<= '1';
				column_rd_addr			<= contB;
				ready						<= '0';
				new_msg_ready			<= '0';
				failed					<= '0';
				go 						<= '1';
				nx_state 				<= espera;
				
			WHEN espera =>
				hash						<= '0';
				mas_bloques				<= '0';
				activo_nonce			<= '0';
				inicio_transmision	<= '0';
				ena_num_ceros_comp	<= '0';
				syn_clr_contB	  		<= '0';
				ena_contB				<= '0';
				reset_all				<= '1';
				column_rd_addr			<= contB;
				ready						<= '0';
				new_msg_ready			<= '0';
				failed					<= '0';
				go 						<= '1';
				nx_state 				<= cuatro;
					
			WHEN cuatro	=>
				hash						<= '0';
				mas_bloques				<= '0';
				activo_nonce			<= '0';
				inicio_transmision	<= '0';
				ena_num_ceros_comp	<= '0';
				syn_clr_contB	  		<= '0';
				ena_contB				<= '0';
				reset_all				<= '1';
				column_rd_addr			<= contB-1;
				ready						<= '0';
				new_msg_ready			<= '0';
				failed					<= '0';
				go 						<= '1';
				IF ((nonce_valid0 AND nonce_valid1 
						AND nonce_valid2 AND nonce_valid3 
						AND nonce_valid4 AND nonce_valid5 
						AND nonce_valid6 AND nonce_valid7 
						AND nonce_valid8 AND nonce_valid9 
						AND nonce_validA AND nonce_validB 
						AND nonce_validC AND nonce_validD 
						AND nonce_validE AND nonce_validF) = '0') THEN
				nx_state 				<= cuatro;
				ELSIF ((nonce_valid0 AND nonce_valid1 
						  AND nonce_valid2 AND nonce_valid3 
						  AND nonce_valid4 AND nonce_valid5 
						  AND nonce_valid6 AND nonce_valid7
						  AND nonce_valid8 AND nonce_valid9 
						  AND nonce_validA AND nonce_validB 
						  AND nonce_validC AND nonce_validD 
						  AND nonce_validE AND nonce_validF) = '1') THEN
				nx_state 				<= cinco;
				END IF;
				
			WHEN cinco	=>
				hash						<= '1';
				mas_bloques				<= '0';
				activo_nonce			<= '0';
				inicio_transmision	<= '0';
				ena_num_ceros_comp	<= '0';
				syn_clr_contB	  		<= '0';
				ena_contB				<= '0';
				reset_all				<= '1';
				column_rd_addr			<= contB-1;
				ready						<= '0';
				new_msg_ready			<= '0';
				failed					<= '0';
				go 						<= '1';
				IF (bloques_cuenta = 0) THEN
				nx_state 				<= fail ;
				ELSE 
				nx_state 				<= seis ;
				END IF;
				
			WHEN seis	=>
				hash						<= '0';
				mas_bloques				<= '1';
				activo_nonce			<= '0';
				inicio_transmision	<= '0';
				ena_num_ceros_comp	<= '0';
				syn_clr_contB	  		<= '0';
				ena_contB				<= '0';
				reset_all				<= '1';
				column_rd_addr			<= contB-1;
				ready						<= '0';
				new_msg_ready			<= '0';
				failed					<= '0';
				go 						<= '1';
				IF ((digest_valid0 AND digest_valid1 
						AND digest_valid2 AND digest_valid3 
						AND digest_valid4 AND digest_valid5 
						AND digest_valid6 AND digest_valid7 
						AND digest_valid8 AND digest_valid9 
						AND digest_validA AND digest_validB 
						AND digest_validC AND digest_validD 
						AND digest_validE AND digest_validF) = '0') THEN
				nx_state 				<= seis;
				ELSIF ((digest_valid0 AND digest_valid1 
						AND digest_valid2 AND digest_valid3 
						AND digest_valid4 AND digest_valid5 
						AND digest_valid6 AND digest_valid7
						AND digest_valid8 AND digest_valid9 
						AND digest_validA AND digest_validB 
						AND digest_validC AND digest_validD 
						AND digest_validE AND digest_validF) = '1') THEN
				nx_state 				<= siete;
				END IF;		
				
			WHEN siete	=>
				hash						<= '0';
				mas_bloques				<= '1';
				activo_nonce			<= '0';
				inicio_transmision	<= '0';
				ena_num_ceros_comp	<= '0';
				syn_clr_contB	  		<= '0';
				ena_contB				<= '0';
				reset_all				<= '1';
				column_rd_addr			<= 0 ;
				ready						<= '0';
				new_msg_ready			<= '0';
				failed					<= '0';
				go 						<= '1';
				IF ( contB_bloques_cuenta = '1') THEN
				nx_state 				<= no_leer;
				ELSE
				nx_state 				<= ocho;
				END IF;
				
			WHEN ocho	=>
				hash						<= '0';
				mas_bloques				<= '1';
				activo_nonce			<= '0';
				inicio_transmision	<= '0';
				ena_num_ceros_comp	<= '0';
				syn_clr_contB	  		<= '0';
				ena_contB				<= '1';
				reset_all				<= '1';
				column_rd_addr			<= 0 ;
				ready						<= '1';
				new_msg_ready			<= '0';
				failed					<= '0';
				go 						<= '1';
				nx_state 				<=  seis;
			
			WHEN no_leer	=>
				hash						<= '0';
				mas_bloques				<= '0';
				activo_nonce			<= '0';
				inicio_transmision	<= '0';
				ena_num_ceros_comp	<= '0';
				syn_clr_contB	  		<= '1';
				ena_contB				<= '0';
				reset_all				<= '1';
				column_rd_addr			<= 0 ;
				ready						<= '1';
				new_msg_ready			<= '0';
				failed					<= '0';
				go 						<= '1';
				IF ((leer_ok0 AND leer_ok1 
						AND leer_ok2 AND leer_ok3 
						AND leer_ok4 AND leer_ok5 
						AND leer_ok6 AND leer_ok7 
						AND leer_ok8 AND leer_ok9 
						AND leer_okA AND leer_okB 
						AND leer_okC AND leer_okD 
						AND leer_okE AND leer_okF) = '0') THEN
				nx_state 				<=  no_leer;
				ELSIF ((leer_ok0 AND leer_ok1 
						AND leer_ok2 AND leer_ok3 
						AND leer_ok4 AND leer_ok5 
						AND leer_ok6 AND leer_ok7
						AND leer_ok8 AND leer_ok9 
						AND leer_okA AND leer_okB 
						AND leer_okC AND leer_okD 
						AND leer_okE AND leer_okF) = '1') THEN
				nx_state 				<=  nueve;
				END IF;
			
			WHEN nueve	=>
				hash						<= '0';
				mas_bloques				<= '0';
				activo_nonce			<= '1';
				inicio_transmision	<= '0';
				ena_num_ceros_comp	<= '1';
				syn_clr_contB	  		<= '1';
				ena_contB				<= '0';
				reset_all				<= '1';
				column_rd_addr			<= 0 ;
				ready						<= '1';
				new_msg_ready			<= '0';
				failed					<= '0';
				go 						<= '1';
				nx_state 				<=  wait_comp;
			
			WHEN wait_comp	=>
				hash						<= '0';
				mas_bloques				<= '0';
				activo_nonce			<= '0';
				inicio_transmision	<= '0';
				ena_num_ceros_comp	<= '1';
				syn_clr_contB	  		<= '1';
				ena_contB				<= '0';
				reset_all				<= '1';
				column_rd_addr			<= 0 ;
				ready						<= '1';
				new_msg_ready			<= '0';
				failed					<= '0';
				go 						<= '1';
				nx_state 				<=  diez;
		
			WHEN diez	=>
				hash						<= '0';
				mas_bloques				<= '0';
				activo_nonce			<= '0';
				inicio_transmision	<= '0';
				ena_num_ceros_comp	<= '1';
				syn_clr_contB	  		<= '1';
				ena_contB				<= '0';
				reset_all				<= '1';
				column_rd_addr			<= 0 ;
				ready						<= '0';
				new_msg_ready			<= '0';
				failed					<= '0';
				go 						<= '1';
				IF ( (comparar_ceros0 OR comparar_ceros1 
						OR comparar_ceros2 OR comparar_ceros3 
						OR comparar_ceros4 OR comparar_ceros5 
						OR comparar_ceros6 OR comparar_ceros7 
						OR comparar_ceros8 OR comparar_ceros9 
						OR comparar_cerosA OR comparar_cerosB 
						OR comparar_cerosC OR comparar_cerosD 
						OR comparar_cerosE OR comparar_cerosF) = '1' ) THEN
				nx_state 				<= doce;				
				ELSIF ((MaxTseq0 OR MaxTseq1 
							OR MaxTseq2 OR MaxTseq3 
							OR MaxTseq4 OR MaxTseq5 
							OR MaxTseq6 OR MaxTseq7 
							OR MaxTseq8 OR MaxTseq9 
							OR MaxTseqA OR MaxTseqB 
							OR MaxTseqC OR MaxTseqD 
							OR MaxTseqE OR MaxTseqF) = '1') THEN
				nx_state 				<= fail;
				ELSE
				nx_state 				<= once;
				END IF;
				
			WHEN once	=>
				hash						<= '0';
				mas_bloques				<= '0';
				activo_nonce			<= '0';
				inicio_transmision	<= '0';
				ena_num_ceros_comp	<= '0';
				syn_clr_contB	  		<= '0';
				ena_contB				<= '1';
				reset_all				<= '1';
				column_rd_addr			<= 0 ;
				ready						<= '0';
				new_msg_ready			<= '0';
				failed					<= '0';
				go 						<= '1';
				nx_state 				<= espera ;
				
			WHEN doce	=>
				hash						<= '0';
				mas_bloques				<= '0';
				activo_nonce			<= '0';
				inicio_transmision	<= '1';
				ena_num_ceros_comp	<= '0';
				syn_clr_contB	  		<= '1';
				ena_contB				<= '0';
				reset_all				<= '1';
				column_rd_addr			<= 0 ;
				ready						<= '0';
				new_msg_ready			<= '1';
				failed					<= '0';
				go 						<= '0';
				nx_state 				<= trece;
			
			WHEN fail	=>
				hash						<= '0';
				mas_bloques				<= '0';
				activo_nonce			<= '0';
				inicio_transmision	<= '1';
				ena_num_ceros_comp	<= '0';
				syn_clr_contB	  		<= '1';
				ena_contB				<= '0';
				reset_all				<= '1';
				column_rd_addr			<= 0 ;
				ready						<= '0';
				new_msg_ready			<= '1';
				failed					<= '1';
				go 						<= '0';
				nx_state 				<= trece;
			
			WHEN trece	=>
				hash						<= '0';
				mas_bloques				<= '0';
				activo_nonce			<= '0';
				inicio_transmision	<= '1';
				ena_num_ceros_comp	<= '0';
				syn_clr_contB	  		<= '1';
				ena_contB				<= '0';
				reset_all				<= '1';
				column_rd_addr			<= 0 ;
				ready						<= '0';
				new_msg_ready			<= '0';
				failed					<= '0';
				go 						<= '0';
				IF (fin_mensaje = '0') THEN
				nx_state 				<= uno;
				ELSIF (fin_mensaje = '1') THEN
				nx_state 				<= trece;
				END IF;

			END CASE;
		END IF;
	END PROCESS combinationalGLOBAL;
END ARCHITECTURE;