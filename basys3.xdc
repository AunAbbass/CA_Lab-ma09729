## Clock
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Reset button (btnC)
set_property PACKAGE_PIN U18 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

## Switches
set_property PACKAGE_PIN V17 [get_ports {sw_pins[0]}]
set_property PACKAGE_PIN V16 [get_ports {sw_pins[1]}]
set_property PACKAGE_PIN W16 [get_ports {sw_pins[2]}]
set_property PACKAGE_PIN W17 [get_ports {sw_pins[3]}]
set_property PACKAGE_PIN W15 [get_ports {sw_pins[4]}]
set_property PACKAGE_PIN V15 [get_ports {sw_pins[5]}]
set_property PACKAGE_PIN W14 [get_ports {sw_pins[6]}]
set_property PACKAGE_PIN W13 [get_ports {sw_pins[7]}]
set_property PACKAGE_PIN V2 [get_ports {sw_pins[8]}]
set_property PACKAGE_PIN T3 [get_ports {sw_pins[9]}]
set_property PACKAGE_PIN T2 [get_ports {sw_pins[10]}]
set_property PACKAGE_PIN R3 [get_ports {sw_pins[11]}]
set_property PACKAGE_PIN W2 [get_ports {sw_pins[12]}]
set_property PACKAGE_PIN U1 [get_ports {sw_pins[13]}]
set_property PACKAGE_PIN T1 [get_ports {sw_pins[14]}]
set_property PACKAGE_PIN R2 [get_ports {sw_pins[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw_pins[*]}]

## LEDs
set_property PACKAGE_PIN U16 [get_ports {led_pins[0]}]
set_property PACKAGE_PIN E19 [get_ports {led_pins[1]}]
set_property PACKAGE_PIN U19 [get_ports {led_pins[2]}]
set_property PACKAGE_PIN V19 [get_ports {led_pins[3]}]
set_property PACKAGE_PIN W18 [get_ports {led_pins[4]}]
set_property PACKAGE_PIN U15 [get_ports {led_pins[5]}]
set_property PACKAGE_PIN U14 [get_ports {led_pins[6]}]
set_property PACKAGE_PIN V14 [get_ports {led_pins[7]}]
set_property PACKAGE_PIN V13 [get_ports {led_pins[8]}]
set_property PACKAGE_PIN V3 [get_ports {led_pins[9]}]
set_property PACKAGE_PIN W3 [get_ports {led_pins[10]}]
set_property PACKAGE_PIN U3 [get_ports {led_pins[11]}]
set_property PACKAGE_PIN P3 [get_ports {led_pins[12]}]
set_property PACKAGE_PIN N3 [get_ports {led_pins[13]}]
set_property PACKAGE_PIN P1 [get_ports {led_pins[14]}]
set_property PACKAGE_PIN L1 [get_ports {led_pins[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_pins[*]}]

## Seven-segment segments
set_property PACKAGE_PIN W7 [get_ports {seg[0]}]
set_property PACKAGE_PIN W6 [get_ports {seg[1]}]
set_property PACKAGE_PIN U8 [get_ports {seg[2]}]
set_property PACKAGE_PIN V8 [get_ports {seg[3]}]
set_property PACKAGE_PIN U5 [get_ports {seg[4]}]
set_property PACKAGE_PIN V5 [get_ports {seg[5]}]
set_property PACKAGE_PIN U7 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[*]}]

## Seven-segment anodes
set_property PACKAGE_PIN U2 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[*]}]

## countdown_out[3:0] -> Pmod JA1..JA4 (spare header pins, so the port is constrained)
set_property PACKAGE_PIN J1 [get_ports {countdown_out[0]}]
set_property PACKAGE_PIN L2 [get_ports {countdown_out[1]}]
set_property PACKAGE_PIN J2 [get_ports {countdown_out[2]}]
set_property PACKAGE_PIN G2 [get_ports {countdown_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {countdown_out[*]}]

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
