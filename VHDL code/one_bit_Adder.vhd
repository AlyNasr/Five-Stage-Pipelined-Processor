LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY one_bit_Adder IS
        PORT( a,b,cin : IN std_logic;                   
              s,cout : OUT std_logic);
END one_bit_Adder;

ARCHITECTURE my_adder OF one_bit_Adder IS
BEGIN      

 s <= a XOR b XOR cin;             
 cout <= (a AND b) or (cin AND (a XOR b));
END my_adder;



