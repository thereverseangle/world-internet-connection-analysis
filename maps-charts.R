mapsDataCleaning <- function() {
  
  # Maps and Dataset Country name adjustment
  speed_mean_country$country[speed_mean_country$country_code == "KZ"] <<- "Kazakhstan"
  speed_mean_country$country[speed_mean_country$country_code == "US"] <<- "USA"
  speed_mean_country$country[speed_mean_country$country_code == "RU"] <<- "Russia"
  speed_mean_country$country[speed_mean_country$country_code == "KR"] <<- "South Korea"
  speed_mean_country$country[speed_mean_country$country_code == "GB"] <<- "UK"
  speed_mean_country$country[speed_mean_country$country_code == "CI"] <<- "Ivory Coast"
  speed_mean_country$country[speed_mean_country$country_code == "SY"] <<- "Syria"
  speed_mean_country$country[speed_mean_country$country_code == "IR"] <<- "Iran"
  speed_mean_country$country[speed_mean_country$country_code == "MD"] <<- "Moldova"
  
  quality_mean_country$country[quality_mean_country$country_code == "KZ"] <<- "Kazakhstan"
  quality_mean_country$country[quality_mean_country$country_code == "US"] <<- "USA"
  quality_mean_country$country[quality_mean_country$country_code == "RU"] <<- "Russia"
  quality_mean_country$country[quality_mean_country$country_code == "KR"] <<- "South Korea"
  quality_mean_country$country[quality_mean_country$country_code == "GB"] <<- "UK"
  quality_mean_country$country[quality_mean_country$country_code == "CI"] <<- "Ivory Coast"
  quality_mean_country$country[quality_mean_country$country_code == "SY"] <<- "Syria"
  quality_mean_country$country[quality_mean_country$country_code == "IR"] <<- "Iran"
  quality_mean_country$country[quality_mean_country$country_code == "MD"] <<- "Moldova"
}

produceMaps <- function() {
  
  world_data_map <- map_data('world')
  
  speed_map_dataset <<- left_join(world_data_map, speed_mean_country, by = c('region' = 'country'))
  
  # Download Speed Map
  download_speed_map <<- ggplot(data = speed_map_dataset, aes(x = long, y = lat, group = group)) +
    geom_polygon(aes(fill = m_download_kbps)) + 
    labs(title = "World Internet Connection", subtitle = "Download Speed in Kbps", caption = "Source: Ookla") + 
    scale_fill_gradient(low = "red", high = "green", guide = "colourbar") +
    theme_void()
  
  # Upload Speed Map
  upload_speed_map <<- ggplot(data = speed_map_dataset, aes(x = long, y = lat, group = group)) +
    geom_polygon(aes(fill = m_upload_kbps)) + 
    labs(title = "World Internet Connection", subtitle = "Upload Speed in Kbps", caption = "Source: Ookla") + 
    scale_fill_gradient(low = "red", high = "green", guide = "colourbar") +
    theme_void()
}

produceCharts <- function() {
 
  # Packet Loss Histogram
  packet_loss_hist <<- ggplot(data = quality_mean_country, aes(x = reorder(country, m_packet_loss), y = m_packet_loss)) +
    geom_bar(stat="identity") +
    coord_flip()
  
  # Latency Histogram
  latency_hist <<- ggplot(data = quality_mean_country, aes(x = reorder(country, m_latency), y = m_latency)) +
    geom_bar(stat="identity") +
    coord_flip()
  
  # Fastest City of Country.
  speed_city_hist <<- ggplot(data = speed_max_city, aes(x = reorder(city, m_download_kbps), y = m_download_kbps)) +
    geom_bar(stat="identity") +
    coord_flip()
  
  # Fastest ISP of Country.
  speed_isp_hist <<- ggplot(data = speed_max_isp, aes(x = reorder(isp_name, m_download_kbps), y = m_download_kbps)) +
    geom_bar(stat="identity") +
    coord_flip()
}