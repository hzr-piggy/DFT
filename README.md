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

## gyrotropic_spin.F90 
Replaces wannier90-version/src/postw90/gyrotropic.F90  
Originally to calculate the SPIN part of kinetic magnetoelectric effect (kME) and the interband contribution to the natural optical
activity (NOA) we also need to compute the ORBITAL part (berry_task=-spin, user guide version-3.1.0 section 13), which requires a huge .uHu file. With slight modification, we can compute the SPIN part alone.  

Usage (see tutorial version-3.1.0 24: Tellurium-gyrotropic effects)
...
gyrotropic=true  
gyrotropic_task=-kspin (SPIN part only, require mmn, amn, spn file)  
gyrotropic_task=-korb (ORBITAL part only, require additional uHu file)  
gyrotropic_task=-noaspin (SPIN part only, require mmn, amn, spn file)  
gyrotropic_task=-noaorb (ORBITAL part only, require additional uHu file)
...
