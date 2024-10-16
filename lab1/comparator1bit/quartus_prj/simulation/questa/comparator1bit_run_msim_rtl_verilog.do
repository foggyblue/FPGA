transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/MUST/EIE_Year_3/FPGA/Projects/lab1/comparator1bit/rtl {D:/MUST/EIE_Year_3/FPGA/Projects/lab1/comparator1bit/rtl/comparator1bit.v}

vlog -vlog01compat -work work +incdir+D:/MUST/EIE_Year_3/FPGA/Projects/lab1/comparator1bit/quartus_prj/../sim {D:/MUST/EIE_Year_3/FPGA/Projects/lab1/comparator1bit/quartus_prj/../sim/tb_comparator1bit.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_comparator1bit

add wave *
view structure
view signals
run 1 us
