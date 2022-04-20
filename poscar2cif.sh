#!/usr/bin/env bash
usage()
{
	echo "Usage: ./poscar2cif <POSCAR file> [-l LatticeTolerance] [-p AtomicPositionTolerance] [-r (Rhombohedral Axes)] "
	exit 1
}
if [ "$#" -eq 0 ]
then
	usage >&2
fi

posfile="${1:?Missing POSCAR file}"
infile="${posfile%.*}".in
outfile="${posfile%.*}".cif

printf "!useKeyWords\n" > $infile
printf "!title\n" >> $infile
head -1 $posfile >> $infile

shift 1
#findsym default latTol=0.00001
#findsym default posTol=0.001
while getopts ":l:p:r" opt; do
	case $opt in
	l) latTol="$OPTARG"
	printf "!latticeTolerance\n" >> $infile
	printf "$latTol\n" >> $infile
	;;
	p) posTol="$OPTARG"
	printf "!atomicPositionTolerance\n" >> $infile
	printf "$posTol\n" >> $infile
	;;
	r) printf "!rhombohedralAxes\n" >> $infile
	;;
	:) echo "Missing argument" >&2
	rm $infile
	exit 2
	;;
	\?) echo "Invalid option -$OPTARG" >&2
	rm $infile
	exit 3
	;;
	esac
done

printf "!latticeBasisVectors\n" >> $infile
sed -n '3,5p' $posfile >> $infile

atomList=($(sed -n '6p' test.vasp))
natom=$(sed -n '7p' $posfile)
natomList=($natom)
N=0
for n in $natom
do  
	N=$(($N+$n))
done


printf "!atomCount\n" >> $infile
printf "$N\n" >> $infile

printf "!atomType\n" >> $infile
for i in "${!atomList[@]}"
do
	printf "${natomList[$i]}*${atomList[$i]} " >> $infile
done
printf "\n" >> $infile
printf "!atomPosition\n" >> $infile
grep -A $N 'Direct' $posfile | tail -n $N >> $infile

# findsym  $infile > $outfile
