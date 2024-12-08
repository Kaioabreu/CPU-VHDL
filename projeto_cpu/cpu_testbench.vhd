-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

-- Componentes do DUT (Device Under Test)
    component cpu_module
        Port (
            CLK  : in  STD_LOGIC;
            RESET: in  STD_LOGIC;
            LCD  : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Sinais para o DUT
    signal CLK       : STD_LOGIC := '0';
    signal RESET     : STD_LOGIC := '1';
    signal LCD       : STD_LOGIC_VECTOR(7 downto 0);

    -- Clock period
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instância do DUT
    uut: cpu_module
        Port map (
            CLK  => CLK,
            RESET => RESET,
            LCD  => LCD
        );

    -- Geração do Clock
    clk_process : process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Estímulos de Teste
    stim_proc: process
    begin
        -- Inicialização
        wait for 20 ns; -- Espera para estabilizar o DUT
        RESET <= '0'; -- Libera o RESET

        -- Teste 1: Verificar incremento do PC
        wait for 100 ns; -- Observe o PC após alguns ciclos

        -- Teste 2: Simular uma instrução de salto (se configurada na CU)
        -- Adicione sinais específicos no caso de saltos ou branches

        wait for 200 ns; -- Observa mais instruções
        assert false report "Fim da Simulação" severity note;
        wait;
    end process;

  END;
