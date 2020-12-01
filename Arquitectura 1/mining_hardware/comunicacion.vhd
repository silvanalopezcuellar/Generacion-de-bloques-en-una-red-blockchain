LIBRARY IEEE;
USE ieee.STD_LOGIC_1164.all;

USE ieee.numeric_std.all;
----------------------------------------------------------------------------------------------------
ENTITY comunicacion IS
	GENERIC		( Convel    			: INTEGER  ;  
					  Nvel      			: INTEGER  ;
					  Conceros				: INTEGER  ; 
					  Nceros					: INTEGER  ;
					  Confinal				: INTEGER  ; 
					  Nfinal					: INTEGER  ;
					  Conmitadvel 			: INTEGER  ;  
					  Nmitadvel      		: INTEGER  ;
					  Conbits     			: INTEGER  ;  
					  Nbits					: INTEGER  ;
					  Con512     			: INTEGER  ;  
					  N512					: INTEGER  ;
					  Conblock    			: INTEGER  ;  
					  Nblock					: INTEGER  ;
					  Contransmision		: INTEGER  ;  
					  Ntransmision			: INTEGER  ;
					  Conbits2    			: INTEGER  ;  
					  Nbits2					: INTEGER  ;
					  Xmax 					: INTEGER  ;
					  Ymax 					: INTEGER  ;
					  MAX_WIDTH			   : INTEGER  ;
					  halfL					: INTEGER  
				  );
	PORT		(	  clk	        			:	IN 	STD_ULOGIC;
					  rst	        	   	:	IN 	STD_ULOGIC;
					  fail_s					: 	IN		STD_ULOGIC;
					  new_msg_ready		:	IN		STD_ULOGIC:='0';
					  rx			   		:	IN		STD_ULOGIC:='1';
					  row_rd_addr			: 	IN		INTEGER := 0;
					  column_rd_addr		:  IN 	INTEGER := 0;
					  iniciotransmision	:	IN		STD_ULOGIC:='0';
					  transmitir         :	IN 	STD_ULOGIC_VECTOR(255 DOWNTO 0):= (OTHERS => '0');
					  transmitir_n			:	IN	   STD_ULOGIC_VECTOR (31 DOWNTO 0);
					  transmitir_t			:	IN	   STD_ULOGIC_VECTOR (15 DOWNTO 0);
					  tx						:	OUT	STD_ULOGIC;
					  bloques_cuenta		:	OUT   STD_ULOGIC_VECTOR(5 DOWNTO 0);
					  fin_mensaje_out		:	OUT   STD_ULOGIC;
					  salidatr				:	OUT	STD_ULOGIC;
					  data_out				:	OUT	STD_ULOGIC_VECTOR(511 DOWNTO 0);
					  ceros_integer		:	OUT	INTEGER;
					  bloques_out        :  OUT   INTEGER;
					  fin_envio_msg		:	OUT	STD_ULOGIC;
					  finalByte				:	OUT	STD_ULOGIC_VECTOR(5 DOWNTO 0);
					  rst_comms				:	OUT	STD_ULOGIC
				); 
	END ENTITY;
	
	
	
ARCHITECTURE comunicacionARCH OF comunicacion IS
	
SIGNAL contvelMaxTick, contbitsMaxTick, cont512MaxTick, 
		 contblockMaxTick, contmitadvelMaxTick, num_ceros,
		 contcerosMaxTick, contfinalMaxTick 						: STD_ULOGIC;
SIGNAL syn_clr_contvel, syn_clr_contbits, syn_clr_cont512, 
		 syn_clr_contblock, syn_clr_contmitadvel, 
		 syn_clr_contceros, syn_clr_contfinal    					: STD_ULOGIC;
SIGNAL countbits, countblock, count512, countvel, 
		 countmitadvel, countfinal, counttr, bloques   	      : INTEGER;
SIGNAL ena_contbits, ena_contvel, ena_cont512, 
		 ena_contblock, ena_contmitadvel, wr_en, 
		 ena_num_ceros, ena_contceros, ena_contfinal      		: STD_ULOGIC;
SIGNAL data_in														      : STD_ULOGIC;
SIGNAL row_wr_addr, column_wr_addr, countnumceros		      : INTEGER;
SIGNAL salida_num_ceros	                                    : STD_ULOGIC_VECTOR(15 DOWNTO 0);
SIGNAL conttrMaxTick, fin_mensaje									: STD_ULOGIC;
SIGNAL contbits2MaxTick													: STD_ULOGIC;
SIGNAL syn_clr_bits2														: STD_ULOGIC;
SIGNAL syn_clr_tr															: STD_ULOGIC;
SIGNAL countbits2															: INTEGER;	
SIGNAL ena_contbits2														: STD_ULOGIC;
SIGNAL ena_conttr															: STD_ULOGIC;
SIGNAL ena_guardar														: STD_ULOGIC;
SIGNAL ena_desplazar														: STD_ULOGIC;
SIGNAL salida_sha		 													: STD_ULOGIC_VECTOR (255 DOWNTO 0);
BEGIN

bloques_out <= bloques;
fin_mensaje_out <= fin_mensaje;

controlre: ENTITY work.controlrecepcion
	PORT MAP	( clk	              		=> clk, 
				  rst	               	=> rst,
				  rx							=> rx,
				  new_msg_ready			=> new_msg_ready,
				  contvelMaxTick     	=> contvelMaxTick,
				  contcerosMaxTick		=> contcerosMaxTick,
				  contfinalMaxTick		=> contfinalMaxTick,
				  contmitadvelMaxTick	=> contmitadvelMaxTick,
				  contbitsMaxTick			=> contbitsMaxTick,
				  cont512MaxTick    		=> cont512MaxTick,
				  contblockMaxTick		=> contblockMaxTick,
				  countvel					=> countvel,
				  countnumceros			=> countnumceros,
				  countfinal				=> countfinal,
				  countmitadvel			=> countmitadvel,
				  countbits					=> countbits,
				  countblock				=> countblock,
				  count512					=> count512,
				  syn_clr_contvel 		=> syn_clr_contvel,
				  syn_clr_contceros		=> syn_clr_contceros,
				  syn_clr_contfinal		=> syn_clr_contfinal,
				  syn_clr_contmitadvel 	=> syn_clr_contmitadvel,
				  syn_clr_contbits 		=> syn_clr_contbits,
				  syn_clr_cont512    	=> syn_clr_cont512,
				  syn_clr_contblock 		=> syn_clr_contblock,
				  ena_contbits				=> ena_contbits,
				  ena_contvel				=> ena_contvel,
				  ena_contceros			=> ena_contceros,
				  ena_contfinal			=> ena_contfinal,
				  ena_contmitadvel		=> ena_contmitadvel,
				  ena_cont512				=> ena_cont512,
				  ena_contblock			=> ena_contblock,
				  data_in					=> data_in,
				  wr_en		  		   	=> wr_en,
				  num_ceros					=>	num_ceros,
				  ena_num_ceros 			=> ena_num_ceros,
				  row_wr_addr 		   	=> row_wr_addr,
				  column_wr_addr  		=> column_wr_addr,
				  fin_mensaje				=> fin_mensaje,
				  bloques					=> bloques,
				  rst_comms					=> rst_comms
				  ); 
				  
Registro_numceros: ENTITY work.Reg_Num_Ceros
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  countnumceros   =>	countnumceros,
				  ena_num_ceros 	=>	ena_num_ceros,
				  num_ceros			=> num_ceros,
				  salida_num_ceros=> salida_num_ceros);
	
Numcerosinteger: ENTITY work.ascii_to_integer
	PORT MAP ( ascii 					=> salida_num_ceros,
				  ceros_integer 		=> ceros_integer);

contvelocidad: ENTITY work.cont_c
	GENERIC MAP( Con      		=> Convel, 
				  N					=>	Nvel)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=> syn_clr_contvel,
				  ena_cont		   =>	ena_contvel,
				  contMaxTick	   =>	contvelMaxTick,
				  salidacount		=> countvel);
				  
contmitadvelocidad: ENTITY work.cont_c
	GENERIC MAP( Con      		=> Conmitadvel, 
				  N					=>	Nmitadvel)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=> syn_clr_contmitadvel,
				  ena_cont		   =>	ena_contmitadvel,
				  contMaxTick	   =>	contmitadvelMaxTick,
				  salidacount		=> countmitadvel);
				  
contceros: ENTITY work.cont_c
	GENERIC MAP( Con      		=> Conceros, 
				  N					=>	Nceros)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=> syn_clr_contceros, 
				  ena_cont		   =>	ena_contceros,
				  contMaxTick	   =>	contcerosMaxTick,
				  salidacount		=> countnumceros);
	
contfinal: ENTITY work.cont_c
	GENERIC MAP( Con      		=> Confinal, 
				  N					=>	Nfinal)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=> syn_clr_contfinal, 
				  ena_cont		   =>	ena_contfinal,
				  contMaxTick	   =>	contfinalMaxTick,
				  salidacount		=> countfinal);
				  
contbitss: ENTITY work.cont_c
	GENERIC MAP( Con      		=> Conbits, 
				  N					=>	Nbits)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=> syn_clr_contbits, 
				  ena_cont		   =>	ena_contbits,
				  contMaxTick	   =>	contbitsMaxTick,
				  salidacount		=> countbits);
		
contblocks: ENTITY work.cont_c
	GENERIC MAP( Con      		=> Conblock, 
				  N					=>	Nblock)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=> syn_clr_contblock,
				  ena_cont		   =>	ena_contblock,
				  contMaxTick	   =>	contblockMaxTick,
				  salidacount		=> countblock);
				  
cont512s: ENTITY work.cont_c
	GENERIC MAP( Con      		=> Con512, 
				  N					=>	N512)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=> syn_clr_cont512, 
				  ena_cont		   =>	ena_cont512,
				  contMaxTick	   =>	cont512MaxTick,
				  salidacount		=> count512);
				  
				 
memoria: ENTITY work.RAM
	GENERIC MAP (Xmax => Xmax,
				 Ymax   => Ymax,
				 halfL  => halfL)
	PORT MAP( clk		  		   => clk,
				 wr_en		  		=> wr_en,
				 data_in	  			=> data_in,
				 bloques				=> bloques,
				 fin_mensaje   	=> fin_mensaje,
				 --read
				 row_rd_addr 		=> row_rd_addr,
				 column_rd_addr  	=> column_rd_addr,
				 --write
				 finalByte			=> finalByte,
				 row_wr_addr 		=> row_wr_addr,
				 column_wr_addr  	=> column_wr_addr,
				 data_out			=> data_out);
				 
controltr: ENTITY work.controltransmision
	PORT MAP	( clk	               => clk, 
				  rst	               => rst,
				  iniciotransmision	=> iniciotransmision,
				  conttrMaxTick      => conttrMaxTick,
				  contbitsMaxTick		=> contbits2MaxTick,
				  countbits				=> countbits2,
				 -- salida					=> salida1,
				  syn_clr_tr			=> syn_clr_tr,
				  syn_clr_bits			=> syn_clr_bits2,
				  ena_conttr			=> ena_conttr,
				  ena_contbits			=> ena_contbits2,
				  ena_guardar			=> ena_guardar,
				  ena_desplazar		=> ena_desplazar,
				  tx						=> tx
				  ); 

conttrasmision: ENTITY work.cont_c
	GENERIC MAP( Con      		=> Contransmision, 
				  N					=>	Ntransmision)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=> syn_clr_tr,
				  ena_cont		   =>	ena_conttr,
				  contMaxTick	   =>	conttrMaxTick,
				  salidacount		=> counttr);
				  
contbitss2: ENTITY work.cont_c
	GENERIC MAP( Con      		=> Conbits2, 
				  N					=>	Nbits2)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=> syn_clr_bits2, 
				  ena_cont		   =>	ena_contbits2,
				  contMaxTick	   =>	contbits2MaxTick,
				  salidacount		=> countbits2);
				 
registro: ENTITY work.serial_converter
	GENERIC MAP( MAX_WIDTH		=> MAX_WIDTH)
	PORT	MAP (clk				=>	clk,
				 rst				=>	rst,
				 fail_s			=> fail_s,
				 ena_guardar	=> ena_guardar,
				 ena_desplazar => ena_desplazar,
				 transmitir		=>	transmitir,
				 transmitir_n 	=> transmitir_n,
				 transmitir_t	=> transmitir_t,
				 dout 			=>	salidatr);
				  
END ARCHITECTURE;