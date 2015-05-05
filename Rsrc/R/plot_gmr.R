#' Do all gmr plots
#'
#' @param M a list object created by read_admb function
#' @param plot_res plot residuals only (default = FALSE)
#' @return All gmr plots.
#' @author DN Webber
#' @export
plot_gmr(M, plot_res = FALSE)
{
    plot_catch(M, plot_res)
}
