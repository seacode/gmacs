#' Specify the type of plot you would like to create
#'
#' @param filename the directory and name of the file to save
#' @param gmr_options a list of options for plotting
#' @param width the width of the plot in mm
#' @param height the height of the plot in mm
#' @return a plot device
#' @author DN Webber
#' @export
#' 
plot_type <- function(filename, width, height, gmr_options = .gmr_options)
{
    if (gmr_options$plot_type %in% c("png","PNG",".png",".PNG","Png",".Png"))
    {
        png(paste(filename, ".png", sep = ""), width = width, height = height,
            unit = "mm", res = gmr_options$plot_resolution)
    }
}
