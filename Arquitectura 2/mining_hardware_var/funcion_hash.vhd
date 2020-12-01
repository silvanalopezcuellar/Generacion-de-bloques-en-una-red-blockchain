LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;  
USE ieee.numeric_std.all; 
use ieee.std_logic_signed .all ;
USE ieee.std_logic_1164.std_ulogic;

------------------------------------------------------
ENTITY funcion_hash IS
GENERIC	( 	nonceL		   	:		INTEGER );
PORT		(	clk				: IN  STD_ULOGIC;
				reset				: IN  STD_ULOGIC;
				hash				: IN  STD_ULOGIC:='0';
				mas_bloques		: IN  STD_ULOGIC:='1';
				msg_input		: IN  STD_ULOGIC_VECTOR((511) DOWNTO 0):= (OTHERS => '0');
				nonce_input		: IN  STD_ULOGIC_VECTOR((nonceL-1) DOWNTO 0):= (OTHERS => '0');
				ready				: IN  STD_ULOGIC;
				digest_valid	: OUT STD_ULOGIC;
				leer_ok			: OUT STD_ULOGIC;
				output			: OUT STD_ULOGIC_VECTOR(255 DOWNTO 0)
				);
END ENTITY funcion_hash;  
------------------------------------------------------
ARCHITECTURE funcion_hashARCH OF funcion_hash IS 
------------------------------------------------------
SIGNAL error, syn_clr_contw, ena_contw, maxtickw, syn_clr_contr, ena_contr, maxtickr	: STD_ULOGIC;
SIGNAL address																			: STD_ULOGIC_VECTOR(7 DOWNTO 0);
SIGNAL read_data, word, digest_control, write_data							: STD_ULOGIC_VECTOR(31 DOWNTO 0);
SIGNAL regout_enable, ena_IN_reg													: STD_ULOGIC:='0';
SIGNAL ena_input_in				 													: STD_ULOGIC:='1';
SIGNAL cuentar, cuentaw																: STD_ULOGIC_VECTOR(7 DOWNTO 0);
SIGNAL cs, we, clk_ctrl, digest_v, reset_SHA	, first_sig					: STD_ULOGIC;


COMPONENT sha256 
	PORT (
					clk 			: in   STD_ULOGIC;
					reset_n 		: in   STD_ULOGIC;
					-- Control
					cs 			: in   STD_ULOGIC;
					we				: in   STD_ULOGIC;
					-- Data ports
					address		: in   STD_ULOGIC_VECTOR(7 DOWNTO 0);
					write_data	: in   STD_ULOGIC_VECTOR(31 DOWNTO 0);
					read_data	: out  STD_ULOGIC_VECTOR(31 DOWNTO 0);
					error			: out  STD_ULOGIC
			);
END COMPONENT;


BEGIN
	
	------------------------------------------------------------ Component Instantiation sha-256
	Module_SHA256: sha256
	PORT MAP(	clk			=>	clk,
               reset_n		=>	reset_SHA,
               -- Control.
               cs				=>	cs,
               we				=>	we,
               -- Data ports.
               address		=> address,
               write_data	=>	write_data,
               read_data	=>	read_data,
               error			=>	error
				);
				
	regout_enable	<= not we;	
	
	------------------------------------------------------------ Component Instantiation sha out register
	
	Module_SHAoutRegister: ENTITY work.sha256_outregister
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					-- Contol.
					enable 		=>	regout_enable,
					address		=> address,
					-- Data ports.
					r_input		=> read_data,
					r_output    => output
 				);
				
	---------------------------------------------------------- Component Instantiation in register sha

	Module_inregisterSHA: ENTITY work.inregister_sha256
	GENERIC	MAP( 	nonceL	=> nonceL)
	PORT MAP (	clk			=> clk,
					reset			=>	reset,
					mas_bloques => mas_bloques,
					first_sig	=> first_sig,
					-- Contol.
					Write_enable=>	ena_input_in,
					read_enable	=> ena_IN_reg,
					-- Data ports.
					address		=>	cuentaw,
					msg_input	=> msg_input,
					nonce_input => nonce_input,
					w_output		=> word
 				);	

	---------------------------------------------------------- Component Instantiation CONTROL in out register
	
	Module_controlInOutRegister: ENTITY work.control_inoutregister
	PORT	MAP( clk	          => clk,
				  rst	          => reset,
				  hash			 => hash,
				  mas_bloques	 => mas_bloques,
				  ready			 => ready,
				  ena_input_in	 => ena_input_in,
				  ena_IN_reg	 => ena_IN_reg,
				  word 			 => word,				  
				  cuentar		 => cuentar,
				  cuentaw		 => cuentaw,
				  digest_control=> read_data,
				  address_out	 => address,
				  write_data	 => write_data,
				  cs				 => cs,
				  we				 => we,
				  ena_contw		 => ena_contw,
				  ena_contr		 => ena_contr,
				  syn_clr_contw => syn_clr_contw,
				  syn_clr_contr => syn_clr_contr,
				  reset_SHA		 => reset_SHA,
				  digest_valid	 => digest_valid,
				  leer_ok		 => leer_ok,
				  first_sig		 => first_sig
				  ); 

	---------------------------------------------------------- Component Instantiation cont
				  
	Module_ContRegisterw : 	ENTITY work.cont
	GENERIC MAP( Rstvalue       	=> 16,
				  Con       	=> 31,
				  N				=>	8)
	PORT	MAP( clk				=> clk,
				  rst				=> reset,
				  syn_clr_cont	=> syn_clr_contw,
				  ena_cont		=> ena_contw,
				  contMaxTick	=> maxtickw,
				  salidacount  => cuentaw
				  );
				  
	Module_ContRegisterr : 	ENTITY work.cont
	GENERIC	MAP( Rstvalue       	=> 32,
				  Con       	=> 40,
				  N				=>	8)
	PORT	MAP( clk				=> clk,
				  rst				=> reset,
				  syn_clr_cont	=> syn_clr_contr,
				  ena_cont		=> ena_contr,
				  contMaxTick	=> maxtickr,
				  salidacount  => cuentar
				  );
	  

END ARCHITECTURE;