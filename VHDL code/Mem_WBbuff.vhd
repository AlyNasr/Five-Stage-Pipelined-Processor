LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


ENTITY Mem_WBbuff IS
        PORT( Wclk,Wrst: in std_logic;
              
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
END Mem_WBbuff;

ARCHITECTURE myMemBuff OF Mem_WBbuff IS
BEGIN      

PROCESS(Wclk,Wrst)
BEGIN
IF(Wrst = '1') THEN
    
              Out_MemOutput <= (OTHERS=>'0');
              OUT_MemToReg <= "000";
              OUT_WB_AluOutput<= (OTHERS=>'0');
              
              -- To Register file
              OUT_WB_Rdst1 <= (OTHERS=>'0');
              --OUT_WB_Rdst2  <= (OTHERS=>'0');
              OUT_RegWrite1	 <=  '0';
	            OUT_RegWrite2	 <=  '0';
	            --OUT_WB_WriteData2<= (OTHERS=>'0');
	            Out_IN_Port <= (OTHERS=>'0');
	            OutM_Outp <= '0';
	            OutM_Outdata1 <= (OTHERS=>'0');
	            OutM_SR1data <= (OTHERS=>'0');
	            OutM_SR2data <= (OTHERS=>'0');
	            OutM_Rsrc1 <= (OTHERS=>'0');
	            OutM_ImmVal <= (OTHERS=>'0');
	            OutM_SP <= "00000000000000000000011111111110";
  ELSIF rising_edge(Wclk)  THEN     
 	            
 	            Out_MemOutput <= IN_MemOutput;
              OUT_MemToReg <= IN_MemToReg;
              OUT_WB_AluOutput <= IN_WB_AluOutput;
              
              -- To Register file
              OUT_WB_Rdst1 <= IN_WB_Rdst1;
              -- OUT_WB_Rdst2  <= IN_WB_Rdst2 ;
              OUT_RegWrite1	 <= IN_RegWrite1 ;
	            OUT_RegWrite2	 <= IN_RegWrite2 ;
	            --OUT_WB_WriteData2<= IN_WB_WriteData2;
	            Out_IN_Port <=  In_IN_Port;
	            OutM_Outp <= InM_Outp;
	            OutM_Outdata1 <= INM_Outdata1 ; 
	            OutM_SR1data <= INM_SR1data;
	            OutM_SR2data <= INM_SR2data;
	            OutM_Rsrc1 <= INM_Rsrc1;
	            OutM_ImmVal <= INM_ImmVal;
	            OutM_SP <= INM_Sp;
    
END IF;
END PROCESS;

END myMemBuff ;







