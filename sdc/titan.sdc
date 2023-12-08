###############################################################################
# Created by write_sdc
# Fri Dec  8 16:48:49 2023
###############################################################################
current_design titan
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name sys_clock_i -period 25.0000 [get_ports {sys_clock_i}]
set_clock_transition 0.1500 [get_clocks {sys_clock_i}]
set_clock_uncertainty 0.2500 sys_clock_i
set_propagated_clock [get_clocks {sys_clock_i}]
set_input_delay 5.0000 -clock [get_clocks {sys_clock_i}] -add_delay [get_ports {spi_clock_i}]
set_input_delay 5.0000 -clock [get_clocks {sys_clock_i}] -add_delay [get_ports {spi_cs_i}]
set_input_delay 5.0000 -clock [get_clocks {sys_clock_i}] -add_delay [get_ports {spi_pico_i}]
set_output_delay 5.0000 -clock [get_clocks {sys_clock_i}] -add_delay [get_ports {spi_poci_o}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0729 [get_ports {spi_poci_o}]
set_driving_cell -lib_cell gf180mcu_fd_sc_mcu7t5v0__inv_1 -pin {ZN} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {spi_clock_i}]
set_driving_cell -lib_cell gf180mcu_fd_sc_mcu7t5v0__inv_1 -pin {ZN} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {spi_cs_i}]
set_driving_cell -lib_cell gf180mcu_fd_sc_mcu7t5v0__inv_1 -pin {ZN} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {spi_pico_i}]
set_driving_cell -lib_cell gf180mcu_fd_sc_mcu7t5v0__inv_4 -pin {ZN} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sys_clock_i}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_transition 3.0000 [current_design]
set_max_fanout 4.0000 [current_design]
