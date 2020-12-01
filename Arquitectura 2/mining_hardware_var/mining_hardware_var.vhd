LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;  
USE ieee.numeric_std.all; 
use ieee.std_logic_signed .all ;
USE ieee.std_logic_1164.std_ulogic;

------------------------------------------------------
ENTITY mining_hardware_var IS

GENERIC	( 	  -- GENERIC funcion_hash

				  nonceL		   		: INTEGER	:= 32		;
				  
				  -- GENERIC generacion_nonce
				  
				  randL		   		: INTEGER	:= 12 	;
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
				  MAX_WIDTH			   : INTEGER	:= 380	;
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
				  
END ENTITY mining_hardware_var;  
------------------------------------------------------
ARCHITECTURE mining_hardware_varARCH OF mining_hardware_var IS 
------------------------------------------------------

SIGNAL column_rd_addr						:	INTEGER :=0;
SIGNAL row_rd_addr, 
		 bloques, contB, ceros_integer	: 	INTEGER;
SIGNAL iniciotransmision, fin_mensaje,
		 rst_all, ready, activo_nonce,
		 comparar_ceros0, comparar_ceros1, 
		 comparar_ceros2, comparar_ceros3,
		 comparar_ceros4, comparar_ceros5,
		 comparar_ceros6, comparar_ceros7,
		 comparar_ceros8, comparar_ceros9,
		 comparar_cerosA, comparar_cerosB,
		 comparar_cerosC, comparar_cerosD,
		 comparar_cerosE, comparar_cerosF,
		 ena_num_ceros_comp, rst_def,
		 syn_clr_contB, reset, ena_contB,
		 new_msg_ready, test	, rst_end, 
		 MaxTseq0, MaxTseq1, MaxTseq2,
		 MaxTseq3, MaxTseq4, MaxTseq5,
		 MaxTseq6, MaxTseq7, MaxTseq8,
		 MaxTseq9, MaxTseqA, MaxTseqB,
		 MaxTseqC, MaxTseqD, MaxTseqE,
		 MaxTseqF, failed, 
		 fail_s, leer_ok0, leer_ok1, 
		 leer_ok2, leer_ok3, leer_ok4,
		 leer_ok5, leer_ok6, leer_ok7,
		 leer_ok8, leer_ok9, leer_okA, 
		 leer_okB, leer_okC, leer_okD,
		 leer_okE, leer_okF,
		 digest_valid0, digest_valid1,
		 digest_valid2, digest_valid3, 
		 digest_valid4, digest_valid5,
		 digest_valid6, digest_valid7,
		 digest_valid8, digest_valid9,
		 digest_validA, digest_validB,
		 digest_validC, digest_validD,
		 digest_validE, digest_validF,
		 nonce_valid0, nonce_valid1, 
		 nonce_valid2, nonce_valid3, 
		 nonce_valid4, nonce_valid5, 
		 nonce_valid6, nonce_valid7,
		 nonce_valid8, nonce_valid9, 
		 nonce_validA, nonce_validB,
		 nonce_validC, nonce_validD,
		 nonce_validE, nonce_validF,
		 comparar_ceros_tot, rst_comms,
		 rst_others								:  STD_ULOGIC;
SIGNAL contB_ULOGIC							:  STD_ULOGIC_VECTOR (4 DOWNTO 0);
SIGNAL ceros_ok_out							:  STD_ULOGIC_VECTOR (15 DOWNTO 0);
SIGNAL transmitir						      : 	STD_ULOGIC_VECTOR (255 DOWNTO 0);
SIGNAL semilla_x0								: 	STD_ULOGIC_VECTOR (randL-1 DOWNTO 0);
SIGNAL nonce0, nonce1, nonce2, nonce3, 
		 nonce4, nonce5, nonce6, nonce7,
		 nonce8, nonce9, nonceA, nonceB, 
		 nonceC, nonceD, nonceE, nonceF	:	STD_ULOGIC_VECTOR(randL+sequL-1 DOWNTO 0);
SIGNAL hash										:  STD_ULOGIC:='0';
SIGNAL mas_bloques							:  STD_ULOGIC:='1';
SIGNAL msg_input								:  STD_ULOGIC_VECTOR(511 DOWNTO 0):= (OTHERS => '0');
SIGNAL nonce_input							:  STD_ULOGIC_VECTOR((nonceL-1) DOWNTO 0):= (OTHERS => '0');
SIGNAL output0, output1, output2, 
		 output3, output4, output5,
		 output6, output7, output8, 
		 output9, outputA, outputB, 
		 outputC, outputD, outputE, 
		 outputF									:  STD_ULOGIC_VECTOR(255 DOWNTO 0);
SIGNAL transmitir_n							:	STD_ULOGIC_VECTOR (31 DOWNTO 0);
SIGNAL transmitir_t, tiempo_ok			:	STD_ULOGIC_VECTOR (15 DOWNTO 0):= (OTHERS => '0');
SIGNAL semillax0								:	STD_ULOGIC_VECTOR (randL-1 DOWNTO 0);
SIGNAL countd 									:  STD_ULOGIC_VECTOR(N2-1 DOWNTO 0); -- Count decenas
SIGNAL count									:	STD_ULOGIC_VECTOR(N2-1 DOWNTO 0); -- Count unidades
SIGNAL countp									:	STD_ULOGIC_VECTOR(N2-1 DOWNTO 0); -- Count decimales
SIGNAL finalByte								:	STD_ULOGIC_VECTOR(halfL-1 DOWNTO 0);
SIGNAL digi00,digi0,digi1,digi2						   				:  STD_ULOGIC_VECTOR(N2-1 DOWNTO 0);
SIGNAL ena0, ena1, ena2, ena3, ena4 , ena5, enable_salida		:  STD_ULOGIC;
SIGNAL max_tick2, max_tick3												:	STD_ULOGIC;
SIGNAL go											               		:	STD_ULOGIC:='0';
SIGNAL go2											               		:	STD_ULOGIC:='0';
SIGNAL enable													      		:	STD_ULOGIC:='1';	

BEGIN
	
	
	comparar_ceros_tot		<= comparar_ceros0 OR comparar_ceros1 OR comparar_ceros2 OR comparar_ceros3 OR 
										comparar_ceros4 OR comparar_ceros5 OR comparar_ceros6 OR comparar_ceros7 OR 
										comparar_ceros8 OR comparar_ceros9 OR comparar_cerosA OR comparar_cerosB OR 
										comparar_cerosC OR comparar_cerosD OR comparar_cerosE OR comparar_cerosF;
	contB 						<= TO_INTEGER(UNSIGNED(contB_ULOGIC));
	clk_out						<= clk;
	
	reset 						<= rst AND rst_all AND (NOT rst_end) AND rst_comms;
	rst_def 						<= rst AND (NOT rst_end);
	rst_others					<= rst AND (NOT rst_end) AND rst_comms;
	
	semillax0 					<= msg_input(495 DOWNTO (496 - halfL)) & finalByte;
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
				  comparar_ceros		=> comparar_ceros_tot,
				  go						=> go2
				  );

Module_RegistroTiempo: ENTITY work.Reg_t
	PORT MAP(     clk				     => clk,
					  rst				     => rst_def,
					  tiempo_ok         => tiempo_ok,
					  cerosOK		     => comparar_ceros_tot,
					  salida_reg_tiempo => transmitir_t
					);
								
---------------------------------------------------------------------------- INSTANCIACION DE MODULOS MINADO
	Module_controlGLOBAL: ENTITY work.controlGLOBAL
	PORT MAP (	clk					=> clk,
					rst					=>	rst_others,
					leer_ok0				=> leer_ok0,
					leer_ok1				=> leer_ok1,
					leer_ok2				=> leer_ok2,
					leer_ok3				=> leer_ok3,
					leer_ok4				=> leer_ok4,
					leer_ok5				=> leer_ok5,
					leer_ok6				=> leer_ok6,
					leer_ok7				=> leer_ok7,
					leer_ok8				=> leer_ok8,
					leer_ok9				=> leer_ok9,
					leer_okA				=> leer_okA,
					leer_okB				=> leer_okB,
					leer_okC				=> leer_okC,
					leer_okD				=> leer_okD,
					leer_okE				=> leer_okE,
					leer_okF				=> leer_okF,
					fin_mensaje			=>	fin_mensaje,
					nonce_valid0		=>	nonce_valid0,
					nonce_valid1		=>	nonce_valid1,
					nonce_valid2		=>	nonce_valid2,
					nonce_valid3		=>	nonce_valid3,
					nonce_valid4		=>	nonce_valid4,
					nonce_valid5		=>	nonce_valid5,
					nonce_valid6		=>	nonce_valid6,
					nonce_valid7		=>	nonce_valid7,
					nonce_valid8		=>	nonce_valid8,
					nonce_valid9		=>	nonce_valid9,
					nonce_validA		=>	nonce_validA,
					nonce_validB		=>	nonce_validB,
					nonce_validC		=>	nonce_validC,
					nonce_validD		=>	nonce_validD,
					nonce_validE		=>	nonce_validE,
					nonce_validF		=>	nonce_validF,
					digest_valid0		=>	digest_valid0,
					digest_valid1		=>	digest_valid1,
					digest_valid2		=>	digest_valid2,
					digest_valid3		=>	digest_valid3,
					digest_valid4		=>	digest_valid4,
					digest_valid5		=>	digest_valid5,
					digest_valid6		=>	digest_valid6,
					digest_valid7		=>	digest_valid7,
					digest_valid8		=>	digest_valid8,
					digest_valid9		=>	digest_valid9,
					digest_validA		=>	digest_validA,
					digest_validB		=>	digest_validB,
					digest_validC		=>	digest_validC,
					digest_validD		=>	digest_validD,
					digest_validE		=>	digest_validE,
					digest_validF		=>	digest_validF,
					comparar_ceros0	=>	comparar_ceros0,
					comparar_ceros1	=>	comparar_ceros1,
					comparar_ceros2	=>	comparar_ceros2,
					comparar_ceros3	=>	comparar_ceros3,
					comparar_ceros4	=>	comparar_ceros4,
					comparar_ceros5	=>	comparar_ceros5,
					comparar_ceros6	=>	comparar_ceros6,
					comparar_ceros7	=>	comparar_ceros7,
					comparar_ceros8	=>	comparar_ceros8,
					comparar_ceros9	=>	comparar_ceros9,
					comparar_cerosA	=>	comparar_cerosA,
					comparar_cerosB	=>	comparar_cerosB,
					comparar_cerosC	=>	comparar_cerosC,
					comparar_cerosD	=>	comparar_cerosD,
					comparar_cerosE	=>	comparar_cerosE,
					comparar_cerosF	=>	comparar_cerosF,
					MaxTseq0				=> MaxTseq0,
					MaxTseq1				=> MaxTseq1,
					MaxTseq2				=> MaxTseq2,
					MaxTseq3				=> MaxTseq3,
					MaxTseq4				=> MaxTseq4,
					MaxTseq5				=> MaxTseq5,
					MaxTseq6				=> MaxTseq6,
					MaxTseq7				=> MaxTseq7,
					MaxTseq8				=> MaxTseq8,
					MaxTseq9				=> MaxTseq9,
					MaxTseqA				=> MaxTseqA,
					MaxTseqB				=> MaxTseqB,
					MaxTseqC				=> MaxTseqC,
					MaxTseqD				=> MaxTseqD,
					MaxTseqE				=> MaxTseqE,
					MaxTseqF				=> MaxTseqF,
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
					  
	Module_salida_output: ENTITY work.Output_sel
 	GENERIC MAP  ( BitsNonce		=> nonceL)   
	PORT	MAP( clk						=> clk,			
				  rst						=> rst_def,
				  ceros_ok(0)			=> ceros_ok_out(0),
				  ceros_ok(1)			=> ceros_ok_out(1),
				  ceros_ok(2)			=> ceros_ok_out(2),
				  ceros_ok(3)			=> ceros_ok_out(3),
				  ceros_ok(4)			=> ceros_ok_out(4),
				  ceros_ok(5)			=> ceros_ok_out(5),
				  ceros_ok(6)			=> ceros_ok_out(6),
				  ceros_ok(7)			=> ceros_ok_out(7),
				  ceros_ok(8)			=> ceros_ok_out(8),
				  ceros_ok(9)			=> ceros_ok_out(9),
				  ceros_ok(10)			=> ceros_ok_out(10),
				  ceros_ok(11)			=> ceros_ok_out(11),
				  ceros_ok(12)			=> ceros_ok_out(12),
				  ceros_ok(13)			=> ceros_ok_out(13),
				  ceros_ok(14)			=> ceros_ok_out(14),
				  ceros_ok(15)			=> ceros_ok_out(15),
				  enable					=> enable_salida,
				  output0				=> output0,
				  output1				=> output1,
				  output2				=> output2,
				  output3				=> output3,
				  output4				=> output4,
				  output5				=> output5,
				  output6				=> output6,
				  output7				=> output7,
				  output8				=> output8,
				  output9				=> output9,
				  outputA				=> outputA,
				  outputB				=> outputB,
				  outputC				=> outputC,
				  outputD				=> outputD,
				  outputE				=> outputE,
				  outputF				=> outputF,
				  nonce0					=> nonce0,
				  nonce1					=> nonce1,
				  nonce2					=> nonce2,
				  nonce3					=> nonce3,
				  nonce4					=> nonce4,
				  nonce5					=> nonce5,
				  nonce6					=> nonce6,
				  nonce7					=> nonce7,
				  nonce8					=> nonce8,
				  nonce9					=> nonce9,
				  nonceA					=> nonceA,
				  nonceB					=> nonceB,
				  nonceC					=> nonceC,
				  nonceD					=> nonceD,
				  nonceE					=> nonceE,
				  nonceF					=> nonceF,
				  salida_final(287 DOWNTO 32)			=> transmitir,
				  salida_final(31 DOWNTO 0)			=> transmitir_n  );
				
	Module_out_select: ENTITY work.out_select
	PORT MAP ( clk				      => clk,
				  rst				 		=> rst_def,
				  comparar_ceros(0)	=> comparar_cerosF,
				  comparar_ceros(1)	=> comparar_cerosE,
				  comparar_ceros(2)	=> comparar_cerosD,
				  comparar_ceros(3)	=> comparar_cerosC,
				  comparar_ceros(4)	=> comparar_cerosB,
				  comparar_ceros(5)	=> comparar_cerosA,
				  comparar_ceros(6)	=> comparar_ceros9,
				  comparar_ceros(7)	=> comparar_ceros8,
				  comparar_ceros(8)	=> comparar_ceros7,
				  comparar_ceros(9)	=> comparar_ceros6,
				  comparar_ceros(10)	=> comparar_ceros5,
				  comparar_ceros(11)	=> comparar_ceros4,
				  comparar_ceros(12)	=> comparar_ceros3,
				  comparar_ceros(13)	=> comparar_ceros2,
				  comparar_ceros(14)	=> comparar_ceros1,
				  comparar_ceros(15)	=> comparar_ceros0,
				  enable					=> enable_salida,
				  ceros_ok				=> ceros_ok_out);
	
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
					  rst_comms				=> rst_comms
					);
					  
	Module_salidatrans:	 ENTITY work.salida_tr
	PORT MAP	( clk						   => clk, 
				  rst						   => rst_def,  
				  failed					   => failed, 
				  fail_s						=> fail_s
				  );

------------------------------------------------------------------------- MODULOS DUPLICADOS 
--------------------------------------------------------------------0	 
	Module_funcion_hash0: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonce0,
					ready			=> ready,
					digest_valid=> digest_valid0,
					leer_ok		=> leer_ok0,
					output		=> output0
 				);

	Module_generacion_nonce0: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL,
						seqRST		=> 0,
						LimSEQ		=> (2**sequL)/ 16)
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseq0,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_valid0,
					nonce				=> nonce0
 				);
				
	Module_Comparador_ceros0: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> output0(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_ceros0
					  );	
					  
--------------------------------------------------------------------1
	Module_funcion_hash1: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonce1,
					ready			=> ready,
					digest_valid=> digest_valid1,
					leer_ok		=> leer_ok1,
					output		=> output1
 				);

	Module_generacion_nonce1: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL,
						seqRST		=> (2**sequL)/ 16,
						LimSEQ		=> ((2**sequL)/ 16)*2)
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseq1,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_valid1,
					nonce				=> nonce1
 				);
	
	Module_Comparador_ceros1: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> output1(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_ceros1
					  );	
				
--------------------------------------------------------------------2
	Module_funcion_hash2: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonce2,
					ready			=> ready,
					digest_valid=> digest_valid2,
					leer_ok		=> leer_ok2,
					output		=> output2
 				);

	Module_generacion_nonce2: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL,
						seqRST		=> ((2**sequL)/ 16)*2,
						LimSEQ		=> ((2**sequL)/ 16)*3)
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseq2,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_valid2,
					nonce				=> nonce2
 				);				
				
	Module_Comparador_ceros2: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> output2(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_ceros2
					  );	
	
--------------------------------------------------------------------3
	Module_funcion_hash3: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonce3,
					ready			=> ready,
					digest_valid=> digest_valid3,
					leer_ok		=> leer_ok3,
					output		=> output3
 				);

	Module_generacion_nonce3: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL,
						seqRST		=> ((2**sequL)/ 16)*3,
						LimSEQ		=> ((2**sequL)/ 16)*4	)
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseq3,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_valid3,
					nonce				=> nonce3
 				);
				
	Module_Comparador_ceros3: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> output3(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_ceros3
					  );	
	
--------------------------------------------------------------------4
				
	Module_funcion_hash4: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonce4,
					ready			=> ready,
					digest_valid=> digest_valid4,
					leer_ok		=> leer_ok4,
					output		=> output4
 				);

	Module_generacion_nonce4: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL,
						seqRST		=> ((2**sequL)/ 16)*4,
						LimSEQ		=> ((2**sequL)/ 16)*5 	)
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseq4,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_valid4,
					nonce				=> nonce4
 				);
	
	Module_Comparador_ceros4: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> output4(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_ceros4
					  );	
				
--------------------------------------------------------------------5
	Module_funcion_hash5: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonce5,
					ready			=> ready,
					digest_valid=> digest_valid5,
					leer_ok		=> leer_ok5,
					output		=> output5
 				);

	Module_generacion_nonce5: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL,
						seqRST		=> ((2**sequL)/ 16)*5,
						LimSEQ		=> ((2**sequL)/ 16)*6 )
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseq5,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_valid5,
					nonce				=> nonce5
 				);
				
	Module_Comparador_ceros5: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> output5(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_ceros5
					  );	
	
--------------------------------------------------------------------6				
	Module_funcion_hash6: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonce6,
					ready			=> ready,
					digest_valid=> digest_valid6,
					leer_ok		=> leer_ok6,
					output		=> output6
 				);

	Module_generacion_nonce6: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL,
						seqRST		=> ((2**sequL)/ 16)*6,
						LimSEQ		=> ((2**sequL)/ 16)*7)
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseq6,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_valid6,
					nonce				=> nonce6
 				);
				
	Module_Comparador_ceros6: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> output6(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_ceros6
					  );	
	
--------------------------------------------------------------------7
				
	Module_funcion_hash7: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonce7,
					ready			=> ready,
					digest_valid=> digest_valid7,
					leer_ok		=> leer_ok7,
					output		=> output7
 				);

	Module_generacion_nonce7: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL,
						seqRST		=> ((2**sequL)/ 16)*7,
						LimSEQ		=> ((2**sequL)/ 16)*8 )
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseq7,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_valid7,
					nonce				=> nonce7
 				);
	
	Module_Comparador_ceros7: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> output7(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_ceros7
					  );

--------------------------------------------------------------------8	 
	Module_funcion_hash8: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonce8,
					ready			=> ready,
					digest_valid=> digest_valid8,
					leer_ok		=> leer_ok8,
					output		=> output8
 				);

	Module_generacion_nonce8: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL,
						seqRST		=> ((2**sequL)/ 16)*8,
						LimSEQ		=> ((2**sequL)/ 16)*9)
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseq8,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_valid8,
					nonce				=> nonce8
 				);
				
	Module_Comparador_ceros8: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> output8(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_ceros8
					  );	
					  
--------------------------------------------------------------------9
	Module_funcion_hash9: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonce9,
					ready			=> ready,
					digest_valid=> digest_valid9,
					leer_ok		=> leer_ok9,
					output		=> output9
 				);

	Module_generacion_nonce9: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL,
						seqRST		=> ((2**sequL)/ 16)*9,
						LimSEQ		=> ((2**sequL)/ 16)*10)
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseq9,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_valid9,
					nonce				=> nonce9
 				);
	
	Module_Comparador_ceros9: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> output9(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_ceros9
					  );	
				
--------------------------------------------------------------------A
	Module_funcion_hashA: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonceA,
					ready			=> ready,
					digest_valid=> digest_validA,
					leer_ok		=> leer_okA,
					output		=> outputA
 				);

	Module_generacion_nonceA: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL,
						seqRST		=> ((2**sequL)/ 16)*10,
						LimSEQ		=> ((2**sequL)/ 16)*11)
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseqA,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_validA,
					nonce				=> nonceA
 				);				
				
	Module_Comparador_cerosA: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> outputA(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_cerosA
					  );	
	
--------------------------------------------------------------------B
	Module_funcion_hashB: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonceB,
					ready			=> ready,
					digest_valid=> digest_validB,
					leer_ok		=> leer_okB,
					output		=> outputB
 				);

	Module_generacion_nonceB: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL,
						seqRST		=> ((2**sequL)/ 16)*11,
						LimSEQ		=> ((2**sequL)/ 16)*12	)
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseqB,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_validB,
					nonce				=> nonceB
 				);
				
	Module_Comparador_cerosB: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> outputB(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_cerosB
					  );	
	
--------------------------------------------------------------------C
				
	Module_funcion_hashC: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonceC,
					ready			=> ready,
					digest_valid=> digest_validC,
					leer_ok		=> leer_okC,
					output		=> outputC
 				);

	Module_generacion_nonceC: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL,
						seqRST		=> ((2**sequL)/ 16)*12,
						LimSEQ		=> ((2**sequL)/ 16)*13 	)
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseqC,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_validC,
					nonce				=> nonceC
 				);
	
	Module_Comparador_cerosC: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> outputC(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_cerosC
					  );	
				
--------------------------------------------------------------------D
	Module_funcion_hashD: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonceD,
					ready			=> ready,
					digest_valid=> digest_validD,
					leer_ok		=> leer_okD,
					output		=> outputD
 				);

	Module_generacion_nonceD: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL,
						seqRST		=> ((2**sequL)/ 16)*13,
						LimSEQ		=> ((2**sequL)/ 16)*14 )
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseqD,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_validD,
					nonce				=> nonceD
 				);
				
	Module_Comparador_cerosD: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> outputD(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_cerosD
					  );	
	
--------------------------------------------------------------------E				
	Module_funcion_hashE: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonceE,
					ready			=> ready,
					digest_valid=> digest_validE,
					leer_ok		=> leer_okE,
					output		=> outputE
 				);

	Module_generacion_nonceE: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL,
						seqRST		=> ((2**sequL)/ 16)*14,
						LimSEQ		=> ((2**sequL)/ 16)*15)
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseqE,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_validE,
					nonce				=> nonceE
 				);
				
	Module_Comparador_cerosE: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> outputE(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_cerosE
					  );	
	
--------------------------------------------------------------------F
				
	Module_funcion_hashF: ENTITY work.funcion_hash
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					hash			=> hash,
					mas_bloques => mas_bloques,
					msg_input	=> msg_input,
					nonce_input	=> nonceF,
					ready			=> ready,
					digest_valid=> digest_validF,
					leer_ok		=> leer_okF,
					output		=> outputF
 				);

	Module_generacion_nonceF: ENTITY work.generacion_nonce
	GENERIC	MAP( 	randL			=> randL,
						halfL			=> halfL,
						sequL			=> sequL,
						twicL			=> twicL,
						seqRST		=> ((2**sequL)/ 16)*15,
						LimSEQ		=> 2**sequL )
	PORT MAP (	clk				=> clk,
					rst				=>	reset,
					MaxTseq			=> MaxTseqF,
					activo_nonce	=> activo_nonce,
					semilla_x0		=> semillax0,
					nonce_valid		=> nonce_validF,
					nonce				=> nonceF
 				);
	
	Module_Comparador_cerosF: 	ENTITY work.comparador_ceros
	PORT	MAP( 	  clk						=> clk,
					  rst						=> rst_others,
					  ena_num_ceros_comp	=>	ena_num_ceros_comp,
					  digest_ceros			=> outputF(255 DOWNTO 128),
					  ceros_integer		=> ceros_integer,
					  cerosOK				=> comparar_cerosF
					  );

	
END ARCHITECTURE;