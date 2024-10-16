transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {comparator1bit.vo}

vlog -vlog01compat -work work +incdir+D:/MUST/EIE_Year_3/FPGA/Projects/lab1/comparator1bit/quartus_prj/../sim {D:/MUST/EIE_Year_3/FPGA/Projects/lab1/comparator1bit/quartus_prj/../sim/tb_comparator1bit.v}

vsim -t 1ps -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  tb_comparator1bit

add wave *
view structure
view signals
run 1 us
