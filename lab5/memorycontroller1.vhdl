-- Memory controller generated from the DSP toolbox
-- Electronics Systems, http://www.es.isy.liu.se/

library ieee;
use ieee.std_logic_1164.all;

entity memorycontroller1 is
port(
state : in integer range 0 to 47;
adress : out integer range 0 to 6;
enable, readwrite : out std_logic);
end memorycontroller1;

architecture generated of memorycontroller1 is
begin
with state select
adress <= 
0 when 0,
0 when 1,
2 when 2,
1 when 3,
3 when 4,
1 when 6,
2 when 7,
4 when 8,
3 when 9,
6 when 10,
4 when 11,
4 when 12,
2 when 14,
3 when 16,
2 when 17,
0 when 18,
0 when 19,
5 when 20,
3 when 21,
0 when 22,
4 when 23,
0 when 24,
0 when 25,
1 when 26,
1 when 27,
3 when 28,
3 when 29,
3 when 30,
1 when 32,
1 when 33,
1 when 34,
1 when 35,
0 when 36,
0 when 37,
0 when 38,
0 when 39,
1 when 40,
5 when 41,
1 when 42,
3 when 43,
0 when 44,
0 when 45,
6 when 47,
0 when others;

with state select
readwrite <= 
'1' when 0,
'0' when 1,
'1' when 2,
'0' when 3,
'1' when 4,
'1' when 6,
'0' when 7,
'1' when 8,
'0' when 9,
'1' when 10,
'0' when 11,
'1' when 12,
'1' when 14,
'1' when 16,
'0' when 17,
'1' when 18,
'0' when 19,
'1' when 20,
'0' when 21,
'1' when 22,
'0' when 23,
'1' when 24,
'0' when 25,
'1' when 26,
'0' when 27,
'1' when 28,
'0' when 29,
'1' when 30,
'1' when 32,
'0' when 33,
'1' when 34,
'0' when 35,
'1' when 36,
'0' when 37,
'1' when 38,
'0' when 39,
'1' when 40,
'0' when 41,
'1' when 42,
'0' when 43,
'1' when 44,
'0' when 45,
'0' when 47,
'-' when others;

with state select
enable <= 
'1' when 0,
'1' when 1,
'1' when 2,
'1' when 3,
'1' when 4,
'1' when 6,
'1' when 7,
'1' when 8,
'1' when 9,
'1' when 10,
'1' when 11,
'1' when 12,
'1' when 14,
'1' when 16,
'1' when 17,
'1' when 18,
'1' when 19,
'1' when 20,
'1' when 21,
'1' when 22,
'1' when 23,
'1' when 24,
'1' when 25,
'1' when 26,
'1' when 27,
'1' when 28,
'1' when 29,
'1' when 30,
'1' when 32,
'1' when 33,
'1' when 34,
'1' when 35,
'1' when 36,
'1' when 37,
'1' when 38,
'1' when 39,
'1' when 40,
'1' when 41,
'1' when 42,
'1' when 43,
'1' when 44,
'1' when 45,
'1' when 47,
'0' when others;

end generated;
