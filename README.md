# DFT

## sumpdos.sh 
For summing projected density of states (PDOS) in Quantum Espresso (as the sumpdos.x in QE does not work on PDOS with spin-orbit)

Requires prefix-proj.pdos_atom#* files from projwfc.x output  
Usage:  
./sumpdos.sh atom1 atom2 ...

## pythtb_w90.py
A modified version of [PythTB](http://www.physics.rutgers.edu/pythtb/) that can read output from Wannier90 **AND include spin**.  

Usage similar to http://www.physics.rutgers.edu/pythtb/usage.html#pythtb.w90  
...
PREFIX=w90("/path/to/file", "PREFIX")  
my_model=PREFIX.model(... , **nspin=2**)
...
