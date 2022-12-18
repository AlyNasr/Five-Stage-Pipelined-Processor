LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


ENTITY Integrated IS
     PORT(
      
          Clk: IN std_logic;
          Rst: IN std_Logic;
          Interrupt: IN std_logic;
     
     I_PC: Out std_logic_vector(31 downto 0);
     I_SP: Out std_logic_vector(31 downto 0);
     
     IR0: Out std_logic_vector(31 downto 0);
     IR1: Out std_logic_vector(31 downto 0);
     IR2: Out std_logic_vector(31 downto 0);
     IR3: Out std_logic_vector(31 downto 0);
     IR4: Out std_logic_vector(31 downto 0);
     IR5: Out std_logic_vector(31 downto 0);
     IR6: Out std_logic_vector(31 downto 0);
     IR7: Out std_logic_vector(31 downto 0);
     
     I_ZeroFlag: out std_logic;
     I_NegativeFlag: out std_logic;
     I_CarryFlag: out std_logic;
     
     In_Port: IN std_logic_vector(31 downto 0);
     OutPort: Out std_logic_vector(31 downto 0)
     
        );
END integrated;

ARCHITECTURE myintegrated OF integrated IS

component Fetch IS
     PORT( Fclk,Frst, FInterrupt : IN std_logic;
           F_JmpDec: IN std_logic_vector(1 downto 0);
           F_RegData,F_MemSpData: In std_logic_vector(31 downto 0);
           
           Out_PC: Out std_logic_vector (31 downto 0);     
           out_Instruction : OUT std_logic_vector (31 downto 0);
           Out_PcPlusTwo: OUT std_logic_vector (31 downto 0);
           IntrOnCall: std_logic);
END component;

Component FE_DEbuff IS
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
END component;

component Decode IS
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
END component;

Component DE_EXbuff IS
     PORT( 
  DEclk,DErst,DEwe: IN std_logic;
      
       IN_D_Rdst: IN std_logic_vector (2 downto 0);
       IN_D_Rsrc1: IN std_logic_vector (2 downto 0);
       IN_D_Rsrc2: IN std_logic_vector (2 downto 0);     
       --Inputs
       IN_D_Extended_ImmVal: IN std_logic_vector(31 downto 0);
       IN_D_Extended_EA : IN std_logic_vector(31 downto 0);
       
       --Reg File Outputs
       IN_D_OutData1: IN std_logic_vector(31 downto 0);
       IN_D_OutData2: IN std_logic_vector(31 downto 0);
       
       -- Control unit outputs
       IN_D_ALUop		:IN std_logic_vector(3 downto 0);
       IN_D_ALUsrc		:IN std_logic;
--IN_D_SpValue	:IN std_logic_vector(2 downto 0);
--IN_D_Save		:IN std_logic;
	 IN_D_Restore	:IN std_logic;
	     IN_D_R1Data		:IN std_logic_vector(1 downto 0);
	     IN_D_RegDst		:IN std_logic;
	 IN_D_MemData	:IN std_logic_vector(1 downto 0);
	 IN_D_MemAddress	:IN std_logic_vector(1 downto 0);
	 IN_D_MemToReg	:IN std_logic_vector(2 downto 0);
	     IN_D_RegWrite1	:IN std_logic;
	     IN_D_RegWrite2	:IN std_logic;
	 IN_D_MemWrite	:IN std_logic;
	    IN_D_SetC		:IN std_logic;
	    IN_D_ClrC		:IN std_logic;
	    IN_D_JZ			:IN std_logic;
	    IN_D_JN			:IN std_logic;
	    IN_D_JC			:IN std_logic;
	    IN_D_JMP		:IN std_logic;
	    
	    DEIN_Port: IN std_logic_vector(31 downto 0);
	    IN_Outp: IN std_logic;
	    INen_CCR: IN std_logic;
       
       IN_SR1data: In std_logic_vector(31 downto 0);
       IN_SR2data: In std_logic_vector(31 downto 0);
       
       IN_Dsp: In std_logic_vector(31 downto 0);
       IN_MemAddress: in std_logic_vector(31 downto 0);
       
       IN_Pc: in std_logic_vector(31 downto 0);
       IN_PcPlusTwo: in std_logic_vector(31 downto 0);
       IN_Interr: in std_logic;
       IN_MemPc: in std_logic;
       IN_CF_en: in std_logic;
       -- Outputs
       OUT_D_Extended_ImmVal: Out std_logic_vector(31 downto 0);
       OUT_D_Extended_EA : Out std_logic_vector(31 downto 0);
       
       OUT_D_Rdst: OUT std_logic_vector (2 downto 0);
       OUT_D_Rsrc1: OUT std_logic_vector (2 downto 0);
       OUT_D_Rsrc2: OUT std_logic_vector (2 downto 0);
       
       --Reg File Outputs
       OUT_D_OutData1: Out std_logic_vector(31 downto 0);
       OUT_D_OutData2: Out std_logic_vector(31 downto 0);
       
       -- Control unit outputs
       OUT_D_ALUop		:out std_logic_vector(3 downto 0);
       OUT_D_ALUsrc		:out std_logic;
--OUT_D_SpValue	:out std_logic_vector(2 downto 0);
--OUT_D_Save		:out std_logic;
	 OUT_D_Restore	:out std_logic;
	     OUT_D_R1Data		:out std_logic_vector(1 downto 0);
	     OUT_D_RegDst		:out std_logic;
	 OUT_D_MemData	:out std_logic_vector(1 downto 0);
	 OUT_D_MemAddress	:out std_logic_vector(1 downto 0);
	 OUT_D_MemToReg	:out std_logic_vector(2 downto 0);
	     OUT_D_RegWrite1	:out std_logic;
	     OUT_D_RegWrite2	:out std_logic;
	 OUT_D_MemWrite	:out std_logic;
	    OUT_D_SetC		:out std_logic;
	    OUT_D_ClrC		:out std_logic;
	    OUT_D_JZ			:out std_logic;
	    OUT_D_JN			:out std_logic;
	    OUT_D_JC			:out std_logic;
	    OUT_D_JMP		:out std_logic;
	    ODEIN_Port: out std_logic_vector(31 downto 0);
	    OUT_Outp: Out std_logic;
	    Outen_CCR: out std_logic;
	    OUT_SR1data: out std_logic_vector(31 downto 0);
      OUT_SR2data: out std_logic_vector(31 downto 0);
      Out_Dsp: Out std_logic_vector(31 downto 0);
      Out_MemAddress: out std_logic_vector(31 downto 0);
      Out_Pc: out std_logic_vector(31 downto 0);
      Out_PcPlusTwo: out std_logic_vector(31 downto 0);
      Out_Interr: out std_logic;
      Out_MemPc: out std_logic;
      Out_CF_en: out std_logic
              
           
        );
END component;

component Execute IS
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
END component;

component Ex_MemBuff IS
        PORT( 
                 EMclk,EMrst : in std_logic;
              
              IN_E_Rdst : in std_logic_vector (2 downto 0);
              IN_ALU_Result : in std_logic_vector (31 downto 0);
              IN_E_Zeroflag: in std_logic; 
              IN_E_Negativeflag: in std_logic;
              IN_E_Carryflag: in std_logic;
              IN_E_Extended_EA: in std_logic_vector(31 downto 0);
              IN_E_MemAddress: in std_logic_vector(1 downto 0);
              IN_E_MemToReg: in std_logic_vector(2 downto 0);
              IN_E_MemWrite: in std_logic;
              
              IN_E_RegWrite1: in std_logic;
              IN_E_RegWrite2: in std_logic;
              IN_E_IN_Port: in std_logic_vector (31 downto 0);
              IN_E_Outp: in std_logic;
              IN_E_Outdata1: in std_logic_vector (31 downto 0);
              IN_E_SR1data: in std_logic_vector (31 downto 0);
              IN_E_SR2data: in std_logic_vector (31 downto 0);
              IN_E_Rsrc1: in std_logic_vector(2 downto 0); -- swap
              IN_E_ImmVal: in std_logic_vector (31 downto 0);
              IN_E_SP: in std_logic_vector(31 downto 0);
	            IN_E_OutMemAddress: in std_logic_vector(31 downto 0);
              
              IN_E_Pc: in std_logic_vector(31 downto 0);
              IN_E_PcPlusTwo: in std_logic_vector(31 downto 0);
              IN_E_MemData:  in std_logic_vector(1 downto 0); 
              IN_E_MemPc: in std_logic;
              
              OUTt_E_Rdst : out std_logic_vector (2 downto 0);
              OUT_ALU_Result : out std_logic_vector (31 downto 0);
              OUT_E_Zeroflag: out std_logic; 
              OUT_E_Negativeflag: out std_logic;
              OUT_E_Carryflag: out std_logic;
              OUT_E_Extended_EA: Out std_logic_vector(31 downto 0);
              OUT_E_MemAddress: Out std_logic_vector(1 downto 0);
              OUT_E_MemToReg: OUT std_logic_vector(2 downto 0);
              Out_E_MemWrite: OUT std_logic;
              
              OUT_E_RegWrite1: out std_logic;
              OUT_E_RegWrite2: out std_logic;
              OUT_E_IN_Port: out std_logic_vector (31 downto 0);
              out_E_Outp: out std_logic;
              Out_E_Outdata1: out std_logic_vector (31 downto 0);
              OUT_E_SR1data: out std_logic_vector (31 downto 0);
              OUT_E_SR2data: out std_logic_vector (31 downto 0);
              OUT_E_Rsrc1: out std_logic_vector(2 downto 0);
              OUT_E_ImmVal: out std_logic_vector (31 downto 0);
              Out_E_SP: out std_logic_vector(31 downto 0);
	            Out_E_OutMemAddress: out std_logic_vector(31 downto 0);
	            Out_E_Pc: out std_logic_vector(31 downto 0);
              Out_E_PcPlusTwo: out std_logic_vector(31 downto 0);
              Out_E_MemData:  out std_logic_vector(1 downto 0);
              Out_E_MemPc: out std_logic
                  );    
END component;

component MemoryStage IS
     PORT( Mclk,Mrst : IN std_logic;
       
       M_IN_Sp: In std_logic_vector(31 downto 0);
       M_IN_EA: In std_logic_vector(31 downto 0);
       M_MemAddress: In std_logic_vector(1 downto 0);
       
       M_Writeen: in std_logic;
       M_Regdata: in std_logic_vector(31 downto 0);
       M_Pcdata: in std_logic_vector(31 downto 0);
       M_PcPlusTwodata: in std_logic_vector(31 downto 0);
       M_MemData: in std_logic_vector(1 downto 0);
       
       M_Readen: in std_logic;
       M_memory_output: Out std_logic_Vector(31 downto 0);
       
       M_PCIntr: in std_logic_Vector(31 downto 0);
       M_intr: in std_logic;
       M_IntrSp: in std_logic_vector(31 downto 0)
           );
END component;

component Mem_WBbuff IS
        PORT(Wclk,Wrst: in std_logic;
              
              -- To the WB muux
              In_MemOutput: in std_logic_vector(31 downto 0);
              In_MemToReg: in std_logic_vector(2 downto 0);
              IN_WB_AluOutput: in std_logic_vector(31 downto 0);
              
              -- To Register file
              In_WB_Rdst1  : in std_logic_vector(2 downto 0);
              --In_WB_Rdst2  : in std_logic_vector(2 downto 0); -- in case of swap
              In_RegWrite1	:in std_logic;
	            In_RegWrite2	:in std_logic;
	            --IN_WB_WriteData2: in std_logic_vector(31 downto 0); Swap
              In_IN_Port: in std_logic_vector (31 downto 0);
              InM_Outp: in std_logic;
              INM_Outdata1 : in std_logic_vector (31 downto 0);
              
              INM_SR1data: in std_logic_vector (31 downto 0);
              INM_SR2data: in std_logic_vector (31 downto 0);
              INM_Rsrc1: in std_logic_vector(2 downto 0);
              INM_ImmVal: in std_logic_vector (31 downto 0);
              INM_SP: in std_logic_vector (31 downto 0);
          -- Outputs
              -- To the WB muux
              Out_MemOutput: Out std_logic_vector(31 downto 0);
              OUT_MemToReg: Out std_logic_vector(2 downto 0);
              OUT_WB_AluOutput: Out std_logic_vector(31 downto 0);
              
              -- To Register file
              OUT_WB_Rdst1  : Out std_logic_vector(2 downto 0);
             -- OUT_WB_Rdst2  : Out std_logic_vector(2 downto 0); --in case of swap
              OUT_RegWrite1	:Out std_logic;
	            OUT_RegWrite2	:Out std_logic;
	            --OUT_WB_WriteData2: Out std_logic_vector(31 downto 0); Swap
	            Out_IN_Port: out std_logic_vector (31 downto 0);
	            OutM_Outp: out std_logic;
	            OutM_Outdata1 : Out std_logic_vector (31 downto 0);
	            OutM_SR1data: out std_logic_vector (31 downto 0);
              OutM_SR2data: out std_logic_vector (31 downto 0);
              OutM_Rsrc1: out std_logic_vector(2 downto 0);
              OutM_ImmVal: out std_logic_vector (31 downto 0);
              OutM_SP: out std_logic_vector (31 downto 0)
      
      
              );    
END component;


component WriteBack IS
     PORT( 
             RegVal,MemoryVal,Input_port, In_Woutdata1: In std_logic_vector(31 downto 0);
            IN_SwapR1: In std_logic_vector(31 downto 0); 
            IN_Imm: In std_logic_vector(31 downto 0);      
            Slct: In std_logic_vector(2 downto 0);
            Se: In std_logic;
            OutVal: Out std_logic_vector(31 downto 0);
            OutportVal: Out std_logic_vector(31 downto 0)
           );
END component;



-- Signals fetch
Signal PPc: std_logic_vector(31 downto 0);
Signal OutInstruction: std_logic_vector(31 downto 0);

Signal mPc: std_logic_vector(31 downto 0);
Signal mOutInstruction: std_logic_vector(31 downto 0);
Signal mIN_Port: std_logic_vector(31 downto 0);
Signal FPcPlusTwo: std_logic_vector(31 downto 0);

-- 
signal FD_Buff_PcplusTwo:std_logic_vector(31 downto 0);
Signal Fd_Interrupt: std_logic;
-- Signals Decode
Signal       mRdst:  std_logic_vector (2 downto 0);
Signal       mRsrc1: std_logic_vector (2 downto 0);
Signal       mRsrc2: std_logic_vector (2 downto 0);
      
Signal mExtendedImm: std_logic_vector(31 downto 0);
Signal mExtendedEA: std_logic_vector(31 downto 0);
Signal mD_OutData1: std_logic_vector(31 downto 0);
Signal mD_OutData2:  std_logic_vector(31 downto 0);
       
       -- Control unit outputs
Signal       mD_ALUop		: std_logic_vector(3 downto 0);
Signal       mD_ALUsrc		: std_logic;
--D_SpValue	: std_logic_vector(2 downto 0);
--D_Save		:std_logic;
Signal      mD_Restore	: std_logic;
Signal	     mD_R1Data		: std_logic_vector(1 downto 0);
Signal	     mD_RegDst		: std_logic;
Signal      mD_MemData	: std_logic_vector(1 downto 0);
Signal	 mD_MemAddress	: std_logic_vector(1 downto 0);
Signal	 mD_MemToReg	: std_logic_vector(2 downto 0);
Signal	     mD_RegWrite1	: std_logic;
Signal	     mD_RegWrite2	: std_logic;
Signal   mD_MemWrite	: std_logic;
Signal	    mD_SetC		: std_logic;
Signal	    mD_ClrC		: std_logic;
Signal	    mD_JZ			: std_logic;
Signal	    mD_JN			: std_logic;
Signal	    mD_JC			: std_logic;
Signal	    mD_JMP		: std_logic;
Signal	    mD_Outp		: std_logic;
Signal     mDen_CCR:  std_logic;
Signal     mD_SP: std_logic_vector(31 downto 0);
Signal	    mD_OutMemAddress:  std_logic_vector(31 downto 0);
Signal	    mD_IntrAddress:  std_logic_vector(31 downto 0);
Signal     mD_MemPc: std_logic;	 
Signal     mD_CF_en: std_logic;   
 -- Signals DE/Ex Buff
Signal mmExtendedImm: std_logic_vector(31 downto 0);
Signal mmExtendedEA : std_logic_vector(31 downto 0);

Signal       mmRdst:  std_logic_vector (2 downto 0);
Signal       mmRsrc1: std_logic_vector (2 downto 0);
Signal       mmRsrc2: std_logic_vector (2 downto 0);

Signal mmD_OutData1: std_logic_vector(31 downto 0);
Signal mmD_OutData2:  std_logic_vector(31 downto 0);
       
    
Signal       mmD_ALUop		: std_logic_vector(3 downto 0);
Signal       mmD_ALUsrc		: std_logic;
--D_SpValue	:out std_logic_vector(2 downto 0);
--D_Save		:out std_logic;
Signal    	 mmD_Restore	: std_logic;
Signal	     mmD_R1Data		: std_logic_vector(1 downto 0);
Signal	     mmD_RegDst		: std_logic;
Signal      mmD_MemData	: std_logic_vector(1 downto 0);
Signal	 mmD_MemAddress	: std_logic_vector(1 downto 0);
Signal	 mmD_MemToReg	: std_logic_vector(2 downto 0);
Signal	     mmD_RegWrite1	: std_logic;
Signal	     mmD_RegWrite2	: std_logic;
Signal     mmD_MemWrite	: std_logic;
Signal	    mmD_SetC		: std_logic;
Signal	    mmD_ClrC		: std_logic;
Signal	    mmD_JZ			: std_logic;
Signal	    mmD_JN			: std_logic;
Signal	    mmD_JC			: std_logic;
Signal	    mmD_JMP		: std_logic;
Signal     mmIN_Port : std_logic_vector(31 downto 0);
Signal     mm_Outp: std_logic;
Signal     mmDen_CCR: std_logic;
Signal     mmD_SR1data: std_logic_vector(31 downto 0);
Signal     mmD_SR2data: std_logic_vector(31 downto 0);
Signal     mmD_SP: std_logic_vector(31 downto 0);
Signal	    mmD_OutMemAddress:  std_logic_vector(31 downto 0);
Signal     mmPc: std_logic_vector(31 downto 0);
Signal     mmFD_Buff_PcplusTwo: std_logic_vector(31 downto 0);
Signal     mmDEInterrupt: std_logic;
Signal     mmD_MemPc: std_logic;
Signal     mmD_CF_en: std_logic;
-- Execute outputs
Signal       mEOUT_E_Rdst :  std_logic_vector (2 downto 0);
Signal       mEALU_Result :  std_logic_vector (31 downto 0);
Signal       mEE_Zeroflag:  std_logic; 
Signal       mEE_Negativeflag:  std_logic;
Signal       mEE_Carryflag:  std_logic;
Signal       mE_Extended_EA: std_logic_vector (31 downto 0);
Signal       mE_SR1: std_logic_vector (31 downto 0); 
Signal       mE_SR2: std_logic_vector (31 downto 0);
Signal       mE_JmpDecision: std_logic_vector(1 downto 0);
-- EX/Mem buffer output signals
Signal       BuffEOUT_E_Rdst :  std_logic_vector (2 downto 0);
Signal       BuffEALU_Result :  std_logic_vector (31 downto 0);
Signal       BuffEE_Zeroflag:  std_logic; 
Signal       BuffEE_Negativeflag:  std_logic;
Signal       BuffEE_Carryflag:  std_logic;
Signal       BuffEE_Extended_EA:  std_logic_vector (31 downto 0);
Signal       BuffE_MemAddress: std_logic_vector(1 downto 0);
Signal       BuffE_MemToReg: std_logic_vector(2 downto 0);
Signal       BuffE_MemWrite: std_logic;
Signal       BuffE_RegWrite1: std_logic;
Signal       BuffE_RegWrite2: std_logic;
Signal       BuffE_IN_Port : std_logic_vector(31 downto 0);
Signal       BuffE_Outp: std_logic;
Signal       BuffE_OutData1: std_logic_vector(31 downto 0);
Signal       BuffE_SR1data: std_logic_vector(31 downto 0);
Signal       BuffE_SR2data: std_logic_vector(31 downto 0);
Signal       BuffE_Rsrc1: std_logic_vector(2 downto 0);
Signal       BuffE_ExtendedImm: std_logic_vector(31 downto 0);
Signal       BuffE_Sp: std_logic_vector(31 downto 0);
Signal       BuffE_MemoryAddress: std_logic_vector(31 downto 0);
Signal       BuffE_Pc : std_logic_vector(31 downto 0);
Signal       BuffE_PcplusTwo : std_logic_vector(31 downto 0);
Signal       BuffE_MemData:  std_logic_vector(1 downto 0);
Signal       BuffE_MemPc: std_logic;
-- Memory outputs 
Signal M_MemoryOutput: std_logic_vector(31 downto 0);

-- Mem/Wb buffer outputs
 Signal             MW_MemOutput:  std_logic_vector(31 downto 0);
 Signal             MW_MemToReg:  std_logic_vector(2 downto 0);
 Signal             MW_WB_AluOutput:  std_logic_vector(31 downto 0);
 Signal             MW_IN_Port:  std_logic_vector(31 downto 0);  
 Signal             MW_Outp: std_logic;   
 Signal             MW_OutData1: std_logic_vector(31 downto 0); 
 Signal             MW_ExtendedImm: std_logic_vector(31 downto 0);
 Signal             MW_Sp: std_logic_vector(31 downto 0);       
              -- To Register file
  Signal            MW_WB_Rdst1  :  std_logic_vector(2 downto 0);
  --Signal            -- MW_WB_Rdst2  :  std_logic_vector(2 downto 0); in case of swap
  Signal            MW_RegWrite1	: std_logic;
	Signal            MW_RegWrite2	: std_logic;
	--Signal            --MW_WB_WriteData2:  std_logic_vector(31 downto 0); Swap
	--Write Back output
Signal WB_Output: std_logic_vector( 31 downto 0);
Signal            MW_SR1data : std_logic_vector (31 downto 0);
Signal            MW_SR2data : std_logic_vector (31 downto 0);
Signal            MW_Rsrc1: std_logic_vector (2 downto 0);

	            
BEGIN
F: Fetch Port Map (clk,rst,Interrupt, mE_JmpDecision , mmD_SR1data, M_MemoryOutput ,PPc,OutInstruction, FPcPlusTwo, Fd_Interrupt);
FD_Buff: FE_DEbuff Port Map (clk,rst,'1',pPc,OutInstruction, IN_Port, FPcPlusTwo ,Interrupt,mPc,mOutInstruction,mIN_Port,FD_Buff_PcplusTwo, Fd_Interrupt );

D: Decode Port Map (clk, rst, mOutInstruction,
                    MW_WB_Rdst1, MW_Rsrc1, WB_Output, MW_SR2data, MW_RegWrite1,MW_RegWrite2,  Interrupt,
                    mRdst, mRsrc1, mRsrc2 ,mExtendedImm ,mExtendedEA ,mD_OutData1, mD_OutData2 ,
                    mD_ALUop, mD_ALUsrc	, mD_Restore,mD_R1Data, mD_RegDst, mD_MemData ,mD_MemAddress, mD_MemToReg ,mD_RegWrite1, mD_RegWrite2,mD_MemWrite, 
                    mD_SetC, mD_ClrC, mD_JZ, mD_JN, mD_JC, mD_JMP, mD_Outp,mDen_CCR, mD_SP, mD_OutMemAddress,mD_IntrAddress,
                    IR0,IR1,IR2,IR3,IR4,IR5,IR6,IR7, mD_MemPc, mD_CF_en);

DE_Buff: DE_EXbuff Port Map (clk,rst,'1',mRdst, mRsrc1, mRsrc2 ,mExtendedImm ,mExtendedEA ,mD_OutData1, mD_OutData2 , mD_ALUop, 
                            mD_ALUsrc	,mD_Restore ,mD_R1Data, mD_RegDst, mD_MemData ,mD_MemAddress,mD_MemToReg ,mD_RegWrite1, mD_RegWrite2,mD_MemWrite ,mD_SetC,
                            mD_ClrC, mD_JZ, mD_JN, mD_JC, mD_JMP, mIN_Port, mD_Outp,mDen_CCR,mD_OutData1, mD_OutData2, mD_SP, mD_OutMemAddress,mPc,FD_Buff_PcplusTwo,Fd_Interrupt,mD_MemPc,mD_CF_en, 
                            mmExtendedImm ,mmExtendedEA ,mmRdst, mmRsrc1, mmRsrc2, mmD_OutData1, mmD_OutData2 , mmD_ALUop, 
                            mmD_ALUsrc	,mmD_Restore ,mmD_R1Data, mmD_RegDst,mmD_MemData ,mmD_MemAddress ,mmD_MemToReg,mmD_RegWrite1, mmD_RegWrite2,mmD_MemWrite,
                            mmD_SetC, mmD_ClrC, mmD_JZ, mmD_JN, mmD_JC, mmD_JMP, mmIN_Port,mm_Outp,mmDen_CCR, mmD_SR1data, mmD_SR2data,
                            mmD_SP, mmD_OutMemAddress, mmPc,mmFD_Buff_PcplusTwo, mmDEInterrupt, mmD_MemPc, mmD_CF_en);

E: Execute port map(clk,rst, mmExtendedImm,mmExtendedEA, mmRdst, mmRsrc1, mmRsrc2, mmD_OutData1, mmD_OutData2,
                    mmD_ALUop, mmD_ALUsrc,mmD_Restore	, mmD_R1Data, mmD_RegDst, mmD_MemToReg,mmD_RegWrite1, mmD_RegWrite2,
                    mmD_SetC, mmD_ClrC, mmD_JZ, mmD_JN, mmD_JC, mmD_JMP,mmDen_CCR, Fd_Interrupt,  BuffE_MemPc,
                    mEOUT_E_Rdst,mEALU_Result,mEE_Zeroflag,mEE_Negativeflag,mEE_Carryflag,mE_Extended_EA,mE_SR1, mE_SR2, mE_JmpDecision, mmD_CF_en);

EM_Buff: EX_MemBuff port map (clk,rst,mEOUT_E_Rdst,mEALU_Result,mEE_Zeroflag,mEE_Negativeflag,mEE_Carryflag,mE_Extended_EA,mmD_MemAddress,
                               mmD_MemToReg,mmD_MemWrite, mmD_RegWrite1, mmD_RegWrite2, mmIN_Port,mm_Outp, mmD_OutData1, mE_SR1, mE_SR2,mmRsrc1, mmExtendedImm,
                                mmD_SP, mmD_OutMemAddress, mmPc,mmFD_Buff_PcplusTwo,mmD_MemData,  mmD_MemPc,
                              buffEOUT_E_Rdst ,buffEALU_Result,buffEE_Zeroflag,buffEE_Negativeflag,buffEE_Carryflag,BuffEE_Extended_EA,
                              BuffE_MemAddress,
                              BuffE_MemToReg , BuffE_MemWrite, BuffE_RegWrite1, BuffE_RegWrite2,BuffE_IN_Port,BuffE_Outp, BuffE_OutData1,
                              BuffE_SR1data, BuffE_SR2data, BuffE_Rsrc1, BuffE_ExtendedImm,BuffE_SP,BuffE_MemoryAddress, BuffE_Pc,BuffE_PcplusTwo,  BuffE_MemData, BuffE_MemPc);

MS: MemoryStage port map (clk,rst, BuffE_MemoryAddress, BuffEE_Extended_EA, BuffE_MemAddress, BuffE_MemWrite, BuffE_SR1data ,BuffE_Pc, BuffE_PcplusTwo,  BuffE_MemData ,'1', M_MemoryOutput, FD_Buff_PcplusTwo, Interrupt, mD_IntrAddress);
                              
MW_Buff: Mem_WBbuff port map (clk,rst, M_MemoryOutput , BuffE_MemToReg ,buffEALU_Result , buffEOUT_E_Rdst , BuffE_RegWrite1,
                              BuffE_RegWrite2, BuffE_IN_Port, BuffE_Outp, BuffE_OutData1, BuffE_SR1data, BuffE_SR2data, BuffE_Rsrc1,BuffE_ExtendedImm,BuffE_SP,
                               
                               MW_MemOutput ,MW_MemToReg ,MW_WB_AluOutput,  MW_WB_Rdst1, MW_RegWrite1,MW_RegWrite2,MW_IN_Port, MW_Outp, MW_OutData1,
                               MW_SR1data, MW_SR2data, MW_Rsrc1, MW_ExtendedImm, MW_Sp);
U_WriteBack: WriteBack port map (MW_WB_AluOutput, MW_MemOutput, MW_IN_Port , MW_OutData1, MW_SR1data ,MW_ExtendedImm ,MW_MemToReg, MW_Outp , WB_Output, OutPort );                             

 I_PC <= PPC;
 I_ZeroFlag <= mEE_Zeroflag;
 I_NegativeFlag <= mEE_Negativeflag;
 I_CarryFlag <= mEE_Carryflag;
 I_SP <= mmD_SP;
END myintegrated;
