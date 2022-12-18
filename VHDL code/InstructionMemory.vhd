LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY InstructionMemory IS
 PORT (
       PC_in : IN std_logic_vector(31 DOWNTO 0);
       
	     InstructionOut: OUT std_logic_vector(31 DOWNTO 0);
	     
	     ResetAddress: OUT std_logic_vector(31 DOWNTO 0);
	     InterruptAddress: OUT std_logic_vector(31 DOWNTO 0)
	     );
END ENTITY InstructionMemory;

ARCHITECTURE myMemory OF InstructionMemory IS  
  TYPE instMem IS ARRAY(0 TO 2048) of std_logic_vector(15 DOWNTO 0);
  signal instruction: instMem;
  
  Begin
 InstructionOut <= (instruction(to_integer(unsigned(PC_in)) +1) & instruction(to_integer(unsigned(PC_in)))); 
 ResetAddress <= instruction(1) & instruction(0);
 InterruptAddress <= instruction(3) & instruction(2);
End myMemory;