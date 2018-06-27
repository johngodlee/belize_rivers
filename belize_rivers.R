# Belize watersheds that were used for trade down to the coast.
# John Godlee (johngodlee@gmail.com)
# 2018_06_07

# Remove old crap
rm(list=ls())

# Packages ----
library(rgdal)
library(raster)

# Set working directory to the location of the source file ----
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Add shapefiles ----
belize <- readOGR(dsn = "BLZ_adm", layer = "BLZ_adm0")

rivers_1 <- readOGR(dsn = "camerica", layer = "carivs")
rivers_2 <- readOGR(dsn = "Belize_Rivers 2", layer = "Belize_Rivers")
rivers_2_first_belize <- readOGR(dsn = "belize_rivers_2_first_crop", layer = "belizer_rivers_2_first_crop")
rivers_2_second_belize <- readOGR(dsn = "belize_rivers_2_second_crop", layer = "belizer_rivers_2_second_crop")

watersheds <- readOGR(dsn = "Belize_Watersheds", layer = "Belize_Watersheds")

rivers_2_wgs84 <- spTransform(rivers_2, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")) 

# rivers_1 ---- 

## Filter out rivers not in Belize
rivers_1_belize <- crop(rivers_1, belize)

svg(filename = "img/svg/rivers_1_belize.svg", width = 15, height = 20, onefile = TRUE)
plot(rivers_1_belize)
plot(belize, add = TRUE)
dev.off()

## Filter out small rivers according to bank full width
rivers_1_big <- rivers_1_belize[rivers_1_belize$a_WIDTH > quantile(rivers_1_belize$a_WIDTH, 0.50), ]

svg(filename = "img/svg/rivers_1_big.svg", width = 15, height = 20, onefile = TRUE)
plot(rivers_1_big)
plot(belize, add = TRUE)
dev.off()

# rivers_2 ----

## Filter out none first order streams
# rivers_2_first <- rivers_2_wgs84[rivers_2_wgs84$Strm_order > 1, ]
# rivers_2_second <- rivers_2_wgs84[rivers_2_wgs84$Strm_order > 2, ]

## Crop to belize
# rivers_2_first_belize <- crop(rivers_2_first, belize)
# rivers_2_second_belize <- crop(rivers_2_second, belize)

# writeOGR(obj=rivers_2_first_belize, dsn="belize_rivers_2_first_crop", layer="belizer_rivers_2_first_crop", driver="ESRI Shapefile")
# writeOGR(obj=rivers_2_second_belize, dsn="belize_rivers_2_second_crop", layer="belizer_rivers_2_second_crop", driver="ESRI Shapefile")

svg(filename = "img/svg/rivers_2_wgs84.svg", width = 15, height = 20, onefile = TRUE)
plot(rivers_2_wgs84) 
plot(belize, add = TRUE)
dev.off()

svg(filename = "img/svg/rivers_2_first_belize.svg", width = 15, height = 20, onefile = TRUE)
plot(rivers_2_first_belize)
plot(belize, add = TRUE)
dev.off()

svg(filename = "img/svg/rivers_2_second_belize.svg", width = 15, height = 20, onefile = TRUE)
plot(rivers_2_second_belize)
plot(belize, add = TRUE)
dev.off()

# png outputs ----

png(filename = "img/png/rivers_1_belize.png", width = 15, height = 20, units = "in", res = 300)
plot(rivers_1_belize)
plot(belize, add = TRUE)
dev.off()

png(filename = "img/png/rivers_1_big.png", width = 15, height = 20, units = "in", res = 300)
plot(rivers_1_big)
plot(belize, add = TRUE)
dev.off()

png(filename = "img/png/rivers_2_wgs84.png", width = 15, height = 20, units = "in", res = 300)
plot(rivers_2_wgs84) 
plot(belize, add = TRUE)
dev.off()

png(filename = "img/png/rivers_2_first_belize.png", width = 15, height = 20, units = "in", res = 300)
plot(rivers_2_first_belize)
plot(belize, add = TRUE)
dev.off()

png(filename = "img/png/rivers_2_second_belize.png", width = 15, height = 20, units = "in", res = 300)
plot(rivers_2_second_belize)
plot(belize, add = TRUE)
dev.off()


