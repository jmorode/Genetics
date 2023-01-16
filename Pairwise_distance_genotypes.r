#Pairwise_distance_genotypes.r
#input: excel file with allele in only two colums by loci 
#output: pairwise distance between genotypes: matrix + table counts + plot
# --------------------------------------------------------------------------

options <- commandArgs(trailingOnly = TRUE)

if('help' %in% options | length(options) != 2){
    cat(" === Pairwise_distance_genotypes.r ====\n\
    Compute frequencies of microsatellites alleles given a table of observation\n\
    Usage: \n \
    Rscript Pairwise_distance_genotypes.r <input_file> <output_file>")
    quit()
}

# Input file
inputFile <- options[1]

# Output file
outputfile <- options[2]

# Allèles et fréquences à chaque locus (individus)
matrix.indata <- read.table(inputFile, sep=";", header=TRUE, row.names=1)
sample_name <- rownames(matrix.indata)

# Number of individuals 
nb.individus <- nrow(matrix.indata)

# Matrix differences
mat.diff = matrix(0, nrow=nb.individus, ncol=nb.individus, byrow=TRUE)

#Locus 
locus.list <- colnames(matrix.indata)[seq(1,ncol(matrix.indata),2)]
nb.locus = length(locus.list)

#List of the number of difference
listall <- c()

#### Loop on the individuals
for (k in 1:nb.individus){
    for (l in 1:k){
        ## Calculate nb diff 
        nb.diff.ind = 0
        mat.ind = matrix(0, nrow=4, ncol=nb.locus, byrow=TRUE)
        rownames(mat.ind) <- c("Ind1_all-1","Ind1_all-2","Ind2_all-1","Ind2_all-2")
        colnames(mat.ind) <- locus.list

        for(i in seq(2,2*nb.locus,2)){
            all.loc1 = c(matrix.indata[k,i],matrix.indata[k,i+1]) #liste ind 1
            all.loc2 = c(matrix.indata[l,i],matrix.indata[l,i+1] )#liste ind 2

            if(length(unique(c(all.loc1,all.loc2))) == 1){
                nb.diff.loc = 0
            }else{
                nb.diff.loc = 2 - length(intersect(all.loc1,all.loc2))
            }

            nb.diff.ind = nb.diff.ind + nb.diff.loc
        }
        
        mat.diff[k,l] = nb.diff.ind
        listall <- c(listall, nb.diff.ind)

    }
}

rownames(mat.diff) <- sample_name
colnames(mat.diff) <- sample_name
#View(mat.diff)  #Commented this line because when running the script, the window is closing immediately
write.csv(mat.diff,file=outputfile,row.names = TRUE)

##print('Table paiwise differences')
tab_listall = table(factor(listall, levels=0:(2*nb.locus))) 
## Remove zeros on the diagonal
tab_listall[1] = tab_listall[1] - nb.individus
bpdata = 2*tab_listall/(nb.individus*(nb.individus-1))
pdf('barplot_pairwise_distance.pdf')
bp <- barplot(bpdata, ylim = c(0,max(bpdata)), xlim= c(0,2*nb.locus),width=0.8, xaxt="none",  space=0)
##abline(h=0.05, col="blue")
axis(side = 2, font = 2)
axis(side = 1, at = bp, las=2, labels= seq(0,2*nb.locus,1), cex.axis=0.8, font=2)
mtext(side=1, line=2, "Number of differences", font=2,cex=1.2)
mtext(side=2, line=3, "Frequency", font=2, cex=1.2)
dev.off()

