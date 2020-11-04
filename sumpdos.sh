#!/usr/bin/env bash
# Usage: sumpdos.sh atom1 atom2 atom3 ...
# Output all.dat format "E atom1_s atom1_p .. atom2_s atom2_p ... total"
# Also a list of atom_orbital.dat files

# Get energy
awk '{print $1}' *pdos_tot > E.dat
tail -n +2 E.dat > result.dat
for atom in "$@"
do
	for orb in s p d f
	do
		# Check if orbital exists
		if ls  *proj*${atom}*_wfc*${orb}* 1> /dev/null 2>&1; then
			cp E.dat ${atom}_${orb}.dat
			# Group all j's of each element into atom_orb.dat
			for f in *proj*${atom}*${orb}* ; do
				awk '{print $2}' $f | paste -d ' ' ${atom}_${orb}.dat - > temp.dat	
				mv temp.dat ${atom}_${orb}.dat
			done
			# Remove header and sum over j's into all.dat
			sed -i '1d' ${atom}_${orb}.dat
			awk '{for(i=2;i<=NF;i++) t+=$i; print t; t=0}' ${atom}_${orb}.dat | paste -d ' ' result.dat - > result_temp.dat
			mv result_temp.dat result.dat
			echo ${atom}_${orb}
		fi
	done
done
# Sum over all orbitals
awk '{for(i=2;i<=NF;i++) t+=$i; print t; t=0}' result.dat > sum.dat
paste -d ' ' result.dat sum.dat > all.dat
rm E.dat result.dat sum.dat

