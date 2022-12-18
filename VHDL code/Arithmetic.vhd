LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


ENTITY Arithmetic IS
  
	PORT ( A,B:  IN std_logic_vector(31 DOWNTO 0);
         
         control_signal: IN std_logic_vector(3 downto 0);
         F:  OUT  std_logic_vector(31 DOWNTO 0);
         
         flag: OUT std_logic_vector (2 downto 0) );

END  Arithmetic;

ARCHITECTURE my_arithmetic of Arithmetic IS

Component nbit_Adder IS
PORT   (a, b : IN std_logic_vector(31 DOWNTO 0) ;
             cin: IN std_logic;       
             s : OUT std_logic_vector(31 DOWNTO 0);
             cout : OUT std_logic);
END component;
         
SIGNAL x,y : std_logic_vector(31 DOWNTO 0);
Signal c: std_logic;   -- for cout
Signal Ci: std_logic;  -- for cin

BEGIN
u0: nbit_Adder PORT MAP (A,x,Ci,y,c);

x  <=    "00000000000000000000000000000001"  WHEN control_signal = "0001"  -- INC
   ELSE  "11111111111111111111111111111111"  WHEN control_signal = "0010"  -- DEC
   ElSE  B                                   WHEN control_signal = "0011"  -- ADD,IADD
   ELSE  Not B                               WHEN control_signal = "0101"; -- SUB  
   

Ci <= '1' WHEN control_signal = "0101" -- SUB
 ELSE '0';

F <= y;

flag(0) <= '1' WHEN y = ("00000000000000000000000000000000")
         ELSE '0';

flag(1) <= '1' WHEN y(31) ='1'
         ELSE '0';

flag(2) <= c;
END my_arithmetic;
   







