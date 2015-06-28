# ----------------------------------------------------------------------------- #
# OneSex
# ----------------------------------------------------------------------------- #
#require(devtools)
#devtools::install_github("seacode/gmacs", subdir = "/gmr", ref = "develop")
require(gmr)

.MODELDIR = c("")
.THEME    = theme_bw(base_size = 12, base_family = "")
.OVERLAY  = TRUE
.SEX      = c("Aggregate","Male","Female")
.FLEET    = c("Pot","Trawl bycatch","NMFS Trawl","BSFRF")
.TYPE     = c("Retained & Discarded","Retained","Discarded")
.SHELL    = c("Aggregate","New Shell","Old Shell")
.MATURITY = c("Aggregate","Immature","Mature")
.SEAS     = c("Annual")
.FIGS     = c("figure/")

fn       <- paste0(.MODELDIR, "gmacs")
M        <- lapply(fn, read_admb)
names(M) <- "OneSex"

ww <- 6
hh <- 5

priors <- table_priors(M)
write.table(priors, file = paste0(.FIGS, "prior.csv"), sep = ",", row.names = FALSE)

likes <- table_likelihoods(M)
write.table(likes, file = paste0(.FIGS, "likelihood.csv"), sep = ",", row.names = FALSE)

pen <- table_penalties(M)
write.table(pen, file = paste0(.FIGS, "penalties.csv"), sep = ",", row.names = FALSE)

plot_catch(M)
ggsave(paste0(.FIGS, "catch.png"), width = ww*1.2, height = hh*1.2)
dev.off()

plot_cpue(M)
ggsave(paste0(.FIGS, "cpue.png"), width = ww*2.5, height = hh)
dev.off()

plot_cpue(M, "BSFRF")
ggsave(paste0(.FIGS, "cpue_BSFRF.png"), width = ww, height = hh)
dev.off()

plot_cpue(M, "NMFS Trawl")
ggsave(paste0(.FIGS, "cpue_NMFS.png"), width = ww*2.5, height = hh)
dev.off()

plot_natural_mortality(M, plt_knots = TRUE, knots = c(1976, 1980, 1985, 1994))
ggsave(paste0(.FIGS, "M_t.png"), width = ww, height = hh)
dev.off()

plot_ssb(M)
ggsave(paste0(.FIGS, "mmb.png"), width = ww, height = hh)
dev.off()

plot_recruitment(M)
ggsave(paste0(.FIGS, "recruitment.png"), width = ww, height = hh)
dev.off()

plot_selectivity(M)
ggsave(paste0(.FIGS, "selectivity.png"), width = ww*1.5, height = hh*1.5)
dev.off()

plot_growth_transition(M)
ggsave(paste0(.FIGS, "growth_transition.png"), width = ww*1.5, height = hh*1.5)
dev.off()

plot_molt_prob(M)
ggsave(paste0(.FIGS, "molt_prob.png"), width = ww*1.5, height = hh*1.5)
dev.off()

plot_size_transition(M)
ggsave(paste0(.FIGS, "size_transition.png"), width = ww*1.5, height = hh*1.5)
dev.off()

plot_growth_inc(M)
ggsave(paste0(.FIGS, "gi.png"), width = ww, height = hh)
dev.off()

plot_length_weight(M)
ggsave(paste0(.FIGS, "length_weight.png"), width = ww, height = hh)
dev.off()

plot_numbers(M)
ggsave(paste0(.FIGS, "numbers.png"), width = ww*2, height = hh*1.5)
dev.off()

plot_numbers(M, subsetby = c("1975","2014"))
ggsave(paste0(.FIGS, "numbers.png"), width = ww*1.2, height = hh)
dev.off()

plot_size_comps(M, 1)
ggsave(paste0(.FIGS, "lf_1.png"), width = ww*2, height = hh*1.5)
dev.off()

plot_size_comps(M, 2)
ggsave(paste0(.FIGS, "lf_2.png"), width = ww*2, height = hh*1.5)
dev.off()

plot_size_comps(M, 3)
ggsave(paste0(.FIGS, "lf_3.png"), width = ww*2, height = hh*1.5)
dev.off()

plot_size_comps(M, 4)
ggsave(paste0(.FIGS, "lf_4.png"), width = ww*2, height = hh*1.5)
dev.off()

plot_size_comps(M, 5)
ggsave(paste0(.FIGS, "lf_5.png"), width = ww*2, height = hh*1.5)
dev.off()

plot_size_comps(M, 6)
ggsave(paste0(.FIGS, "lf_6.png"), width = ww*2, height = hh*1.5)
dev.off()
