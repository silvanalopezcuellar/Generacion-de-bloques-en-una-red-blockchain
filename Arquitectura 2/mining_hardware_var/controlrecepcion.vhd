LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------
ENTITY controlrecepcion IS
	PORT		( clk	              		:	IN 	STD_ULOGIC;
				  rst	               	:	IN 	STD_ULOGIC;
				  rx							:	IN 	STD_ULOGIC;
				  new_msg_ready			:	IN		STD_ULOGIC;
				  contvelMaxTick     	:	IN 	STD_ULOGIC;
				  contcerosMaxTick		:	IN		STD_ULOGIC;
				  contfinalMaxTick		:	IN		STD_ULOGIC;
				  contmitadvelMaxTick	:	IN 	STD_ULOGIC;
				  contbitsMaxTick			:	IN 	STD_ULOGIC;
				  cont512MaxTick    		:	IN 	STD_ULOGIC;
				  contblockMaxTick		:	IN 	STD_ULOGIC;
				  countvel					:	IN		INTEGER := 0;
				  countnumceros			:	IN		INTEGER := 0;
				  countfinal				:	IN 	INTEGER := 0;
				  countmitadvel			:	IN		INTEGER := 0;
				  countbits					:	IN		INTEGER := 0;
				  countblock				:	IN		INTEGER := 0;
				  count512					:	IN		INTEGER := 0;
				  syn_clr_contvel 		:	OUT	STD_ULOGIC;
				  syn_clr_contceros		:	OUT	STD_ULOGIC;
				  syn_clr_contfinal		:	OUT   STD_ULOGIC;
				  syn_clr_contmitadvel 	:	OUT	STD_ULOGIC;
				  syn_clr_contbits 		:	OUT	STD_ULOGIC;
				  syn_clr_cont512    	:	OUT	STD_ULOGIC;
				  syn_clr_contblock 		:	OUT	STD_ULOGIC;
				  ena_contbits				:	OUT	STD_ULOGIC;
				  ena_contvel				:	OUT	STD_ULOGIC;
				  ena_contceros			:	OUT	STD_ULOGIC;
				  ena_contfinal			:	OUT   STD_ULOGIC;
				  ena_contmitadvel		:  OUT   STD_ULOGIC;
				  ena_cont512				:	OUT	STD_ULOGIC;
				  ena_contblock			:	OUT	STD_ULOGIC;
				  data_in					:	OUT	STD_ULOGIC;
				  wr_en		  		   	:	OUT	STD_ULOGIC;
				  num_ceros				   :	OUT   STD_ULOGIC;	
				  ena_num_ceros			:	OUT	STD_ULOGIC;
				  row_wr_addr 		   	:	OUT   INTEGER := 0;
				  column_wr_addr  		:	OUT   INTEGER := 0;
				  fin_mensaje				:	OUT	STD_ULOGIC;
				  bloques					:	OUT	INTEGER := 0;
				  rst_comms					:	OUT	STD_ULOGIC);
END ENTITY;
--------------------------------
ARCHITECTURE oneHot OF controlrecepcion IS

	TYPE state IS (uno, dos, tres, cuatro, cinco, seis, siete_mitad, siete, ocho, nueve, diez, once, doce);
	SIGNAL pr_state, nx_state	:	state;
BEGIN
	

	combinationalrx: PROCESS( rst, clk, pr_state, rx, contvelMaxTick, contmitadvelMaxTick, contbitsMaxTick, cont512MaxTick, contblockMaxTick, contfinalMaxTick, contcerosMaxTick, countfinal, countnumceros, countvel, countmitadvel, countbits, countblock, count512)
	BEGIN
	
	IF (rst = '0') THEN
			pr_state	<=	uno;
		ELSIF (rising_edge(clk)) THEN
		
		CASE pr_state IS
			WHEN uno	=>
			   syn_clr_contvel 		<= '1';
				syn_clr_contceros		<=	'1';
				syn_clr_contfinal		<= '1';
			   syn_clr_contmitadvel <= '1';
			   syn_clr_contbits 		<= '1';
			   syn_clr_cont512    	<= '1';
			   syn_clr_contblock 	<= '1';
			   ena_contbits			<= '0';
			   ena_contvel				<= '0';
				ena_contceros			<= '0';
				ena_contfinal			<= '0';
				ena_contmitadvel		<= '0';
			   ena_cont512				<= '0';
			   ena_contblock			<= '0';
			   data_in					<= '0';
			   wr_en		  		   	<= '0';
				num_ceros				<= '0';	
				ena_num_ceros			<= '0';
			   row_wr_addr 		   <= 0;
			   column_wr_addr  		<= 0;
				fin_mensaje				<= '0';
				bloques					<= 0;
				rst_comms				<= '1';			
				IF (rx = '1') THEN
				pr_state 			<= uno;
				ELSIF (rx = '0') THEN
				pr_state 			<= dos;
				END IF;
				
			WHEN dos	=>
				syn_clr_contvel 		<= '1';
				syn_clr_contceros		<=	'1';
				syn_clr_contfinal		<= '1';
			   syn_clr_contmitadvel <= '0';
			   syn_clr_contbits 		<= '1';
			   syn_clr_cont512    	<= '1';
			   syn_clr_contblock 	<= '1';
			   ena_contbits			<= '0';
			   ena_contvel				<= '0';
				ena_contmitadvel		<= '1';
			   ena_cont512				<= '0';
			   ena_contblock			<= '0';
			   data_in					<= '0';
			   wr_en		  		   	<= '0';
				num_ceros				<= '0';	
				ena_num_ceros			<= '0';
			   row_wr_addr 		   <= 0;
			   column_wr_addr  		<= 0;
				fin_mensaje				<= '0';
				bloques					<= 0;
				rst_comms				<= '0';			
				IF (contmitadvelMaxTick = '1') THEN
				pr_state 			<= tres;
				ELSIF (contmitadvelMaxTick = '0') THEN
				pr_state 			<= dos;
				END IF;
				
			WHEN tres	=>
				syn_clr_contvel 		<= '0';
				syn_clr_contceros		<=	'0';
				syn_clr_contfinal		<= '1';
			   syn_clr_contmitadvel <= '1';
			   syn_clr_contbits 		<= '0';
			   syn_clr_cont512    	<= '1';
			   syn_clr_contblock 	<= '1';
			   ena_contbits			<= '0';
			   ena_contvel				<= '1';
				ena_contceros			<= '0';
				ena_contfinal			<= '0';
				ena_contmitadvel		<= '0';
			   ena_cont512				<= '0';
			   ena_contblock			<= '0';
			   data_in					<= '0';
			   wr_en		  		   	<= '0';
				num_ceros				<= '0';	
				ena_num_ceros			<= '0';
			   row_wr_addr 		   <= count512;
			   column_wr_addr  		<= countblock;
				fin_mensaje				<= '0';
				rst_comms				<= '0';			
				IF (contvelMaxTick = '1') THEN
				pr_state 			<= cuatro;
				ELSIF (contvelMaxTick = '0') THEN
				pr_state 			<= tres;
				END IF;
				
			WHEN cuatro	=>
				syn_clr_contvel 		<= '1';
				syn_clr_contceros		<=	'0';
				syn_clr_contfinal		<= '1';
			   syn_clr_contmitadvel <= '1';
			   syn_clr_contbits 		<= '0';
			   syn_clr_cont512    	<= '1';
			   syn_clr_contblock 	<= '1';
			   ena_contbits			<= '1';
			   ena_contvel				<= '0';
				ena_contceros			<= '1';
				ena_contfinal			<= '0';
				ena_contmitadvel		<= '0';
			   ena_cont512				<= '0';
			   ena_contblock			<= '0';
			   data_in					<= '0';
			   wr_en		  		   	<= '0';
				num_ceros				<= rx;	
				ena_num_ceros			<= '1';
			   row_wr_addr 		   <= 0;
			   column_wr_addr  		<= 0;
				fin_mensaje				<= '0';
				rst_comms				<= '0';			
				IF (contbitsMaxTick = '1') THEN
				pr_state 			<= cinco;
				ELSIF (contbitsMaxTick = '0') THEN
				pr_state 			<= tres;
				END IF;
				
			
			WHEN cinco	=>
				syn_clr_contvel 		<= '0';
				syn_clr_contceros		<=	'0';
				syn_clr_contfinal		<= '1';
			   syn_clr_contmitadvel <= '1';
			   syn_clr_contbits 		<= '1';
			   syn_clr_cont512    	<= '1';
			   syn_clr_contblock 	<= '1';
			   ena_contbits			<= '0';
			   ena_contvel				<= '1';
				ena_contceros			<= '0';
				ena_contfinal			<= '0';
				ena_contmitadvel		<= '0';
			   ena_cont512				<= '0';
			   ena_contblock			<= '0';
			   data_in					<= '0';
			   wr_en		  		   	<= '0';
				num_ceros				<= rx;	
				ena_num_ceros			<= '0';
			   row_wr_addr 		   <= 0;
			   column_wr_addr  		<= 0;
				fin_mensaje				<= '0';
				rst_comms				<= '0';			
				IF (contvelMaxTick = '1') THEN
				pr_state 			<= seis;
				ELSIF (contvelMaxTick = '0') THEN
				pr_state 			<= cinco;
				END IF;
				
			WHEN seis	=>
			   syn_clr_contvel 		<= '1';
				syn_clr_contceros		<=	'0';
				syn_clr_contfinal		<= '1';
			   syn_clr_contmitadvel <= '1';
			   syn_clr_contbits 		<= '1';
			   syn_clr_cont512    	<= '1';
			   syn_clr_contblock 	<= '1';
			   ena_contbits			<= '0';
			   ena_contvel				<= '0';
				ena_contceros			<= '0';
				ena_contfinal			<= '0';
				ena_contmitadvel		<= '0';
			   ena_cont512				<= '0';
			   ena_contblock			<= '0';
			   data_in					<= '0';
			   wr_en		  		   	<= '0';
				num_ceros				<= rx;	
				ena_num_ceros			<= '0';
			   row_wr_addr 		   <= 0;
			   column_wr_addr  		<= 0;
				fin_mensaje				<= '0';
				rst_comms				<= '0';			
				IF (rx = '1') THEN
				pr_state 			<= seis;
				ELSIF ((rx = '0') AND (contcerosMaxTick = '0')) THEN
				pr_state 			<= tres;
				ELSIF ((rx = '0') AND (contcerosMaxTick = '1')) THEN
				pr_state 			<= siete_mitad;
				END IF;
				
			WHEN siete_mitad =>
				syn_clr_contvel 		<= '1';
				syn_clr_contceros		<=	'1';
				syn_clr_contfinal		<= '1';
			   syn_clr_contmitadvel <= '0';
			   syn_clr_contbits 		<= '0';
			   syn_clr_cont512    	<= '0';
			   syn_clr_contblock 	<= '0';
			   ena_contbits			<= '0';
			   ena_contvel				<= '0';
				ena_contceros			<= '0';
				ena_contfinal			<= '0';
				ena_contmitadvel		<= '1';
			   ena_cont512				<= '0';
			   ena_contblock			<= '0';
			   data_in					<= '0';
			   wr_en		  		   	<= '0';
				num_ceros				<= rx;	
				ena_num_ceros			<= '0';
			   row_wr_addr 		   <= count512;
			   column_wr_addr  		<= countblock;
				fin_mensaje				<= '0';
				rst_comms				<= '1';			
				IF (contmitadvelMaxTick = '1') THEN
				pr_state 			<= siete;
				ELSIF (contmitadvelMaxTick = '0') THEN
				pr_state 			<= siete_mitad;
				END IF;
				
				
			WHEN siete	=>
				syn_clr_contvel 		<= '0';
				syn_clr_contceros		<=	'1';
				syn_clr_contfinal		<= '1';
			   syn_clr_contmitadvel <= '1';
			   syn_clr_contbits 		<= '0';
			   syn_clr_cont512    	<= '0';
			   syn_clr_contblock 	<= '0';
			   ena_contbits			<= '0';
			   ena_contvel				<= '1';
				ena_contceros			<= '0';
				ena_contfinal			<= '0';
				ena_contmitadvel		<= '0';
			   ena_cont512				<= '0';
			   ena_contblock			<= '0';
			   data_in					<= '0';
			   wr_en		  		   	<= '0';
				num_ceros				<= rx;	
				ena_num_ceros			<= '0';
			   row_wr_addr 		   <= count512;
			   column_wr_addr  		<= countblock;
				fin_mensaje				<= '0';
				rst_comms				<= '1';			
				IF (contvelMaxTick = '1') THEN
				pr_state 			<= ocho;
				ELSIF (contvelMaxTick = '0') THEN
				pr_state 			<= siete;
				END IF;
				
			WHEN ocho	=>
				syn_clr_contvel 		<= '1';
				syn_clr_contceros		<=	'1';
				syn_clr_contfinal		<= '1';
			   syn_clr_contmitadvel <= '1';
			   syn_clr_contbits 		<= '0';
			   syn_clr_cont512    	<= '0';
			   syn_clr_contblock 	<= '0';
			   ena_contbits			<= '1';
			   ena_contvel				<= '0';
				ena_contceros			<= '0';
				ena_contfinal			<= '0';
				ena_contmitadvel		<= '0';
			   ena_cont512				<= '1';
			   ena_contblock			<= '0';
			   data_in					<= rx;
			   wr_en		  		   	<= '1';
				num_ceros				<= '0';	
				ena_num_ceros			<= '0';
			   row_wr_addr 		   <= count512;
			   column_wr_addr  		<= countblock;
				fin_mensaje				<= '0';
				rst_comms				<= '1';			
				IF (contbitsMaxTick = '1') THEN
				pr_state 			<= nueve;
				ELSIF (contbitsMaxTick = '0') THEN
				pr_state 			<= siete;
				END IF;
				
			WHEN nueve	=>
				syn_clr_contvel 		<= '1';
				syn_clr_contceros		<=	'1';
				syn_clr_contfinal		<= '1';
			   syn_clr_contmitadvel <= '1';
			   syn_clr_contbits 		<= '1';
			   syn_clr_cont512    	<= '0';
			   syn_clr_contblock 	<= '0';
			   ena_contbits			<= '0';
			   ena_contvel				<= '0';
				ena_contceros			<= '0';
				ena_contfinal			<= '0';
				ena_contmitadvel		<= '0';
			   ena_cont512				<= '0';
			   ena_contblock			<= cont512MaxTick;
			   data_in					<= rx;
			   wr_en		  		   	<= '0';
				num_ceros				<= '0';	
				ena_num_ceros			<= '0';
			   row_wr_addr 		   <= count512;
			   column_wr_addr  		<= countblock;
				fin_mensaje				<= '0';
				rst_comms				<= '1';			
				bloques					<= countblock;
				pr_state 				<= diez;
			
			WHEN diez	=>
				syn_clr_contvel 		<= '0';
				syn_clr_contceros		<=	'1';
				syn_clr_contfinal		<= '1';
			   syn_clr_contmitadvel <= '1';
			   syn_clr_contbits 		<= '1';
			   syn_clr_cont512    	<= '0';
			   syn_clr_contblock 	<= '0';
			   ena_contbits			<= '0';
			   ena_contvel				<= '1';
				ena_contceros			<= '0';
				ena_contfinal			<= '0';
				ena_contmitadvel		<= '0';
			   ena_cont512				<= '0';
			   ena_contblock			<= '0';
			   data_in					<= rx;
			   wr_en		  		   	<= '0';
				num_ceros				<= '0';	
				ena_num_ceros			<= '0';
			   row_wr_addr 		   <= count512;
			   column_wr_addr  		<= countblock;
				fin_mensaje				<= '0';
				rst_comms				<= '1';			
				IF (contvelMaxTick = '1') THEN
				pr_state 			   <= once;
				ELSIF (contvelMaxTick = '0') THEN
				pr_state 			   <= diez;
				END IF;
				
			WHEN once   =>
				syn_clr_contvel 		<= '1';
				syn_clr_contceros		<=	'1';
				syn_clr_contfinal		<= '0';
			   syn_clr_contmitadvel <= '1';
			   syn_clr_contbits 		<= '1';
			   syn_clr_cont512    	<= '0';
			   syn_clr_contblock 	<= '0';
			   ena_contbits			<= '0';
			   ena_contvel				<= '0';
				ena_contceros			<= '0';
				ena_contfinal			<= '1';
				ena_contmitadvel		<= '0';
			   ena_cont512				<= '0';
			   ena_contblock			<= '0';
			   data_in					<= '0';
			   wr_en		  		   	<= '0';
				num_ceros				<= '0';	
				ena_num_ceros			<= '0';
			   row_wr_addr 		   <= 0;
			   column_wr_addr  		<= 0;
				fin_mensaje				<= '0';
				rst_comms				<= '1';			
				IF ((rx = '1') AND (contfinalMaxTick = '0')) THEN
				pr_state 			<= once;
				ELSIF (rx = '0') THEN
				pr_state 			<= siete_mitad;
				ELSIF ((rx = '1') AND (contfinalMaxTick = '1')) THEN
				pr_state 			<= doce;
				END IF;
			
			WHEN doce	=>
				syn_clr_contvel 		<= '1';
				syn_clr_contceros		<=	'1';
				syn_clr_contfinal		<= '1';
				syn_clr_contmitadvel <= '1';
			   syn_clr_contbits 		<= '1';
			   syn_clr_cont512    	<= '0';
			   syn_clr_contblock 	<= '0';
			   ena_contbits			<= '0';
			   ena_contvel				<= '0';
				ena_contceros			<= '0';
				ena_contfinal			<= '0';
				ena_contmitadvel		<= '0';
			   ena_cont512				<= '0';
			   ena_contblock			<= '0';
			   data_in					<= '0';
			   wr_en		  		   	<= '0';
				num_ceros				<= '0';	
				ena_num_ceros			<= '0';
			   row_wr_addr 		   <= 0;
			   column_wr_addr  		<= 0;
				fin_mensaje				<= '1';
				bloques					<= countblock;
				rst_comms				<= '1';			
				IF (new_msg_ready='1') THEN
				pr_state 			   <= uno;
				ELSIF (new_msg_ready='0') THEN
				pr_state 			   <= doce;
				END IF;
												
		END CASE;
	  END IF;
	END PROCESS combinationalrx;
END ARCHITECTURE;