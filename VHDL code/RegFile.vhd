library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;  


entity RegisterFile is
port (
clk,rst: in std_logic;

ReadAddress1 : in std_logic_vector(2 downto 0);
ReadAddress2 : in std_logic_vector(2 downto 0);
OutData1 : out std_logic_vector (31 downto 0);
OutData2 : out std_logic_vector (31 downto 0);
	
WriteAddress1: in std_logic_vector(2 downto 0);
WriteAddress2: in std_logic_vector(2 downto 0);
WriteData1: in std_logic_vector(31 downto 0);
WriteData2: in std_logic_vector(31 downto 0);
WriteEnable1 : in std_logic;
WriteEnable2 : in std_logic;

     Reg0: Out std_logic_vector(31 downto 0);
     Reg1: Out std_logic_vector(31 downto 0);
     Reg2: Out std_logic_vector(31 downto 0);
     Reg3: Out std_logic_vector(31 downto 0);
     Reg4: Out std_logic_vector(31 downto 0);
     Reg5: Out std_logic_vector(31 downto 0);
     Reg6: Out std_logic_vector(31 downto 0);
     Reg7: Out std_logic_vector(31 downto 0)
      );

end RegisterFile;

ARCHITECTURE myReg of RegisterFile is
type RegFile is array (0 to 7 ) of std_logic_vector (31 downto 0);
signal RegArray: RegFile;
begin
 process(clk,rst) 
 begin
 if(rst='1') then
   RegArray(0) <= (OTHERS=>'0');
   RegArray(1) <= (OTHERS=>'0');
   RegArray(2) <= (OTHERS=>'0');
   RegArray(3) <= (OTHERS=>'0');
   RegArray(4) <= (OTHERS=>'0');
   RegArray(5) <= (OTHERS=>'0');
   RegArray(6) <= (OTHERS=>'0');
   RegArray(7) <= (OTHERS=>'0');
   
 elsif(falling_edge(clk)) then
 
   if(WriteEnable1 ='1') then
    RegArray(to_integer(unsigned(WriteAddress1))) <= WriteData1;
   end if;
  if(WriteEnable2 ='1') then
    RegArray(to_integer(unsigned(WriteAddress2))) <= WriteData2;
   end if;
   
 end if;
 end process;

OutData1 <=  RegArray(to_integer(unsigned(ReadAddress1)));
OutData2 <=  RegArray(to_integer(unsigned(ReadAddress2)));

Reg0 <=  RegArray(0);
Reg1 <=  RegArray(1);
Reg2 <=  RegArray(2);
Reg3 <=  RegArray(3);
Reg4 <=  RegArray(4);
Reg5 <=  RegArray(5);
Reg6 <=  RegArray(6);
Reg7 <=  RegArray(7);

End myreg;  