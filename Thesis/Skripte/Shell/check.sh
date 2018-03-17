#!/bin/bash

matlab_script="binMat2decMat.m"

./simulate.sh && matlab -nojvm -nodisplay -nosplash -r $matlab_script

stty echo
