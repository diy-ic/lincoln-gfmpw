###############################################################################
# Created by write_sdc
# Thu Dec  7 19:02:22 2023
###############################################################################
current_design titan
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name wb_clk_i -period 24.0000 
set_clock_uncertainty 0.2500 wb_clk_i
set_input_delay 4.8000 -clock [get_clocks {wb_clk_i}] -add_delay [get_ports {spi_clock_i}]
set_input_delay 4.8000 -clock [get_clocks {wb_clk_i}] -add_delay [get_ports {spi_cs_i}]
set_input_delay 4.8000 -clock [get_clocks {wb_clk_i}] -add_delay [get_ports {spi_pico_i}]
set_input_delay 4.8000 -clock [get_clocks {wb_clk_i}] -add_delay [get_ports {sys_clock_i}]
set_output_delay 4.8000 -clock [get_clocks {wb_clk_i}] -add_delay [get_ports {spi_poci_o}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0729 [get_ports {spi_poci_o}]
set_driving_cell -lib_cell gf180mcu_fd_sc_mcu7t5v0__inv_1 -pin {ZN} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {spi_clock_i}]
set_driving_cell -lib_cell gf180mcu_fd_sc_mcu7t5v0__inv_1 -pin {ZN} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {spi_cs_i}]
set_driving_cell -lib_cell gf180mcu_fd_sc_mcu7t5v0__inv_1 -pin {ZN} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {spi_pico_i}]
set_driving_cell -lib_cell gf180mcu_fd_sc_mcu7t5v0__inv_1 -pin {ZN} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sys_clock_i}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_transition 3.0000 [current_design]
set_max_fanout 4.0000 [current_design]
