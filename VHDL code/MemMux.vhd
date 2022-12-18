LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


-- Mux to select Sp or EA in Memory stage
ENTITY MemMux IS
     PORT( 
            IN_Sp,IN_EA: In std_logic_vector(31 downto 0);       
            In_S: In std_logic_vector(1 downto 0);
            
            Outp: Out std_logic_vector(31 downto 0);
            MeIntr: in std_logic
          );
END Memmux;

ARCHITECTURE mymmux OF Memmux IS
BEGIN

Outp <= IN_EA When In_S ="10"
     ELSE IN_Sp    WHEN MeIntr = '1' OR In_S ="01"
     ELSE "00000000000000000000001000000000";  
END mymmux;





