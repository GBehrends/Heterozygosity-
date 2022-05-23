# Calculating Genome Wide Observed Heterozygosity
-------------------------------------------------------------------------------------------------------------------------------------------------------

STEP 1: Make directory for output \
*Submission script will not work if output files don't go into a separate directory*

mkdir -p Het/SimpleVCF Het/VCF

-------------------------------------------------------------------------------------------------------------------------------------------------------

STEP 2: Submit ConcatFilter.sh to filter and simplify the genotype info 

-------------------------------------------------------------------------------------------------------------------------------------------------------

STEP 3: Concatenate the simplified vcf files 

cat *simple.vcf >> name.simple.vcf2 \
mv name.simple.vcf2 name.simple.vcf

-------------------------------------------------------------------------------------------------------------------------------------------------------

STEP 4: Modify the concatenated simple vcf to make het calculations simpler 

sed -i 's/|/./g' name.simple.vcf  \
sed -i 's/[//]/./g' name.simple.vcf

-------------------------------------------------------------------------------------------------------------------------------------------------------

STEP 5: Subtmit HetCalc.sh 

-------------------------------------------------------------------------------------------------------------------------------------------------------

STEP 6: Place Sample IDs in Obs_Het Files (optional if you have the ID list) \
*Sample ID list must be in the same order as the columns in your simple.vcf files*

paste Sample_ID_list Obs_Het.txt | cut -f 1,3 > Obs_Het_final.tsv 

An example of the ID list is included 

-------------------------------------------------------------------------------------------------------------------------------------------------------

Step 7: Plot observed heterosyzgosity results with Plot_Het.r

