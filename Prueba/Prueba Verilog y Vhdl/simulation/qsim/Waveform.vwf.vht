-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "11/29/2019 17:09:55"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          prueba
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY prueba_vhd_vec_tst IS
END prueba_vhd_vec_tst;
ARCHITECTURE prueba_arch OF prueba_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL in0a : STD_LOGIC;
SIGNAL in0o : STD_LOGIC;
SIGNAL in1a : STD_LOGIC;
SIGNAL in1o : STD_LOGIC;
SIGNAL output_a : STD_LOGIC;
SIGNAL output_o : STD_LOGIC;
COMPONENT prueba
	PORT (
	in0a : IN STD_LOGIC;
	in0o : IN STD_LOGIC;
	in1a : IN STD_LOGIC;
	in1o : IN STD_LOGIC;
	output_a : OUT STD_LOGIC;
	output_o : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : prueba
	PORT MAP (
-- list connections between master ports and signals
	in0a => in0a,
	in0o => in0o,
	in1a => in1a,
	in1o => in1o,
	output_a => output_a,
	output_o => output_o
	);

-- in0a
t_prcs_in0a: PROCESS
BEGIN
LOOP
	in0a <= '0';
	WAIT FOR 100000 ps;
	in0a <= '1';
	WAIT FOR 100000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_in0a;

-- in1a
t_prcs_in1a: PROCESS
BEGIN
LOOP
	in1a <= '0';
	WAIT FOR 50000 ps;
	in1a <= '1';
	WAIT FOR 50000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_in1a;

-- in0o
t_prcs_in0o: PROCESS
BEGIN
LOOP
	in0o <= '0';
	WAIT FOR 100000 ps;
	in0o <= '1';
	WAIT FOR 100000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_in0o;

-- in1o
t_prcs_in1o: PROCESS
BEGIN
LOOP
	in1o <= '0';
	WAIT FOR 50000 ps;
	in1o <= '1';
	WAIT FOR 50000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_in1o;
END prueba_arch;
