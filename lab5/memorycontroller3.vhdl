-- Memory controller generated from the DSP toolbox
-- Electronics Systems, http://www.es.isy.liu.se/

library ieee;
use ieee.std_logic_1164.all;

entity memorycontroller3 is
port(
state : in integer range 0 to 47;
adress : out integer range 0 to 0;
enable, readwrite : out std_logic);
end memorycontroller3;

architecture generated of memorycontroller3 is
begin
with state select
adress <= 
0 when 5,
0 when 16,
0 when 25,
0 when 32,
0 when others;

with state select
readwrite <= 
'0' when 5,
'1' when 16,
'0' when 25,
'1' when 32,
'-' when others;

with state select
enable <= 
'1' when 5,
'1' when 16,
'1' when 25,
'1' when 32,
'0' when others;

end generated;
