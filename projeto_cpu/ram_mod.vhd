library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.libcpu.all;

entity RAM_8x8192 is
    port (
        CLK      : in std_logic;
        DIN      : in word;
        ADDR     : in std_logic_vector(12 downto 0);
        WE       : in std_logic;
        DOUT     : out word;
        POS_255  : out word
    );
end RAM_8x8192;

architecture Behavioral of RAM_8x8192 is
    
    type RAM_t is array(0 to 8191) of word;
    signal ram : RAM_t := (
        0 => x"0001",
        1 => x"0003",
        2 => x"1001",
        3 => x"2000",
        4 => x"2000",
        5 => x"2510",
        6 => x"2010",
        7 => x"3101",
        8 => x"0C00",
        9 => x"0C00",
        10 => x"8000",
        11 => x"8400",
        12 => x"8800",
        13 => x"8001",
        14 => x"8C00",
        15 => x"8200",
        16 => x"0000",
        17 => x"8300",
        18 => x"0001",
        19 => x"9000",
        20 => x"A0C0",
        21 => x"B010",
        22 => x"C000",
        23 => x"8000",
        24 => x"2000",
        25 => x"0000",
        26 => x"0000",
        27 => x"C010",
        28 => x"2000",
        56 => x"2010",
        57 => x"8E00",
        58 => x"FFFF",
        59 => x"8200",
        60 => x"FFFF",
        128 => x"1890",
        255 => x"FFFF",
        others => x"F0F0"
    );

    signal read_address : std_logic_vector(12 downto 0) := (others => '0');

begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            if WE = '1' then
                ram(to_integer(unsigned(ADDR))) <= DIN;
            end if;
            read_address <= ADDR;
        end if;
    end process;

    DOUT <= ram(to_integer(unsigned(read_address)));
    POS_255 <= ram(255);

end Behavioral;
