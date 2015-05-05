#' Do all gmr plots
#'
#' @param M a list object created by read_admb function
#' @param plot_res plot residuals only (default = FALSE)
#' @param gmr_options the default plotting options
#' @return All gmr plots.
#' @author DN Webber
#' @export
plot_gmr <- function(M, plot_res = FALSE, target_dir = "", gmr_options = .gmr_options)
{
    p <- plot_catch(M, plot_res)
    fn <- paste0(target_dir, "/", "catch.png")
    ggsave(fn, width = 3*gmr_options$plot_size[1], height = 10+gmr_options$plot_size[2], bg = "white", units = "mm")
    #plot_type(fn, width = 2*gmr_options$plot_size[1], height = 10+gmr_options$plot_size[2], gmr_options)
    #print(p)
    dev.off()
}
