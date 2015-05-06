#' Set plotting theme for ggplot2 via gmr
#'
#' Gives user control over plot theme by running ggplot2 functions 
#' that do the same. This allows a user to set the theme without 
#' independently loading the ggplot2 package.
#'
#' @param name of desired theme
#' @return Sets ggplot2 theme for current working session
#' @export
set_ggtheme <- function(theme){
  switch(theme,
          bw      = ggtheme <<- theme_bw(),
          gray    = ggtheme <<- theme_gray(),
          classic = ggtheme <<- theme_classic(),
          minimal = ggtheme <<- theme_minimal()
  )
  message("The ggplot theme has been set to ", theme, " for this working session")
}