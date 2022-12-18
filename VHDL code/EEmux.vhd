LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


-- Mux selector is RegDst
ENTITY EEmux IS
     PORT( 
            Rdst,Rsrc1: In std_logic_vector(2 downto 0);       
            Sel: In std_logic;
            
            Output: Out std_logic_vector(2 downto 0)
          );
END EEmux;

ARCHITECTURE myEEmux OF EEmux IS
BEGIN

Output <= Rdst When Sel ='0'
     ELSE Rsrc1;
END myEEmux;





