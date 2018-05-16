-- PE controller generated from the DSP toolbox
-- Electronics Systems, http://www.es.isy.liu.se/

library ieee;
use ieee.std_logic_1164.all;

entity pecontroller1 is
port(
state : in integer range 0 to 47;
coefficient : out std_logic_vector(0 to 9);
start : out std_logic);
end pecontroller1;

architecture generated of pecontroller1 is
begin
with state select
coefficient <= 
"0011101010" when 2,
"1110010100" when 10,
"1110010101" when 18,
"1110000100" when 26,
"0100100011" when 34,
"1110000100" when 42,
"----------" when others;
with state select
start <= 
'1' when 2,
'1' when 10,
'1' when 18,
'1' when 26,
'1' when 34,
'1' when 42,
'0' when others;

end generated;
