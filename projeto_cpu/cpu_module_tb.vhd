--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:24:25 12/06/2024
-- Design Name:   
-- Module Name:   /home/ise/projeto_cpu/cpu_module_tb.vhd
-- Project Name:  projeto_cpu
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cpu_module
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY cpu_module_tb IS
END cpu_module_tb;
 
ARCHITECTURE behavior OF cpu_module_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cpu_module
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         LEDS : OUT  std_logic;
         LCD : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';

 	--Outputs
   signal LEDS : std_logic;
   signal LCD : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cpu_module PORT MAP (
          CLK => CLK,
          RESET => RESET,
          LEDS => LEDS,
          LCD => LCD
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- Reset desativado inicialmente
        RESET <= '0';
        wait for 20 ns;

        -- Ativa o RESET
        RESET <= '1';
        wait for 20 ns;

        -- Desativa o RESET
        RESET <= '0';
        wait for 40 ns;

        -- Fim da simulação
        wait;
   end process;

END;
