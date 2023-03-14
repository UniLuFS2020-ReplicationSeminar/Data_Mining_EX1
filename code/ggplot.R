#GGplot code for the group 

library(tidyverse)
library(haven)

#loading dataset

dataset <- read_dta("data/data_raw/qog_bas_cs_jan22.dta")

View(dataset)

#creating new dataset with the columns to work with

ggdata <- dataset %>% 
  select(
    cname, #Country name
    ipu_l_sw, #Share of Women (Lower and Single Houses) 
    fh_ipolity2, #Level of Democracy (Freedom House/Imputed Polity) 
    mad_gdppc, #Real GDP per Capita
  )

library(ggplot2)

#Share of Women in Boxplot
plot1 <- ggplot(ggdata, aes(x = ipu_l_sw))+
  geom_boxplot()+ 
  labs(title = "Share of Women (Lower and Single Houses)", 
                      subtitle = "Rwanda has the highest share with 61.3", 
                      caption = "THE QOG BASIC DATASET 2022", 
                      x = "share of women in percentage", 

  )

print(plot1)

