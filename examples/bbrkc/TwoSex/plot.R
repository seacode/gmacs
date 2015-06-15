# ----------------------------------------------------------------------------- #
# TwoSex
# ----------------------------------------------------------------------------- #
require(devtools)
devtools::install_github("seacode/gmacs", subdir = "/gmr", ref = "develop")
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
names(M) <- basename(.MODELDIR)

ww <- 6
hh <- 5

plot_catch(M)
ggsave(paste0(.FIGS, "catch.png"), width = ww*1.2, height = hh*1.2)

plot_cpue(M)
ggsave(paste0(.FIGS, "cpue.png"), width = ww*2.5, height = hh)

plot_natural_mortality(M)
ggsave(paste0(.FIGS, "M_t.png"), width = ww, height = hh)

plot_ssb(M)
ggsave(paste0(.FIGS, "mmb.png"), width = ww, height = hh)

plot_recruitment(M)
ggsave(paste0(.FIGS, "recruitment.png"), width = ww, height = hh)

plot_selectivity(M)
ggsave(paste0(.FIGS, "selectivity.png"), width = ww*1.5, height = hh*1.5)

plot_size_transition(M)
ggsave(paste0(.FIGS, "size_transition.png"), width = ww*1.5, height = hh*1.5)

plot_growth_inc(M)
ggsave(paste0(.FIGS, "gi.png"), width = ww, height = hh)

plot_length_weight(M)
ggsave(paste0(.FIGS, "length_weight.png"), width = ww, height = hh)

plot_numbers(M)
ggsave(paste0(.FIGS, "numbers.png"), width = ww*2, height = hh*1.5)


plot_datarange(M)
plot_size_comps(M, 1)
plot_size_comps(M, 2)
plot_size_comps(M, 3)
plot_size_comps(M, 4)
plot_size_comps(M, 5)
plot_size_comps(M, 6)
plot_size_comps(M, 7)
plot_size_comps(M, 8)
plot_size_comps(M, 9)
plot_size_comps(M, 10)
plot_numbers(M, subsetby = c("1975","2014"))
