#GGplot code for the group 

library(tidyverse)
library(haven)

#loading dataset

here::here()

dataset <- read_dta("data/data_raw/qog_bas_ts_jan22.dta")

View(dataset)

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
plot1 <- ggplot(ggdata, aes(x = ipu_l_sw))+
  geom_boxplot()+ 
  labs(title = "Share of Women (Lower and Single Houses)", 
                      subtitle = "Rwanda has the highest share with 56.3", 
                      caption = "THE QOG BASIC DATASET 2022", 
                      x = "share of women in percentage", 
  )

plot2 <- ggplot(ggdata, aes(x = arda_isgenpct, y = fh_ipolity2))+
  geom_smooth()+
  geom_point()+
  labs(title = "Relationship Islam and Democracy", 
       subtitle = "Negative relationship of Islam and Democracy", 
       caption = "THE QOG BASIC DATASET 2022", 
       x = "Islam",
       y = "Level of Democracy"
  )

#Comment for the end of the document: In the graphics aswell as in the regression we see that having Islam as State religion it has a negative influence on the womens' share in parliament and the democracy index. 
#In the regression we controlled for additional variables. Even though the data is one sided we would need to consider more variables that could have on womens' share and democracy index next to Islam.
#With this data alone we cannot conclude that Islam is the only nor the biggest factor that has influence on the above mentioned points. 

print(plot2)

