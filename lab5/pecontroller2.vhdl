-- PE controller generated from the DSP toolbox
-- Electronics Systems, http://www.es.isy.liu.se/

library ieee;
use ieee.std_logic_1164.all;

entity pecontroller2 is
port(
state : in integer range 0 to 47;
coefficient : out std_logic_vector(0 to 9);
start : out std_logic);
end pecontroller2;

architecture generated of pecontroller2 is
begin
with state select
coefficient <= 
"1000111001" when 4,
"1000111001" when 12,
"1010100101" when 20,
"1100010100" when 28,
"1110001101" when 36,
"1100010100" when 44,
"----------" when others;
with state select
start <= 
'1' when 4,
'1' when 12,
'1' when 20,
'1' when 28,
'1' when 36,
'1' when 44,
'0' when others;

end generated;
