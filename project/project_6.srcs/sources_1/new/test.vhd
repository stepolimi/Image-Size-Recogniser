---------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.02.2018 19:32:36
-- Design Name: 
-- Module Name: prova1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity project_reti_logiche is
    port (
        i_clk : in std_logic;
        i_start : in std_logic;
        i_rst : in std_logic;
        i_data : in std_logic_vector(7 downto 0);
        o_address : out std_logic_vector(15 downto 0);
        o_done : out std_logic;
        o_en : out std_logic;
        o_we : out std_logic;
        o_data : out std_logic_vector (7 downto 0)
    );
end project_reti_logiche;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
 
entity counter is
    port(
        clock: in std_logic;
        start: in std_logic;
        reset: in std_logic;
        enable: out std_logic;
        wenable: out std_logic;
        address: out std_logic_vector (15 downto 0);
        lenght: out std_logic_vector(7 downto 0);
        high: out std_logic_vector (7 downto 0);
        trashold: out std_logic_vector (7 downto 0);
        data: in std_logic_vector (7 downto 0);
        go: out std_logic
        );
end counter;
 
architecture take_data of counter is
    signal aggiungi : std_logic_vector (15 downto 0) := "0000000000000001";
    signal indirizzo : std_logic_vector(15 downto 0) := "0000000000000010";
    
    begin
          valore : process(clock,start) is
          begin
              if rising_edge(clock) then
                  case indirizzo is
                      when "0000000000000100" =>
                           lenght <= data;
                      when "0000000000000101" =>
                           high <= data;
                      when "0000000000000110" =>
                           trashold <= data;
                           go <= '1';
                      when others =>
                            indirizzo <= indirizzo;   --nulla in pratica
                  end case;
                  if(reset = '0') then
                 -- if(start='1') then
                     enable <= '1';
                     wenable <= '0';
                     address <= indirizzo;
                     indirizzo <= indirizzo + aggiungi;
               --   end if;
                  else
                     indirizzo <= "0000000000000010";
                     go <= '0';
                  end if;
              end if;
          end process;
end take_data;

-------------------------------------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
 
entity find_left is
    port(
        data: in std_logic_vector (7 downto 0);
        address: out std_logic_vector (15 downto 0);
        shift: out std_logic_vector (7 downto 0);
        clock: in std_logic;
        reset: in std_logic;
--        enable: out std_logic;
--        wenable: out std_logic;
        go: out std_logic;
        high: in std_logic_vector (7 downto 0);
        lenght: in std_logic_vector (7 downto 0);
        trashold: in std_logic_vector (7 downto 0);
        start: in std_logic;
        stop: out std_logic
    );
end find_left;

architecture left_size of find_left is
    signal colonna : std_logic_vector (7 downto 0) := "00000001";           --tiene traccia della colonna attuale
    signal place: std_logic_vector (7 downto 0) := "00000001";              --posizione successiva sulla colonna
    signal starting_address : std_logic_vector (15 downto 0) := "0000000000000101";     --indirizzo iniziale della mem (5)
    signal to_be_read : std_logic_vector (15 downto 0) := "0000000000000101";       --indirizzo attuale che si manda in uscita
    signal add : std_logic_vector (15 downto 0);                       
    signal one: std_logic_vector (7 downto 0) := "00000001";
    signal pos: std_logic_vector (7 downto 0):="00000000";          --
    begin
          valore : process(clock) is
          begin
              if rising_edge(clock) then
                    if(start = '1') then
                        place <= place + one;
                        address <= to_be_read;
                        if(data = data) then
                            shift <= colonna;
                            go <= '1';
                            stop <= '0';
                        elsif( place = high ) then
                            place <= one;
                            to_be_read <= starting_address + "00000000" & colonna;
                            colonna <= colonna + one;
                        else
                            add <= "00000000" & lenght;
                            to_be_read <= to_be_read + add;
                        end if;

                   end if;
              end if;
          end process;
end left_size;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
 
entity find_up is
    port(
        data: in std_logic_vector (7 downto 0);
        address: out std_logic_vector (15 downto 0);
        shift: out std_logic_vector (7 downto 0);
        clock: in std_logic;
        reset: in std_logic;
        enable: out std_logic;
        wenable: out std_logic;
        go: in std_logic;
        high: in std_logic_vector (7 downto 0);
        lenght: in std_logic_vector (7 downto 0);
        trashold: in std_logic_vector (7 downto 0)
    );
end find_up;

architecture up_size of find_up is
    signal riga_due_prima : std_logic_vector (7 downto 0) := "00000001";
    signal place: std_logic_vector (7 downto 0) := "00000000";
    signal last_read : std_logic_vector (15 downto 0) := "0000000000000100";
    signal aggiungi : std_logic_vector (15 downto 0) := "0000000000000001";
    signal indirizzo : std_logic_vector(15 downto 0) := "0000000000000010";
    begin
          valore : process(clock) is
          begin
              if rising_edge(clock) then
                      address <= indirizzo;
   --                 if( place = lenght) then
   --                         
   --                 else
   --                     indirizzo <= last_read + indirizzo;
   --                 end if;
              end if;
          end process;
end up_size;



-------------------------------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity mux is
    port(
        clock: in std_logic;
        sel: in std_logic_vector (3 downto 0);
        count: in std_logic_vector (15 downto 0);
        left: in std_logic_vector (15 downto 0);
        up: in std_logic_vector (15 downto 0);
        right: in std_logic_vector (15 downto 0);
        down: in std_logic_vector (15 downto 0);
        address: out std_logic_vector (15 downto 0)
        );
end mux;

architecture mux_address of mux is
    begin
        with sel select
            address <= count when "0000",
                       left when "0001",
                       right when "0010",
                       up when "0100",
                       down when "1000",
                       "1010101010101010" when others;
end mux_address;        

-------------------------------------------------------------------------------------------------------------

architecture arch of project_reti_logiche is
    
    signal lenght: std_logic_vector (7 downto 0);
    signal high: std_logic_vector (7 downto 0);
    signal trashold: std_logic_vector (7 downto 0);
    
    signal ready: std_logic_vector (3 downto 0) := "0000";
    
    signal shift_l: std_logic_vector (7 downto 0);
    signal shift_r: std_logic_vector (7 downto 0);
    signal shift_high: std_logic_vector (7 downto 0);
    signal shift_low: std_logic_vector (7 downto 0);
    
    signal address_count: std_logic_vector (15 downto 0);
    signal address_left: std_logic_vector (15 downto 0);  
    signal address_high: std_logic_vector (15 downto 0);
    signal address_low: std_logic_vector (15 downto 0);
    signal address_right: std_logic_vector (15 downto 0);  
    
    component counter is
        port(
            clock: in std_logic;
            reset: in std_logic;
            start: in std_logic;
            enable: out std_logic;
            wenable: out std_logic;
            address: out std_logic_vector (15 downto 0);
            lenght : out std_logic_vector (7 downto 0);
            high: out std_logic_vector (7 downto 0);
            trashold: out std_logic_vector (7 downto 0);
            data: in std_logic_vector (7 downto 0);
            go: out std_logic 
        );
    end component;
    
    component find_left is
        port(
            data: in std_logic_vector (7 downto 0);
            address: out std_logic_vector (15 downto 0);
            shift: out std_logic_vector (7 downto 0);
            clock: in std_logic;
            reset: in std_logic;
  --          enable: out std_logic;
  --          wenable: out std_logic;
            go: out std_logic;
            high: in std_logic_vector (7 downto 0);
            lenght: in std_logic_vector (7 downto 0);
            trashold: in std_logic_vector (7 downto 0);
            start: in std_logic;
            stop: out std_logic            
        );
    end component; 
    
    component mux is
        port(
            clock: in std_logic;
            sel: in std_logic_vector (3 downto 0);
            count: in std_logic_vector (15 downto 0);
            left: in std_logic_vector (15 downto 0);
            up: in std_logic_vector (15 downto 0);
            right: in std_logic_vector (15 downto 0);
            down: in std_logic_vector (15 downto 0);
            address: out std_logic_vector (15 downto 0)
            );
    end component;

    begin
        take: counter 
            port map(
                clock => i_clk,
                start => i_start,
                enable => o_en,
                wenable => o_we,
                address => address_count,
                reset => i_rst,
                lenght => lenght,
                high => high,
                trashold => trashold,
                data =>i_data,
                go => ready(0)
            );
        left: find_left
                    port map(
                        clock => i_clk,
                        go => ready(1),
    --                    enable => o_en,             ---metto in entrata l'adrress e uso quello come valore iniziale!
    --                    wenable => o_we,
                        address => address_left,
                        reset => i_rst,
                        data => i_data,
                        shift => shift_l,
                        high => high,
                        lenght =>lenght,
                        trashold =>trashold,
                        start => ready (0),
                        stop => ready(0)
                    );
        multiplexer: mux
            port map(
                clock => i_clk,
                sel => ready,
                count => address_count,
                left => address_left,
                right => address_right,
                up => address_high,
                down => address_low,
                address => o_address
            );
       
end arch;
