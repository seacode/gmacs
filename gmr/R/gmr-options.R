#' The color-blind friendly palette with grey
#'
#' see http://www.cookbook-r.com/Graphs/Colors_%28ggplot2%29/
#' 
#' @author D'Arcy N. Webber
#' @export
#' 
.cbPalette1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")


#' The color-blind friendly palette with black
#'
#' see http://www.cookbook-r.com/Graphs/Colors_%28ggplot2%29/
#'
#' @author D'Arcy N. Webber
#' @export
#' 
.cbPalette2 <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")


#' GMR plotting options
#'
#' Parameters to be passed on to gmr plotting functions
#'
#' @param plot_type the type of plot to create (png is the only option at the mo)
#' @param plot_resolution png resolution
#' @param plot_size a vector of length 2 containing the width and height of plot (mm)
#' @param plot_cols the colour palette used for plotting (recommend the colour-blind palette cbPalette1 or cdPalette2)
#' @author D'Arcy N. Webber
#' @export
#' 
.gmr_options <- list(plot_type = "png", plot_resolution = 400,
                     plot_size = c(100,100), plot_cols = .cbPalette1,
                     thick = 2, thin = 1)
