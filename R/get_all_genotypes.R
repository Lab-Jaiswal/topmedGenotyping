#' Make a geno_full
#' 
#' @param variants_df dataframe containing all of the variants in the directory, created with get_directory_variants 
#' @param directory
#' @keywords get all genotypes
#' @export
#' @examples
#' @export
#' get_genotypes_from_pgen()

get_all_genotypes <- function(variants_df, directory){
  variants_df_auto <- filter(variants_df, chromosome != "chrX")
  variants_df_x <- filter(variants_df, chromosome == "chrX")
  
  chromosome <- variants_df$chromosome[1]
  psam <- make_psam(chromosome, directory)
  
  if (nrow(variants_df_auto) > 0){
    geno_auto <- get_genotypes(variants_df_auto, directory, psam)
  } else {
    geno_auto <- as.data.frame(matrix(ncol = 0, nrow = 0))
  }
  if (nrow(variants_df_x) > 0) {
    psam_x <- make_psam("chrX", directory)
    geno_x <- get_genotypes(variants_df_x, directory, psam = psam_x)
  } else {
    geno_x <- as.data.frame(matrix(ncol = 0, nrow = 0))
  }
  
  if (nrow(geno_auto) > 0 & nrow(geno_x) > 0){
    geno_full <- left_join(geno_auto, geno_x)
  } else if (nrow(geno_auto) > 0) {
    geno_full <- geno_auto
  } else {
    geno_full <- geno_x
  }
  geno_full         
}
