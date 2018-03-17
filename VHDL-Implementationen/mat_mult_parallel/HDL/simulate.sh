#!/bin/bash

# directories

work_dir=mat_mult/
base_dir=/home/tlattmann/cadence/
vhdl_dir=HDL/


# global settings

errormax=15
worklib=worklib
#testbench=top_level_tb
testbench=dft8optimiert_top
architecure=arch
simulation_time="1500ns"


# VHDL-files

directory=$base_dir$work_dir$vhdl_dir

constant_declarations="constants.vhdl"
datatype_declarations="datatypes.vhdl"
function_declerations="functions.vhdl"

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
$function_declerations \
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
