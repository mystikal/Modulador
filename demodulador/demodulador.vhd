----------------------------------------------------------------------------------
-- Engineer: Juan Herrero Macias
-- 
-- Create Date:    18:37:36 11/20/2013 
-- Design Name: 
-- Module Name:    demodulador - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity demodulador is
    Port ( modulada : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           leds : out  STD_LOGIC_VECTOR (7 downto 0);
           segmentos : out STD_LOGIC_VECTOR (7 downto 0);
           anodo : out STD_LOGIC_VECTOR (3 downto 0));
end demodulador;

-- Esta arquitectura integra los modulos detector_Byte y detector_Cabecera

architecture Behavioral of demodulador is
signal cabecera_Detectada: STD_LOGIC;
signal modulada_Sincronizada: STD_LOGIC;
signal modo: INTEGER range 3 downto 0;
begin

detector_Cabecera: entity work.detector_Cabecera
	Port Map ( 
		clk => clk,
		reset => reset,
		modulada => modulada_Sincronizada,
		cabecera_Detectada => cabecera_Detectada
		);
		
detector_Byte: entity work.detector_Byte
	Port Map ( 
		clk => clk,
		reset => reset,
		modulada => modulada_Sincronizada,
		cabecera_Detectada => cabecera_Detectada,
		leds => leds,
		modo => modo
		);
		
display_Modo: entity work.display_Modo
	Port Map ( 
		clk => clk,
		reset => reset,
		segmentos => segmentos,
		anodo => anodo,
		modo => modo
		);
		
sincronizador: entity work.sincronizador
	Port Map (
		clk => clk,
		reset => reset,
		modulada => modulada,
		modulada_Sincronizada => modulada_Sincronizada
		);

		
end Behavioral;

