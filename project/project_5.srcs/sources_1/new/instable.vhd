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
        data: in std_logic_vector (7 downto 0)
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
                  end if;
              end if;
          end process;
end take_data;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
 
entity find_first is
    port(
        data: in std_logic_vector (7 downto 0);
        address: out std_logic_vector (15 downto 0);
        shift: out std_logic_vector (7 downto 0);
        clock: in std_logic;
        reset: in std_logic;
        enable: out std_logic;
        wenable: out std_logic;
        start: in std_logic;
        max: in std_logic_vector (7 downto 0)
    );
end find_first;

architecture left_size of find_first is
    signal aggiungi : std_logic_vector (15 downto 0) := "0000000000000001";
    signal indirizzo : std_logic_vector(15 downto 0) := "0000000000000010";
    begin
          valore : process(clock,start) is
          begin
              if rising_edge(clock) then
              
                  if(reset = '0') then
                     enable <= '1';
                     wenable <= '0';
                     address <= indirizzo;
                     indirizzo <= indirizzo + aggiungi;
                  else
                     indirizzo <= "0000000000000010";
                  end if;
              end if;
          end process;
end left_size;

architecture arch of project_reti_logiche is
    
    signal lenght: std_logic_vector (7 downto 0);
    signal high: std_logic_vector (7 downto 0);
    signal trashold: std_logic_vector (7 downto 0);
    
    signal shift_l: std_logic_vector (7 downto 0);
    signal shift_r: std_logic_vector (7 downto 0);
    signal shift_high: std_logic_vector (7 downto 0);
    signal shift_low: std_logic_vector (7 downto 0);
    
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
            data: in std_logic_vector (7 downto 0) 
        );
    end component;
    
    component find_first is
        port(
            data: in std_logic_vector (7 downto 0);
            address: out std_logic_vector (15 downto 0);
            shift: out std_logic_vector (7 downto 0);
            clock: in std_logic;
            reset: in std_logic;
            enable: out std_logic;
            wenable: out std_logic;
            start: in std_logic;
            max: in std_logic_vector (7 downto 0)
        );
    end component; 

    begin
        take: counter 
            port map(
                clock => i_clk,
                start => i_start,
                enable => o_en,
                wenable => o_we,
                address => o_address,
                reset => i_rst,
                lenght => lenght,
                high => high,
                trashold => trashold,
                data =>i_data
            );
        left: find_first
                port map(
                    clock => i_clk,
                    start => i_start,
                    enable => o_en,
                    wenable => o_we,
                    address => o_address,
                    reset => i_rst,
                    data => i_data,
                    shift => shift_l,
                    max => high
                );
            
        
       
end arch;
