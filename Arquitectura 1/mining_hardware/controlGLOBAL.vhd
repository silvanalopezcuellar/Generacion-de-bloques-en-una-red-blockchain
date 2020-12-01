LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_1164.std_ulogic;

-------------------------------
ENTITY controlGLOBAL IS
	PORT		( clk	            	:	IN STD_ULOGIC;
				  rst	        	    	:	IN STD_ULOGIC;
				  leer_ok				:	IN	STD_ULOGIC;
				  fin_mensaje			:	IN	STD_ULOGIC;
				  nonce_valid			:	IN	STD_ULOGIC;
				  digest_valid			:  IN STD_ULOGIC;
				  comparar_ceros		:	IN	STD_ULOGIC;
				  MaxTseq				:	IN	STD_ULOGIC;
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
				  go						:	OUT STD_ULOGIC); 
END ENTITY;
--------------------------------
ARCHITECTURE controlglob OF controlGLOBAL IS
--------------------------------

	TYPE state IS (uno, dos, tres, espera, cuatro, cinco, seis, siete, ocho, nueve, no_leer, wait_comp, diez, once, doce, fail, trece);
	SIGNAL nx_state	:	state;
	SIGNAL contB_bloques_cuenta : STD_ULOGIC:='0';
	
BEGIN
	
	test <= contB_bloques_cuenta;
		CombinationalGLOBAL: PROCESS(rst, contB, bloques_cuenta, clk, contB_bloques_cuenta, MaxTseq, leer_ok, fin_mensaje, nonce_valid, digest_valid, comparar_ceros, bloques_cuenta, contB)
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
				IF (nonce_valid = '0') THEN
				nx_state 				<= cuatro;
				ELSIF (nonce_valid = '1') THEN
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
				IF (digest_valid = '0') THEN
				nx_state 				<= seis;
				ELSIF (digest_valid = '1') THEN
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
				IF (leer_ok = '0') THEN
				nx_state 				<=  no_leer;
				ELSIF (leer_ok = '1') THEN
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
				IF ( comparar_ceros = '1' ) THEN
				nx_state 				<= doce;				
				ELSIF ( MaxTseq = '1') THEN
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