library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- * max 4k jumpable instructions (12-bit jump destination)
-- * max 64k data words in same address space, limited by block RAM
-- * 16-bit word size, no byte addressing
-- 
-- MOV  set register to 8-bit constant
-- MOVT set upper part of register to 8-bit constant
-- B... conditional branch to pc + 8-bit signed constant
-- JMP  jump to 12-bit unsigned constant
-- 
-- LDR  load from address in [register + 4-bit signed constant]
-- STR  store to address in [register + 4-bit signed constant]
-- PUSH push register
-- POP  pop register
-- 
-- ADD  add two registers
-- ADDC add 4-bit unsigned constant to register
-- SUB  subtract two registers
-- SUBC subtract 4-bit unsigned constant from register
-- 
-- SHFT shift register by 4-bit signed constant without 0
-- AND  and two registers
-- OR   or two registers
-- XOR  xor two registers
-- 
-- MOV  0000 DDDD CCCC CCCC
-- MOVT 0001 DDDD CCCC CCCC
-- B    0010 FFFF CCCC CCCC
-- JMP  0011 CCCC CCCC CCCC
-- 
-- LDR  0100 DDDD SSSS CCCC
-- STR  0101 TTTT SSSS CCCC
-- PUSH 0110 0000 1110 SSSS
-- POP  0111 DDDD 1110 0000
-- 
-- ADD  1000 DDDD SSSS TTTT
-- ADD  1001 DDDD SSSS CCCC
-- SUB  1010 DDDD SSSS TTTT
-- SUB  1011 DDDD SSSS CCCC
-- 
-- SHFT 1100 DDDD SSSS CCCC (first bit is direction, rest is amount-1)
-- AND  1101 DDDD SSSS TTTT
-- OR   1110 DDDD SSSS TTTT
-- XOR  1111 DDDD SSSS TTTT


package libcpu is

  subtype crumb is std_logic_vector(1 downto 0);
  subtype nibble is std_logic_vector(3 downto 0);
  subtype byte is std_logic_vector(7 downto 0);
  subtype word is std_logic_vector(15 downto 0);
  subtype ALUOpT is std_logic_vector(2 downto 0);
  
  constant gMISC : crumb    := "00";
  constant oMOV  : crumb    := "00";
  constant oMOVT : crumb    := "01";
  constant oB    : crumb    := "10";
  constant oJMP  : crumb    := "11";

  constant gMEM  : crumb    := "01";
  constant oLDR  : crumb    := "00";
  constant oSTR  : crumb    := "01";
  constant oPUSH : crumb    := "10";
  constant oPOP  : crumb    := "11";

  constant gARITH: crumb    := "10";
  constant oADD  : crumb    := "00";
  constant oADDC : crumb    := "01";
  constant oSUB  : crumb    := "10";
  constant oSUBC : crumb    := "11";

  constant gLOGIC: crumb    := "11";
  constant oSHIFT: crumb    := "00";
  constant oAND  : crumb    := "01";
  constant oORR  : crumb    := "10";
  constant oXOR  : crumb    := "11";
  
  constant goMOV  : nibble   := gMISC  & oMOV;
  constant goMOVT : nibble   := gMISC  & oMOVT;
  constant goB    : nibble   := gMISC  & oB;
  constant goJMP  : nibble   := gMISC  & oJMP;
  constant goLDR  : nibble   := gMEM   & oLDR;
  constant goSTR  : nibble   := gMEM   & oSTR;
  constant goPUSH : nibble   := gMEM   & oPUSH;
  constant goPOP  : nibble   := gMEM   & oPOP;
  constant goADD  : nibble   := gARITH & oADD;
  constant goADDC : nibble   := gARITH & oADDC;
  constant goSUB  : nibble   := gARITH & oSUB;
  constant goSUBC : nibble   := gARITH & oSUBC;
  constant goSHIFT: nibble   := gLOGIC & oSHIFT;
  constant goAND  : nibble   := gLOGIC & oAND;
  constant goORR  : nibble   := gLOGIC & oORR;
  constant goXOR  : nibble   := gLOGIC & oXOR;
  
  constant bB   : nibble    := "0000"; -- Unconditional
  constant bBZ  : nibble    := "0001"; -- Zero (equal)
  constant bBNZ : nibble    := "0010"; -- Non zero (not equal)
  constant bBCS : nibble    := "0011"; -- Carry set (unsigned lower)
  constant bBCC : nibble    := "0100"; -- Carry cleared (unsigned higher or same)
  constant bBLT : nibble    := "0101"; -- Signed less than
  constant bBGE : nibble    := "0110"; -- Signed greater than or equal

  constant rPC  : nibble    := "1111";
  constant rSP  : nibble    := "1110";
  
  constant amALU: std_logic := '0';
  constant amRU : std_logic := '1';
  constant bmRU : std_logic := '0';
  constant bmCU : std_logic := '1';
  constant cmALU: std_logic := '0';
  constant cmLSU: std_logic := '1';

  constant aADD  : ALUOpT    := "000";
  constant aSUB  : ALUOpT    := "001";
  constant aMOV  : ALUOpT    := "010";
  constant aMOVT : ALUOpT    := "011";
  constant aSHIFT: ALUOpT    := "100";
  constant aAND  : ALUOpT    := "101";
  constant aOR   : ALUOpT    := "110";
  constant aXOR  : ALUOpT    := "111";
  
  constant addr_BUTTON     : word := x"0000";
  constant addr_ENCODER    : word := x"0001";
  constant addr_PS2_DATA   : word := x"0002";
  constant addr_UART_DATA  : word := x"0003";
  constant addr_UART_STATUS: word := x"0004";
  constant addr_LED        : word := x"0005";
  constant addr_SSD        : word := x"0006";
  constant addr_LCD_DATA   : word := x"0007";
  constant addr_LCD_CMD    : word := x"0008";
  
  constant addr_RESET      : word := x"0010";
  constant addr_SP         : word := x"1fff";
  
  constant bittime: integer := 434; -- 50000000 / 115200
  constant MARK: std_logic := '1';
  constant SPACE: std_logic := '0';

  function hex2ssd(hex : std_logic_vector(3 downto 0)) return std_logic_vector;
  function scan2char(scan: std_logic_vector(7 downto 0)) return std_logic_vector;

end package;

package body libcpu is

  -- Returns segments in order GFEDCBA (MSB to LSB)
  function hex2ssd (hex : std_logic_vector(3 downto 0)) return std_logic_vector is
    variable ssd: std_logic_vector(6 downto 0);
  begin
    case hex is
      when "0000" => ssd := "0111111";
      when "0001" => ssd := "0000110";
      when "0010" => ssd := "1011011";
      when "0011" => ssd := "1001111";
      when "0100" => ssd := "1100110";
      when "0101" => ssd := "1101101";
      when "0110" => ssd := "1111101";
      when "0111" => ssd := "0000111";
      when "1000" => ssd := "1111111";
      when "1001" => ssd := "1100111";
      when "1010" => ssd := "1110111";
      when "1011" => ssd := "1111100";
      when "1100" => ssd := "0111001";
      when "1101" => ssd := "1011110";
      when "1110" => ssd := "1111001";
      when "1111" => ssd := "1110001";
      when others => report "unreachable" severity failure;
    end case;
    return ssd;
  end function;
  
  function scan2char (scan : std_logic_vector(7 downto 0)) return std_logic_vector is
    type MemoryT is array(0 to 255) of std_logic_vector(7 downto 0);
    constant ROM: MemoryT := (16#1C# => x"61", --a
									   16#32# => x"62", --b
  									   16#21# => x"63", --c
									   16#23# => x"64", --d
									   16#24# => x"65", --e
									   16#2B# => x"66", --f
									   16#34# => x"67", --g
									   16#33# => x"68", --h
									   16#43# => x"69", --i
									   16#3B# => x"6A", --j
									   16#42# => x"6B", --k
									   16#4B# => x"6C", --l
									   16#3A# => x"6D", --m
									   16#31# => x"6E", --n
									   16#44# => x"6F", --o
									   16#4D# => x"70", --p
									   16#15# => x"71", --q
									   16#2D# => x"72", --r
									   16#1B# => x"73", --s
									   16#2C# => x"74", --t
									   16#3C# => x"75", --u
									   16#2A# => x"76", --v
									   16#1D# => x"77", --w
									   16#22# => x"78", --x
									   16#35# => x"79", --y
									   16#1A# => x"7A", --z
									   16#16# => x"31", --1
									   16#1E# => x"32", --2
									   16#26# => x"33", --3
									   16#25# => x"34", --4
									   16#2E# => x"35", --5
									   16#36# => x"36", --6
									   16#3D# => x"37", --7
									   16#3E# => x"38", --8
									   16#46# => x"39", --9
									   16#45# => x"30", --0
									   16#4E# => x"2D", -- -
									   16#55# => x"3D", -- =
									   16#5A# => x"0D", --Enter
									   others => (others => 'U'));    	 
  begin
    return ROM(to_integer(unsigned(scan)));
  end function;
 
end package body;
