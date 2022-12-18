LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


ENTITY DE_EXbuff IS
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
END DE_EXbuff;

ARCHITECTURE myDEbuff OF DE_EXbuff IS
BEGIN

PROCESS(DEclk,DErst)
BEGIN
IF(DErst = '1') THEN
       OUT_D_Extended_ImmVal <= (OTHERS=>'0');
       OUT_D_Extended_EA <= (OTHERS=>'0');
       
       OUT_D_Rdst  <= (OTHERS=>'0');
       OUT_D_Rsrc1 <= (OTHERS=>'0');
       OUT_D_Rsrc2 <= (OTHERS=>'0');
       
       --Reg File Outputs
       OUT_D_OutData1 <= (OTHERS=>'0');
       OUT_D_OutData2<= (OTHERS=>'0');
       
       -- Control unit outputs
       OUT_D_ALUop		<= (OTHERS=>'0');
       OUT_D_ALUsrc		<= '0';
--OUT_D_SpValue	<= (OTHERS=>'0');
--OUT_D_Save		<= (OTHERS=>'0');
	 OUT_D_Restore	<= '0';
	     OUT_D_R1Data		<= (OTHERS=>'0');
	     OUT_D_RegDst		<= '0';
	 OUT_D_MemData	<= (OTHERS=>'0');
	 OUT_D_MemAddress	<= "00";
	 OUT_D_MemToReg	<= "000";
	     OUT_D_RegWrite1	<= '0';
	     OUT_D_RegWrite2	<= '0';
	 OUT_D_MemWrite	<= '0';
	    OUT_D_SetC		<= '0';
	    OUT_D_ClrC		<= '0';
	    OUT_D_JZ			<= '0';
	    OUT_D_JN			<= '0';
	    OUT_D_JC			<= '0';
	    OUT_D_JMP		<= '0';
      ODEIN_Port <= (OTHERS=>'0');
      OUT_Outp <= '0';
      Outen_CCR <= '0';
      OUT_SR1data <= (OTHERS=>'0');
      OUT_SR2data <= (OTHERS=>'0');
      Out_Dsp <= "00000000000000000000011111111110";
      Out_MemAddress <= (OTHERS=>'0'); 
      Out_Pc <= (OTHERS=>'0');
      Out_PcPlusTwo <= (OTHERS=>'0');
      Out_Interr <= '0';
      Out_MemPc <= '0';
      Out_CF_en <= '0';
ELSIF rising_edge(DEclk)  THEN     
 	    if (DEwe = '1') THEN
      OUT_D_Extended_ImmVal <= IN_D_Extended_ImmVal;
      OUT_D_Extended_EA <= IN_D_Extended_EA;
       
       OUT_D_Rdst  <= IN_D_Rdst;
       OUT_D_Rsrc1 <= IN_D_Rsrc1;
       OUT_D_Rsrc2 <= IN_D_Rsrc2;
      
       --Reg File Outputs
       OUT_D_OutData1 <= IN_D_OutData1;
       OUT_D_OutData2 <= IN_D_OutData2;
       
       -- Control unit outputs
       OUT_D_ALUop		<= IN_D_ALUop;
       OUT_D_ALUsrc		<= IN_D_ALUsrc;
--OUT_D_SpValue	<= IN_D_SpValue;
--OUT_D_Save		<= IN_D_Save;
	 OUT_D_Restore	<= IN_D_Restore;
	     OUT_D_R1Data		<= IN_D_R1Data;
	     OUT_D_RegDst		<= IN_D_RegDst;
	 OUT_D_MemData	<= IN_D_MemData;
	 OUT_D_MemAddress	<= IN_D_MemAddress;
	 OUT_D_MemToReg	<= IN_D_MemToReg;
	     OUT_D_RegWrite1	<= IN_D_RegWrite1;
	     OUT_D_RegWrite2	<= IN_D_RegWrite2;
	 OUT_D_MemWrite	<= IN_D_MemWrite;
	    OUT_D_SetC		<= IN_D_SetC;
	    OUT_D_ClrC		<= IN_D_ClrC;
	    OUT_D_JZ			<= IN_D_JZ	;
	    OUT_D_JN			<= IN_D_JN;
	    OUT_D_JC			<= IN_D_JC;
	    OUT_D_JMP		<= IN_D_JMP;
 	    ODEIN_Port <= DEIN_Port; 
 	    OUT_Outp <= IN_Outp ; 
 	    Outen_CCR <= INen_CCR;
 	    OUT_SR1data <= IN_SR1data;
 	    OUT_SR2data <= IN_SR2data;
 	     Out_Dsp <= IN_Dsp ;
      Out_MemAddress <= IN_MemAddress; 
      Out_Pc <= IN_Pc;
      Out_PcPlusTwo <= IN_PcPlusTwo ;
      Out_Interr <= IN_Interr;
      Out_MemPc <= In_MemPc;
      Out_CF_en <= In_CF_en;
 	      	    End if;
END IF;
END PROCESS;


END myDEbuff;



