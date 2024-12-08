----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:13:49 12/07/2024 
-- Design Name: 
-- Module Name:    ram_mod - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Updated RAM Module for Integration
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.02 - File Updated
-- Additional Comments: Added support for LCD integration and consistent signal handling
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM_8x8192 is
    port (
        CLK      : in std_logic;
        DIN      : in std_logic_vector(15 downto 0);
        ADDR     : in std_logic_vector(12 downto 0); -- 13 bits para 8192 palavras
        WE       : in std_logic;
        DOUT     : out std_logic_vector(15 downto 0);
        POS_255  : out std_logic_vector(15 downto 0)  -- Valor fixo para endereço 255
    );
end RAM_8x8192;

architecture Behavioral of RAM_8x8192 is
    
    type RAM_t is array(0 to 8191) of std_logic_vector(15 downto 0);
    signal ram : RAM_t := (
        0 => "0000000000000001", -- add     Ra Rb                   -- Ra = 17
        1 => "0000000000000011", -- add     Ra Rd (overflow)        -- Ra = 15
        2 => "0001000000000001", -- sub     Ra Rb                   -- Ra = 0
        3 => "0010000000000000", -- inc     Ra                      -- Ra = 1
        4 => "0010000000000000", -- inc     Ra                      -- Ra = 2
        5 => "0010010100000000", -- dec     Rb                      -- Rb = 14
        6 => "0010000100000000", -- dec     Ra                      -- Ra = 1
        7 => "0011000100000001", -- and     Ra Rb                   -- Ra = 0
        8 => "0100001100000000", -- or      Ra Rd                   -- Ra = 254
        9 => "0100001100000000", -- or      Ra Rd                   -- Ra = 254
        10 => "1000000000000000", -- push   Ra      
        11 => "1000010000000000", -- push   Rb      
        12 => "1000100000000000", -- push   Rc      
        13 => "1000000100000000", -- pop    Ra                      -- Ra = 68
        14 => "1000100100000000", -- pop    Rc                      -- Rc = 14
        15 => "1000001000000000", -- st     Ra 0x--     
        16 => "0000000000000000", -- [COMP st]      
        17 => "1000001100000000", -- ld     Ra 0x--     
        18 => "0000000000000001", -- [COMP lt]                      -- Ra = 3
        19 => "1001001000000000", -- ldr    Ra Rc                   -- Ra = 137
        20 => "1010001100000000", -- str    Ra Rd                   -- MEM[Rd = 254] = 137
        21 => "1011000100000000", -- mov    Ra Rb                   -- Ra = 14
        22 => "1100000000000000", -- jmp    0x--   (jmp para 25)
        23 => "1000000000000000", -- [COMP jmp]    (ponteiro)
        24 => "0010000000000000", -- inc    Ra [NO DEVE SER EXEC]  -- Ra = 15 / Ra = 14
        25 => "0000000000000000", -- add    Ra Ra                   -- Ra = 28
        26 => "0000000000000000", -- add    Ra Ra                   -- Ra = 56
        27 => "1100000100000000", -- jmpr   Ra
        28 => "0010000000000000", -- inc    Ra [NO DEVE SER EXEC]  -- Ra = 57 / Ra = 56
        56 => "0010000100000000", -- dec    Ra                      -- Ra = 55
        57 => "1000111000000000", -- st     Rd 0x--
        58 => "1111111111111111", -- [COMP st POS 255]
        59 => "1000001000000000", -- st     Ra 0x--
        60 => "1111111111111111", -- [COMP st POS 255]
        128 => "0001100100000000", -- Exemplo de dado adicional
        255 => "1111111111111111", -- Conteúdo para POS_255 (fixo)
        others => "1111000011110000" -- Dados default
    );

    signal read_address : std_logic_vector(12 downto 0) := (others => '0');

begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            if WE = '1' then
                ram(to_integer(unsigned(ADDR))) <= DIN; -- Escrita na memória
            end if;
            read_address <= ADDR; -- Atualização do endereço de leitura
        end if;
    end process;

    DOUT <= ram(to_integer(unsigned(read_address))); -- Saída dos dados
    POS_255 <= ram(255); -- Retornar conteúdo do endereço fixo 255

end Behavioral;
