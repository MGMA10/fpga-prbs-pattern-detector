vlib work
vlog -f sourcefiles.txt
vsim -voptargs=+accs work.TOP_TB
add wave *
run -all