----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:13:43 10/26/2017 
-- Design Name: 
-- Module Name:    automata - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity automata is
    Port ( CLK : in  STD_LOGIC; -- Reloj del aut�mata
           C0 : in  STD_LOGIC; -- Condici�n de decision para "0"
           C1 : in  STD_LOGIC; -- Condici�n de decisi�n para "1"
           DATO : out  STD_LOGIC; -- Datos a cargar
           CAPTUR  : out  STD_LOGIC; -- Enable del reg. de desplaz.
           VALID : out  STD_LOGIC); -- Enable del reg. de validaci�n
end automata;

architecture a_automata of automata is
type TIPO_ESTADO is (ESP_SYNC,AVAN_ZM,MUESTREO,DATO0,DATO1,DATOSYNC);
signal ST : TIPO_ESTADO:= ESP_SYNC ; -- Estado inicial en que arranca
signal salidas : : STD_LOGIC_VECTOR (2 downto 0) :="000";

begin
 process (CLK)
 variable cont : STD_LOGIC_VECTOR (7 downto 0):="00000000"; -- contador
									-- para contar ciclos en un estado, iniciado a 0
	begin
		if (CLK'event and CLK = '1') then
			case ST is
				when ESP_SYNC => -- Estado normal, dura 1 ciclo de reloj
					if {CONDICIONES DE LAS ENTRADAS} then
						ST<={NUEVO ESTADO};
						-- otras condiciones juto aqui
					end if;
				when AVAN_ZM => -- Estado que dura 20 ciclos de reloj
					
					cont:= cont+1; -- Se incrementa el contador.
					if (cont=20) then -- Si llega a 20
						cont:=(others=>'0'); -- Poner el contador a 0
						ST<=MUESTREO; -- Y cambiar de estado
					else
						ST<=AVAN_ZM; -- Si no ha llegado a 20 permanecer
					end if; -- en el mismo estado
					-- Otros estados
			end case;
		end if;
	end process;
 
 with ST select
				salidas<=
								"000" when ESP_SYNC,
								"XXX" when AVAN_ZM,
								"XXX" when ...,
								--aqui faltan mas salidas
								"000" when others;

DATO <= salidas(2);
CAPTUR <= salidas(1);
VALID <= salidas(0);
end a_automata;
