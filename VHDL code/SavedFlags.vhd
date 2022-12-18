LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


ENTITY SavedFlags IS
     PORT( 
           S_ZF,S_NF,S_CF: in std_logic;
           S_Int: in std_logic;
           
           OutS_ZF, OutS_NF, OutS_CF: out std_logic
           
           );
END SavedFlags;


ARCHITECTURE mysavedFlags OF SavedFlags IS
 BEGIN
 OutS_ZF <= S_ZF WHEN S_Int ='1';

OutS_NF <= S_NF WHEN S_Int ='1';
  
OutS_CF <= S_CF WHEN S_Int ='1';
 
END mySavedFlags;



