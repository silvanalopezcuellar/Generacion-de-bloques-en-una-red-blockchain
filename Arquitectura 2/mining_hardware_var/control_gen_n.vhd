LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_1164.std_ulogic;

-------------------------------
ENTITY control_gen_n IS
	PORT		( clk	            	:	IN STD_ULOGIC;
				  rst	        	    	:	IN STD_ULOGIC;
				  activo_nonce			:	IN	STD_ULOGIC;
				  contingencia			:	IN	STD_ULOGIC;
				  maxtickseed			:  IN STD_ULOGIC;
				  mult_control			:	IN	STD_ULOGIC;
				  control_regsem		:	OUT STD_ULOGIC_VECTOR(1 DOWNTO 0);
				  control_cuadradosm	:  OUT STD_ULOGIC;
				  control_nbluid		:	OUT STD_ULOGIC;
				  control_mult			:	OUT STD_ULOGIC;
				  ena_contseq			:	OUT STD_ULOGIC;
				  syn_clr_contseq	   :	OUT STD_ULOGIC;
				  syn_clr_contseed	:	OUT STD_ULOGIC;
				  ena_contseed		   :	OUT STD_ULOGIC;
				  nonce_valid			:	OUT STD_ULOGIC
				  ); 
END ENTITY;
--------------------------------
ARCHITECTURE controlgenn OF control_gen_n IS
--------------------------------
	--SIGNAL							:	INTEGER:=0;
	--SIGNAL							:	STD_ULOGIC_VECTOR(2 DOWNTO 0);


	TYPE state IS (cero, uno, dos, espera, tres, cuatro, cinco, seis, siete, ocho, nueve);
	SIGNAL nx_state	:	state;
	
BEGIN

	
		Combinationalnonc: PROCESS(rst, clk, activo_nonce, contingencia, nx_state, mult_control)
	BEGIN
		IF (rst = '0') THEN
		
			nx_state	<=	cero;
		
		ELSIF (rising_edge(clk)) THEN

			CASE nx_state IS
			
			WHEN cero =>
				control_regsem			<= "00";
				control_cuadradosm	<= '0';
				control_nbluid			<= '0';
				control_mult			<= '0';
				ena_contseq		   	<= '0';
			   syn_clr_contseq		<= '1';
				ena_contseed	   	<= '0';
			   syn_clr_contseed		<= '1';
				nonce_valid				<= '0';
				IF (activo_nonce = '0') THEN
				nx_state 				<= cero;
				ELSIF (activo_nonce = '1') THEN
				nx_state 				<= uno;
				END IF;
				
			WHEN uno =>
				control_regsem			<= "01";
				control_cuadradosm	<= '0';
				control_nbluid			<= '0';
				control_mult			<= '0';
				ena_contseq		   	<= '0';
			   syn_clr_contseq		<= '0';
				ena_contseed	   	<= '0';
			   syn_clr_contseed		<= '0';
				nonce_valid				<= '0';
				nx_state 				<= espera;
			
			WHEN espera =>
				control_regsem			<= "00";
				control_cuadradosm	<= '0';
				control_nbluid			<= '0';
				control_mult			<= '0';
				ena_contseq		   	<= '1';
			   syn_clr_contseq		<= '0';
				ena_contseed	   	<= '1';
			   syn_clr_contseed		<= '0';
				nonce_valid				<= '0';
				nx_state 				<= dos;
			
			WHEN dos =>
				control_regsem			<= "00";
				control_cuadradosm	<= '0';
				control_nbluid			<= '0';
				control_mult			<= '1';
				ena_contseq		   	<= '0';
			   syn_clr_contseq	  	<= '0';
				ena_contseed	   	<= '0';
			   syn_clr_contseed		<= '0';
				nonce_valid				<= '0';
				IF (mult_control = '0') THEN
				nx_state 				<= dos;
				ELSIF (mult_control = '1') THEN
				nx_state 				<= tres;
				END IF;
			
			WHEN tres =>
				control_regsem			<= "00";
				control_cuadradosm	<= '1';
				control_nbluid			<= '0';
				control_mult			<= '1';
				ena_contseq		   	<= '0';
			   syn_clr_contseq		<= '0';
				ena_contseed	   	<= '0';
			   syn_clr_contseed		<= '0';
				nonce_valid				<= '0';
				nx_state 				<= cuatro;
				
			WHEN cuatro	=>
				control_regsem			<= "00";
				control_cuadradosm	<= '1';
				control_nbluid			<= '0';
				control_mult			<= '1';
				ena_contseq		   	<= '0';
			   syn_clr_contseq		<= '0';
				ena_contseed	   	<= '0';
			   syn_clr_contseed		<= '0';
				nonce_valid				<= '0';
				nx_state 				<= cinco;
				
			WHEN cinco	=>
				control_regsem			<= "00";
				control_cuadradosm	<= '0';
				control_nbluid			<= '0';
				control_mult			<= '0';
				ena_contseq		   	<= '0';
			   syn_clr_contseq		<= '0';
				ena_contseed	   	<= '0';
			   syn_clr_contseed		<= '0';
				nonce_valid				<= '0';
				nx_state 				<= seis;
				
			WHEN seis	=>
				control_regsem			<= "00";
				control_cuadradosm	<= '0';
				control_nbluid			<= '1';
				control_mult			<= '0';
				ena_contseq		   	<= '0';
			    syn_clr_contseq		<= '0';
				ena_contseed	   	<= '0';
			   syn_clr_contseed		<= '0';
				nonce_valid				<= '0';
				nx_state 				<= siete;
				
			WHEN siete	=>
				control_regsem			<= "00";
				control_cuadradosm	<= '0';
				control_nbluid			<= '0';
				control_mult			<= '0';
				ena_contseq		   	<= '0';
			   syn_clr_contseq		<= '0';
				ena_contseed	   	<= '0';
			   syn_clr_contseed		<= '0';
				nonce_valid				<= '1';
				IF ( activo_nonce = '0') THEN
				nx_state 				<= siete;
				ELSIF (contingencia = '0' AND maxtickseed = '0') THEN
				nx_state 				<= ocho;
				ELSIF (contingencia = '1' OR maxtickseed = '1') THEN
				nx_state 				<= nueve;
				END IF;
				
			WHEN ocho	=>
				control_regsem			<= "10";
				control_cuadradosm	<= '0';
				control_nbluid			<= '0';
				control_mult			<= '0';
				ena_contseq		   	<= '0';
			   syn_clr_contseq		<= '0';
				ena_contseed	   	<= '0';
			   syn_clr_contseed		<= '0';
				nx_state 				<= espera;
			
			WHEN nueve	=>
				control_regsem			<= "11";
				control_cuadradosm	<= '0';
				control_nbluid			<= '0';
				control_mult			<= '0';
				ena_contseq		   	<= '0';
			   syn_clr_contseq		<= '0';
				ena_contseed	   	<= '0';
			   syn_clr_contseed		<= '1';
				nx_state 				<= espera;

			END CASE;
		END IF;
	END PROCESS combinationalnonc;
END ARCHITECTURE;