# ----------------------------------------------------------------------------- #
# TwoSex
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
getwd()
print(fn)
print(.FIGS)
print(.MODELDIR)
M        <- lapply(fn, read_admb)
names(M) <- basename(.MODELDIR)

ww <- 6
hh <- 5

pdf(paste0(.FIGS, "catch.pdf"), width = ww*1.2, height = hh*1.2)
plot_catch(M)
dev.off()

pdf(paste0(.FIGS, "cpue.pdf"), width = ww*2.5, height = hh)
plot_cpue(M)
dev.off()

pdf(paste0(.FIGS, "cpue_BSFRF.pdf"), width = ww, height = hh)
plot_cpue(M, "BSFRF")
dev.off()

pdf(paste0(.FIGS, "cpue_NMFS.pdf"), width = ww*2.5, height = hh)
plot_cpue(M, "NMFS Trawl")
dev.off()

pdf(paste0(.FIGS, "M_t.pdf"), width = ww, height = hh)
plot_natural_mortality(M)
dev.off()

pdf(paste0(.FIGS, "mmb.pdf"), width = ww, height = hh)
plot_ssb(M)
dev.off()

pdf(paste0(.FIGS, "recruitment.pdf"), width = ww, height = hh)
plot_recruitment(M)
dev.off()

pdf(paste0(.FIGS, "selectivity.pdf"), width = ww*1.5, height = hh*1.5)
plot_selectivity(M)
dev.off()

pdf(paste0(.FIGS, "size_transition.pdf"), width = ww*1.5, height = hh*1.5)
plot_size_transition(M)
dev.off()

pdf(paste0(.FIGS, "growth_transition.pdf"), width = ww*1.5, height = hh*1.5)
plot_growth_transition(M)
dev.off()

pdf(paste0(.FIGS, "gi.pdf"), width = ww, height = hh)
plot_growth_inc(M)
dev.off()

pdf(paste0(.FIGS, "length_weight.pdf"), width = ww, height = hh)
plot_length_weight(M)
dev.off()

pdf(paste0(.FIGS, "numbers.pdf"), width = ww*2, height = hh*1.5)
plot_numbers(M)
dev.off()

pdf(paste0(.FIGS, "numbers.pdf"), width = ww*1.2, height = hh)
plot_numbers(M, subsetby = c("1975","2014"))
dev.off()

pdf(paste0(.FIGS, "lf_1.pdf"), width = ww*2, height = hh*1.5)
plot_size_comps(M, 1)
dev.off()

pdf(paste0(.FIGS, "lf_2.pdf"), width = ww*2, height = hh*1.5)
plot_size_comps(M, 2)
dev.off()

pdf(paste0(.FIGS, "lf_3.pdf"), width = ww*2, height = hh*1.5)
plot_size_comps(M, 3)
dev.off()

pdf(paste0(.FIGS, "lf_4.pdf"), width = ww*2, height = hh*1.5)
plot_size_comps(M, 4)
dev.off()

pdf(paste0(.FIGS, "lf_5.pdf"), width = ww*2, height = hh*1.5)
plot_size_comps(M, 5)
dev.off()

pdf(paste0(.FIGS, "lf_6.pdf"), width = ww*2, height = hh*1.5)
plot_size_comps(M, 6)
dev.off()
