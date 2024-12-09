library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.libcpu.all;

entity teclado_mod is
    Port (
        PS2_DATA : in  STD_LOGIC;
        PS2_CLK  : in  STD_LOGIC;
        CLK      : in  STD_LOGIC;
        RESET    : in  STD_LOGIC;
        tecla    : out byte;
        valido   : out STD_LOGIC
    );
end teclado_mod;

architecture Behavioral of teclado_mod is
    signal ps2_clk_sync : STD_LOGIC;
    signal shift_reg    : STD_LOGIC_VECTOR(8 downto 0);
    signal bit_count    : INTEGER range 0 to 10 := 0;
    signal tecla_stable : byte := (others => '0');
    signal tecla_valida : STD_LOGIC := '0';

    signal clk_sync : STD_LOGIC_VECTOR(1 downto 0) := (others => '1');

    signal ps2_clk_prev : STD_LOGIC := '1';
    signal ps2_clk_clean : STD_LOGIC := '1';

begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            clk_sync <= clk_sync(0) & PS2_CLK;
        end if;
    end process;

    ps2_clk_sync <= clk_sync(1);

    process(CLK)
    begin
        if rising_edge(CLK) then
            if ps2_clk_sync /= ps2_clk_prev then
                ps2_clk_prev <= ps2_clk_sync;
                ps2_clk_clean <= '0';
            else
                ps2_clk_clean <= '1';
            end if;
        end if;
    end process;

    process(ps2_clk_clean, RESET)
    begin
        if RESET = '1' then
            bit_count <= 0;
            tecla_stable <= (others => '0');
            tecla_valida <= '0';
        elsif falling_edge(ps2_clk_clean) then
            case bit_count is
                when 0 =>
                    if PS2_DATA = '0' then
                        bit_count <= 1;
                    end if;
                when 1 to 8 =>
                    shift_reg <= PS2_DATA & shift_reg(8 downto 1);
                    bit_count <= bit_count + 1;
                when 9 =>
                    bit_count <= bit_count + 1;
                when 10 =>
                    if PS2_DATA = '1' then
                        tecla_stable <= shift_reg(7 downto 0);
                        tecla_valida <= '1';
                    end if;
                    bit_count <= 0;
                when others =>
                    bit_count <= 0;
            end case;
        end if;
    end process;

    tecla <= tecla_stable;
    valido <= tecla_valida;

end Behavioral;
