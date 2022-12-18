LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


ENTITY Shift IS
   PORT ( A,B:  IN std_logic_vector(31 DOWNTO 0);
         
         control_signal: IN std_logic_vector(3 downto 0);
         F:  OUT  std_logic_vector(31 DOWNTO 0);
         flag: OUT std_logic_vector (2 downto 0));
END  Shift;

ARCHITECTURE my_shift of shift IS
   signal out_signal: std_logic_vector(31 downto 0);
 BEGIN
 out_signal <=  std_logic_vector(shift_left(unsigned(A),to_integer(unsigned(B))))  WHEN control_signal = "1000"  --SHL
          ELSE  std_logic_vector(shift_right(unsigned(A),to_integer(unsigned(B)))) WHEN control_signal = "1001"; --SHR  
    
 F <= out_signal;
 
 flag(0) <= '1' WHEN out_signal = ("00000000000000000000000000000000")
         ELSE '0';
           
   flag(1) <= '1' WHEN out_signal(31) ='1'
         ELSE '0';
 
 flag(2) <=   A(32 - to_integer(unsigned(B)))    WHEN control_signal = "1000" AND B /= "00000000000000000000000000000000"  --SHL
        ELSE  A(to_integer(unsigned(B) -1))      WHEN control_signal = "1001" AND B /= "00000000000000000000000000000000";  --SHR
    
 END my_shift;


