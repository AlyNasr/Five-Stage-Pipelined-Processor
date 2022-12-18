LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


ENTITY StackPointer IS
     PORT( clk,rst : IN std_logic;
           --In_Sp: IN std_logic_vector (31 downto 0);
           In_SPvalue: IN std_logic_vector (2 downto 0); 
           IN_SPenable: IN std_logic;  
           IN_Interru: In std_logic;
           out_Sp : OUT std_logic_vector (31 downto 0);
           memAddress: OUT std_logic_vector (31 downto 0);
           IntrAddress: OUT std_logic_vector (31 downto 0)
           );
END Stackpointer;

ARCHITECTURE mystack OF StackPointer IS
Signal SpSignal: std_logic_vector (31 downto 0); 
Signal AddressL: std_logic_vector (15 downto 0);
Signal AddressU: std_logic_vector (15 downto 0);
BEGIN
  
PROCESS(clk,rst)
BEGIN
IF(rst = '1') THEN
     SpSignal <= "00000000000000000000011111111110"; -- initial stack value = 7FE

ELSIF falling_edge(clk)  THEN  
 if (IN_Interru = '1') then
     SpSignal <= std_logic_vector(to_unsigned(to_integer(unsigned(SpSignal) - 2),32));
else 
  if (IN_SPenable = '1') then  
 	   if ( In_SPvalue = "001") then
         SpSignal <= std_logic_vector(to_unsigned(to_integer(unsigned(SpSignal) - 2),32));
    elsif (In_SPvalue = "010") then
         SpSignal <= std_logic_vector(to_unsigned(to_integer(unsigned(SpSignal) + 2),32));
    elsif (In_SPvalue = "011") then
         SpSignal <= std_logic_vector(to_unsigned(to_integer(unsigned(SpSignal) + 2),32));
     elsif ( In_SPvalue = "110") then
         SpSignal <= std_logic_vector(to_unsigned(to_integer(unsigned(SpSignal) - 2),32));
     elsif (In_SPvalue = "100") then
         SpSignal <= std_logic_vector(to_unsigned(to_integer(unsigned(SpSignal) + 2),32));
   
    else 
        SpSignal <= SpSignal;
END IF;        
END IF;
END IF; 	    
END IF;
END PROCESS;
out_Sp <= SpSignal;

memAddress <=  std_logic_vector(to_unsigned(to_integer(unsigned(SpSignal) + 2),16))  & std_logic_vector(to_unsigned(to_integer(unsigned(SpSignal) + 3),16)) 
                WHEN In_SPvalue = "001" OR  In_SPvalue = "110" 
         ELSE  SpSignal(15 downto 0) & std_logic_vector(to_unsigned(to_integer(unsigned(SpSignal) + 1),16)) 
                WHEN In_SPvalue = "010" OR In_SPvalue = "011" OR In_SPvalue = "100" ;
IntrAddress <=  std_logic_vector(to_unsigned(to_integer(unsigned(SpSignal)),16))  & std_logic_vector(to_unsigned(to_integer(unsigned(SpSignal)),16)) 
                WHEN IN_Interru = '1';
                   
END mystack;


