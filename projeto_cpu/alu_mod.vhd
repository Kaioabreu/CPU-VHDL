----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:10:56 11/15/2024
-- Design Name: 
-- Module Name:    alu_mod - Behavioral 
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

entity alu_mod is
    Port ( A 			: in  word;
           B 			: in  word;
           FLAGS 		: out STD_LOGIC_VECTOR(3 downto 0); --(3 - Carry Flag, 2 - Zero Flag, 1 - Negative Flag, 0 - Overflow Flag)
			  ALU_CTRL 	: in  ALUPoT;
           Y 			: out word); --Resultado
end alu_mod;

architecture Behavioral of alu_mod is
	signal carry_out : STD_LOGIC := '0';
   signal overflow  : STD_LOGIC := '0';
begin
	process(A,B, ALU_CTRL)
		variable temp_result : SIGNED(16 downto 0);  -- Para somar com Carry (tem 1 bit a mais pra conseguir pegar o carry no final da conta)
	begin
		Y <= (others => '0');
      carry_out <= '0';
      overflow <= '0';
		
		case alu_ctrl is
			when aADD => --Soma
				temp_result := SIGNED(A) + SIGNED(B);
				Y <= STD_LOGIC_VECTOR(temp_result(15 downto 0));
				carry_out <= temp_result(16);
				--overflow <= ?? Buguei em como fazer
				
			when aSUB => --Subtração
				temp_result := SIGNED(A) - SIGNED(B);
            Y <= STD_LOGIC_VECTOR(temp_result(15 downto 0));
            carry_out <= temp_result(16);
				--overflow <= ?? Buguei em como fazer
				
			when aMOV => --MOVE
				y <= A;
				
			when aMOVT =>
				Y <= (B(7 downto 0) & A(7 downto 0));
				
			when aSHIFT =>
				--FAZER
				
			when aAND => --AND
				Y <= A and B;
				
			when aOR => --OR
				Y <= A or B;
				
			when aXOR => --XOR
				Y <= A xor B;
				
			when others => --Operação inválida
				Y <= (others => '0');
		end case;
		
		FLAGS(0) <= overflow;
		FLAGS(1) <= Y(15);
		FLAGS(2) <= '1' WHEN y = (others => '0') else '0';
		FLAGS(3) <= carry_out;
		
	end process;

end Behavioral;

