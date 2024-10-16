transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/MUST/EIE_Year_3/FPGA/Projects/lab1/decoder2to4/rtl {D:/MUST/EIE_Year_3/FPGA/Projects/lab1/decoder2to4/rtl/decoder2to4.v}

vlog -vlog01compat -work work +incdir+D:/MUST/EIE_Year_3/FPGA/Projects/lab1/decoder2to4/quartus_prj/../sim {D:/MUST/EIE_Year_3/FPGA/Projects/lab1/decoder2to4/quartus_prj/../sim/tb_decoder2to4.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_decoder2to4

add wave *
view structure
view signals
run 1 us
