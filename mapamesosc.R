library(tmap)
library(maptools)
library(rgdal)
library(raster)
library(remotes)
library(rgeos)
library(sp)
library(RColorBrewer)

#carregando arquivo

MAPASC = shapefile("C:/Users/bielz/Documents/Testing/aprendendomapas/42MEE250GC_SIR.shp")

class(MAPASC)

summary(MAPASC)

# Corrigindo os dados do código IBGE das mesorregiões
MAPASC$CD_GEOCME=substr(MAPASC$CD_GEOCME,1,6)

# Vizualização dos dados principais
head(MAPASC@data)

plot(MAPASC)

#FILTRANDO UNIDADE ESCOLHIDA (OPICIONAL)
plot(MAPASC[MAPASC$NM_MESO =='SUL CATARINENSE',], 
     axes="TRUE",  
     main="Mapa da mesorregião Sul de Santa Catarina - SC",
     border=gray(0.5), 
     lwd=.5)


#ajustes
nomes <- c("Grande Florianópolis", "Norte", "Oeste", "Serrana", "Sul", "Vale do Itajaí")
MAPASC$NM_MESO <- nomes
MAPASC$NM_MESO


coral <- brewer.pal(n = 6, name = "RdBu")

#incrementando o mapa
tm_shape(MAPASC)+
  tm_polygons()+
    tm_shape(MAPASC[1,])+
      tm_polygons(col= coral[1])+
      tm_text('NM_MESO', size = 0.7)+
  tm_shape(MAPASC[2,])+
      tm_polygons(col= coral[2])+
      tm_text('NM_MESO', size = 0.7)+
    tm_shape(MAPASC[3,])+
      tm_polygons(col=coral[3])+
      tm_text('NM_MESO', size = 0.7)+
    tm_shape(MAPASC[4,])+
      tm_polygons(col= coral[4])+
      tm_text('NM_MESO', size = 0.7)+
    tm_shape(MAPASC[5,])+
      tm_polygons(col=coral[5])+
      tm_text('NM_MESO', size = 0.7)+
    tm_shape(MAPASC[6,])+
      tm_polygons(col= coral[6])+
      tm_text('NM_MESO', size = 0.7)+
  tm_fill()+
  tm_compass(type = '4star', position = c("left", "bottom"))+
  tm_scale_bar(position = c("left", "bottom"))+
  tm_layout(main.title = "Mesorregiões de Santa Catarina", 
            main.title.position = "center",
            fontfamily ="serif")+
  tm_borders()


