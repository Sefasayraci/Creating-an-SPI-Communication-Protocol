----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2022 23:17:30
-- Design Name: 
-- Module Name: spi_master_slave - Behavioral
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
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spi_master_slave is
    Port ( rst : in STD_LOGIC;
           sck : in STD_LOGIC;
           mosi : in STD_LOGIC;
           ss : in STD_LOGIC;
           tx_data	: in std_logic_vector(7 downto 0);
          rx_data : out std_logic_vector(7 downto 0);
           miso : out STD_LOGIC);
end spi_master_slave;

architecture Behavioral of spi_master_slave is

    signal bit_cnt	: std_logic_vector(2 downto 0);
    signal rx_reg 	:  std_logic_vector(7 downto 0);


begin

-- Bit Counter
process(rst,ss,sck)
begin
	if(ss = '1' or rst = '1') then
		bit_cnt <= "111";
	elsif(ss = '0' and rising_edge(sck)) then
		if(bit_cnt = "000") then
			bit_cnt <= "111";	
		else
			bit_cnt <= bit_cnt - "001";	
		end if;		
	end if;
end process;

--
process(rst, ss, sck)
begin
	if(ss = '1' or rst = '1') then
		rx_reg <= (others => '0');
	elsif(ss = '0' and rising_edge(sck)) then
		rx_reg(to_integer(unsigned(bit_cnt))) <= mosi;
	end if;
end process;
rx_data <= rx_reg;

--
process(rst, ss, sck)
begin
	if(ss = '1' or rst = '1') then
		miso <= '0';
	elsif(ss = '0' and rising_edge(sck)) then
		miso <= tx_data(to_integer(unsigned(bit_cnt)));
	end if;
end process;
--


end Behavioral;
