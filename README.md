# Genetics Astyanax

This folder contains code that was used for studying populations of Astyanax mexicanus, which are surface and cave fishes, based on microsatellites genotypes.

The scripts are the following: 
- Frequencies.r: computes allelic frequencies and the probability that two unrelated individuals have the same genotype. It also allows to format a data file for the script GenerateIndividuals_Astyanax.r 
- Pairwise_distance_genotypes_astyanax.r: it computes the pairwise distance between the genotypes that are given in input.
- GenerateIndividuals_Astyanax.r: based on allelic frequencies of a given population, it computes and plots the heterozigosity. It also simulates, still based on these frequencies, families composed of a mother, two fathers, two full siblings and one half sibling. For each type of relationship (unrelated, full sibling, half sibling and parent offspring) it computes the pairwise distance between genotypes. It also formats an input files with the simulated families for MLRelate software. 

This code was executed under R 4.1.0. 
 
