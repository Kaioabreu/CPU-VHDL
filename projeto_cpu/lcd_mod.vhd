----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:23:07 12/08/2024 
-- Design Name: 
-- Module Name:    lcd_mod - Behavioral 
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

entity lcd_mod is
    port(
        clk     : in   STD_LOGIC;
        reset   : in   STD_LOGIC;
        lcd_e   : out  STD_LOGIC;
        lcd_rs  : out  STD_LOGIC;
        lcd_rw  : out  STD_LOGIC;
        sf_d    : out  STD_LOGIC_VECTOR(3 downto 0);
        ir      : in   STD_LOGIC_VECTOR(7 downto 0) -- Instrução da RAM
    );
end lcd_mod;

architecture Behavioral of lcd_mod is

    -- Tabela de mapeamento de instruções para texto legível
    type TEXT_MAP_ROM_t is array (0 to 255) of std_logic_vector(8*16-1 downto 0); -- 16 chars
    constant TEXT_MAP_ROM : TEXT_MAP_ROM_t := (
        -- Mapear as instruções presentes na RAM
        0    => to_std_logic_vector("add RA, RB      "), -- add Ra, Rb
        1    => to_std_logic_vector("add RA, RD      "), -- add Ra, Rd
        2    => to_std_logic_vector("add RB, RA      "), -- add Rb, Ra
        3    => to_std_logic_vector("add RB, RD      "), -- add Rb, Rd
        4    => to_std_logic_vector("sub RA, RB      "), -- sub Ra, Rb
        5    => to_std_logic_vector("sub RA, RD      "), -- sub Ra, Rd
        6    => to_std_logic_vector("sub RB, RA      "), -- sub Rb, Ra
        7    => to_std_logic_vector("sub RB, RD      "), -- sub Rb, Rd
        8    => to_std_logic_vector("inc RA          "), -- inc Ra
        9    => to_std_logic_vector("inc RB          "), -- inc Rb
        10   => to_std_logic_vector("dec RA          "), -- dec Ra
        11   => to_std_logic_vector("dec RB          "), -- dec Rb
        12   => to_std_logic_vector("and RA, RB      "), -- and Ra, Rb
        13   => to_std_logic_vector("and RA, RD      "), -- and Ra, Rd
        14   => to_std_logic_vector("or  RA, RB      "), -- or Ra, Rb
        15   => to_std_logic_vector("or  RA, RD      "), -- or Ra, Rd
        16   => to_std_logic_vector("xor RA, RB      "), -- xor Ra, Rb
        17   => to_std_logic_vector("xor RA, RD      "), -- xor Ra, Rd
        18   => to_std_logic_vector("push RA         "), -- push Ra
        19   => to_std_logic_vector("push RB         "), -- push Rb
        20   => to_std_logic_vector("pop RA          "), -- pop Ra
        21   => to_std_logic_vector("pop RB          "), -- pop Rb
        22   => to_std_logic_vector("st RA, 0x--     "), -- st Ra
        23   => to_std_logic_vector("st RB, 0x--     "), -- st Rb
        24   => to_std_logic_vector("ld RA, 0x--     "), -- ld Ra
        25   => to_std_logic_vector("ld RB, 0x--     "), -- ld Rb
        26   => to_std_logic_vector("ldr RA, RB      "), -- ldr Ra, Rb
        27   => to_std_logic_vector("ldr RB, RA      "), -- ldr Rb, Ra
        28   => to_std_logic_vector("str RA, RB      "), -- str Ra, Rb
        29   => to_std_logic_vector("str RB, RA      "), -- str Rb, Ra
        30   => to_std_logic_vector("mov RA, RB      "), -- mov Ra, Rb
        31   => to_std_logic_vector("mov RB, RA      "), -- mov Rb, Ra
        32   => to_std_logic_vector("jmp 0x--        "), -- jmp para 0x--
        33   => to_std_logic_vector("jmpr RA         "), -- jmpr Ra
        34   => to_std_logic_vector("jmpr RB         "), -- jmpr Rb
        35   => to_std_logic_vector("halt            "), -- halt
        36   => to_std_logic_vector("nop             "), -- nop
        others => to_std_logic_vector("invalid instr. ") -- Instrução inválida
    );

    type fsm_t is (init, idle, write_a, write_b);
    signal STATE : fsm_t := init;

    signal LCD_E_REG, LCD_RS_REG, LCD_RW_REG : STD_LOGIC := '0';
    signal SF_D_REG : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal TEXT_DISPLAY : std_logic_vector(8*16-1 downto 0) := (others => '0');
    signal INIT_COUNTER : unsigned(4 downto 0) := (others => '0');
    signal RESET_DONE   : std_logic := '0';

begin
    process(clk)
        variable counter : unsigned(19 downto 0) := (others => '0');
    begin
        if rising_edge(clk) then
            if reset = '1' then
                STATE <= init;
                RESET_DONE <= '0';
                LCD_E_REG <= '0';
                LCD_RS_REG <= '0';
                LCD_RW_REG <= '0';
                SF_D_REG <= (others => '0');
                TEXT_DISPLAY <= (others => '0');
                INIT_COUNTER <= (others => '0');
            else
                case STATE is
                    when init =>
                        if not RESET_DONE then
                            counter := counter + 1;
                            if counter = 50000 then
                                RESET_DONE <= '1';
                                counter := (others => '0');
                                STATE <= idle;
                            end if;
                        end if;

                    when idle =>
                        TEXT_DISPLAY <= TEXT_MAP_ROM(to_integer(unsigned(ir)));
                        INIT_COUNTER <= (others => '0');
                        STATE <= write_a;

                    when write_a =>
                        SF_D_REG <= TEXT_DISPLAY(4 * (to_integer(INIT_COUNTER) + 1) - 1 downto 4 * to_integer(INIT_COUNTER));
                        LCD_E_REG <= '1';
                        LCD_RS_REG <= '1';
                        LCD_RW_REG <= '0';
                        counter := counter + 1;

                        if counter = 12 then
                            counter := (others => '0');
                            STATE <= write_b;
                        end if;

                    when write_b =>
                        LCD_E_REG <= '0';
                        LCD_RS_REG <= '1';
                        LCD_RW_REG <= '0';
                        counter := counter + 1;

                        if counter = 2000 then
                            counter := (others => '0');
                            if INIT_COUNTER = 15 then
                                STATE <= idle;
                            else
                                INIT_COUNTER <= INIT_COUNTER + 1;
                                STATE <= write_a;
                            end if;
                        end if;

                    when others =>
                        STATE <= idle;
                end case;
            end if;
        end if;
    end process;

    LCD_E  <= LCD_E_REG;
    LCD_RS <= LCD_RS_REG;
    LCD_RW <= LCD_RW_REG;
    SF_D   <= SF_D_REG;

end Behavioral;
