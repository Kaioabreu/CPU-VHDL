----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:18:39 11/15/2024 
-- Design Name: 
-- Module Name:    cpu_module - Behavioral 
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
use work.libcpu.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cpu_module is
	Port ( 
		CLK : in  STD_LOGIC;
      RESET : in  STD_LOGIC;
      --LEDS : out  STD_LOGIC_VECTOR(não sei o tamanho);
      LCD : out  STD_LOGIC_VECTOR(7 downto 0));
end cpu_module;

architecture Behavioral of cpu_module is

   -- Registradores
   signal PC         : word := (others => '0');
	signal PC_NEXT		: word := (others => '0');
   signal IR         : word;                   
   signal DATA_BUS   : word;                  
   signal REG_WE     : STD_LOGIC := '0';       
   signal PC_WE      : STD_LOGIC := '0';       
   signal RAM_WE     : STD_LOGIC := '0';                        

   -- ALU
   signal ALU_RESULT : word;                   
   signal ALU_FLAGS  : nibble;
   signal ALU_CTRL   : ALUOpT;                 
   signal ALU_A      : word;                   
   signal ALU_B      : word;                   
   signal ALU_Y      : word;                   

   -- Banco de registradores
   signal R_ADDR_A   : nibble; 
   signal R_ADDR_B   : nibble; 
   signal W_ADDR     : nibble; 
   signal W_DATA     : word;                          
   signal R_DATA_A   : word;                          
   signal R_DATA_B   : word;                          

   -- Memória
   signal RAM_ADDR   : word;
   signal RAM_DATA   : word;
	signal RAM_OUT    : word;

begin

	alu_inst : entity work.alu_mod
		Port map (
			A			=> ALU_A,
			B			=> ALU_B,
			ALU_CTRL => ALU_CTRL,
			Y			=> ALU_Y,
			FLAGS		=> ALU_FLAGS
		);
		
	cu_inst : entity work.control_unit_mod
		Port map(
			CLK      => CLK,
			RESET		=> RESET,
			IR			=> IR,
			FLAGS		=> ALU_FLAGS,
			ALU_CTRL	=> ALU_CTRL,
			RAM_WE	=> RAM_WE,
			REG_WE	=> REG_WE,
			PC_WE		=> PC_WE,
			PC			=> PC,
			PC_NEXT  => PC_NEXT
		);
	
	ru_inst : entity work.register_unit_mod
      Port map (
         CLK       => CLK,
         RESET     => RESET,
         REG_WE    => REG_WE,
         R_ADDR_A  => R_ADDR_A,
         R_ADDR_B  => R_ADDR_B,
         W_ADDR    => W_ADDR,
         W_DATA    => W_DATA,
         R_DATA_A  => R_DATA_A,
         R_DATA_B  => R_DATA_B
      );
	
	process(CLK, RESET)
	begin
		if RESET = '1' then
			PC <= (others => '0');
		elsif rising_edge(CLK) then
			if PC_WE = '1' then
				PC <= PC_NEXT;
			end if;
		end if;
	end process;
	
end Behavioral;

