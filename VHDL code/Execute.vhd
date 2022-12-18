LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


ENTITY Execute IS
     PORT( 
        Eclk, Erst: In std_logic;
       E_Extended_ImmVal: in std_logic_vector(31 downto 0);
       E_Extended_EA: in std_logic_vector(31 downto 0);
       
       E_Rdst : in std_logic_vector (2 downto 0);
       E_Rsrc1: in std_logic_vector (2 downto 0);
       E_Rsrc2: in std_logic_vector (2 downto 0);
      
       
       --Reg File Outputs
       E_OutData1: in std_logic_vector(31 downto 0);
       E_OutData2: in std_logic_vector(31 downto 0);
       
       -- Control unit outputs
       E_ALUop		:in std_logic_vector(3 downto 0);
       E_ALUsrc		:in std_logic;
--E_SpValue	:in std_logic_vector(2 downto 0);
--E_Save		:in std_logic;
	 E_Restore	:in std_logic;
	     E_R1Data		:in std_logic_vector(1 downto 0);
	     E_RegDst		:in std_logic;
	 --E_MemData	:in std_logic_vector(1 downto 0);
	 --E_MemAddress	:in std_logic;
	 E_MemToReg	:in std_logic_vector(2 downto 0);
	     E_RegWrite1	:in std_logic;
	     E_RegWrite2	:in std_logic;
	 --E_MemWrite	:in std_logic;
	    E_SetC		:in std_logic;
	    E_ClrC		:in std_logic;
	    E_JZ			:in std_logic;
	    E_JN			:in std_logic;
	    E_JC			:in std_logic;
	    E_JMP		:in std_logic;
	    E_Den_CCR: in std_logic;
	    E_Interrupt: in std_logic;
	    E_MemPc: in std_logic;
	    -- Outputs
	     OUT_E_Rdst : out std_logic_vector (2 downto 0);
       ALU_Result : out std_logic_vector (31 downto 0);
       E_Zeroflag: out std_logic; 
       E_Negativeflag: out std_logic;
       E_Carryflag: out std_logic;
       Out_E_Extended_EA: Out std_logic_vector(31 downto 0);
       E_SR1: Out std_logic_vector(31 downto 0);
       E_SR2: Out std_logic_vector(31 downto 0);
       E_JumpDecision: out std_logic_vector(1 downto 0);
       E_CF_en: In std_logic
     );
END Execute;

ARCHITECTURE myexecute OF Execute IS
component Emux IS
     PORT( 
            R,ImmVal: In std_logic_vector(31 downto 0);       
            S: In std_logic;
            
            Output: Out std_logic_vector(31 downto 0)
          );
END component;

-- Mux selector is RegDst
component EEmux IS
     PORT( 
            Rdst,Rsrc1: In std_logic_vector(2 downto 0);       
            Sel: In std_logic;
            
            Output: Out std_logic_vector(2 downto 0)
          );
End component;

component ALU IS
  Port ( 
    
-- Inputs
IN1: IN std_logic_vector (31 downto 0);
IN2: IN std_logic_vector (31 downto 0);
Control_Unit_Signal: IN std_logic_vector(3 downto 0);
  
-- Outputs
Result: OUT std_logic_vector (31 downto 0);
--Flags :  OUT std_logic_vector(2 downto 0)  -- Flags(0) = zero flag
                                           -- Flags(1) = negative flag
  zeroFlag : out std_logic;
  NegativeFlag : out std_logic;
  CarryFlag: out std_logic;
  A_JD: in std_logic_vector(1 downto 0);
  A_JZ: in std_logic;   
  A_JN: in std_logic;
  A_JC: in std_logic                          
);
End component;

component CCR IS
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
END component;

component Swap IS
     PORT( 
            IN_R1: in std_logic_vector(31 downto 0); 
            IN_R2: in std_logic_vector(31 downto 0);
            Selector: in std_logic_vector(2 downto 0); 
            
            Out_R1: out std_logic_vector(31 downto 0); 
            Out_R2: out std_logic_vector(31 downto 0)
            
         );
END component;

component Jump_Decision IS
        PORT(  Jclk: in std_logic;
               ZF, NF, CF: IN std_logic;      -- input flags from the CCR
               JZ, JN, JC, Jmp: IN std_logic; 
			         
               jmpDecision: OUT std_logic_vector(1 downto 0);
               jMemPc: in std_logic);  -- 01 if jump is taken
END component;

component SavedFlags IS
     PORT( 
           S_ZF,S_NF,S_CF: in std_logic;
           S_Int: in std_logic;
           
           OutS_ZF, OutS_NF, OutS_CF: out std_logic
           
           );
END component;



Signal ALU_In2: std_logic_vector(31 downto 0);
Signal SzeroFlag, SNegativeFlag, SCarryFlag: std_logic; 
Signal JZf,JNf,JCf: std_logic;    
Signal SigjmpDec: std_logic_vector(1 downto 0); 
SIGNAL SavedZF, SavedNF, SavedCF :  std_logic;                        
BEGIN

UEmux :  Emux port map (E_Outdata2,E_Extended_ImmVal,E_ALUsrc, ALU_In2);
UEEmux : EEmux port map (E_Rdst,E_Rsrc1,E_RegDst,Out_E_Rdst);
UALU : ALU port map (E_outdata1, ALU_in2,E_ALUop, ALu_result,SzeroFlag, SNegativeFlag, SCarryFlag,
                     SigjmpDec, JZf, JNf, JCf );
--UC: CCR port map (Eclk, Erst, SzeroFlag, SNegativeFlag, SCarryFlag,E_setc, E_clrc, E_Zeroflag, E_Negativeflag,
--                  E_Carryflag,E_Den_CCR);
UC: CCR port map (Eclk, Erst, SzeroFlag, SNegativeFlag, SCarryFlag, SavedZF, SavedNF, SavedCF, E_Restore ,E_setc, E_clrc, JZf, JNf,
                   JCf,E_Den_CCR, E_CF_en);              
US: SavedFlags port map (JZf, JNf, JCF, E_Interrupt, SavedZF, SavedNF, SavedCF );              

UjmpDecide: Jump_Decision port map (Eclk,JZf, JNf, JCf, E_JZ, E_JN, E_JC, E_Jmp, SigjmpDec, E_MemPc);                   
Uswap: Swap port map (E_OutData1, E_OutData2, E_MemToReg, E_SR1, E_SR2 );                   
Out_E_Extended_EA <=  E_Extended_EA;                

E_Zeroflag <=  JZf;
E_Negativeflag <= Jnf;
E_Carryflag <= jcf; 
E_JumpDecision <= SigjmpDec;
END myexecute;



