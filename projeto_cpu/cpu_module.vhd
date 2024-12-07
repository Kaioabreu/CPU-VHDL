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
	--registradores
	signal PC         : word := (others => '0'); -- Program Counter
   signal IR         : word; -- Instruction Register
   signal DATA_BUS   : word; -- Barramento de dados
	signal REG_WE 		: STD_LOGIC := '0'; -- REG Write Enable 
	signal PC_WE 		: STD_LOGIC := '0';
	signal RAM_WE 		: STD_LOGIC := '0';
	signal RAM_ADDR   : word; -- Endereço de memória
	signal RAM_DATA   : word; -- Dados de memória
	-- alu
	signal ALU_RESULT : word; -- Resultado da ALU
   signal ALU_FLAGS  : STD_LOGIC_VECTOR(3 downto 0);  -- Flags da ALU
	signal ALU_CTRL   : ALUOpT;
	signal ALU_A		: word;
	signal ALU_B		: word;
	signal ALU_Y		: word;
	
	component alu_mod is
		Port (
			A 			: in word;
			B     	: in word;
			FLAGS 	: out STD_LOGIC_VECTOR(3 downto 0);
			ALU_CTRL : in ALUOpT;
			Y			: out word
		);
	end component;
	
	component control_unit_mod is
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
	end component;
	
	 component RAM_64kx16 is
      Port(
         CLK    : in  std_logic;
         DIN    : in  std_logic_vector(15 downto 0);
         ADDR   : in  std_logic_vector(15 downto 0);
         WE     : in  std_logic;
         DOUT   : out std_logic_vector(15 downto 0);
         POS_SP : out std_logic_vector(15 downto 0)
      );
   end component;

begin

	alu_inst : alu_mod
		Port map (
			A			=> ALU_A,
			B			=> ALU_B,
			ALU_CTRL => ALU_CTRL,
			Y			=> ALU_Y,
			FLAGS		=> ALU_FLAGS
		);
		
	cu_inst : control_unit_mod
		Port map(
			CLK      => CLK,
			RESET		=> RESET,
			IR			=> IR,
			FLAGS		=> ALU_FLAGS,
			ALU_CTRL	=> ALU_CTRL,
			RAM_WE	=> RAM_WE,
			REG_WE	=> REG_WE,
			PC_WE		=> PC_WE
		);

	u_RAM : entity work.RAM_64kx16(rtl)
      port map(
         CLK    => CLK,
         DIN    => RAM_DIN,    -- Dados que a CPU escreve na RAM
         ADDR   => RAM_ADDR,   -- Endereço fornecido pela CPU
         WE     => RAM_WE,     -- Sinal de escrita controlado pela CU
         DOUT   => RAM_DOUT,   -- Dados lidos da RAM
         POS_SP => POS_SP_reg  -- Podemos monitorar se necessário
      );

end Behavioral;

