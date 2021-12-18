# scripts

## phonon.txt
Basic usage of phonopy https://phonopy.github.io/phonopy/vasp.html to get phonon
Also include scripts to extract phonon frequency, eigendisplacement and dynamical matrix

## script_vasp.txt
Simple BASH script to extract data (Hessian matrix, force matrix etc) from VASP output

## sumpdos.sh 
For summing projected density of states (PDOS) in Quantum Espresso (as the sumpdos.x in QE does not work on PDOS with spin-orbit)

Requires prefix-proj.pdos_atom#* files from projwfc.x output  
Usage:  
./sumpdos.sh atom1 atom2 ...

