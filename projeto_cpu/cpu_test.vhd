library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.libcpu.all;

entity testbench is
end testbench;

architecture behavior of testbench is

    component cpu_module
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
    end component;

    signal CLK        : STD_LOGIC := '0';
    signal RESET      : STD_LOGIC := '1';
    signal PS2_DATA_tb: STD_LOGIC := '0';
    signal PS2_CLK_tb : STD_LOGIC := '0';
    signal lcd_e_tb   : STD_LOGIC;
    signal lcd_rs_tb  : STD_LOGIC;
    signal lcd_rw_tb  : STD_LOGIC;
    signal sf_d_tb    : STD_LOGIC_VECTOR(3 downto 0);
    signal seg_tb     : STD_LOGIC_VECTOR(6 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: cpu_module
        Port map (
            CLK      => CLK,
            RESET    => RESET,
            PS2_DATA => PS2_DATA_tb,
            PS2_CLK  => PS2_CLK_tb,
            lcd_e    => lcd_e_tb,
            lcd_rs   => lcd_rs_tb,
            lcd_rw   => lcd_rw_tb,
            sf_d     => sf_d_tb,
            seg      => seg_tb
        );

    clk_process : process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    stim_proc: process
    begin
        wait for 20 ns;
        RESET <= '0';
        wait for 200 ns;
        assert false report "Fim da Simulação" severity note;
        wait;
    end process;

end behavior;