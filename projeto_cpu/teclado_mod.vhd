----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:25:28 12/07/2024 
-- Design Name: 
-- Module Name:    teclado_mod - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity teclado_mod is
end teclado_mod;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity teclado_mod is
    Port (
        PS2_DATA : in  STD_LOGIC;              -- Dados do teclado PS/2
        PS2_CLK  : in  STD_LOGIC;              -- Clock do teclado PS/2
        CLK      : in  STD_LOGIC;              -- Clock principal da FPGA
        tecla    : out STD_LOGIC_VECTOR(7 downto 0); -- Código da tecla pressionada
        valido   : out STD_LOGIC               -- Indica se uma tecla válida foi lida
    );
end teclado_mod;

architecture Behavioral of teclado_mod is
    -- Sinais internos
    signal ps2_clk_sync : STD_LOGIC;                 -- Clock sincronizado
    signal shift_reg : STD_LOGIC_VECTOR(8 downto 0); -- Registrador de deslocamento
    signal bit_count : INTEGER range 0 to 10 := 0;   -- Contador de bits recebidos
    signal tecla_stable : STD_LOGIC_VECTOR(7 downto 0) := (others => '0'); -- Código final da tecla
    signal tecla_valida : STD_LOGIC := '0';          -- Sinal de validade da tecla

    -- Sincronizador para evitar metaestabilidade
    signal clk_sync : STD_LOGIC_VECTOR(1 downto 0) := (others => '1');
begin
    -- Sincronizador para o clock do teclado
    process(CLK)
    begin
        if rising_edge(CLK) then
            clk_sync <= clk_sync(0) & PS2_CLK;
        end if;
    end process;

    ps2_clk_sync <= clk_sync(1); -- Clock sincronizado

    -- Máquina de estados para captura de dados do teclado
    process(ps2_clk_sync)
    begin
        if falling_edge(ps2_clk_sync) then -- Bordas negativas do clock sincronizado
            case bit_count is
                when 0 =>
                    -- Espera pelo start bit
                    if PS2_DATA = '0' then
                        bit_count <= 1;
                    end if;
                when 1 to 8 =>
                    -- Captura os 8 bits de dados
                    shift_reg <= PS2_DATA & shift_reg(8 downto 1);
                    bit_count <= bit_count + 1;
                when 9 =>
                    -- Ignora o bit de paridade
                    bit_count <= bit_count + 1;
                when 10 =>
                    -- Stop bit e finalização
                    if PS2_DATA = '1' then
                        tecla_stable <= shift_reg(7 downto 0); -- Armazena o código da tecla
                        tecla_valida <= '1'; -- Marca como válida
                    end if;
                    bit_count <= 0; -- Reinicia o contador
                when others =>
                    bit_count <= 0; -- Estado inválido
            end case;
        end if;
    end process;

    -- Saídas
    tecla <= tecla_stable;
    valido <= tecla_valida;
end Behavioral;


