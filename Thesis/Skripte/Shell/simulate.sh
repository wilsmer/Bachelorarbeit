#!/bin/bash

# global settings

errormax=15
worklib=worklib
#testbench=top_level_tb
testbench=dft8optimiert_top
architecure=arch
simulation_time="1500ns"


# VHDL-files

constant_declarations="constants.vhdl"
datatype_declarations="datatypes.vhdl"

main_entity="dft8optimiert.vhdl"
top_level_entity="dft8_optimiert_top.vhdl"
#top_level_testbench=

embedded_entity_1="read_input_matrix.vhdl"
embedded_entity_2="write_results.vhdl"


constant_declarations=$directory$constant_declarations
datatype_declarations=$directory$datatype_declarations
function_declerations=$directory$function_declerations
main_entity=$directory$main_entity
top_level_entity=$directory$top_level_entity
#top_level_testbench=$directory$top_level_testbench

embedded_entity_1=$directory$embedded_entity_1
embedded_entity_2=$directory$embedded_entity_2


# libs und logfiles

cdslib="cds.lib"
elab_logfile="ncelab.log"
ncvhdl_logfile="nchvdl.log"
ncsim_logfile="ncsim.log"

cdslib=${base_dir}${work_dir}${cdslib}
elab_logfile=${dirctory}${elab_logfile}
ncvhdl_logfile=${directory}${ncvhdl_logfile}
ncsim_logfile=${directory}${ncsim_logfile}


## 

ncvhdl \
-work $worklib \
-cdslib $cdslib \
-logfile $ncvhdl_logfile \
-errormax $errormax \
-update \
-v93 \
-linedebug \
$constant_declarations \
$datatype_declarations \
$embedded_entity_1 \
$embedded_entity_2 \
$main_entity \
$top_level_entity \
#$top_level_testbench
#-status \

ncelab \
-work $worklib \
-cdslib $cdslib \
-logfile $elab_logfile \
-errormax $errormax \
-access +wc \
${worklib}.${testbench}
#-status \

ncsim \
-cdslib $cdslib \
-logfile $ncsim_logfile \
-errormax $errormax \
-exit \
${worklib}.${testbench}:${architecure} \
-input testRUN.tcl  
#-status \



#ncvhdl -work worklib -cdslib /home/tlattmann/cadence/mat_mult/cds.lib -logfile /home/tlattmann/cadence/mat_mult/nchvdl.log -errormax 15 -update -v93 -linedebug /home/tlattmann/cadence/mat_mult/HDL/constants.vhdl /home/tlattmann/cadence/mat_mult/HDL/datatypes.vhdl /home/tlattmann/cadence/mat_mult/HDL/functions.vhdl /home/tlattmann/cadence/mat_mult/HDL/read_input_matrix.vhdl /home/tlattmann/cadence/mat_mult/HDL/write_results.vhdl /home/tlattmann/cadence/mat_mult/HDL/dft8optimiert.vhdl /home/tlattmann/cadence/mat_mult/HDL/dft8_optimiert_top.vhdl -status 

#ncelab -work worklib -cdslib /home/tlattmann/cadence/mat_mult/cds.lib -logfile /home/tlattmann/cadence/mat_mult/ncelab.log -errormax 15 -access +wc worklib.dft8optimiert_top -status 

#ncsim -cdslib /home/tlattmann/cadence/mat_mult/cds.lib -logfile /home/tlattmann/cadence/mat_mult/ncsim.log -errormax 15 worklib.dft8_optimiert_top:arch -input testRUN.tcl -status

#database -open waves -into waves.shm -default
#probe -create -shm :clk :input_imag :input_real :loaded :mult_im_out :mult_re_out :multState_out :nReset :result_imag :result_ready :result_real :sum1_stage1_3v6_re_out :sum1_stage2_2v3_re_out :sum1_stage2_3v3_re_out :sum1_stage3_1v1_re_out :sum3_stage1_im_out :sum3_stage1_re_out :sum3_stage2_im_out :sum3_stage2_re_out :sum3_stage3_im_out :sum3_stage3_re_out :sum3_stage4_im_out :sum3_stage4_re_out :write_done
