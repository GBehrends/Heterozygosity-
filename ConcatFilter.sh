#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=filt_Het 
#SBATCH --nodes=1 --ntasks=12
#SBATCH --partition quanah
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=<# of scaffolds in helper list>


		
							###Beginning Steps###

# define input files from helper file during genotyping
input_array=$( head -n${SLURM_ARRAY_TASK_ID} <helper list> | tail -n1 )

#Begin for loop for all species directories 
for i in $(cat ../specieslist); do 

# define main working directory
<working_directory>

# Run vcftools 
vcftools --vcf ${workdir}/03_vcf/${input_array}.g.vcf  --max-missing 0.5 --minQ 20 --minGQ 20 --minDP 6 --max-meanDP 50  --max-alleles 2 --mac 1 --max-maf 0.49 --remove-indels --include-non-variant-sites --recode --recode-INFO-all --out ${i}/04_vcf_all_sites/${input_array}

# Run bcftools to simplify vcfs for Het calculation 
bcftools query -f '%POS\t%REF\t%ALT[\t%GT]\n ' ${i}/04_vcf_all_sites/${input_array}.recode.vcf > ${i}/04_vcf_all_sites/${input_array}.simple.vcf;
done 
