LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


ENTITY CCR IS
        PORT( 
              Cclk,Crst: In std_logic;
              ZF_IN_ALU,  NF_IN_ALU,  CF_IN_ALU : IN std_logic;        -- Inputs from the ALU
                                                                
              ZF_IN_Saved, NF_IN_Saved, CF_IN_Saved: IN std_logic; -- Inputs from the saved flags 
              restore : in std_logic;
              --Save_IN, restore, SETC, CLRC: IN std_logic;            
              SETC, CLRC: IN std_logic; 
               --Save_OUT: OUT std_logic; 
              ZF_OUT,NF_OUT,CF_OUT: OUT std_logic;
              en: In std_logic;
              CF_en: In std_logic
            );    
END CCR;

ARCHITECTURE my_CCR OF CCR IS
  Signal SZF_Out : std_logic;
  Signal SNF_Out : std_logic;
  Signal SCF_Out : std_logic;
BEGIN      

PROCESS(cclk,crst)
BEGIN
IF(crst = '1') THEN
    ZF_Out <= '0';
    NF_Out <= '0';
    CF_Out <= '0';
  
  ELSIF falling_edge(cclk)  THEN     
 	 if(en ='1') THEN
 	 --if (SETC = '1') then 
   --  CF_OUT<='1';
   --  ZF_OUT<=ZF_IN_ALU;
   --  NF_OUT<= NF_IN_ALU;
   --else if (CLRC = '1') then 
    --CF_OUT<= '0';
    --ZF_OUT<=ZF_IN_ALU;
    --NF_OUT<= NF_IN_ALU;
   --else   
      if (restore = '1') Then
        ZF_Out<=ZF_IN_Saved;
        NF_Out<= NF_IN_Saved;
        CF_Out<= CF_IN_Saved;
      ELSE
    ZF_Out<=ZF_IN_ALU;
    NF_Out<= NF_IN_ALU;
        if (CF_en = '1') Then
        CF_Out<= CF_IN_ALU;
      END if;
   END IF;
   END IF;
END IF;
END PROCESS;
   -- ZF_Out <= ZF_IN_Saved WHEN restore = '1'
    --     ELSE SZF_Out;
    
    --NF_Out <= NF_IN_Saved WHEN restore = '1'
    --     ELSE SNF_Out;

    --CF_Out <= CF_IN_Saved WHEN restore = '1'
    --     ELSE SCF_Out;

END my_CCR;



