LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_1164.std_ulogic;

-------------------------------
ENTITY control_inoutregister IS
	PORT		( clk	               :	IN 	STD_ULOGIC;
				  rst	               :	IN 	STD_ULOGIC;
				  hash   				:	IN		STD_ULOGIC;
				  mas_bloques			:	IN		STD_ULOGIC;	
				  ready					:	IN		STD_ULOGIC;	
				  word					:	IN 	STD_ULOGIC_VECTOR(31 DOWNTO 0);
				  cuentar				:	IN		STD_ULOGIC_VECTOR(7 DOWNTO 0);
				  cuentaw				:	IN		STD_ULOGIC_VECTOR(7 DOWNTO 0);
				  digest_control		:	IN		STD_ULOGIC_VECTOR(31 DOWNTO 0);
				  address_out			:  OUT   STD_ULOGIC_VECTOR(7 DOWNTO 0);
				  write_data			:	OUT 	STD_ULOGIC_VECTOR(31 DOWNTO 0);
				  ena_input_in			:	OUT	STD_ULOGIC;
				  ena_IN_reg			:	OUT	STD_ULOGIC;	
				  cs						:	OUT	STD_ULOGIC;
				  we						:	OUT	STD_ULOGIC;
				  ena_contw		      :	OUT	STD_ULOGIC;
				  ena_contr		      :	OUT	STD_ULOGIC;
				  syn_clr_contw	   :	OUT	STD_ULOGIC;
				  syn_clr_contr	   :	OUT	STD_ULOGIC;
				  reset_SHA				:	OUT	STD_ULOGIC;
				  digest_valid			:  OUT	STD_ULOGIC;
				  leer_ok				:	OUT	STD_ULOGIC;
				  first_sig				:	OUT	STD_ULOGIC
				  ); 
END ENTITY;
--------------------------------
ARCHITECTURE oneHot OF control_inoutregister IS
--------------------------------
	SIGNAL	first_time, Registro_first_time, regleer	:	STD_ULOGIC:='0';
	SIGNAL 	read_data_control									:	STD_ULOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL	address, address_reg								:	STD_ULOGIC_VECTOR(7 DOWNTO 0);
	SiGNAL	signal_Registro_first_time						:	STD_ULOGIC_VECTOR(31 DOWNTO 0);


	TYPE state IS (uno, dos, tres, cuatro, cinco, cinco_5, cinco_6, seis, siete, ocho, ocho_5, nueve, nueve_5, diez, once, doce, trece, trece_5, catorce, quince);
	SIGNAL nx_state	:	state;
	
BEGIN
	
	address_out <= address_reg;
	leer_ok <= regleer;
	signal_Registro_first_time <= (OTHERS => Registro_first_time);						--***************  testing
	first_sig <= Registro_first_time;
	
	Combinationalsha: PROCESS(rst, clk, word, hash, nx_state, address, Registro_first_time, address_reg, digest_control, first_time)
	BEGIN
		IF (rst = '0') THEN
		
			nx_state	<=	uno; 
			Registro_first_time <= '0';
			regleer <= '0';
		
		ELSIF (rising_edge(clk)) THEN

			address_reg	<=	address;
	
				IF (first_time='1') THEN
					Registro_first_time	<=	'1';
				ELSIF (nx_state = uno) THEN
					Registro_first_time	<=	'0';
				END IF;
				
				IF (cuentar = "00100111") THEN
					regleer <= '1';
				ELSIF (nx_state = uno) THEN
					regleer	<=	'0';
				END IF;

			CASE nx_state IS
			
			WHEN uno =>
				address				<= "00000000";
				write_data			<= "00000000000000000000000000000000";
				cs						<= '0';
				we						<= '0';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '1';
				syn_clr_contr	   <= '1';
				first_time			<= '0';
				ena_input_in		<= '1';
				ena_IN_reg			<=	'0';
				read_data_control	<=	"00000000000000000000000000000000";
				reset_SHA			<= '0';
				digest_valid		<= '0';
				IF (hash = '0') THEN
				nx_state 			<= uno;
				ELSIF (hash = '1') THEN
				nx_state 			<= dos;
				END IF;
				
			WHEN dos =>
				address				<= "00000000";
				write_data			<= "00000000000000000000000000000000";
				cs						<= '0';
				we						<= '0';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '1';
				syn_clr_contr	   <= '1';
				first_time			<= '0';
				ena_input_in		<= '1';
				ena_IN_reg			<=	'0';
				read_data_control	<=	"00000000000000000000000000000000";
				reset_SHA			<= rst;
				digest_valid		<= '0';				
				nx_state 			<= tres;
				
			WHEN tres =>
				address				<= cuentaw;
				write_data			<= "00000000000000000000000000000000";
				cs						<= '0';
				we						<= '0';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '1';
				syn_clr_contr	   <= '1';
				first_time			<= '0';
				ena_input_in		<= '1';
				ena_IN_reg			<=	'0';
				read_data_control	<=	"00000000000000000000000000000000";
				reset_SHA			<= rst;
				digest_valid		<= '0';
				nx_state 			<= cuatro;
				
			WHEN cuatro	=>
				address				<= cuentaw;
				write_data			<= word;
				cs						<= '1';
				we						<= '1';
				ena_contw		   <= '1';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '0';
				syn_clr_contr	   <= '0';
				first_time			<= '0';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'1';
				read_data_control	<=	"00000000000000000000000000000000";
				reset_SHA			<= rst;
				digest_valid		<= '0';
				nx_state 			<= cinco;
				
			WHEN cinco	=>
				address				<= cuentaw;
				write_data			<= word;
				cs						<= '0';
				we						<= '0';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '0';
				syn_clr_contr	   <= '0';
				first_time			<= '0';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'1';
				read_data_control	<=	"00000000000000000000000000000000";
				reset_SHA			<= rst;
				digest_valid		<= '0';
				
				IF ((address = "00011111") AND (Registro_first_time = '0')) THEN
				nx_state 			<= cinco_5;
				ELSIF ((address = "00011111") AND (Registro_first_time = '1')) THEN
				nx_state 			<= cinco_6;
				ELSIF (address <	"00011111") THEN
					nx_state 			<= cuatro;
				ELSIF (address >	"00011111") THEN
					nx_state 			<= uno;
				END IF;
				
			WHEN cinco_5	=>
				address				<= cuentaw;
				write_data			<= word;
				cs						<= '1';
				we						<= '1';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '0';
				syn_clr_contr	   <= '0';
				first_time			<= '0';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'1';
				read_data_control	<=	"00000000000000000000000000000000";
				reset_SHA			<= rst;
				digest_valid		<= '0';
				nx_state 			<= seis;
			
			WHEN cinco_6	=>
				address				<= cuentaw;
				write_data			<= word;
				cs						<= '1';
				we						<= '1';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '0';
				syn_clr_contr	   <= '0';
				first_time			<= '0';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'1';
				read_data_control	<=	"00000000000000000000000000000000";
				reset_SHA			<= rst;
				digest_valid		<= '0';
				nx_state 			<= siete;
				
			WHEN seis	=>
				address				<= "00001000";
				write_data			<= "00000000000000000000000000000101";
				cs						<= '0';
				we						<= '0';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '0';
				syn_clr_contr	   <= '0';
				first_time			<= '1';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'0';
				read_data_control	<=	"00000000000000000000000000000000";
				reset_SHA			<= rst;
				digest_valid		<= '0';
				nx_state 			<= ocho_5;
				
			WHEN siete	=>
				address				<= "00001000";
				write_data			<= "00000000000000000000000000000110";
				cs						<= '0';
				we						<= '0';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '0';
				syn_clr_contr	   <= '0';
				first_time			<= '1';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'0';
				read_data_control	<=	"00000000000000000000000000000000";
				reset_SHA			<= rst;
				digest_valid		<= '0';
				nx_state 			<= ocho;
				
			WHEN ocho	=>
				address				<= "00001000";
				write_data			<= "00000000000000000000000000000110";
				cs						<= '1';
				we						<= '1';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '1';
				syn_clr_contr	   <= '1';
				first_time			<= '1';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'0';
				read_data_control	<=	"00000000000000000000000000000000";
				reset_SHA			<= rst;
				digest_valid		<= '0';
				nx_state 			<= nueve;
			
			WHEN ocho_5	=>
				address				<= "00001000";
				write_data			<= "00000000000000000000000000000101";
				cs						<= '1';
				we						<= '1';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '1';
				syn_clr_contr	   <= '1';
				first_time			<= '0';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'0';
				read_data_control	<=	"00000000000000000000000000000000";
				reset_SHA			<= rst;
				digest_valid		<= '0';
				nx_state 			<= nueve;
				
			WHEN nueve	=>
				address				<= "00001000";
				write_data			<= word;
				cs						<= '0';
				we						<= '0';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '1';
				syn_clr_contr	   <= '1';
				first_time			<= '1';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'0';
				read_data_control	<=	"00000000000000000000000000000000";
				reset_SHA			<= rst;
				digest_valid		<= '0';
				nx_state 			<= nueve_5;

			WHEN nueve_5	=>
				address				<= "00001001";
				write_data			<= word;
				cs						<= '1';
				we						<= '0';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '1';
				syn_clr_contr	   <= '1';
				first_time			<= '1';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'0';
				read_data_control	<=	digest_control;
				reset_SHA			<= rst;
				digest_valid		<= '0';
				IF (address_reg="00001001") THEN
				nx_state 			<= diez;
				ELSE
				nx_state 			<= nueve_5;
				END IF;
			
			WHEN diez	=>
				address				<= "00001001";
				write_data			<= word;
				cs						<= '1';
				we						<= '0';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '1';
				syn_clr_contr	   <= '1';
				first_time			<= '1';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'0';
				read_data_control	<=	digest_control;
				reset_SHA			<= rst;
				digest_valid		<= '0';
				IF (digest_control="00000000000000000000000000000000") THEN
				nx_state 			<= once;
				ELSIF (digest_control/="00000000000000000000000000000000") THEN
				nx_state 			<= doce;
				END IF;		
				
			WHEN once	=>
				address				<= "00001001";
				write_data			<= word;
				cs						<= '1';
				we						<= '0';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '1';
				syn_clr_contr	   <= '1';
				first_time			<= '1';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'0';
				read_data_control	<=	digest_control;
				reset_SHA			<= rst;
				digest_valid		<= '0';
				nx_state 			<= diez;	
				
			WHEN doce	=>
				address				<= "00001001";
				write_data			<= word;
				cs						<= '0';
				we						<= '0';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '1';
				syn_clr_contr	   <= '1';
				first_time			<= '1';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'0';
				read_data_control	<=	digest_control;
				reset_SHA			<= rst;
				digest_valid		<= '1';
				nx_state 			<= trece;
				
			WHEN trece	=>
				address				<= cuentar;
				write_data			<= word;
				cs						<= '1';
				we						<= '0';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '0';
				syn_clr_contr	   <= '0';
				first_time			<= '1';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'0';
				read_data_control	<=	digest_control;
				reset_SHA			<= rst;
				digest_valid		<= '0';
				IF (ready = '0') THEN
				nx_state 			<= trece;
				ELSIF (ready = '1') THEN
				nx_state          <= trece_5;
				END IF;
				
			WHEN trece_5	=>
				address				<= cuentar;
				write_data			<= word;
				cs						<= '1';
				we						<= '0';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '0';
				syn_clr_contr	   <= '0';
				first_time			<= '1';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'0';
				read_data_control	<=	digest_control;
				reset_SHA			<= rst;
				digest_valid		<= '0';
				IF (mas_bloques = '0') THEN
				nx_state 			<= catorce;
				ELSIF (mas_bloques = '1') THEN
				nx_state          <= tres;
				END IF;
				
			WHEN catorce	=>
				address				<= cuentar;
				write_data			<= word;
				cs						<= '0';
				we						<= '0';
				ena_contw		   <= '0';
			   ena_contr		   <= '0';
				syn_clr_contw	   <= '0';
				syn_clr_contr	   <= '0';
				first_time			<= '1';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'0';
				read_data_control	<=	digest_control;
				reset_SHA			<= rst;
				digest_valid		<= '0';
				nx_state 			<= quince;
				
			WHEN quince	=>
				address				<= cuentar;
				write_data			<= word;
				cs						<= '0';
				we						<= '0';
				ena_contw		   <= '0';
			   ena_contr		   <= '1';
				syn_clr_contw	   <= '0';
				syn_clr_contr	   <= '0';
				first_time			<= '1';
				ena_input_in		<= '0';
				ena_IN_reg			<=	'0';
				read_data_control	<=	digest_control;
				reset_SHA			<= rst;
				digest_valid		<= '0';
				IF (address_reg > "00100111") THEN
				nx_state          <= uno;
				ELSIF (address = "00100111" OR address < "00100111") THEN
				nx_state 			<= trece;
				END IF;
			
			END CASE;
		END IF;
	END PROCESS combinationalsha;
END ARCHITECTURE;