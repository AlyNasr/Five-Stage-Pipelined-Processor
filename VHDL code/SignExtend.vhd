LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


ENTITY SignExtend IS
     PORT( 
       IN_Immediate: IN std_logic_vector(15 downto 0);
       Extended_ImmValue : OUT std_logic_vector(31 downto 0);
       
       IN_EA: IN std_logic_vector(19 downto 0);
       Extended_EA : OUT std_logic_vector(31 downto 0)
       
       
     );
END SignExtend;

ARCHITECTURE mysign OF SignExtend IS
BEGIN
Extended_ImmValue <= ("0000000000000000" & IN_Immediate);
Extended_EA <= ("000000000000" & IN_EA);

END mysign;

