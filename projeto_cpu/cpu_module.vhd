library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.libcpu.all;

entity cpu_module is
    Port (
        CLK        : in  STD_LOGIC;
        RESET      : in  STD_LOGIC;
        PS2_DATA   : in  STD_LOGIC;
        PS2_CLK    : in  STD_LOGIC;
        lcd_e      : out STD_LOGIC;
        lcd_rs     : out STD_LOGIC;
        lcd_rw     : out STD_LOGIC;
        sf_d       : out STD_LOGIC_VECTOR(3 downto 0);
        seg        : out STD_LOGIC_VECTOR(6 downto 0)
    );
end cpu_module;

architecture Behavioral of cpu_module is

    signal PC         : word := (others => '0');
    signal IR         : word;
    signal DATA_BUS   : word;
    signal REG_WE     : STD_LOGIC := '0';
    signal PC_WE      : STD_LOGIC := '0';
    signal RAM_WE     : STD_LOGIC := '0';
    signal RAM_ADDR   : word;
    signal RAM_DATA   : word;

    signal ALU_RESULT : word;
    signal ALU_FLAGS  : STD_LOGIC_VECTOR(3 downto 0);
    signal ALU_CTRL   : ALUOpT;
    signal ALU_A      : word;
    signal ALU_B      : word;

    signal lcd_ir      : std_logic_vector(7 downto 0);
    signal lcd_pos_255 : word;

    signal tecla_ps2     : byte;
    signal tecla_valida  : STD_LOGIC;

    signal DISPLAY_VAL   : STD_LOGIC_VECTOR(3 downto 0);

begin

    alu_inst : entity work.alu_mod
        port map (
            A         => ALU_A,
            B         => ALU_B,
            ALU_CTRL  => ALU_CTRL,
            Y         => ALU_RESULT,
            FLAGS     => ALU_FLAGS
        );

    cu_inst : entity work.control_unit_mod
        port map(
            CLK      => CLK,
            RESET    => RESET,
            IR       => IR,
            PC       => PC,
            FLAGS    => ALU_FLAGS,
            ALU_CTRL => ALU_CTRL,
            RAM_WE   => RAM_WE,
            REG_WE   => REG_WE,
            PC_WE    => PC_WE
        );

    u_RAM : entity work.RAM_8x8192
        port map(
            CLK     => CLK,
            DIN     => RAM_DATA,
            ADDR    => RAM_ADDR(12 downto 0),
            WE      => RAM_WE,
            DOUT    => RAM_DATA,
            POS_255 => lcd_pos_255
        );

    u_lcd : entity work.lcd_mod
        port map(
            clk     => CLK,
            reset   => RESET,
            lcd_e   => lcd_e,
            lcd_rs  => lcd_rs,
            lcd_rw  => lcd_rw,
            sf_d    => sf_d,
            ir      => lcd_ir,
            pos_255 => lcd_pos_255
        );

    teclado_inst : entity work.teclado_mod
        port map(
            PS2_DATA => PS2_DATA,
            PS2_CLK  => PS2_CLK,
            CLK      => CLK,
            RESET    => RESET,
            tecla    => tecla_ps2,
            valido   => tecla_valida
        );

    DATA_BUS <= x"00" & tecla_ps2 when tecla_valida = '1' else (others => '0');
    lcd_ir <= RAM_DATA(7 downto 0);

    DISPLAY_VAL <= ALU_RESULT(3 downto 0);

    u_display : entity work.display_mod
        port map(
            num => DISPLAY_VAL,
            seg => seg
        );

end Behavioral;
