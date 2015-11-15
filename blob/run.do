vlib work
vlog -reportprogress 300 -work work blob.v
vlog -reportprogress 300 -work work blob_tb.v
vsim work.blob_tb
add wave -radix unsigned -position end  sim:/blob_tb/uut/*
run -all