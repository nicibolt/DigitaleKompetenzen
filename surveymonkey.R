require(lubridate)
require(tidyverse)

#' Loads surveymonkey generated csv files that contain 2 line headers
#'
#' @param filename Character of the file location.
#'
#' @return raw data with a single header
#' @export
#'
#' @examples
load_surveymonkey_csv <- function(filename) {
  suppressWarnings(
    header <- read_csv(filename, n_max = 1))
  suppressWarnings(
    raw <- read_csv(filename, skip = 1)
  )
  col_names <- paste(names(header), names(raw))
  names(raw) <- col_names
  
  remove_nbsp <- function(text){
    gsub("\u00A0", " ", text, fixed = TRUE)
  }
  raw <- raw %>% mutate_if(is.character,remove_nbsp)
  
  raw
}


#' Rename all variables by a character vector, but keep unnamed variables the same
#'
#' @param df The dataframe to rename
#' @param columnvector A vector of names 
#'
#' @return A dataframe with renames columns
#' @export
#'
#' @examples
name_variables <- function(df, columnvector) {
  #oldnames <- names(df)
  l <- length(columnvector)
  names(df)[1:l] <- columnvector
  df
}



#' Add a survey response duration to surveymonkey data-frames.
#' Dataframes must contain a date_created and date_modified column.
#'
#' @param df Surveymonkey dataframe
#'
#' @return A dataframe with new column for survey duration
#' @export
#'
#' @examples
add_survey_response_duration <- function(df){
  if (!"date_created" %in% names(df)) {
    stop("Error: Dataframe must contain a column named `date_created`", call. = F)  
  }
  if (!"date_modified" %in% names(df)) {
    stop("Error: Dataframe must contain a column named `date_modified`", call. = F)  
  }
  
  
  df %>% mutate(
    newcreate   = str_replace_all(date_created, pattern = "/", replacement = "-"),
    newmodified = str_replace_all(date_modified, pattern = "/", replacement = "-")) %>%  
    mutate(createdate   = mdy_hms(newcreate),
           modifieddate = mdy_hms(newmodified)) %>% 
    mutate(survey_duration = difftime(modifieddate, createdate, units = "secs"))
}



generate_codebook <- function(df, filename) {
  text <- names(df)
  variable <- paste0("VAR",1:dim(df)[2])
  codebook <- tibble(variable, text)
  write_delim(codebook, filename, delim = ";")
  
}

read_codebook <- function(filename){
  read_delim(filename, delim = ";")
}


