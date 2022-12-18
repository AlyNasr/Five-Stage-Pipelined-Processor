LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Jump_Decision IS
        PORT(  Jclk: in std_logic;
               ZF, NF, CF: IN std_logic;      -- input flags from the CCR
               JZ, JN, JC, Jmp: IN std_logic; 
			         
               jmpDecision: OUT std_logic_vector(1 downto 0);
               jMemPc: in std_logic);  -- 01 if jump is taken
END Jump_Decision;



ARCHITECTURE my_jump OF Jump_Decision IS
  Signal sigZF: std_logic;
  Signal sigNF: std_logic;
  Signal sigCF: std_logic;
BEGIN      
   
  
 PROCESS(Jclk)
BEGIN
IF falling_edge(Jclk)  THEN  
 sigZF <= ZF;
 sigNF <= NF;
 sigCF <= CF;
  
END IF; 	    

END PROCESS;
 jmpDecision <= "01" WHEN    (sigZF = '1' AND JZ ='1') 
                          OR (sigNF = '1' AND JN ='1')
                          OR (sigCF = '1' AND JC ='1')
                           OR (jmp = '1')
             ELSE "10"   WHEN jMemPc ='1'            
						   
             ELSE "00";
 
 -- jmpDecision <= "01" WHEN    (ZF = '1' AND JZ ='1') 
 --                         OR (NF = '1' AND JN ='1')
   --                       OR (CF = '1' AND JC ='1')
     --                      OR (jmp = '1')
       --      ELSE "10"   WHEN jMemPc ='1'            
						   
        --     ELSE "00";
 
END my_jump;



