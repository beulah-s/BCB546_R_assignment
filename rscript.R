getwd()
``
genotype <- read_tsv("https://raw.githubusercontent.com/EEOB-BioData/BCB546-Spring2022/main/assignments/UNIX_Assignment/fang_et_al_genotypes.txt")
``
View(genotype)
`
snp_position<-read_tsv("https://raw.githubusercontent.com/EEOB-BioData/BCB546-Spring2022/main/assignments/UNIX_Assignment/snp_position.txt")
`
View(snp_position)
object.size(genotype)
23124584 bytes
359384 bytes
ncol(genotype)
986
ncol(snp_position)
15
By inspecting this file I learned that:
The information is arranged in 986 columns with A/T/G/C bases
File size is 2.3 MB
Maize <- filter(Genotypes, Group == "ZMMIL" | Group == "ZMMLR" | Group == "ZMMMR")
View(Maize)
Maize.cut <- select(Maize, -c(Sample_ID, JG_OTU, Group))
View(Maize.cut)
Trans.maize <- t(Maize.cut)
View(Trans.maize)
snp_position<-read_tsv("https://raw.githubusercontent.com/EEOB-BioData/BCB546-Spring2022/main/assignments/UNIX_Assignment/snp_position.txt")
snp_position.cut <- select(snp_position, SNP_ID | Chromosome | Position)
View(snp_position.cut)
snp_position.cut.sort <- snp_position.cut %>% arrange(SNP_ID)
View(snp_position.cut.sort)
Maize.join <- cbind(snp_position.cut.sort,Trans.maize)
View(Maize.join)
new_maize.join <- filter(Maize.join, Chromosome != "unknown" , Position != "unknown")
new_maize.join2 <- filter(new_maize.join, Chromosome != "multiple", Position != "multiple")
Maize.join.sort <- arrange(new_maize.join2, as.numeric(new_maize.join2$Position))
View(Maize.join.sort)
Maize.join.sort.dec <- arrange(new_maize.join2, desc(as.numeric(new_maize.join2$Position)))
View(Maize.join.sort.dec)
Chr_1 <- filter(Maize.join.sort, Chromosome == "1")
View(Chr_1)
Chr_2 <- filter(Maize.join.sort, Chromosome == "2")
View(Chr_2)
Chr_3 <- filter(Maize.join.sort, Chromosome == "3")
Chr_4 <- filter(Maize.join.sort, Chromosome == "4")
Chr_5 <- filter(Maize.join.sort, Chromosome == "5")
Chr_6 <- filter(Maize.join.sort, Chromosome == "6")
Chr_7 <- filter(Maize.join.sort, Chromosome == "7")
Chr_8 <- filter(Maize.join.sort, Chromosome == "8")
Chr_9 <- filter(Maize.join.sort, Chromosome == "9")
Chr_10 <- filter(Maize.join.sort, Chromosome == "10")
