library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.libcpu.all;

entity register_unit_mod is
    Port (
        CLK        : in  STD_LOGIC;
        RESET      : in  STD_LOGIC;
        REG_WE     : in  STD_LOGIC;
        R_ADDR_A   : in  STD_LOGIC_VECTOR(3 downto 0);
        R_ADDR_B   : in  STD_LOGIC_VECTOR(3 downto 0);
        W_ADDR     : in  STD_LOGIC_VECTOR(3 downto 0);
        W_DATA     : in  word;
        R_DATA_A   : out word;
        R_DATA_B   : out word
    );
end register_unit_mod;

architecture Behavioral of register_unit_mod is
    type REG_ARRAY is array (15 downto 0) of word;
    signal REGISTERS : REG_ARRAY := (others => (others => '0'));
begin

    process(R_ADDR_A, R_ADDR_B, REGISTERS)
    begin
        R_DATA_A <= REGISTERS(to_integer(unsigned(R_ADDR_A)));
        R_DATA_B <= REGISTERS(to_integer(unsigned(R_ADDR_B)));
    end process;

    process(CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                REGISTERS <= (others => (others => '0'));
            elsif REG_WE = '1' then
                REGISTERS(to_integer(unsigned(W_ADDR))) <= W_DATA;
            end if;
        end if;
    end process;

end Behavioral;
