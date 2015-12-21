# ----------------------------------------------------------------------------- #
# OneSex
# ----------------------------------------------------------------------------- #
#require(devtools)
#devtools::install_github("seacode/gmacs", subdir = "/gmr", ref = "develop")
require(gmr)
#setwd()

#.MODELDIR = c("/Users/Jim/_mymods/seacode/gmacs/examples/smbbc/")
.MODELDIR = c("")
.THEME    = theme_bw(base_size = 12, base_family = "")
.OVERLAY  = TRUE
.SEX      = c("Aggregate","Male")
.FLEET    = c("Pot","Trawl bycatch","Fixed bycatch","NMFS Trawl","ADFG Pot")
.TYPE     = c("Retained & Discarded","Retained","Discarded")
.SHELL    = c("Aggregate")
.MATURITY = c("Aggregate")
.SEAS     = c("Annual")
.FIGS     = c("figure/")

fn       <- paste0(.MODELDIR, "gmacs")
M        <- lapply(fn, read_admb)
names(M) <- "OneSex"

ww <- 6
hh <- 5

png(paste0(.FIGS, "data.png"), width = ww*2, height = ww, units = "in", res = 300)
plot_datarange(M)
dev.off()

priors <- table_priors(M)
write.table(priors, file = paste0(.FIGS, "prior.csv"), sep = ",", row.names = FALSE)

likes <- table_likelihoods(M)
write.table(likes, file = paste0(.FIGS, "likelihood.csv"), sep = ",", row.names = FALSE)

pen <- table_penalties(M)
write.table(pen, file = paste0(.FIGS, "penalties.csv"), sep = ",", row.names = FALSE)

plot_recruitment_size(M)
ggsave(paste0(.FIGS, "rec_size.png"), width = ww*2.5, height = hh*1.5)
dev.off()

plot_catch(M)
ggsave(paste0(.FIGS, "catch.png"), width = ww*2.5, height = hh)
dev.off()

plot_cpue(M, ShowEstErr=TRUE)
ggsave(paste0(.FIGS, "cpue.png"), width = ww*2.5, height = hh)
dev.off()

plot_cpue(M, "ADFG Pot", ShowEstErr=TRUE)
ggsave(paste0(.FIGS, "cpue_BSFRF.png"), width = ww, height = hh)
dev.off()

plot_cpue(M, "NMFS Trawl", ShowEstErr=TRUE)
ggsave(paste0(.FIGS, "cpue_NMFS.png"), width = ww*2.5, height = hh)
dev.off()

plot_natural_mortality(M, plt_knots = TRUE, knots = c(1976, 1980, 1985, 1994))
ggsave(paste0(.FIGS, "M_t.png"), width = ww, height = hh)
dev.off()

plot_ssb(M)
ggsave(paste0(.FIGS, "ssb.png"), width = ww, height = hh)
dev.off()

plot_recruitment(M)
ggsave(paste0(.FIGS, "recruitment.png"), width = ww, height = hh)
dev.off()

plot_selectivity(M)
ggsave(paste0(.FIGS, "selectivity.png"), width = ww*1.5, height = hh*1.5)
dev.off()

# plot_growth_transition(M)
# ggsave(paste0(.FIGS, "growth_transition.png"), width = ww*1.5, height = hh*1.5)
# dev.off()
# 
# plot_molt_prob(M)
# ggsave(paste0(.FIGS, "molt_prob.png"), width = ww*1.5, height = hh*1.5)
# dev.off()
# 
# plot_size_transition(M)
# ggsave(paste0(.FIGS, "size_transition.png"), width = ww*1.5, height = hh*1.5)
# # dev.off()
# 
# plot_growth_inc(M)
# ggsave(paste0(.FIGS, "gi.png"), width = ww, height = hh)
# dev.off()
# 
# plot_length_weight(M)
# ggsave(paste0(.FIGS, "length_weight.png"), width = ww, height = hh)
# dev.off()
# 
plot_numbers(M)
ggsave(paste0(.FIGS, "numbers.png"), width = ww*2, height = hh*1.5)
dev.off()
# 
# plot_numbers(M, subsetby = c("1975","2014"))
# ggsave(paste0(.FIGS, "numbers.png"), width = ww*1.2, height = hh)
# dev.off()
# 
plot_size_comps(M, 1)
ggsave(paste0(.FIGS, "lf_1.png"), width = ww*2, height = hh*1.5)
dev.off()
 
plot_size_comps(M, 2)
ggsave(paste0(.FIGS, "lf_2.png"), width = ww*2, height = hh*1.5)
dev.off()
 
plot_size_comps(M, 3)
ggsave(paste0(.FIGS, "lf_3.png"), width = ww*2, height = hh*1.5)
dev.off()
 
# plot_size_comps(M, 4)
# ggsave(paste0(.FIGS, "lf_4.png"), width = ww*2, height = hh*1.5)
# dev.off()
# 
# plot_size_comps(M, 5)
# ggsave(paste0(.FIGS, "lf_5.png"), width = ww*2, height = hh*1.5)
# dev.off()
# 
# plot_size_comps(M, 6)
# ggsave(paste0(.FIGS, "lf_6.png"), width = ww*2, height = hh*1.5)
# # # dev.off()
