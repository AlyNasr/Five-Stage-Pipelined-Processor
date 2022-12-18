LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


-- Mux to select Rdst data or PC or Pc + 2 as an input data to memory
ENTITY DataMemMux IS
     PORT( 
            IN_Rdata,IN_PcVal, IN_PcValPlusTwo: In std_logic_vector(31 downto 0);       
            In_Sd: In std_logic_vector(1 downto 0);
            
            OutpData: Out std_logic_vector(31 downto 0);
            PC_Intr: In std_logic_vector(31 downto 0);
            DM_Intr: In std_logic
          );
END DataMemmux;

ARCHITECTURE mydatamux OF DataMemmux IS
BEGIN

OutpData <= IN_PcVal When In_Sd = "01"
     ELSE IN_PcValPlusTwo WHEN In_Sd = "10" 
     ELSE PC_Intr WHEN DM_Intr = '1'
     ELSE  IN_Rdata;
END mydatamux;







