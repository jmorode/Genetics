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

where `<inputfile>` and `<outputfile>` is the path to your input and output files.

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

