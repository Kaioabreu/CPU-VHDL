----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:28:12 11/16/2024 
-- Design Name: 
-- Module Name:    control_unit_mod - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_unit_mod is
	Port (
		CLK      : in STD_LOGIC;
		RESET		: in STD_LOGIC;
		IR			: in word;
		FLAGS		: in STD_LOGIC_VECTOR(3 downto 0);
		
		ALU_CTRL	: out ALUOpT;
		RAM_WE	: out STD_LOGIC;
		REG_WE	: out STD_LOGIC;
		PC_WE		: out STD_LOGIC
	);
end control_unit_mod;

architecture Behavioral of control_unit_mod is

--criar FSM (MAQUINA DE ESTADOS)

begin
	process(CLK, RESET)
	begin
	
	end process;

end Behavioral;

