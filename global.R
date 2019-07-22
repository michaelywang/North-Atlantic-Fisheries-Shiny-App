# Libraries ####
library(tidyverse)
library(tidyr)
library(shiny)
library(shinydashboard)
library(leaflet)
library(DT)
library(RColorBrewer)
library(googleVis)

# CSV Database ####
fish27=read.csv("ICES_Fish_Database_Area_27")

# Gather Years for plotting ####
Gathered_Fish_Data=gather(fish27, key="year", value="catch", X2006, X2007, X2008, X2009, X2010, X2011, X2012, X2013, X2014, X2015, X2016, X2017)

#temp tester choice
choice="ES"

sorted_DF=Gathered_Fish_Data%>% filter(Country==choice) %>% filter(Species=='HER'|Species=='COD'|Species=='MAC'|Species=='SPR'|Species=='HAD'|Species=='HOM'|Species=='PIL'|Species=='PLE'|Species=='HKE'|Species=='REB'|Species=='NOP'|Species=='VMA'|Species=='WHG'|Species=='SOL'|Species=='ANE'|Species=='FLE'|Species=='ALB'|Species=='MON'|Species=='COE') %>% group_by(Country, year, Species,redlistCategory) %>% summarise(CATCHERS=sum(catch))

End_by_Weight=Gathered_Fish_Data %>% filter(redlistCategory!='Data Deficient') %>% group_by(redlistCategory) %>% summarise(sum(totalWeight))


#Endangered Species Data
Endangered_DF=Gathered_Fish_Data%>% filter(redlistCategory=="Critically Endangered" | redlistCategory=="Endangered"| redlistCategory=="Near Threatened"| redlistCategory=="Vulnerable") %>% arrange(desc(totalWeight))

Top_Endangered=Endangered_DF %>% group_by(Species, redlistCategory) %>% summarise(heavy_endangered=sum(totalWeight)) %>% top_n(20, heavy_endangered)


#Endangered Species Pie Chart
Endangered_Status_Pie_Chart=End_by_Weight %>% ggplot(aes(x="", y=`sum(totalWeight)`, fill=redlistCategory))+geom_bar(stat="identity",width=1) + coord_polar("y", start=0)+scale_fill_brewer(palette="Blues")

#Map Planning
MapDF=fish27 %>% group_by(Country) %>% summarise(Total_Catch_By_Country=sum(totalWeight))
MapDF


Top_20_Fish_by_Weight=c('HER', 'COD', 'MAC', 'SPR', 'HAD', 'HOM', 'PIL', 'PLE', 'HKE', 'REB', 'NOP', 'VMA', 'WHG', 'SOL', 'ANE', 'FLE', 'ALB', 'MON', 'COE')


