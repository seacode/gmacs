# k palof
# 04-09-2019 
# user created functions for smbkc projections

f_sum <- function(data, col1, col2, div){
  col1 = enquo(col1)
  col2 = enquo(col2)
  div = enquo(div)
  
  data %>% 
    dplyr::select(!!col1:!!col2) %>% 
    apply(1, sum, na.rm=T) %>% 
    as.data.frame %>% 
    bind_cols(data) %>% 
    transmute(temp = . / !!div * 100) %>% 
    .$temp
}  


f_test <- function(x){
  as.numeric(x > 100)
}


# function to output .csv and .png ------------------------

write_rec_prob <- function(n_prob_yr, model, version) {
  TheD <- read.table(paste0("./projections/", model, "/", version, "/mcoutProj.rep"))[,-c(4,5,6,7,8)]
  
  Nyear <- length(TheD[1,])-4
  Nline <- length(TheD[,1])
  print(Nyear)
  print(Nline)
  
  # prob of recovery 
  for (Iline in 1:Nline)
    TheD[Iline,5:(4 + Nyear)] <- TheD[Iline, 5:(4 + Nyear)] / TheD[Iline, 4] * 100 
  
  
  TheD %>% 
    #mutate(ratio = f_sum(., V10, V59, V9)) %>% 
    mutate_at(vars(-V1, -V2, -V3, -V9), f_test) %>% 
    mutate(id = 1:n()) %>% 
    gather(year, value, -V1, -V2, -V3, -V9, -id) %>% 
    group_by(id) %>% 
    mutate(test = as.numeric(lead(value) + value ==2),
           year = as.numeric(as.factor(year))) %>%  #this doesn't work if you get above V99
    group_by(year, V3) %>% 
    summarise(recovery = sum(test, na.rm = TRUE) / n() * 100)  %>% 
    mutate(FishMort = ifelse(V3 == 1, "F = 0", "F = 0.18")) -> output
  #write_csv("test.csv")
  write_csv(output, paste0('./projections/', model, '/', version, '/rec_prob_out_', model, version, '.csv'))
  
  year1 <- output[1:2, ]
  year1 %>% 
    mutate(year2 = year) -> year1
  
  output %>% 
    mutate(year2 = year + 1) %>% 
    bind_rows(year1) %>% 
    filter(year2 <= Nyear) %>% 
    ggplot(aes(year2, recovery, group = V3)) + 
    geom_line() +
    geom_point(aes(group = V3, shape = FishMort), size = 2) +
    scale_shape_manual(name = "", values = c(16, 22)) +
    geom_hline(yintercept = 50, color = "red", lty = "dashed", lwd = 1.5) +
    geom_vline(xintercept = 10, color = "blue", lty = 2, lwd = 1.5) +
    ggtitle(paste0(model, version)) +
    ylab("Probability of recovery") +
    xlab("Year") +
    ylim(0,100) +
    theme(plot.title = element_text(hjust = 0.5)) -> plotA
  ggsave(paste0('./projections/figures/', model, '_', version, '_rec_prob.png'), plotA, dpi = 800,
         width = 7.5, height = 3.75)
  
}

