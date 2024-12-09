library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.libcpu.all;

entity lcd_mod is
    port(
        clk     : in   STD_LOGIC;
        reset   : in   STD_LOGIC;
        lcd_e   : out  STD_LOGIC;
        lcd_rs  : out  STD_LOGIC;
        lcd_rw  : out  STD_LOGIC;
        sf_d    : out  STD_LOGIC_VECTOR(3 downto 0);
        ir      : in   STD_LOGIC_VECTOR(7 downto 0);
        pos_255 : in   word
    );
end lcd_mod;

architecture Behavioral of lcd_mod is

    function str2slv(S : string) return std_logic_vector is
        variable result : std_logic_vector(S'length*8-1 downto 0);
    begin
        for i in S'range loop
            result((S'length - i)*8+7 downto (S'length - i)*8) := std_logic_vector(to_unsigned(character'pos(S(i)), 8));
        end loop;
        return result;
    end function;

    type TEXT_MAP_ROM_t is array (0 to 255) of std_logic_vector(127 downto 0);
    constant TEXT_MAP_ROM : TEXT_MAP_ROM_t := (
        0    => str2slv("add RA, RB      "),
        1    => str2slv("add RA, RD      "),
        2    => str2slv("sub RA, RB      "),
        3    => str2slv("inc RA          "),
        4    => str2slv("inc RA          "),
        5    => str2slv("dec RB          "),
        6    => str2slv("dec RA          "),
        7    => str2slv("and RA, RB      "),
        8    => str2slv("or  RA, RD      "),
        9    => str2slv("or  RA, RD      "),
        10   => str2slv("push RA         "),
        11   => str2slv("push RB         "),
        12   => str2slv("push RC         "),
        13   => str2slv("pop RA          "),
        14   => str2slv("pop RC          "),
        15   => str2slv("st RA, 0x--     "),
        16   => str2slv("[COMP st]       "),
        17   => str2slv("ld RA, 0x--     "),
        18   => str2slv("[COMP lt]       "),
        19   => str2slv("ldr RA, RC      "),
        20   => str2slv("str RA, RD      "),
        21   => str2slv("mov RA, RB      "),
        22   => str2slv("jmp 0x--        "),
        23   => str2slv("[COMP jmp]      "),
        24   => str2slv("inc RA          "),
        25   => str2slv("add RA, RA      "),
        26   => str2slv("add RA, RA      "),
        27   => str2slv("jmpr RA         "),
        28   => str2slv("inc RA          "),
        56   => str2slv("dec RA          "),
        57   => str2slv("st RD, 0x--     "),
        58   => str2slv("[COMP st POS255]"),
        59   => str2slv("st RA, 0x--     "),
        60   => str2slv("[COMP st POS255]"),
        128  => str2slv("mov R0, R0      "),
        others => str2slv("invalid instr.  ")
    );

    type fsm_t is (init, idle, write_a, write_b);
    signal STATE : fsm_t := init;

    signal LCD_E_REG, LCD_RS_REG, LCD_RW_REG : STD_LOGIC := '0';
    signal SF_D_REG : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal TEXT_DISPLAY : std_logic_vector(127 downto 0) := (others => '0');
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
                        if RESET_DONE = '0' then
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
