LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY DataMemory IS
 PORT ( 
 Dmclk: in std_logic;
 
 Writeen: in std_logic;
 Write_Address: in std_logic_vector(31 downto 0);
 Write_data: in std_logic_vector(31 downto 0);
 
 Read_Address: in std_logic_Vector(31 downto 0);
 Readen: in std_logic;
 Read_data: Out std_logic_Vector(31 downto 0) ;
 
 DM_MemAddress: In std_logic_vector(1 downto 0)
  );
END ENTITY DataMemory;

ARCHITECTURE myMemory OF DataMemory IS  
  TYPE DataMem IS ARRAY(0 TO 2048) of std_logic_vector(15 DOWNTO 0);
  signal Data: DataMem;
  
  Begin
process(Dmclk)
begin
if(falling_edge(Dmclk)) then
   if (writeen='1') then
     if (DM_MemAddress = "01") then
        Data(to_integer(unsigned(Write_Address(31 downto 16)))) <= Write_data(31 downto 16);
        Data(to_integer(unsigned(Write_Address(15 downto 0)))) <= Write_data(15 downto 0);
    else 
        Data(to_integer(unsigned(Write_Address(15 downto 0)))) <= Write_data(31 downto 16);
        Data(to_integer(unsigned(Write_Address(15 downto 0)))+1) <= Write_data(15 downto 0);
    end if;
  end if;
end if;
end process;
 Read_data <= (Data(to_integer(unsigned(Read_Address(31 downto 16)))) & Data(to_integer(unsigned(Read_Address(15 downto 0)))))
               WHEN to_integer(unsigned(Read_Address(31 downto 16))) >= 0 AND to_integer(unsigned(Read_Address(31 downto 16))) <= 4095
                    AND to_integer(unsigned(Read_Address(15 downto 0))) >= 0 AND to_integer(unsigned(Read_Address(15 downto 0))) <= 4095
                    AND DM_MemAddress = "01"    
          ELSE Data(to_integer(unsigned(Write_Address(15 downto 0)))) & Data(to_integer(unsigned(Write_Address(15 downto 0)))+1)
               WHEN to_integer(unsigned(Read_Address(31 downto 16))) >= 0 AND to_integer(unsigned(Read_Address(31 downto 16))) <= 4095
                    AND to_integer(unsigned(Read_Address(15 downto 0))) >= 0 AND to_integer(unsigned(Read_Address(15 downto 0))) <= 4095
                    AND DM_MemAddress = "10"
          ELSE (OTHERS=>'0');      
End myMemory;

