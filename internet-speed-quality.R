calculateInternetSpeedAndQuality <- function() {
  
  #
  # Download and Upload speeds.
  #
  
  # Filter Country data for Year 2014.
  speed_country_2014 <- city_isp_daily_speeds %>% 
    filter(year(date) == 2014) %>%
    select(country, country_code, download_kbps, upload_kbps)
  
  # Filter City data for Year 2014.
  speed_city_2014 <- city_isp_daily_speeds %>% 
    filter(year(date) == 2014) %>%
    select(city, country, country_code, download_kbps, upload_kbps)
  
  # Filter ISP data for Year 2014.
  speed_isp_2014 <- city_isp_daily_speeds %>% 
    filter(year(date) == 2014) %>%
    select(isp_name, country, country_code, download_kbps, upload_kbps)
  
  # Calculating mean speed per Country.
  speed_mean_country <<- speed_country_2014 %>% 
    group_by(country, country_code) %>% 
    summarise(
      m_download_kbps = mean(download_kbps),
      m_upload_kbps = mean(upload_kbps))

  # Calculating max speed per City of Country.
  speed_max_city <<- speed_city_2014 %>% 
    group_by(country, country_code) %>% 
    summarise(
      city = max(city),
      m_download_kbps = max(download_kbps),
      m_upload_kbps = max(upload_kbps))
  
  # Calculating max speed per ISP of Country.
  speed_max_isp <<- speed_isp_2014 %>% 
    group_by(country, country_code) %>% 
    summarise(
      isp_name = max(isp_name),
      m_download_kbps = max(download_kbps),
      m_upload_kbps = max(upload_kbps))
  
  #
  # Quality of connection.
  # (Latency and Packet Loss).
  #
  
  # Filter Country data for Year 2014.
  quality_country_2014 <- city_isp_daily_quality %>% 
    filter(year(date) == 2014) %>%
    select(country, country_code, rfactor, packet_loss, latency)
  
  # Calculating mean quality per Country.
  quality_mean_country <<- quality_country_2014 %>% 
    group_by(country, country_code) %>%
    summarise(
      m_rfactor = mean(rfactor),
      m_packet_loss = mean(packet_loss),
      m_latency = mean(latency))
}