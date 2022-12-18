LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


ENTITY MemoryStage IS
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
END MemoryStage;


ARCHITECTURE mymem OF MemoryStage IS
Signal InputDataMemory: std_logic_vector(31 downto 0);
Signal SWriteEn: std_logic; 
component DataMemory IS
 PORT ( 
 Dmclk: in std_logic;
 
 Writeen: in std_logic;
 Write_Address: in std_logic_vector(31 downto 0);
 Write_data: in std_logic_vector(31 downto 0);
 
 Read_Address: in std_logic_Vector(31 downto 0);
 Readen: in std_logic;
 Read_data: Out std_logic_Vector(31 downto 0);
 DM_MemAddress: In std_logic_vector(1 downto 0) 
  );
END component;


component MemMux IS
     PORT( 
            IN_Sp,IN_EA: In std_logic_vector(31 downto 0);       
            In_S: In std_logic_vector(1 downto 0);
            
            Outp: Out std_logic_vector(31 downto 0);
            MeIntr: in std_logic
           );
END component;


component DataMemMux IS
     PORT( 
             IN_Rdata,IN_PcVal, IN_PcValPlusTwo: In std_logic_vector(31 downto 0);       
            In_Sd: In std_logic_vector(1 downto 0);
            
            OutpData: Out std_logic_vector(31 downto 0);
            PC_Intr: In std_logic_vector(31 downto 0);
            DM_Intr: In std_logic
           );
END component;

Signal Address: std_logic_vector(31 downto 0);
Signal WriteAddr: std_logic_vector(31 downto 0);
BEGIN

  U_MemMux: MemMux port map (M_IN_Sp, M_IN_EA, M_MemAddress, Address,M_intr );  
  U_DataMux: DataMemMux port map (M_Regdata, M_Pcdata, M_PcPlusTwodata, M_MemData, InputDataMemory,M_PCIntr, M_intr  );
  U_DM: DataMemory Port map(Mclk, SWriteEn, WriteAddr, InputDataMemory, address ,M_Readen, M_memory_output,M_MemAddress );
  
  SWriteEn <= '1' WHEN M_intr ='1'
        ELSE  M_Writeen;
  
  WriteAddr <= M_IntrSp WHEN M_intr ='1'
          ELSE Address;     
END mymem;


