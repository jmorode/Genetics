# Frequencies.r
#input: excel file with allele in only one colum by loci
#output: probabilty of two unrelated individuals to have the same gentotype
#      : print frequencies
#      : input file GenerateIndividuals_Astyanax.r
# --------------------------------------------------------------------------

options <- commandArgs(trailingOnly = TRUE)

if('help' %in% options | length(options) != 2){
    cat(" === Frequencies.r ====\n\
    Compute frequencies of microsatellites alleles given a table of observation\n\
    Usage: \n \
    Rscript Frequencies.r <input_file> <output_file>")
    quit()
}

#input file
inputFile <- options[1]

#output file
outfile <- options[2]

#input file
df_allele <- read.csv(inputFile, header = TRUE, sep=';')
df_allele$POP <- NULL
loci_names <- names(df_allele)
print(loci_names)
tot_number_events_by_loci <- nrow(df_allele)
print(tot_number_events_by_loci)

# output file for input generate individual astyanax code

df_output <- data.frame(Locus=integer(), Allele=integer(), Frequence=double())
# initialization of proba different individuals 
proba <- 1

# loop over loci 
for (i in names(df_allele)) {
    loci_alleles <- table(df_allele[[i]])

    # init for proba different individuals 
    term_1 <- 0 # sum freq_i^4
    freqs_loci <- c()

    loci_alleles = loci_alleles[!names(loci_alleles) == '0']
    
    # For the freq, I replaced the number of events by the sum of the table
    # because in case there is missing value in the table the frequency was 
    # calculated with these NA row included, which is wrong.
    freq = loci_alleles / sum(loci_alleles) 
    term_1 = sum(freq^4)

    for (j in names(loci_alleles)) {
        df_output <- rbind(df_output, data.frame(Locus=i, Allele=j, Frequence=freq[j]))
        freqs_loci <- c(freqs_loci, freq[j])
    }

    # compute sum sum (fifj)^2 in each loci
    term_2 <- 0 
    if (length(freqs_loci) > 1) { # else only one allele, term_2 = 0
        for (k in 1:(length(freqs_loci)-1)) {
            for (l in (k+1):length(freqs_loci)){
                term_2 <- term_2 + (as.numeric(freqs_loci[k]) * as.numeric(freqs_loci[l]))^2
            }
        }
    }

    # compute proba for each loci
    proba <- proba * (term_1 + 4*term_2)
}

# fill csv for generate individual astyanax code
df_out<-df_output[!(df_output$Frequence==1),] # remove proba equal 1 
write.csv(df_out, outfile, row.names = FALSE, quote = FALSE)

#Print frequencies
View(df_out)

# print proba different individuals 
print('Probability that two unrelated individuals would have the same genotype:')
print(proba)
