LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY tiempo IS
	GENERIC	( Cont1     			: INTEGER	:= 100;
				  Cont2		         : INTEGER 	:= 9;
				  N1				      : INTEGER   := 10;
				  N2			      	: INTEGER   := 4;
				  Conad					: INTEGER	:= 100;
				  Nad						: INTEGER	:= 10);
				  
	PORT		( clk				:	IN		STD_ULOGIC;
				  rst	      	:	IN 	STD_ULOGIC;
				  enable			:	IN 	STD_ULOGIC;
				  go				:	IN 	STD_ULOGIC;
				  salidatiempo	:  OUT 	STD_ULOGIC_VECTOR(15 DOWNTO 0)
				  );
END ENTITY;
---------------------------------- 
ARCHITECTURE tiempoArch OF tiempo IS

   SIGNAL	digi3,digi0,digi1,digi2								                           :  STD_ULOGIC_VECTOR(N2-1 DOWNTO 0);
	SIGNAL   ena0, ena1, ena2, ena3, ena4, ena5, enadri, syn1, syn2, syn3, syn4		:  STD_ULOGIC;
	SIGNAL	max_tick2, max_tick3, ignore, max_tick4			                        :	STD_ULOGIC;
	
	
BEGIN
	ena1 				  <= go;
	ena3 				  <= max_tick2 AND ena2;
	ena4 				  <= max_tick3 AND ena3;
	ena5				  <= max_tick4 AND ena4;
	
	syn1             <= ena2;
	syn2				  <= max_tick2;
	syn3				  <= max_tick3;
	syn4 				  <= max_tick4;
										
	salidatiempo(15) <= digi3(3);
	salidatiempo(14) <= digi3(2);
	salidatiempo(13) <= digi3(1);
   salidatiempo(12) <= digi3(0);
	salidatiempo(11) <= digi2(3);
	salidatiempo(10) <= digi2(2);
	salidatiempo(9)  <= digi2(1);
   salidatiempo(8)  <= digi2(0);
	salidatiempo(7)  <= digi1(3);
	salidatiempo(6)  <= digi1(2);
	salidatiempo(5)  <= digi1(1);
   salidatiempo(4)  <= digi1(0);
	salidatiempo(3)  <= digi0(3);
	salidatiempo(2)  <= digi0(2);
	salidatiempo(1)  <= digi0(1);
   salidatiempo(0)  <= digi0(0);
--				 
	contModule_1: ENTITY work.cont_t
	GENERIC MAP(Rstvalue => 0,
					Con 		=> Cont1,
					 N	  		=> N1 )
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=> '0',
				  ena_cont		   =>	go,
				  contMaxTick	   =>	ena2);
--													-- Contador de cada 10 ms
--				 
	contModule_2: ENTITY work.cont_t
	GENERIC MAP( Rstvalue 	=> 0,
					Con 			=> Cont2,
					 N	  			=> N2)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=> '0',
				  ena_cont		   =>	ena2,
				  contMaxTick	   =>	max_tick2,
				  salidacount		=> digi0);
--												-- Contador de 0 a 90 ms
--				 
	contModule_3: ENTITY work.cont_t
	GENERIC MAP( Rstvalue	=> 0,
					Con 			=> Cont2,
					 N	  			=> N2)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=> '0',
				  ena_cont		   =>	ena3,
				  contMaxTick	   =>	max_tick3,
				  salidacount		=> digi1);
--												-- contador de 0 a 9 s
	contModule_4: ENTITY work.cont_t
	GENERIC MAP( Rstvalue 		=> 0,
					Con 				=> Cont2,
					 N	  				=> N2)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=> '0',
				  ena_cont		   =>	ena4,
				  contMaxTick		=> max_tick4,
				  salidacount		=> digi2);
--												-- contador de 0 a 9 décimas de segundo

	contModule_5: ENTITY work.cont_t
	GENERIC MAP( Rstvalue 		=> 0,
					Con 				=> Cont2,
					 N	  				=> N2)
	PORT	MAP( clk					=>	clk,
				  rst					=>	rst,
				  syn_clr_cont 	=> '0',
				  ena_cont		   =>	ena5,
				  salidacount		=> digi3);
				 
		
END ARCHITECTURE tiempoArch;