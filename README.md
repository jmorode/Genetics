# Genetics_Astyanax

This folder contains code that was used for studying populations of Astyanax mexicanus, which are surface and cave fishes, based on microsatellites genotypes.

The scripts are the following: 
- Frequencies.r: computes allelic frequencies and the probability that two unrelated individuals have the same genotype. It also allows to format a data file for the script GenerateIndividuals_Astyanax.r 
- Pairwise_distance_genotypes_astyanax.r: it computes the pairwise distance between the genotypes that are given in input.
- GenerateIndividuals_Astyanax.r: based on allelic frequencies of a given population, it computes and plots the heterozigosity. It also simulates, still based on these frequencies, families composed of a mother, two fathers, two full siblings and one half sibling. For each type of relationship (unrelated, full sibling, half sibling and parent offspring) it computes the pairwise distance between genotypes. It also formats an input files with the simulated families for MLRelate software. 


This package is composed of 3 scripts:
* Frequencies.r
* GenerateIndividual_astyanax.r
* Pairwise_distance_genotypes_astyanax.r

## Dependencies
* R > 4.0

## Pairwise_distance_genotypes_astyanax.r
Given a file containing observed microsatellite alleles in a population, this script is computating the genetic distance between each individual

### Usage
`Rscript Pairwise_distance_genotype_astyanax.r <inputfile> <outputfile>`
where `<inputfile>` and `<outputfile>` are the path to your input and output files.

### Input file
A table with a row per individual and two columns for each locus (one per allele).

| Individual | locus 1 | locus 1 | locus 2 | locus 2 | … | locus n | locus n |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Ind 1 | 125 | 136 | 10 | 15 | … | 56 | 80 |
| … | | | | |  | |
| Ind n | 126 | 142 | 20 | 15 | … | 64 | 78 |

### Output file
There is two output:
Graph + table

## Frequencies.r
Compute the probability that two unrelated individuals have the  the same genotype considering the microsatellites observation in the input file.

### Usage
`Rscript Frequencies.r <inputfile> <outputfile>`
where `<inputfile>` and `<outputfile>` are the path to your input and output files.

### Input file
A table with a column per locus and a row per observation. If there is *x* individuals, the file should have *x*2* rows.

| Locus 1 | Locus 2 | … | Locus n |
| --- | --- | --- | --- |
| Obs 1.1 | Obs 2.1 | … | Obs n.1 |
| Obs 1.2 | Obs 2.2 | … | Obs n.2 |
| … | | | |
| Obs 1.m | Obs 2.m | … | Obs n.m |

### Output
* Write in the terminal the probability that two unrelated individuals would have the same genotype.
* Write the `<outputfile>`in the curreny directory for use with `GenerateIndividual_astyanax.r`

## GenerateIndividual_astyanax.r
Generate individuals given then frequency of the different alleles given in input

### Usage
`Rscript GenerateIndivual_astyanax.r <input file> <output directory>`
where `<input file>` is the path to the input file and `<output directory>` is the path to the directory where all output file will be written (that directory should exist).

### Input file
The input file can be generated using the script `Frequencies.r`.

### Output
All results file will be writtent in the `<output directory>`. That directory have to be created prior to execution. You can output in the current directory by using `.`.

* `GeneratedIndividuals4MLRelate.txt`: input file for MLRelate2.
* `TableFrequencesMatRed.csv`: Distribution of the number of differences between individuals being non-related, parent-offspring, full sibs or half sibs.
* `DistribDiffMatRed.pdf`: Graph presenting the distribution of the number of differences between individuals.
* `TableHeterozygosity.csv`: Heterozygosity of each locus.

## Licence
These scripts are distributed under the CeCILL licence.
