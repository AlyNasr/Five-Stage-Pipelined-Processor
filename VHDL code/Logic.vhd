Library ieee;
use ieee.std_logic_1164.all;
Entity Logic IS
    
  Port ( 
  A: IN std_logic_vector (31  downto 0);
  B: IN std_logic_vector (31 downto 0);
  control_signal: IN std_logic_vector(3 downto 0);
  
  F: OUT std_logic_vector (31 downto 0);
  flag: OUT std_logic_vector (1 downto 0)  -- only zero and negative flags, no carry flag in case of logic operations
);
End Logic;

Architecture my_logic of Logic IS 
 signal out_signal: std_logic_vector(31 downto 0);
begin
  out_signal <=   NOT A  WHEN  control_signal = "1010"
                  Else A AND B  WHEN  control_signal = "0110"
                  Else A OR  B  WHEN  control_signal = "0111";
   
   F<= out_signal;
   
   flag(0) <= '1' WHEN out_signal = ("00000000000000000000000000000000")
         ELSE '0';
           
   flag(1) <= '1' WHEN out_signal(31) ='1'
         ELSE '0';
   
        
           
end my_logic ;



