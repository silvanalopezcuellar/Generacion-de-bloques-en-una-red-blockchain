LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;  
USE ieee.numeric_std.all; 
use ieee.std_logic_signed .all ;
USE ieee.std_logic_1164.std_ulogic;

------------------------------------------------------
ENTITY mining_hardware IS

GENERIC	( 	  -- GENERIC funcion_hash

				  nonceL		   		: INTEGER	:= 32		;
				  
				  -- GENERIC generacion_nonce
				  
				  randL		   		: INTEGER	:= 12 		;
				  halfL  				: INTEGER	:= 6  	;  
				  sequL					: INTEGER	:= 20		;
				  twicL					: INTEGER	:= 24		;
				  
				  -- GENERIC comunicacion
				  
				  Convel    			: INTEGER  	:= 10416	;  
			     Nvel      			: INTEGER  	:= 14		;
				  Conceros				: INTEGER  	:= 16		; 
				  Nceros					: INTEGER  	:= 5		;
				  Confinal				: INTEGER  	:= 20832 ; 
				  Nfinal					: INTEGER  	:= 15		;
				  Conmitadvel 			: INTEGER  	:= 5205 	;  
				  Nmitadvel      		: INTEGER  	:= 13		;
				  Conbits     			: INTEGER  	:= 7		;	  
				  Nbits					: INTEGER  	:= 3		;
				  Con512     			: INTEGER  	:= 511	;  
				  N512					: INTEGER  	:= 9		;
				  Conblock    			: INTEGER  	:= 16		;	  
				  Nblock					: INTEGER  	:= 5		;
				  Contransmision		: INTEGER  	:= 10416	;  
				  Ntransmision			: INTEGER  	:= 14		;
				  Conbits2    			: INTEGER  	:= 380	;  
				  Nbits2					: INTEGER  	:= 9		;
				  Xmax 					: INTEGER	:= 511	;
				  Ymax 					: INTEGER	:= 16		;
				  MAX_WIDTH			   : INTEGER	:= 380   ;
				  Cont1     			: INTEGER	:= 100;
				  Cont2		         : INTEGER 	:= 9;
				  N1				      : INTEGER   := 10;
				  N2			      	: INTEGER   := 4;
				  Conad					: INTEGER	:= 100;
				  Nad						: INTEGER	:= 10);
				  
				  
	PORT		( clk								:	IN		STD_ULOGIC;
				  rst      						:	IN 	STD_ULOGIC;
				  Rx								:	IN		STD_ULOGIC;
				  Tx								:	OUT 	STD_ULOGIC;
				  clk_out 						:	OUT 	STD_ULOGIC
	           );
				  
END ENTITY mining_hardware;  
------------------------------------------------------
ARCHITECTURE mining_hardwareARCH OF mining_hardware IS 
------------------------------------------------------

SIGNAL column_rd_addr						:	INTEGER :=0;
SIGNAL row_rd_addr, 
		 bloques, contB, ceros_integer	: 	INTEGER;
SIGNAL iniciotransmision, fin_mensaje,
		 rst_all, digest_valid, ready,
		 comparar_ceros, ena_contB, 
		 ena_num_ceros_comp, rst_def,
		 syn_clr_contB, reset, leer_ok,
		 new_msg_ready, test	, rst_end, 
		 MaxTseq, failed, fail_s,
		 rst_comms, rst_others				:  STD_ULOGIC;
SIGNAL contB_ULOGIC							:  STD_ULOGIC_VECTOR (4 DOWNTO 0);
SIGNAL activo_nonce, nonce_valid  		:  STD_ULOGIC;
SIGNAL transmitir						      : 	STD_ULOGIC_VECTOR (255 DOWNTO 0);
SIGNAL semilla_x0								: 	STD_ULOGIC_VECTOR (randL-1 DOWNTO 0);
SIGNAL nonce									:	STD_ULOGIC_VECTOR(randL+sequL-1 DOWNTO 0);
SIGNAL hash										:  STD_ULOGIC:='0';
SIGNAL mas_bloques							:  STD_ULOGIC:='1';
SIGNAL msg_input								:  STD_ULOGIC_VECTOR(511 DOWNTO 0):= (OTHERS => '0');
SIGNAL nonce_input							:  STD_ULOGIC_VECTOR((nonceL-1) DOWNTO 0):= (OTHERS => '0');
SIGNAL output									:  STD_ULOGIC_VECTOR(255 DOWNTO 0);
SIGNAL transmitir_n							:	STD_ULOGIC_VECTOR (31 DOWNTO 0);
SIGNAL semillax0								:	STD_ULOGIC_VECTOR (randL-1 DOWNTO 0);
SIGNAL countd 									:  STD_ULOGIC_VECTOR(N2-1 DOWNTO 0); -- Count decenas
SIGNAL count									:	STD_ULOGIC_VECTOR(N2-1 DOWNTO 0); -- Count unidades
SIGNAL countp									:	STD_ULOGIC_VECTOR(N2-1 DOWNTO 0); -- Count decimales
SIGNAL finalByte								:	STD_ULOGIC_VECTOR(halfL-1 DOWNTO 0);
SIGNAL transmitir_t, tiempo_ok			:	STD_ULOGIC_VECTOR (15 DOWNTO 0);
SIGNAL digi00,digi0,digi1,digi2						   		:  STD_ULOGIC_VECTOR(N2-1 DOWNTO 0);
SIGNAL ena0, ena1, ena2, ena3, ena4 , ena5 					:  STD_ULOGIC:='0';
SIGNAL max_tick2, max_tick3										:	STD_ULOGIC:='0';
SIGNAL go											               :	STD_ULOGIC:='0';
SIGNAL go2											               :	STD_ULOGIC:='0';
SIGNAL enable													      :	STD_ULOGIC:='1';	


BEGIN
	
	
	clk_out						<= clk;
	contB 						<= TO_INTEGER(UNSIGNED(contB_ULOGIC));
		
	reset 						<= rst AND rst_all AND (NOT rst_end) AND rst_comms;
	rst_def 						<= rst AND (NOT rst_end);
	rst_others					<= rst AND (NOT rst_end) AND rst_comms;
	semillax0 					<= msg_input(479 DOWNTO (480 - halfL)) & finalByte;
	--semillax0 				<= (OTHERS => '0');
	

	
	------------------------------------------------------------ INSTANCIACION DE MODULOS DE CRONOMETRO
cuenta_tiempo: ENTITY work.tiempo 
	GENERIC MAP( Cont1		=> Cont1,
				  Cont2			=> Cont2,
				  N1				=> N1,
				  N2				=> N2,
				  Conad			=> Conad,
				  Nad				=> Nad)
				  
	PORT MAP	( clk				=> clk,
				  rst	      	=> rst_others,
				  enable			=> '1',
				  go				=> go2,
				  salidatiempo	=> tiempo_ok
				  );
				 
registro_go: ENTITY work.Reg_Go 
	PORT MAP	( clk						=> clk,
				  rst						=> rst_others,
				  fin_mensaje			=> fin_mensaje,
				  comparar_ceros		=> comparar_ceros,
				  go						=> go2
				  );
								
Module_RegistroNonce: ENTITY work.Reg_Nonce
	PORT MAP(     clk				     => clk,
					  rst				     => rst_others,
					  nonce			     => nonce,
					  tiempo_ok         => tiempo_ok,
					  cerosOK		     => comparar_ceros,
					  salida_nonce		  => transmitir_n,
					  salida_reg_tiempo => transmitir_t
					);						
---------------------------------------------------------------------------- INSTANCIACION DE MODULOS MINADO
	
	Module_funcion_hash: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonce,
					ready			=> ready,
					digest_valid=> digest_valid,
					leer_ok		=> leer_ok,
					output		=> transmitir
 				);

	Module_generacion_nonce: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL	)
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseq,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_valid,
					nonce				=> nonce
 				);

	Module_controlGLOBAL: ENTITY work.controlGLOBAL
	PORT MAP (	clk					=> clk,
					rst					=>	rst_others,
					leer_ok				=> leer_ok,
					fin_mensaje			=>	fin_mensaje,
					nonce_valid			=>	nonce_valid,
					digest_valid		=>	digest_valid,
					comparar_ceros		=>	comparar_ceros,
					MaxTseq				=> MaxTseq,
					bloques_cuenta		=>	bloques,
					contB					=>	contB,
					hash					=>	hash,
					mas_bloques			=>	mas_bloques,
					activo_nonce		=>	activo_nonce,
					inicio_transmision=>	iniciotransmision,
					ena_num_ceros_comp=>	ena_num_ceros_comp,
					syn_clr_contB		=>	syn_clr_contB,
					ena_contB			=>	ena_contB,
					reset_all			=>	rst_all,
					ready					=> ready,
					column_rd_addr		=>	column_rd_addr,
					new_msg_ready		=> new_msg_ready,
					failed				=> failed,
					test					=> test,
					go						=> go
 				);
				
	Module_Comparador_ceros: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> transmitir(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_ceros
					  );	
	
	Module_ContB : 	ENTITY work.cont_normal
	GENERIC MAP( Rstvalue       	=> 0,
					  Con       		=> 17,
					  N					=>	5)
	PORT	MAP( 	  clk				=> clk,
					  rst				=> rst_others,
					  syn_clr_cont	=> syn_clr_contB,
					  ena_cont		=> ena_contB,
					  salidacount  => contB_ULOGIC
					  );

----------------------------------------------------------------------------- INSTANCIACION DE MODULOS COMUNICACION
				
	Module_comunicacion: ENTITY work.comunicacion
	GENERIC MAP	( Convel    		   => Convel,  
					  Nvel      			=> Nvel,
				     Conceros				=> Conceros, 
				     Nceros					=> Nceros,
				     Confinal				=> Confinal, 
				     Nfinal					=> Nfinal,
				     Conmitadvel 			=> Conmitadvel, 
				     Nmitadvel      		=> Nmitadvel,
				     Conbits     			=> Conbits,  
				     Nbits					=> Nbits,
				     Con512     			=> Con512,  
				     N512					=> N512,
				     Conblock    			=> Conblock,  
				     Nblock					=> Nblock,
				     Contransmision		=> Contransmision, 
				     Ntransmision			=> Ntransmision,
				     Conbits2    			=> Conbits2,  
				     Nbits2					=> Nbits2,
				     Xmax 					=> Xmax,
				     Ymax 					=> Ymax,
				     MAX_WIDTH			   => MAX_WIDTH,
					  halfL					=> halfL)
	PORT MAP	(	  clk	        		   => clk,
					  rst	        	      => rst_def,
					  fail_s					=> fail_s,
					  new_msg_ready		=> new_msg_ready,
					  rx			   	   => Rx,
					  row_rd_addr		   => row_rd_addr,
					  column_rd_addr	   => column_rd_addr,
					  iniciotransmision	=> iniciotransmision,
					  transmitir         => transmitir,
					  transmitir_n			=> transmitir_n,
					  transmitir_t			=> transmitir_t,
					  tx						=> rst_end,
					  bloques_out			=> bloques,
					  fin_mensaje_out		=> fin_mensaje,
					  salidatr				=> Tx,
					  data_out				=> msg_input,
					  ceros_integer		=> ceros_integer,
					  finalByte				=> finalByte,
					  rst_comms				=>	rst_comms
					);
					  
	
	Module_salidatrans:	 ENTITY work.salida_tr
	PORT MAP	( clk						   => clk, 
				  rst						   => rst_others,  
				  failed					   => failed, 
				  fail_s						=> fail_s
				  );
				  
	
END ARCHITECTURE;