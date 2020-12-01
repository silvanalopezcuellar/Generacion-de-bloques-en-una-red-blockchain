LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;  
USE ieee.numeric_std.all; 
------------------------------------------------------
ENTITY prueba IS
PORT(	in0a			: IN  STD_LOGIC;		-- Entrada 0 para el módulo de AND
		in1a			: IN  STD_LOGIC;		-- Entrada 1 para el módulo de AND
		in0o			: IN  STD_LOGIC;		-- Entrada 0 para el módulo de OR
		in1o			: IN  STD_LOGIC;		-- Entrada 1 para el módulo de OR
		output_a			: OUT STD_LOGIC;	-- Salida de la operación AND
		output_o			: OUT STD_LOGIC);	-- Salida de la operación OR
END ENTITY prueba;  
------------------------------------------------------
ARCHITECTURE structural OF prueba IS 
------------------------------------------------------
SIGNAL bit0,bit1,outbit	: STD_ULOGIC;			-- Definicion de las señales del COMPONENT

COMPONENT verilogor								-- COMPONENT para el módulo escrito en verilog para implementar una OR
	PORT (	bit0 	: IN STD_ULOGIC;			-- Entrada 0 para el módulo de OR escrito en verilog
			bit1	: IN STD_ULOGIC;			-- Entrada 1 para el módulo de OR escrito en verilog
			outbit	: OUT STD_ULOGIC);			-- Salida de la operación OR
END COMPONENT;

BEGIN
												-- Instanciación de los módulos
	Module_0: ENTITY work.vhdland				-- Módulo de AND en VHDL
	PORT MAP(	A => in0a,
					B => in1a,
					Salida  => output_a);
												
	Module_1: verilogor							-- Módulo de OR en verilog
	PORT MAP(	bit0 => in0o,
					bit1 => in1o,
					outbit  => output_o);
		
END ARCHITECTURE structural;

