LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


-- Mux to select R2 or Immediate value in Execute stage
ENTITY Emux IS
     PORT( 
            R,ImmVal: In std_logic_vector(31 downto 0);       
            S: In std_logic;
            
            Output: Out std_logic_vector(31 downto 0)
          );
END Emux;

ARCHITECTURE mymux OF Emux IS
BEGIN

Output <= R When S ='0'
     ELSE ImmVal;
END mymux;



