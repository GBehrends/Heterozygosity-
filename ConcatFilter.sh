#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=filt_Het 
#SBATCH --nodes=1 --ntasks=12
#SBATCH --partition quanah
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=<# of g.vcf prefixes>


		
							###Beginning Steps###

# define input files from helper file during genotyping
input_array=$( head -n${SLURM_ARRAY_TASK_ID} <list of g.vcf file prefixes> | tail -n1 )

#Begin for loop for all species directories 
for i in $(cat ../specieslist); do 

# Run vcftools 
vcftools --vcf <location of g.vcf files> --max-missing 0.5 --minQ 20 --minGQ 20 --minDP 6 --max-meanDP 50  --max-alleles 2 --mac 1 --max-maf 0.49 --remove-indels --include-non-variant-sites --recode --recode-INFO-all --out Het/VCF 

# Run bcftools to simplify vcfs for Het calculation 
bcftools query -f '%POS\t%REF\t%ALT[\t%GT]\n ' Het/VCF/${input_array}.vcf > Het/SimpleVCF/${input_array}.simple.vcf;
done 
