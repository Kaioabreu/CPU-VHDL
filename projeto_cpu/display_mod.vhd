----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:52:31 12/08/2024 
-- Design Name: 
-- Module Name:    display_mod - Behavioral 
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

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
--
-- Create Date:    DD:MM:YY HH:MM:SS
-- Design Name:    Display de 7 segmentos
-- Module Name:    display_mod - Behavioral
-- Project Name:
-- Target Devices:
-- Tool versions:
-- Description:
--   Módulo responsável por receber um valor em 4 bits (num) e converter este valor
--   em um padrão de 7 segmentos (seg), adequados para a representação de um dígito
--   hexadecimal (0-9 e fallback) em um display de 7 segmentos comum (a, b, c, d, e, f, g).
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------

entity display_mod is
    Port (
        num : in  STD_LOGIC_VECTOR(3 downto 0);  -- Número em 4 bits (0 a 9) a ser exibido no display
        seg : out STD_LOGIC_VECTOR(6 downto 0)   -- Saída para os segmentos: a,b,c,d,e,f,g
    );
end display_mod;

architecture Behavioral of display_mod is
begin
    ----------------------------------------------------------------------------
    -- O processo abaixo é sensível à entrada 'num' e atualiza a saída 'seg'
    -- de acordo com o valor recebido. Cada caso do 'case' representa um dígito
    -- a ser exibido, definindo qual segmento acender ('0') e qual segmento
    -- apagar ('1'), dependendo da convenção adotada.
    --
    -- Notas sobre o display de 7 segmentos:
    --  Cada posição do vetor 'seg' corresponde a um segmento do display:
    --    seg(6) -> a
    --    seg(5) -> b
    --    seg(4) -> c
    --    seg(3) -> d
    --    seg(2) -> e
    --    seg(1) -> f
    --    seg(0) -> g
    --
    -- O padrão usado aqui é ativo em '0', ou seja, para acender um segmento o bit
    -- é '0' e para apagar é '1'. Isso é uma convenção comum.
    ----------------------------------------------------------------------------

    process(num)
    begin
        case num is
            when "0000" => seg <= "0000001"; -- Exibe '0'
            when "0001" => seg <= "1001111"; -- Exibe '1'
            when "0010" => seg <= "0010010"; -- Exibe '2'
            when "0011" => seg <= "0000110"; -- Exibe '3'
            when "0100" => seg <= "1001100"; -- Exibe '4'
            when "0101" => seg <= "0100100"; -- Exibe '5'
            when "0110" => seg <= "0100000"; -- Exibe '6'
            when "0111" => seg <= "0001111"; -- Exibe '7'
            when "1000" => seg <= "0000000"; -- Exibe '8'
            when "1001" => seg <= "0000100"; -- Exibe '9'
            when others => seg <= "1111111"; -- Estado inválido: Apaga todos os segmentos
        end case;
    end process;

end Behavioral;

