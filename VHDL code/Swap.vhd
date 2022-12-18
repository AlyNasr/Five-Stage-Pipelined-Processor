LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY Swap IS
     PORT( 
            IN_R1: in std_logic_vector(31 downto 0); 
            IN_R2: in std_logic_vector(31 downto 0);
            Selector: in std_logic_vector(2 downto 0); 
            
            Out_R1: out std_logic_vector(31 downto 0); 
            Out_R2: out std_logic_vector(31 downto 0)
            
         );
END Swap;

ARCHITECTURE myswap OF Swap IS
  BEGIN
 
Out_R1 <= IN_R2 WHEN Selector = "011"
     ELSE IN_R1;
       
Out_R2 <= IN_R1 WHEN Selector = "011"
     ELSE IN_R2;
       
       
END myswap;







