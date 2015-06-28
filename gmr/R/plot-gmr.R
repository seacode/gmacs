#' Do all gmr plots
#'
#' @param M a list object created by read_admb function
#' @param plot_res plot residuals only (default = FALSE)
#' @param gmr_options the default plotting options
#' @return All gmr plots.
#' @author DN Webber
#' @export
#' 
plot_gmr <- function(M, plot_res = FALSE, target_dir = "", gmr_options = .gmr_options)
{
    wkey <- 20
    # Data range
    cat("Plotting data range...\n")
    fn <- paste0(target_dir, "/", "fig_dataRange")
    plot_type(fn, width = wkey+2*gmr_options$plot_size[1], height = 2*gmr_options$plot_size[2], gmr_options)
    plot_datarange(M)
    dev.off()
    # Catch
    cat("Plotting catch...\n")
    plot_catch(M, plot_res)
    fn <- paste0(target_dir, "/", "fig_Catch.png")
    ggsave(fn, width = wkey+3*gmr_options$plot_size[1], height = gmr_options$plot_size[2], bg = "white", units = "mm")
    #plot_type(fn, width = 2*gmr_options$plot_size[1], height = 10+gmr_options$plot_size[2], gmr_options)
    #print(p)
    dev.off()
    # SSB
    cat("Plotting spawning stock biomass...\n")
    plot_ssb(M)
    fn <- paste0(target_dir, "/", "fig_SSB.png")
    ggsave(fn, width = wkey+1*gmr_options$plot_size[1], height = gmr_options$plot_size[2], bg = "white", units = "mm")
    dev.off()
    # Recruitment
    cat("Plotting recruitment...\n")
    plot_recruitment(M)
    fn <- paste0(target_dir, "/", "fig_Recruits.png")
    ggsave(fn, width = wkey+1*gmr_options$plot_size[1], height = gmr_options$plot_size[2], bg = "white", units = "mm")
    dev.off()
    # CPUE
    cat("Plotting catch per unit effort...\n")
    plot_cpue(M)
    fn <- paste0(target_dir, "/", "fig_CPUE.png")
    ggsave(fn, width = wkey+2*gmr_options$plot_size[1], height = gmr_options$plot_size[2], bg = "white", units = "mm")
    dev.off()
    # Size transition
    cat("Plotting size transitions...\n")
    plot_sizeTransition(M)
    fn <- paste0(target_dir, "/", "fig_sizeTransition.png")
    ggsave(fn, width = wkey+2*gmr_options$plot_size[1], height = 2*gmr_options$plot_size[2], bg = "white", units = "mm")
    dev.off()
    # Selectivity
    cat("Plotting selectivity...\n")
    plot_selectivity(M)
    fn <- paste0(target_dir, "/", "fig_selectivity.png")
    ggsave(fn, width = wkey+2*gmr_options$plot_size[1], height = 2*gmr_options$plot_size[2], bg = "white", units = "mm")
    dev.off()
}
