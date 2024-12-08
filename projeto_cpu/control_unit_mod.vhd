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
use work.libcpu.all;
use IEEE.NUMERIC_STD.ALL;

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
		PC			: in word;
		
		ALU_CTRL	: out ALUOpT;
		RAM_WE	: out STD_LOGIC;
		REG_WE	: out STD_LOGIC;
		PC_WE		: out STD_LOGIC;
		PC_NEXT 	: out word
	);
end control_unit_mod;

architecture Behavioral of control_unit_mod is

	type state_type is (FETCH, DECODE, EXECUTE);
	signal state : state_type := FETCH;

	signal cir : STD_LOGIC_VECTOR(15 downto 0); --Registrador de Instrução

	alias gr    : crumb is cir(15 downto 14);  -- Grupo de instruções (2 bits)
	alias op    : crumb is cir(13 downto 12);  -- Opcode específico (2 bits)
	alias grop  : nibble is cir(15 downto 12); -- Grupo + Opcode (4 bits)
	alias r1    : nibble is cir(11 downto 8);  -- Registrador 1
	alias r2    : nibble is cir(7 downto 4);   -- Registrador 2
	alias r3    : nibble is cir(3 downto 0);   -- Registrador 3
	alias f     : nibble is cir(11 downto 8);  -- Flags ou condição
	alias c4    : nibble is cir(3 downto 0);   -- Constante de 4 bits
	alias c8    : byte  is cir(7 downto 0);    -- Constante de 8 bits
	alias c12   : STD_LOGIC_VECTOR(11 downto 0) is cir(11 downto 0); -- Constante de 12 bits

begin
	process(CLK, RESET)
	begin
		if RESET ='1' then
			STATE <= FETCH;
			ALU_CTRL <= aMOV;
			RAM_WE <= '0';
			REG_wE <= '0';
			PC_WE <= '0';
			
		elsif rising_edge(CLK) then
			case STATE is
				when FETCH =>
					PC_WE <= '1';
					PC_NEXT <= STD_LOGIC_VECTOR(unsigned(PC) + 1);
					RAM_WE <= '0';
					REG_WE <= '0';
					STATE <= DECODE;
					
				when DECODE =>
					case grop is
						when goMOV =>
							ALU_CTRL <= aMOV;
							
						when goMOVT =>
							ALU_CTRL <= aMOVT;

						when goB =>
							
						when goJMP =>
							
						when goLDR =>
							ALU_CTRL <= aADD;
							RAM_WE <= '0';
							
						when goSTR =>
							ALU_CTRL <= aADD;
							RAM_WE <= '1';
						
						when goPUSH =>
							ALU_CTRL <= aMOV;
							RAM_WE <= '1';
						
						when goPOP =>
							ALU_CTRL <= aMOV;
							RAM_wE <= '0';
							
						when goADD =>
							ALU_CTRL <= aADD;
							
						when goADDC =>
							ALU_CTRL <= aADD;
							
						when goSUB =>
							ALU_CTRL <= aSUB;
						
						when goSUBC =>
							ALU_CTRL <= aSUB;
							
						when goSHIFT =>
							ALU_CTRL <= aSHIFT;
							
						when goAND =>
							ALU_CTRL <= aAND;
							
						when goORR =>
							ALU_CTRL <= aOR;
							
						when goXOR =>
							ALU_CTRL <= aXOR;
							
						when others =>
							ALU_CTRL <= aMOV;
					end case;
					STATE <= EXECUTE;

				when EXECUTE =>
					case grop is
						when others =>
						
					end case;
					pc_we <= '0';
					state <= FETCH;
			end case;
		end if;
	end process;

end Behavioral;

