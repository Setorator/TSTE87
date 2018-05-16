-- PE controller generated from the DSP toolbox
-- Electronics Systems, http://www.es.isy.liu.se/

library ieee;
use ieee.std_logic_1164.all;

entity pecontroller3 is
port(
state : in integer range 0 to 47;
coefficient : out std_logic_vector(0 to 15);
start : out std_logic);
end pecontroller3;

architecture generated of pecontroller3 is
begin
with state select
coefficient <= 
"1111011101000000" when 6,
"1100010100000000" when 14,
"1110000100000000" when 22,
"1000111000110000" when 30,
"1010100100100000" when 38,
"----------------" when others;
with state select
start <= 
'1' when 6,
'1' when 14,
'1' when 22,
'1' when 30,
'1' when 38,
'0' when others;

end generated;
