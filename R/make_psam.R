#' Make a psam
#'
#' @param chromosome chromosome labeled as "chrNumber" (ex: "chr1")
#' @param directory directory containing the files
#' @return a psam
#' @export
make_psam <- function(chromosome, directory){
  directory_list <- list.files(directory, pattern = ".psam", full.names = TRUE) 
  psam_selected <- directory_list[1]
  psam <- read_tsv(psam_selected)
}