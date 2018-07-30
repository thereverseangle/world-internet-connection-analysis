library(readr)
library(dplyr)
library(lubridate)
library(ggplot2)
source("internet-speed-quality.R")
source("maps-charts.R")

#
# Dataset source comes from Ookla and available on Harvard Dataverse.
#
# All datasets: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/UL7NYU
# 
# City ISP Daily Speed: https://dataverse.harvard.edu/file.xhtml?persistentId=doi:10.7910/DVN/UL7NYU/93B5OW&version=1.1
# City ISP Daily Quality: https://dataverse.harvard.edu/file.xhtml?persistentId=doi:10.7910/DVN/UL7NYU/KGN6Q6&version=1.1
#

# Loading data
city_isp_daily_quality <<- read_csv("city_isp_daily_quality.csv")
city_isp_daily_speeds <<- read_csv("city_isp_daily_speeds.csv")

calculateInternetSpeedAndQuality()
mapsDataCleaning()
produceMaps()
