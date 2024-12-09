library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.libcpu.all;

entity control_unit_mod is
    Port (
        CLK      : in STD_LOGIC;
        RESET    : in STD_LOGIC;
        IR       : in word;
        FLAGS    : in STD_LOGIC_VECTOR(3 downto 0);
        PC       : in word;
        
        ALU_CTRL : out ALUOpT;
        RAM_WE   : out STD_LOGIC;
        REG_WE   : out STD_LOGIC;
        PC_WE    : out STD_LOGIC;
        PC_NEXT  : out word
    );
end control_unit_mod;

architecture Behavioral of control_unit_mod is

    type state_type is (FETCH, DECODE, EXECUTE, WRITEBACK);
    signal state : state_type := FETCH;

    signal cir : word;

    alias grop  : nibble is cir(15 downto 12);

begin
    process(CLK, RESET)
    begin
        if RESET ='1' then
            state <= FETCH;
            ALU_CTRL <= aMOV;
            RAM_WE <= '0';
            REG_WE <= '0';
            PC_WE <= '0';
				PC_NEXT <= x"0040";
            
        elsif rising_edge(CLK) then
            case state is
                when FETCH =>
                    PC_WE <= '1';
                    --PC_NEXT <= PC;
                    RAM_WE <= '0';
                    REG_WE <= '0';
                    state <= DECODE;
                    
                when DECODE =>
                    cir <= IR;
                    case grop is
                        when goMOV   => ALU_CTRL <= aMOV;
                        when goMOVT  => ALU_CTRL <= aMOVT;
                        when goB     => null;
                        when goJMP   => null;
                        when goLDR   => ALU_CTRL <= aADD; RAM_WE <= '0';
                        when goSTR   => ALU_CTRL <= aADD; RAM_WE <= '1';
                        when goPUSH  => ALU_CTRL <= aMOV; RAM_WE <= '1';
                        when goPOP   => ALU_CTRL <= aMOV; REG_WE <= '0';
                        when goADD   => ALU_CTRL <= aADD;
                        when goADDC  => ALU_CTRL <= aADD;
                        when goSUB   => ALU_CTRL <= aSUB;
                        when goSUBC  => ALU_CTRL <= aSUB;
                        when goSHIFT => ALU_CTRL <= aSHIFT;
                        when goAND   => ALU_CTRL <= aAND;
                        when goORR   => ALU_CTRL <= aOR;
                        when goXOR   => ALU_CTRL <= aXOR;
                        when others  => ALU_CTRL <= aMOV;
                    end case;
                    state <= EXECUTE;

                when EXECUTE =>
                    state <= WRITEBACK;
					 when WRITEBACK =>
						  PC_WE <= '0';
						  state <= FETCH;
            end case;
        end if;
    end process;

end Behavioral;
