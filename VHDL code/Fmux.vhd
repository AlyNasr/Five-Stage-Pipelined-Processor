LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY Fmux IS
     PORT( 
            RegData,MemSpData: In std_logic_vector(31 downto 0);       
            JmpDec: In std_logic_vector(1 downto 0);
            
            UpdatedPc: Out std_logic_vector(31 downto 0)
          );
END Fmux;

ARCHITECTURE myfmux OF Fmux IS
BEGIN

UpdatedPc <= RegData When JmpDec ="01"
     ELSE MemSpData;
END myfmux;





