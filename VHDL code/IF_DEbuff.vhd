LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


ENTITY FE_DEbuff IS
     PORT( 
           clk,rst,we: IN std_logic;
           
           FD_IN_PC : IN std_logic_vector(31 downto 0);
           FD_IN_Instruction: IN std_logic_vector(31 downto 0);
           FD_IN_Port: IN std_logic_vector(31 downto 0);
            IN_FD_PcPlusTwo: IN std_logic_vector(31 downto 0);
            IN_FDIntr: in std_logic;
           FD_OUT_PC : OUT std_logic_vector(31 downto 0);
           FD_OUT_Instruction: OUT std_logic_vector(31 downto 0);
           OFD_IN_Port: OUT std_logic_vector(31 downto 0);
           Out_FD_PcPlusTwo: OUT std_logic_vector(31 downto 0);
           Out_FDIntr: Out std_logic           
        );
END FE_DEbuff;

ARCHITECTURE myFDbuff OF FE_DEbuff IS
BEGIN

PROCESS(clk,rst)
BEGIN
IF(rst = '1') THEN
     FD_OUT_PC <= (OTHERS=>'0');
     FD_OUT_Instruction <= (OTHERS=>'0');
     OFD_IN_Port <= (OTHERS=>'0');
     Out_FD_PcPlusTwo <= (OTHERS=>'0');
     Out_FDIntr <= '0';
ELSIF rising_edge(clk)  THEN     
 	    if (we = '1') THEN
 	     FD_OUT_PC <= FD_IN_PC;
       FD_OUT_Instruction <= FD_IN_Instruction;
       OFD_IN_Port <=  FD_IN_Port; 
       Out_FD_PcPlusTwo <= IN_FD_PcPlusTwo;
       Out_FDIntr <= In_FDIntr;
 	    End if;
END IF;
END PROCESS;


END myFDbuff;

