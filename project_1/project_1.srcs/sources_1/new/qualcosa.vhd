library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_reti_logiche is
port (
i_clk : in std_logic?
i_start : in std_logic?
i_rst : in std_logic?
i_data : in std_logic_vector(7 downto 0)?
o_address : out std_logic_vector(15 downto 0)?
o_done : out std_logic?
o_en : out std_logic?
o_we : out std_logic?
o_data : out std_logic_vector (7 downto 0)
)?
end project_reti_logiche?


achitecture arch of project_reti_logiche is
signal aggiungi : std_logic_vector (15 downto 0) :="0000000000000001";
signal indirizzo : std_logic_vector (15 downto 0) :="0000000000000100";
--signal prova : std_logic_vector(7 downto 0);
--signal trovato : bit := '0';
begin
    
        o_data <= "11111111";
        o_address <= indirizzo;
end arch;

