#Pairwise_distance_genotypes_astyanax.r
#input: excel file with allele in only two colums by loci 
#output: pairwise distance between genotypes: matrix + table counts + plot
# --------------------------------------------------------------------------


# Input file
datafile <- "./Input/DataPairwiseDiff_CF_Lab_2021.csv"

# Output file
outputfile <- "./Output/OutputPairwiseDiff_CF_Lab_2021.csv"

# Allèles et fréquences à chaque locus (individus)
matrix.indata <- read.table(datafile, sep=";")
sample_name <- matrix.indata[,1]

# Number of individuals 
nb.individus <- nrow(matrix.indata)

# Matrix differences
mat.diff = matrix(0, nrow=nb.individus, ncol=nb.individus, byrow=TRUE)

#Locus 
nb.locus = (ncol(matrix.indata)-1)/2 
locus.list <- c("Hc5","Ib1", "Vf3", "a8g5", "Xa3", "wf6", "A13e5", "Lb9", "A2A7", "vc10", "A13f8", "A6f1", "a6h6", "A14d8", "a4g11", "Wd11", "Wc12", "A5f9")

#List of the number of difference
listall <- c()

#### Loop on the individuals
for (k in 1:nb.individus)
{
for (l in 1:k)
{
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
}

else{
nb.diff.loc = 2 - length(intersect(all.loc1,all.loc2))
}
nb.diff.ind = nb.diff.ind + nb.diff.loc
}
mat.diff[k,l] = nb.diff.ind
listall <- c(listall, nb.diff.ind)

}}
rownames(mat.diff) <- sample_name
colnames(mat.diff) <- sample_name
View(mat.diff) 
write.csv(mat.diff,file=outputfile,row.names = TRUE)
#print('Table paiwise differences')
tab_listall = table(factor(listall, levels=0:(2*nb.locus))) 
# Remove zeros on the diagonal
tab_listall[1] = tab_listall[1] - nb.individus
bp <- barplot(2*tab_listall/(nb.individus*(nb.individus-1)), ylim = c(0,0.25), xlim= c(0,2*nb.locus),width=0.8, xaxt="none",  space=0)
#abline(h=0.05, col="blue")
axis(side = 2, font = 2)
axis(side = 1, at = bp, las=2, labels= seq(0,2*nb.locus,1), cex.axis=0.8, font=2)
mtext(side=1, line=2, "Number of differences", font=2,cex=1.2)
mtext(side=2, line=3, "Frequency", font=2, cex=1.2)

