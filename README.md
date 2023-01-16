# Genetics

This folder contains code that was used for studying populations of species based on microsatellites genotypes.

The scripts are the following: 
- Frequencies.r: computes allelic frequencies and the probability that two unrelated individuals have the same genotype. It also allows to format a data file for the script GenerateIndividuals.r 
- Pairwise_distance_genotypes.r: it computes the pairwise distance between the genotypes that are given in input.
- GenerateIndividuals.r: based on allelic frequencies of a given population, it computes and plots the heterozigosity. It also simulates, still based on these frequencies, families composed of a mother, two fathers, two full siblings and one half sibling. For each type of relationship (unrelated, full sibling, half sibling and parent offspring) it computes the pairwise distance between genotypes. It also formats an input files with the simulated families for MLRelate software. 
- reformat_genotypes_files_rows_cols.py: it allows to reformat genotypes input files, switching to a display of alleles values for each loci from double rows to double columns, and conversly. 

This package is composed of 4 scripts:
* Frequencies.r
* GenerateIndividual.r
* Pairwise_distance_genotypes.r
* reformat_genotypes_files_rows_cols.py

## Dependencies
* R > 4.0
* Python >= 3.9

## Pairwise_distance_genotypes.r
Given a file containing observed microsatellite alleles in a population, this script is computating the genetic distance between each individual

### Usage
`Rscript Pairwise_distance_genotype.r <inputfile> <outputfile>`
where `<inputfile>` and `<outputfile>` are the path to your input and output files.

### Input file
A table with a row per individual and two columns for each locus (one per allele).

| Individual | locus 1 | locus 1 | locus 2 | locus 2 | … | locus n | locus n |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Ind 1 | 125 | 136 | 10 | 15 | … | 56 | 80 |
| … | | | |... |  | |
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
A table with a column per locus and a row per alelle. If there is *x* individuals, the file should have *x*2* rows.

| Locus 1 | Locus 2 | … | Locus n |
| --- | --- | --- | --- |
| All 1.1 | All 2.1 | … | All n.1 |
| All 1.2 | All 2.2 | … | All n.2 |
| … | |... | | 
| All m.1 | All m.1 | … | All m.n |
| All m.2 | All m.2 | … | All m.n |

### Output
* Write in the terminal the probability that two unrelated individuals would have the same genotype.
* Write the `<outputfile>`in the curreny directory for use with `GenerateIndividual.r`

## GenerateIndividual.r
Generate individuals given then frequency of the different alleles given in input

### Usage
`Rscript GenerateIndivual.r <input file> <output directory>`
where `<input file>` is the path to the input file and `<output directory>` is the path to the directory where all output file will be written (that directory should exist).

### Input file
The input file can be generated using the script `Frequencies.r`.

### Output
All results file will be writtent in the `<output directory>`. That directory have to be created prior to execution. You can output in the current directory by using `.`.

* `GeneratedIndividuals4MLRelate.txt`: input file for MLRelate2.
* `TableFrequencesMatRed.csv`: Distribution of the number of differences between individuals being non-related, parent-offspring, full sibs or half sibs.
* `DistribDiffMatRed.pdf`: Graph presenting the distribution of the number of differences between individuals.
* `TableHeterozygosity.csv`: Heterozygosity of each locus.

## reformat_genotypes_files_rows_cols.py
Reformat microsatellites input files, switching to a display of alleles values for each loci from double rows to double columns, and conversly. 

### Usage
`python3 reformat_genotypes_files_rows_cols.py <input_file.csv> <format_type>`
where `<input_file>` is the path of the input csv file (separator ";")
and `<format_type>` is either 'cols_to_rows' (double columns to double rows) or 'rows_to_cols' (double rows to double columns)

### Input file
Compulsory columns names are 'Pop', 'Sample', 'Year' and then loci names with:

* for 'cols_to_rows': a row per individual and two columns for each locus (one per allele).

| Pop | Sample | Year | locus 1 | locus 1 | locus 2 | locus 2 | … | locus n | locus n |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| CF1 |Ind 1 |2016 | 125 | 136 | 10 | 15 | … | 56 | 80 |
| ... |  |  |  |  |  |  | ... | | |
| CFn |Ind n |2022 | 126 | 142 | 20 | 15 | … | 64 | 78 |

* for 'rows_to_cols': a column per locus and a row per allele

| Pop | Sample | Year| Locus 1 | Locus 2 | … | Locus n |
| --- | --- | --- | --- | --- | --- | --- |
| CF1 |Ind 1 |2016| All 1.1 | All 2.1 | … | All n.1 |
| CF1 |Ind 1 |2016| All 1.2 | All 2.2 | … | All n.2 |
| ... |  |  |  | |... | |
| CFn |Ind n |2022| All m.1 | All m.1 | … | All m.n |
| CFn |Ind n |2022| All m.2 | All m.2 | … | All m.n |

### Output file
Reformatted file, either from double rows to double columns or conversely.


## Licence
These scripts are distributed under the CeCILL licence.
