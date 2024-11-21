##Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# Ensures that synthesis understands the timing requirements for the clock signal connected to the clk port.
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

## LEDs
set_property PACKAGE_PIN U16 [get_ports {transmit}]
set_property IOSTANDARD LVCMOS33 [get_ports {transmit}]

##Buttons
set_property PACKAGE_PIN U18 [get_ports btnC]
set_property IOSTANDARD LVCMOS33 [get_ports btnC]
set_property PACKAGE_PIN T18 [get_ports btnU]
set_property IOSTANDARD LVCMOS33 [get_ports btnU]
set_property PACKAGE_PIN W19 [get_ports btnL]
set_property IOSTANDARD LVCMOS33 [get_ports btnL]
set_property PACKAGE_PIN T17 [get_ports btnR]
set_property IOSTANDARD LVCMOS33 [get_ports btnR]
set_property PACKAGE_PIN U17 [get_ports btnD]
set_property IOSTANDARD LVCMOS33 [get_ports btnD]


##USB-RS232 Interface
#set_property PACKAGE_PIN B18 [get_ports RxD]
#set_property IOSTANDARD LVCMOS33 [get_ports RxD]
set_property PACKAGE_PIN A18 [get_ports TxD]
set_property IOSTANDARD LVCMOS33 [get_ports TxD]

# Ensures that the FPGA uses the JTAG clock during its startup sequence
set_property BITSTREAM.STARTUP.STARTUPCLK JTAGCLK [current_design]

# Configuration logic operates at the same voltage level as the I/O banks
set_property CFGBVS VCCO [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]