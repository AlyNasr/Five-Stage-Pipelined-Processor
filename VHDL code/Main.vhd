LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


ENTITY main IS
     PORT( 
     Clk: IN std_logic;
     Reset: IN std_Logic;
     Interrupt: IN std_logic;
     
     PC: Out std_logic_vector(31 downto 0);
     SP: Out std_logic_vector(31 downto 0);
     
     R0: Out std_logic_vector(31 downto 0);
     R1: Out std_logic_vector(31 downto 0);
     R2: Out std_logic_vector(31 downto 0);
     R3: Out std_logic_vector(31 downto 0);
     R4: Out std_logic_vector(31 downto 0);
     R5: Out std_logic_vector(31 downto 0);
     R6: Out std_logic_vector(31 downto 0);
     R7: Out std_logic_vector(31 downto 0);
     
     ZeroFlag: out std_logic;
     NegativeFlag: out std_logic;
     CarryFlag: out std_logic;
     
     InPort: IN std_logic_vector(31 downto 0);
     OutPort: Out std_logic_vector(31 downto 0)
     
     
     );
END main;


ARCHITECTURE mymain OF main IS

component Integrated IS
     PORT(     Clk: IN std_logic;
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
END component;
BEGIN
 U: Integrated port map(Clk, Reset, Interrupt,PC, SP, R0,R1,R2,R3,R4,R5,R6,R7,ZeroFlag, NegativeFlag, CArryFlag, Inport, OutPort); 
END mymain;



