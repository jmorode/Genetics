# Genetics_Astyanax

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
