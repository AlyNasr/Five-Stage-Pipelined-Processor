-- operation        Control unit signal
-- NOT                     1010
-- INC                     0001
-- DEC                     0010
-- ADD, IADD               0011
-- SUB                     0101
-- AND                     0110
-- OR                      0111
-- SHL                     1000
-- SHR                     1001
-- SetC                    1100
-- CLRC                    1011 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity ALU IS
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
End ALU;

Architecture MyALU of ALU  IS
  
  Component Logic IS
  Port ( 
A: IN std_logic_vector (31  downto 0);
  B: IN std_logic_vector (31 downto 0);
  control_signal: IN std_logic_vector(3 downto 0);
  
  F: OUT std_logic_vector (31 downto 0);
  flag: OUT std_logic_vector (1 downto 0)  
);
End component;

Component Arithmetic IS
  
	PORT ( A,B:  IN std_logic_vector(31 DOWNTO 0);
         
         control_signal: IN std_logic_vector(3 downto 0);
         F:  OUT  std_logic_vector(31 DOWNTO 0);
         
         flag: OUT std_logic_vector (2 downto 0) );

END  component;

component Shift IS
  PORT ( A,B:  IN std_logic_vector(31 DOWNTO 0);
         
         control_signal: IN std_logic_vector(3 downto 0);
         F:  OUT  std_logic_vector(31 DOWNTO 0);
        
         flag: OUT std_logic_vector (2 downto 0));
END  component;

  Signal out_logic, out_Arithmetic, out_shift: std_logic_vector(31 downto 0);
  Signal flags_Logic: std_logic_vector(1 downto 0);
  Signal flags_Arithmetic, flags_shift: std_logic_vector(2 downto 0);
  Signal Flags: std_logic_vector (2 downto 0);
Begin
U1: Logic        PORT MAP(IN1,IN2,Control_Unit_Signal,out_Logic,flags_logic);  
U2: Arithmetic   PORT MAP(IN1,IN2,Control_Unit_Signal,out_Arithmetic,flags_Arithmetic);
U3: Shift        PORT MAP(IN1,IN2,Control_Unit_Signal,out_shift,flags_shift);
  
  Result <=  out_Logic      WHEN Control_Unit_Signal = "1010" OR control_unit_signal = "0110" OR control_unit_signal = "0111"
        ELSE out_Arithmetic WHEN Control_Unit_Signal = "0001" OR control_unit_signal = "0010" OR control_unit_signal = "0011" OR control_unit_signal = "0101"
        ELSE out_Shift      WHEN Control_Unit_Signal = "1000" OR control_unit_signal = "1001";
  

  Flags(0) <= flags_Logic(0) WHEN Control_Unit_Signal = "1010" OR control_unit_signal = "0110" OR control_unit_signal = "0111"
           ELSE flags_Arithmetic(0) WHEN Control_Unit_Signal = "0001" OR control_unit_signal = "0010" OR control_unit_signal = "0011" OR control_unit_signal = "0101"
           ELSE flags_shift(0) WHEN Control_Unit_Signal = "1000" OR control_unit_signal = "1001"
           ELSE '0' WHEN A_JD = "01" AND  A_JZ = '1'
           ELSE '0' ;   
            
  Flags(1) <= flags_Logic(1) WHEN Control_Unit_Signal = "1010" OR control_unit_signal = "0110" OR control_unit_signal = "0111"
           ELSE flags_Arithmetic(1) WHEN Control_Unit_Signal = "0001" OR control_unit_signal = "0010" OR control_unit_signal = "0011" OR control_unit_signal = "0101"
           ELSE flags_shift(1) WHEN Control_Unit_Signal = "1000" OR control_unit_signal = "1001"
           ELSE '0' WHEN A_JD = "01" AND  A_JN = '1'
         ELSE '0';  
  Flags(2) <= flags_Arithmetic(2) WHEN Control_Unit_Signal = "0001" OR control_unit_signal = "0010" OR control_unit_signal = "0011" OR control_unit_signal = "0101"
           ELSE flags_shift(2) WHEN Control_Unit_Signal = "1000" OR control_unit_signal = "1001"
           ELSE '1' WHEN Control_Unit_Signal = "1100"
           ELSE '0' WHEN Control_Unit_Signal = "1011";
        
  ZeroFlag <= Flags(0);
  NegativeFlag <= Flags(1);
  CarryFlag <= Flags(2);
 End MyALU;
 






