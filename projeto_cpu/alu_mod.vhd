library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.libcpu.all;

entity alu_mod is
    Port (
        A        : in  word;
        B        : in  word;
        FLAGS    : out STD_LOGIC_VECTOR(3 downto 0);
        ALU_CTRL : in  ALUOpT;
        Y        : out word
    );
end alu_mod;

architecture Behavioral of alu_mod is
    signal carry_out : STD_LOGIC := '0';
    signal overflow  : STD_LOGIC := '0';
    signal Y_internal : word;
    signal is_zero   : STD_LOGIC;
begin
    process(A,B, ALU_CTRL)
        variable temp_result : SIGNED(16 downto 0);
    begin
        carry_out <= '0';
        overflow <= '0';
        
        case ALU_CTRL is
            when aADD =>
                temp_result := SIGNED(A) + SIGNED(B);
                Y_internal <= STD_LOGIC_VECTOR(temp_result(15 downto 0));
                carry_out <= temp_result(16);
                overflow <= NOT (A(15) XOR B(15)) AND (A(15) XOR temp_result(15));

            when aSUB =>
                temp_result := SIGNED(A) - SIGNED(B);
                Y_internal <= STD_LOGIC_VECTOR(temp_result(15 downto 0));
                carry_out <= temp_result(16);
                overflow <= (A(15) XOR B(15)) AND (A(15) XOR temp_result(15));

            when aMOV =>
                Y_internal <= A;

            when aMOVT =>
                Y_internal <= (B(7 downto 0) & A(7 downto 0));

            when aSHIFT =>
                Y_internal <= (others => '0'); -- não implementado

            when aAND =>
                Y_internal <= A and B;

            when aOR =>
                Y_internal <= A or B;

            when aXOR =>
                Y_internal <= A xor B;

            when others =>
                Y_internal <= (others => '0');
        end case;
        
        if (Y_internal = (others => '0')) then
            is_zero <= '1';
        else
            is_zero <= '0';
        end if;
        
        FLAGS(0) <= overflow;
        FLAGS(1) <= Y_internal(15);
        FLAGS(2) <= is_zero;
        FLAGS(3) <= carry_out;
        
    end process;
    
    Y <= Y_internal;

end Behavioral;
