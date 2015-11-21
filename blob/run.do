vlib work
vlog -reportprogress 300 -work work blob.v
vlog -sv -reportprogress 300 -work work ../pixel_arbiter/pixel_arbiter.sv
vlog -sv -reportprogress 300 -work work ../ram/ram.sv
vlog -sv -reportprogress 300 -work work blob_tb.sv
vsim work.blob_tb
add wave -radix unsigned -position end  sim:/blob_tb/blob0/*
#add wave -radix unsigned -position end  sim:/blob_tb/blob1/*
add wave -radix unsigned -position end  sim:/blob_tb/pixel_arbiter_i/*
#add wave -radix unsigned -position end  sim:/blob_tb/pixel_arbiter_i/pixel_ram/*
run -all