#GGplot code for the group 

library(tidyverse)
library(haven)

#loading dataset

here::here()

dataset <- read_dta("../data/data_raw/qog_bas_ts_jan22.dta")


#creating new dataset with the columns to work with

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

#Share of Women in Boxplot
plot_box_women <- ggplot(ggdata, aes(x = ipu_l_sw))+
  geom_boxplot(fill = 'lightblue')+ 
  labs(title = "Share of Women (Lower and Single Houses)", 
                      subtitle = "Rwanda has the highest share with 56.3", 
                      caption = "THE QOG BASIC DATASET 2022", 
                      x = "share of women in percentage", 
  )


#Share of Women % vs Level of Democracy
filtered_data <- ggdata %>%
  filter(ipu_l_sw > 40)

plot_point_women <-  ggplot(filtered_data, aes(x = fh_ipolity2, y = ipu_l_sw)) +
  geom_point(aes(color = cname)) +
  # geom_text(aes(label = cname), nudge_y = 0.5) +
  scale_color_discrete(name = "Country") +
  labs(title = "Share of Women % vs Level of Democracy",
       subtitle = "Filtered by Share of Women > 40%",
       x = "Level of Democracy",
       y = "Share of Women (%)")


#Islam vs Level of Democracy Regression
plot_lm <- ggplot(ggdata, aes(x = arda_isgenpct, y = fh_ipolity2))+
  geom_smooth()+
  geom_point()+
  labs(title = "Relationship Islam and Democracy", 
       subtitle = "Negative relationship of Islam and Democracy", 
       caption = "THE QOG BASIC DATASET 2022", 
       x = "Islam",
       y = "Level of Democracy"
  )
