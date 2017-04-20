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
.FLEET    = c("Pot","Trawl Bycatch","Bairdi fishery bycatch","Fixed_gear", "NMFS Trawl","BSFRF")
.TYPE     = c("Retained & Discarded","Retained","Discarded")
.SHELL    = c("Aggregate","New Shell","Old Shell")
.MATURITY = c("Aggregate","Immature","Mature")
.SEAS     = c("1","2","3","4")
.FIGS     = c("figure/")

fn       <- paste0(.MODELDIR, "gmacs")
M        <- lapply(fn, read_admb)
names(M) <- basename(.MODELDIR)

ww <- 6
hh <- 5

plot_selectivity(M, ncol = 4)
ggsave(paste0(.FIGS, "selectivity.png"), width = ww*2, height = hh*1.5)
dev.off()

#priors <- table_priors(M)
#write.table(priors, file = paste0(.FIGS, "prior.csv"), sep = ",", row.names = FALSE)

#likes <- table_likelihoods(M)
#write.table(likes, file = paste0(.FIGS, "likelihood.csv"), sep = ",", row.names = FALSE)

#pen <- table_penalties(M)
#write.table(pen, file = paste0(.FIGS, "penalties.csv"), sep = ",", row.names = FALSE)

plot_catch(M)
ggsave(paste0(.FIGS, "catch.png"), width = ww*1.2, height = hh*1.2)
dev.off()

plot_cpue(M, ShowEstErr = TRUE)
ggsave(paste0(.FIGS, "cpue.png"), width = ww*2.5, height = hh)
dev.off()

plot_cpue(M, "BSFRF", ShowEstErr = TRUE)
ggsave(paste0(.FIGS, "cpue_BSFRF.png"), width = ww, height = hh)
dev.off()

plot_cpue(M, "NMFS Trawl", ShowEstErr = TRUE)
ggsave(paste0(.FIGS, "cpue_NMFS.png"), width = ww*2.5, height = hh)
dev.off()

plot_natural_mortality(M)
ggsave(paste0(.FIGS, "M_t.png"), width = ww, height = hh)
dev.off()

plot_ssb(M)
ggsave(paste0(.FIGS, "ssb.png"), width = ww, height = hh)
dev.off()

plot_recruitment_size(M)
ggsave(paste0(.FIGS, "rec_size.png"), width = ww*2.5, height = hh*1.5)
dev.off()

plot_recruitment(M)
ggsave(paste0(.FIGS, "recruitment.png"), width = ww, height = hh)
dev.off()

plot_molt_prob(M)
ggsave(paste0(.FIGS, "molt_prob.png"), width = ww*1.5, height = hh*1.5)
dev.off()

#plot_size_transition(M, females = TRUE)
plot_size_transition(M)
ggsave(paste0(.FIGS, "size_transition.png"), width = ww*1.5, height = hh*1.5)
dev.off()

plot_growth_transition(M)
ggsave(paste0(.FIGS, "growth_transition.png"), width = ww*1.5, height = hh*1.5)
dev.off()

plot_growth_inc(M)
ggsave(paste0(.FIGS, "gi.png"), width = ww, height = hh)
dev.off()

plot_numbers(M, nrow = 4)
ggsave(paste0(.FIGS, "numbers_all_yrs.png"), width = ww*2, height = hh*1.5)
dev.off()

plot_numbers(M, subsetby = c("1975","1976","1977","2014","2015","2016"))
ggsave(paste0(.FIGS, "numbers.png"), width = ww*1.2, height = hh)
dev.off()

plot_numbers(M, subsetby = c("1975"))
ggsave(paste0(.FIGS, "numbers_initial.png"), width = ww*1.2, height = hh)
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

plot_size_comps(M, 7)
ggsave(paste0(.FIGS, "lf_7.png"), width = ww*2, height = hh*1.5)
dev.off()

plot_size_comps(M, 8)
ggsave(paste0(.FIGS, "lf_8.png"), width = ww*2, height = hh*1.5)
dev.off()

plot_size_comps(M, 9)
ggsave(paste0(.FIGS, "lf_9.png"), width = ww*2, height = hh*1.5)
dev.off()

plot_size_comps(M, 1, res = TRUE)
ggsave(paste0(.FIGS, "lf_1b.png"), width = ww*2, height = hh*1.5)
dev.off()

plot_size_comps(M, 2, res = TRUE)
ggsave(paste0(.FIGS, "lf_2b.png"), width = ww*2, height = hh*1.5)
dev.off()

plot_size_comps(M, 3, res = TRUE)
ggsave(paste0(.FIGS, "lf_3b.png"), width = ww*2, height = hh*1.5)
dev.off()

plot_size_comps(M, 4, res = TRUE)
ggsave(paste0(.FIGS, "lf_4b.png"), width = ww*2, height = hh*1.5)
dev.off()

plot_size_comps(M, 5, res = TRUE)
ggsave(paste0(.FIGS, "lf_5b.png"), width = ww*2, height = hh*1.5)
dev.off()

plot_size_comps(M, 6, res = TRUE)
ggsave(paste0(.FIGS, "lf_6b.png"), width = ww*2, height = hh*1.5)
dev.off()

plot_size_comps(M, 7, res = TRUE)
ggsave(paste0(.FIGS, "lf_7b.png"), width = ww*2, height = hh*1.5)
dev.off()

png(filename = paste0(.FIGS, "data_range.png"), width = ww, height = hh*1.0, units = 'in', res = 400)
plot_datarange(M)
dev.off()

#plot_length_weight(M)
#ggsave(paste0(.FIGS, "length_weight.png"), width = ww, height = hh)
#dev.off()
