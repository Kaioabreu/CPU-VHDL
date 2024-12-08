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
        sf_d       : out STD_LOGIC_VECTOR(3 downto 0)
    );
end cpu_module;

architecture Behavioral of cpu_module is

    signal PC         : word := (others => '0'); -- Program Counter
    signal IR         : word; -- Instruction Register
    signal DATA_BUS   : word; -- Barramento de dados
    signal REG_WE     : STD_LOGIC := '0'; -- REG Write Enable 
    signal PC_WE      : STD_LOGIC := '0';
    signal RAM_WE     : STD_LOGIC := '0';
    signal RAM_ADDR   : word; -- Endereço de memória
    signal RAM_DATA   : word; -- Dados de memória

    -- ALU
    signal ALU_RESULT : word; -- Resultado da ALU
    signal ALU_FLAGS  : STD_LOGIC_VECTOR(3 downto 0); -- Flags da ALU
    signal ALU_CTRL   : ALUOpT;
    signal ALU_A      : word;
    signal ALU_B      : word;

    -- LCD
    signal lcd_ir      : std_logic_vector(7 downto 0);
    signal lcd_pos_255 : std_logic_vector(15 downto 0);

    -- Teclado PS/2
    signal tecla_ps2     : STD_LOGIC_VECTOR(7 downto 0); -- Código da tecla
    signal tecla_valida  : STD_LOGIC; -- Indica se a tecla é válida

begin

    -- ALU Instância
    alu_inst : entity work.alu_mod
        Port map (
            A         => ALU_A,
            B         => ALU_B,
            ALU_CTRL  => ALU_CTRL,
            Y         => ALU_RESULT,
            FLAGS     => ALU_FLAGS
        );

    -- Unidade de Controle Instância
    cu_inst : entity work.control_unit_mod
        Port map(
            CLK      => CLK,
            RESET    => RESET,
            IR       => IR,
            PC       => PC, -- Conexão do Program Counter
            FLAGS    => ALU_FLAGS,
            ALU_CTRL => ALU_CTRL,
            RAM_WE   => RAM_WE,
            REG_WE   => REG_WE,
            PC_WE    => PC_WE
        );

    -- RAM Instância
    u_RAM : entity work.RAM_8x8192
        Port map(
            CLK     => CLK,
            DIN     => RAM_DATA,   
            ADDR    => RAM_ADDR,   
            WE      => RAM_WE,     
            DOUT    => RAM_DATA,   
            POS_255 => lcd_pos_255  
        );

    -- LCD Instância
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

    -- Teclado Instância
    teclado_inst : entity work.teclado_mod
        port map(
            PS2_DATA => PS2_DATA,   
            PS2_CLK  => PS2_CLK,    
            CLK      => CLK,
            RESET    => RESET,
            tecla    => tecla_ps2,  
            valido   => tecla_valida 
        );

    -- Conexões
    DATA_BUS <= "00000000" & tecla_ps2 when tecla_valida = '1' else (others => '0');
    lcd_ir <= RAM_DATA(7 downto 0); -- Parte baixa dos dados da RAM

end Behavioral;
