#require(devtools)
#devtools::install_github("seacode/gmacs", subdir = "/gmr", ref = "develop")
# ploting for model 1 under smbkc18a folder - using gmr and Jim's code 
require(gmr)
in_path<-"C:/gmacs/gmr/R/"
library(miceadds)
library(ggplot2)
library(dplyr)
source.all( path=in_path, grepstring="\\.R",  print.source=TRUE, file_sep="__"  )
#setwd("./smbkc_18a/model_1")

mod_names <- c("5_initcond_2")
.MODELDIR = c("./5_initcond_2/")
.THEME    = theme_bw(base_size = 12, base_family = "")
.OVERLAY  = TRUE
.SEX      = c("Aggregate","Male")
.FLEET    = c("Pot","Trawl bycatch","NMFS Trawl")
.TYPE     = c("Retained","Discarded","Discarded")
.SHELL    = c("Aggregate")
.MATURITY = c("Aggregate")
.SEAS     = c("Annual")
.FIGS     = c("./5_initcond/figure/")

fn       <- paste0(.MODELDIR, "gmacs")
M        <- lapply(fn, read_admb) #need .prj file to run gmacs and need .rep file here
names(M) <- mod_names

ww <- 6
hh <- 5

# Jim's plots -------------------------------
plot_recruitment_size(M)
ggsave(paste0(.FIGS, "rec_size.png"), width = ww*2.5, height = hh*1.5)
dev.off()

plot_catch(M)
ggsave(paste0(.FIGS, "catch.png"), width = ww*1.2, height = hh*1.2)
dev.off()

plot_cpue(M, ShowEstErr = TRUE, "NMFS Trawl", ylab = "Survey numbers")
ggsave(paste0(.FIGS, "cpue_trawl.png"), width = ww, height = hh)
dev.off()

plot_natural_mortality(M, plt_knots = FALSE)
ggsave(paste0(.FIGS, "M_t.png"), width = ww, height = hh)
dev.off()

plot_ssb(M)
ggsave(paste0(.FIGS, "ssb.png"), width = ww, height = hh)
dev.off()

plot_recruitment(M)
ggsave(paste0(.FIGS, "recruitment.png"), width = ww, height = hh)
dev.off()

plot_selectivity(M, ncol = 5) # FIX not working
ggsave(paste0(.FIGS, "selectivity.png"), width = ww*1.5, height = hh*1.5)
dev.off()

# plot_growth_transition(M)
# ggsave(paste0(.FIGS, "growth_transition.png"), width = ww*1.5, height = hh*1.5)
# dev.off()
# 
 plot_molt_prob(M)
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
# plot_numbers(M)
# ggsave(paste0(.FIGS, "numbers.png"), width = ww*2, height = hh*1.5)
# dev.off()
# 
# plot_numbers(M, subsetby = c("1975","2014"))
# ggsave(paste0(.FIGS, "numbers.png"), width = ww*1.2, height = hh)
# dev.off()
# 
 plot_size_comps(M)
 
plot_size_comps(M, 1)
ggsave(paste0(.FIGS, "lf_1.png"), width = ww*2, height = hh*1.5)
dev.off()
 
mdf <- .get_sizeComps_df(M)
dim(mdf)

par(mfcol=c(9,5),mar=c(.1,.1,.1,.1),oma=c(4,4,1,1))
len_bin<-seq(27.5,132.5,5)
years<-unique(mdf[[1]]$year)
for(x in 1:length(years))
{
 temp<-mdf[[1]][mdf[[1]]$year==years[x],]
 plot(temp$value,type='l',xaxt='n',yaxt='n',bty='n')
 lines(temp$pred,lty=2,col=2)
 legend('topleft',legend=years[x],bty='n')

}


# my plots -------------
# SSB -----------
ssb <- .get_ssb_df(M)
head(ssb)


ssb %>% 
  ggplot(aes(year, ssb)) +
    geom_line() +
    geom_ribbon(aes(x=year, ymax = ub, ymin = lb), alpha = 0.2) +
    expand_limits(y=0) +
    scale_y_continuous(expand = c(0,0)) +
    geom_hline(data = Bmsy_options, aes(yintercept = Bmsy), color = c("blue", "red"), 
               lty = c("solid", "dashed"))+
    geom_text(data = Bmsy_options, aes(x= 1980, y = Bmsy, label = label), 
              hjust = -0.45, vjust = 1.5, nudge_y = 0.05, size = 3.5) +
    ggtitle("Base model - model 1 (Model 3 2018)") +
    ylab("MMB (t)") + xlab("Year") +
    .THEME
ggsave(paste0(.FIGS, "ssb_Bmsy.png"), width = ww, height = hh)
dev.off()

# Bmsy proxy table --------
# need ssb from above
ssb %>% 
  summarise(Bmsy = mean(ssb)) %>% 
  mutate(years = "1978-2017", label = "1978-2017 B_MSY" )-> Bmsy
ssb %>% 
  filter(year >= 1996) %>% 
  summarise(Bmsy = mean (ssb)) %>% 
  mutate(years = "1996-2017", label = "1996-2017 B_MSY")->Bmsy2

Bmsy %>% 
  bind_rows(Bmsy2) %>% 
  mutate(Bmsy50 = 0.5*Bmsy) -> Bmsy_options

Bmsy_options %>% 
  mutate(reduction = (Bmsy-Bmsy[1])/ Bmsy[1])


Bmsy = M[[1]]$spr_bmsy
MMB = M[[1]]$spr_bmsy * M[[1]]$spr_depl
B_Bmsy = M[[1]]$spr_depl
Fofl = M[[1]]$sd_fofl[1] # Fofl for current year
years = as.character(M[[1]]$spr_syr)
as.character(M[[1]]$spr_nyr)



ofl_df <- data.frame(Bmsy, MMB, B_Bmsy, Fofl, years)
write_csv(ofl_df, paste0('./smbkc_18a/model_1/ofl_table_', mod_names, '.csv'))

### cpue ---------------
cpue <- .get_cpue_df(M)

## trawl survey
cpue %>% 
  filter(fleet == "NMFS Trawl") %>% 
  ggplot(aes(year, cpue)) +
  expand_limits(y = 0) +
  geom_pointrange(aes(year, cpue, ymax = ub, ymin = lb), col = "black") +
  geom_pointrange(aes(year, cpue, ymax = ube, ymin = lbe), color = "red", 
                  shape = 1, linetype = "dotted", position = position_dodge(width = 1)) +
  geom_line(aes(year, pred)) +
  labs(x = "Year", y = "CPUE") +
  .THEME

# pot survey
cpue %>% 
  filter(fleet == "ADFG Pot") %>% 
  ggplot(aes(year, cpue)) +
  expand_limits(y = 0) +
  geom_pointrange(aes(year, cpue, ymax = ub, ymin = lb), col = "black") +
  geom_pointrange(aes(year, cpue, ymax = ube, ymin = lbe), color = "red", 
                  shape = 1, linetype = "dotted", position = position_dodge(width = 1)) +
  geom_line(aes(year, pred)) +
  labs(x = "Year", y = "CPUE") +
  .THEME

# recruitment -------------
rec <- .get_recruitment_df(M)
head(rec)

#rbar is estimated in model

rec %>% 
  ggplot(aes(year, y = exp(log_rec)/1000000)) +
  geom_line() +
  geom_ribbon(aes(x=year, ymax = ub/1000000, ymin = lb/1000000), alpha = 0.25) +
  expand_limits(y=0) +
  ggtitle("Base model 2018") +
  ylab("Recruitment (millions of individuals)") + xlab("Year") +
  geom_hline(aes(yintercept = rbar[1]/1000000), color = "gray25") +
  geom_text(aes(x = 2000, y = rbar[1]/1000000, label = "R_bar"), 
            hjust = -0.45, vjust = 1.75, nudge_y = 0.05, size = 3.0) +
  .THEME +
  geom_hline(data = avgR_options, aes(yintercept = meanR), color = c("blue", "red"), 
             lty = c("solid", "dashed"))+
  geom_text(data = avgR_options, aes(x= 1980, y = meanR, label = years), 
            hjust = -1.45, vjust = 2.5, nudge_y = 0.05, size = 3.5) 
ggsave(paste0(.FIGS, "recruitment_line_with years.png"), width = ww, height = hh)
dev.off()
         

### need option with new average recruitment    

# need to pull rbar from model output with different recruitment years
rec %>% 
  summarise(meanR = mean(exp(log_rec)/1000000)) %>% 
  mutate(years = "1978-2017")-> avgR
rec %>% 
  filter(year >= 1996) %>% 
  summarise(meanR = mean (exp(log_rec)/1000000)) %>% 
  mutate(years = "1996-2017")-> avgR2

avgR %>% 
  bind_rows(avgR2) -> avgR_options
  #mutate(Bmsy50 = 0.5*Bmsy) -> Bmsy_options

# recruitment changing years ------
avgR_options # see above is calculated average recruitment for each time series

rec$rbar[1]


### OFL --------
M[[base_model_1]]$spr_cofl

