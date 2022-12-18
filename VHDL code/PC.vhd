LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


ENTITY PC_Reg IS
     PORT( clk,rst, Interrupt: IN std_logic;
           --d: IN std_logic_vector (31 downto 0);   
           PCResetAddress: IN std_logic_vector(31 DOWNTO 0);
	         PCInterruptAddress: IN std_logic_vector(31 DOWNTO 0);
	         Jsel: In std_logic_vector(1 downto 0);
	         Pc_Reg: IN std_logic_vector(31 DOWNTO 0);
	         Pc_Mem: IN std_logic_vector(31 DOWNTO 0);
	         
           PC_out : OUT std_logic_vector (31 downto 0);
           PC_PlusTwo: OUT std_logic_vector (31 downto 0);
           pIntrOnCall: std_logic );
END PC_Reg;

ARCHITECTURE myPC_Reg OF PC_Reg IS
  
  signal temppc: std_logic_vector (31 downto 0);
  signal PcoutSig: std_logic_vector (31 downto 0);
BEGIN
PROCESS(clk,rst)
BEGIN
IF(rst = '1') THEN
    temppc <= PCResetAddress;
ELSIF (Interrupt = '1') THEN
     temppc <= PCInterruptAddress;
ElsIF rising_edge(clk)  THEN 
    If (Jsel = "01") Then
          if (pIntrOnCall = '1') then
               temppc <= std_logic_vector(to_unsigned((to_integer(unsigned(temppc))+ 2),temppc'length));
          Else 
              temppc <= Pc_Reg;
          END IF; 
    ELSIF (Jsel = "10") THEN
     temppc <= Pc_Mem;
  
    Else    
 	    temppc <= std_logic_vector(to_unsigned((to_integer(unsigned(temppc))+ 2),temppc'length));
	  End If;  
END IF;
END PROCESS;

--PC_out <= temppc;
PcoutSig <= PCResetAddress WHEN rst ='1'
    ELSE   PCInterruptAddress When Interrupt = '1'
    ELSE temppc; 
PC_out <= PcoutSig;
PC_PlusTwo <= std_logic_vector(to_unsigned((to_integer(unsigned(PcoutSig))+ 2),temppc'length));      
END myPC_Reg;
