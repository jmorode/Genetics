# Frequencies.r
#input: excel file with allele in only one colum by loci
#output: probabilty of two unrelated individuals to have the same gentotype
#      : print frequencies
#      : input file GenerateIndividuals_Astyanax.r
# --------------------------------------------------------------------------


#input file
df_allele <- read.csv("./Input/Genotypes_CF_Lab.csv", header = TRUE, sep=';')
df_allele$POP <- NULL
loci_names <- names(df_allele)
print(loci_names)
tot_number_events_by_loci <- nrow(df_allele)
print(tot_number_events_by_loci)
# output file for input generate individual astyanax code
outfile <- "./Input/InputGenerateIndividuals-CF_Lab.csv"
df_output <- data.frame(Locus=integer(), Allele=integer(), Frequence=double())
# initialization of proba different individuals 
proba <- 1

# loop over loci 
for (i in names(df_allele)) {
loci_alleles <- table(df_allele[[i]])

# init for proba different individuals 
term_1 <- 0 # sum freq_i^4
freqs_loci <- c()

# loop over alleles in each loci
for (j in 1:length(loci_alleles)) {
nbev_by_loci <- tot_number_events_by_loci
# for generate individual 
sallele <- strtoi(names(loci_alleles[j]))
if (sallele == 0) { 
subcount <- as.numeric(loci_alleles[j])
nbev_by_loci <- nbev_by_loci - subcount
}
else{
scount <- as.numeric(loci_alleles[j])
sfrequency <- scount / nbev_by_loci
new_row = c(i, sallele, sfrequency)
df_output[nrow(df_output)+1,] <- new_row}

# for proba different individuals 
term_1 <- term_1 + sfrequency^4 # sum freq_i^4
freqs_loci <- c(freqs_loci, sfrequency) # store frequencies
}

# compute sum sum (fifj)^2 in each loci
term_2 <- 0 
if (length(freqs_loci) > 1) { # else only one allele, term_2 = 0
for (k in 1:(length(freqs_loci)-1)) {
for (l in (k+1):length(freqs_loci)){
term_2 <- term_2 + freqs_loci[k]^2*freqs_loci[l]^2
}}}
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
