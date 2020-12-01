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

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

-- DATE "11/29/2019 17:09:59"

-- 
-- Device: Altera EP4CGX15BF14C6 Package FBGA169
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_NCEO~	=>  Location: PIN_N5,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
-- ~ALTERA_DATA0~	=>  Location: PIN_A5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_ASDO~	=>  Location: PIN_B5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_NCSO~	=>  Location: PIN_C5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DCLK~	=>  Location: PIN_A4,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_DATA0~~padout\ : std_logic;
SIGNAL \~ALTERA_ASDO~~padout\ : std_logic;
SIGNAL \~ALTERA_NCSO~~padout\ : std_logic;
SIGNAL \~ALTERA_DATA0~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_ASDO~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_NCSO~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	prueba IS
    PORT (
	in0a : IN std_logic;
	in1a : IN std_logic;
	in0o : IN std_logic;
	in1o : IN std_logic;
	output_a : OUT std_logic;
	output_o : OUT std_logic
	);
END prueba;

-- Design Ports Information
-- output_a	=>  Location: PIN_E13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output_o	=>  Location: PIN_L9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in0a	=>  Location: PIN_G9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in1a	=>  Location: PIN_G10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in0o	=>  Location: PIN_N11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in1o	=>  Location: PIN_N10,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF prueba IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_in0a : std_logic;
SIGNAL ww_in1a : std_logic;
SIGNAL ww_in0o : std_logic;
SIGNAL ww_in1o : std_logic;
SIGNAL ww_output_a : std_logic;
SIGNAL ww_output_o : std_logic;
SIGNAL \output_a~output_o\ : std_logic;
SIGNAL \output_o~output_o\ : std_logic;
SIGNAL \in0a~input_o\ : std_logic;
SIGNAL \in1a~input_o\ : std_logic;
SIGNAL \Module_0|Salida~combout\ : std_logic;
SIGNAL \in0o~input_o\ : std_logic;
SIGNAL \in1o~input_o\ : std_logic;
SIGNAL \Module_1|outbit~combout\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_in0a <= in0a;
ww_in1a <= in1a;
ww_in0o <= in0o;
ww_in1o <= in1o;
output_a <= ww_output_a;
output_o <= ww_output_o;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: IOOBUF_X33_Y25_N9
\output_a~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Module_0|Salida~combout\,
	devoe => ww_devoe,
	o => \output_a~output_o\);

-- Location: IOOBUF_X24_Y0_N9
\output_o~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Module_1|outbit~combout\,
	devoe => ww_devoe,
	o => \output_o~output_o\);

-- Location: IOIBUF_X33_Y22_N1
\in0a~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in0a,
	o => \in0a~input_o\);

-- Location: IOIBUF_X33_Y22_N8
\in1a~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in1a,
	o => \in1a~input_o\);

-- Location: LCCOMB_X32_Y22_N16
\Module_0|Salida\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Module_0|Salida~combout\ = (\in0a~input_o\ & \in1a~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in0a~input_o\,
	datad => \in1a~input_o\,
	combout => \Module_0|Salida~combout\);

-- Location: IOIBUF_X26_Y0_N1
\in0o~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in0o,
	o => \in0o~input_o\);

-- Location: IOIBUF_X26_Y0_N8
\in1o~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in1o,
	o => \in1o~input_o\);

-- Location: LCCOMB_X26_Y1_N8
\Module_1|outbit\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Module_1|outbit~combout\ = (\in0o~input_o\) # (\in1o~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \in0o~input_o\,
	datad => \in1o~input_o\,
	combout => \Module_1|outbit~combout\);

ww_output_a <= \output_a~output_o\;

ww_output_o <= \output_o~output_o\;
END structure;


