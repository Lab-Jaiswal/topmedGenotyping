library(devtools)
library(magrittr)
library(tidyverse)
library(pgenlibr)
#devtools::install_github("Lab-Jaiswal/topmed_genotyping")
library(topmedGenotyping)

directory <- "/o/s/p/topmed/topmed_f9/genotypes/pgen_files/" #for details on the filepath, contact Maggie Maurer
rsid_fp <- read_tsv("/o/s/p/topmed/topmed_f9/genotypes/pgen_files/chip_snps_vep_annotated_rsid.tsv", col_names = FALSE)
rsids <- rsid_fp %>% pull(X5)

sequnce <- seq(1:22) %>% append(c("X"))
chr_list<- sprintf("chr%s", sequnce)  

variants_df <- get_variants(chr_list[21:22], rsids, directory) %>% filter(!is.na(index)) 

pgen_list <- get_pgen_list(chr_list[21:22], directory)

genotypes <- get_all_genotypes(variants_df, pgen_list, directory)
write_rds(geno_full, "ukbiobank_genotypes.rda")
