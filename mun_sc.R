library(tmap)
library(maptools)
library(rgdal)
library(raster)
library(remotes)
library(rgeos)
library(sp)
library(RColorBrewer)

#importando arquivos

MUNSC = shapefile("C:/Users/bielz/Documents/Testing/aprendendomapas/42MUE250GC_SIR.shp")
class(MUNSC)

library(readr)
PIB_MUN <- read_delim("PIB_MUN.csv", ";", 
                      escape_double = FALSE, locale = locale(decimal_mark = ","), 
                      trim_ws = TRUE)
View(PIB_MUN)

#arrumando nomes e juntando as planilhas
nomes_mun <- PIB_MUN$MUN
PIB_MUN$MUN <- MUNSC$NM_MUNICIP

MAPAMUN = merge(MUNSC, PIB_MUN, by.x = "NM_MUNICIP", by.y = "MUN")
names(MAPAMUN)
head(MAPAMUN@data)

MAPAMUN$NM_MUNICIP <- nomes_mun
head(MAPAMUN@data)

# Vizualização dos dados principais
head(MAPAMUN@data)
plot(MAPAMUN)

#cor
laranjada <- brewer.pal(n = 5, name = "YlOrRd")

#escalas de cores --> style
##https://geocompr.github.io/post/2019/tmap-color-scales/##

#incrementando o mapa
tm_shape(MAPAMUN)+
  tm_polygons("PIB2017", 
              style = "fisher",
              palette = laranjada, 
              title = "PIB(mil)(2017)/Municipios(SC)")+
  tm_fill()+
  tm_legend()+
  tm_layout(fontfamily = "serif")+
  tm_borders()