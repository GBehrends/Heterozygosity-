#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=Het 
#SBATCH --nodes=1 --ntasks=16
#SBATCH --partition quanah
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G

# Be sure to make output directory separate from the input directory. 
# Input directory is the directory containing your .simple.vcfs files.  
outputdir=Het
inputdir=Het/SimpleVCF


for i in $(ls ${inputdir} | grep "simple.vcf"); do
END="$(awk '{print NF; exit}' ${inputdir}/${i})"; 
for ((x = 4; x <= END; ++x)); do
Genotyped_Count="$(cut -f${x} ${inputdir}/${i} | wc -l | sed 's/ /\t/g' | cut -f1)"
Het_Count="$(cut -f${x} ${inputdir}/${i} | grep -F -e '0/1' -e '1/0' -e '1|0' -e '0|1' | wc -l | sed 's/ /\t/g' | cut -f1)"
echo " scale=10; ${Het_Count} / ${Genotyped_Count}" | bc >> ${outputdir}/${i%%.*}_Obs_Het_Temp.txt
cat -n ${outputdir}/${i%%.*}_Obs_Het_Temp.txt > ${outputdir}/${i%%.*}_Het.txt; done
rm ${outputdir}/*Temp.txt; done
