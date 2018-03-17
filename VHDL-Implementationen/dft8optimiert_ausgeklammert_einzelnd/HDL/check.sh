#!/bin/bash

octave_script_dir="/home/tlattmann/Bachelorarbeit/octave/dft8_vhdl_test/"
octave_script="binMat2decMat.m"

octave="matlab -nodesktop -r "

./simulate.sh && matlab -nojvm -nodisplay -nosplash -r $octave_script

stty echo
