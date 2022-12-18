LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY WriteBack IS
     PORT( 
            RegVal,MemoryVal,Input_port, In_Woutdata1: In std_logic_vector(31 downto 0);
            IN_SwapR1: In std_logic_vector(31 downto 0); 
            IN_Imm: In std_logic_vector(31 downto 0);      
            Slct: In std_logic_vector(2 downto 0);
            Se: In std_logic;
            OutVal: Out std_logic_vector(31 downto 0);
            OutportVal: Out std_logic_vector(31 downto 0)
            
          );
END WriteBack;

ARCHITECTURE myWB OF WriteBack IS
BEGIN

Outval <= RegVal When Slct = "000"
     ELSE MemoryVal When Slct = "001"
     ELSE IN_SwapR1 When Slct = "011"  
     Else Input_port When Slct = "010"
     ELSE IN_Imm;  


OutportVal <=  In_Woutdata1 WHen Se = '1';    
END myWB;







