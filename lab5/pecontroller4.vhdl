-- PE controller generated from the DSP toolbox
-- Electronics Systems, http://www.es.isy.liu.se/

library ieee;
use ieee.std_logic_1164.all;

entity pecontroller4 is
port(
state : in integer range 0 to 47;
coefficient : out std_logic_vector(0 to 9);
start : out std_logic);
end pecontroller4;

architecture generated of pecontroller4 is
begin
with state select
coefficient <= 
"0011100110" when 8,
"1010100101" when 16,
"1111011101" when 24,
"1111010000" when 32,
"1111011101" when 40,
"----------" when others;
with state select
start <= 
'1' when 8,
'1' when 16,
'1' when 24,
'1' when 32,
'1' when 40,
'0' when others;

end generated;
