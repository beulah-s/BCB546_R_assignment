View(Fang)
Zmaize <- filter(Fang, Group == "ZMMIL" | Group == "ZMMLR" | Group == "ZMMMR")
View(Zmaize)
Zmaize.cut <- select(Zmaize, -c(Sample_ID, JG_OTU, Group))
View(Zmaize.cut)
Trans.zmaize <- t(Zmaize.cut)
View(Trans.zmaize)
snpfile<-read_tsv("https://raw.githubusercontent.com/EEOB-BioData/BCB546-Spring2022/main/assignments/UNIX_Assignment/snp_position.txt")
snpfile.cut <- select(snpfile, SNP_ID | Chromosome | Position)
View(snpfile.cut)
Zmaize.join <- cbind(snpfile.cut,Trans.zmaize)
View(Zmaize.join)
#teosinte
Tmaize <- filter(Fang, Group == "ZMPBA" | Group == "ZMPIL" | Group == "ZMPJA")
View(Tmaize)
Tmaize.cut <- select(Tmaize, -c(Sample_ID, JG_OTU, Group))
View(Tmaize.cut)
Trans.tmaize <- t(Tmaize.cut)
View(Trans.tmaize)
Tmaize.join <- cbind(snpfile.cut, Trans.tmaize)
View(Tmaize.join)
Tmaize.join_1 <- filter(Tmaize.join, Chromosome != "unknown" , Position != "unknown")
Tmaize.join_2 <- filter(Tmaize.join_1, Chromosome != "multiple", Position != "multiple")
Tmaize.join.sort <- arrange(Tmaize.join_2, as.numeric(Tmaize.join_2$Position))
View(Tmaize.join.sort)
# decreasing order
Tmaize.join.sort.dec <- arrange(Tmaize.join_2, desc(as.numeric(Tmaize.join_2$Position)))
View(Tmaize.join.sort.dec)
Tmaize.join.sort.dec.dash <- data.frame(lapply(Tmaize.join.sort.dec, gsub, pattern = "[?]", replacement = "-"))
View(Tmaize.join.sort.dec.dash)
# Zmaize
Zmaize.join_1 <- filter(Zmaize.join, Chromosome != "unknown" , Position != "unknown")
Zmaize.join_2 <- filter(Zmaize.join_1, Chromosome != "multiple", Position != "multiple")
Zmaize.join.sort <- arrange(Zmaize.join_2, as.numeric(Zmaize.join_2$Position))
View(Zmaize.join.sort)
Zmaize.join.sort.dec <- arrange(Zmaize.join_2, desc(as.numeric(Zmaize.join_2$Position)))
Zmaize.join.sort.dec.dash <- data.frame(lapply(Zmaize.join.sort.dec, gsub, pattern = "[?]", replacement = "-"))
View(Zmaize.join.sort.dec.dash)
Zmaize_long <- Zmaize.join.sort.dec.dash %>% pivot_longer(!Chromosome, names_to = "Position", values_to= "BP", )%>%  {.} 
View(Zmaize_long)
Zmaize_long$Chromosome = as.numeric(as.character(Zmaize_long$Chromosome))
mutate(Zmaize_long, Zmaize_long$Species <- ("Maize"))
View(Zmaize_long)
Zmaize_long_species <- mutate(Zmaize_long, Zmaize_long$Species <- ("Maize")) 
View(Zmaize_long_species)
Tmaize_long <- Tmaize.join.sort.dec.dash %>% pivot_longer(!Chromosome, names_to = "Position", values_to= "BP", )%>%  {.}
View(Tmaize_long)
Tmaize_long$Chromosome = as.numeric(as.character(Tmaize_long$Chromosome))
Tmaize_long_species <- mutate(Tmaize_long, Tmaize_long$Species <- ("Teosinte"))
View(Tmaize_long_species)
Zmaize_long%>% 
  +     select(Chromosome, Position) %>%
  +     mutate(
    +         Species = "Maize"
    +         
      +     )%>% {.} -> Zmaize_species
View(Zmaize_species)
Tmaize_long%>% 
  +     select(Chromosome, Position) %>%
  +     mutate(
    +         Species = "Teosinte"
    +         
      +     )%>% {.} -> Tmaize_species
View(Tmaize_species)
View(Tmaize_species)
snp_chromosome <- bind_rows(Zmaize_species, Tmaize_species)
View(snp_chromosome)
ggplot(snp_chromosome, aes(x=Chromosome, fill= Species, color= Species)) + geom_bar(bins=10, position = "dodge")
Warning message:
  Ignoring unknown parameters: bins 