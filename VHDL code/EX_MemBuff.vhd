LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


ENTITY Ex_MemBuff IS
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
END Ex_MemBuff;

ARCHITECTURE myEx_MemBuff OF Ex_MemBuff IS
BEGIN      

PROCESS(EMclk,EMrst)
BEGIN
IF(EMrst = '1') THEN
    OUTt_E_Rdst <= (OTHERS=>'0');
    OUT_ALU_Result <= (OTHERS=>'0');
    OUT_E_Zeroflag <= '0'; 
    OUT_E_Negativeflag <= '0';
    OUT_E_Carryflag <= '0';
    OUT_E_Extended_EA <= (OTHERS=>'0');
    OUT_E_MemAddress <= "00";
    OUT_E_MemToReg <= "000";
    Out_E_MemWrite <= '0';
    OUT_E_RegWrite1 <= '0';
    OUT_E_RegWrite2 <= '0';
    OUT_E_IN_Port <= (OTHERS=>'0');
    out_E_Outp <= '0';
    Out_E_Outdata1 <= (OTHERS=>'0');
    OUT_E_SR1data <= (OTHERS=>'0');
    OUT_E_SR2data <= (OTHERS=>'0');
    OUT_E_Rsrc1 <= (OTHERS=>'0');
    OUT_E_ImmVal <= (OTHERS=>'0');
    Out_E_Sp <= "00000000000000000000011111111110";
    Out_E_OutMemAddress <= (OTHERS=>'0'); 
    Out_E_Pc <= (OTHERS=>'0');
    Out_E_PcPlusTwo <=(OTHERS=>'0');
    Out_E_MemData <= (OTHERS=>'0');
     Out_E_MemPc <= '0';                
  ELSIF rising_edge(EMclk)  THEN     
 	  OUTt_E_Rdst <= IN_E_Rdst ;
    OUT_ALU_Result <= IN_ALU_Result;
    OUT_E_Zeroflag <= IN_E_Zeroflag; 
    OUT_E_Negativeflag <= IN_E_Negativeflag;
    OUT_E_Carryflag <= IN_E_Carryflag;
    OUT_E_Extended_EA <= IN_E_Extended_EA ;
    OUT_E_MemAddress <= IN_E_MemAddress;
    OUT_E_MemToReg <= IN_E_MemToReg;
    Out_E_MemWrite <= IN_E_MemWrite;
    OUT_E_RegWrite1 <= IN_E_RegWrite1;
    OUT_E_RegWrite2 <= IN_E_RegWrite2 ;   
    OUT_E_IN_Port <= IN_E_IN_Port;
    out_E_Outp <= In_E_Outp;
    Out_E_Outdata1 <= IN_E_Outdata1;
    OUT_E_SR1data <= IN_E_SR1data ;
    OUT_E_SR2data <= IN_E_SR2data;
    OUT_E_Rsrc1 <= IN_E_Rsrc1;
    OUT_E_ImmVal <= IN_E_ImmVal;
    Out_E_Sp <= IN_E_Sp;
    Out_E_OutMemAddress <= IN_E_OutMemAddress;  
    Out_E_Pc <= IN_E_Pc ;
    Out_E_PcPlusTwo <= IN_E_PcPlusTwo;
    Out_E_MemData <= IN_E_MemData;
     Out_E_MemPc <=  IN_E_MemPc ;       
    
END IF;
END PROCESS;

END myEx_MemBuff;





