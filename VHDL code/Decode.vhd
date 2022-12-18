LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
ENTITY Decode IS
     PORT( 
       Dclk, Drst: In std_logic;
       D_Instruction: In std_logic_vector(31 downto 0);
       
       --Inputs from the Write BackStage
         WB_WriteAddress1: in std_logic_vector(2 downto 0);
         WB_WriteAddress2: in std_logic_vector(2 downto 0); 
         WB_WriteData1: in std_logic_vector(31 downto 0);
         WB_WriteData2: in std_logic_vector(31 downto 0);
         WB_WriteEnable1 : in std_logic;
         WB_WriteEnable2 : in std_logic;
       --
         D_Interrupt: in std_logic; 
       --
       Rdst: OUT std_logic_vector (2 downto 0);
       Rsrc1:OUT std_logic_vector (2 downto 0);
       Rsrc2: OUT std_logic_vector (2 downto 0);
       --
              --Sign Extend Outputs
       D_Extended_ImmVal: Out std_logic_vector(31 downto 0);
       D_Extended_EA : Out std_logic_vector(31 downto 0);
       
       --Reg File Outputs
       D_OutData1: Out std_logic_vector(31 downto 0);
       D_OutData2: Out std_logic_vector(31 downto 0);
       
       -- Control unit outputs
       D_ALUop		:out std_logic_vector(3 downto 0);
       D_ALUsrc		:out std_logic;
--D_SpValue	:out std_logic_vector(2 downto 0);
--D_Save		:out std_logic;
	 D_Restore	:out std_logic;
	     D_R1Data		:out std_logic_vector(1 downto 0);
	     D_RegDst		:out std_logic;
	 D_MemData	:out std_logic_vector(1 downto 0);
	 D_MemAddress	:out std_logic_vector(1 downto 0);
	 D_MemToReg	:out std_logic_vector(2 downto 0);
	     D_RegWrite1	:out std_logic;
	     D_RegWrite2	:out std_logic;
	 D_MemWrite	:out std_logic;
	    D_SetC		:out std_logic;
	    D_ClrC		:out std_logic;
	    D_JZ			:out std_logic;
	    D_JN			:out std_logic;
	    D_JC			:out std_logic;
	    D_JMP		:out std_logic;
	    D_Outp: out std_logic;
	    D_en_CCR: out std_logic;
	    
	    D_SP: Out std_logic_vector(31 downto 0);
	    D_OutMemAddress: Out std_logic_vector(31 downto 0);
	    D_IntrAddress: Out std_logic_vector(31 downto 0);
	    
	   DReg0: Out std_logic_vector(31 downto 0);
     DReg1: Out std_logic_vector(31 downto 0);
     DReg2: Out std_logic_vector(31 downto 0);
     DReg3: Out std_logic_vector(31 downto 0);
     DReg4: Out std_logic_vector(31 downto 0);
     DReg5: Out std_logic_vector(31 downto 0);
     DReg6: Out std_logic_vector(31 downto 0);
     DReg7: Out std_logic_vector(31 downto 0);
     
 
	 D_MemPc: out std_logic;
	 D_CF_en: out std_logic
	
     );
END Decode;

ARCHITECTURE mydecode OF Decode IS

Component RegisterFile is
port (
clk,rst: in std_logic;

ReadAddress1 : in std_logic_vector(2 downto 0);
ReadAddress2 : in std_logic_vector(2 downto 0);
OutData1 : out std_logic_vector (31 downto 0);
OutData2 : out std_logic_vector (31 downto 0);
	
WriteAddress1: in std_logic_vector(2 downto 0);
WriteAddress2: in std_logic_vector(2 downto 0);
WriteData1: in std_logic_vector(31 downto 0);
WriteData2: in std_logic_vector(31 downto 0);
WriteEnable1 : in std_logic;
WriteEnable2 : in std_logic;

     Reg0: Out std_logic_vector(31 downto 0);
     Reg1: Out std_logic_vector(31 downto 0);
     Reg2: Out std_logic_vector(31 downto 0);
     Reg3: Out std_logic_vector(31 downto 0);
     Reg4: Out std_logic_vector(31 downto 0);
     Reg5: Out std_logic_vector(31 downto 0);
     Reg6: Out std_logic_vector(31 downto 0);
     Reg7: Out std_logic_vector(31 downto 0)
     
 );
end component;

Component SignExtend IS
     PORT( 
       IN_Immediate: IN std_logic_vector(15 downto 0);
       Extended_ImmValue : OUT std_logic_vector(31 downto 0);
       
       IN_EA: IN std_logic_vector(19 downto 0);
       Extended_EA : OUT std_logic_vector(31 downto 0)
    );
END component;

component Controlunit is 
port(
reset       :in std_logic;
opcode      :in std_logic_vector(4 downto 0);
C_Interrupt: in std_logic;

ALUop		:out std_logic_vector(3 downto 0);
ALUsrc		:out std_logic;
SpValue	:out std_logic_vector(2 downto 0);
   --Save		:out std_logic;
	 Restore	:out std_logic;
	 R1Data		:out std_logic_vector(1 downto 0);
	 RegDst		:out std_logic;
	 MemData	:out std_logic_vector(1 downto 0);
	 MemAddress	:out std_logic_vector(1 downto 0);
	 MemToReg	:out std_logic_vector(2 downto 0);
	 RegWrite1	:out std_logic;
	 RegWrite2	:out std_logic;
	 MemWrite	:out std_logic;
	 SetC		:out std_logic;
	 ClrC		:out std_logic;
	 JZ			:out std_logic;
	 JN			:out std_logic;
	 JC			:out std_logic;
	 JMP		:out std_logic;
	 Outp: out std_logic;
	 en_CCR: out std_logic;
	Sp_en: out std_logic;
	 MemPc: out std_logic;
	 CF_en: out std_logic
	
);
end component;

component StackPointer IS
     PORT( clk,rst : IN std_logic;
           
           In_SPvalue: IN std_logic_vector (2 downto 0); 
           IN_SPenable: IN std_logic;  
           IN_Interru: In std_logic;
           out_Sp : OUT std_logic_vector (31 downto 0);
           memAddress: OUT std_logic_vector (31 downto 0);
           IntrAddress: OUT std_logic_vector (31 downto 0)
           );
END component;

-- Signals
Signal TempWriteData: std_logic_vector(31 downto 0);
Signal OpReadAddress1: std_logic_vector(2 downto 0);
Signal OpReadAddress2: std_logic_vector(2 downto 0);
Signal TempSPval: std_logic_vector(2 downto 0);
Signal TempSPen: std_logic;
BEGIN
S: SignExtend Port Map (D_Instruction(20 downto 5),D_Extended_ImmVal, D_Instruction(23 downto 4), D_Extended_EA);

--R: RegisterFile Port Map (Dclk, Drst , D_Instruction(26 downto 24) , D_Instruction(23 downto 21) , D_OutData1 , D_OutData2 ,
 --  "000" , "000" , TempWriteData, TempWriteData, '0', '0');

OpReadAddress1 <= D_Instruction(23 downto 21) WHEN     D_Instruction(31 downto 27) = "01001"
                                                    OR D_Instruction(31 downto 27) = "01010"
                                                    OR D_Instruction(31 downto 27) = "01011"
                                                    OR D_Instruction(31 downto 27) = "01100"
                                                    OR D_Instruction(31 downto 27) = "01101"
               ELSE  D_Instruction(26 downto 24);   

OpReadAddress2 <= D_Instruction(20 downto 18) WHEN     D_Instruction(31 downto 27) = "01001"
                                                    OR D_Instruction(31 downto 27) = "01011"
                                                    OR D_Instruction(31 downto 27) = "01100"
                                                    OR D_Instruction(31 downto 27) = "01101"
              ELSE D_Instruction(23 downto 21);   
                                               
                                                    
R: RegisterFile Port Map (Dclk, Drst , OpReadAddress1, OpReadAddress2 , D_OutData1 , D_OutData2 ,
   WB_WriteAddress1, WB_WriteAddress2 , WB_WriteData1, WB_WriteData2, WB_WriteEnable1, WB_WriteEnable2,
   DReg0,DReg1,DReg2,DReg3, DReg4,DReg5,DReg6,DReg7);
 
C: ControlUnit Port Map (Drst, D_Instruction(31 downto 27) ,D_Interrupt ,D_ALUop,	D_ALUsrc, TempSPval, D_Restore,D_R1Data,D_RegDst,D_MemData ,D_MemAddress	,D_MemToReg,
               D_RegWrite1, D_RegWrite2,	D_MemWrite,D_SetC,	D_ClrC, D_JZ,	D_JN, D_JC, D_JMP , D_Outp, D_en_CCR, TempSPen,  D_MemPc, D_CF_en); 

U_S: StackPointer port map (Dclk, Drst, TempSPval, TempSPen,D_Interrupt ,D_SP, D_OutMemAddress, D_IntrAddress);	 

       Rdst <= D_Instruction(26 downto 24);
       Rsrc1 <= D_Instruction(23 downto 21);
       Rsrc2  <= D_Instruction(20 downto 18);
END mydecode;
       
