#Data Mining / Universität Luzern
#CE1
#Part 1: Some regressions

#Load package "haven" in order to import the STATA data set
library(haven)

#Load package "here"
library("here")

# Get wd:
here::here()

#Import data set:
#data_cs <- read_dta(file = here::here("data", "data_raw", "qog_bas_cs_jan22.dta"))
data_ts <- read_dta(file = here::here("data", "data_raw", "qog_bas_ts_jan22.dta"))

#Load package "tidyverse"
library(tidyverse)

#Select variables:
data_ts_2 <- data_ts %>% 
  select(
    cname, #Country name
    year, #Year               
    ipu_l_sw, #Share of Women (Lower and Single Houses) 
    fh_ipolity2, #Level of Democracy (Freedom House/Imputed Polity) 
    arda_isgenpct, #Islam: Total (% Adherents) 
    mad_gdppc, #Real GDP per Capita 
    )%>% 
  filter(year==2010)

#Summary statistics of the data sets
summary(data_ts_2)

#Run some regressions 
regression_a <- lm(ipu_l_sw ~ arda_isgenpct, data=data_ts_2)
regression_b <- lm(ipu_l_sw ~ arda_isgenpct+fh_ipolity2, data=data_ts_2)
regression_c <- lm(ipu_l_sw ~ arda_isgenpct+fh_ipolity2+mad_gdppc, data=data_ts_2)

#Show results
summary(regression_a)
summary(regression_b)
summary(regression_c)

#Load package "labelled" to generate table
library(stargazer)

#Generate a well-formatted table
stargazer(regression_a, regression_b, regression_c, 
          title="Regression on the Share of Women in Parliament (Lower and Single Houses) ", 
          dep.var.caption="", 
          dep.var.labels.include=FALSE,
          covariate.labels=c("Islam","Level of Democracy", "Real GDP per Capita"), 
          digits=2,
          keep.stat=c("rsq", "adj.rsq", "n"), 
          notes=c("Notes: Standard errors in parentheses."), 
          notes.align = "c", 
          notes.label="",
          no.space=TRUE)