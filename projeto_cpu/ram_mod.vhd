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
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.libcpu.all; -- uso do pacote libcpu para addr_SP e tipos

entity RAM_64kx16 is
    Port(
        CLK    : in  std_logic;
        DIN    : in  std_logic_vector(15 downto 0);
        ADDR   : in  std_logic_vector(15 downto 0);
        WE     : in  std_logic;
        DOUT   : out std_logic_vector(15 downto 0);
        POS_SP : out std_logic_vector(15 downto 0)
    );
end RAM_64kx16;

architecture rtl of RAM_64kx16 is

    type RAM_t is array(0 to 65535) of std_logic_vector(15 downto 0);

    -- Inicialização da memória:
    -- * Endereços 0x0000 - 0x0008: periféricos mapeados (btn, enc, kdr, udr, usr, led, ssd, ldr, lcr).
    --   Inicialmente todos zero. Em tempo de execução, o processador lerá/escreverá neles.
    --
    -- * A execução começa em 0x0010. Vamos colocar o exemplo do simple.asm, 
    --   conforme gerado por as-puc16:
    --   
    --   simple.asm:
    --   16 => "0000000000000000", -- mov r0, 0
    --   17 => "1001000000000001", -- add r0, r0, 1
    --   18 => "0010000011111110", -- b @loop
    --
    -- * Caso precisemos colocar dados do hello.c em 0x1000 (4096), usando 
    --   a saída do compilador (exemplo do data a partir de 4096):
    --   4096 => "0000000001001000", -- .dw 72 ('H')
    --   4097 => "0000000001100101", -- .dw 101 ('e')
    --   4098 => "0000000001101100", -- .dw 108 ('l')
    --   ... e assim por diante
    --
    -- * O restante da memória será inicializado com zeros.

    constant addr_SP : std_logic_vector(15 downto 0) := x"1FFF"; -- Topo da pilha

    signal ram : RAM_t := (
        -- I/O mapeado (0x0000 a 0x0008):
        0 => (others => '0'), -- btn
        1 => (others => '0'), -- enc
        2 => (others => '0'), -- kdr
        3 => (others => '0'), -- udr
        4 => (others => '0'), -- usr
        5 => (others => '0'), -- led
        6 => (others => '0'), -- ssd
        7 => (others => '0'), -- ldr
        8 => (others => '0'), -- lcr

        -- Espaço até 0x000F (15 decimal):
        9 to 15 => (others => '0'), 

        -- Instruções do simple.asm começando em 0x0010 (decimal 16):
        16 => "0000000000000000", -- mov r0,0
        17 => "1001000000000001", -- add r0,r0,1
        18 => "0010000011111110", -- b @loop
        
        -- Espaço entre 19 e 4095 livre:
        19 to 4095 => (others => '0'),

        -- Exemplo de dados do hello.c (não obrigatório, só ilustrando):
        4096 => "0000000001001000", -- 'H' (72)
        4097 => "0000000001100101", -- 'e' (101)
        4098 => "0000000001101100", -- 'l' (108)
        4099 => "0000000001101100", -- 'l' (108)
        4100 => "0000000001101111", -- 'o' (111)
        4101 => "0000000000101100", -- ',' (44)
        4102 => "0000000000100000", -- ' ' (32)
        4103 => "0000000001110111", -- 'w' (119)
        4104 => "0000000001101111", -- 'o' (111)
        4105 => "0000000001110010", -- 'r' (114)
        4106 => "0000000001101100", -- 'l' (108)
        4107 => "0000000001100100", -- 'd' (100)
        4108 => "0000000000100001", -- '!' (33)
        4109 => "0000000000000000", -- 0 terminador da string

        -- Resto da memória até 0x1FFE:
        4110 to 8190 => (others => '0'),

        -- O topo da pilha em 0x1FFF (8191 decimal), podemos deixar zero inicialmente:
        8191 => (others => '0'),

        -- Demais endereços, caso algum seja necessário:
        8192 to 65535 => (others => '0')
    );

    signal read_address : std_logic_vector(15 downto 0) := (others => '0');

begin

    -- Processo síncrono na borda de descida do CLK:
    -- Se WE='1', escrevemos DIN no endereço ADDR.
    -- Também atualizamos read_address para leitura síncrona.
    process(CLK)
    begin
        if falling_edge(CLK) then
            if WE = '1' then
                ram(to_integer(unsigned(ADDR))) <= DIN;
            end if;
            read_address <= ADDR;
        end if;
    end process;

    -- A saída DOUT apresenta o dado da RAM no endereço read_address registrado:
    DOUT <= ram(to_integer(unsigned(read_address)));

    -- POS_SP retorna o conteúdo no endereço do stack pointer, útil para debug:
    POS_SP <= ram(to_integer(unsigned(addr_SP)));

end rtl;
