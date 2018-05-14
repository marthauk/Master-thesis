library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity block_ram is
  generic(
    B_RAM_SIZE      : integer := 100;
    B_RAM_BIT_WIDTH : integer := 32
    );
  port (
    clk           : in  std_logic;
    aresetn       : in  std_logic;
    data_in       : in  std_logic_vector(B_RAM_BIT_WIDTH-1 downto 0);
    write_enable  : in  std_logic;
    read_enable   : in  std_logic;
    read_address  : in  integer range 0 to B_RAM_SIZE-1;
    write_address : in  integer range 0 to B_RAM_SIZE -1;  -- added
    data_out      : out std_logic_vector(B_RAM_BIT_WIDTH-1 downto 0)
    );
end block_ram;
architecture Behavioral of block_ram is
  type bus_array is array(0 to B_RAM_SIZE-1) of std_logic_vector(B_RAM_BIT_WIDTH-1 downto 0);
  signal b_ram_data : bus_array;
begin
  process(clk)
  begin
    if(rising_edge(clk)) then
      if(write_enable = '1') then
        b_ram_data(write_address) <= data_in;
      end if;
    end if;
  end process;
  process(clk)
  begin
    if(rising_edge(clk)) then
      if(read_enable = '1') then
        data_out <= b_ram_data(read_address);
      end if;
    end if;

  end process;
end Behavioral;
