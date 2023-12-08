onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_manchester_baby/clock
add wave -noupdate /tb_manchester_baby/reset_i
add wave -noupdate /tb_manchester_baby/logisim_clock_tree_0_out
add wave -noupdate /tb_manchester_baby/logisim_clock_tree_3_out
add wave -noupdate /tb_manchester_baby/stop_lamp_o
add wave -noupdate -divider {ram i/o}
add wave -noupdate -radix hexadecimal /tb_manchester_baby/ram_addr_o
add wave -noupdate -radix hexadecimal /tb_manchester_baby/ram_data_io
add wave -noupdate -radix hexadecimal /tb_manchester_baby/ram_rw_en_o
add wave -noupdate -radix hexadecimal /tb_manchester_baby/uut_manchester_baby/ram_data_i
add wave -noupdate -radix hexadecimal /tb_manchester_baby/uut_manchester_baby/ram_addr_o
add wave -noupdate -divider internal
add wave -noupdate -radix hexadecimal /tb_manchester_baby/uut_manchester_baby/manchester_baby_instance/CIRCUIT_0/IR/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 265
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {863 ps}
