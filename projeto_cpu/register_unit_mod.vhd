----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:59:11 11/17/2024 
-- Design Name: 
-- Module Name:    register_unit_mod - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_unit_mod is
    Port (
        CLK				: in  STD_LOGIC;                        -- Clock
        RESET			: in  STD_LOGIC;                        -- Reset global
        REG_WE			: in  STD_LOGIC;                        -- Habilitação de escrita
        R_ADDR_A		: in  STD_LOGIC_VECTOR(3 downto 0);     -- Endereço do registrador para leitura A
        R_ADDR_B		: in  STD_LOGIC_VECTOR(3 downto 0);     -- Endereço do registrador para leitura B
        W_ADDR			: in  STD_LOGIC_VECTOR(3 downto 0);     -- Endereço do registrador para escrita
        W_DATA			: in  STD_LOGIC_VECTOR(15 downto 0);    -- Dados a serem escritos
        R_DATA_A		: out STD_LOGIC_VECTOR(15 downto 0);    -- Dados lidos do registrador A
        R_DATA_B		: out STD_LOGIC_VECTOR(15 downto 0)     -- Dados lidos do registrador B
    );
end register_unit_mod;

architecture Behavioral of register_unit_mod is
    type REG_ARRAY is array (15 downto 0) of STD_LOGIC_VECTOR(15 downto 0);
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

