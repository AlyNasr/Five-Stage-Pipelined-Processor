LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


ENTITY Fetch IS
     PORT( Fclk,Frst, FInterrupt : IN std_logic;
           F_JmpDec: IN std_logic_vector(1 downto 0);
           F_RegData,F_MemSpData: In std_logic_vector(31 downto 0);
           
           Out_PC: Out std_logic_vector (31 downto 0);     
           out_Instruction : OUT std_logic_vector (31 downto 0);
           Out_PcPlusTwo: OUT std_logic_vector (31 downto 0);
           IntrOnCall: std_logic );
END Fetch;


ARCHITECTURE myfetch OF Fetch IS
signal PcSig: std_logic_vector (31 downto 0);

component PC_Reg IS
     PORT(  clk,rst, Interrupt: IN std_logic;
           --d: IN std_logic_vector (31 downto 0);   
           PCResetAddress: IN std_logic_vector(31 DOWNTO 0);
	         PCInterruptAddress: IN std_logic_vector(31 DOWNTO 0);
	         Jsel: In std_logic_vector(1 downto 0);
	         Pc_Reg: IN std_logic_vector(31 DOWNTO 0);
	         Pc_Mem: IN std_logic_vector(31 DOWNTO 0);
	         
           PC_out : OUT std_logic_vector (31 downto 0);
           PC_PlusTwo: OUT std_logic_vector (31 downto 0);
           pIntrOnCall: std_logic);
END component;

component InstructionMemory IS
 PORT (
      PC_in : IN std_logic_vector(31 DOWNTO 0);
       
	     InstructionOut: OUT std_logic_vector(31 DOWNTO 0);
	     
	     ResetAddress: OUT std_logic_vector(31 DOWNTO 0);
	     InterruptAddress: OUT std_logic_vector(31 DOWNTO 0));
END component;

component Fmux IS
     PORT( 
            RegData,MemSpData: In std_logic_vector(31 downto 0);       
            JmpDec: In std_logic_vector(1 downto 0);
            
            UpdatedPc: Out std_logic_vector(31 downto 0)
          );
END component;

Signal SigRstAddress: std_logic_vector(31 DOWNTO 0);
Signal SigIntAddress: std_logic_vector(31 DOWNTO 0);
Signal MuxPc: std_logic_vector(31 DOWNTO 0);

BEGIN
  
PC1: PC_Reg PORT MAP (Fclk,Frst,FInterrupt, SigRstAddress, SigIntAddress ,F_JmpDec, MuxPc ,F_MemSpData,PcSig, Out_PcPlusTwo, IntrOnCall);
IM : InstructionMemory Port map (PcSig,out_instruction, SigRstAddress, SigIntAddress ); 
Fm: Fmux port map (F_RegData, F_MemSpData, F_JmpDec, MuxPc ); 
Out_Pc <= PcSig; 
END myfetch;

