#!/bin/bash

matlab_script="VHDL-DFT_Vergleich.m"

./simulate.sh && matlab -nojvm -nodisplay -nosplash -r $matlab_script

stty echo
