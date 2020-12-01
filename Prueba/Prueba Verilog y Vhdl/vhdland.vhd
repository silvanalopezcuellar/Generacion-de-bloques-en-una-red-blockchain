-- Test file including an NAD function using VHDL.
LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;  
USE ieee.numeric_std.all; 
------------------------------------------------------
ENTITY vhdland IS
PORT(	A			: IN  STD_LOGIC;			-- Entrada 0 para el módulo de AND
		B			: IN  STD_LOGIC;			-- Entrada 0 para el módulo de AND
		Salida	: OUT STD_LOGIC);				-- Salida de la operación AND
END ENTITY vhdland;  
------------------------------------------------------
ARCHITECTURE gatelevel OF vhdland IS 
------------------------------------------------------
BEGIN
		Salida <= A AND B;						-- Operación AND
					
END ARCHITECTURE gatelevel;

