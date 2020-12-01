LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
-------------------------------
ENTITY serial_converter IS
	GENERIC ( MAX_WIDTH		:	INTEGER	:= 380);
	PORT	  ( clk				:	IN STD_ULOGIC;
				 rst				:	IN	STD_ULOGIC;
				 fail_s			:	IN	STD_ULOGIC;
				 ena_guardar	:	IN STD_ULOGIC;
				 ena_desplazar	:	IN STD_ULOGIC;
				 transmitir		:	IN	STD_ULOGIC_VECTOR (255 DOWNTO 0);
				 transmitir_n	:	IN	STD_ULOGIC_VECTOR (31 DOWNTO 0);
				 transmitir_t	:	IN	STD_ULOGIC_VECTOR (15 DOWNTO 0);
				 dout 			:	OUT STD_ULOGIC:='1');
END ENTITY;
--------------------------------
ARCHITECTURE rtl OF serial_converter IS
	SIGNAL buffer_s: STD_ULOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0)
	;
	SIGNAL d			: STD_ULOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
BEGIN

	d(9) <= '1'; -- bit parada
	d(8) <= (transmitir(255) AND (NOT fail_s)) OR (fail_s);
	d(7) <= (transmitir(254) AND (NOT fail_s)) OR (fail_s);
	d(6) <= (transmitir(253) AND (NOT fail_s)) OR (fail_s);
	d(5) <= (transmitir(252) AND (NOT fail_s)) OR (fail_s); ------ t
	d(4) <= (transmitir(251) AND (NOT fail_s)) OR (fail_s);
	d(3) <= (transmitir(250) AND (NOT fail_s)) OR (fail_s);
	d(2) <= (transmitir(249) AND (NOT fail_s)) OR (fail_s);
	d(1) <= (transmitir(248) AND (NOT fail_s)) OR (fail_s); 
	d(0) <= '0'; -- bit inicio
	d(19) <= '1'; -- bit parada
	d(18) <= (transmitir(247) AND (NOT fail_s)) OR (fail_s);
	d(17) <= (transmitir(246) AND (NOT fail_s)) OR (fail_s);
	d(16) <= (transmitir(245) AND (NOT fail_s)) OR (fail_s);
	d(15) <= (transmitir(244) AND (NOT fail_s)) OR (fail_s);
	d(14) <= (transmitir(243) AND (NOT fail_s)) OR (fail_s);
	d(13) <= (transmitir(242) AND (NOT fail_s)) OR (fail_s);
	d(12) <= (transmitir(241) AND (NOT fail_s)) OR (fail_s);
	d(11) <= (transmitir(240) AND (NOT fail_s)) OR (fail_s);
	d(10) <= '0'; -- bit inicio
	d(29) <= '1'; -- bit parada
	d(28) <= (transmitir(239) AND (NOT fail_s)) OR (fail_s);
	d(27) <= (transmitir(238) AND (NOT fail_s)) OR (fail_s);
	d(26) <= (transmitir(237) AND (NOT fail_s)) OR (fail_s);
	d(25) <= (transmitir(236) AND (NOT fail_s)) OR (fail_s);
	d(24) <= (transmitir(235) AND (NOT fail_s)) OR (fail_s);
	d(23) <= (transmitir(234) AND (NOT fail_s)) OR (fail_s);
	d(22) <= (transmitir(233) AND (NOT fail_s)) OR (fail_s);
	d(21) <= (transmitir(232) AND (NOT fail_s)) OR (fail_s); 
	d(20) <= '0'; -- bit inicio
	d(39) <= '1'; -- bit parada
	d(38) <= (transmitir(231) AND (NOT fail_s)) OR (fail_s);
	d(37) <= (transmitir(230) AND (NOT fail_s)) OR (fail_s);
	d(36) <= (transmitir(229) AND (NOT fail_s)) OR (fail_s);
	d(35) <= (transmitir(228) AND (NOT fail_s)) OR (fail_s);
	d(34) <= (transmitir(227) AND (NOT fail_s)) OR (fail_s);
	d(33) <= (transmitir(226) AND (NOT fail_s)) OR (fail_s);
	d(32) <= (transmitir(225) AND (NOT fail_s)) OR (fail_s);
	d(31) <= (transmitir(224) AND (NOT fail_s)) OR (fail_s); 
	d(30) <= '0'; -- bit inicio
	d(49) <= '1'; -- bit parada
	d(48) <= (transmitir(223) AND (NOT fail_s)) OR (fail_s);
	d(47) <= (transmitir(222) AND (NOT fail_s)) OR (fail_s);
	d(46) <= (transmitir(221) AND (NOT fail_s)) OR (fail_s);
	d(45) <= (transmitir(220) AND (NOT fail_s)) OR (fail_s);
	d(44) <= (transmitir(219) AND (NOT fail_s)) OR (fail_s);
	d(43) <= (transmitir(218) AND (NOT fail_s)) OR (fail_s);
	d(42) <= (transmitir(217) AND (NOT fail_s)) OR (fail_s);
	d(41) <= (transmitir(216) AND (NOT fail_s)) OR (fail_s); 
	d(40) <= '0'; -- bit inicio
	d(59) <= '1'; -- bit parada
	d(58) <= (transmitir(215) AND (NOT fail_s)) OR (fail_s);
	d(57) <= (transmitir(214) AND (NOT fail_s)) OR (fail_s);
	d(56) <= (transmitir(213) AND (NOT fail_s)) OR (fail_s);
	d(55) <= (transmitir(212) AND (NOT fail_s)) OR (fail_s);
	d(54) <= (transmitir(211) AND (NOT fail_s)) OR (fail_s);
	d(53) <= (transmitir(210) AND (NOT fail_s)) OR (fail_s);
	d(52) <= (transmitir(209) AND (NOT fail_s)) OR (fail_s);
	d(51) <= (transmitir(208) AND (NOT fail_s)) OR (fail_s); 
	d(50) <= '0'; -- bit inicio
	d(69) <= '1'; -- bit parada
	d(68) <= (transmitir(207) AND (NOT fail_s)) OR (fail_s);
	d(67) <= (transmitir(206) AND (NOT fail_s)) OR (fail_s);
	d(66) <= (transmitir(205) AND (NOT fail_s)) OR (fail_s);
	d(65) <= (transmitir(204) AND (NOT fail_s)) OR (fail_s);
	d(64) <= (transmitir(203) AND (NOT fail_s)) OR (fail_s);
	d(63) <= (transmitir(202) AND (NOT fail_s)) OR (fail_s);
	d(62) <= (transmitir(201) AND (NOT fail_s)) OR (fail_s);
	d(61) <= (transmitir(200) AND (NOT fail_s)) OR (fail_s);
	d(60) <= '0'; -- bit inicio
	d(79) <= '1'; -- bit parada
	d(78) <= (transmitir(199) AND (NOT fail_s)) OR (fail_s);
	d(77) <= (transmitir(198) AND (NOT fail_s)) OR (fail_s);
	d(76) <= (transmitir(197) AND (NOT fail_s)) OR (fail_s);
	d(75) <= (transmitir(196) AND (NOT fail_s)) OR (fail_s);
	d(74) <= (transmitir(195) AND (NOT fail_s)) OR (fail_s);
	d(73) <= (transmitir(194) AND (NOT fail_s)) OR (fail_s);
	d(72) <= (transmitir(193) AND (NOT fail_s)) OR (fail_s);
	d(71) <= (transmitir(192) AND (NOT fail_s)) OR (fail_s);
	d(70) <= '0'; -- bit inicio
	d(89) <= '1'; -- bit parada
	d(88) <= (transmitir(191) AND (NOT fail_s)) OR (fail_s);
	d(87) <= (transmitir(190) AND (NOT fail_s)) OR (fail_s);
	d(86) <= (transmitir(189) AND (NOT fail_s)) OR (fail_s);
	d(85) <= (transmitir(188) AND (NOT fail_s)) OR (fail_s);
	d(84) <= (transmitir(187) AND (NOT fail_s)) OR (fail_s);
	d(83) <= (transmitir(186) AND (NOT fail_s)) OR (fail_s);
	d(82) <= (transmitir(185) AND (NOT fail_s)) OR (fail_s);
	d(81) <= (transmitir(184) AND (NOT fail_s)) OR (fail_s);
	d(80) <= '0'; -- bit inicio
	d(99) <= '1'; -- bit parada
	d(98) <= (transmitir(183) AND (NOT fail_s)) OR (fail_s);
	d(97) <= (transmitir(182) AND (NOT fail_s)) OR (fail_s);
	d(96) <= (transmitir(181) AND (NOT fail_s)) OR (fail_s);
	d(95) <= (transmitir(180) AND (NOT fail_s)) OR (fail_s);
	d(94) <= (transmitir(179) AND (NOT fail_s)) OR (fail_s);
	d(93) <= (transmitir(178) AND (NOT fail_s)) OR (fail_s);
	d(92) <= (transmitir(177) AND (NOT fail_s)) OR (fail_s);
	d(91) <= (transmitir(176) AND (NOT fail_s)) OR (fail_s); 
	d(90) <= '0'; -- bit inicio
	d(109) <= '1'; -- bit parada
	d(108) <= (transmitir(175) AND (NOT fail_s)) OR (fail_s);
	d(107) <= (transmitir(174) AND (NOT fail_s)) OR (fail_s);
	d(106) <= (transmitir(173) AND (NOT fail_s)) OR (fail_s);
	d(105) <= (transmitir(172) AND (NOT fail_s)) OR (fail_s);
	d(104) <= (transmitir(171) AND (NOT fail_s)) OR (fail_s);
	d(103) <= (transmitir(170) AND (NOT fail_s)) OR (fail_s);
	d(102) <= (transmitir(169) AND (NOT fail_s)) OR (fail_s);
	d(101) <= (transmitir(168) AND (NOT fail_s)) OR (fail_s);
	d(100) <= '0'; -- bit inicio
	d(119) <= '1'; -- bit parada
	d(118) <= (transmitir(167) AND (NOT fail_s)) OR (fail_s);
	d(117) <= (transmitir(166) AND (NOT fail_s)) OR (fail_s);
	d(116) <= (transmitir(165) AND (NOT fail_s)) OR (fail_s);
	d(115) <= (transmitir(164) AND (NOT fail_s)) OR (fail_s);
	d(114) <= (transmitir(163) AND (NOT fail_s)) OR (fail_s);
	d(113) <= (transmitir(162) AND (NOT fail_s)) OR (fail_s);
	d(112) <= (transmitir(161) AND (NOT fail_s)) OR (fail_s);
	d(111) <= (transmitir(160) AND (NOT fail_s)) OR (fail_s);
	d(110) <= '0'; -- bit inicio
	d(129) <= '1'; -- bit parada
	d(128) <= (transmitir(159) AND (NOT fail_s)) OR (fail_s);
	d(127) <= (transmitir(158) AND (NOT fail_s)) OR (fail_s);
	d(126) <= (transmitir(157) AND (NOT fail_s)) OR (fail_s);
	d(125) <= (transmitir(156) AND (NOT fail_s)) OR (fail_s);
	d(124) <= (transmitir(155) AND (NOT fail_s)) OR (fail_s);
	d(123) <= (transmitir(154) AND (NOT fail_s)) OR (fail_s);
	d(122) <= (transmitir(153) AND (NOT fail_s)) OR (fail_s);
	d(121) <= (transmitir(152) AND (NOT fail_s)) OR (fail_s); 
	d(120) <= '0'; -- bit inicio
	d(139) <= '1'; -- bit parada
	d(138) <= (transmitir(151) AND (NOT fail_s)) OR (fail_s);
	d(137) <= (transmitir(150) AND (NOT fail_s)) OR (fail_s);
	d(136) <= (transmitir(149) AND (NOT fail_s)) OR (fail_s);
	d(135) <= (transmitir(148) AND (NOT fail_s)) OR (fail_s);
	d(134) <= (transmitir(147) AND (NOT fail_s)) OR (fail_s);
	d(133) <= (transmitir(146) AND (NOT fail_s)) OR (fail_s);
	d(132) <= (transmitir(145) AND (NOT fail_s)) OR (fail_s);
	d(131) <= (transmitir(144) AND (NOT fail_s)) OR (fail_s); 
	d(130) <= '0'; -- bit inicio
	d(149) <= '1'; -- bit parada
	d(148) <= (transmitir(143) AND (NOT fail_s)) OR (fail_s);
	d(147) <= (transmitir(142) AND (NOT fail_s)) OR (fail_s);
	d(146) <= (transmitir(141) AND (NOT fail_s)) OR (fail_s);
	d(145) <= (transmitir(140) AND (NOT fail_s)) OR (fail_s);
	d(144) <= (transmitir(139) AND (NOT fail_s)) OR (fail_s);
	d(143) <= (transmitir(138) AND (NOT fail_s)) OR (fail_s);
	d(142) <= (transmitir(137) AND (NOT fail_s)) OR (fail_s);
	d(141) <= (transmitir(136) AND (NOT fail_s)) OR (fail_s);
	d(140) <= '0'; -- bit inicio
	d(159) <= '1'; -- bit parada
	d(158) <= (transmitir(135) AND (NOT fail_s)) OR (fail_s);
	d(157) <= (transmitir(134) AND (NOT fail_s)) OR (fail_s);
	d(156) <= (transmitir(133) AND (NOT fail_s)) OR (fail_s);
	d(155) <= (transmitir(132) AND (NOT fail_s)) OR (fail_s);
	d(154) <= (transmitir(131) AND (NOT fail_s)) OR (fail_s);
	d(153) <= (transmitir(130) AND (NOT fail_s)) OR (fail_s);
	d(152) <= (transmitir(129) AND (NOT fail_s)) OR (fail_s);
	d(151) <= (transmitir(128) AND (NOT fail_s)) OR (fail_s); 
	d(150) <= '0'; -- bit inicio
	d(169) <= '1'; -- bit parada
	d(168) <= (transmitir(127) AND (NOT fail_s)) OR (fail_s);
	d(167) <= (transmitir(126) AND (NOT fail_s)) OR (fail_s);
	d(166) <= (transmitir(125) AND (NOT fail_s)) OR (fail_s);
	d(165) <= (transmitir(124) AND (NOT fail_s)) OR (fail_s);
	d(164) <= (transmitir(123) AND (NOT fail_s)) OR (fail_s);
	d(163) <= (transmitir(122) AND (NOT fail_s)) OR (fail_s);
	d(162) <= (transmitir(121) AND (NOT fail_s)) OR (fail_s);
	d(161) <= (transmitir(120) AND (NOT fail_s)) OR (fail_s); 
	d(160) <= '0'; -- bit inicio
	d(179) <= '1'; -- bit parada
	d(178) <= (transmitir(119) AND (NOT fail_s)) OR (fail_s);
	d(177) <= (transmitir(118) AND (NOT fail_s)) OR (fail_s);
	d(176) <= (transmitir(117) AND (NOT fail_s)) OR (fail_s);
	d(175) <= (transmitir(116) AND (NOT fail_s)) OR (fail_s);
	d(174) <= (transmitir(115) AND (NOT fail_s)) OR (fail_s);
	d(173) <= (transmitir(114) AND (NOT fail_s)) OR (fail_s);
	d(172) <= (transmitir(113) AND (NOT fail_s)) OR (fail_s);
	d(171) <= (transmitir(112) AND (NOT fail_s)) OR (fail_s); 
	d(170) <= '0'; -- bit inicio
	d(189) <= '1'; -- bit parada
	d(188) <= (transmitir(111) AND (NOT fail_s)) OR (fail_s);
	d(187) <= (transmitir(110) AND (NOT fail_s)) OR (fail_s);
	d(186) <= (transmitir(109) AND (NOT fail_s)) OR (fail_s);
	d(185) <= (transmitir(108) AND (NOT fail_s)) OR (fail_s);
	d(184) <= (transmitir(107) AND (NOT fail_s)) OR (fail_s);
	d(183) <= (transmitir(106) AND (NOT fail_s)) OR (fail_s);
	d(182) <= (transmitir(105) AND (NOT fail_s)) OR (fail_s);
	d(181) <= (transmitir(104) AND (NOT fail_s)) OR (fail_s);
	d(180) <= '0'; -- bit inicio
	d(199) <= '1'; -- bit parada
	d(198) <= (transmitir(103) AND (NOT fail_s)) OR (fail_s);
	d(197) <= (transmitir(102) AND (NOT fail_s)) OR (fail_s);
	d(196) <= (transmitir(101) AND (NOT fail_s)) OR (fail_s);
	d(195) <= (transmitir(100) AND (NOT fail_s)) OR (fail_s);
	d(194) <= (transmitir(99) AND (NOT fail_s)) OR (fail_s);
	d(193) <= (transmitir(98) AND (NOT fail_s)) OR (fail_s);
	d(192) <= (transmitir(97) AND (NOT fail_s)) OR (fail_s);
	d(191) <= (transmitir(96) AND (NOT fail_s)) OR (fail_s); 
	d(190) <= '0'; -- bit inicio
	d(209) <= '1'; -- bit parada
	d(208) <= (transmitir(95) AND (NOT fail_s)) OR (fail_s);
	d(207) <= (transmitir(94) AND (NOT fail_s)) OR (fail_s);
	d(206) <= (transmitir(93) AND (NOT fail_s)) OR (fail_s);
	d(205) <= (transmitir(92) AND (NOT fail_s)) OR (fail_s);
	d(204) <= (transmitir(91) AND (NOT fail_s)) OR (fail_s);
	d(203) <= (transmitir(90) AND (NOT fail_s)) OR (fail_s);
	d(202) <= (transmitir(89) AND (NOT fail_s)) OR (fail_s);
	d(201) <= (transmitir(88) AND (NOT fail_s)) OR (fail_s); 
	d(200) <= '0'; -- bit inicio
	d(219) <= '1'; -- bit parada
	d(218) <= (transmitir(87) AND (NOT fail_s)) OR (fail_s);
	d(217) <= (transmitir(86) AND (NOT fail_s)) OR (fail_s);
	d(216) <= (transmitir(85) AND (NOT fail_s)) OR (fail_s);
	d(215) <= (transmitir(84) AND (NOT fail_s)) OR (fail_s);
	d(214) <= (transmitir(83) AND (NOT fail_s)) OR (fail_s);
	d(213) <= (transmitir(82) AND (NOT fail_s)) OR (fail_s);
	d(212) <= (transmitir(81) AND (NOT fail_s)) OR (fail_s);
	d(211) <= (transmitir(80) AND (NOT fail_s)) OR (fail_s);
	d(210) <= '0'; -- bit de inicio
	d(229) <= '1'; -- bit de parada
	d(228) <= (transmitir(79) AND (NOT fail_s)) OR (fail_s); 
	d(227) <= (transmitir(78) AND (NOT fail_s)) OR (fail_s);
	d(226) <= (transmitir(77) AND (NOT fail_s)) OR (fail_s);
	d(225) <= (transmitir(76) AND (NOT fail_s)) OR (fail_s);
	d(224) <= (transmitir(75) AND (NOT fail_s)) OR (fail_s);
	d(223) <= (transmitir(74) AND (NOT fail_s)) OR (fail_s);
	d(222) <= (transmitir(73) AND (NOT fail_s)) OR (fail_s);
	d(221) <= (transmitir(72) AND (NOT fail_s)) OR (fail_s);
	d(220) <= '0'; -- bit de inicio
	d(239) <= '1'; -- bit de parada
	d(238) <= (transmitir(71) AND (NOT fail_s)) OR (fail_s);
	d(237) <= (transmitir(70) AND (NOT fail_s)) OR (fail_s);
	d(236) <= (transmitir(69) AND (NOT fail_s)) OR (fail_s);
	d(235) <= (transmitir(68) AND (NOT fail_s)) OR (fail_s);
	d(234) <= (transmitir(67) AND (NOT fail_s)) OR (fail_s);
	d(233) <= (transmitir(66) AND (NOT fail_s)) OR (fail_s);
	d(232) <= (transmitir(65) AND (NOT fail_s)) OR (fail_s);
	d(231) <= (transmitir(64) AND (NOT fail_s)) OR (fail_s);
	d(230) <= '0'; -- bit de inicio
	d(249) <= '1'; -- bit de parada
	d(248) <= (transmitir(63) AND (NOT fail_s)) OR (fail_s);
	d(247) <= (transmitir(62) AND (NOT fail_s)) OR (fail_s);
	d(246) <= (transmitir(61) AND (NOT fail_s)) OR (fail_s);
	d(245) <= (transmitir(60) AND (NOT fail_s)) OR (fail_s);
	d(244) <= (transmitir(59) AND (NOT fail_s)) OR (fail_s);
	d(243) <= (transmitir(58) AND (NOT fail_s)) OR (fail_s);
	d(242) <= (transmitir(57) AND (NOT fail_s)) OR (fail_s);
	d(241) <= (transmitir(56) AND (NOT fail_s)) OR (fail_s);
	d(240) <= '0'; -- bit de inicio
	d(259) <= '1'; -- bit de parada
	d(258) <= (transmitir(55) AND (NOT fail_s)) OR (fail_s);
	d(257) <= (transmitir(54) AND (NOT fail_s)) OR (fail_s);
	d(256) <= (transmitir(53) AND (NOT fail_s)) OR (fail_s);
	d(255) <= (transmitir(52) AND (NOT fail_s)) OR (fail_s);
	d(254) <= (transmitir(51) AND (NOT fail_s)) OR (fail_s);
	d(253) <= (transmitir(50) AND (NOT fail_s)) OR (fail_s);
	d(252) <= (transmitir(49) AND (NOT fail_s)) OR (fail_s);
	d(251) <= (transmitir(48) AND (NOT fail_s)) OR (fail_s);
	d(250) <= '0'; -- bit de inicio
	d(269) <= '1'; -- bit de parada
	d(268) <= (transmitir(47) AND (NOT fail_s)) OR (fail_s);
	d(267) <= (transmitir(46) AND (NOT fail_s)) OR (fail_s);
	d(266) <= (transmitir(45) AND (NOT fail_s)) OR (fail_s);
	d(265) <= (transmitir(44) AND (NOT fail_s)) OR (fail_s);
	d(264) <= (transmitir(43) AND (NOT fail_s)) OR (fail_s);
	d(263) <= (transmitir(42) AND (NOT fail_s)) OR (fail_s);
	d(262) <= (transmitir(41) AND (NOT fail_s)) OR (fail_s);
	d(261) <= (transmitir(40) AND (NOT fail_s)) OR (fail_s);
	d(260) <= '0'; -- bit de inicio
	d(279) <= '1'; -- bit de parada
	d(278) <= (transmitir(39) AND (NOT fail_s)) OR (fail_s);
	d(277) <= (transmitir(38) AND (NOT fail_s)) OR (fail_s);
	d(276) <= (transmitir(37) AND (NOT fail_s)) OR (fail_s);
	d(275) <= (transmitir(36) AND (NOT fail_s)) OR (fail_s);
	d(274) <= (transmitir(35) AND (NOT fail_s)) OR (fail_s);
	d(273) <= (transmitir(34) AND (NOT fail_s)) OR (fail_s);
	d(272) <= (transmitir(33) AND (NOT fail_s)) OR (fail_s);
	d(271) <= (transmitir(32) AND (NOT fail_s)) OR (fail_s);
	d(270) <= '0'; -- bit de inicio
	d(289) <= '1'; -- bit de parada
	d(288) <= (transmitir(31) AND (NOT fail_s)) OR (fail_s);
	d(287) <= (transmitir(30) AND (NOT fail_s)) OR (fail_s);
	d(286) <= (transmitir(29) AND (NOT fail_s)) OR (fail_s);
	d(285) <= (transmitir(28) AND (NOT fail_s)) OR (fail_s);
	d(284) <= (transmitir(27) AND (NOT fail_s)) OR (fail_s);
	d(283) <= (transmitir(26) AND (NOT fail_s)) OR (fail_s);
	d(282) <= (transmitir(25) AND (NOT fail_s)) OR (fail_s);
	d(281) <= (transmitir(24) AND (NOT fail_s)) OR (fail_s);
	d(280) <= '0'; -- bit de inicio
	d(299) <= '1'; -- bit de parada
	d(298) <= (transmitir(23) AND (NOT fail_s)) OR (fail_s);
	d(297) <= (transmitir(22) AND (NOT fail_s)) OR (fail_s);
	d(296) <= (transmitir(21) AND (NOT fail_s)) OR (fail_s);
	d(295) <= (transmitir(20) AND (NOT fail_s)) OR (fail_s);
	d(294) <= (transmitir(19) AND (NOT fail_s)) OR (fail_s);
	d(293) <= (transmitir(18) AND (NOT fail_s)) OR (fail_s);
	d(292) <= (transmitir(17) AND (NOT fail_s)) OR (fail_s);
	d(291) <= (transmitir(16) AND (NOT fail_s)) OR (fail_s);
	d(290) <= '0'; -- bit de inicio
	d(309) <= '1'; -- bit de parada
	d(308) <= (transmitir(15) AND (NOT fail_s)) OR (fail_s);
	d(307) <= (transmitir(14) AND (NOT fail_s)) OR (fail_s);
	d(306) <= (transmitir(13) AND (NOT fail_s)) OR (fail_s);
	d(305) <= (transmitir(12) AND (NOT fail_s)) OR (fail_s);
	d(304) <= (transmitir(11) AND (NOT fail_s)) OR (fail_s);
	d(303) <= (transmitir(10) AND (NOT fail_s)) OR (fail_s);
	d(302) <= (transmitir(9) AND (NOT fail_s)) OR (fail_s);
	d(301) <= (transmitir(8) AND (NOT fail_s)) OR (fail_s);
	d(300) <= '0'; -- bit de inicio
	d(319) <= '1'; -- bit de parada
	d(318) <= (transmitir(7) AND (NOT fail_s)) OR (fail_s);
	d(317) <= (transmitir(6) AND (NOT fail_s)) OR (fail_s);
	d(316) <= (transmitir(5) AND (NOT fail_s)) OR (fail_s);
	d(315) <= (transmitir(4) AND (NOT fail_s)) OR (fail_s);
	d(314) <= (transmitir(3) AND (NOT fail_s)) OR (fail_s);
	d(313) <= (transmitir(2) AND (NOT fail_s)) OR (fail_s);
	d(312) <= (transmitir(1) AND (NOT fail_s)) OR (fail_s);
	d(311) <= (transmitir(0) AND (NOT fail_s)) OR (fail_s);
	d(310) <= '0'; -- bit de inicio
	d(329) <= '1'; -- bit de parada
	d(328) <= (transmitir_n(31) AND (NOT fail_s)) OR (fail_s);
	d(327) <= (transmitir_n(30) AND (NOT fail_s)) OR (fail_s);
	d(326) <= (transmitir_n(29) AND (NOT fail_s)) OR (fail_s);
	d(325) <= (transmitir_n(28) AND (NOT fail_s)) OR (fail_s);
	d(324) <= (transmitir_n(27) AND (NOT fail_s)) OR (fail_s);
	d(323) <= (transmitir_n(26) AND (NOT fail_s)) OR (fail_s);
	d(322) <= (transmitir_n(25) AND (NOT fail_s)) OR (fail_s);
	d(321) <= (transmitir_n(24) AND (NOT fail_s)) OR (fail_s);
	d(320) <= '0'; -- bit de inicio
	d(339) <= '1'; -- bit de parada
	d(338) <= (transmitir_n(23) AND (NOT fail_s)) OR (fail_s);
	d(337) <= (transmitir_n(22) AND (NOT fail_s)) OR (fail_s);
	d(336) <= (transmitir_n(21) AND (NOT fail_s)) OR (fail_s);
	d(335) <= (transmitir_n(20) AND (NOT fail_s)) OR (fail_s);
	d(334) <= (transmitir_n(19) AND (NOT fail_s)) OR (fail_s);
	d(333) <= (transmitir_n(18) AND (NOT fail_s)) OR (fail_s);
	d(332) <= (transmitir_n(17) AND (NOT fail_s)) OR (fail_s);
	d(331) <= (transmitir_n(16) AND (NOT fail_s)) OR (fail_s);
	d(330) <= '0'; -- bit de inicio
--------------------------------------------------
   d(349) <= '1';
	d(348) <= (transmitir_n(15) AND (NOT fail_s)) OR (fail_s);
	d(347) <= (transmitir_n(14) AND (NOT fail_s)) OR (fail_s);
	d(346) <= (transmitir_n(13) AND (NOT fail_s)) OR (fail_s);
	d(345) <= (transmitir_n(12) AND (NOT fail_s)) OR (fail_s);
	d(344) <= (transmitir_n(11) AND (NOT fail_s)) OR (fail_s);
	d(343) <= (transmitir_n(10) AND (NOT fail_s)) OR (fail_s);
	d(342) <= (transmitir_n(9) AND (NOT fail_s)) OR (fail_s);
	d(341) <= (transmitir_n(8) AND (NOT fail_s)) OR (fail_s);
	d(340) <= '0';
	d(359) <= '1';
	d(358) <= (transmitir_n(7) AND (NOT fail_s)) OR (fail_s);
	d(357) <= (transmitir_n(6) AND (NOT fail_s)) OR (fail_s);
	d(356) <= (transmitir_n(5) AND (NOT fail_s)) OR (fail_s);
	d(355) <= (transmitir_n(4) AND (NOT fail_s)) OR (fail_s);
	d(354) <= (transmitir_n(3) AND (NOT fail_s)) OR (fail_s);
	d(353) <= (transmitir_n(2) AND (NOT fail_s)) OR (fail_s);
	d(352) <= (transmitir_n(1) AND (NOT fail_s)) OR (fail_s);
	d(351) <= (transmitir_n(0) AND (NOT fail_s)) OR (fail_s);
	d(350) <= '0';
	----------------------------tiempo
	d(369) <= '1';
	d(368) <= (transmitir_t(15) AND (NOT fail_s)) OR (fail_s);
	d(367) <= (transmitir_t(14) AND (NOT fail_s)) OR (fail_s);
	d(366) <= (transmitir_t(13) AND (NOT fail_s)) OR (fail_s);
	d(365) <= (transmitir_t(12) AND (NOT fail_s)) OR (fail_s);
	d(364) <= (transmitir_t(11) AND (NOT fail_s)) OR (fail_s);
	d(363) <= (transmitir_t(10) AND (NOT fail_s)) OR (fail_s);
	d(362) <= (transmitir_t(9) AND (NOT fail_s)) OR (fail_s);
	d(361) <= (transmitir_t(8) AND (NOT fail_s)) OR (fail_s);
	d(360) <= '0';
	d(379) <= '1';
	d(378) <= (transmitir_t(7) AND (NOT fail_s)) OR (fail_s);
	d(377) <= (transmitir_t(6) AND (NOT fail_s)) OR (fail_s);
	d(376) <= (transmitir_t(5) AND (NOT fail_s)) OR (fail_s);
	d(375) <= (transmitir_t(4) AND (NOT fail_s)) OR (fail_s);
	d(374) <= (transmitir_t(3) AND (NOT fail_s)) OR (fail_s);
	d(373) <= (transmitir_t(2) AND (NOT fail_s)) OR (fail_s);
	d(372) <= (transmitir_t(1) AND (NOT fail_s)) OR (fail_s);
	d(371) <= (transmitir_t(0) AND (NOT fail_s)) OR (fail_s);
	d(370) <= '0';
	
	
	PROCESS (clk, rst)
	BEGIN
		IF (rst='0') THEN
			buffer_s <= (OTHERS => '1');
		ELSIF (rising_edge(clk)) THEN
			IF (ena_guardar='1' AND ena_desplazar='0') THEN
				buffer_s <= d;
			ELSIF (ena_guardar='0' AND ena_desplazar='1') THEN
				buffer_s <= '1' & buffer_s(MAX_WIDTH-1 DOWNTO 1);
			ELSE
			buffer_s<= buffer_s;
			END IF;
		END IF;
	END PROCESS;
	
	dout <= buffer_s(0);
END ARCHITECTURE;