#Data Mining / Universität Luzern
#CE1
#Part 2: Some plots

#Load package "tidyverse", "haven" as well as "here"
library(tidyverse)
library(haven)
library("here")

#Get wd:
here::here()

#Import data set:
dataset <- read_dta("../data/data_raw/qog_bas_ts_jan22.dta")

#Create a new dataset with the selected data we work with
ggdata <- dataset %>% 
  select(
    cname, #Country name
    year, #Year               
    ipu_l_sw, #Share of Women (Lower and Single Houses) 
    fh_ipolity2, #Level of Democracy (Freedom House/Imputed Polity) 
    arda_isgenpct, #Islam: Total (% Adherents) 
    mad_gdppc, #Real GDP per Capita 
  )%>% 
  filter(year==2010)

#Boxplot: Share of Women in Parliament (Lower ans Single Houses)
plot_box_women <- ggplot(ggdata, aes(x = ipu_l_sw))+
  geom_boxplot(fill = 'lightblue')+ 
  labs(title = "Share of Women (Lower and Single Houses)", 
                      subtitle = "Rwanda has the highest share with 56.3", 
                      caption = "THE QOG BASIC DATASET 2022", 
                      x = "share of women in percentage", 
  )

#Plot: Regression Level of Democracy on Islam
plot_reg <- ggplot(ggdata, aes(x = arda_isgenpct, y = fh_ipolity2))+
  geom_smooth()+
  geom_point()+
  labs(title = "Relationship Islam and Democracy", 
       subtitle = "Negative relationship of Islam and Democracy", 
       caption = "THE QOG BASIC DATASET 2022", 
       x = "Islam",
       y = "Level of Democracy"
  )

#Filter data: Only countries with more than 40% share of women 
filtered_data <- ggdata %>%
  filter(ipu_l_sw > 40)

#Plot: Scatter showing countries with more than 40% women in the parliament
plot_scatter_women <-  ggplot(filtered_data, aes(x = fh_ipolity2, y = ipu_l_sw)) +
  geom_point(aes(color = cname)) +
  # geom_text(aes(label = cname), nudge_y = 0.5) +
  scale_color_discrete(name = "Country") +
  labs(title = "Share of Women % vs Level of Democracy",
       subtitle = "Filtered by Share of Women > 40%",
       x = "Level of Democracy",
       y = "Share of Women (%)")
