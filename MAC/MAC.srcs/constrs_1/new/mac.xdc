
#set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports {clk}]; 
set_property PACKAGE_PIN N14 [get_ports clk]
    set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 5.00 -waveform {0 2.5} [get_ports {clk}];


       